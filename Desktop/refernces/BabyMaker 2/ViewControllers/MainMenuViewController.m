//
//  MainMenuViewController.m
//  BabyMaker
//
//  Created by ajeet Singh on 12/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "MainMenuViewController.h"
#import "ViewController.h"
#import "PPRevealSideViewController.h"
#import "OvulationTrackerCalViewController.h"
#import "MensturalCycleViewController.h"
#import "MealDiaryTrackerViewController.h"
#import "MealInfoPageViewController.h"
#import "SettingsViewController.h"
#import "ExerciseLogViewController.h"
#import "StressMgtViewController.h"
#import "SupplementLogViewController.h"
#import "EducationCenterViewController.h"
#import "AMHCalculatorViewController.h"
#import "ShareViewController.h"
#import "ShareWithPatnerViewController.h"
#import "AboutViewController.h"
#import "StoreViewController.h"
#import "MainMenuCell.h"
#import "AppDelegate.h"
#import "ReminderViewController.h"
#import "SVProgressHUD.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController
@synthesize MenuListArray,arrBackground,arrIcon,idxPath,lblUserName,lblAge,userImage;
NSString *DateString,*ImagePath;
AppDelegate *app;

- (void)viewDidLoad
{
    [super viewDidLoad];
    app =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //    MenuListArray = [[NSMutableArray alloc] initWithObjects:@"Ovulation Tracker / Calender",@"Meal Diary and Tracker",@"Exercise Log and Info",@"Menstrual Cycle Info",@"Stress Management",@"Supplement Log and Info",@"Education Center",@"AMH Calculator",@"Share",@"Share With Patner",@"About",@"Store",@"Reminder",
    
    MenuListArray = [[NSMutableArray alloc] initWithObjects:@"Calendar",@"Menstrual Cycle Info",@"Meal Diary Tracker",@"Exercise Log",@"Stress Management",@"Supplement/Vitamin Info",@"Education Center",@"AMH Calculator",@"Share",@"Share With Patner",@"About",@"Store",@"Reminder", nil];
    
    arrIcon=[[NSMutableArray alloc]initWithObjects:@"ovulation_icon.png",@"menstrualInfo_icon.png",@"mealDiary_icon.png",@"exercise_icon.png", @"stress_icon.png",@"supplement_icon.png",@"education_icon.png",@"amh_icon.png",@"share_icon.png",@"sharewith_icon.png",@"about_icon.png",@"store_icon.png",@"reminder_icon.png", nil];
    
    
    
    arrBackground=[[NSMutableArray alloc]initWithObjects:@"ovulation_bg.png",@"stress_bg.png",@"mealDiary_bg.png",@"exercise_bg.png",@"menstrualInfo_bg.png",@"supplement_bg.png",@"education_bg.png",@"amh_bg.png",@"share_bg.png",@"sharewith_bg.png",@"about_bg.png",@"store_bg.png",@"reminder_bg.png", nil];
    [MainMenuTable reloadData];
    

   

    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        // code for landscape orientation
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)
        {
            NSLog(@"device is 7.0");
            [self.userImage setFrame:CGRectMake(101, 53,81 ,72)];
            [self.lblUserName setFrame:CGRectMake(43,12,196 ,21)];
            [self.lblAge setFrame:CGRectMake(106, 34,70 ,15)];
        }
        else
        {
            NSLog(@"device is 6.0");
            [self.userImage setFrame:CGRectMake(101, 53,81 ,72)];
            [self.lblUserName setFrame:CGRectMake(43,12,196 ,21)];
            [self.lblAge setFrame:CGRectMake(106, 34,70 ,15)];
            
        }
        
        [self setMenuLandscape];
          MainMenuTable.frame = CGRectMake(0,143,568,800);
        [_scrollMenu setContentSize:CGSizeMake(568, 800)];
    }
    else
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)
        {
            NSLog(@"device is 7.0");
            [self.userImage setFrame:CGRectMake(101, 53,81 ,72)];
            [self.lblUserName setFrame:CGRectMake(43,12,196 ,21)];
            [self.lblAge setFrame:CGRectMake(106, 34,70 ,15)];
        }
        else
        {
            NSLog(@"device is 6.0");
            [self.userImage setFrame:CGRectMake(101, 53,81 ,72)];
            [self.lblUserName setFrame:CGRectMake(43,12,196 ,21)];
            [self.lblAge setFrame:CGRectMake(106, 34,70 ,15)];
            
        }
         [self setMenu];
       
          MainMenuTable.frame = CGRectMake(0,143,320,800);
        [_scrollMenu setContentSize:CGSizeMake(320, 785)];
    }
    
    if (app.SelectedIndexPath!=NULL)
        [MainMenuTable selectRowAtIndexPath:app.SelectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
   
}
#pragma mark UIInterfaceOrientation method


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
   
    [self setMenuLandscape];
}
-(void)viewWillAppear:(BOOL)animated
{
    app.userImage = [UIImage imageNamed:@"defaultUser1.png"];
    
    lblAge.text = @"";
    userImage.image = app.userImage;
    lblUserName.text = app.UserName;
    
    userImage.layer.masksToBounds = YES;
    userImage.layer.cornerRadius = 10.0;
    
    
    if( [[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"])
    {
        
        app.UserName= [[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"];
        app.Age =[[NSUserDefaults standardUserDefaults] objectForKey:@"UserAge"];
        
        
        if( [[NSUserDefaults standardUserDefaults] objectForKey:@"UserImage"])
        {
            NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserImage"];
            UIImage* image = [UIImage imageWithData:imageData];
            app.userImage=image;
            
        }
        else
        {
            PFQuery *QUE = [PFQuery queryWithClassName:@"UserMst"];
            //    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
            [QUE getObjectInBackgroundWithId:[[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"] block:^(PFObject *testObject, NSError *error) {
                
                
                if ([[testObject objectForKey:@"user_image"] isEqualToString:@"---"])
                {
                    
                    //            [SVProgressHUD dismiss];
                    
                    [[NSUserDefaults standardUserDefaults] setValue:UIImagePNGRepresentation( app.userImage )forKey:@"UserImage"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                }
                else
                {
                    PFFile *userImageFile = testObject[@"imageFile"];
                    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                        if (!error) {
                            app.userImage = [UIImage imageWithData:imageData];
                            userImage.image = app.userImage;
                            
                            [[NSUserDefaults standardUserDefaults] setValue:UIImagePNGRepresentation( app.userImage )forKey:@"UserImage"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            
                        }
                        
                        //                [SVProgressHUD dismiss];
                    }];
                }
                
            }];
            
        }
        
        NSLog(@"age :: %@",app.Age);
        
        lblUserName.text = app.UserName;
        lblAge.text = [@"" stringByAppendingFormat:@"%@ Years",app.Age];
        userImage.image = app.userImage;
        
    }
    else
    {
        
        PFQuery *QUE = [PFQuery queryWithClassName:@"UserMst"];
        //    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
        [QUE getObjectInBackgroundWithId:[[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"] block:^(PFObject *testObject, NSError *error) {
            
            app.UserName = [testObject objectForKey:@"user_firstname"];
            DateString = [testObject objectForKey:@"user_dob"];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd-MM-yyyy"];
            NSDate *birthday = [dateFormatter dateFromString:DateString];
            NSDate *now = [NSDate date];
            NSDateComponents* ageComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:birthday toDate:now options:0];
            NSInteger age = [ageComponents year];
            app.Age=[NSString stringWithFormat:@"%d",age];
            
            lblAge.text = [NSString stringWithFormat:@"%@ Years",app.Age];
            lblUserName.text = app.UserName;
            
            
            NSLog(@"age :: %@",app.Age);
            
            [[NSUserDefaults standardUserDefaults] setValue:app.UserName  forKey:@"UserName"];
            [[NSUserDefaults standardUserDefaults] setValue:app.Age forKey:@"UserAge"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            if ([[testObject objectForKey:@"user_image"] isEqualToString:@"---"])
            {
                
                //            [SVProgressHUD dismiss];
                
                [[NSUserDefaults standardUserDefaults] setValue:UIImagePNGRepresentation( app.userImage )forKey:@"UserImage"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
            }
            else
            {
                PFFile *userImageFile = testObject[@"imageFile"];
                [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                    if (!error) {
                        app.userImage = [UIImage imageWithData:imageData];
                        userImage.image = app.userImage;
                        
                        [[NSUserDefaults standardUserDefaults] setValue:UIImagePNGRepresentation( app.userImage )forKey:@"UserImage"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                    }
                    
                    //                [SVProgressHUD dismiss];
                }];
            }
        }];
    }

}
-(void)setMenu
{
    int y = 130;
    
    for (int i=0; i<[MenuListArray count]; i++) {
        
        UIView *item=[[UIView alloc]initWithFrame:CGRectMake(0,y+(i*50), 320, 60)];
        [_scrollMenu addSubview:item];
        
        UIImageView *imgBg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
        [imgBg setImage:[UIImage imageNamed:[arrBackground objectAtIndex:i]]];
        [item addSubview:imgBg];
        
        UIImageView *imgIcon=[[UIImageView alloc]initWithFrame:CGRectMake(37, 10, 32, 32)];
        [imgIcon setImage:[UIImage imageNamed:[arrIcon objectAtIndex:i]]];
        [item addSubview:imgIcon];
                
        UILabel *lblTitle=[[UILabel alloc]initWithFrame:CGRectMake(85, 17, 250, 30)];
        [lblTitle setText:[MenuListArray objectAtIndex:i]];
        [lblTitle setTextColor:[UIColor whiteColor]];
        [lblTitle setBackgroundColor:[UIColor clearColor]];
        [lblTitle setFont:[UIFont boldSystemFontOfSize:17.0f]];
        [item addSubview:lblTitle];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 17, 320, 50)];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn setTag:i];
        [btn addTarget:self action:@selector(displayView:) forControlEvents:UIControlEventTouchUpInside];
        [item addSubview:btn];
    }
}

-(void)setMenuLandscape
{
    int y = 130;
    
    for (int i=0; i<[MenuListArray count]; i++) {
        
        UIView *item=[[UIView alloc]initWithFrame:CGRectMake(0,y+(i*50), self.scrollMenu.frame.size.width, 60)];
        [_scrollMenu addSubview:item];
        
        UIImageView *imgBg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.scrollMenu.frame.size.width, 60)];
        [imgBg setImage:[UIImage imageNamed:[arrBackground objectAtIndex:i]]];
        [item addSubview:imgBg];
        
        UIImageView *imgIcon=[[UIImageView alloc]initWithFrame:CGRectMake(37, 10, 32, 32)];
        [imgIcon setImage:[UIImage imageNamed:[arrIcon objectAtIndex:i]]];
        [item addSubview:imgIcon];
        
        UILabel *lblTitle=[[UILabel alloc]initWithFrame:CGRectMake(85, 15, 350, 30)];
        [lblTitle setText:[MenuListArray objectAtIndex:i]];
        [lblTitle setTextColor:[UIColor whiteColor]];
        [lblTitle setBackgroundColor:[UIColor clearColor]];
        [lblTitle setFont:[UIFont boldSystemFontOfSize:17.0f]];
        [item addSubview:lblTitle];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 15, self.scrollMenu.frame.size.width, 50)];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn setTag:i];
        [btn addTarget:self action:@selector(displayView:) forControlEvents:UIControlEventTouchUpInside];
        [item addSubview:btn];
    }
}

-(IBAction)displayView:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    if (btn.tag == 0)
    {
        app.SelectedIndexPath=[NSIndexPath indexPathWithIndex:btn.tag];
        OvulationTrackerCalViewController *obj = [[OvulationTrackerCalViewController alloc] initWithNibName:@"OvulationTrackerCalViewController" bundle:[NSBundle mainBundle]];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
        [self.revealSideViewController replaceCentralViewControllerWithNewControllerWithoutPopping:nav];
        [self.revealSideViewController popViewControllerAnimated:YES];
//        [obj release];
    }
    else if (btn.tag == 1)
    {
        app.SelectedIndexPath=[NSIndexPath indexPathWithIndex:btn.tag];
        MensturalCycleViewController *obj = [[MensturalCycleViewController alloc] initWithNibName:@"MensturalCycleViewController" bundle:[NSBundle mainBundle]];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
        [self.revealSideViewController replaceCentralViewControllerWithNewControllerWithoutPopping:nav];
        [self.revealSideViewController popViewControllerAnimated:YES];
//        [obj release];

    }
    else if (btn.tag == 2)
    {
        app.SelectedIndexPath=[NSIndexPath indexPathWithIndex:btn.tag];
        MealDiaryTrackerViewController *obj = [[MealDiaryTrackerViewController alloc] initWithNibName:@"MealDiaryTrackerViewController" bundle:[NSBundle mainBundle]];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
        [self.revealSideViewController replaceCentralViewControllerWithNewControllerWithoutPopping:nav];
        [self.revealSideViewController popViewControllerAnimated:YES];
//        [obj release];
        
        
    }
    else if (btn.tag == 3)
    {
        app.SelectedIndexPath=[NSIndexPath indexPathWithIndex:btn.tag];
        ExerciseLogViewController *obj = [[ExerciseLogViewController alloc] initWithNibName:@"ExerciseLogViewController" bundle:[NSBundle mainBundle]];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
        [self.revealSideViewController replaceCentralViewControllerWithNewControllerWithoutPopping:nav];
        [self.revealSideViewController popViewControllerAnimated:YES];
//        [obj release];
           }
    else if (btn.tag == 4)
    {
        app.SelectedIndexPath=[NSIndexPath indexPathWithIndex:btn.tag];
        StressMgtViewController *obj = [[StressMgtViewController alloc] initWithNibName:@"StressMgtViewController" bundle:[NSBundle mainBundle]];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
        [self.revealSideViewController replaceCentralViewControllerWithNewControllerWithoutPopping:nav];
        [self.revealSideViewController popViewControllerAnimated:YES];
//        [obj release];
    }
    else if (btn.tag == 5)
    {
        app.SelectedIndexPath=[NSIndexPath indexPathWithIndex:btn.tag];
        SupplementLogViewController *obj = [[SupplementLogViewController alloc] initWithNibName:@"SupplementLogViewController" bundle:[NSBundle mainBundle]];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
        [self.revealSideViewController replaceCentralViewControllerWithNewControllerWithoutPopping:nav];
        [self.revealSideViewController popViewControllerAnimated:YES];
//        [obj release];
    }
    else if (btn.tag == 6)
    {
        app.SelectedIndexPath=[NSIndexPath indexPathWithIndex:btn.tag];
        EducationCenterViewController *obj = [[EducationCenterViewController alloc] initWithNibName:@"EducationCenterViewController" bundle:[NSBundle mainBundle]];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
        [self.revealSideViewController replaceCentralViewControllerWithNewControllerWithoutPopping:nav];
        [self.revealSideViewController popViewControllerAnimated:YES];
//        [obj release];
    }
    else if (btn.tag == 7)
    {
        app.SelectedIndexPath=[NSIndexPath indexPathWithIndex:btn.tag];
        AMHCalculatorViewController *obj = [[AMHCalculatorViewController alloc] initWithNibName:@"AMHCalculatorViewController" bundle:[NSBundle mainBundle]];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
        [self.revealSideViewController replaceCentralViewControllerWithNewControllerWithoutPopping:nav];
        [self.revealSideViewController popViewControllerAnimated:YES];
//        [obj release];
    }
    else if (btn.tag == 8)
    {
        app.SelectedIndexPath=[NSIndexPath indexPathWithIndex:btn.tag];
        ShareViewController *obj = [[ShareViewController alloc] initWithNibName:@"ShareViewController" bundle:[NSBundle mainBundle]];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
        [self.revealSideViewController replaceCentralViewControllerWithNewControllerWithoutPopping:nav];
        [self.revealSideViewController popViewControllerAnimated:YES];
//        [obj release];
    }
    else if (btn.tag == 9)
    {
        app.SelectedIndexPath=[NSIndexPath indexPathWithIndex:btn.tag];
        ShareWithPatnerViewController *obj = [[ShareWithPatnerViewController alloc] initWithNibName:@"ShareWithPatnerViewController" bundle:[NSBundle mainBundle]];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
        [self.revealSideViewController replaceCentralViewControllerWithNewControllerWithoutPopping:nav];
        [self.revealSideViewController popViewControllerAnimated:YES];
//        [obj release];
    }
    else if (btn.tag == 10)
    {
        app.SelectedIndexPath=[NSIndexPath indexPathWithIndex:btn.tag];
        AboutViewController *obj = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:[NSBundle mainBundle]];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
        [self.revealSideViewController replaceCentralViewControllerWithNewControllerWithoutPopping:nav];
        [self.revealSideViewController popViewControllerAnimated:YES];
//        [obj release];
    }
    else if(btn.tag==11)
    {
        app.SelectedIndexPath=[NSIndexPath indexPathWithIndex:btn.tag];
        StoreViewController *obj = [[StoreViewController alloc] initWithNibName:@"StoreViewController" bundle:[NSBundle mainBundle]];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
        [self.revealSideViewController replaceCentralViewControllerWithNewControllerWithoutPopping:nav];
        [self.revealSideViewController popViewControllerAnimated:YES];
//        [obj release];
    }
   else
   {
       app.SelectedIndexPath=[NSIndexPath indexPathWithIndex:btn.tag];
       ReminderViewController *obj = [[ReminderViewController alloc] initWithNibName:@"ReminderViewController" bundle:[NSBundle mainBundle]];
       UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
       [self.revealSideViewController replaceCentralViewControllerWithNewControllerWithoutPopping:nav];
       [self.revealSideViewController popViewControllerAnimated:YES];
//       [obj release];
   }
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

- (void)dealloc {
//    [_scrollMenu release];
//    [super dealloc];
}
@end
