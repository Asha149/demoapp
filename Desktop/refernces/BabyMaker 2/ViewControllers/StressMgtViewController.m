//
//  StressMgtViewController.m
//  BabyMaker
//
//  Created by ajeet Singh on 14/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "StressMgtViewController.h"
#import "MainMenuViewController.h"
#import "PPRevealSideViewController.h"
#import "SVProgressHUD.h"

@interface StressMgtViewController ()

@end

@implementation StressMgtViewController
@synthesize btnMenu,btnPrevious,btnNext,Scroll,lblDate,QuoteTextView,DescriptionTextView,myDateString,Cal,QuoteArray,btnDate,btnAddEdit;
NSMutableArray *abc;
UIView *CalendarView;
NSString *str,*strID;

#pragma mark
#pragma mark - View-lifeCycle Methods...
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [Scroll setContentSize:CGSizeMake(320, Scroll.frame.size.height)];
    [btnMenu addTarget:self action:@selector(btnMenuClick:) forControlEvents:UIControlEventTouchUpInside];
    QuoteArray = [[NSMutableArray alloc] init];
    
    [DescriptionTextView setInputAccessoryView:self.toolbar];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyy"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    myDateString = [dateFormatter stringFromDate:[NSDate date]];
    DateToDisplayFormatter = [[NSDateFormatter alloc]init];
    [DateToDisplayFormatter setDateFormat:@"dd MMMM, yyyy"];
    NSString *DateTODisplay = [DateToDisplayFormatter stringFromDate:[NSDate date]];
    [btnDate setTitle:DateTODisplay forState:UIControlStateNormal];
    
    PFQuery *query = [PFQuery queryWithClassName:@"QuoteMst"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error)
        {
            abc = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"quote_description"]];
            QuoteTextView.text=[abc objectAtIndex:0];
            
//            if (!([[btnDate titleForState:UIControlStateNormal] isEqualToString:[dateFormatter stringFromDate:[NSDate date]]]))
//            {
//                NSUInteger randomIndex = arc4random_uniform(abc.count);
//                NSString *randomString = abc[randomIndex];
//                QuoteTextView.text = randomString;
//            }
        }
        else
        {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
    }];
    
    [self Querring];
    
    Cal = [[TKCalendarMonthView alloc]init];
    Cal.delegate = self;
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        CalendarView = [[UIView alloc] initWithFrame:CGRectMake(124, 105, 320, Cal.frame.size.height)];
    }
    else
    {
     CalendarView = [[UIView alloc] initWithFrame:CGRectMake(0, 105, 320, Cal.frame.size.height)];
    }
    
//    [CalendarView setBackgroundColor:[UIColor whiteColor]];
    [CalendarView addSubview:Cal];
    [self.Scroll addSubview:CalendarView];
    [CalendarView setHidden:YES];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)])
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            CGFloat scale = [UIScreen mainScreen].scale;
            result = CGSizeMake(result.width * scale, result.height * scale);
            
            if(result.height == 960)
            {
                NSLog(@"iPhone 4 Resolution");
                
            }
            if(result.height == 1136)
            {
                NSLog(@"iPhone 5 Resolution");
                [DescriptionTextView setFrame:CGRectMake(DescriptionTextView.frame.origin.x, DescriptionTextView.frame.origin.y, DescriptionTextView.frame.size.width, 280)];
            }
        }
        else{
            NSLog(@"Standard Resolution");
        }
    }
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        CalendarView = [[UIView alloc] initWithFrame:CGRectMake(124, 105, 320, Cal.frame.size.height)];
    }
    else
    {
        CalendarView = [[UIView alloc] initWithFrame:CGRectMake(0, 105, 320, Cal.frame.size.height)];
    }

}
-(void)Querring
{
    ///---
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    NSDate *Dat = [DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]];
    NSString *DateToDisplay = [dateFormatter stringFromDate:Dat];
    
    NSString *objIDFromUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"];
    NSLog(@"objIDFromUserDefaults = %@",objIDFromUserDefaults);
    
    PFQuery *QUE = [PFQuery queryWithClassName:@"StressMgt"];
    [QUE whereKey:@"stress_user_id" equalTo:objIDFromUserDefaults];
    [QUE whereKey:@"stress_date" equalTo:DateToDisplay];
    [QUE findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if ([objects count]>0)
        {
            NSLog(@"Objects = %@",objects);
            NSMutableArray *stress_description = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"stress_description"]];
            DescriptionTextView.text = [stress_description objectAtIndex:0];
            
            NSMutableArray *objectId = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"objectId"]];
            strID = [objectId objectAtIndex:0];
            str=@"ToEdit";
        }
        else
        {
            str=@"---";
            DescriptionTextView.text=@"";
        }
        [SVProgressHUD dismiss];
    }];
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
        [btnDate setTitle:[DateToDisplayFormatter stringFromDate:d] forState:UIControlStateNormal];
    }
//    NSLog(@"date == %@",d);
    
    [btnDate setEnabled:YES];
    [btnPrevious setEnabled:YES];
    [btnNext setEnabled:YES];
    [CalendarView setHidden:YES];
    [_detailView setHidden:NO];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:CalendarView cache:YES];
    [UIView commitAnimations];
    
    [self Querring];
}


#pragma mark
#pragma mark - Button Click Methods...
-(IBAction)btnDateClick:(id)sender
{
    [self save];
    [btnDate setEnabled:NO];
    [btnPrevious setEnabled:NO];
    [btnNext setEnabled:NO];
    [CalendarView setHidden:NO];
    [_detailView setHidden:YES];
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init] ;
    dayComponent.day = 1;
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    [Cal selectDate:[theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]] options:0]];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:CalendarView cache:YES];
    [UIView commitAnimations];
}

-(IBAction)btnPreviousClick:(id)sender
{
    [self save];
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = -1;
        
    NSUInteger randomIndex = arc4random_uniform(abc.count);
    NSString *randomString = abc[randomIndex];
    QuoteTextView.text = randomString;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    [Cal selectDate:[DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]]];
    
    [btnDate setTitle:[DateToDisplayFormatter stringFromDate:[theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]] options:0]] forState:UIControlStateNormal];

    [self Querring];
}

-(IBAction)btnNextClick:(id)sender
{
    [self save];
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 1;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    
    NSDate *today = [NSDate date];
    NSDate *newDate = [theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]] options:0];
    
    NSComparisonResult result=[today compare:newDate];
    
    if(result==NSOrderedAscending)
    {
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Can not enter stress management information for future dates." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Alert show];
//        [Alert release];
    }
    else
    {
        NSUInteger randomIndex = arc4random_uniform(abc.count);
        NSString *randomString = abc[randomIndex];
        QuoteTextView.text = randomString;
        
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        [btnDate setTitle:[DateToDisplayFormatter stringFromDate:[theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]] options:0]] forState:UIControlStateNormal];
        [Cal selectDate:[theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]] options:0]];
        [self Querring];
    }
}

-(void)save
{
    NSString *DescriptionTextViewString = [DescriptionTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([str isEqualToString:@"ToEdit"])
    {
        str=@"---";
        if (DescriptionTextViewString.length==0)
        {
//            UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"Description is Blank" message:@"Please, Enter any Description for the Day." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [Alert show];
            //            [Alert release];
        }
        else
        {
            PFQuery *query = [PFQuery queryWithClassName:@"StressMgt"];
            [query getObjectInBackgroundWithId:strID block:^(PFObject *testObject, NSError *error) {
                
                [testObject setObject:DescriptionTextViewString forKey:@"stress_description"];
                [testObject save];
            }];
        }
    }
    else
    {
        str=@"ToEdit";
        if (DescriptionTextViewString.length==0)
        {
//            UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"Description is Blank" message:@"Please, Enter any Description for the Day." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [Alert show];
            //            [Alert release];
        }
        else
        {
            ///---
            NSDate *Dat = [DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]];
            NSString *DateToDisplay = [dateFormatter stringFromDate:Dat];
            
            NSString *objIDFromUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"];
            NSLog(@"objIDFromUserDefaults = %@",objIDFromUserDefaults);
            
            PFObject *testObject = [PFObject objectWithClassName:@"StressMgt"];
            [testObject setObject:DateToDisplay forKey:@"stress_date"];
            [testObject setObject:DescriptionTextViewString forKey:@"stress_description"];
            [testObject setObject:objIDFromUserDefaults forKey:@"stress_user_id"];
            [testObject save];
            UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"Save" message:@"Your Description is Stored." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [Alert show];
            //            [Alert release];
        }
    }

}

-(IBAction)btnAddEditClick:(id)sender
{
    [self save];
}

- (IBAction)btnMinimize_Click:(id)sender {
    [self.DescriptionTextView resignFirstResponder];
}

-(IBAction)btnMenuClick:(id)sender
{
    [DescriptionTextView resignFirstResponder];
    MainMenuViewController *obj = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:[NSBundle mainBundle]];
    [self.revealSideViewController pushViewController:obj onDirection:PPRevealSideDirectionLeft withOffset:50 animated:YES];
//    [obj release];
}


#pragma mark
#pragma mark - TextView Delegate Methods...
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionTransitionCurlUp animations:^{
        CGRect rc = [textView bounds];
        rc = [textView convertRect:rc toView:Scroll];
        rc.origin.x = 0 ;
        rc.origin.y = 110 ;
        CGPoint pt=rc.origin;
        [self.Scroll setContentOffset:pt animated:YES];
    }completion:nil];
}
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if([text isEqualToString:@"\n"])
//    {
//        [textView resignFirstResponder];
//    }
//    return YES;
//}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionTransitionCurlUp animations:^{
        CGRect rc = [textView bounds];
        rc = [textView convertRect:rc toView:Scroll];
        rc.origin.x = 0 ;
        rc.origin.y = 0 ;
        CGPoint pt=rc.origin;
        [self.Scroll setContentOffset:pt animated:YES];
    }completion:nil];
}

//- (void)ToDismissPickers
//{
//    [DescriptionTextView resignFirstResponder];
//}

//-(void)textViewDidChange:(UITextView *)textView
//{
//    CGFloat fontHeight = (textView.font.ascender - textView.font.descender) + 1;
//    CGRect newTextFrame = textView.frame;
//    newTextFrame.size = textView.contentSize;
//    newTextFrame.size.height = newTextFrame.size.height + fontHeight;
//    textView.frame = newTextFrame;
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

- (void)dealloc {
//    [_detailView release];
//    [super dealloc];
}
@end
