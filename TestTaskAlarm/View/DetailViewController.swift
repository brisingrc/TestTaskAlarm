//
//  DetailViewController.swift
//  TestTaskAlarm
//
//  Created by Мак on 12/6/19.
//  Copyright © 2019 Aidar Zhussupov. All rights reserved.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {
    let formatter = DateFormatter()
    var vm: DetailVCViewModel?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func saveAlarm(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "HH:mm"
        nameTextField.text = "alarm"
        subscribe()
        customeUI(button: saveButton)
        assignbackground()
    }
    
    func customeUI(button: UIButton) {
        button.layer.cornerRadius = 15/// радиус закругления закругление
        button.layer.borderWidth = 2   // толщина обводки
        button.backgroundColor = UIColor.black
        button.clipsToBounds = true
        button.isEnabled = true
        button.tintColor = UIColor.white
    }
    
    func subscribe() {
        guard let vm = vm else { return }
        _ = datePicker.rx.date.subscribe(onNext: { date in
            print(date)
            UserDefaults.standard.setValue(date, forKey: "alarm")
            UserDefaults.standard.setValue(self.nameTextField.text, forKey: "name")
            vm.date.onNext(self.formatter.string(from: date))
            ScheduleNotification.shared.scheduleNotification(notifaicationType: self.nameTextField.text!, date: date)
            
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        _ = nameTextField.rx.text.subscribe(onNext: { text in
            vm.alarmName.onNext(text ?? "Alarm")
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    func assignbackground() {
        if let background = UIImage(named: "background") {
            self.view.backgroundColor = UIColor(patternImage: background)
        }
    }
    
}
