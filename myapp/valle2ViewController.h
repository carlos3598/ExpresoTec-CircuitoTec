//
//  valle2ViewController.h
//  myapp
//
//  Created by Carlos Salazar on 4/6/15.
//  Copyright (c) 2015 Carlos Salazar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


#import "KMLParser.h"

@interface valle2ViewController : UIViewController{
    IBOutlet MKMapView *map;
    KMLParser *kmlParser;
}
@property(nonatomic,strong) CLLocationManager *locationManager;

@end
