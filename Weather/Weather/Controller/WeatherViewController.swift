//
//  WeatherViewController.swift
//  Weather
//
//  Created by Amur Aliverdiev on 21.04.2023.
//


//Приложение через API получает данные о погоде с поиском задавать города


import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var minMaxTemp: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var cityName: UILabel!
    

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global().async {
            
            WorkManager.shared.loadDataWeather(cityName: "London") { weatherData in
                
                DispatchQueue.main.async {
                    
                    self.cityName.text = "\(weatherData.name)"
                    self.temp.text = "\(Int(weatherData.main.temp))°"
                    self.minMaxTemp.text = "Min: \(Int(weatherData.main.tempMin))°, Max: \(Int(weatherData.main.tempMax))°"
                    self.feelsLike.text = "По ощущению \(Int(weatherData.main.feelsLike))°"
                }
            }
        }
        
        
    }
    
    // MARK: - Alert
    @IBAction func searchButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Название города", message: "", preferredStyle: .alert)
        
        alert.addTextField() { text in
            text.placeholder = "Moscow Belgorod Volgograd Kazan"
        }
        
        let alertAction = UIAlertAction(title: "Поиск", style: .default) { _ in
            
            DispatchQueue.global().async {
                
                WorkManager.shared.loadDataWeather(cityName: (alert.textFields?.first?.text)!) { weatherData in
                    
                    DispatchQueue.main.async {
                        
                        self.cityName.text = "\(weatherData.name)"
                        self.temp.text = "\(Int(weatherData.main.temp))°"
                        self.minMaxTemp.text = "Min: \(Int(weatherData.main.tempMin))°, Max: \(Int(weatherData.main.tempMax))°"
                        self.feelsLike.text = "По ощущению \(Int(weatherData.main.feelsLike))°"
                        
                    }
                }
            }
        }
        
        
        
        alert.addAction(alertAction)
        
        present(alert, animated: true)
    }
    

}

