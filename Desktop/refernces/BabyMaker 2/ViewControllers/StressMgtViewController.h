//
//  StressMgtViewController.h
//  BabyMaker
//
//  Created by ajeet Singh on 14/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKCalendarMonthView.h"
#import <Parse/Parse.h>

@interface StressMgtViewController : UIViewController < UIScrollViewDelegate, UITextViewDelegate, TKCalendarMonthViewDelegate >
{
    UIScrollView *Scroll;
    UIButton *btnMenu, *btnPrevious, *btnNext, *btnDate, *btnAddEdit;
    UILabel *lblDate;
    UITextView *QuoteTextView,*DescriptionTextView;
    NSDateFormatter *dateFormatter,*DateToDisplayFormatter;
}
@property (nonatomic,retain) IBOutlet UIScrollView *Scroll;
@property (nonatomic,retain) IBOutlet UIButton *btnMenu, *btnPrevious, *btnNext, *btnDate, *btnAddEdit;
@property (nonatomic,retain) IBOutlet UILabel *lblDate;
@property (nonatomic,retain) IBOutlet UITextView *QuoteTextView,*DescriptionTextView;
@property (nonatomic,retain) IBOutlet NSString *myDateString;
@property (nonatomic,retain) IBOutlet NSMutableArray *QuoteArray;
@property (strong, nonatomic) TKCalendarMonthView *Cal;
@property (retain, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;

-(IBAction)btnPreviousClick:(id)sender;
-(IBAction)btnNextClick:(id)sender;
-(IBAction)btnDateClick:(id)sender;
-(IBAction)btnAddEditClick:(id)sender;
- (IBAction)btnMinimize_Click:(id)sender;
@end
