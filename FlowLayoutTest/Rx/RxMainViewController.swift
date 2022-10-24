//
//  RxMainViewController.swift
//  FlowLayoutTest
//
//  Created by Carki on 2022/10/24.
//

import UIKit

import RxCocoa
import RxSwift

class RxMainViewController: BaseViewController {
    
    let mainView = RxMainView()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableSetting()
        pickerViewSetting()
        switchSetting()
        setSignUp()
    }
    
    func tableSetting() {
        let myTableView = mainView.rxTableViw
        let myLabel = mainView.rxCheckLabel
        
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let items = Observable.just([
            "First Item",
            "Second Item",
            "Third Item"
        ])

        items
        .bind(to: myTableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element) @ row \(row)"
            return cell
        }
        .disposed(by: disposeBag)
        
        myTableView.rx.modelSelected(String.self)
            .map { data in
                "\(data)를 클릭했습니다."
            }
            .bind(to: myLabel.rx.text)
//            .subscribe { value in //성공한 케이스
//                print(value)
//            } onError: { error in
//                print("error")
//            } onCompleted: {
//                print("completed")
//            } onDisposed: {
//                print("disposed")
//            }
            .disposed(by: disposeBag)

    }
    
    func pickerViewSetting() {
        
        let myPickerView = mainView.rxPickerView
        let myLabel = mainView.rxCheckLabel
        
        let items = Observable.just([
                "영화",
                "애니메이션",
                "드라마",
                "기타"
            ])
     
        items
            .bind(to: myPickerView.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
        
        myPickerView.rx.modelSelected(String.self)
            .map { $0.description }
            .bind(to: myLabel.rx.text)
//            .subscribe(onNext: { value in
//                print(value)
//            })
            .disposed(by: disposeBag)
    }
    
    func switchSetting() {
        let mySwitch = mainView.rxSwitch
        let myLabel = mainView.rxCheckLabel
        
        Observable.of(false) //just?, of?
            .bind(to: mySwitch.rx.isOn)
            .disposed(by: disposeBag)
        
        mySwitch.rx.controlEvent(.valueChanged)
            .withLatestFrom(mySwitch.rx.value)
            .subscribe { bool in
                if bool {
                    myLabel.text = "스위치 ON"
                } else {
                    myLabel.text = "스위치 OFF"
                }
            }
            .disposed(by: disposeBag)
    }
    
    func setSignUp() {
        
        let myIdTextField = mainView.rxIdTextField
        let myEmailTextField = mainView.rxEmailTextField
        let mySignUpButton = mainView.rxSignButton
        let myLabel = mainView.rxCheckLabel
        
        //ex. 텍스트필드1(Observable), 텍스트필드2(Observable) > 레이블(Observer, bind)
        Observable.combineLatest(myIdTextField.rx.text.orEmpty, myEmailTextField.rx.text.orEmpty) {  value1, value2 in
            return "name은 \(value1)이고, 이메일은 \(value2)입니다."
        }
        .bind(to: myLabel.rx.text)
        .disposed(by: disposeBag)
        
        //데이터의 흐름 Stream 시퀀스
        myIdTextField //UITextField
            .rx //Reactive
            .text //String?
            .orEmpty //옵셔널 해제 String
            .map { $0.count < 4} //Int
            //.map { $0  < 4 } //Bool
            .bind(to: myEmailTextField.rx.isHidden, mySignUpButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        myEmailTextField.rx.text.orEmpty
            .map { $0.count > 4 }
            .bind(to: mySignUpButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        mySignUpButton.rx.tap //touchUpInside
            .subscribe { _ in
                self.showAlert()
            }
            .disposed(by: disposeBag)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "하하하", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}
