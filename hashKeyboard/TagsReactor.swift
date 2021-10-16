//
//  TagsReactor.swift
//  hashKeyboard
//
//  Created by Juyeon on 2021/10/17.
//

import Foundation
import ReactorKit

class TagsReactor: Reactor {
    enum Action {
        case loadTags
    }
    enum Mutation {
        case setTags([Tag])
    }
    
    struct State {
        var tags: [Tag] = []
    }
    
    var initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadTags: return .just(.setTags(CoreDataManager.shared.loadFromCoreData(request: Tag.fetchRequest())))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setTags(let tags):
            newState.tags = tags
        }
        return newState
    }
}
