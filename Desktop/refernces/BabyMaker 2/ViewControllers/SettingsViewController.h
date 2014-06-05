//
//  SettingsViewController.h
//  BabyMaker
//
//  Created by ajeet Singh on 13/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBSwitch.h"

@interface SettingsViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIAlertViewDelegate, UIActionSheetDelegate, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate >
{
    UIScrollView *Scroll;
    NSDateFormatter *dateFormatter;
    UITextField *txtDateOfBirth, *txtFirstDay, *txtUsualCycleLength, *txtMethodUnits, *txtTemperatureMethods, *txtPatnerID, *txtAdd, *txtEdit, *txtFirstName, *txtImage;
    UIButton *btnSaveSettings, *btnBack, *btnCheckBox,*btnOk,*btnAdd,*btnEdit,*btnCancel,*btnDateTime,*btnAddPhoto;
    UIDatePicker *pickerDateOfBirth, *pickerFirstDay;
    UIPickerView *pcikerUnits, *pickerTemperatureMethods;
    UITextView *DescTextView;
    UIView *AddEditPopUp;
    UITableView *tblDiagnosis,*tblEditDiagnosis;
    UIImageView *userImage,*tempImage;
    MBSwitch *SW;
    UITextField *selectedTextField;
}

@property (nonatomic,retain) IBOutlet UIScrollView *Scroll;
@property (nonatomic,retain) IBOutlet UITextField *txtDateOfBirth, *txtFirstDay, *txtUsualCycleLength, *txtMethodUnits, *txtTemperatureMethods, *txtPatnerID, *txtAdd, *txtEdit, *txtFirstName, *txtImage;
@property (nonatomic,retain) IBOutlet UIButton *btnSaveSettings, *btnBack, *btnCheckBox,*btnOk,*btnAdd,*btnEdit,*btnCancel,*btnDateTime,*btnAddPhoto;
@property (nonatomic,retain) IBOutlet UIDatePicker *pickerDateOfBirth, *pickerFirstDay;
@property (nonatomic,retain) IBOutlet UIPickerView *pcikerUnits, *pickerTemperatureMethods;
@property (nonatomic,retain) IBOutlet UITextView *DescTextView;
@property (nonatomic,retain) IBOutlet UIView *AddEditPopUp;
@property (nonatomic,retain) IBOutlet UITableView *tblDiagnosis,*tblEditDiagnosis;
@property (nonatomic,retain) IBOutlet NSString *FromWhere,*OBJECTid;
@property (nonatomic,retain) IBOutlet NSMutableArray *DiagnosisArr, *itsToDoChecked;
@property (nonatomic,retain) IBOutlet UIImageView *userImage,*tempImage;
@property (nonatomic,retain) IBOutlet MBSwitch *SW;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;

-(IBAction)btnSaveSettingsClick:(id)sender;
-(IBAction)btnCheckBoxClick:(id)sender;
-(IBAction)btnAddClick:(id)sender;
-(IBAction)btnEditClick:(id)sender;
-(IBAction)btnCancelClick:(id)sender;
-(IBAction)btnDateTimeClick:(id)sender;
-(IBAction)btnAddPhoto:(id)sender;
-(IBAction)SWChanged:(id)sender;
- (IBAction)btnMinimize_Click:(id)sender;
@end
