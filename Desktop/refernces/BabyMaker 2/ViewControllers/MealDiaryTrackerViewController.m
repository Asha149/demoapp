//
//  MealDiaryTrackerViewController.m
//  BabyMaker
//
//  Created by ajeet Singh on 13/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "MealDiaryTrackerViewController.h"
#import "MealInfoPageViewController.h"
#import "MainMenuViewController.h"
#import "PPRevealSideViewController.h"
#import "MealDiaryDetailsViewController.h"
#import "MealDiaryCell.h"
#import "SVProgressHUD.h"

@interface MealDiaryTrackerViewController ()

@end

@implementation MealDiaryTrackerViewController
@synthesize btnMenu,btnDetail,dayEvents,Cal,Scroll,DateString,btnDateLabel,btnPrevious,btnNext;
NSMutableArray *TimeDuration,*Meal_Connent,*objectIDS;
UIView *CalendarView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    [btnMenu addTarget:self action:@selector(btnMenuClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnDetail addTarget:self action:@selector(btnDetailClick:) forControlEvents:UIControlEventTouchUpInside];
    
    Cal = [[TKCalendarMonthView alloc]initWithSundayAsFirst:YES];
    Cal.delegate = self;
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        CalendarView = [[UIView alloc] initWithFrame:CGRectMake(124, 0, 320, Cal.frame.size.height)];

    }
    else
    {
        CalendarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, Cal.frame.size.height)];
    }
//    [CalendarView setBackgroundColor:[UIColor whiteColor]];
    [CalendarView addSubview:Cal];
    [Scroll addSubview:CalendarView];
    [CalendarView setHidden:YES];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    DateString = [dateFormatter stringFromDate:[NSDate date]];
    DateToDisplayFormatter = [[NSDateFormatter alloc]init];
    [DateToDisplayFormatter setDateFormat:@"dd MMMM, yyyy"];
    NSString *DateTODisplay = [DateToDisplayFormatter stringFromDate:[NSDate date]];
    [btnDateLabel setTitle:DateTODisplay forState:UIControlStateNormal];
    
    TimeDuration = [[NSMutableArray alloc] init];
    [TimeDuration addObject:@"BreakFast"];
    [TimeDuration addObject:@"Snacks"];
    [TimeDuration addObject:@"Lunch"];
    [TimeDuration addObject:@"Dinner"];
    [TimeDuration addObject:@"Dessert"];
    
    Meal_Connent = [[NSMutableArray alloc] init];
    [Meal_Connent addObject:@"---"];
    [Meal_Connent addObject:@"---"];
    [Meal_Connent addObject:@"---"];
    [Meal_Connent addObject:@"---"];
    [Meal_Connent addObject:@"---"];
    
    objectIDS = [[NSMutableArray alloc] init];
    
    [Scroll setContentSize:CGSizeMake(Scroll.frame.size.width, Scroll.frame.size.height)];
}


-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"ViewWillAppear");
    NSLog(@"Date = %@",btnDateLabel.titleLabel.text);
    
    [self Querrying];
}

#pragma mark UIInterfaceOrientation method


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        CalendarView = [[UIView alloc] initWithFrame:CGRectMake(124, 0, 320, Cal.frame.size.height)];
        
    }
    else
    {
        CalendarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, Cal.frame.size.height)];
    }
}
-(IBAction)btnDateLabelClick:(id)sender
{
    [CalendarView setHidden:NO];
    [btnDateLabel setEnabled:NO];
    [btnPrevious setEnabled:NO];
    [btnNext setEnabled:NO];
    [dayEvents setHidden:YES];
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 1;
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    [Cal selectDate:[theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[btnDateLabel titleForState:UIControlStateNormal]] options:0]];
    [self Querrying];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:CalendarView cache:YES];
    [UIView commitAnimations];
}
-(IBAction)btnPreviousClick:(id)sender
{
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = -1;
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    [btnDateLabel setTitle:[DateToDisplayFormatter stringFromDate:[theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[btnDateLabel titleForState:UIControlStateNormal]] options:0]] forState:UIControlStateNormal];
    [self Querrying];
}

-(IBAction)btnNextClick:(id)sender
{
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 1;
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    
    NSDate *today = [NSDate date];
    NSDate *newDate = [theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[btnDateLabel titleForState:UIControlStateNormal]] options:0];
    
    NSComparisonResult result=[today compare:newDate];
    
    if(result==NSOrderedAscending)
    {
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Can not enter meal information for future dates." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Alert show];
//        [Alert release];
    }
    else
    {
        [btnDateLabel setTitle:[DateToDisplayFormatter stringFromDate:[theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[btnDateLabel titleForState:UIControlStateNormal]] options:0]] forState:UIControlStateNormal];
        [self Querrying];
    }
}

#pragma mark -
#pragma mark TKCalendarMonthViewDelegate methods
- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d
{
    NSLog(@"date == %@",d);
    [btnDateLabel setEnabled:YES];
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
        [btnDateLabel setTitle:DateTODisplay forState:UIControlStateNormal];

        [self Querrying];
    }
    
    [CalendarView setHidden:YES];
    [dayEvents setHidden:NO];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:CalendarView cache:YES];
    [UIView commitAnimations];
}

-(void) Querrying
{
    NSDate *DTD = [DateToDisplayFormatter dateFromString:[btnDateLabel titleForState:UIControlStateNormal]];
    NSString *DateToDisplay = [dateFormatter stringFromDate:DTD];
    
    NSString *objIDFromUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"];
    NSLog(@"objIDFromUserDefaults = %@",objIDFromUserDefaults);
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    PFQuery *QUE = [PFQuery queryWithClassName:@"MealInfo"];
    [QUE whereKey:@"meal_user_id" equalTo:objIDFromUserDefaults];
    [QUE whereKey:@"meal_date" equalTo:DateToDisplay];
    [QUE findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        [Meal_Connent removeAllObjects];
        [objectIDS removeAllObjects];
        if ([objects count]>0)
        {
            NSMutableArray *meal_comment = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"meal_comment"]];
            NSLog(@"meal_comment = %@",meal_comment);
            
            NSMutableArray *meal_title = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"meal_title"]];
            NSLog(@"meal_title = %@",meal_title);
            
            NSMutableArray *objectId = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"objectId"]];
            NSLog(@"objectId = %@",objectId);
            
            if ([meal_title containsObject:@"BreakFast"])
            {
                int i = [meal_title indexOfObject:@"BreakFast"];
                [Meal_Connent addObject:[meal_comment objectAtIndex:i]];
                [objectIDS addObject:[objectId objectAtIndex:i]];
            }
            else
            {
                NSLog(@"---");
                [Meal_Connent addObject:@"---"];
                [objectIDS addObject:@"---"];
            }
            
            if ([meal_title containsObject:@"Snacks"])
            {
                int i = [meal_title indexOfObject:@"Snacks"];
                [Meal_Connent addObject:[meal_comment objectAtIndex:i]];
                [objectIDS addObject:[objectId objectAtIndex:i]];
            }
            else
            {
                NSLog(@"---");
                [Meal_Connent addObject:@"---"];
                [objectIDS addObject:@"---"];
            }
            
            if ([meal_title containsObject:@"Lunch"])
            {
                int i = [meal_title indexOfObject:@"Lunch"];
                [Meal_Connent addObject:[meal_comment objectAtIndex:i]];
                [objectIDS addObject:[objectId objectAtIndex:i]];
            }
            else
            {
                NSLog(@"---");
                [Meal_Connent addObject:@"---"];
                [objectIDS addObject:@"---"];
            }
            
            if ([meal_title containsObject:@"Dinner"])
            {
                int i = [meal_title indexOfObject:@"Dinner"];
                [Meal_Connent addObject:[meal_comment objectAtIndex:i]];
                [objectIDS addObject:[objectId objectAtIndex:i]];
            }
            else
            {
                NSLog(@"---");
                [Meal_Connent addObject:@"---"];
                [objectIDS addObject:@"---"];
            }
            
            if ([meal_title containsObject:@"Dessert"])
            {
                int i = [meal_title indexOfObject:@"Dessert"];
                [Meal_Connent addObject:[meal_comment objectAtIndex:i]];
                [objectIDS addObject:[objectId objectAtIndex:i]];
            }
            else
            {
                NSLog(@"---");
                [Meal_Connent addObject:@"---"];
                [objectIDS addObject:@"---"];
            }
            NSLog(@"ObjectIDS = %@",objectIDS);
        }
        else
        {
            [Meal_Connent addObject:@"---"];
            [Meal_Connent addObject:@"---"];
            [Meal_Connent addObject:@"---"];
            [Meal_Connent addObject:@"---"];
            [Meal_Connent addObject:@"---"];
            [objectIDS addObject:@"---"];
            [objectIDS addObject:@"---"];
            [objectIDS addObject:@"---"];
            [objectIDS addObject:@"---"];
            [objectIDS addObject:@"---"];
        }
        [dayEvents reloadData];
        [SVProgressHUD dismiss];
    }];
}


#pragma mark
#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [TimeDuration count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *simpleTableIdentifier = @"MealDiary";
    MealDiaryCell *cell = (MealDiaryCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MealDiaryCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    cell.lblTimeDuration.text = [TimeDuration objectAtIndex:[indexPath row]];
    cell.lbldesc.text = [Meal_Connent objectAtIndex:[indexPath row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MealDiaryDetailsViewController *obj=[[MealDiaryDetailsViewController alloc]init];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    DateString = [dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"DateString = %@",DateString);
    obj.myDateString = [btnDateLabel titleForState:UIControlStateNormal];
    obj.mytitle = [TimeDuration objectAtIndex:[indexPath row]];
    obj.myComment = [Meal_Connent objectAtIndex:[indexPath row]];
    obj.myObjID = [objectIDS objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:obj animated:YES];
//    [obj release];
}


-(IBAction)btnMenuClick:(id)sender
{
    
    MainMenuViewController *obj = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:[NSBundle mainBundle]];
    [self.revealSideViewController pushViewController:obj onDirection:PPRevealSideDirectionLeft withOffset:50 animated:YES];
//    [obj release];
}
-(IBAction)btnDetailClick:(id)sender
{
    MealDiaryDetailsViewController *obj = [[MealDiaryDetailsViewController alloc] initWithNibName:@"MealDiaryDetailsViewController" bundle:[NSBundle mainBundle]];
    [self.revealSideViewController pushViewController:obj onDirection:PPRevealSideDirectionRight withOffset:0 animated:YES];
//    [obj release];
}
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
