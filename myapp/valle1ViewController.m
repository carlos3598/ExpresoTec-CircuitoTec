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
#import <MapKit/MapKit.h>

@import CoreLocation;



@interface valle1ViewController ()


@end
@implementation valle1ViewController {
    GMSMapView *mapView_;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    // Position the map so that all overlays and annotations are visible on screen.
    

    //Mi codigo
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
    mapView_.settings.myLocationButton = YES;

    // Creates a marker in the center of the map.
    /*
    GMSMutablePath *path = [GMSMutablePath path];
    
    // Parque
    GMSMarker *Parque = [[GMSMarker alloc] init];
    Parque.position = CLLocationCoordinate2DMake(25.65291946689985, -100.3884086046549);
    Parque.title = @"Parque";
    Parque.map = mapView_;
    [path addLatitude:25.65291946689985 longitude:-100.3884086046549];
    
    // Rio Sena
    GMSMarker *rioSena = [[GMSMarker alloc] init];
    rioSena.position = CLLocationCoordinate2DMake(25.65634079068095, -100.3841459511093);
    rioSena.title = @"Río Sena";
    rioSena.map = mapView_;
    [path addLatitude:25.65634079068095 longitude:-100.3841459511093];
    
    // Rio Mississipi
    GMSMarker *rioMississipi = [[GMSMarker alloc] init];
    rioMississipi.position = CLLocationCoordinate2DMake(25.66292821423032,-100.3807370841317);
    rioMississipi.title = @"Río Mississipi";
    rioMississipi.map = mapView_;
    [path addLatitude:25.66292821423032 longitude:-100.3807370841317];
    
    // Río Amazonas (Farmacias del Ahorro)
    GMSMarker *rioAmazonasFA = [[GMSMarker alloc] init];
    rioAmazonasFA.position = CLLocationCoordinate2DMake(25.66558460797741,-100.3797229080173);
    rioAmazonasFA.title = @"Río Amazonas (Farmacias del Ahorro)";
    rioAmazonasFA.map = mapView_;
    [path addLatitude:25.66558460797741 longitude:-100.3797229080173];
    
    // Río Amazonas (Farmcia Benavides)
    GMSMarker *rioAmazonasFB = [[GMSMarker alloc] init];
    rioAmazonasFB.position = CLLocationCoordinate2DMake(25.65862424651492,-100.3558750331652);
    rioAmazonasFB.title = @"Río Amazonas (Farmcia Benavides)";
    rioAmazonasFB.map = mapView_;
    [path addLatitude:25.65862424651492 longitude:-100.3558750331652];
    
    // Av. Vasconcelos (Sierra Madre)
    GMSMarker *vasconcelos = [[GMSMarker alloc] init];
    vasconcelos.position = CLLocationCoordinate2DMake(25.65302540011142,-100.3563172021508);
    vasconcelos.title = @"Av. Vasconcelos (Sierra Madre)";
    vasconcelos.map = mapView_;
    [path addLatitude:25.65302540011142 longitude:-100.3563172021508];
    
    // Pantepec y Tamuin
    GMSMarker *pantepecTamuin = [[GMSMarker alloc] init];
    pantepecTamuin.position = CLLocationCoordinate2DMake(25.65826615049697,-100.3459325328107);
    pantepecTamuin.title = @"Pantepec y Tamuin";
    pantepecTamuin.map = mapView_;
    [path addLatitude:25.65826615049697 longitude:-100.3459325328107];
    
    // EGAP / EGADE
    GMSMarker *egapEgade = [[GMSMarker alloc] init];
    egapEgade.position = CLLocationCoordinate2DMake(25.64440236620213,-100.3250357857649);
    egapEgade.title = @"EGAP / EGADE";
    egapEgade.map = mapView_;
    [path addLatitude:25.64440236620213 longitude:-100.3250357857649];
    
    // Tecnológico de Monterrey, Campus Monterrey
    GMSMarker *tec = [[GMSMarker alloc] init];
    tec.position = CLLocationCoordinate2DMake(25.65299133272366,-100.2879344522716);
    tec.title = @"Tecnológico de Monterrey, Campus Monterrey";
    tec.map = mapView_;
    [path addLatitude:25.65299133272366 longitude:-100.2879344522716];
    
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.strokeColor = [UIColor blueColor];
    polyline.strokeWidth = 5.f;
    polyline.map = mapView_;
    NSLog(@"User's location: %@", mapView_.myLocation);
    self.view = mapView_;
    
    MKDirectionsRequest *location = [[MKDirections alloc]init];
    */
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
