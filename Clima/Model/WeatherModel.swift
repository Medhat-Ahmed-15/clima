

import Foundation


struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temprature: Double
    
    var conditionName: String{
        switch conditionID {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud.bolt"
                default:
                    return "cloud"
                }
    }
    
    var tempretureString: String{
        return String(format: "%.1f", temprature)
    }
    
    init(conditionID: Int, cityName: String, temprature: Double) {
        self.conditionID = conditionID
        self.cityName = cityName
        self.temprature = temprature
    }
    
   
}
