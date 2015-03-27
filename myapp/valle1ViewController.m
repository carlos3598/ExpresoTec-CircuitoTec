//
//  valle1ViewController.m
//  myapp
//
//  Created by Carlos Salazar on 3/23/15.
//  Copyright (c) 2015 Carlos Salazar. All rights reserved.
//

#import "valle1ViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <Firebase/Firebase.h>
@import CoreLocation;



@interface valle1ViewController ()


@end
@implementation valle1ViewController {
    GMSMapView *mapView_;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    GMSMarker *camion = [[GMSMarker alloc] init];
    Firebase *valle1 = [[Firebase alloc] initWithUrl:@"https://torrid-fire-4635.firebaseio.com/Valle2"];
    [valle1 observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        double latitud,longitud;
        latitud = [snapshot.value[@"Latitud"] doubleValue];
        longitud = [snapshot.value[@"Longitud"] doubleValue];
        camion.position = CLLocationCoordinate2DMake(latitud, longitud);
        camion.title = @"Camion";
        camion.map = mapView_;

    }];

    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }

    // Do any additional setup after loading the view.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView_;
    mapView_.settings.myLocationButton = YES;
    
    GMSMutablePath *path = [GMSMutablePath path];
    [path addLatitude:-33.866 longitude:151.195]; // Sydney
    GMSMarker *fiji = [[GMSMarker alloc] init];
    fiji.position = CLLocationCoordinate2DMake(-18.142, 178.431);
    fiji.title = @"Fiji";
    fiji.map = mapView_;
    [path addLatitude:-18.142 longitude:178.431]; // Fiji
    
    GMSMarker *hawaii = [[GMSMarker alloc] init];
    hawaii.position = CLLocationCoordinate2DMake(22.291, -158.821);
    hawaii.title = @"Hawaii";
    hawaii.map = mapView_;
    [path addLatitude:21.291 longitude:-157.821]; // Hawaii
    
    GMSMarker *MontaunView = [[GMSMarker alloc] init];
    MontaunView.position = CLLocationCoordinate2DMake(37.423, -122.091);
    MontaunView.title = @"Montaun View";
    MontaunView.map = mapView_;
    [path addLatitude:37.423 longitude:-122.091]; // Mountain View
    
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.strokeColor = [UIColor blueColor];
    polyline.strokeWidth = 5.f;
    polyline.map = mapView_;
    NSLog(@"User's location: %@", mapView_.myLocation);
    self.view = mapView_;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
