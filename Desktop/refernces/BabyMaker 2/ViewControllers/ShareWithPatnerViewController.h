//
//  ShareWithPatnerViewController.h
//  BabyMaker
//
//  Created by ajeet Singh on 16/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <Parse/Parse.h>

@interface ShareWithPatnerViewController : UIViewController < UIScrollViewDelegate, UIPickerViewDelegate, UITextFieldDelegate, UITextViewDelegate, MFMailComposeViewControllerDelegate >
{
    UIScrollView *Scroll;
    UITextField *txtData, *txtTo;
    UITextView *MessageTextView,*DataTextView;
    UIImageView *LoadDataView;
    UIPickerView *DataPickerView;
    UIButton *btnSend, *btnCancel;
}
@property (nonatomic,retain) IBOutlet UIScrollView *Scroll;
@property (nonatomic,retain) IBOutlet UIButton *btnMenu;
@property (nonatomic,retain) IBOutlet UITextField *txtData, *txtTo;
@property (nonatomic,retain) IBOutlet UITextView *MessageTextView,*DataTextView;
@property (nonatomic,retain) IBOutlet UIImageView *LoadDataView;
@property (nonatomic,retain) IBOutlet UIPickerView *DataPickerView;
@property (nonatomic,retain) IBOutlet UIButton *btnSend, *btnCancel;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;

-(IBAction)btnSendClick:(id)sender;
-(IBAction)btnCancelClick:(id)sender;
- (IBAction)btnMinimize_Click:(id)sender;
@end
