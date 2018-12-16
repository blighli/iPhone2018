//
//  DataModel.swift
//  Cloud
//
//  Created by shayue on 2018/12/01.
//  Copyright © 2018 shayue. All rights reserved.
//

import UIKit

class DataModel {	
	//Declare your model variables here
	var temperature: Int = 0
	var condition: Int = 0
	var city: String = ""
	var weatherIconName: String = ""
	
	//This method turns a condition code into the name of the weather condition image
	func updateWeatherIcon(condition: Int) -> String {
		
		switch (condition) {
		case 200...202, 210...212, 221, 230...232 :
			return "thunderstorm"			//雷阵雨
			
		case 300...302, 310, 311...314, 321:
			return "drizzle"				//毛毛雨
			
		case 500 :
			return "lightrain"				//小雨
			
		case 501 :
			return "moderaterain"			//中雨
			
		case 502 :
			return "heavyrain"				//大雨
			
		case 503 :
			return "veryheavyrain"			//暴雨
			
		case 504 :
			return "extremerain"			//特大暴雨
			
		case 511 :
			return "freezingrain"			//冻雨
			
		case 520...522, 531 :
			return "showerrain"			//阵雨
			
		case 600 :
			return "lightsnow"				//小雪
			
		case 601  :
			return "snow"					//中雪
			
		case 602 :
			return "heavysnow"				//大雪
			
		case 611, 612, 615, 616 :
			return "yujiaxue"				//雨夹雪
			
		case 620...622 :
			return "showersnow"			//阵雪
			
		case 701, 711, 741 :
			return "mist"					//雾
			
		case 721 :
			return "haze"					//雾霾
			
		case 751, 761 :
			return "sand"					//雾霾
			
		case 800 :
			return "sky"					//晴天
			
		case 801 :
			return "fewclouds"
			
		case 802 :
			return "scatteredclouds"
			
		case 803 :
			return "brokenclouds"
			
		case 804 :
			return "overcastclouds"
			
		default :
			return "sky"
		}
		
	}
}
