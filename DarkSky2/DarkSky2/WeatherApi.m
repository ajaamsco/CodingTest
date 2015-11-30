//
//  WeatherApi.m
//  DarkSky2
//
//  Created by Angus Johnston on 29/11/2015.
//  Copyright © 2015 Angus Johnston. All rights reserved.
//

#import "WeatherApi.h"


@implementation WeatherApi


-(id)init: (id<WeatherApiControllerDelegate>)delegate {
    self.delegate = delegate;
    return self;
}

/**
* Method to make a call to the Dark Sky Forecast API (https://developer.forecast.io)
*/
-(void)searchWeatherApi :(double)latitude :(double)longtitude {

    NSString *body = @"https://api.forecast.io/forecast/0b8c3efdd89da5d33960f22a30dc33d9/";
    NSString *lat = [NSMutableString stringWithFormat:@"%.4f", latitude];
    NSString *lon = [NSMutableString stringWithFormat:@"%.4f", longtitude];
    NSString* finalString = @"";
    
    finalString = [finalString stringByAppendingString:body];
    finalString = [finalString stringByAppendingString:lat];
    finalString = [finalString stringByAppendingString:@","];
    finalString = [finalString stringByAppendingString:lon];
    
    NSURL *urlPath = [[NSURL alloc] initWithString:finalString];
    
    // invoke Task to retrieve data via weather api
    if (urlPath != nil) {
        [self getWeatherData:urlPath];
    }

}

/**
* Helper method to submit the API call as a data task
*/
-(void)getWeatherData :(NSURL*)url{

    NSURLRequest *searchRequest	= [[NSURLRequest alloc] initWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    session.configuration.timeoutIntervalForRequest = 10;

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:searchRequest
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if(error != nil) {
                if (self.delegate != nil) {
                    dispatch_async(dispatch_get_main_queue(), ^(void){
                        [self.delegate didFinishWeatherApiSearch:0.0 forecast:nil city:nil weatherApiError:error.localizedDescription theWholeShibang:nil];
                    });
                }
            }
            
            if (data != nil) {
                NSDictionary *resultsDictionary;
                NSError *myError = nil;
                resultsDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&myError];
                
                if ([resultsDictionary isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *currentWeather = resultsDictionary[@"currently"];
                    double temperatureF = [currentWeather[@"temperature"] doubleValue];
                    NSString *forecast = currentWeather[@"icon"];
                    NSString *timezone = resultsDictionary[@"timezone"];
                    
                    NSString *dataAsString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSString *city = [self getCity:timezone];

                    //done. send data back
                    dispatch_async(dispatch_get_main_queue(), ^(void){
                        [self.delegate didFinishWeatherApiSearch:temperatureF forecast:forecast city:city weatherApiError:nil theWholeShibang:dataAsString];
                    });
                    
                } else {
                    //wasnt a dictionary. abort!
                    dispatch_async(dispatch_get_main_queue(), ^(void){
                        [self.delegate didFinishWeatherApiSearch:0.0 forecast:nil city:nil weatherApiError:@"Response data incorrect format" theWholeShibang:nil];
                    });
                }
            }
        }];
	
    [dataTask resume];
}

/**
* Helper method to get the current geolocation city (from api response) for display in the UI
*/
-(NSString*)getCity :(NSString*)timezoneData {
    
    NSArray *city = [timezoneData componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/"]];
    
    if (city != nil) {
        return city[1];   // eg. ["Australia", "Sydney" ] is format of array
    }
    return @"Unknown City";
}


@end
