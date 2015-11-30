//
//  Weather.m
//  DarkSky2
//
//  Created by Angus Johnston on 29/11/2015.
//  Copyright © 2015 Angus Johnston. All rights reserved.
//

#import "Weather.h"


@implementation Weather


/**
 * Initializer/instantiation method with 3 input parms
 */
- (id)initWithData :(double)temperatureF forecast:(NSString*)forecast timezone:(NSString*)timezone {
    self = [super init];
    if (self) {
        self.temperatureF = temperatureF;
        self.forecast = forecast;
        self.timezone = timezone;
    }
    return self;
}

/**
* Helper method to provide UI with nicely formatted weather conditions description
*/
- (NSString *)prettyText: (NSString *)textToFormat {
	
	NSDictionary *weatherType =
    @{
      @"clear-day"          : @"Clear Day",
      @"clear-night"        : @"Clear Night",
      @"rain"               : @"Rain",
      @"snow"               : @"Snow",
      @"sleet"              : @"Sleet",
      @"wind"               : @"Wind",
      @"fog"                : @"Fog",
      @"cloudy"             : @"Cloudy",
      @"partly-cloudy-day"  : @"Partly cloudy day",
      @"partly-cloudy-night": @"Partly cloudy night"
    };
    
    if (textToFormat != nil) {
        //match against the dictionary "weatherType"
        NSString *weatherTypeFormattedDescription = weatherType[textToFormat];
        if (weatherTypeFormattedDescription != nil) {
            return weatherTypeFormattedDescription;
        }
    }
    return @"Unknown weather";
}

/**
* Helper method to return a single image, associated with current weather conditions
*/
- (UIImage *)getImage {
    
	UIImage *image = [[UIImage alloc] init];
    
    if ([self.forecast  isEqual: @"clear-day"]) {
        image = [UIImage imageNamed:@"clear-day"];
        
    } else if ([self.forecast  isEqual: @"clear-night"]){
        image = [UIImage imageNamed:@"clear-night"];
        
    } else if ([self.forecast  isEqual: @"rain"]){
        image = [UIImage imageNamed:@"rain"];
        
    } else if ([self.forecast  isEqual: @"snow"]){
        image = [UIImage imageNamed:@"snow"];
        
    } else if ([self.forecast  isEqual: @"sleet"]){
        image = [UIImage imageNamed:@"sleet"];
        
    } else if ([self.forecast  isEqual: @"wind"]){
        image = [UIImage imageNamed:@"wind"];
        
    } else if ([self.forecast  isEqual: @"fog"]){
        image = [UIImage imageNamed:@"fog"];

    } else if ([self.forecast  isEqual: @"partly-cloudy-day"]){
        image = [UIImage imageNamed:@"partly-cloudy-day"];
        
    } else if ([self.forecast  isEqual: @"cloudy"]){
        image = [UIImage imageNamed:@"cloudy"];
        
    } else if ([self.forecast  isEqual: @"partly-cloudy-night"]){
        image = [UIImage imageNamed:@"partly-cloudy-night"];
    } else {
        image = [UIImage imageNamed:@"unknown-weather"];
    }

    return image;

}


/**
* Helper method to convert from US Fahrenheit to degrees Celcius
*/
- (int)convertToCelsius {
    float celsius;
    celsius = (self.temperatureF - 32) / 1.8;
    int celciusInt = @(celsius).intValue;

    return celciusInt;
}


@end
