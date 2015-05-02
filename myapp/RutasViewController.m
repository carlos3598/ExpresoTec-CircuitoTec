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
    NSArray *annotations;
    NSArray *markers;
    BOOL bImagen;
    GMSMutablePath *path;
    NSString *rutaOrig;
    NSString *path1;
    NSMutableArray *windowsArray;
    NSMutableDictionary *data;
    NSArray *paths;
    NSString *documentsDirectory;
    NSString *pathP;
    NSInteger index;
    Firebase *firebase;
}

-(IBAction)addFavorite:(UIButton *)sender{
    if(!bImagen) {
        [sender setImage:[UIImage imageNamed:@"Star Filled-25.png"] forState:UIControlStateNormal];
    
        NSLog(@"windows: %@", windowsArray);
        [windowsArray addObject:rutaOrig];
        NSLog(@"windows after add: %@", windowsArray);
        [windowsArray writeToFile:path1 atomically:YES];
    }
    else{
        [windowsArray removeObject:rutaOrig];
         NSLog(@"windows after remove: %@", windowsArray);
        [sender setImage:[UIImage imageNamed:@"Star-25.png"] forState:UIControlStateNormal];
        [windowsArray writeToFile:path1 atomically:YES];
        bImagen = !bImagen;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    path1 = [[NSBundle mainBundle] pathForResource:@"favoritos" ofType:@"plist"];
    windowsArray =[[NSMutableArray alloc] initWithContentsOfFile:path1];
    NSString *ruta = self.detailItem;
    bImagen = [windowsArray containsObject:ruta];
    //index = [windowsArray   indexOfObject:ruta];
    self.view = mapView_;
   
    rutaOrig = ruta;
    self.tabBarController.navigationItem.title = ruta;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0.0f, 0.0f, 25.0f, 40.0f)];
    [btn addTarget:self action:@selector(addFavorite:) forControlEvents:UIControlEventTouchUpInside];
    
    if(bImagen)
        [btn setImage:[UIImage imageNamed:@"Star Filled-25.png"] forState:UIControlStateNormal];
    else
        [btn setImage:[UIImage imageNamed:@"Star-25.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.tabBarController.navigationItem.rightBarButtonItem = btnItem;
   
    ruta = [ruta lowercaseString];
    ruta = [ruta stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
        
        
    
    }
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:25.649998
                                                            longitude:-100.289899
                                                                 zoom:14];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    mapView_.settings.myLocationButton = YES;
    
    
  
    GMSMarker *camion = [[GMSMarker alloc] init];
    firebase= [[Firebase alloc] initWithUrl:@"https://rutastec.firebaseio.com/"];
    
    [firebase observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        Boolean server = [snapshot hasChild:rutaOrig];
        if (server) {

            firebase = [firebase childByAppendingPath:rutaOrig];
            
            [firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
                
                double latitud,longitud;
                
                latitud = [snapshot.value[@"latitude"] doubleValue];
                longitud = [snapshot.value[@"longitude"] doubleValue];
                
                NSString *log = [NSString stringWithFormat:@" latitude -%@ longitud-- %@"  , snapshot.value[@"latitude"],snapshot.value[@"longitude"]];
                NSLog(@"%@",log);
                
                camion.position = CLLocationCoordinate2DMake(latitud, longitud);
                camion.title = @"Camion";
                camion.map = mapView_;
                
            }];
        }
    }];

    
    // Do any additional setup after loading the view.
    
    
    
    NSString *pathKml = [[NSBundle mainBundle] pathForResource:ruta ofType:@"kml"];
    NSURL *url = [NSURL fileURLWithPath:pathKml];
    kmlParser = [[KMLParser alloc] initWithURL:url];
    [kmlParser parseKML];
    
    
    NSArray *overlays = [kmlParser overlays];
    MKPolyline *linea = overlays[0];
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:0.5f];
    
    path = [GMSMutablePath path];
    for (unsigned long i=0; i < linea.pointCount; i++) {
        MKMapPoint *coordenadas = &linea.points[i];
        [path addLatitude:MKCoordinateForMapPoint(*coordenadas).latitude longitude:MKCoordinateForMapPoint(*coordenadas).longitude];
    }
    
    annotations = [kmlParser points];
    NSInteger i = 0;
    for ( id <MKAnnotation> annotation in annotations) {
        NSString *imagen;
        if(i< [annotations count]-1){
            imagen = [NSString stringWithFormat:@"icon-%ld", (long)i];
        }
        if(i == [annotations count]-1){
            imagen = @"icon-tec";
        }
            GMSMarker *marker = [[GMSMarker alloc]init];
            marker.position = annotation.coordinate;
            marker.title = annotation.title;
            marker.icon = [UIImage imageNamed:imagen];
            marker.map = mapView_;
            i++;
    }
    
    
    
    if([ruta rangeOfString:@"noche"].location == NSNotFound){
        
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        polyline.strokeColor = color;
        polyline.strokeWidth = 3.0f;
        polyline.map = mapView_;

    }
    else {
        
        GMSPolygon *polygon= [GMSPolygon polygonWithPath:path];
        polygon.fillColor =color;
        polygon.strokeColor = color;
        polygon.map = mapView_;
    }
    
}
-(void) showAllMarkers{
    
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithPath:path];
    [mapView_ animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:30.0f]];
}

-(void) viewDidAppear:(BOOL)animated {
    
    [self showAllMarkers];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidDisappear:(BOOL)animated {

    [super viewDidDisappear:YES];
    [firebase removeAllObservers];
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
