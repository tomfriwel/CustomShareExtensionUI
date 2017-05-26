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
    // Do any additional setup after loading the view, typically from a nib.
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
