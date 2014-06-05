//
//  ViewController.m
//  BabyMaker
//
//  Created by ajeet Singh on 12/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "ViewController.h"
#import "PPRevealSideViewController.h"
#import "MainMenuViewController.h"
#import "SettingsViewController.h"
#import "AppDelegate.h"
#import "OvulationTrackerCalViewController.h"
#import "MealDiaryTrackerViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SVProgressHUD.h"

@interface ViewController ()
@end

@implementation ViewController
@synthesize checkbox, btnAccept, btnCancel, ConditionTextView, ScrollView;
@synthesize txtemail,txtpass,btnRegister,btnCancel2,btnMenu,popupView;
@synthesize SW;
@synthesize oriCenter, f;
NSMutableArray *UserEmailIDs,*UserPassword,*UserObjIDs;
NSString *AlreadyRegistered,*RegistratedObjectID;
bool checked;
AppDelegate *app;


#pragma mark
#pragma mark - View LifeCycle Methods...
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    UserEmailIDs = [[NSMutableArray alloc] init];
    UserPassword = [[NSMutableArray alloc] init];
    UserObjIDs = [[NSMutableArray alloc] init];
    popupView.hidden = YES;
    self.oriCenter = self.popupView.frame.origin;
    NSLog(@"%f, %f", oriCenter.x, oriCenter.y);
     [btnAccept setEnabled:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];

    PFQuery *QUE = [PFQuery queryWithClassName:@"UserMst"];
    [QUE findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if ([objects count]>0)
        {
            UserEmailIDs = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"user_email_id"]];
            UserPassword = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"user_password"]];
            UserObjIDs = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"objectId"]];
        }
    }];
    
    NSLog(@"FL = %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"FL"]);
    NSLog(@"objectId = %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"]);
    
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"FL"] isEqualToString:@"FL"])
    {
        [ScrollView setContentSize:CGSizeMake(ScrollView.frame.size.width, ScrollView.frame.size.height+10)];
        checked=false;
        self.title = @"Terms of Services";
        app =(AppDelegate *)[[UIApplication sharedApplication] delegate];
        [btnMenu addTarget:self action:@selector(btnMenuClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnAccept setBackgroundImage:[UIImage imageNamed:@"btn_black.png"] forState:UIControlStateSelected];
        [btnCancel setBackgroundImage:[UIImage imageNamed:@"btn_black.png"] forState:UIControlStateSelected];
        
        [txtemail setKeyboardType:UIKeyboardTypeEmailAddress];
        ConditionTextView.textAlignment = NSTextAlignmentJustified;

        [SW setOnTintColor:[UIColor colorWithRed:232/255.0f green:87/255.0f blue:131/255.0f alpha:1.00f]];
        [SW setOffTintColor:[UIColor whiteColor]];
        [SW setOn:NO animated:YES];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ToDismissKeypads)];
        [self.view addGestureRecognizer:tap];
        
        [ScrollView setFrame:CGRectMake(ScrollView.frame.origin.x, ScrollView.frame.origin.y, ScrollView.frame.size.width, ConditionTextView.frame.origin.y+ConditionTextView.frame.size.height+10)];
    }
    else
    {
         MainMenuViewController *obj = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:[NSBundle mainBundle]];
//        OvulationTrackerCalViewController *obj = [[OvulationTrackerCalViewController alloc] initWithNibName:@"OvulationTrackerCalViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:obj animated:YES];
//        [obj release];
    }
    
    ///// for custom button
//    CALayer *layer = btnRegister.layer;
//    layer.backgroundColor = [[UIColor clearColor] CGColor];
//    layer.borderColor = [[UIColor darkGrayColor] CGColor];
//    layer.cornerRadius = 8.0f;
//    layer.borderWidth = 1.0f;
    
}
-(void)viewWillAppear
{
    [ScrollView setContentSize:CGSizeMake(ScrollView.frame.size.width, ScrollView.frame.size.width+10)];
}

- (void)keyboardDidShow: (NSNotification *) notif{
    // Do something here
    UIDeviceOrientation ori = [[UIDevice currentDevice] orientation];
    if(UIDeviceOrientationIsLandscape(ori))
    {
        f = -30;
    }
    else
    {
        f =70;
    }
    [popupView setFrame:CGRectMake(popupView.frame.origin.x, f, popupView.frame.size.width, popupView.frame.size.height)];
    NSLog(@"%f, %f", popupView.frame.origin.x, popupView.frame.origin.y);
}

- (void)keyboardDidHide: (NSNotification *) notif{
    // Do something here
    UIDeviceOrientation ori = [[UIDevice currentDevice] orientation];
    if(UIDeviceOrientationIsLandscape(ori))
    {
        f = oriCenter.y-110;
    }
    else{
        f= oriCenter.y;
    }
    [popupView setFrame:CGRectMake(popupView.frame.origin.x, f, popupView.frame.size.width, popupView.frame.size.height)];
    NSLog(@"%f, %f", popupView.frame.origin.x, popupView.frame.origin.y);
}

-(IBAction)SWChanged:(id)sender
{
    if (SW.isOn)
    {
        NSLog(@"ON");
        checked=true;

        [btnAccept setEnabled:YES];
        
    }
    else
    {
        checked=false;
        NSLog(@"OFF");
        
        [btnAccept setEnabled:NO];
    }
    UIDeviceOrientation ori = [[UIDevice currentDevice] orientation];
    if(UIDeviceOrientationIsLandscape(ori))
    {
        f = oriCenter.y-110;
    }
    else{
        f= oriCenter.y;
    }
    [popupView setFrame:CGRectMake(popupView.frame.origin.x, f, popupView.frame.size.width, popupView.frame.size.height)];
     NSLog(@"%f, %f", popupView.frame.origin.x, popupView.frame.origin.y);
//    float y = 110.0f;
//    UIDeviceOrientation ori = [[UIDevice currentDevice] orientation];
//    if(UIDeviceOrientationIsLandscape(ori))
//    {
//        self.popupView.center = CGPointMake(self.oriCenter.x , oriCenter.y-115 );
//    }else {
//        self.popupView.center = oriCenter;
//    }
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    UIDeviceOrientation ori = [[UIDevice currentDevice] orientation];
    if(UIDeviceOrientationIsLandscape(ori))
    {
        f = oriCenter.y-110;
    }
    else{
        f= oriCenter.y;
    }
    [popupView setFrame:CGRectMake(popupView.frame.origin.x, f, popupView.frame.size.width, popupView.frame.size.height)];
    NSLog(@"%f, %f", popupView.frame.origin.x, popupView.frame.origin.y);
//    float y = 110.0f;
//    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
//    if(UIDeviceOrientationIsLandscape(orientation))
//    {
//        
//    } else{
//        [popupView setFrame:CGRectMake(popupView.frame.origin.x, y, popupView.frame.size.width, popupView.frame.size.height)];
//    }
}
-(IBAction)btnMenuClick:(id)sender
{
    MainMenuViewController *obj = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:[NSBundle mainBundle]];
    [self.revealSideViewController pushViewController:obj onDirection:PPRevealSideDirectionLeft withOffset:50 animated:YES completion:nil];
//    [obj release];
}
- (void)ToDismissKeypads
{
    [txtemail resignFirstResponder];
    [txtpass resignFirstResponder];
}


#pragma mark
#pragma mark - TextField Delegate Methods...
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionTransitionCurlUp animations:^{
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        
        CGRect rc = [textField bounds];
        rc = [textField convertRect:rc toView:ScrollView];
        rc.origin.x = 0 ;
        if(UIDeviceOrientationIsLandscape(orientation))
        {
            rc.origin.y = 100;
        }
        else{
        rc.origin.y = 70 ;
        }
        CGPoint pt=rc.origin;
        [self.ScrollView setContentOffset:pt animated:YES];
    }completion:nil];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionTransitionCurlUp animations:^{
        CGRect rc = [textField bounds];
        rc = [textField convertRect:rc toView:ScrollView];
        rc.origin.x = 0 ;
        rc.origin.y = 0 ;
        CGPoint pt=rc.origin;
        [self.ScrollView setContentOffset:pt animated:YES];
    }completion:nil];
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    [theTextField resignFirstResponder];
    return YES;
}
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


#pragma mark
#pragma mark - Button Click Methods...
-(IBAction)checkboxClick:(id)sender
{
    if (checked)
    {
        checked=false;
        [checkbox setBackgroundImage:[UIImage imageNamed:@"UnCheck.png"] forState:UIControlStateNormal];
    }
    else
    {
        checked=true;
        [checkbox setBackgroundImage:[UIImage imageNamed:@"toggleno.png"] forState:UIControlStateNormal];
    }
}
-(IBAction)btnAcceptClick:(id)sender
{
    if (checked)
    {
        popupView.hidden=NO;
        [ScrollView setScrollEnabled:NO];
        _imgBackView.layer.cornerRadius=1;
        [_imgBackView.layer setBorderColor:[[UIColor colorWithRed:231/255.0f green:216/255.0f blue:222/255.0f alpha:1] CGColor]];
        _imgBackView.layer.borderWidth=2;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:popupView cache:YES];
        [UIView commitAnimations];
    }
    else
    {
        UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Accept the terms"
                                                            message:@"You need to accept the Terms of Services to proceed."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];        
        [CheckAlert show];
    }
}
-(IBAction)btnCancelClick:(id)sender
{
    exit(0);
}
-(IBAction)btnRegisterClick:(id)sender
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    NSString *textEmail = [txtemail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textPass  = [txtpass.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (textEmail.length==0 || textPass.length==0)
    {
        UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Fields are Blank"
                                                            message:@"Please fill the Blank fields."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
        
        [CheckAlert show];
    }
    else
    {
        for (int i=0; i<[UserEmailIDs count]; i++)
        {
            if ([textEmail isEqualToString:[UserEmailIDs objectAtIndex:i]])
            {
                if ([textPass isEqualToString:[UserPassword objectAtIndex:i]])
                {
                    AlreadyRegistered = @"YES";
                    RegistratedObjectID = [UserObjIDs objectAtIndex:i];
                    NSLog(@"RegistratedObjectID = %@",RegistratedObjectID);
                }
                else
                {
                    AlreadyRegistered = @"BUT";
                }
            }
        }
        
        BOOL isValid = [self NSStringIsValidEmail:txtemail.text];
        if (isValid)
        {
            if ([AlreadyRegistered isEqualToString:@"YES"])
            {
                [[NSUserDefaults standardUserDefaults] setValue:RegistratedObjectID forKey:@"objectId"];
                [[NSUserDefaults standardUserDefaults] setValue:@"FL" forKey:@"FL"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                                UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Welcome"
                                                                    message:@"Login Successfully with Registrated Email-id"
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                [CheckAlert show];
                MainMenuViewController *obj = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:[NSBundle mainBundle]];
                
                //                OvulationTrackerCalViewController *obj = [[OvulationTrackerCalViewController alloc] initWithNibName:@"OvulationTrackerCalViewController" bundle:[NSBundle mainBundle]];
                [self.navigationController pushViewController:obj animated:YES];
//                [obj release];
            }
            else if ([AlreadyRegistered isEqualToString:@"BUT"])
            {
                UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Warning, Wrong Password."
                                                                    message:@"Wrong Password of already Registrated Email-id"
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                [CheckAlert show];
            }
            else
            {
                [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
                PFObject *testObject = [PFObject objectWithClassName:@"UserMst"];
                [testObject setObject:textEmail forKey:@"user_email_id"];
                [testObject setObject:textPass forKey:@"user_password"];
                [testObject save];
                app.ObjID = testObject.objectId;
                [[NSUserDefaults standardUserDefaults] setValue:testObject.objectId forKey:@"objectId"];
                [[NSUserDefaults standardUserDefaults] setValue:@"FL" forKey:@"FL"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                NSLog(@"FL = %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"FL"]);
                NSLog(@"objectId = %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"]);
                NSLog(@"1.App.ObjID = %@",app.ObjID);
                
                [SVProgressHUD dismiss];
                SettingsViewController *obj=[[SettingsViewController alloc]init];
                obj.FromWhere=@"TERM";
                [self.navigationController pushViewController:obj animated:YES];
//                [obj release];
            
            }
            
            
        }
        else
        {
            UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Invalid Email Id"
                                                                message:@"Please enter proper Email ID."
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];            
            [CheckAlert show];
        }
    }
    [SVProgressHUD dismiss];
//    SettingsViewController *obj=[[SettingsViewController alloc]init];
//    obj.FromWhere=@"TERM";
//    [self.navigationController pushViewController:obj animated:YES];
//    [obj release];

}
-(IBAction)btnCancel2Click:(id)sender
{
    popupView.hidden = YES;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:popupView cache:YES];
    [UIView commitAnimations];
    [ScrollView setScrollEnabled:YES];
}




- (void)dealloc {
//    [_imgBackView release];
//    [super dealloc];
}
@end
