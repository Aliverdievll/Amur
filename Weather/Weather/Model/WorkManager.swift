//
//  WorkManager.swift
//  Weather
//
//  Created by Amur Aliverdiev on 21.04.2023.
//

import Foundation
import UIKit

//В данной моделе выполняется запрос данных из сети
class WorkManager {
    
    static let shared = WorkManager()
    
    
    func loadDataWeather(cityName: String, complition: @escaping (WeatherData) -> ()) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=97c5a6a3984c19b8f5a94639efef49b0&units=metric"
        
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: url) { data, reponse, error in
                
                guard let data = data else { return }
                
                
                guard let weather = try? JSONDecoder().decode(WeatherData.self, from: data) else { return }
                
                complition(weather)
                
            }.resume()
        }
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
}
