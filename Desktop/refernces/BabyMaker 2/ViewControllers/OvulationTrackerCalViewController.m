//
//  OvulationTrackerCalViewController.m
//  BabyMaker
//
//  Created by ajeet Singh on 14/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "OvulationTrackerCalViewController.h"
#import "MainMenuViewController.h"
#import "PPRevealSideViewController.h"
//#import "CheckmarkTile.h"
#import "SettingsViewController.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "MensturalCycleViewController.h"

//#import "TKCalendarMonthView.m"
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-480)?NO:YES)
@interface OvulationTrackerCalViewController ()

@end

@implementation OvulationTrackerCalViewController
@synthesize Scroll,btnMenu,btnSettings,sparkline,indexPath,DipDate;
@synthesize arrDates,selectedIndex;
@synthesize weekView;
@synthesize viewHeading,img;

TKCalendarMonthView *Cal;
AppDelegate *app;
NSString *DateString;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    app =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    arrCalDetails=[[NSMutableArray alloc]init];
    [Scroll setDelegate:self];
    [Scroll setScrollEnabled:YES];
    [Scroll setContentSize:CGSizeMake(320, Scroll.frame.size.height+20)];
    [Scroll setBackgroundColor:[UIColor clearColor]];
    [btnMenu addTarget:self action:@selector(btnMenuClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnSettings addTarget:self action:@selector(btnSettingsClick:) forControlEvents:UIControlEventTouchUpInside];
    DipDate=@"";
    
    Cal = [[TKCalendarMonthView alloc]init];
    Cal.delegate = self;
    Cal.dataSource = self;
    [Cal setBackgroundColor:[UIColor clearColor]];
    
    
      [Scroll setBackgroundColor:[UIColor clearColor]];
    [Cal reload];
    
    arrDates=[[NSMutableArray alloc]init];
    [self setDateArray];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
        // code
        NSLog(@"device is 7.0");
        //  [self.lblPhrase setFrame:CGRectMake(self.lblPhrase.frame.origin.x, self.lblPhrase.frame.origin.y+30, self.lblPhrase.frame.size.width, self.lblPhrase.frame.size.height)];
        [self.img setFrame:CGRectMake(0, 0,568,20)];
        [self.viewHeading setFrame:CGRectMake(0, 20,  self.viewHeading.frame.size.width, self.viewHeading.frame.size.height)];
 
    }
    else
    {
        NSLog(@"device is 6.0");
        [img setHidden:YES];
        [self.viewHeading setFrame:CGRectMake(0, 0,  self.viewHeading.frame.size.width, self.viewHeading.frame.size.height)];

    }
//    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
//    {
//         sparkline = [[CKSparkline alloc] initWithFrame:CGRectMake(144, 300, 300, 150)];
//    }
//    else
//    {
        sparkline = [[CKSparkline alloc] initWithFrame:CGRectMake(20, 350, 300, 150)];
//    }
    [sparkline setBackgroundColor:[UIColor clearColor]];
    self.sparkline.lineColor = [UIColor grayColor];
    self.sparkline.lineWidth = 3.0;
    self.sparkline.drawPoints = YES;
    self.sparkline.drawArea = YES;
    
    
    //New Calendar
    if (app.ObjID.length==0) {
        app.ObjID=[[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"];
    }
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger monthInt = [components month];
    NSInteger yearInt = [components year];
    NSInteger NewmonthInt;
    NSInteger NewyearInt;
    if ([components month]==1)
    {
        NewmonthInt = [components month]+11;
        NewyearInt = [components year]-1;
    }
    else
    {
        NewmonthInt = [components month]-1;
        NewyearInt = [components year];
    }
    
    NSString *objIDFromUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"];
//    NSLog(@"objIDFromUserDefaults = %@",objIDFromUserDefaults);
    
    PFQuery *query = [PFQuery queryWithClassName:@"MensturalCycleInfo"];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [query whereKey:@"menstural_user_id" equalTo:objIDFromUserDefaults];
    [query orderByAscending:@"menstural_date"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        NSArray *menstural_date = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_date"]];
        NSArray *menstural_temperature = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_temperature"]];
        NSMutableArray *mensturalTemperature = [[NSMutableArray alloc]init];
        NSMutableArray *mensturalDate = [[NSMutableArray alloc]init];
        
        for (int i = 0; i<[menstural_date count]; i++)
        {
            NSString *yearString = [[menstural_date objectAtIndex:i] substringWithRange:NSMakeRange(6, 4)];
            NSString *monthString = [[menstural_date objectAtIndex:i] substringWithRange:NSMakeRange(3, 2)];
            int intMonth = [monthString intValue];
            int intYear = [yearString intValue];
            if (monthInt==intMonth && yearInt==intYear)
            {
                [mensturalTemperature addObject:[menstural_temperature objectAtIndex:i]];
                [mensturalDate addObject:[menstural_date objectAtIndex:i]];
            }
        }
        if ([mensturalTemperature count]==0)
        {
            [sparkline removeFromSuperview];
        }
        else
        {
//            NSLog(@"Menstural Temperature = %@", mensturalTemperature);
//            NSLog(@"Menstural Date = %@", mensturalDate);
            
                self.sparkline.data = mensturalTemperature;
                UILabel *lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(-55, 80, 100, 20)];
                [lbl1 setText:@"Temperature --->"];
                [lbl1 setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                [lbl1 setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
                UILabel *lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 147, 100, 20)];
                [lbl2 setText:@"Days --->"];
                [lbl2 setFont:[UIFont fontWithName:@"Helvetica" size:12]];
                [sparkline addSubview:lbl1];
                [sparkline addSubview:lbl2];
                [Scroll addSubview:sparkline];
                [Scroll bringSubviewToFront:sparkline];
            
        }
//        UIGraphicsBeginImageContext(self.Scroll.frame.size);
//        [self.Scroll.layer renderInContext:UIGraphicsGetCurrentContext()];
//        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        app.OvulationImage = viewImage;

        UIGraphicsBeginImageContext(self.sparkline.frame.size);
        [self.sparkline.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
//        CGRect rect = CGRectMake(0,300,320,200);
//        CGImageRef imageRef = CGImageCreateWithImageInRect([viewImage CGImage], rect);
//        UIImage *newImg = [UIImage imageWithCGImage:imageRef];
        app.OvulationImage=viewImage;
      
        [SVProgressHUD dismiss];
    }];
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"MensturalCycleInfo"];
    [query2 whereKey:@"menstural_user_id" equalTo:objIDFromUserDefaults];
    [query2 orderByAscending:@"menstural_date"];
    [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        NSArray *menstural_date = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_date"]];
        NSArray *menstural_temperature = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_temperature"]];
        NSMutableArray *mensturalTemperature = [[NSMutableArray alloc]init];
        NSMutableArray *mensturalDate = [[NSMutableArray alloc]init];
        
        for (NSObject *obj in objects) {
            [self setCalendarDetails:obj];
        }
        self.Calendar=[[CKCalendarView alloc]initWithStartDay:startMonday];
        self.Calendar.delegate=self;
        [self.Calendar setBackgroundColor:[UIColor whiteColor]];
        self.Calendar.onlyShowCurrentMonth=NO;
        self.Calendar.adaptHeightToNumberOfWeeksInMonth=YES;
//        if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
//        {
//            [self.Calendar setFrame:CGRectMake(124, 10, 320, 320)];
//        }
//        else
//        {
            [self.Calendar setFrame:CGRectMake(0, 10, 320, 320)];
//        }
        [Scroll addSubview:self.Calendar];

        
        for (int i = 0; i<[menstural_date count]; i++)
        {
            NSString *yearString = [[menstural_date objectAtIndex:i] substringWithRange:NSMakeRange(6, 4)];
            NSString *monthString = [[menstural_date objectAtIndex:i] substringWithRange:NSMakeRange(3, 2)];
            int intMonth = [monthString intValue];
            int intYear = [yearString intValue];
            if (NewmonthInt==intMonth && NewyearInt==intYear)
            {
                [mensturalTemperature addObject:[menstural_temperature objectAtIndex:i]];
                [mensturalDate addObject:[menstural_date objectAtIndex:i]];
            }
        }
//        NSLog(@"New Menstural Temperature = %@", mensturalTemperature);
//        NSLog(@"New Menstural Date = %@", mensturalDate);
        if (mensturalTemperature.count>5)
        {
            int abc=[self OvulationDate:mensturalTemperature];
            if (!(abc>[mensturalTemperature count]))
            {
                DipDate=[mensturalDate objectAtIndex:abc];
//                NSLog(@"New DipDate = %@",DipDate);
            }
            [Cal reload];
        }
        else
        {
//            NSLog(@"Less Then 5 Data...");
        }
        [SVProgressHUD dismiss];
    }];
    
    PFQuery *QUE = [PFQuery queryWithClassName:@"UserMst"];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [QUE getObjectInBackgroundWithId:[[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"] block:^(PFObject *testObject, NSError *error) {
        
        app.UserName = [testObject objectForKey:@"user_firstname"];
        DateString = [testObject objectForKey:@"user_dob"];
        
        if ([[testObject objectForKey:@"user_image"] isEqualToString:@"---"])
        {
            app.userImage = [UIImage imageNamed:@"defaultUser.png"];
            [SVProgressHUD dismiss];
        }
        else
        {
            PFFile *userImageFile = testObject[@"imageFile"];
            [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                if (!error) {
                    app.userImage = [UIImage imageWithData:imageData];
                }
                [SVProgressHUD dismiss];
            }];
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        NSDate* birthday = [dateFormatter dateFromString:DateString];
        NSDate* now = [NSDate date];
        NSDateComponents* ageComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:birthday toDate:now options:0];
        NSInteger age = [ageComponents year];
//        NSLog(@"Age = %d",age);
        app.Age=[NSString stringWithFormat:@"%d",age];
        
        [SVProgressHUD dismiss];
    }];
    
    [self setDateScroll];
}

#pragma mark UIInterfaceOrientation method

-(void)setCalendarDetails:(NSObject *)object
{
    NSLog(@"Object : %@",object);
    NSString *mps=[object valueForKey:@"menstural_mps"];
    NSString *intercourse=[object valueForKey:@"menstural_intercourse"];
    NSString *opk=[object valueForKey:@"menstural_opk"];
    NSString *pregnancy=[object valueForKey:@"menstural_pregnency_test"];
    NSString *frening=[object valueForKey:@"menstural_frening_test"];
    NSString *notes=[object valueForKey:@"menstural_notes"];
    
    if (mps.length!=0) {
        if ([mps isEqualToString:@"Heavy"] || [mps isEqualToString:@"Medium"] || [mps isEqualToString:@"Light"] || [mps isEqualToString:@"Spotting Red"] || [mps isEqualToString:@"Spotting Brown"]) {
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:[object valueForKey:@"menstural_date"] forKey:@"date"];
            if ([mps isEqualToString:@"Heavy"]) {
                [dict setValue:@"High" forKey:@"type"];
            }
            else if ([mps isEqualToString:@"Medium"]) {
                [dict setValue:@"Medium" forKey:@"type"];
            }
            else if ([mps isEqualToString:@"Light"]) {
                [dict setValue:@"Light" forKey:@"type"];
            }
            else if ([mps isEqualToString:@"Spotting Red"]) {
                [dict setValue:@"Spotting Red" forKey:@"type"];
            }
            else if ([mps isEqualToString:@"Spotting Brown"]) {
                [dict setValue:@"Spotting Brown" forKey:@"type"];
            }
            [arrCalDetails addObject:dict];
        }
        
    }
    
    if (intercourse.length!=0) {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setValue:[object valueForKey:@"menstural_date"] forKey:@"date"];
        [dict setValue:@"Intercourse" forKey:@"type"];
        [arrCalDetails addObject:dict];
    }
    
    if (opk.length!=0) {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setValue:[object valueForKey:@"menstural_date"] forKey:@"date"];
        if ([opk isEqualToString:@"Strong Positive"]) {
            [dict setValue:@"Strong Positive" forKey:@"type"];
        }
        else if ([opk isEqualToString:@"Faint Positive"]) {
            [dict setValue:@"Faint Positive" forKey:@"type"];
        }
        else if ([opk isEqualToString:@"Negative"]) {
            [dict setValue:@"Faint Positive" forKey:@"type"];
        }
        [arrCalDetails addObject:dict];
    }
    
    if (pregnancy.length!=0) {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setValue:[object valueForKey:@"menstural_date"] forKey:@"date"];
        if ([pregnancy isEqualToString:@"Positive"]) {
            [dict setValue:@"Positive" forKey:@"type"];
        }
        else if ([pregnancy isEqualToString:@"Negative"]) {
            [dict setValue:@"Negative" forKey:@"type"];
        }
        [arrCalDetails addObject:dict];
    }
    
    if (frening.length!=0) {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setValue:[object valueForKey:@"menstural_date"] forKey:@"date"];
        if ([frening isEqualToString:@"Full"]) {
            [dict setValue:@"Full" forKey:@"type"];
        }
        else if ([frening isEqualToString:@"Partial"]) {
            [dict setValue:@"Partial" forKey:@"type"];
        }
        else if ([frening isEqualToString:@"Pebbles"]) {
            [dict setValue:@"Pebbles" forKey:@"type"];
        }
        [arrCalDetails addObject:dict];
    }
    
    if ([notes rangeOfString:@"miscarriage" options:NSCaseInsensitiveSearch].location == NSNotFound) {
        NSLog(@"string does not contain bla");
    } else {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setValue:[object valueForKey:@"menstural_date"] forKey:@"date"];
        [dict setValue:@"Miscarriage" forKey:@"type"];
        [arrCalDetails addObject:dict];
    }
}

-(NSMutableArray *)dateType:(NSDate *)date{
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    for (int i=0; i<arrCalDetails.count; i++) {
        NSMutableDictionary *dict=[arrCalDetails objectAtIndex:i];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        
        if ([[dict objectForKey:@"date"] isEqualToString:[dateFormatter stringFromDate:date]]) {
            [arr addObject:[dict objectForKey:@"type"]];
        }
    }
    return arr;
}

#pragma mark -
#pragma mark - CKCalendarDelegate
- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
    // TODO: play with the coloring if we want to...
//    if ([self dateIsDisabled:date]) {
//        dateItem.backgroundColor = [UIColor redColor];
//        dateItem.textColor = [UIColor whiteColor];
//    }
    NSMutableArray *result=[self dateType:date];
    if (result.count==0) {

    }
    else{
        NSMutableArray *arrImages=[[NSMutableArray alloc]init];
        for (int i=0; i<result.count; i++) {
            NSString *type=[result objectAtIndex:i];
            if ([type isEqualToString:@"High"]) {
                [arrImages addObject:[UIImage imageNamed:@"cal_Dark-Red.png"]];
            }
            else if ([type isEqualToString:@"Medium"]){
                [arrImages addObject:[UIImage imageNamed:@"cal_medium-red.png"]];
            }
            else if ([type isEqualToString:@"Light"]){
                [arrImages addObject:[UIImage imageNamed:@"cal_Light-red.png"]];
            }
            else if ([type isEqualToString:@"Spotting Red"]){
                [arrImages addObject:[UIImage imageNamed:@"red.png"]];
            }
            else if ([type isEqualToString:@"Spotting Brown"]){
                [arrImages addObject:[UIImage imageNamed:@"brown.png"]];
            }
            else if ([type isEqualToString:@"Intercourse"]){
                [arrImages addObject:[UIImage imageNamed:@"small-heart.png"]];
            }
            else if ([type isEqualToString:@"Strong Positive"]){
                [arrImages addObject:[UIImage imageNamed:@"plus_left.png"]];
            }
            else if ([type isEqualToString:@"Faint Positive"]){
                [arrImages addObject:[UIImage imageNamed:@"plus_small_left.png"]];
            }
            else if ([type isEqualToString:@"Positive"]){
                [arrImages addObject:[UIImage imageNamed:@"pg+.png"]];
            }
            else if ([type isEqualToString:@"Negative"]){
                [arrImages addObject:[UIImage imageNamed:@"pg-.png"]];
            }
            else if ([type isEqualToString:@"Full"]){
                [arrImages addObject:[UIImage imageNamed:@"F.png"]];
            }
            else if ([type isEqualToString:@"Partial"]){
                [arrImages addObject:[UIImage imageNamed:@"PF.png"]];
            }
            else if ([type isEqualToString:@"Pebbles"]){
                [arrImages addObject:[UIImage imageNamed:@"P.png"]];
            }
            else if ([type isEqualToString:@"Miscarriage"]){
                [arrImages addObject:[UIImage imageNamed:@"MC.png"]];
            }
            else{

            }
        }
        if (arrImages.count>=1) {
            [dateItem setBackgroundColor:[UIColor colorWithPatternImage:[self blendImages:arrImages]]];
            [dateItem setTextColor:[UIColor whiteColor]];
        }
//        else if (arrImages.count==1){
//            [dateItem setBackgroundColor:[UIColor colorWithPatternImage:[arrImages objectAtIndex:0]]];
//        }
        else{
            [dateItem setBackgroundColor:[UIColor clearColor]];
        }
    }
}

-(UIImage *)blendImages:(NSMutableArray *)array{
    
//    UIImage *temp_img=[array objectAtIndex:0];
//    CGSize size = temp_img.size;
    UIGraphicsBeginImageContext(CGSizeMake(42, 42));
    
    for (int i=0; i<array.count; i++) {
        UIImage* uiimage = [array objectAtIndex:i];
        [uiimage drawAtPoint:CGPointMake(2, 2) blendMode:kCGBlendModeNormal alpha:1.0];
    }
    return UIGraphicsGetImageFromCurrentImageContext();
}

//- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
//    return ![self dateIsDisabled:date];
//}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
  //  self.dateLabel.text = [self.dateFormatter stringFromDate:date];
    MensturalCycleViewController *vc=[[MensturalCycleViewController alloc]init];
    vc.mensDate=date;
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)setDateScroll {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
	NSMutableArray *array = [[NSMutableArray alloc] init];
    
	for (int i = 0; i < 10; i++) {

        
        NSString *str=[dateFormatter stringFromDate:[arrDates objectAtIndex:i]];
		ACPItem *item = [[ACPItem alloc] initACPItem:[UIImage imageNamed:@"circle.png"] iconImage:nil andLabel:[str substringWithRange:NSMakeRange(0, 2)]];
            
		[item setHighlightedBackground:nil iconHighlighted:nil textColorHighlighted:[UIColor blackColor]];
        
		[array addObject:item];
	}
    
	[_scrollDates setUpACPScrollMenu:array];
	[_scrollDates setAnimationType:ACPZoomOut];
    [_scrollDates setThisItemHighlighted:2];
	_scrollDates.delegate = self;
}



- (void)scrollMenu:(ACPItem *)menu didSelectIndex:(NSInteger)selectedIndex {
//	NSLog(@"Item %d", selectedIndex);
    //DO somenthing here
}

-(void)setDateArray
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd EEEE"];
    NSDate *now = [NSDate date];
    
//    NSLog(@"Today: %@", now);
//    NSLog(@"Date Formatted: %@", [dateFormatter stringFromDate:now]);
    
    int daysToAdd = -2;
    NSDate *newDate = [now dateByAddingTimeInterval:60*60*24*daysToAdd];
//    NSLog(@"Date Formatted: %@", [dateFormatter stringFromDate:newDate]);
    
    [arrDates addObject:newDate];
    for (int i=0; i<10; i++) {
        int daysToAdd = 1;
        newDate = [newDate dateByAddingTimeInterval:60*60*24*daysToAdd];
//        NSLog(@"Date Formatted: %@", [dateFormatter stringFromDate:newDate]);
        [arrDates addObject:newDate];
    }
}

-(void)addDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd EEEE"];
    NSDate *now = [arrDates objectAtIndex:arrDates.count-1];//[dateFormatter dateFromString:[arrDates objectAtIndex:arrDates.count-1]];
    
    int daysToAdd = 1;
    NSDate *newDate = [now dateByAddingTimeInterval:60*60*24*daysToAdd];
    NSLog(@"Date Formatted: %@", [dateFormatter stringFromDate:newDate]);
    [arrDates addObject:newDate];
}




-(int)OvulationDate:(NSArray *)array
{
    int cnt;
    for (int i=0; i<[array count]-5; i++) {
        NSInteger point=[[array objectAtIndex:i] integerValue];
        NSInteger max=[[array objectAtIndex:i+1] integerValue];
        cnt=0;
        if (max>point) {
            for (int j=1; j<6; j++) {
                if (max<=[[array objectAtIndex:i+j] integerValue]) {
                    cnt++;
                    max=[[array objectAtIndex:i+j] integerValue];
                }
                else{
                    i=i+j-1;
                    break;
                }
            }
        }
        if (cnt==5) {
            return i;
//            NSLog(@"point = %d",i);
            break;
        }
        else{
            //return 0;
            //break;
        }
    }
    return [array count]+1;
}

#pragma mark -
#pragma mark TKCalendarMonthViewDelegate methods
- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d
{
//    NSLog(@"DateTapped = %@",d);
}
- (void) calendarMonthView:(TKCalendarMonthView*)monthView monthDidChange:(NSDate*)month animated:(BOOL)animated
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:month];
    NSInteger monthInt = [components month];
    NSInteger yearInt = [components year];
    NSInteger NewmonthInt;
    NSInteger NewyearInt;
    if ([components month]==1)
    {
        NewmonthInt = [components month]+11;
        NewyearInt = [components year]-1;
    }
    else
    {
        NewmonthInt = [components month]-1;
        NewyearInt = [components year];
    }
    
    NSString *objIDFromUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"];
//    NSLog(@"objIDFromUserDefaults = %@",objIDFromUserDefaults);
    
    PFQuery *query = [PFQuery queryWithClassName:@"MensturalCycleInfo"];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [query whereKey:@"menstural_user_id" equalTo:objIDFromUserDefaults];
    [query orderByAscending:@"menstural_date"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        NSArray *menstural_date = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_date"]];
        NSArray *menstural_temperature = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_temperature"]];
        NSMutableArray *mensturalTemperature = [[NSMutableArray alloc]init];
        NSMutableArray *mensturalDate = [[NSMutableArray alloc]init];
        
        for (int i = 0; i<[menstural_date count]; i++)
        {
            NSString *yearString = [[menstural_date objectAtIndex:i] substringWithRange:NSMakeRange(6, 4)];
            NSString *monthString = [[menstural_date objectAtIndex:i] substringWithRange:NSMakeRange(3, 2)];
            int intMonth = [monthString intValue];
            int intYear = [yearString intValue];
            if (monthInt==intMonth && yearInt==intYear)
            {
                [mensturalTemperature addObject:[menstural_temperature objectAtIndex:i]];
                [mensturalDate addObject:[menstural_date objectAtIndex:i]];
            }
        }
        if ([mensturalTemperature count]==0)
        {
            [sparkline removeFromSuperview];
        }
        else
        {
//            NSLog(@"Menstural Temperature = %@", mensturalTemperature);
//            NSLog(@"Menstural Date = %@", mensturalDate);
        
            self.sparkline.data = mensturalTemperature;
            UILabel *lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(-55, 80, 100, 20)];
            [lbl1 setText:@"Temperature --->"];
            [lbl1 setFont:[UIFont fontWithName:@"Helvetica" size:12]];
            [lbl1 setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
            UILabel *lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 147, 100, 20)];
            [lbl2 setText:@"Days --->"];
            [lbl2 setFont:[UIFont fontWithName:@"Helvetica" size:12]];
            [sparkline addSubview:lbl1];
            [sparkline addSubview:lbl2];
            [Scroll addSubview:sparkline];
            [Scroll bringSubviewToFront:sparkline];
        }
        [SVProgressHUD dismiss];
    }];
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"MensturalCycleInfo"];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [query2 whereKey:@"menstural_user_id" equalTo:objIDFromUserDefaults];
    [query2 orderByAscending:@"menstural_date"];
    [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
    {
        NSArray *menstural_date = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_date"]];
        NSArray *menstural_temperature = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_temperature"]];
        NSMutableArray *mensturalTemperature = [[NSMutableArray alloc]init];
        NSMutableArray *mensturalDate = [[NSMutableArray alloc]init];
        
        for (int i = 0; i<[menstural_date count]; i++)
        {
            NSString *yearString = [[menstural_date objectAtIndex:i] substringWithRange:NSMakeRange(6, 4)];
            NSString *monthString = [[menstural_date objectAtIndex:i] substringWithRange:NSMakeRange(3, 2)];
            int intMonth = [monthString intValue];
            int intYear = [yearString intValue];
            if (NewmonthInt==intMonth && NewyearInt==intYear)
            {
                [mensturalTemperature addObject:[menstural_temperature objectAtIndex:i]];
                [mensturalDate addObject:[menstural_date objectAtIndex:i]];
            }
        }
//        NSLog(@"New Menstural Temperature = %@", mensturalTemperature);
//        NSLog(@"New Menstural Date = %@", mensturalDate);
        if (mensturalTemperature.count>5)
        {
            int abc=[self OvulationDate:mensturalTemperature];
            if (!(abc>[mensturalTemperature count]))
            {
                DipDate=[mensturalDate objectAtIndex:abc];
//                NSLog(@"New DipDate = %@",DipDate);
            }
            [Cal reload];
        }
        else
        {
//            NSLog(@"Less Then 5 Data...");
        }
    }];
}
- (NSArray *)calendarMonthView:(TKCalendarMonthView *)monthView marksFromDate:(NSDate *)startDate toDate:(NSDate *)lastDate
{
    NSArray *data=[[NSArray alloc]init];
    NSDateFormatter *DF1 = [[NSDateFormatter alloc] init];
    [DF1 setDateFormat:@"dd-MM-yyyy"];
    NSDateFormatter *DF2 = [[NSDateFormatter alloc] init];
    [DF2 setDateFormat:@"yyyy-MM-dd"];
    
    if (![DipDate isEqualToString:@""])
    {
        NSDate *DDate = [DF1 dateFromString:DipDate];
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
        [dayComponent setMonth:1];
        DDate = [theCalendar dateByAddingComponents:dayComponent toDate:DDate options:0];
        NSString *DString = [NSString stringWithFormat:@"%@ 00:00:00 +0000", [DF2 stringFromDate:DDate]];
        data = [NSArray arrayWithObjects:DString, nil];
//        NSLog(@"data = %@",data);
    }
	NSMutableArray *marks = [NSMutableArray array];
	NSCalendar *cal = [NSCalendar currentCalendar];
	[cal setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	NSDateComponents *comp = [cal components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit |
											  NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit)
									fromDate:startDate];
	NSDate *d = [cal dateFromComponents:comp];
	NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
	[offsetComponents setDay:1];
	while (YES) {
		if ([d compare:lastDate] == NSOrderedDescending) {
			break;
		}
		if ([data containsObject:[d description]]) {
			[marks addObject:[NSNumber numberWithBool:YES]];
		} else {
			[marks addObject:[NSNumber numberWithBool:NO]];
		}
		
		d = [cal dateByAddingComponents:offsetComponents toDate:d options:0];
	}
//	[offsetComponents release];
	return [NSArray arrayWithArray:marks];
}




-(IBAction)btnMenuClick:(id)sender
{
    MainMenuViewController *obj = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:[NSBundle mainBundle]];
    [self.revealSideViewController pushViewController:obj onDirection:PPRevealSideDirectionLeft withOffset:50 animated:YES];
//    [obj release];
}
-(IBAction)btnSettingsClick:(id)sender
{    
    SettingsViewController *obj=[[SettingsViewController alloc]init];
    obj.FromWhere=@"OVT";
    [self.navigationController pushViewController:obj animated:YES];
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

- (void)dealloc {
//    [_scrollDates release];
//    [_calendarView release];
//    [super dealloc];
}
@end
