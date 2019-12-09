//
//  ViewModel.swift
//  TestTaskAlarm
//
//  Created by Мак on 12/6/19.
//  Copyright © 2019 Aidar Zhussupov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    var viewModel = DetailVCViewModel()
    var date = PublishSubject<String>()
    var alarmNme = PublishSubject<String>()
    init() {
        _ = viewModel.date.subscribe(onNext: { date in
            print(date)
            self.date.onNext(date)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        _ = viewModel.alarmName.subscribe(onNext: { name in
            self.alarmNme.onNext(name)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
}
