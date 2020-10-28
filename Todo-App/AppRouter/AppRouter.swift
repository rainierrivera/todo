//
//  AppRouter.swift
//  Todo-App
//
//  Created by Collabera on 10/23/20.
//

import ReSwift

final class AppRouter {
    
  let navigationController: UINavigationController
    
  init(window: UIWindow) {
    navigationController = UINavigationController()
    window.rootViewController = navigationController
    // 1
    store.subscribe(self) {
      $0.select {
        $0.routerState
      }
    }
  }
  
  // 2
  fileprivate func pushViewController(identifier: String, animated: Bool) {
    let viewController = instantiateViewController(identifier: identifier)
    let newViewControllerType = type(of: viewController)
    if let currentVc = navigationController.topViewController {
      let currentViewControllerType = type(of: currentVc)
      if currentViewControllerType == newViewControllerType {
        return
      }
    }

    navigationController.pushViewController(viewController, animated: animated)
  }
    
  private func instantiateViewController(identifier: String) -> UIViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: identifier)
  }
}


extension AppRouter: StoreSubscriber {
  func newState(state: RoutingState) {
    
    if state.routingDestination == .pop {
      navigationController.popViewController(animated: true)
      return
    }
    
    let shouldAnimate = navigationController.topViewController != nil
    pushViewController(identifier: state.routingDestination.rawValue, animated: shouldAnimate)
  }
}
