//
//  ShareExtensionViewController.m
//  CustomShareExtensionUI
//
//  Created by tomfriwel on 26/05/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "ShareExtensionViewController.h"
#import "SheetViewController.h"
#import "SharePresentationController.h"

@interface ShareExtensionViewController () <UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) UIVisualEffectView *blurView;

@end

@implementation ShareExtensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareBackgroundView];
    //    [self addSheetView];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAction:)]];

    SheetViewController *vc = [[UIStoryboard storyboardWithName:@"MainInterface" bundle:nil] instantiateViewControllerWithIdentifier:@"SheetViewController"];
    
    __weak typeof(self) weakSelf = self;
    [vc setCancelBlcok:^{
        [weakSelf dismissAction:nil];
    }];
    [vc setDoneBlcok:^{
        [weakSelf dismissAction:nil];
    }];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    nav.transitioningDelegate = self;
    nav.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:nav animated:YES completion:nil];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self dealData];
//    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    self.view.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height);
    self.blurView.alpha = 0;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear  animations:^{
//        self.view.transform = CGAffineTransformIdentity;
        self.blurView.alpha = 1;
    } completion:nil];
}

- (IBAction)dismissAction:(id)sender {
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear  animations:^{
        self.blurView.alpha = 0;
//        self.view.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height);
    } completion:^(BOOL finished) {
        [self.extensionContext completeRequestReturningItems:nil completionHandler:nil];
    }];
}

#pragma mark - 

-(void)dealData {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __block BOOL hasExistsUrl = NO;
        static NSString *identifier = @"public.data";
        [self.extensionContext.inputItems enumerateObjectsUsingBlock:^(NSExtensionItem * _Nonnull extItem, NSUInteger idx, BOOL * _Nonnull stop) {
            [extItem.attachments enumerateObjectsUsingBlock:^(NSItemProvider * _Nonnull itemProvider, NSUInteger idx, BOOL * _Nonnull stop) {
                NSLog(@"registeredTypeIdentifiers:%@", itemProvider.registeredTypeIdentifiers);
                if ([itemProvider hasItemConformingToTypeIdentifier:identifier]) {
                    [itemProvider loadItemForTypeIdentifier:identifier options:nil completionHandler:^(id<NSSecureCoding>  _Nullable item, NSError * _Null_unspecified error) {
                        NSLog(@"itemclass = %@", NSStringFromClass([(NSObject *)item class]));
                        NSLog(@"item = %@", item);
                        if ([(NSObject *)item isKindOfClass:[NSURL class]]) {
                            NSLog(@"分享的URL = %@", item);
                        }
                    }];
                    
                    [itemProvider loadPreviewImageWithOptions:nil completionHandler:^(id<NSSecureCoding>  _Nullable item, NSError * _Null_unspecified error) {
                        if ([(NSObject *)item isKindOfClass:[UIImage class]]) {
                            //                        self.imageView.image = (UIImage *)item;
                        }
                    }];
                    
                    hasExistsUrl = YES;
                    *stop = YES;
                }
                
            }];
            
            if (hasExistsUrl)
            {
                *stop = YES;
            }
            
        }];
    });
}

#pragma mark - sheet

-(void)prepareBackgroundView {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.blurView.frame = [UIScreen mainScreen].bounds;
    
    [self.view insertSubview:self.blurView atIndex:0];
}

//-(void)addSheetView {
//    // 1- Init bottomSheetVC
//    UINavigationController *vc = [[UIStoryboard storyboardWithName:@"MainInterface" bundle:nil] instantiateViewControllerWithIdentifier:@"BottomSheetNavigationController"];
//    vc.view.layer.cornerRadius = 8;
//    vc.view.clipsToBounds = YES;
//    // 2- Add bottomSheetVC as a child view
//    [self addChildViewController:vc];
//    [self.view addSubview:vc.view];
//    
//    [vc didMoveToParentViewController:self];
//    
//    // 3- Adjust bottomSheet frame and initial position.
//    CGFloat H = self.view.frame.size.height;
//    CGFloat W  = self.view.frame.size.width;
//    CGFloat h = 400;
//    CGFloat w  = 270;
//    vc.view.frame = CGRectMake((W-w)/2.0, (H-h)/2.0, w, h);
//}

#pragma mark - UIViewControllerTransitioningDelegate

-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    SharePresentationController *presentation = [[SharePresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    
    __weak typeof(self) weakSelf = self;
    [presentation setTapContainerBlcok:^{
        [weakSelf dismissAction:nil];
    }];
    return presentation;
}


@end
