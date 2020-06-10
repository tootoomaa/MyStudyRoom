//
//  ViewController.swift
//  SelectCar
//
//  Created by 김광수 on 09/10/2019.
//  Copyright © 2019 김광수. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
  
  @IBOutlet weak var imgView: UIImageView!
  
  let carCompanyName = ["Tesla","Lamborghini","Porsche"]
  var carModel:[String] = [] //var carModel = [String]()
  var carModelImage:[String] = []
  
  //이미지뷰에 이미지를 넣기 위하여 배열형태로 정의
  let tesla = ["model S", "model X"]
  let lamborghini = ["aventador","veneno","huracan"]
  let porsche = ["911", "boxter"]
  
  let teslaImageNames = ["tesla-model-s.jpg","tesla-model-x.jpg"]
  let lamborghiniImageName = ["lamborghini-aventador.jpg","lamborghini-veneno.jpg","lamborghini-huracan.jpg"]
  let porscheImageName = ["porsche-911.jpg","porsche-boxter.jpg"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    carModel = tesla
    carModelImage = tesla
    imgView.layer.cornerRadius = 50.0
    imgView.layer.masksToBounds = true
    // Do any additional setup after loading the view.
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 2
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    //        print(component)
    if component == 0 {
      return carCompanyName.count
    } else {
      return carModel.count
    }
    
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if component == 0 {
      return carCompanyName[row]
    } else {
      return carModel[row]
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if component == 0 && row == 0{
      carModel = tesla
      carModelImage = teslaImageNames
      pickerView.selectRow(0, inComponent: 1, animated: true)
    } else if component == 0 && row == 1 {
      carModel = lamborghini
      carModelImage = lamborghiniImageName
    } else if component == 0 && row == 2 {
      carModel = porsche
      carModelImage = porscheImageName
      
      pickerView.selectRow(0, inComponent: 1, animated: true)
    }
    imgView.image = UIImage(named: carModelImage[pickerView.selectedRow(inComponent: 1)])
    pickerView.reloadAllComponents()
  }
}

