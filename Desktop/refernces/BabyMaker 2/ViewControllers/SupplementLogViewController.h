//
//  SupplementLogViewController.h
//  BabyMaker
//
//  Created by ajeet Singh on 14/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKCalendarMonthView.h"
#import <Parse/Parse.h>

@interface SupplementLogViewController : UIViewController < TKCalendarMonthViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate >
{
    NSMutableArray *supplements;
    NSDateFormatter *dateFormatter,*DateToDisplayFormatter;
    UIView *CalendarView;
    NSMutableDictionary *previousData;
}


@property (nonatomic,retain) IBOutlet UIButton *btnMenu;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerSupplement;
@property (weak, nonatomic) IBOutlet UIButton *btnSupplement;
@property (weak, nonatomic) IBOutlet UIButton *btnDate;
@property (strong, nonatomic) TKCalendarMonthView *Cal;
@property (weak, nonatomic) IBOutlet UIView *viewDetails;
@property (weak, nonatomic) IBOutlet UITextView *txtComment;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

- (IBAction)btnSupplement_Click:(id)sender;
- (IBAction)btnDate_Click:(id)sender;
- (IBAction)btnNextClick:(id)sender;
- (IBAction)btnPreviousClick:(id)sender;
- (IBAction)btnAdd_Click:(id)sender;
- (IBAction)btnSave_Click:(id)sender;
- (IBAction)btnMinimize_Click:(id)sender;
- (IBAction)btnSameAsPrevious_Click:(id)sender;

@end
