//
//  MapViewController.m
//  LocalTest
//
//  Created by Huahan on 4/7/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "MapViewController.h"
@import MapKit;

@interface MapViewController ()
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (void)initilizeLocationTracking
{
    _locationManager = [[CLLocationManager alloc] init];
    assert(self.locationManager);
    
    self.locationManager.delegate = self;
    // We use -respondsToSelector: to only call the new authorization API on systems that support it.
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.locationManager requestWhenInUseAuthorization];
        
        // note: doing so will provide the blue status bar indicating iOS
        // will be tracking your location, when this sample is backgrounded
    }
    
    NSString * const LocationTrackingAccuracyPrefsKey;
    
    self.locationManager.desiredAccuracy =
    [[NSUserDefaults standardUserDefaults] doubleForKey:LocationTrackingAccuracyPrefsKey];
    
    // start tracking the user's location
    [self.locationManager startUpdatingLocation];
    
    // Observe the application going in and out of the background, so we can toggle location tracking.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleUIApplicationDidEnterBackgroundNotification:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleUIApplicationWillEnterForegroundNotification:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
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
