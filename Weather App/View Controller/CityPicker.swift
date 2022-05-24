//
//  CityPicker.swift
//  Weather App
//
//  Created by Hassan on 23/05/2022.
//

import UIKit

class CityPicker: UIViewController {

    
    var cityArray : [City] = [City(cityName: "Giza", cityId: "360995"),
                         City(cityName: "Cairo", cityId: "360630"),
                         City(cityName: "Alexandria", cityId: "361058"),
                         City(cityName: "Ismailia", cityId: "361055"),
                         City(cityName: "Hurghada", cityId: "361291"),
                         City(cityName: "Al Fayoum", cityId: "361320"),
                         City(cityName: "Beheira", cityId: "361370") ,
                              City(cityName: "Aswan", cityId: "359792") 

                        ]
    
    var selectedCity:City?
    override func viewDidLoad() {
        super.viewDidLoad()

        let jeremyGif = UIImage.gifImageWithName("giphy")
        let imageView = UIImageView(image: jeremyGif)
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height * 0.3)
        view.addSubview(imageView)    }


    @IBAction func pickCityBtn(_ sender: Any) {
        
        if let city = selectedCity {
            print(city.cityName)
            NotificationCenter.default.post(name: NSNotification.Name("selectedCity"), object: nil,userInfo: ["city" : city])
            dismiss(animated: true, completion: nil)
        }
    }
}


extension CityPicker : UIPickerViewDelegate , UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityArray[row].cityName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedCity = cityArray[row]
    }
    
    // change color of text
    /*
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: cityArray[row].cityName, attributes: [NSAttributedString.Key.foregroundColor : UIColor.tintColor])
    } */
    
    
}
