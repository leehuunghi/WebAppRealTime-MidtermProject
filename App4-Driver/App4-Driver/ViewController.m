//
//  ViewController.m
//  App4-Driver
//
//  Created by LeHuuNghi on 11/11/18.
//  Copyright © 2018 LeHuuNghi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.99 blue:1 alpha:1];
    
    NSURL* url = [NSURL URLWithString:@"http://172.16.1.32:3000/api/employee/login"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    request.HTTPMethod = @"POST";
    
    NSDictionary *dictionary = @{@"username":@"a",
                                 @"password":@"b",
                                 @"role":@"driver"
                                 };
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:nil];
    [request setHTTPBody:data];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error: %@", error);
        } else {
            NSDictionary *forJSONObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            if ([forJSONObject valueForKey:@"auth"] == NO) {
                NSLog(@"No authencation!");
            }
        }
    }];
    
    [dataTask resume];

}


@end
