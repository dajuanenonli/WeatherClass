//
//  ViewController.m
//  WeatherClass
//
//  Created by Student on 7/22/15.
//  Copyright (c) 2015 Student_Ralph. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "CurrentCondition.h"
#import "WeatherData.h"


//http://www.vikingcomputerconsulting.com/weather_sample/weather.php?format=json

@interface ViewController ()

@property (nonatomic, strong) NSDictionary *weather;
@property (nonatomic, strong) NSDictionary *currentCondition;
@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, retain) CurrentCondition *todaysCondition;
@property (nonatomic, retain) WeatherData *weatherData;

@end

@implementation ViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   
    self.weatherData = [[WeatherData alloc] init];
    [self.weatherData fetch];
    //self.weatherData.currentCondition
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark table view stuff
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.currentCondition.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SimpleTableIdentifier];        
    }
    if(self.currentCondition != nil)
    {
        NSArray *keyArray = [self.currentCondition allKeys];
        
        NSString *key = [keyArray objectAtIndex:indexPath.row];
        
        if([[self.currentCondition valueForKey:key] isKindOfClass:[NSString class]])
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", key, [self.currentCondition valueForKey:key]];        }
        else
        {
            //if value is array, loop through the value
            NSArray *arrayValue = [self.currentCondition valueForKey:key];
            NSMutableString *concatenatedString = [NSMutableString string];
            for (int i = 0; i<arrayValue.count; i++) {
                [concatenatedString appendString:[[arrayValue objectAtIndex:i] valueForKey:@"value"]];
                if(i + 1 < arrayValue.count)
                {
                    [concatenatedString appendString:@", "];
                }
            }
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", key, concatenatedString];

        }
        
        
    }
    

    return cell;
}

#pragma mark AFNetworking methods
//- (IBAction)jsonTapped:(id)sender
//{
    
//}
@end
