//
//  ViewController.swift
//  Cloud
//
//  Created by shayue on 2018/11/23.
//  Copyright © 2018 shayue. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
	
	//Constants
	let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
	let APP_ID = "1d505359c7db3fcf2502ffd40525ddc8"
	
	//TODO: Declare instance variables here
	let locationManager = CLLocationManager()
	let weatherDataModel = DataModel()
	let now = Date()
	
	//Pre-linked IBOutlets
	@IBOutlet weak var temperatureLabel: UILabel!
	@IBOutlet weak var weatherIcon: UIImageView!
	@IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var poemText: UITextView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//TODO:Set up the location manager here.
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
		
		//record time
		let now = Date()
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		dateFormatter.locale = Locale.current
		let convertDate = dateFormatter.string(from: now)
		let month = Int((convertDate as NSString).substring(with: NSMakeRange(5, 2)))!
		switch month {
			case 3...5:
				poemText.text = "沾衣欲湿杏花雨，吹面不寒杨柳风。"
			case 6...8:
				poemText.text = "稻花香里说丰年。听取蛙声一片。"
			case 9...11:
				poemText.text = "枯藤老树昏鸦，\n小桥流水人家，\n古道西风瘦马。\n夕阳西下，\n断肠人在天涯。"
			case 12, 1, 2:
				poemText.text = "月落乌啼霜满天，江枫渔火对愁眠。"
		default: break
			
		}
	}
	
	
	
	//MARK: - Networking
	/***************************************************************/
	
	//Write the getWeatherData method here:
	func getWeatherData(url: String, parameters: [String: String]) {
		Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
			response in
			if response.result.isSuccess {
				print("成功获取气象数据")
				let weatherJSON: JSON = JSON(response.result.value!)
				self.updateWeatherData(json: weatherJSON)
			}else {
				print("错误 \(String(describing: response.result.error))")
				self.cityLabel.text = "连接问题"
			}
		}
	}
	
	
	//MARK: - JSON Parsing
	/***************************************************************/
	
	
	//Write the updateWeatherData method here:
	func updateWeatherData(json: JSON) {
		if let tempResult = json["main"]["temp"].double {
			weatherDataModel.temperature = Int(tempResult - 273.15)
			weatherDataModel.city = json["name"].stringValue
			weatherDataModel.condition = json["weather"]["id"].intValue
			weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
			
			updateUIWithWeatherData()
		}else {
			cityLabel.text = "气象信息不可用"
		}
	}
	
	
	
	
	//MARK: - UI Updates
	/***************************************************************/
	
	
	//Write the updateUIWithWeatherData method here:
	func updateUIWithWeatherData() {
		cityLabel.text = weatherDataModel.city
		temperatureLabel.text = String(weatherDataModel.temperature) + "°"
		weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
	}
	
	
	//MARK: - Location Manager Delegate Methods
	/***************************************************************/
	
	//Write the didUpdateLocations method here:
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let location = locations[locations.count - 1]
		
		if location.horizontalAccuracy > 0 {
			locationManager.stopUpdatingLocation()
			locationManager.delegate = nil
			
			print("经度 = \(location.coordinate.longitude)，纬度 = \(location.coordinate.latitude)")
			
			let latitude = String(location.coordinate.latitude)
			let longitude = String(location.coordinate.longitude)
			
			let params: [String: String] = ["lat": latitude, "lon": longitude, "appid": APP_ID]
			getWeatherData(url: WEATHER_URL, parameters: params)
		}
	}
	
	//Write the didFailWithError method here:
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print(error)
		cityLabel.text = "定位失败"
	}
	
	
	
	
	//MARK: - Change City Delegate methods
	/***************************************************************/
	
	
	//Write the userEnteredANewCityName Delegate method here:
	func userEnteredANewCityName(city: String) {
		let params: [String: String] = ["q": city, "appid": APP_ID]
		getWeatherData(url: WEATHER_URL, parameters: params)
	}
	
	
	//Write the PrepareForSegue Method here
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "changeCityName" {
			let destinationVC = segue.destination as! ChangeCityViewController
			destinationVC.delegate = self
		}
	}
	
}

