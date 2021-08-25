//  
//  TestStackViewModel.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import RxSwift

struct TestStackViewModel {

    let title = Observable.just("Test Stack")
    let pushButtonTitle = Observable.just("PUSH")
    let modalButtonTitle = Observable.just("MODAL")
    let dismissModalButtonTitle = Observable.just("DISMISS MODAL")

    let isOnModal: Observable<Bool>

    init(isOnModal: Bool) {
        self.isOnModal = .just(isOnModal)
    }

}
