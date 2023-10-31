//
//  ViewModel.swift
//  ToWatchMovie
//
//  Created by Dima Kozhanovsky on 06/10/2023.
//

import Foundation
import Combine

final class MainScreenViewModel : ObservableObject {
    
    //  ObservableObject protocol, which means SwiftUI’s views can watch it for changes.
    // финал класс не только запрещает наследоваие но и влияет на диспатчерезацию , методы класса хранятся по определеным адрессам , в момент вызова метода программа переходит по адресу и считывает те инструкции которые там находятся , у класса насдедника без прайват  подсавляется ссыллка на виртуальную таблицу из класса наследника ( если метода был переопредлен ) . Для протоколов создается  witness table ( адреса функции ищутся не в виртуальной таблице )
    // Виды диспатчеризации : статическая / прямая (static /direct )  ( методы вызываются на этапе компиляции ( при преобразовании swift в assembler ( после swift intermediate )  ,  не в ран тайме  не во время исполнения  ) Работает со структкрами , финальными классами , финальными методами , расширений
    
    // виртуальная / witness - классы не final и протоколы
    
    //  зачем нужно знать - в массивых , переборках масивах на этапе компиляции программа не понимает что мы иммеем ввмду
    // mwssage dispatch -для обждектив с свои особенности
    @Published var state : MainScreenState = .idle
    // the @Published property wrapper effectively adds a willSet property observer
    //The most common time willSet is used is when you need to know the state of your program before a change is made
    
    private let repository = MovieRepository()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init( ) {
        // новый иницализатор
        moviesSubscription()
     
        // когда вемодель создаться у нее в инициализаторе вызовется это функция
    }
    
}
//MARK:- Subscribes
extension MainScreenViewModel {
    func moviesSubscription() {
        repository.$movies.sink { [weak self] movies in
            DispatchQueue.main.async {
                if movies.isEmpty {
                    self?.state = .empty
                }
                else {
                    self?.state = .moviesList(movies)
                }
            }
        }
        .store(in: &cancellables)
        
        
        // на паблишед объекты можно подписаться
        // на 58 делаем подписку
        // на 61 удаляем полписку  без 61 подписка не сработает
    }
}

