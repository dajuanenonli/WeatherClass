//
//  ViewController.m
//  WeatherClass
//
//  Created by Student on 7/22/15.
//  Copyright (c) 2015 Student_Ralph. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

static NSString * const BaseURLString = @"http://www.vikingcomputerconsulting.com/weather_sample/";
//http://www.vikingcomputerconsulting.com/weather_sample/weather.php?format=json

@interface ViewController ()

@property (nonatomic, strong) NSDictionary *weather;
@property (nonatomic, strong) NSDictionary *currentCondition;
@property (nonatomic, strong) NSDictionary *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
        self.weather = (NSDictionary *)responseObject;
        self.data = [self.weather objectForKey:@"data"];
    
        self.currentCondition = [[self.data objectForKey:@"current_condition"] objectAtIndex:0];
        
        self.title = @"JSON Retrieved";
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    // 5
    [operation start];
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
