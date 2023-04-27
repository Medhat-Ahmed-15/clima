//
//  WeatherData.swift
//  Clima
//
//  Created by Medhat Ahmed on 24/04/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation


struct WeatherData: Decodable{
    
    let name: String
    let main: Main
    let weather: [WeatherInfo]
    
}

struct Main: Decodable{
    let temp: Double
}



struct WeatherInfo: Decodable{
    
    let id: Int
    let description: String
    
}
