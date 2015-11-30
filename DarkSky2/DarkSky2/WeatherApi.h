//
//  WeatherApi.h
//  DarkSky2
//
//  Created by Angus Johnston on 29/11/2015.
//  Copyright © 2015 Angus Johnston. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WeatherApiControllerDelegate 

    - (void)didFinishWeatherApiSearch:
                             (double) temperatureF
           forecast         :(NSString *) forecast
           city             :(NSString *) city
           weatherApiError  :(NSString *) weatherApiError
           theWholeShibang  :(NSString *) theWholeShibang;
@end


@interface WeatherApi : NSObject

    @property (weak) id <WeatherApiControllerDelegate> delegate;
    @property NSString *errorResponse;

    //initialiser
    - (id)init: (id<WeatherApiControllerDelegate>)delegate;

    /**
	* Method to make a call to the Dark Sky Forecast API (https://developer.forecast.io)
	*/
    -(void)searchWeatherApi :(double)latitude :(double)longtitude;

    /**
	* Helper method to submit the API call as a data task
	*/
    -(void)getWeatherData :(NSURL*)url;

    /**
     * Helper method to get the current geolocation city (from api response) for display in the UI
    */
    -(NSString*)getCity :(NSString*)timezoneData;


@end

