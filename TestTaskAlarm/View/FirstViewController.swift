//
//  ViewController.swift
//  TestTaskAlarm
//
//  Created by Мак on 12/6/19.
//  Copyright © 2019 Aidar Zhussupov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FirstViewController: UIViewController {
    var vm = ViewModel()
    var alarmModel: AlarmModel?
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var nameAlarm: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserDefaults()
        addGestureRecognizer(label: timeTextField)
        bindUI()
        assignbackground()
        checkName()
    }
    
    func bindUI() {
        _ = vm.date.bind(to: timeTextField.rx.text)
        _ = vm.alarmName.bind(to: nameAlarm.rx.text)
    }
    
    func addGestureRecognizer(label: UITextField) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(FirstViewController.tapFunction))
        timeTextField.isUserInteractionEnabled = true
        timeTextField.addGestureRecognizer(tap)
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        performSegue(withIdentifier: "toDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let detailViewController = segue.destination as? DetailViewController {
                detailViewController.vm = vm.viewModel //Or pass any values
            }
        }
    }
    
    
    func checkUserDefaults() {
        guard let alarmName = UserDefaults.standard.string(forKey: "name") else { return }
        guard let date = UserDefaults.standard.string(forKey: alarmName) else {
            print("Nothing in UserDefauls")
            timeTextField.text = "00:00"; return}
        nameAlarm.text = alarmName
//        let formatter = DateFormatter()
//        formatter.dateFormat = "HH:mm"
        timeTextField.text = date
//            formatter.string(from: date as! Date)
    }
    
    func checkName(){
        guard let name = UserDefaults.standard.object(forKey: "name") else {
            nameAlarm.text = "userDefaults"; return}
        nameAlarm.text = name as? String
    }
    
    func assignbackground() {
        if let background = UIImage(named: "background") {
            self.view.backgroundColor = UIColor(patternImage: background)
        }
    }
    
    
}




