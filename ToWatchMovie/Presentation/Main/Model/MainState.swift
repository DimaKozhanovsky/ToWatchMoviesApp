//
//  MainState.swift
//  ToWatchMovie
//
//  Created by Dima Kozhanovsky on 21/10/2023.
//

import Foundation

// enum чтобы отоборажать состояния вью


enum MainScreenState {
    case idle
    case empty
    case moviesList([MovieModel])
}
