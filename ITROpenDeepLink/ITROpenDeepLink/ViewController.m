//
//  ViewController.m
//  ITROpenDeepLink
//
//  Created by kirthi on 03/09/15.
//  Copyright © 2015 ITechRoof. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)openMain:(id)sender{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"deepLink://link/main"]];
}

- (IBAction)openPage1:(id)sender{
 
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"deepLink://link/page1"]];
}

- (IBAction)openPage2:(id)sender{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"deepLink://link/page2"]];
}

@end
