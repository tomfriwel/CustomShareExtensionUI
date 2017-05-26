//
//  SharePresentationController.h
//  CustomShareExtensionUI
//
//  Created by tomfriwel on 26/05/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SharePresentationController : UIPresentationController

@property (nonatomic, copy) void(^tapContainerBlcok)(void);

@end
