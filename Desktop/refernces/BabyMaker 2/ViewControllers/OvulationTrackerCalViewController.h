//
//  OvulationTrackerCalViewController.h
//  BabyMaker
//
//  Created by ajeet Singh on 14/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "KLCalendarView.h"
#import "Kal.h"
#import "TKCalendarMonthView.h"
#import "CKSparkline.h"
#import <Parse/Parse.h>
#import "ACPScrollMenu.h"
#import "CKCalendarView.h"

@interface OvulationTrackerCalViewController : UIViewController < UIScrollViewDelegate, TKCalendarMonthViewDelegate, TKCalendarMonthViewDataSource, ACPScrollDelegate, CKCalendarDelegate>
{
    CKSparkline *sparkline;
    UIScrollView *Scroll;
    UIButton *btnMenu,*btnSettings;
    NSIndexPath *indexPath;
    NSMutableArray *arrCalDetails;
    int count;
}
@property (strong, nonatomic) CKCalendarView *Calendar;
@property (nonatomic, retain) IBOutlet CKSparkline *sparkline;
@property (nonatomic,retain) IBOutlet UIScrollView *Scroll;
@property (nonatomic,retain) IBOutlet UIButton *btnMenu,*btnSettings;
@property (nonatomic,retain) IBOutlet NSIndexPath *indexPath;
@property (nonatomic,retain) NSString *DipDate;
@property (retain, nonatomic) IBOutlet UIView *calendarView;
@property (nonatomic,retain) IBOutlet UIView *viewHeading;
@property (nonatomic,retain) IBOutlet UIImageView *img;
@property (strong, nonatomic) NSMutableArray *arrDates;
@property (nonatomic) NSUInteger selectedIndex;
@property (retain, nonatomic) IBOutlet ACPScrollMenu *scrollDates;
@property BOOL weekView;

@end
