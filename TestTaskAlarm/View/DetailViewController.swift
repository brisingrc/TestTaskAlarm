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
        customeUI()
        assignbackground()
    }
    
    func customeUI() {
        saveButton.layer.cornerRadius = 15/// радиус закругления закругление
        saveButton.layer.borderWidth = 2   // толщина обводки
        saveButton.backgroundColor = UIColor.black
        saveButton.clipsToBounds = true
        saveButton.isEnabled = true
        saveButton.tintColor = UIColor.white
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
        let background = UIImage(named: "background")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
      imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        imageView.alpha = 0.5
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }

}
