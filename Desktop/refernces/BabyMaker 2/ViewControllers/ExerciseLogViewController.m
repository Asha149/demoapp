//
//  ExerciseLogViewController.m
//  BabyMaker
//
//  Created by ajeet Singh on 14/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "ExerciseLogViewController.h"
#import "MainMenuViewController.h"
#import "PPRevealSideViewController.h"
#import "ViewExerciseViewController.h"
#import "SVProgressHUD.h"

@interface ExerciseLogViewController ()

@end

@implementation ExerciseLogViewController

NSArray *hour_min;
@synthesize btnMenu,btnPrevious,btnNext,txtExercise,txtDuration, Scroll,myDateString,Cal,btnSave,btnViewExercise,btnDate,BackgroundView,DateString,hourMinPicker,btnGetDuration;
UIView *CalendarView;
UITapGestureRecognizer *tap;
#pragma mark
#pragma mark - View-lifeCycle Methods...
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    Scroll.delegate=self;
    [Scroll setContentSize:CGSizeMake(320, Scroll.frame.size.height+50)];
    [btnMenu addTarget:self action:@selector(btnMenuClick:) forControlEvents:UIControlEventTouchUpInside];    
    [txtDuration setKeyboardType:UIKeyboardTypeNumberPad];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyy"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    myDateString = [dateFormatter stringFromDate:[NSDate date]];
    DateToDisplayFormatter = [[NSDateFormatter alloc]init];
    [DateToDisplayFormatter setDateFormat:@"dd MMMM, yyyy"];
    NSString *DateTODisplay = [DateToDisplayFormatter stringFromDate:[NSDate date]];
    [btnDate setTitle:DateTODisplay forState:UIControlStateNormal];
    
    NSString *objIDFromUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"];
    NSLog(@"objIDFromUserDefaults = %@",objIDFromUserDefaults);
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    PFQuery *QUE = [PFQuery queryWithClassName:@"ExerciseLog"];
    [QUE whereKey:@"exercise_user_id" equalTo:objIDFromUserDefaults];
    [QUE whereKey:@"exercise_date" equalTo:myDateString];
    [QUE findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if ([objects count]>0)
        {
            NSMutableArray *exercise_title = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"exercise_title"]];
            txtExercise.text = [exercise_title objectAtIndex:0];
            
            NSMutableArray *exercise_duration = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"exercise_duration"]];
            NSLog(@"%@",[exercise_duration objectAtIndex:0]);
            NSArray *stringArray = [[exercise_duration objectAtIndex:0] componentsSeparatedByString: @" "];
            
            txtDuration.text = [stringArray objectAtIndex:0];
            [btnGetDuration setTitle:[stringArray objectAtIndex:1] forState:UIControlStateNormal];
        }
        else
        {
            txtExercise.text=@"";
            txtDuration.text=@"";
        }
        [SVProgressHUD dismiss];
    }];
//    
//    //Time Picker
    
    hourMinPicker.hidden = TRUE;
    hour_min = [NSArray arrayWithObjects:@"Hour",@"Minute", nil];
    [hourMinPicker setDelegate:self];
//    timePicker.hidden = TRUE;
//    timePicker.datePickerMode = UIDatePickerModeTime;
//    btnGetDuration.hidden = TRUE;
    
//    CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
//    self.calendar = calendar;
//    calendar.delegate = self;
//    [calendar setBackgroundColor:[UIColor whiteColor]];
//    calendar.onlyShowCurrentMonth = NO;
//    calendar.adaptHeightToNumberOfWeeksInMonth = YES;
//    [self.view addSubview:self.calendar];

    Cal = [[TKCalendarMonthView alloc]init];
    Cal.delegate = self;
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        CalendarView = [[UIView alloc] initWithFrame:CGRectMake(124, 43, 320, Cal.frame.size.height)];
    }
    else
    {
        CalendarView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, 320, Cal.frame.size.height)];
    }
    
//    [CalendarView setBackgroundColor:[UIColor whiteColor]];
    [CalendarView addSubview:Cal];
    [Scroll addSubview:CalendarView];
    [CalendarView setHidden:YES];
    
//    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ToDismissPickers)];
//    [self.view addGestureRecognizer:tap];
    
    [txtDuration setInputAccessoryView:self.toolBar];
    [txtExercise setInputAccessoryView:self.toolBar];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        CalendarView = [[UIView alloc] initWithFrame:CGRectMake(124, 43, 320, Cal.frame.size.height)];
    }
    else
    {
        CalendarView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, 320, Cal.frame.size.height)];
    }
}
- (void)ToDismissPickers
{
    [txtExercise resignFirstResponder];
    [txtDuration resignFirstResponder];
}
//- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
//{
//    [theTextField resignFirstResponder];
//    return YES;
//}



#pragma mark
#pragma mark - Button Click Methods...
-(IBAction)btnDateClick:(id)sender
{
//    [btnDate setEnabled:NO];
//    [btnPrevious setEnabled:NO];
//    [btnNext setEnabled:NO];
//    [tap setEnabled:NO];
//    [CalendarView setHidden:NO];
//    [BackgroundView setHidden:YES];
//    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
//    dayComponent.day = 1;
//    NSCalendar *theCalendar = [NSCalendar currentCalendar];
//    [Cal selectDate:[theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]] options:0]];
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1.0];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:CalendarView cache:YES];
//    [UIView commitAnimations];
    
    [CalendarView setHidden:NO];
    [btnDate setEnabled:NO];
    [btnPrevious setEnabled:NO];
    [btnNext setEnabled:NO];
  //  [tap setHidden:YES];
    [BackgroundView setHidden:YES];
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 1;
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    [Cal selectDate:[theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]] options:0]];
    [self Querrying];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:CalendarView cache:YES];
    [UIView commitAnimations];
}

- (IBAction)btnMinimize_Click:(id)sender {
    [txtExercise resignFirstResponder];
    [txtDuration resignFirstResponder];
}

-(IBAction)btnSaveClick:(id)sender
{
    hourMinPicker.hidden = TRUE;
    NSLog(@"Button Save Click...");
    NSLog(@"%@",btnGetDuration.titleLabel.text);
    NSString *textExercise = [txtExercise.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  //  *textDuration  = [txtDuration.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
     NSString *textDuration = [NSString stringWithFormat:@"%@ %@",txtDuration.text,btnGetDuration.titleLabel.text];
    //NSLog(@"%@",temp);
    if (textExercise.length==0 || textDuration.length==0)
    {
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"Field is Blank" message:@"Please, Enter any something in Blank Field." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Alert show];
//        [Alert release];
    }
    else
    {
        ///---
        NSDate *Dat = [DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]];
        NSString *DateToDisplay = [dateFormatter stringFromDate:Dat];
        
        NSString *objIDFromUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"];
        NSLog(@"objIDFromUserDefaults = %@",objIDFromUserDefaults);
        
        PFObject *testObject = [PFObject objectWithClassName:@"ExerciseLog"];
        [testObject setObject:textExercise forKey:@"exercise_title"];
        [testObject setObject:textDuration forKey:@"exercise_duration"];
        [testObject setObject:DateToDisplay forKey:@"exercise_date"];
        [testObject setObject:objIDFromUserDefaults forKey:@"exercise_user_id"];
        [testObject save];
        NSString *objid = testObject.objectId;
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
        PFQuery *QUE = [PFQuery queryWithClassName:@"ExerciseLog"];
        [QUE getObjectInBackgroundWithId:objid block:^(PFObject *object, NSError *error) {
            
            NSLog(@"Exercise Title = %@",[object objectForKey:@"exercise_title"]);
            NSLog(@"Exercise Duration = %@",[object objectForKey:@"exercise_duration"]);
            NSLog(@"Exercise Date = %@",[object objectForKey:@"exercise_date"]);
            [SVProgressHUD dismiss];
        }];
    }
}
-(IBAction)btnViewExerciseClick:(id)sender
{
    ViewExerciseViewController *obj = [[ViewExerciseViewController alloc] initWithNibName:@"ViewExerciseViewController" bundle:[NSBundle mainBundle]];
    obj.dateString = [btnDate titleForState:UIControlStateNormal];
    [self.navigationController pushViewController:obj animated:YES];
//    [obj release];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    hourMinPicker.hidden = TRUE;
}
//
//- (IBAction)setTime:(id)sender {
//    
//    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//    [outputFormatter setDateFormat:@"h:mm a"];
//    NSLog(@"%@",[outputFormatter stringFromDate:timePicker.date]);
//    txtDuration.text = [outputFormatter stringFromDate:timePicker.date];
//    //[outputFormatter release];
//}

- (IBAction)getDuration:(id)sender {
    
//    btnGetDuration.hidden = TRUE;
//    timePicker.hidden = TRUE;
    
    hourMinPicker.hidden = FALSE;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [hour_min count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [hour_min objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [btnGetDuration setTitle:[hour_min objectAtIndex:row] forState:UIControlStateNormal];
    //NSLog(@"Select Row : %@",);
}

-(IBAction)btnPreviousClick:(id)sender
{
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init] ;
    dayComponent.day = -1;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    [Cal selectDate:[DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]]];
    
    [btnDate setTitle:[DateToDisplayFormatter stringFromDate:[theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]] options:0]] forState:UIControlStateNormal];

    ///---
    NSDate *Dat = [DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]];
    NSString *DateToDisplay = [dateFormatter stringFromDate:Dat];
    
    NSString *objIDFromUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"];
    NSLog(@"objIDFromUserDefaults = %@",objIDFromUserDefaults);
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    PFQuery *QUE = [PFQuery queryWithClassName:@"ExerciseLog"];
    [QUE whereKey:@"exercise_user_id" equalTo:objIDFromUserDefaults];
    [QUE whereKey:@"exercise_date" equalTo:DateToDisplay];
    [QUE findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if ([objects count]>0)
        {
            NSMutableArray *exercise_title = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"exercise_title"]];
            txtExercise.text = [exercise_title objectAtIndex:0];
            
            NSMutableArray *exercise_duration = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"exercise_duration"]];
            txtDuration.text = [exercise_duration objectAtIndex:0];
        }
        else
        {
            txtExercise.text=@"";
            txtDuration.text=@"";
        }
        [SVProgressHUD dismiss];
    }];
}
-(IBAction)btnNextClick:(id)sender
{    
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init] ;
    dayComponent.day = 1;
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    
    NSDate *today = [NSDate date];
    NSDate *newDate = [theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]] options:0];
    
    NSComparisonResult result=[today compare:newDate];
    
    if(result==NSOrderedAscending)
    {
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Can not enter exercise information for future dates." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Alert show];
//        [Alert release];
        [SVProgressHUD dismiss];
    }
    else
    {
        [btnDate setTitle:[DateToDisplayFormatter stringFromDate:[theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]] options:0]] forState:UIControlStateNormal];
        
        [Cal selectDate:[theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]] options:0]];
        
        ///---
        NSDate *Dat = [DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]];
        NSString *DateToDisplay = [dateFormatter stringFromDate:Dat];
        
        NSString *objIDFromUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"];
        NSLog(@"objIDFromUserDefaults = %@",objIDFromUserDefaults);
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
        PFQuery *QUE = [PFQuery queryWithClassName:@"ExerciseLog"];
        [QUE whereKey:@"exercise_user_id" equalTo:objIDFromUserDefaults];
        [QUE whereKey:@"exercise_date" equalTo:DateToDisplay];
        [QUE findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            if ([objects count]>0)
            {
                NSMutableArray *exercise_title = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"exercise_title"]];
                txtExercise.text = [exercise_title objectAtIndex:0];
                
                NSMutableArray *exercise_duration = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"exercise_duration"]];
                txtDuration.text = [exercise_duration objectAtIndex:0];
            }
            else
            {
                txtExercise.text=@"";
                txtDuration.text=@"";
            }
            [SVProgressHUD dismiss];
        }];
    }
}

-(IBAction)btnMenuClick:(id)sender
{
    [self ToDismissPickers];
    MainMenuViewController *obj = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:[NSBundle mainBundle]];
    [self.revealSideViewController pushViewController:obj onDirection:PPRevealSideDirectionLeft withOffset:50 animated:YES];
//    [obj release];
}


- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d
{
    NSLog(@"date == %@",d);
    [btnDate setEnabled:YES];
    [btnPrevious setEnabled:YES];
    [btnNext setEnabled:YES];
    
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 1;
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    
    NSDate *today = [NSDate date];
    NSDate *newDate = [theCalendar dateByAddingComponents:dayComponent toDate:d options:0];
    
    NSComparisonResult result=[today compare:newDate];
    
    if(result==NSOrderedAscending)
    {
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Can not enter meal information for future dates." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Alert show];
        //        [Alert release];
    }
    else
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        DateString = [dateFormatter stringFromDate:d];
        NSString *DateTODisplay = [DateToDisplayFormatter stringFromDate:d];
        [btnDate setTitle:DateTODisplay forState:UIControlStateNormal];
        
        [self Querrying];
    }
    
    [CalendarView setHidden:YES];
    [BackgroundView setHidden:NO];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:CalendarView cache:YES];
    [UIView commitAnimations];
}
-(void) Querrying
{
    NSDate *DTD = [DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]];
    [btnDate setTitle:[DateToDisplayFormatter stringFromDate:DTD] forState:UIControlStateNormal];
    //        ///---
            NSDate *Dat = [DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]];
            NSString *DateToDisplay = [dateFormatter stringFromDate:Dat];
    //
            NSString *objIDFromUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"];
            NSLog(@"objIDFromUserDefaults = %@",objIDFromUserDefaults);
    
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
            PFQuery *QUE = [PFQuery queryWithClassName:@"ExerciseLog"];
            [QUE whereKey:@"exercise_user_id" equalTo:objIDFromUserDefaults];
            [QUE whereKey:@"exercise_date" equalTo:DateToDisplay];
            [QUE findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    //
                if ([objects count]>0)
                {
                    NSMutableArray *exercise_title = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"exercise_title"]];
                    txtExercise.text = [exercise_title objectAtIndex:0];
    
                    NSMutableArray *exercise_duration = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"exercise_duration"]];
                    txtDuration.text = [exercise_duration objectAtIndex:0];
                }
               else
                {
                    txtExercise.text=@"";
                    txtDuration.text=@"";
                }
                [SVProgressHUD dismiss];
            }];
    
}



//- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d
//{
//    NSLog(@"date == %@",d);
//    
//    [btnDate setEnabled:YES];
//    [btnPrevious setEnabled:YES];
//    [btnNext setEnabled:YES];
//    [tap setEnabled:YES];
//    [CalendarView setHidden:YES];
//    [BackgroundView setHidden:NO];
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1.0];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:CalendarView cache:YES];
//    [UIView commitAnimations];
//    
//    NSDateComponents *dayComponent = [[NSDateComponents alloc] init] ;
//    dayComponent.day = 1;
//    NSCalendar *theCalendar = [NSCalendar currentCalendar];
//    
//    NSDate *today = [NSDate date];
//    NSDate *newDate = [theCalendar dateByAddingComponents:dayComponent toDate:d options:0];
//    
//    NSComparisonResult result=[today compare:newDate];
//
//    if(result==NSOrderedAscending)
//    {
//        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Can not enter exercise information for future dates." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [Alert show];
////        [Alert release];
//        [SVProgressHUD dismiss];
//    }
//    else
//    {
//        [btnDate setTitle:[DateToDisplayFormatter stringFromDate:d] forState:UIControlStateNormal];
//        ///---
//        NSDate *Dat = [DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]];
//        NSString *DateToDisplay = [dateFormatter stringFromDate:Dat];
//        
//        NSString *objIDFromUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"];
//        NSLog(@"objIDFromUserDefaults = %@",objIDFromUserDefaults);
//        
//        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
//        PFQuery *QUE = [PFQuery queryWithClassName:@"ExerciseLog"];
//        [QUE whereKey:@"exercise_user_id" equalTo:objIDFromUserDefaults];
//        [QUE whereKey:@"exercise_date" equalTo:DateToDisplay];
//        [QUE findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//            
//            if ([objects count]>0)
//            {
//                NSMutableArray *exercise_title = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"exercise_title"]];
//                txtExercise.text = [exercise_title objectAtIndex:0];
//                
//                NSMutableArray *exercise_duration = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"exercise_duration"]];
//                txtDuration.text = [exercise_duration objectAtIndex:0];
//            }
//            else
//            {
//                txtExercise.text=@"";
//                txtDuration.text=@"";
//            }
//            [SVProgressHUD dismiss];
//        }];
//
//    }
//}


#pragma mark
#pragma mark - Common Methods...
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
