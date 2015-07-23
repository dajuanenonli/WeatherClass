//
//  FetchWeatherData.m
//  WeatherClass
//
//  Created by Student on 7/23/15.
//  Copyright (c) 2015 Student_Ralph. All rights reserved.
//

#import "WeatherData.h"
#import "AFNetworking.h"
#import "CurrentCondition.h"
#import "Constants.h"

@interface NSObject()

@property (nonatomic, retain) CurrentCondition *currentCondition;

@end


@implementation WeatherData



- (void)fetch
{
    // Do any additional setup after loading the view, typically from a nib.
    
    // 1
    NSString *string = [NSString stringWithFormat:@"%@weather.php?format=json", BaseURLString];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 3
        NSDictionary *data = [(NSDictionary *)responseObject objectForKey:@"data"];
        
        NSDictionary *currentData = [[data objectForKey:@"current_condition"] objectAtIndex:0];
        
        //self.cloudCover = [currentCondition[@"cloudCover"] intValue];
        
        //self.currentCondition = [[CurrentCondition alloc] init];
        
        /*for (int i=0; i < currentData.count; i++) {
            
        }*/
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        self.currentCondition.cloudCover = [numberFormatter numberFromString:[self extractValue:[currentData valueForKey:@"cloudcover"]]];
        
        
        
        //self.currentCondition.cloudCover = [NSNumber numberWithInteger:(int)[self extractValue:[currentData valueForKey:@"cloudcover"]]];
        
        //self.title = @"JSON Retrieved";
        //[self.tableView reloadData];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //return nil;
        // 4
        /*UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];*/
    }];
    
    // 5
    [operation start];
}

-(NSString *) extractValue:(id)jsonValue
{
    if([jsonValue isKindOfClass:[NSString class]])
    {
        return (NSString *) jsonValue;
    }
    else
    {
        //if value is array, loop through the value
        NSArray *arrayValue = (NSArray *) jsonValue;
        NSMutableString *concatenatedString = [NSMutableString string];
        for (int i = 0; i<arrayValue.count; i++) {
            [concatenatedString appendString:[[arrayValue objectAtIndex:i] valueForKey:@"value"]];
            if(i + 1 < arrayValue.count)
            {
                [concatenatedString appendString:@", "];
            }
        }
        return  concatenatedString;
    }
    return @"";
}

@end
