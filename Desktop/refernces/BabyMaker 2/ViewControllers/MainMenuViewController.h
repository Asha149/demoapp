//
//  MainMenuViewController.h
//  BabyMaker
//
//  Created by ajeet Singh on 12/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController : UIViewController
{
    UITableView *MainMenuTable;
    NSIndexPath *idxPath;
    UILabel *lblUserName,*lblAge;
    UIImageView *userImage;
}

@property (retain, nonatomic) IBOutlet UIScrollView *scrollMenu;
@property (nonatomic, retain) IBOutlet NSMutableArray *MenuListArray, *arrIcon, *arrBackground;
@property (nonatomic, retain) IBOutlet NSIndexPath *idxPath;
@property (nonatomic, retain) IBOutlet UILabel *lblUserName,*lblAge;
@property (nonatomic, retain) IBOutlet UIImageView *userImage;

@end
