//
//  ViewController.swift
//  SelectCar_Code
//
//  Created by 김광수 on 2020/06/09.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  //MARK: - Properties
  var carCompanyName:[String] = ["Lamborghini","Tesla","Porsche"]
  var carData:[String:[String]] = [
    "Lamborghini":["aventador","veneno","huracan"],
    "Tesla":["model S", "model X"],
    "Porsche":["911", "boxter"]
  ]

  var carModel = [String]()
  var carModelImage:[String] = []
  
  let lamborghiniImageName = ["lamborghini-aventador.jpg","lamborghini-veneno.jpg","lamborghini-huracan.jpg"]
  let teslaImageNames = ["tesla-model-s.jpg","tesla-model-x.jpg"]
  let porscheImageName = ["porsche-911.jpg","porsche-boxter.jpg"]
  
  let pickerView: UIPickerView = {
    let pv = UIPickerView()
    return pv
  }()
  
  let titlelable: UILabel = {
    let label = UILabel()
    label.text = "SelectCar"
    label.font = .boldSystemFont(ofSize: 50)
    return label
  }()
  
  let carImageView: UIImageView = {
    let img = UIImageView()
    img.backgroundColor = .systemGray3
    img.layer.cornerRadius = 10
    img.image = UIImage(named: "lamborghini-aventador.jpg")
    return img
  }()
  
  let backgroundImageView: UIImageView = {
    let imgView = UIImageView()
    imgView.image = UIImage(named: "background.jpeg")
    return imgView
  }()
  
  //MARK: - init
  override func viewDidLoad() {
    super.viewDidLoad()
    // 초기값 지정
    defaultDataSetting()
    
    pickerView.delegate = self
    pickerView.dataSource = self
    
    buildUi()
  }
  
  private func defaultDataSetting() {
    guard let carData = carData["Lamborghini"] else { return }
    carModel = carData
    carModelImage = lamborghiniImageName
  }
  
  private func buildUi() {
    backgroundImageView.frame = view.frame
    view.addSubview(backgroundImageView)
    
    view.addSubview(titlelable)
    view.addSubview(pickerView)
    view.addSubview(carImageView)
    
    titlelable.translatesAutoresizingMaskIntoConstraints = false
    pickerView.translatesAutoresizingMaskIntoConstraints = false
    carImageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      titlelable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      titlelable.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -300),
      
      pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -100),
      pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      pickerView.heightAnchor.constraint(equalToConstant: 150),
      
      carImageView.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 50),
      carImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
      carImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      carImageView.heightAnchor.constraint(equalToConstant: 250)
    ])
  }
  
}

//MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
  
  // 좌우로 보여질 그룹의 갯수를 지정
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 2
  }
  
  // Coponents에 들어갈 내용을 지정
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if component == 0 {
      return carCompanyName.count
    } else {
      return carModel.count
    }
  }
  
  // component를 선택했을때 출력되는 함수
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
    if component == 0 {
      return carCompanyName[row]
    } else {
      return carModel[row]
    }
  }
  
  // row를 선택할때 실행되는 함수
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if component == 0 && row == 0 {
      carModel = carData[carCompanyName[row]]!
      carModelImage = lamborghiniImageName
    } else if component == 0 && row == 1 {
      carModel = carData[carCompanyName[row]]!
      carModelImage = teslaImageNames
    } else if component == 0 && row == 2 {
      carModel = carData[carCompanyName[row]]!
      carModelImage = porscheImageName
    }
    carImageView.image = UIImage(named: carModelImage[pickerView.selectedRow(inComponent: 1)])
    // UIPickerView를 다시 보여줌
    pickerView.reloadAllComponents()
  }
}

