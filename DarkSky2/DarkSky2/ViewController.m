//
//  ViewController.m
//  DarkSky2
//
//  Created by Angus Johnston on 28/11/2015.
//  Copyright © 2015 Angus Johnston. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "Weather.h"
#import "WeatherApi.h"

@interface ViewController ()
@end


@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

    self.apiController = [[WeatherApi alloc] init];
	
	//set the delegate
    self.apiController.delegate = self;
        
    //start location services so we can get geo position
    [self enableLocationServices];
}


/**
* This delegate method is invoked from the delegate, once the data (or error) has been returned via DarkSky API 
*/
-(void) didFinishWeatherApiSearch:(double)temperatureF
                  forecast:(NSString *)forecast
                  city:(NSString *)city
                  weatherApiError:(NSString *)weatherApiError
                  theWholeShibang:(NSString *)theWholeShibang {

    //create strongly typed object "Weather"
    Weather *theWeather = [[Weather alloc] initWithData:temperatureF forecast:forecast timezone:city];

    [self updateView:theWeather data:theWholeShibang];
    
}


/**
* Update UI elements
*/
- (void)updateView: (Weather *)weather data:(NSString *)jsonData {

    int celcius = weather.convertToCelsius;
    
    self.activityIndicator.hidden = YES;
    [self.activityIndicator stopAnimating];

    UIImage *image = weather.getImage;

    self.weatherImageView.image = image;
    self.temperatureLabel.text = [NSString stringWithFormat: @"%d ℃", celcius];
    self.forecastLabel.text = [weather prettyText:[weather forecast]];
    self.outputTextView.text = jsonData;

    self.weatherImageView.hidden = NO;
	
	if ([self.forecastLabel.text isEqualToString:@"Unknown weather"]) {
		self.temperatureLabel.hidden = YES;
		self.statusLabel.hidden = YES;
	} else {
		self.temperatureLabel.hidden = NO;
		self.statusLabel.hidden = NO;
	}
	
	
	self.forecastLabel.hidden = NO;

    [UIView animateWithDuration:1 animations:^{
        self.containerView.hidden = YES;
        self.statusLabel.text = @"Ah, there it is. So..objective.";
        self.outputTextView.hidden = NO;
    }];
}

/**
* If an error was returned from the attempted API call, then display it in the view controller "outputTextView"
*/
- (void)displayApiError:(NSString *)weatherApiError {
    //disable ui elements
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self.activityIndicator removeFromSuperview];
        self.statusLabel.hidden = true;
        self.outputTextView.text = @"Error:\n\(weatherApiError)";
        self.outputTextView.hidden = NO;
    
    });
    [self.locationManager stopUpdatingLocation];

}

/**
* This method will invoke core location services so that we can get users geo-location
*/
- (void)enableLocationServices {

	self.locationManager = [[CLLocationManager alloc] init];
	
	// Ask for Authorisation from the User.
	[self.locationManager requestAlwaysAuthorization];

	//enable location services, or not.
	if ([CLLocationManager locationServicesEnabled])
	{
		self.locationManager.delegate = self;
		[self.locationManager setDistanceFilter:kCLDistanceFilterNone];
		[self.locationManager setHeadingFilter:kCLHeadingFilterNone];
		[self.locationManager startUpdatingLocation];
	} else {
		NSLog(@"Location service disabled");
	}
}

#pragma mark - 🔌 CLLocationManagerDelegate Method

/**
* The delegate & associated method that is called, so we can retrieve users geo-location coordinates
**/
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{

	//get current location
	CLLocationCoordinate2D location = manager.location.coordinate;
	
	self.locationLatitude = location.latitude;
	self.locationLongtitude = location.longitude;

	//call dark sky weather api
	if (self.locationLatitude && self.locationLongtitude) {
        [self.apiController searchWeatherApi:self.locationLatitude :self.locationLongtitude];
    }

}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
