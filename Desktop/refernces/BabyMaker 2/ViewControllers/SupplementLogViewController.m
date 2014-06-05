//
//  SupplementLogViewController.m
//  BabyMaker
//
//  Created by ajeet Singh on 14/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "SupplementLogViewController.h"
#import "MainMenuViewController.h"
#import "PPRevealSideViewController.h"
#import "SVProgressHUD.h"

@interface SupplementLogViewController ()

@end

@implementation SupplementLogViewController
@synthesize btnMenu;


#pragma mark
#pragma mark - View-lifeCycle Methods...
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [btnMenu addTarget:self action:@selector(btnMenuClick:) forControlEvents:UIControlEventTouchUpInside];

    supplements=[[NSMutableArray alloc]initWithObjects:@"Multivitamin", @"Fish Oil", @"Probiotic", nil];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyy"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    DateToDisplayFormatter = [[NSDateFormatter alloc]init];
    [DateToDisplayFormatter setDateFormat:@"dd MMMM, yyyy"];
    NSString *DateTODisplay = [DateToDisplayFormatter stringFromDate:[NSDate date]];
    [self.btnDate setTitle:DateTODisplay forState:UIControlStateNormal];
    
    self.Cal = [[TKCalendarMonthView alloc]init];
    self.Cal.delegate = self;
    CalendarView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 320, self.Cal.frame.size.height)];
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        CalendarView = [[UIView alloc] initWithFrame:CGRectMake(124, 105, 320, self.Cal.frame.size.height)];
    }
    else
    {
        CalendarView = [[UIView alloc] initWithFrame:CGRectMake(0, 105, 320, self.Cal.frame.size.height)];
    }
    
    //    [CalendarView setBackgroundColor:[UIColor whiteColor]];
    [CalendarView addSubview:self.Cal];
    [self.view addSubview:CalendarView];
    [CalendarView setHidden:YES];
    
    [self.txtComment setInputAccessoryView:self.toolBar];
    
    [self.scroll setContentSize:CGSizeMake(320, 470)];
    
    previousData=[[NSMutableDictionary alloc]init];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [self getPrevious];
}

-(void)getPrevious{
    PFQuery *query=[PFQuery queryWithClassName:@"Supplements"];
    [query whereKey:@"Type" containsString:@"Multivitamin"];
    [query orderByDescending:@"supplement_date"];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (object) {
            [previousData setValue:[object valueForKey:@"Comment"] forKey:@"Multivitamin"];
        }
        
        PFQuery *query=[PFQuery queryWithClassName:@"Supplements"];
        [query whereKey:@"Type" containsString:@"Probiotic"];
        [query orderByDescending:@"supplement_date"];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (object) {
                [previousData setValue:[object valueForKey:@"Comment"] forKey:@"Probiotic"];
            }
            PFQuery *query=[PFQuery queryWithClassName:@"Supplements"];
            [query whereKey:@"Type" containsString:@"Fish Oil"];
            [query orderByDescending:@"supplement_date"];
            [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                if (object) {
                    [previousData setValue:[object valueForKey:@"Comment"] forKey:@"Fish Oil"];
                }
                [SVProgressHUD dismiss];
            }];
        }];
    }];
}


#pragma mark
#pragma mark - Button Click Methods...
-(IBAction)btnMenuClick:(id)sender
{
    MainMenuViewController *obj = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:[NSBundle mainBundle]];
    [self.revealSideViewController pushViewController:obj onDirection:PPRevealSideDirectionLeft withOffset:50 animated:YES];
}

- (IBAction)btnPreviousClick:(id)sender {
    [self save];
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = -1;
    
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    [self.Cal selectDate:[DateToDisplayFormatter dateFromString:[self.btnDate titleForState:UIControlStateNormal]]];
    
    [self.btnDate setTitle:[DateToDisplayFormatter stringFromDate:[theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[self.btnDate titleForState:UIControlStateNormal]] options:0]] forState:UIControlStateNormal];
}

- (IBAction)btnAdd_Click:(id)sender {
    UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Add New" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    [CheckAlert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [CheckAlert setDelegate:self];
    [CheckAlert show];
}

- (IBAction)btnSave_Click:(id)sender {
    [self save];
}

- (IBAction)btnMinimize_Click:(id)sender {
    [self.txtComment resignFirstResponder];
}

- (IBAction)btnSameAsPrevious_Click:(id)sender {
    [self.txtComment setText:[previousData valueForKey:self.btnSupplement.titleLabel.text]];
}

#pragma mark alert view
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [supplements addObject:[alertView textFieldAtIndex:0].text];
        [self.pickerSupplement setDataSource:self];
        [self.pickerSupplement setDelegate:self];
        [self.pickerSupplement reloadAllComponents];
    }
}


- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d
{
    
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 1;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    
    NSDate *today = [NSDate date];
    NSDate *newDate = [theCalendar dateByAddingComponents:dayComponent toDate:d options:0];
    
    NSComparisonResult result=[today compare:newDate];
    
    if(result==NSOrderedAscending)
    {
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Can not enter stress management techniques for future dates." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Alert show];
        //        [Alert release];
    }
    else
    {
        [self.btnDate setTitle:[DateToDisplayFormatter stringFromDate:d] forState:UIControlStateNormal];
    }
    //    NSLog(@"date == %@",d);
    
    [self.btnDate setEnabled:YES];
//    [btnPrevious setEnabled:YES];
//    [btnNext setEnabled:YES];
    [CalendarView setHidden:YES];
    [self.viewDetails setHidden:NO];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:CalendarView cache:YES];
    [UIView commitAnimations];
    
}

-(void)save
{
    NSDate *Dat = [DateToDisplayFormatter dateFromString:[self.btnDate titleForState:UIControlStateNormal]];
    NSString *DateToDisplay = [dateFormatter stringFromDate:Dat];
    
    PFObject *testObject = [PFObject objectWithClassName:@"Supplements"];
    [testObject setObject:self.btnSupplement.titleLabel.text forKey:@"Type"];
    [testObject setObject:DateToDisplay forKey:@"supplement_date"];
    [testObject setObject:self.txtComment.text forKey:@"Comment"];
    [testObject setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"] forKey:@"user_id"];
    [testObject save];
    NSString *objid = testObject.objectId;
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    PFQuery *QUE = [PFQuery queryWithClassName:@"Supplements"];
    [QUE getObjectInBackgroundWithId:objid block:^(PFObject *object, NSError *error) {
        [SVProgressHUD dismiss];
    }];
    
    [self getPrevious];
    [self.txtComment setText:@""];
    [self.btnSupplement.titleLabel setText:@"Select Supplement"];
}


#pragma mark
#pragma mark - PickerView Methods...

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [supplements count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [supplements objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component
{
    [self.btnSupplement setTitle:[supplements objectAtIndex:row] forState:UIControlStateNormal];
    [self.pickerSupplement setHidden:YES];
}



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

- (IBAction)btnSupplement_Click:(id)sender {
    [self.pickerSupplement setHidden:NO];
}

- (IBAction)btnDate_Click:(id)sender {
    [self.btnDate setEnabled:NO];
//    [btnPrevious setEnabled:NO];
//    [btnNext setEnabled:NO];
    [CalendarView setHidden:NO];
    [self.viewDetails setHidden:YES];
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init] ;
    dayComponent.day = 1;
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    [self.Cal selectDate:[theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[self.btnDate titleForState:UIControlStateNormal]] options:0]];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:CalendarView cache:YES];
    [UIView commitAnimations];

}

- (IBAction)btnNextClick:(id)sender {
    [self save];
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 1;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    
    NSDate *today = [NSDate date];
    NSDate *newDate = [theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[self.btnDate titleForState:UIControlStateNormal]] options:0];
    
    NSComparisonResult result=[today compare:newDate];
    
    if(result==NSOrderedAscending)
    {
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Can not enter information for future dates." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Alert show];
        //        [Alert release];
    }
    else
    {
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        [self.btnDate setTitle:[DateToDisplayFormatter stringFromDate:[theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[self.btnDate titleForState:UIControlStateNormal]] options:0]] forState:UIControlStateNormal];
        [self.Cal selectDate:[theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[self.btnDate titleForState:UIControlStateNormal]] options:0]];
    }

}
@end
