//
//  MapViewController.m
//  App4-Driver
//
//  Created by LeHuuNghi on 11/12/18.
//  Copyright © 2018 LeHuuNghi. All rights reserved.
//

#import "MNMapViewController.h"
@import SocketIO;

@interface MNMapViewController ()
@property (weak, nonatomic) IBOutlet NMAMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NMAGeoCoordinates *myGeoCoorLocation;
@property (strong, nonatomic) dispatch_queue_t serialQueue;
@end

@implementation MNMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _serialQueue = dispatch_queue_create("com.leehuunghi.serialQueue", DISPATCH_QUEUE_SERIAL);
    
    // Set zoom level
    self.mapView.zoomLevel = NMAMapViewMaximumZoomLevel - 1;

    // Subscribe to position updates
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didUpdatePosition)
                                                 name:NMAPositioningManagerDidUpdatePositionNotification
                                               object:[NMAPositioningManager sharedPositioningManager]];

    // Set position indicator visible. Also starts position updates.
    self.mapView.positionIndicator.visible = YES;
}

- (void)didUpdatePosition {
    // Update position indicator position.
    [[NMAPositioningManager sharedPositioningManager] stopPositioning];
    _myGeoCoorLocation = [[NMAPositioningManager sharedPositioningManager] currentPosition].coordinates;
    
    NMAMapMarker *marker = [[NMAMapMarker alloc] initWithGeoCoordinates:_myGeoCoorLocation];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"location" ofType:@"png"];
    
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];

    UIGraphicsBeginImageContext(CGSizeMake(32, 32));
    [image drawInRect:CGRectMake(0, 0, 32, 32)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    marker.icon = destImage;
    
    [self.mapView addMapObject:marker];
    
    [_mapView setGeoCenter:_myGeoCoorLocation
                     withAnimation:NMAMapAnimationLinear];
}

@end
