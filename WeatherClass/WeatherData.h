//
//  FetchWeatherData.h
//  WeatherClass
//
//  Created by Student on 7/23/15.
//  Copyright (c) 2015 Student_Ralph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CurrentCondition.h"

@interface WeatherData : NSObject
@property (nonatomic, retain) CurrentCondition *currentCondition;

- (void) fetch;
@end
