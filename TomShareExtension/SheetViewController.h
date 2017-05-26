//
//  SheetViewController.h
//  CustomShareExtensionUI
//
//  Created by tomfriwel on 26/05/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SheetViewController : UIViewController

@property (nonatomic, copy) void(^cancelBlcok)(void);
@property (nonatomic, copy) void(^doneBlcok)(void);

@end
