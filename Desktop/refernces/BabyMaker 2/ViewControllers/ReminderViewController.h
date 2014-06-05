//
//  ReminderViewController.h
//  BabyMaker
//
//  Created by Ajeet on 11/8/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReminderViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate>

- (IBAction)btnDate_Click:(id)sender;
- (IBAction)btnSave_Click:(id)sender;
- (IBAction)btnMenu_Click:(id)sender;
- (IBAction)btnReminders_Click:(id)sender;
- (IBAction)btnReminder:(id)sender;


@property (retain, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (retain, nonatomic) IBOutlet UIButton *btnDateSelection;
@property (retain, nonatomic) IBOutlet UITextView *txtMessage;
@property (strong, nonatomic) IBOutlet UIButton *btnReminderSelection;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;

@property (strong, nonatomic) IBOutlet UIPickerView *reminderPicker;
- (IBAction)btnMinimize_Click:(id)sender;
@end
