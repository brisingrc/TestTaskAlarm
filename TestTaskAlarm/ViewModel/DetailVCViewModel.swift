//
//  ViewModelDetailController.swift
//  TestTaskAlarm
//
//  Created by Мак on 12/6/19.
//  Copyright © 2019 Aidar Zhussupov. All rights reserved.
//

import Foundation
import RxSwift
class DetailVCViewModel {
    var date = PublishSubject<String>()
    var alarmName = PublishSubject<String>()
}

