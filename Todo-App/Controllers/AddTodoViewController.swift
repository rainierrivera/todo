//
//  AddTodoViewController.swift
//  Todo-App
//
//  Created by Collabera on 10/27/20.
//

import ReSwift

class AddTodoViewController: UIViewController {
  
  @IBOutlet private weak var addTodoTextField: UITextField!
  @IBOutlet private weak var doneButton: UIButton!
  @IBOutlet private weak var deleteButton: UIButton!
  
  private let appUserDefault = AppUserDefault.shared
  
  var todo: Todo? {
    didSet {
      addTodoTextField.text = todo?.name
      doneButton.isHidden = false
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    store.subscribe(self) {
      $0.select {
        $0.todoState
      }
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    store.unsubscribe(self)
  }
  
  @IBAction private func doneAction(_ anyObject: AnyObject) {
  
    DispatchQueue.main.async { [weak self] in
      guard let todo = self?.todo else { return }
      store.dispatch(DoneTodoAction(todo: todo, isDone: !todo.isDone))
    }
  }
  
  @IBAction private func deleteAction(_ anyObject: AnyObject) {
  
    DispatchQueue.main.async { [weak self] in
      guard let todo = self?.todo else { return }
      store.dispatch(DeleteTodoAction(todo: todo))
    }
  }

  @IBAction private func saveAction(_ anyObject: AnyObject) {
    
    guard let user = appUserDefault.getCurrentUser(), addTodoTextField.text?.isEmpty == false else {
      return
    }
    let todo = Todo(name: addTodoTextField.text!, userId: user.username, isDone: false)
    DispatchQueue.main.async {
      if let _ = self.todo {
        store.dispatch(EditTodoAction(todo: todo))
      } else {
        store.dispatch(AddTodoAction(todo: todo))
      }
    }
  }
}

extension AddTodoViewController: StoreSubscriber {
  func newState(state: TodoState) {
    if state.addedTodo {
      DispatchQueue.main.async {
        self.navigationController?.popViewController(animated: true)
      }
    }
    
    doneButton.isHidden = state.todo == nil
    deleteButton.isHidden = state.todo == nil
    if let todo = state.todo {
      let title = todo.isDone ? "Mark as Undone" : "Mark as Done"
      self.todo = todo
      doneButton.setTitle(title, for: .normal)
    }
  }
}
