//
//  ViewController.m
//  CustomShareExtensionUI
//
//  Created by tomfriwel on 24/05/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = self.view.bounds;
    gradient.colors = @[(id)[UIColor colorWithRed:0.59 green:0.87 blue:0.99 alpha:1.00].CGColor, (id)[UIColor colorWithRed:0.33 green:0.84 blue:0.41 alpha:1.00].CGColor];
    
    [self.view.layer insertSublayer:gradient atIndex:0];
}

- (IBAction)showShareAction:(id)sender {
    NSURL *url = [NSURL URLWithString:@"https://github.com"];
    
    NSArray *activity = @[];
    NSArray *activityItems = @[url];
    
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:activity];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}


@end
