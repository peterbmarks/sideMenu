//
//  AppDelegate.h
//  SideMenuExample
//
//  Created by Peter Marks on 5/03/13.
//  Copyright (c) 2013  Peter B Marks
//

#import <UIKit/UIKit.h>

extern NSString *const kShowMenuNotification;
extern NSString *const kHideMenuNotification;
extern NSString *const kShowHideMenuNotification;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
