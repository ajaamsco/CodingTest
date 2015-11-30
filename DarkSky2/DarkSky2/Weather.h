//
//  Weather.h
//  DarkSky2
//
//  Created by Angus Johnston on 29/11/2015.
//  Copyright © 2015 Angus Johnston. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Weather : NSObject
    @property NSString *forecast;
    @property NSString *timezone;
    @property double temperatureF;

    //initialiser
-(id)initWithData:(double)temperatureF forecast:(NSString*)forecast timezone:(NSString*)timezone;

    /**
	* Helper method to provide UI with nicely formatted weather conditions description
	*/
    - (NSString *)prettyText :(NSString *)textToFormat;

    /**
	* Helper method to return a single image, associated with current weather conditions
	*/
    //func getImage() -> UIImage {
    - (UIImage *)getImage;

    /**
	* Helper method to convert from US Fahrenheit to degrees Celcius
	*/
    - (int)convertToCelsius;

@end
