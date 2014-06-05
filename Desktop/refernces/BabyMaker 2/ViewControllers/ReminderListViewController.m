//
//  ReminderListViewController.m
//  BabyMaker
//
//  Created by Ajeet on 11/11/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "ReminderListViewController.h"

@interface ReminderListViewController ()

@end

@implementation ReminderListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES];
    _arrNotifications=[[NSArray alloc]initWithArray:[[UIApplication sharedApplication] scheduledLocalNotifications]];
    
//    [_tblReminders setFrame:CGRectMake(_tblReminders.frame.origin.x, _tblReminders.frame.origin.y, _tblReminders.frame.size.width, 45*[[[UIApplication sharedApplication] scheduledLocalNotifications] count])];
      [_tblReminders setFrame:CGRectMake(_tblReminders.frame.origin.x, _tblReminders.frame.origin.y, _tblReminders.frame.size.width, 58*[[[UIApplication sharedApplication] scheduledLocalNotifications] count])];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[[UIApplication sharedApplication] scheduledLocalNotifications] count]>0)
    {
        return [[[UIApplication sharedApplication] scheduledLocalNotifications] count];
    }
    else
    {
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"No Data Found" message:@"Here is no data." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Alert show];
//        [Alert release];
        return 0;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    UILocalNotification *localNotification = [_arrNotifications objectAtIndex:indexPath.row];
    [cell.textLabel setText:localNotification.alertBody];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"E, MMM dd,yyyy, h:mm a"];
    NSString *date = [dateFormatter stringFromDate:localNotification.fireDate];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:date];
    NSString *str = [dateFormatter stringFromDate:dateFromString];
    // Break the date up into components
    [cell.detailTextLabel setText:str];
    return cell;
}

- (void)dealloc {
//    [_tblReminders release];
//    [super dealloc];
}
- (IBAction)btnBack_Click:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
