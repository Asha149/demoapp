//
//  ReminderViewController.m
//  BabyMaker
//
//  Created by Ajeet on 11/8/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "ReminderViewController.h"
#import "MainMenuViewController.h"
#import "PPRevealSideViewController.h"
#import "ReminderListViewController.h"

@interface ReminderViewController ()

@end

@implementation ReminderViewController

NSArray *reminder;

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
    reminder = [NSArray arrayWithObjects:@"Daily",@"Weekly",@"Monthly",@"Yearly", nil];
    [self.reminderPicker setDelegate:self];
    [self.reminderPicker setHidden:TRUE];
    
    [_datePicker addTarget:self action:@selector(selectedDate:) forControlEvents:UIControlEventValueChanged];
    
    [self.txtMessage setInputAccessoryView:self.toolBar];
}

- (IBAction)selectedDate:(id)sender{
    //[self ToDismissPickers];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E, MMM dd,yyyy, h:mm a";
    NSLog(@"%@",[formatter stringFromDate:_datePicker.date]);
    [_btnDateSelection.titleLabel setTextColor:[UIColor blackColor]];
   
    [_btnDateSelection.titleLabel setText:[NSString stringWithFormat:@"%@",[formatter stringFromDate:_datePicker.date]]];
     [_btnDateSelection.titleLabel setTextColor:[UIColor blackColor]];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [reminder count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [reminder objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self.btnReminderSelection setTitle:[reminder objectAtIndex:row] forState:UIControlStateNormal];
    //NSLog(@"Select Row : %@",);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
//    [_datePicker release];
//    [_btnDateSelection release];
//   
//    [super dealloc];
}

- (IBAction)btnDate_Click:(id)sender {
    
    if ([_btnReminderSelection.titleLabel.text isEqualToString:@"Daily"]) {
        
        _datePicker.datePickerMode = UIDatePickerModeTime;
    }
    
    
    [self ToDismissPickers];
    [_datePicker setHidden:NO];
    [_reminderPicker setHidden:YES];
}

- (IBAction)btnSave_Click:(id)sender
{
    // Get the current date
     [self ToDismissPickers];
    
    if ([_btnDateSelection.titleLabel.text isEqualToString:@"Please Select Date and Time    "] || _txtMessage.text.length==0)
    {
         [self ToDismissPickers];
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Date is not selected or Message box is Empty." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Alert show];
        
//        [Alert release];
    }
    else
    {
        [self ToDismissPickers];
        NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
        NSString *dateString = _btnDateSelection.titleLabel.text;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"E, MMM dd,yyyy, h:mm a"];
        
        NSDate *dateFromString = [[NSDate alloc] init];
        //NSString *reminder = _btnReminderSelection.titleLabel.text;
        //dateFromString = [dateFormatter dateFromString:reminder];
        
        dateFromString = [dateFormatter dateFromString:dateString];
        NSDate *pickerDate = dateFromString;
        // Break the date up into components
   

        NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit )fromDate:pickerDate];
        NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit )fromDate:pickerDate];
        // Set up the fire time
        NSDateComponents *dateComps = [[NSDateComponents alloc] init];
        [dateComps setDay:[dateComponents day]];
        [dateComps setMonth:[dateComponents month]];
        [dateComps setYear:[dateComponents year]];
        [dateComps setHour:[timeComponents hour]];
        [dateComps setWeekday:[dateComponents weekday]];
        
        // Notification will fire in one minute
        [dateComps setMinute:[timeComponents minute]];
        [dateComps setSecond:[timeComponents second]];
        NSDate *itemDate = [calendar dateFromComponents:dateComps];
        
        UILocalNotification *localNotif = [[UILocalNotification alloc] init];
        if (localNotif == nil)
            return;
        localNotif.fireDate = itemDate;
        localNotif.timeZone = [NSTimeZone defaultTimeZone];
        
        // Notification details
        localNotif.alertBody = _txtMessage.text;
        
        // Set the action button
        localNotif.alertAction = @"View";
        
        if([_btnReminderSelection.titleLabel.text isEqualToString:@"Daily"])
        {
            localNotif.repeatInterval = NSDayCalendarUnit;
        }
        else if([_btnReminderSelection.titleLabel.text isEqualToString:@"Weekly"])
        {
            localNotif.repeatInterval = NSWeekCalendarUnit;
        }
        else if([_btnReminderSelection.titleLabel.text isEqualToString:@"Monthly"])
        {
            localNotif.repeatInterval = NSMonthCalendarUnit;
        }
        else if([_btnReminderSelection.titleLabel.text isEqualToString:@"Yearly"])
        {
            localNotif.repeatInterval = NSYearCalendarUnit;
        }
        localNotif.soundName = UILocalNotificationDefaultSoundName;
        //    localNotif.applicationIconBadgeNumber = 1;
        
        NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
        localNotif.userInfo = infoDict;
        
        // Schedule the notification
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"Reminder" message:@"Your reminder has been saved." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Alert show];
//        [Alert release];
        _txtMessage.text = @"";
    }
    
}

- (IBAction)btnMenu_Click:(id)sender {
    [self ToDismissPickers];
    MainMenuViewController *obj = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:[NSBundle mainBundle]];
    [self.revealSideViewController pushViewController:obj onDirection:PPRevealSideDirectionLeft withOffset:50 animated:YES];
//    [obj release];
}

- (IBAction)btnReminders_Click:(id)sender
{
    
//    if ([_btnDateSelection.titleLabel.text isEqualToString:@"Select Date and Time"] || _txtMessage.text.length==0)
//    {
//         [self ToDismissPickers];
//        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Date is not selected or Message box is Empty." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [Alert show];
//        
//        [Alert release];
//    }
//    else
//    {
     [self ToDismissPickers];
    
    ReminderListViewController *vc=[[ReminderListViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
//    }
}

- (IBAction)btnReminder:(id)sender {
    
    [self.reminderPicker setHidden:FALSE];
    [self.datePicker setHidden:TRUE];
    [_txtMessage resignFirstResponder];

}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [_datePicker setHidden:YES];
//    [_txtMessage resignFirstResponder];
//}
- (void)ToDismissPickers
{
   
    [_txtMessage resignFirstResponder];
     [_datePicker setHidden:YES];
}
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if([text isEqualToString:@"\n"])
//    {
//        [textView resignFirstResponder];
//    }
//    return YES;
//}

- (IBAction)btnMinimize_Click:(id)sender {
    [self.txtMessage resignFirstResponder];
}

@end
