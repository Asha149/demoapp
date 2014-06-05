//
//  MensturalCycleViewController.h
//  BabyMaker
//
//  Created by ajeet Singh on 22/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccordionView.h"
#import "TKCalendarMonthView.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "CKCalendarView.h"

@interface MensturalCycleViewController : UIViewController < UIScrollViewDelegate, UITextFieldDelegate, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate,UITableViewDataSource, AccordionViewDelegate, TKCalendarMonthViewDelegate ,CKCalendarDelegate>
{
    AccordionView *accordion;
    UIScrollView *Scroll;
    UILabel *lblDate;
    UIDatePicker *TimePicker;
    UIButton *btnMenu,*btnPrevious,*btnNext,*btnAddComments,*btnAddSymptoms,*btnAddAdditionalinfo,*btnEditComments,*btnEditSymptoms,*btnEditAdditionalinfo,*btnAddNew,*btnEditExisting,*btnCancelPopup,*btnDate,*btnSave;
    UIButton *btnGeneralCycle,*btnTestsMonitor,*btnMeds,*btnSymptoms,*btnComments,*btnMoodEnergy,*btnAdditionalInfo,*btnCalendar;
    UIView *GeneralCycleView,*TestMonitorView,*MedsView,*SymptomsView,*CommentsView,*AddEditView,*MainView,*AddEdit;
    UITextField *txtTemperature,*txtTime,*txtCerviaclFluid,*txtMPS,*txtIntercourse,*txtOPK,*txtMonitor,*txtFerningTest,*txtOVWatch,*txtPregnancyTest,*txtMood,*txtEnergy;
    UITextView *NoteTextView,*CommentTextView;
    UITableView *tblMeds,*tblSymptoms,*tblAdditionalInfo,*tblAddEdit;
    UIPickerView *picker,*picker2,*picker3,*picker4,*picker5,*picker6,*picker7,*picker8,*picker9,*picker10;
    NSDateFormatter *dateFormatter,*DateToDisplayFormatter;
    AppDelegate *appDelegate;
    UITextField *activeTextField;
    NSMutableArray *arrCalDetails;
}
@property (nonatomic,retain) NSString *DipDate;
@property (strong, nonatomic) CKCalendarView *Calendar;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIButton *btnAddMeds;
@property (weak, nonatomic) IBOutlet UIButton *btnEditMeds;
@property (retain, nonatomic) IBOutlet UIImageView *imgShade;
@property (retain, nonatomic) IBOutlet UIImageView *imgPopUp;
@property (nonatomic,retain) IBOutlet UIScrollView *Scroll;
@property (nonatomic,retain) IBOutlet UILabel *lblDate;
@property (nonatomic,retain) IBOutlet UIDatePicker *TimePicker;
@property (nonatomic,retain) IBOutlet UIButton *btnGeneralCycle,*btnTestsMonitor,*btnMeds,*btnSymptoms,*btnComments,*btnMoodEnergy,*btnAdditionalInfo,*btnCalendar,*btnDate,*btnSave;
@property (nonatomic,retain) IBOutlet UIButton *btnMenu,*btnPrevious,*btnNext,*btnAddComments,*btnAddSymptoms,*btnAddAdditionalinfo,*btnEditComments,*btnEditSymptoms,*btnEditAdditionalinfo;
@property (nonatomic,retain) IBOutlet UIView *GeneralCycleView,*TestMonitorView,*MedsView,*SymptomsView,*CommentsView,*MoodEnergyView,*AdditionalInfoView,*AddEditView,*MainView,*AddEdit,*btnAddNew,*btnEditExisting,*btnCancelPopup,*crampsView;
@property (nonatomic,retain) IBOutlet UITableView *tblMeds,*tblSymptoms,*tblAdditionalInfo,*tblAddEdit,*tblCerviaclFluid;
@property (nonatomic,retain) IBOutlet UIPickerView *picker,*picker2,*picker3,*picker4,*picker5,*picker6,*picker7,*picker8,*picker9,*picker10;
@property (nonatomic,retain) IBOutlet UITextField *txtTemperature,*txtTime,*txtCerviaclFluid,*txtMPS,*txtIntercourse,*txtOPK,*txtMonitor,*txtFerningTest,*txtOVWatch,*txtPregnancyTest,*txtMood,*txtEnergy,*txtCramps,*txtBloodhcg;
@property (nonatomic,retain) IBOutlet UITextView *NoteTextView,*CommentTextView;
@property (nonatomic,retain) IBOutlet NSString *myDateString;
@property (nonatomic,retain) IBOutlet NSMutableArray *CervicalFluidArr,*MPSArr,*InterCourseArr,*OPKArr,*MonitorArr,*FerningTestArr,*OVWatchArr,*PragnencyTestArr,*MoodArr,*EnergyArr,*arrCramps,*arrCerviaclFluid;
@property (strong, nonatomic) CKCalendarView *Cal;
@property (nonatomic,retain)IBOutlet UIPickerView *pkvCramps;
@property (nonatomic,retain)IBOutlet UIButton *btnCrampsClose;
@property (nonatomic,retain)IBOutlet UISwitch *swBooldTest;
@property (nonatomic,retain)IBOutlet UISwitch *swUrineTest;
@property (strong, nonatomic)  NSDate *mensDate;
@property(nonatomic, retain) AppDelegate *appDelegate;
@property (nonatomic,retain) IBOutlet UILabel *lblProcedure;
@property (nonatomic,retain) IBOutlet UITableView *tblProcedure;
@property (nonatomic,retain) IBOutlet UIButton *btnAddProcedure,*btnEditProcedure;
@property (nonatomic,retain) IBOutlet UIView *ProcedureView;
@property (strong, nonatomic) IBOutlet UIView *MedsDetail;


-(IBAction)btnGeneralCycleClick:(id)sender;
-(IBAction)btnTestsMonitorClick:(id)sender;
-(IBAction)btnMedsClick:(id)sender;
-(IBAction)btnSymptomsClick:(id)sender;
-(IBAction)btnMoodEnergyClick:(id)sender;
-(IBAction)btnCommentsClick:(id)sender;
-(IBAction)btnAdditionalInfoClick:(id)sender;
-(IBAction)btnCalendarClick:(id)sender;
-(IBAction)btnPreviousClick:(id)sender;
-(IBAction)btnNextClick:(id)sender;

-(IBAction)btnAddMedsClick:(id)sender;
-(IBAction)btnAddCommentsClick:(id)sender;
-(IBAction)btnAddSymptomsClick:(id)sender;
-(IBAction)btnAddAdditionalinfoClick:(id)sender;
-(IBAction)btnEditMedsClick:(id)sender;
-(IBAction)btnEditCommentsClick:(id)sender;
-(IBAction)btnEditSymptomsClick:(id)sender;
-(IBAction)btnEditAdditionalinfoClick:(id)sender;
- (IBAction)btnSettings_Click:(id)sender;
- (IBAction)btnMinimize_Click:(id)sender;

-(IBAction)btnAddNewClick:(id)sender;
-(IBAction)btnEditExistingClick:(id)sender;
-(IBAction)btnCancelPopupClick:(id)sender;
-(IBAction)btnDateClick:(id)sender;
-(IBAction)btnSave:(id)sender;
-(IBAction)btnMenuClick:(id)sender;
-(IBAction)btnCrampsClose_click:(id)sender;
@end
