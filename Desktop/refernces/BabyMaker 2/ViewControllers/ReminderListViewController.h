//
//  ReminderListViewController.h
//  BabyMaker
//
//  Created by Ajeet on 11/11/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReminderListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tblReminders;
@property (strong, nonatomic) NSArray *arrNotifications;
- (IBAction)btnBack_Click:(id)sender;

@end
