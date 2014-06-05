//
//  StoreViewController.h
//  BabyMaker
//
//  Created by ajeet Singh on 14/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreViewController : UIViewController < UITableViewDelegate, UITableViewDataSource >
{
    IBOutlet UISegmentedControl *Segment;
    UITableView *tbl01;
    UIButton *btnBooks,*btnCDs;
}
@property (nonatomic,retain) IBOutlet UIButton *btnMenu;
@property (nonatomic,retain) IBOutlet UITableView *tbl01;
@property (nonatomic,retain) IBOutlet UIButton *btnBooks,*btnCDs;

-(IBAction)changeSeg;
-(IBAction)btnBooksClick:(id)sender;
-(IBAction)btnCDsClick:(id)sender;

@end
