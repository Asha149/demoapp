//
//  MealDiaryDetailsViewController.m
//  BabyMaker
//
//  Created by ajeet Singh on 15/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "MealDiaryDetailsViewController.h"
#import "MainMenuViewController.h"
#import "MealInfoPageViewController.h"
#import "PPRevealSideViewController.h"
#import "MealDiaryTrackerViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface MealDiaryDetailsViewController ()

@end

@implementation MealDiaryDetailsViewController
@synthesize btnBack,btnInfo,btnDone,btnCancel,lblDate,CommentTexView,Scroll,myDateString,lbltitle,mytitle,lblTime,myComment,myObjID,isToEdit;
AppDelegate *app;

#pragma mark
#pragma mark - View-lifeCycle Methods...
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    app =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [Scroll setContentSize:CGSizeMake(320, 500)];
//    CommentTexView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"border2.png"]];
    [btnBack addTarget:self action:@selector(btnBackClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnInfo addTarget:self action:@selector(btnInfoClick:) forControlEvents:UIControlEventTouchUpInside];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    DateToDisplayFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    [DateToDisplayFormatter setDateFormat:@"dd MMMM, yyyy"];
    
    lblDate.text = myDateString;
    lbltitle.text = mytitle;
    if ([myComment isEqualToString:@"---"])
    {
        CommentTexView.text = @"";
        isToEdit=@"NO";
    }
    else
    {
        CommentTexView.text = myComment;
        isToEdit=@"YES";
    }    
    
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    dateFormatter2.dateFormat = @"hh:mm a";
    lblTime.text = [dateFormatter2 stringFromDate:now];
    
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
                [CommentTexView setFrame:CGRectMake(CommentTexView.frame.origin.x, CommentTexView.frame.origin.y, CommentTexView.frame.size.width, CommentTexView.frame.size.height+80)];
                [btnDone setFrame:CGRectMake(btnDone.frame.origin.x, btnDone.frame.origin.y+80, btnDone.frame.size.width, btnDone.frame.size.height)];
                [btnCancel setFrame:CGRectMake(btnCancel.frame.origin.x, btnCancel.frame.origin.y+80, btnCancel.frame.size.width, btnCancel.frame.size.height)];
            }
        }
        else{
            NSLog(@"Standard Resolution");
        }
    }
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ToDismissPickers)];
//    [self.view addGestureRecognizer:tap];
    
    [CommentTexView setInputAccessoryView:self.toolBar];
}
- (void)ToDismissPickers
{
    [CommentTexView resignFirstResponder];
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
//-(void)textViewDidChange:(UITextView *)textView
//{
//    CGFloat fontHeight = (textView.font.ascender - textView.font.descender) + 1;
//    CGRect newTextFrame = textView.frame;
//    newTextFrame.size = textView.contentSize;
//    newTextFrame.size.height = newTextFrame.size.height + fontHeight;
//    textView.frame = newTextFrame;
//}



#pragma mark
#pragma mark - Button Click Methods...
-(IBAction)btnBackClick:(id)sender
{
    [self ToDismissPickers];
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)btnInfoClick:(id)sender
{    
    MealInfoPageViewController *obj=[[MealInfoPageViewController alloc]init];
    [self.navigationController pushViewController:obj animated:YES];
//    [obj release];    
}
-(IBAction)btnDoneClick:(id)sender
{
    NSString *CommentTexViewString = [CommentTexView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (CommentTexViewString.length==0)
    {
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"Comment Field is Blank" message:@"Please, Enter any comment for the Day." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Alert show];
//        [Alert release];
    }
    else
    {
        if ([isToEdit isEqualToString:@"YES"])
        {
            PFQuery *query = [PFQuery queryWithClassName:@"MealInfo"];
            [query getObjectInBackgroundWithId:myObjID block:^(PFObject *testObject, NSError *error) {
                
                [testObject setObject:CommentTexViewString forKey:@"meal_comment"];
                app.objID = testObject.objectId;
                [testObject save];
                
//                MealDiaryTrackerViewController *obj=[[MealDiaryTrackerViewController alloc]init];
//                [self.navigationController pushViewController:obj animated:NO];
////                [obj release];
//                CATransition *animation = [CATransition animation];
//                [animation setDuration:0.3];
//                [animation setType:kCATransitionPush];
//                [animation setSubtype:kCATransitionFromLeft];
//                [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
//                [[obj.view layer] addAnimation:animation forKey:@"rightToLeftAnimation"];
            }];
        }
        else
        {
            NSDate *Dat = [DateToDisplayFormatter dateFromString:myDateString];
            NSString *DateToDisplay = [dateFormatter stringFromDate:Dat];
            
            NSString *objIDFromUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"];
            NSLog(@"objIDFromUserDefaults = %@",objIDFromUserDefaults);
            
            
            
            
            PFObject *testObject = [PFObject objectWithClassName:@"MealInfo"];
            [testObject setObject:DateToDisplay forKey:@"meal_date"];
            [testObject setObject:lblTime.text forKey:@"meal_time"];
            [testObject setObject:lbltitle.text forKey:@"meal_title"];
            [testObject setObject:CommentTexViewString forKey:@"meal_comment"];
            [testObject setObject:objIDFromUserDefaults forKey:@"meal_user_id"];
            [testObject save];
            app.ObjID = testObject.objectId;
            
//            MealDiaryTrackerViewController *obj=[[MealDiaryTrackerViewController alloc]init];
//            [self.navigationController pushViewController:obj animated:NO];
//            [obj release];
//            CATransition *animation = [CATransition animation];
//            [animation setDuration:0.3];
//            [animation setType:kCATransitionPush];
//            [animation setSubtype:kCATransitionFromLeft];
//            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
//            [[obj.view layer] addAnimation:animation forKey:@"rightToLeftAnimation"];
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
-(IBAction)btnCancelClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnMinimize_Click:(id)sender {
    [CommentTexView resignFirstResponder];
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

@end
