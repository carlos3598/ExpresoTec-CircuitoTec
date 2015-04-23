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

@interface RutasViewController : UIViewController{
    KMLParser *kmlParser;
}
@property(nonatomic,retain) CLLocationManager *locationManager;
@property (strong, nonatomic) NSString * detailItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *myRightButton;

@end