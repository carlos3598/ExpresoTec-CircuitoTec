//
//  valle1ViewController.m
//  myapp
//
//  Created by Carlos Salazar on 3/23/15.
//  Copyright (c) 2015 Carlos Salazar. All rights reserved.
//

#import "RutasViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <Firebase/Firebase.h>
#import <MapKit/MapKit.h>

@import CoreLocation;



@interface RutasViewController ()


@end
@implementation RutasViewController {
    GMSMapView *mapView_;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
        self.view = mapView_;
    NSString *ruta = [self.detailItem description];
    ruta = [ruta lowercaseString];
    ruta = [ruta stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@", ruta);
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
        
    }

    
    // Position the map so that all overlays and annotations are visible on screen.
    

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

    // Do any additional setup after loading the view.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:25.649998
                                                            longitude:-100.289899
                                                                 zoom:11];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    mapView_.settings.myLocationButton = YES;

    NSString *pathKml = [[NSBundle mainBundle] pathForResource:ruta ofType:@"kml"];
    NSURL *url = [NSURL fileURLWithPath:pathKml];
    kmlParser = [[KMLParser alloc] initWithURL:url];
    [kmlParser parseKML];
    
    NSArray *overlays = [kmlParser overlays];
    MKPolyline *linea = overlays[0];
    
    NSArray *annotations = [kmlParser points];

    GMSMutablePath *path = [GMSMutablePath path];
    
    for (unsigned long i=0; i < linea.pointCount; i++) {
        MKMapPoint *coordenadas = &linea.points[i];
        [path addLatitude:MKCoordinateForMapPoint(*coordenadas).latitude longitude:MKCoordinateForMapPoint(*coordenadas).longitude];
    }
    
    for (id <MKAnnotation> annotation in annotations) {
        GMSMarker *marker = [[GMSMarker alloc]init];
        marker.position = annotation.coordinate;
        marker.title = annotation.title;
        marker.map = mapView_;
    }
    
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.strokeColor = [UIColor blueColor];
    polyline.strokeWidth = 5.f;
    polyline.map = mapView_;
    NSLog(@"User's location: %@", mapView_.myLocation);
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
