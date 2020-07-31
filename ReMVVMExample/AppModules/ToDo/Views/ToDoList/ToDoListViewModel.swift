//  
//  ToDoListViewModel.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVM
import RxSwift

public struct ToDoListViewModel: Initializable {

    let title = Observable.just("To-Do List")

    public init() { }

}
