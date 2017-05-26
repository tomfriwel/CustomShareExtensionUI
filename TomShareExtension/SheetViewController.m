//
//  SheetViewController.m
//  CustomShareExtensionUI
//
//  Created by tomfriwel on 26/05/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "SheetViewController.h"

@interface SheetViewController ()

@end

@implementation SheetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.cancelBlcok) {
        self.cancelBlcok();
    }
}

- (IBAction)doneAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.doneBlcok) {
        self.doneBlcok();
    }
}

@end
