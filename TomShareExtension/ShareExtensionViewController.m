//
//  ShareExtensionViewController.m
//  CustomShareExtensionUI
//
//  Created by tomfriwel on 26/05/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "ShareExtensionViewController.h"

@interface ShareExtensionViewController ()

@end

@implementation ShareExtensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.view.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height);
    [UIView animateWithDuration:0.25 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

- (IBAction)dismissAction:(id)sender {
    [UIView animateWithDuration:0.20 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height);
    } completion:^(BOOL finished) {
        [self.extensionContext completeRequestReturningItems:nil completionHandler:nil];
    }];
}

@end