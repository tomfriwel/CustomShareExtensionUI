//
//  SharePresentationController.m
//  CustomShareExtensionUI
//
//  Created by tomfriwel on 26/05/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#define Controller_W 250.0
#define Controller_H 400.0

#import "SharePresentationController.h"

@interface SharePresentationController()

@property (strong, nonatomic) UIView *bgView;

@end

@implementation SharePresentationController

#pragma mark - override

- (void)presentationTransitionWillBegin{
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.containerView addSubview:self.bgView];
    
    [self.bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContainerAction)]];
}

- (BOOL)shouldRemovePresentersView{
    return NO;
}

// frame of controller
- (CGRect)frameOfPresentedViewInContainerView{
    CGRect frame = self.containerView.bounds;
    CGFloat W = frame.size.width;
    CGFloat H = frame.size.height;
    CGFloat w = Controller_W;
    CGFloat h = Controller_H;
    
    return CGRectMake((W-w)/2.0, (H-h)/2.0, w, h);
}

- (UIView *)presentedView{
    UIView *pretedView = self.presentedViewController.view;
    pretedView.clipsToBounds = YES;
    pretedView.layer.cornerRadius = 8.0f;
    
    return pretedView;
}

#pragma mark - action

-(void)tapContainerAction {
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    if (self.tapContainerBlcok) {
        self.tapContainerBlcok();
    }
}

@end
