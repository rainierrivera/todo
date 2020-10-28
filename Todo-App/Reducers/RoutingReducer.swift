//
//  RoutingReducer.swift
//  Todo-App
//
//  Created by Collabera on 10/23/20.
//

import ReSwift

func routingReducer(action: Action, state: RoutingState?) -> RoutingState {
  let appUserDefault = AppUserDefault.shared
  var state = state ?? RoutingState()
  
  switch action {
  case let routingAction as RoutingAction:
    state.routingDestination = routingAction.destination
    if state.routingDestination == .pop {
      appUserDefault.deleteCurrentUser()
    }
  default: break
  }
  
  return state
}
