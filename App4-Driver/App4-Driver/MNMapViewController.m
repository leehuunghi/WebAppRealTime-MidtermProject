//
//  MapViewController.m
//  App4-Driver
//
//  Created by LeHuuNghi on 11/12/18.
//  Copyright © 2018 LeHuuNghi. All rights reserved.
//

#import "MNMapViewController.h"

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
    
    NMAGeoCoordinates *coor = [[NMAGeoCoordinates alloc] initWithLatitude:52.500556 longitude:13.398889];
    NMAMapMarker *mapCircle = [[NMAMapMarker alloc] initWithGeoCoordinates:coor];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"location" ofType:@"png"];
    
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
    mapCircle.icon = image;
    [self.mapView addMapObject:mapCircle];
    [self.mapView setGeoCenter:coor];

    
//    // Subscribe to position updates
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(didUpdatePosition)
//                                                 name:NMAPositioningManagerDidUpdatePositionNotification
//                                               object:[NMAPositioningManager sharedPositioningManager]];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLosePosition) name:NMAPositioningManagerDidLosePositionNotification object:[NMAPositioningManager sharedPositioningManager]];
//
//    // Set position indicator visible. Also starts position updates.
//    self.mapView.positionIndicator.visible = YES;
}

- (void)didUpdatePosition {
    // Update position indicator position.
    [[NMAPositioningManager sharedPositioningManager] stopPositioning];
    _myGeoCoorLocation = [[NMAPositioningManager sharedPositioningManager] currentPosition].coordinates;
    
    [_mapView setGeoCenter:_myGeoCoorLocation
                     withAnimation:NMAMapAnimationLinear];
}

- (void)didLosePosition {
    NMAMapMarker *marker = [[NMAMapMarker alloc] initWithGeoCoordinates:_myGeoCoorLocation];
    
    [NMAMapView shouldBeginRenderingAutomatically:YES];
    
    [self.mapView addMapObject:marker];
}

//- (void)didUpdatePosition {
//    __weak typeof(self)weakSelf = self;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [[NMAPositioningManager sharedPositioningManager] stopPositioning];
//
//        // Update position indicator position.
//        NMAGeoPosition *position = [[NMAPositioningManager sharedPositioningManager] currentPosition];
//
//        [weakSelf.mapView setGeoCenter:position.coordinates
//                 withAnimation:NMAMapAnimationLinear];
//        if (weakSelf.myLocation) [weakSelf.mapView removeMapObject:weakSelf.myLocation];
//        if (weakSelf.mapView) {
//            weakSelf.myLocation = [[NMAMapMarker alloc] initWithGeoCoordinates:position.coordinates];
//            [weakSelf.mapView addMapObject:weakSelf.myLocation];
//        }
//    });
//}

@end
