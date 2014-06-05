//
//  AppDelegate.h
//  BabyMaker
//
//  Created by Ajeet on 2/7/14.
//  Copyright (c) 2014 Ajeet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "PPRevealSideViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
//    bool crampViewShow;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) PPRevealSideViewController *revealSideViewController;
@property (nonatomic, retain) NSString *ObjID, *LastInsertedObjID, *UserName, *Age;
@property (nonatomic, retain) UIImage *userImage,*OvulationImage;
@property (nonatomic, retain) NSIndexPath *SelectedIndexPath;
@property int selectedIndex;
//@property(nonatomic, assign) bool crampViewShow;

@end
