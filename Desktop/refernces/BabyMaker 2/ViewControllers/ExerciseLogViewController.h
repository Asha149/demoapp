//
//  ExerciseLogViewController.h
//  BabyMaker
//
//  Created by ajeet Singh on 14/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKCalendarMonthView.h"
#import <AudioToolbox/AudioToolbox.h>
#import <Parse/Parse.h>

@interface ExerciseLogViewController : UIViewController < UIScrollViewDelegate, UITextFieldDelegate, TKCalendarMonthViewDelegate, UIPickerViewDataSource,UIPickerViewDelegate >
{
    //SystemSoundID SoundID;
    UIButton *btnSave,*btnViewExercise,*btnDate;
    NSDateFormatter *dateFormatter,*DateToDisplayFormatter;
    UIView *BackgroundView;
}
@property (nonatomic,retain) NSString *DateString;

@property (nonatomic,retain) IBOutlet UIScrollView *Scroll;
@property (nonatomic,retain) IBOutlet UIButton *btnMenu, *btnPrevious, *btnNext;
@property (nonatomic,retain) IBOutlet UITextField *txtExercise, *txtDuration;
@property (nonatomic,retain) IBOutlet UIButton *btnSave,*btnViewExercise,*btnDate;
@property (nonatomic,retain) IBOutlet NSString *myDateString;
@property (nonatomic,retain) IBOutlet UIView *BackgroundView;
@property (strong, nonatomic) TKCalendarMonthView *Cal;
@property (strong, nonatomic) IBOutlet UIDatePicker *timePicker;
- (IBAction)getDuration:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnGetDuration;
@property (strong, nonatomic) IBOutlet UIPickerView *hourMinPicker;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;


-(IBAction)btnPreviousClick:(id)sender;
-(IBAction)btnNextClick:(id)sender;
-(IBAction)btnSaveClick:(id)sender;
-(IBAction)btnViewExerciseClick:(id)sender;
-(IBAction)btnDateClick:(id)sender;
- (IBAction)btnMinimize_Click:(id)sender;
@end
