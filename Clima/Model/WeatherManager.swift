
import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    
    func didUpdateWeather(weather: WeatherModel, weatherManager: WeatherManager)
    func didErrorHappened(error: Error)
    
}

struct WeatherManager

{
    
    var delegate: WeatherManagerDelegate?
    
    
    
    let basicWeatherUrl="https://api.openweathermap.org/data/2.5/weather?appid=8f24df36d626f45778c233283d37967f&units=metric"
    
    func fetchWeather(cityName: String){
        
        let weatherUrl="\(basicWeatherUrl)&q=\(cityName)"
        performRequest(urlString: weatherUrl)
                
    }
    
    func fetchWeather(lat: CLLocationDegrees, long: CLLocationDegrees){
        
        let weatherUrl="\(basicWeatherUrl)&lat=\(lat)&lon=\(long)"
        performRequest(urlString: weatherUrl)
                
    }
    
    
    func performRequest (urlString: String)
    {
        //1. Create Url
        if let url=URL(string: urlString){
            //2. Create a URL Session
            
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            
            let task=session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData = data{
                    if let weather = self.parseJSON(weatherData: safeData){
                        
                        self.delegate?.didUpdateWeather(weather: weather,weatherManager: self)
                        
                    }
                }
            }
            
            //4. start task
            
            task.resume()
            
        }
    }
    
    
    func parseJSON(weatherData: Data) -> WeatherModel?{
        
        let decoder=JSONDecoder()
        
        do{
        let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].id)
            let weatherID=decodedData.weather[0].id
            let weatherName=decodedData.name
            let weatherTemp=decodedData.main.temp
            
            let weatherModel = WeatherModel(conditionID: weatherID, cityName: weatherName, temprature: weatherTemp)
            return weatherModel
            
            
            

        }catch{
            
            self.delegate?.didErrorHappened(error:error)
            return nil
            
        }
        
        
        
        
    }
    
    
    
  
    
   
}
