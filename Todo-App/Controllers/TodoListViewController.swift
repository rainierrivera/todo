//
//  TodoListViewController.swift
//  Todo-App
//
//  Created by Collabera on 10/26/20.
//

import ReSwift


class TodoListViewController: UIViewController {

  @IBOutlet private weak var tableView: UITableView!
  
  private var tableDataSource: TableDataSource<UITableViewCell, Todo>?
  
  private let appUserDefault = AppUserDefault.shared
  
  var todos = [Todo]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    
    tableView.tableFooterView = UIView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationItem.title = "Todos"
    
    store.dispatch(RoutingAction(destination: .todoList))
    
    store.subscribe(self) {
      $0.select {
        $0.todoListState
      }
    }
    
    if let user = appUserDefault.getCurrentUser() {
      let action = LoadToDoList(user: user)
      store.dispatch(action)
    }
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    store.unsubscribe(self)
  }
  
  //MARK: - Privates
  
  //MARK: Actions
  @IBAction private func addTodo(_ anyObject: AnyObject) {
    store.dispatch(RoutingAction(destination: .AddTodo))
  }
  
  @IBAction private func signoutButton(_ anyObject: AnyObject) {
    let alertController = AlertHelper.defaultAlert(with: "Are you sure yo want to sign out?", message: nil) { _ in
      store.dispatch(RoutingAction(destination: .pop))
    }
    present(alertController, animated: true, completion: nil)
  }

}

// MARK: Extensions

extension TodoListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    DispatchQueue.main.async {
      store.dispatch(SelectTodoAction(index: indexPath.row))
    }
  }
}

extension TodoListViewController: StoreSubscriber {
  func newState(state: TodoListState) {
    DispatchQueue.main.async {
      self.todos = state.todos.sorted(by: >)
      
      self.tableDataSource = TableDataSource(cellIdentifier:"TodoCell", models: self.todos) {cell, model in
        cell.textLabel?.text = model.name
        cell.accessoryType = model.isDone ? .checkmark : .none
        return cell
      }
      
      self.tableView.dataSource = self.tableDataSource
      self.tableView.reloadData()
    }

    if state.showTodo, let selectedTodo = state.selectedTodo {
      store.dispatch(RoutingAction(destination: .AddTodo))
      store.dispatch(LoadTodo(todo: selectedTodo))
    }
  }
}

