//
//  AppDelegate.h
//  PhraseCrazyApp
//
//  Created by ajeet Singh on 10/09/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic)NSInteger flag;
@property (nonatomic)BOOL IsTimed;
@property (nonatomic)NSInteger Team,Time;
@property (nonatomic)NSInteger intPhraseNo;

@end
