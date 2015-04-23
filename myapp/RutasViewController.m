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
    NSString *ruta = self.detailItem;
    self.tabBarController.title = ruta;
    ruta = [ruta lowercaseString];
    //NSLog(@"Ruta %@", ruta);
    ruta = [ruta stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
        
       self.parentViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(myRightButton)];
        
    }
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:25.649998
                                                            longitude:-100.289899
                                                                 zoom:11];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    mapView_.settings.myLocationButton = YES;
    
    
    /*
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
    GMSMarker *camion = [[GMSMarker alloc] init];
    Firebase *valle1 = [[Firebase alloc] initWithUrl:@"https://rutastec.firebaseio.com/Ruta"];
    [valle1 observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        double latitud,longitud;
        latitud = [snapshot.value[@"latitude"] doubleValue];
        longitud = [snapshot.value[@"longitude"] doubleValue];
<<<<<<< Updated upstream
        //NSString *log = [NSString stringWithFormat:@" latitude -%@ longitud-- %@"  , snapshot.value[@"latitude"],snapshot.value[@"longitude"]];
        //NSLog(log);
=======
        NSString *log = [NSString stringWithFormat:@" latitude -%@ longitud-- %@"  , snapshot.value[@"latitude"],snapshot.value[@"longitude"]];
        NSLog(@"%@",log);
>>>>>>> Stashed changes
        camion.position = CLLocationCoordinate2DMake(latitud, longitud);
        camion.title = @"Camion";
        camion.map = mapView_;

    }];*/
    
    // Do any additional setup after loading the view.
    
    NSString *pathKml = [[NSBundle mainBundle] pathForResource:ruta ofType:@"kml"];
    NSURL *url = [NSURL fileURLWithPath:pathKml];
    kmlParser = [[KMLParser alloc] initWithURL:url];
    [kmlParser parseKML];
    
    NSArray *overlays = [kmlParser overlays];
    MKPolyline *linea = overlays[0];
    
    GMSMutablePath *path = [GMSMutablePath path];
    for (unsigned long i=0; i < linea.pointCount; i++) {
        MKMapPoint *coordenadas = &linea.points[i];
        [path addLatitude:MKCoordinateForMapPoint(*coordenadas).latitude longitude:MKCoordinateForMapPoint(*coordenadas).longitude];
    }
    
    
    
    
    
    NSArray *annotations = [kmlParser points];
    
    for (id <MKAnnotation> annotation in annotations) {
        GMSMarker *marker = [[GMSMarker alloc]init];
        marker.position = annotation.coordinate;
        marker.title = annotation.title;
        marker.map = mapView_;
    }
    
    if([ruta rangeOfString:@"noche"].location == NSNotFound){
        
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        polyline.strokeColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:.5];
        polyline.strokeWidth = 3.f;
        polyline.map = mapView_;
        NSLog(@"User's location: %@", mapView_.myLocation);

    }
    else {
        GMSPolygon *polygon = [GMSPolygon polygonWithPath:path];
        polygon.fillColor =[UIColor colorWithRed:0 green:0 blue:1 alpha:.08];
        polygon.strokeColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
        polygon.map = mapView_;
    }
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
