//
//  ShareViewController.h
//  BabyMaker
//
//  Created by ajeet Singh on 14/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <Parse/Parse.h>

@interface ShareViewController : UIViewController < UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, MFMailComposeViewControllerDelegate >
{
    UITextField *txtData,*txtTo;
    UIButton *btnSave,*btnCancel;
    UIPickerView *picker1,*picker2;
    UIImageView *DataImage;
    UITextView *DataTextView;
}
@property (nonatomic,retain) IBOutlet UITextField *txtData,*txtTo;
@property (nonatomic,retain) IBOutlet UIButton *btnMenu,*btnSave,*btnCancel;
@property (nonatomic,retain) IBOutlet UIPickerView *picker1,*picker2;
@property (nonatomic,retain) IBOutlet UIImageView *DataImage;
@property (nonatomic,retain) IBOutlet UITextView *DataTextView;
@property (retain, nonatomic) IBOutlet UIScrollView *shareScroll;
@property (strong, nonatomic) IBOutlet UIToolbar *tooBar;

-(IBAction)btnSaveClick:(id)sender;
-(IBAction)btnCancelClick:(id)sender;
- (IBAction)btnMinimize_Click:(id)sender;
@end
