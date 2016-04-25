//
//  LocationTool.m
//  JWLocationDemo
//
//  Created by ZMJ on 16/4/23.
//  Copyright © 2016年 LJW. All rights reserved.
//

#import "LocationTool.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationTool()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *manager;


@end

@implementation LocationTool

- (CLLocationManager *)manager
{
    if (_manager == nil) {
        _manager = [[CLLocationManager alloc]init];
    }

    return _manager;
    
}

- (void)startLocationWithBlock:(LocationBlock)returnBlock
{
    self.locationBlock = returnBlock;
    
    if (![CLLocationManager locationServicesEnabled]) return;
           // NSLog(@"定位服务当前可能尚未打开，请设置打开！");
     if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        [self.manager requestWhenInUseAuthorization];
     }
    
    //设置代理
    self.manager.delegate=self;
    //设置定位精度
    self.manager.desiredAccuracy=kCLLocationAccuracyBest;
    self.manager.distanceFilter = 1000.0;
    //启动跟踪定位
    
    [self.manager startUpdatingLocation];
    
    
   // NSLog(@"startLocationWithBlock");

}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
   // NSLog(@"didUpdateLocations");
    NSLog(@"location is --->%@",locations[0]);
    CLLocation *location = locations[0];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error is-->%@",error.description);
            return;
        }
        else
        {
            CLPlacemark *placeMark = placemarks[0];
           // NSLog(@"name is--->%@---%@,",placeMark.name, placeMark.locality);
            if (self.locationBlock) {
                self.locationBlock(placeMark.locality);
            }
            
            
        }
    }];
   // [self.manager stopUpdatingLocation];
    
    // NSLog(@"didUpdateLocations");
    
}

@end
