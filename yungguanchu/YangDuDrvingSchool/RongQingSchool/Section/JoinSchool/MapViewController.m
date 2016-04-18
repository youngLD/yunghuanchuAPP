//
//  MapViewController.m
//  RongQingSchool
//
//  Created by caitong on 15/9/8.
//  Copyright (c) 2015年 荣庆通达驾校. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
-(id)init{
    self = [super init];
    self.hidesBottomBarWhenPushed = YES;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"地图";
    self.navigationItem.leftBarButtonItems = [self.navigationController getNewBackButtons];
    
    // 标注地图类型
    _mapView.mapType = MKMapTypeStandard ;
    //用于将当前视图控制器赋值给地图视图的delegate属性
    _mapView.delegate = self ;
    
    [self geocodeQuery:nil];
}

#pragma mark - 查询按钮触发动作
- (void)geocodeQuery:(id)sender {
    
    if (self.address == nil || [self.address length] == 0) {
        return ;
    }
    
    CLGeocoder *geocode = [[CLGeocoder alloc] init];
    
    [geocode geocodeAddressString:self.address completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"查询记录数: %lu",(unsigned long)[placemarks count]);
        
        if ([placemarks count ] > 0) {
            //移除目前地图上得所有标注点
            [_mapView removeAnnotations:_mapView.annotations];
            
        }
        
        for (int i = 0; i< [placemarks count]; i++) {
            CLPlacemark * placemark = placemarks[i];
            
            //调整地图位置和缩放比例,第一个参数是目标区域的中心点，第二个参数：目标区域南北的跨度，第三个参数：目标区域的东西跨度，单位都是米
            MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(placemark.location.coordinate, 10000, 10000);
            
            //重新设置地图视图的显示区域
            [_mapView setRegion:viewRegion animated:YES];
            // 实例化 MapLocation 对象
            
            MapLocation * annotation = [[MapLocation alloc] init];
            annotation.streetAddress = placemark.thoroughfare ;
            annotation.city = placemark.locality;
            annotation.state = placemark.administrativeArea ;
            annotation.zip = placemark.postalCode;
            annotation.coordinate = placemark.location.coordinate;
            
            //把标注点MapLocation 对象添加到地图视图上，一旦该方法被调用，地图视图委托方法mapView：ViewForAnnotation:就会被回调
            [_mapView addAnnotation:annotation];
            
        }
        
        
    }];
    
}

#pragma mark mapView Delegate 地图 添加标注时 回调
- (MKAnnotationView *) mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>) annotation {
    // 获得地图标注对象
    MKPinAnnotationView * annotationView = (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:@"PIN_ANNOTATION"];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PIN_ANNOTATION"];
    }
    // 设置大头针标注视图为紫色
    annotationView.pinColor = MKPinAnnotationColorPurple ;
    // 标注地图时 是否以动画的效果形式显示在地图上
    annotationView.animatesDrop = YES ;
    // 用于标注点上的一些附加信息
    annotationView.canShowCallout = YES ;
    
    return annotationView;
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    _mapView.centerCoordinate = userLocation.location.coordinate;
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)theMapView withError:(NSError *)error {
    NSLog(@"error : %@",[error description]);
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
