//
//  RxMainView.swift
//  FlowLayoutTest
//
//  Created by Carki on 2022/10/24.
//

import UIKit

import SnapKit

class RxMainView: BaseView {
    let rxTableViw: UITableView = {
        let view = UITableView()
        view.backgroundColor = .brown
        return view
    }()
    
    let rxSwitch: UISwitch = {
        let view = UISwitch()
        
        return view
    }()
    
    let rxIdTextField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .systemMint
        return view
    }()
    
    let rxEmailTextField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .systemMint
        return view
    }()
    
    let rxSignButton: UIButton = {
        let view = UIButton()
        view.setTitle("회원가입", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let rxPickerView: UIPickerView = {
        let view = UIPickerView()
        view.backgroundColor = .brown
        return view
    }()
    
    let rxCheckLabel: UILabel = {
        let view = UILabel()
        view.text = "Label"
        return view
    }()
    
    override func configureUI() {
        [rxTableViw, rxSwitch, rxIdTextField, rxEmailTextField, rxSignButton, rxPickerView, rxCheckLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        rxTableViw.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(150)
        }
        
        rxSwitch.snp.makeConstraints { make in
            make.top.equalTo(rxTableViw.snp.bottom).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
        }
        
        rxIdTextField.snp.makeConstraints { make in
            make.top.equalTo(rxSwitch.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        rxEmailTextField.snp.makeConstraints { make in
            make.top.equalTo(rxIdTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        rxSignButton.snp.makeConstraints { make in
            make.top.equalTo(rxEmailTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        rxPickerView.snp.makeConstraints { make in
            make.top.equalTo(rxSignButton.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(162)
        }
        
        rxCheckLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
    }
}
