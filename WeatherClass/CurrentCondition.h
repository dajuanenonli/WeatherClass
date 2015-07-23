//
//  CurrentCondition.h
//  WeatherClass
//
//  Created by Student on 7/23/15.
//  Copyright (c) 2015 Student_Ralph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentCondition : NSObject
@property (nonatomic, retain) NSNumber *cloudCover;
@property (nonatomic, retain) NSNumber *humidity;
@property (nonatomic, retain) NSDate   *observationTime;
@property (nonatomic, retain) NSNumber *precipMM;
@property (nonatomic, retain) NSNumber *pressure;
@property (nonatomic, retain) NSNumber *temp_C;
@property (nonatomic, retain) NSNumber *temp_F;
@property (nonatomic, retain) NSNumber *visibility;
@property (nonatomic, retain) NSNumber *weatherCode;
@property (nonatomic, retain) NSString *weatherDesc;
@property (nonatomic, retain) NSString *weatherIconUrl;
@property (nonatomic, retain) NSString *windDir16Point;
@property (nonatomic, retain) NSNumber *windDirDegree;
@property (nonatomic, retain) NSNumber *windSpeedKPH;
@property (nonatomic, retain) NSNumber *windSpeedMiles;



@end
