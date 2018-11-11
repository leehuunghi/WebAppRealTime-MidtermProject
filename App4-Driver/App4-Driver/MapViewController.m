//
//  MapViewController.m
//  App4-Driver
//
//  Created by LeHuuNghi on 11/12/18.
//  Copyright © 2018 LeHuuNghi. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet NMAMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NMAGeoCoordinates *geoCoordCenter =
    [[NMAGeoCoordinates alloc] initWithLatitude:49.260327 longitude:-123.115025];
    [self.mapView setGeoCenter:geoCoordCenter withAnimation:NMAMapAnimationNone];
    self.mapView.copyrightLogoPosition = NMALayoutPositionBottomCenter;
    
    //set zoom level
    self.mapView.zoomLevel = 13.2;
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
