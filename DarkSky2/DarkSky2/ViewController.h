//
//  ViewController.h
//  DarkSky2
//
//  Created by Angus Johnston on 28/11/2015.
//  Copyright © 2015 Angus Johnston. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Weather.h"
#import "WeatherApi.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate, WeatherApiControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *forecastLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITextView *outputTextView;

//CoreLocation vars
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@property double locationLatitude;
@property double locationLongtitude;

@property (strong, nonatomic) WeatherApi *apiController;

-(void) didFinishWeatherApiSearch:(double)temperatureF
						 forecast:(NSString *)forecast
							 city:(NSString *)city
				  weatherApiError:(NSString *)weatherApiError
				  theWholeShibang:(NSString *)theWholeShibang;

- (void)enableLocationServices;
- (void)displayApiError:(NSString *)weatherApiError;
- (void)updateView:(Weather *)weather data:(NSString *)jsonData;


@end



