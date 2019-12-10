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
    var alarmName = PublishSubject<String>()
    init() {
        _ = viewModel.alarmModel.subscribe(onNext:{ alarmModel in
            self.date.onNext(alarmModel.date)
            self.alarmName.onNext(alarmModel.alarmName)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
}
