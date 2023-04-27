

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
  
    

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    var weatherManager = WeatherManager()
    let locationManager=CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate=self
        weatherManager.delegate=self
        locationManager.delegate=self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
    }


    
    
}


//MARK: - UITextFieldDelegate


extension WeatherViewController: UITextFieldDelegate{
    
    @IBAction func searchButton(_ sender: UIButton) {
        
        searchTextField.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text ?? "")
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != ""{
            return true
        }else{
            searchTextField.placeholder="Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        weatherManager.fetchWeather(cityName: searchTextField.text ?? "")
        searchTextField.text=""
    }
    
}


//MARK: - WeatherManagerDeleagte

extension WeatherViewController: WeatherManagerDelegate{
    
    func didUpdateWeather(weather: WeatherModel, weatherManager: WeatherManager) {
        DispatchQueue.main.async {
            self.temperatureLabel.text=weather.tempretureString
            self.conditionImageView.image=UIImage(systemName: weather.conditionName)
            self.cityLabel.text=weather.cityName
            
        }
        
    }
    
    func didErrorHappened(error: Error) {
       print(error)
    }
    
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate{
    
    
    @IBAction func currentLocationButton(_ sender: Any) {
        
        locationManager.requestLocation()
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location=locations.last{
            let latitude=location.coordinate.latitude
            let longitude=location.coordinate.longitude
            print(latitude)
            print(longitude)
            
            weatherManager.fetchWeather(lat: latitude, long: longitude)
            locationManager.stopUpdatingLocation()//Stop updating the location oce reached to it

        }
        

        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    
}



