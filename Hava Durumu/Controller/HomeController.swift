//
//  ViewController.swift
//  Hava Durumu
//
//  Created by Halil YAŞ on 28.12.2022.
//

import UIKit
import MapKit

class HomeController: UIViewController, CLLocationManagerDelegate {
    
    //MARK: - Properties
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var precipitaionLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    let locationManager = CLLocationManager()
    
    let client = APIClient()
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        location()
        
    }
    
    //MARK: - API
    
    func updateWeather(coordinate : Coordinate) {
        
        client.getCurrentWeather(at: coordinate) { currentWeather, error in
            if let currentWeather = currentWeather {
                let viewModel = CurrentWeatherModel(data: currentWeather)
                
                DispatchQueue.main.sync {
                    self.showWeather(model: viewModel)
                }
            }
        }
    }
    
    
    //MARK: - Actions
    
    @IBAction func refreshButton(_ sender: Any) {
        indicator.startAnimating()
        locationManager(locationManager, didUpdateLocations: [])
    }
    
    //MARK: - Helpers

    func showWeather(model : CurrentWeatherModel) {
        summaryLabel.text = model.summary
        humidityLabel.text = model.humidity
        temperatureLabel.text = model.temperature
        precipitaionLabel.text = model.precipitationProbability
        weatherIcon.image = model.icon
        indicator.stopAnimating()
    }
    
    //MARK: - Location
    
    func location() {
        self.locationManager.delegate = self
        // uygulama ilk açıldığında atılan istek
        self.locationManager.requestWhenInUseAuthorization()
        
        // konum servisi cihaz da açık mı?
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            
            // konum bilgisini almaya başlayacak
            locationManager.startUpdatingLocation()
        }
    }
    
    // konum bilgisi değişirse bu fonksiyon çalışacak
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationValue : CLLocationCoordinate2D = manager.location!.coordinate
        let clientCoordinate = Coordinate(latitude: locationValue.latitude, longitude: locationValue.longitude)
        print("DEBUG: Latitude :\(clientCoordinate.latitude), Longitude : \(clientCoordinate.longitude)")
        updateWeather(coordinate: clientCoordinate)
    }
}


