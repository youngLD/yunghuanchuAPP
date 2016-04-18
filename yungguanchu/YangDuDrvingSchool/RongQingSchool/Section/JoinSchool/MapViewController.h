//
//  MapViewController.h
//  RongQingSchool
//
//  Created by caitong on 15/9/8.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapLocation.h"  

@interface MapViewController : UIViewController<MKMapViewDelegate>
@property(strong,nonatomic) NSString *address;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end
