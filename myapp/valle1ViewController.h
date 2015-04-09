//
//  valle1ViewController.h
//  myapp
//
//  Created by Carlos Salazar on 3/23/15.
//  Copyright (c) 2015 Carlos Salazar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMLParser.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface valle1ViewController : UIViewController{
    KMLParser *kmlParser;
}
@property(nonatomic,retain) CLLocationManager *locationManager;
@end