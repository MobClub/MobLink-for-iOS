//
//  UIViewController+MLDBackItemHandler.h
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MLDBackItemHandlerProtocol <NSObject>

@optional

// Override this method in UIViewController derived class to handle 'Back' button click.
-(BOOL)navigationShouldPopOnBackButtonClick;

@end

@interface UIViewController (MLDBackItemHandler)<MLDBackItemHandlerProtocol>

@end
