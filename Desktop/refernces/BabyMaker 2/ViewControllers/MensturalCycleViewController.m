//
//  MensturalCycleViewController.m
//  BabyMaker
//
//  Created by ajeet Singh on 22/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "MensturalCycleViewController.h"
#import "MainMenuViewController.h"
#import "PPRevealSideViewController.h"
#import "MeedsTableCell.h"
#import <QuartzCore/QuartzCore.h>
#import "SVProgressHUD.h"
#import "SettingsViewController.h"

@interface MensturalCycleViewController ()

@end

@implementation MensturalCycleViewController
@synthesize DipDate;
@synthesize tblMeds,tblSymptoms,tblAdditionalInfo,tblAddEdit;
@synthesize Scroll,btnMenu,btnPrevious,btnNext,picker,picker2,picker3,picker4,picker5,picker6,picker7,picker8,picker9,picker10,NoteTextView,myDateString,lblDate,TimePicker;
@synthesize btnGeneralCycle,btnTestsMonitor,btnMeds,btnSymptoms,btnComments,btnMoodEnergy,btnAdditionalInfo,btnCalendar;
@synthesize GeneralCycleView,TestMonitorView,MedsView,SymptomsView,CommentsView,MoodEnergyView,AdditionalInfoView,AddEditView,MainView,AddEdit,CommentTextView;
@synthesize txtTemperature,txtTime,txtCerviaclFluid,txtMPS,txtIntercourse,txtOPK,txtMonitor,txtFerningTest,txtOVWatch,txtPregnancyTest,txtMood,txtEnergy,Cal;
@synthesize btnAddMeds,btnAddComments,btnAddSymptoms,btnAddAdditionalinfo,btnEditMeds,btnEditComments,btnEditSymptoms,btnEditAdditionalinfo,btnAddNew,btnEditExisting,btnCancelPopup,btnDate,btnSave;
@synthesize CervicalFluidArr,MPSArr,InterCourseArr,OPKArr,MonitorArr,FerningTestArr,OVWatchArr,PragnencyTestArr,MoodArr,EnergyArr,arrCramps;
@synthesize pkvCramps,btnCrampsClose,crampsView,txtCramps;
@synthesize swBooldTest,swUrineTest;
@synthesize txtBloodhcg;
@synthesize tblCerviaclFluid,arrCerviaclFluid;
@synthesize appDelegate;
@synthesize mensDate;
@synthesize lblProcedure,tblProcedure;
@synthesize btnAddProcedure,btnEditProcedure;
@synthesize ProcedureView,MedsDetail;
@synthesize Calendar;

UIView *CalendarView;
UITapGestureRecognizer *tap;
NSMutableArray *MedsArray,*SymptomsArray,*AdditionalInfoArray,*ABC,*MeedsCheckArr,*SymptomsCheckArr,*AdditionalInfoCheckArr,*CervicalCheckArr,*ProcedureArr,*ProcedureCheckArr;
NSString *From,*TableToLoad,*CheckFOR,*str,*strID,*strCramps,*strCramps1,*strTimer;;
UITextField *txt;
int idx;
bool flag;
bool crampViewShow;
int intMedsView = 0;

#pragma mark
#pragma mark - View-lifeCycle Methods...

- (void)resizing
{
    [self resizeMeds];
    arrCalDetails=[[NSMutableArray alloc]init];
    [tblSymptoms setFrame:CGRectMake(tblSymptoms.frame.origin.x, tblSymptoms.frame.origin.y, tblSymptoms.frame.size.width, 40*[SymptomsArray count])];
//    [tblCerviaclFluid setFrame:CGRectMake(tblCerviaclFluid.frame.origin.x, tblCerviaclFluid.frame.origin.y, tblCerviaclFluid.frame.size.width, 40*[arrCerviaclFluid count])];
    SymptomsView .frame = CGRectMake(SymptomsView.frame.origin.x, MedsView.frame.origin.y+MedsView.frame.size.height+20, SymptomsView.frame.size.width, tblSymptoms.frame.size.height + 100);
    [btnAddSymptoms setFrame:CGRectMake(btnAddSymptoms.frame.origin.x, tblSymptoms.frame.origin.y+tblSymptoms.frame.size.height+10, btnAddSymptoms.frame.size.width, btnAddSymptoms.frame.size.height)];
    [btnEditSymptoms setFrame:CGRectMake(btnEditSymptoms.frame.origin.x, tblSymptoms.frame.origin.y+tblSymptoms.frame.size.height+10, btnEditSymptoms.frame.size.width, btnEditSymptoms.frame.size.height)];
    
    [tblAdditionalInfo setFrame:CGRectMake(tblAdditionalInfo.frame.origin.x, tblAdditionalInfo.frame.origin.y, tblAdditionalInfo.frame.size.width, 40*[AdditionalInfoArray count])];
    AdditionalInfoView .frame = CGRectMake(AdditionalInfoView.frame.origin.x, AdditionalInfoView.frame.origin.y, AdditionalInfoView.frame.size.width, tblAdditionalInfo.frame.size.height + 70);
    [btnAddAdditionalinfo setFrame:CGRectMake(btnAddAdditionalinfo.frame.origin.x, tblAdditionalInfo.frame.origin.y+tblAdditionalInfo.frame.size.height+10, btnAddAdditionalinfo.frame.size.width, btnAddAdditionalinfo.frame.size.height)];
    [btnEditAdditionalinfo setFrame:CGRectMake(btnEditAdditionalinfo.frame.origin.x, tblAdditionalInfo.frame.origin.y+tblAdditionalInfo.frame.size.height+10, btnEditAdditionalinfo.frame.size.width, btnEditAdditionalinfo.frame.size.height)];
    
}

-(void)resizeMeds
{
    NSLog(@"Meds array = %d",MedsArray.count);
    [tblMeds setFrame:CGRectMake(tblMeds.frame.origin.x, tblMeds.frame.origin.y, tblMeds.frame.size.width, 40*[MedsArray count])];
    [btnAddMeds setFrame:CGRectMake(btnAddMeds.frame.origin.x,tblMeds.frame.origin.y+ tblMeds.frame.size.height+10 , btnAddMeds.frame.size.width, btnAddMeds.frame.size.height)];
    [btnEditMeds setFrame:CGRectMake(btnEditMeds.frame.origin.x, tblMeds.frame.origin.y+ tblMeds.frame.size.height +10 , btnEditMeds.frame.size.width, btnEditMeds.frame.size.height)];
    [MedsDetail setFrame:CGRectMake(MedsDetail.frame.origin.x, MedsDetail.frame.origin.y  , MedsDetail.frame.size.width,btnEditMeds.frame.origin.y+btnEditMeds.frame.size.height+10)];
    
    [tblProcedure setFrame:CGRectMake(tblProcedure.frame.origin.x,  tblProcedure.frame.origin.y, tblProcedure.frame.size.width, 40*[ProcedureArr count])];
    [btnAddProcedure setFrame:CGRectMake(btnAddProcedure.frame.origin.x, tblProcedure.frame.origin.y+tblProcedure.frame.size.height+10, btnAddProcedure.frame.size.width, btnAddProcedure.frame.size.height)];
    [btnEditProcedure setFrame:CGRectMake(btnEditProcedure.frame.origin.x,tblProcedure.frame.origin.y+tblProcedure.frame.size.height+10, btnEditProcedure.frame.size.width, btnEditProcedure.frame.size.height)];
    [ProcedureView setFrame:CGRectMake(ProcedureView.frame.origin.x, MedsDetail.frame.origin.y + MedsDetail.frame.size.height + 10 , ProcedureView.frame.size.width, btnEditProcedure.frame.origin.y+btnEditProcedure.frame.size.height+10)];
    
    MedsView.frame = CGRectMake(MedsView.frame.origin.x, MedsView.frame.origin.y, MedsView.frame.size.width,ProcedureView.frame.origin.y+ ProcedureView.frame.size.height);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.navigationController setNavigationBarHidden:YES];
    Cal = [[CKCalendarView alloc]init];
    Cal.delegate = self;
    
    CalendarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, Cal.frame.size.height)];
       [CalendarView setBackgroundColor:[UIColor whiteColor]];
    [CalendarView addSubview:Cal];
    [Scroll addSubview:CalendarView];
    [CalendarView setHidden:YES];
    
   
//    [Scroll setContentSize:CGSizeMake(320, Scroll.frame.size.height+200)];
    //crampViewShow = false;
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        
        [Scroll setContentSize:CGSizeMake(568, Scroll.frame.size.height+200)];
    }
    else
    {
       [Scroll setContentSize:CGSizeMake(320, Scroll.frame.size.height)];
    }
    [btnMenu addTarget:self action:@selector(btnMenuClick:) forControlEvents:UIControlEventTouchUpInside];
    flag=false;
    [tblAddEdit setDelegate:self];
      //
    //[self.revealSideViewController setDirectionsToShowBounce:PPRevealSideDirectionNone];
//    
//    Scroll.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    
//    [MainView addSubview:Scroll];
    
    
    
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyy"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    myDateString = [dateFormatter stringFromDate:[NSDate date]];
    DateToDisplayFormatter = [[NSDateFormatter alloc]init];
    [DateToDisplayFormatter setDateFormat:@"dd MMMM, yyyy"];
    NSString *DateTODisplay = [DateToDisplayFormatter stringFromDate:[NSDate date]];
    [btnDate setTitle:DateTODisplay forState:UIControlStateNormal];
    [crampsView setHidden:YES];
    NSLog(@"mensdate :: %@",mensDate);
    if(mensDate == nil)
    {
        [self Querring];
    }
    else
    {
        [self getDateDATA:mensDate];
    }
    
    TimePicker.datePickerMode = UIDatePickerModeTime;
    TimePicker.date = [NSDate date];
    [TimePicker setMinuteInterval:5];
    [TimePicker addTarget:self action:@selector(TimePickerChanged:) forControlEvents:UIControlEventValueChanged];
    
    [tblMeds setBackgroundColor:[UIColor clearColor]];
    [tblProcedure setBackgroundColor:[UIColor clearColor]];
    [tblSymptoms setBackgroundColor:[UIColor clearColor]];
    
    [tblAdditionalInfo setBackgroundColor:[UIColor clearColor]];
    
    [swBooldTest setOnTintColor:[UIColor colorWithRed:25/255.0f green:167/255.0f blue:249/255.0f alpha:1.00f]];
  // [swBooldTest setOffTintColor:[UIColor whiteColor]];
    [swBooldTest setOn:NO animated:YES];
    swBooldTest.tag = 5;
    swUrineTest.tag = 6;
    [swUrineTest setOn:NO animated:YES];
    swBooldTest.transform = CGAffineTransformMakeScale(0.70, 0.70);
    [swUrineTest setOnTintColor:[UIColor colorWithRed:25/255.0f green:167/255.0f blue:249/255.0f alpha:1.00f]];
   //[swUrineTest setOffTintColor:[UIColor whiteColor]];
    swUrineTest.transform = CGAffineTransformMakeScale(0.70, 0.70);
    
    if(swBooldTest.on)
    {
        [txtBloodhcg setHidden:NO];
    }
    else
    {
        [txtBloodhcg setHidden:YES];
    }
 
    ABC = [[NSMutableArray alloc] init];
    [ABC addObject:@"ABC"];
    [ABC addObject:@"ABC"];
    [ABC addObject:@"ABC"];
    [ABC addObject:@"ABC"];
    [ABC addObject:@"ABC"];
    [ABC addObject:@"ABC"];
    [ABC addObject:@"ABC"];
    
    arrCerviaclFluid = [[NSMutableArray alloc]init];
    [arrCerviaclFluid addObject:@"Clear"];
    [arrCerviaclFluid addObject:@"Stretchy"];
    [arrCerviaclFluid addObject:@"White"];
    [arrCerviaclFluid addObject:@"Yellow"];
    [arrCerviaclFluid addObject:@"Cloudy"];
    [arrCerviaclFluid addObject:@"Milky"];
    [arrCerviaclFluid addObject:@"Odor"];
    [arrCerviaclFluid addObject:@"Dry"];
    [arrCerviaclFluid addObject:@"Greenish"];
    [arrCerviaclFluid addObject:@"Pink"];
    
     MPSArr = [[NSMutableArray alloc] init];
    [MPSArr addObject:@"Heavy"];
    [MPSArr addObject:@"Medium"];
    [MPSArr addObject:@"Light"];
    [MPSArr addObject:@"Spotting Red"];
    [MPSArr addObject:@"Spotting Brown"];
    [MPSArr addObject:@"other"];
    
    InterCourseArr = [[NSMutableArray alloc] init];
    [InterCourseArr addObject:@"AM"];
    [InterCourseArr addObject:@"PM"];
    [InterCourseArr addObject:@"Both"];
    [InterCourseArr addObject:@"None"];
    
    OPKArr = [[NSMutableArray alloc] init];
    [OPKArr addObject:@"Faint Positive"];
    [OPKArr addObject:@"Strong Positive"];
    [OPKArr addObject:@"Negative"];
    
    FerningTestArr = [[NSMutableArray alloc] init];
    [FerningTestArr addObject:@"Full"];
    [FerningTestArr addObject:@"Partial"];
    [FerningTestArr addObject:@"Pebbles"];
    [FerningTestArr addObject:@"None"];
    
    PragnencyTestArr = [[NSMutableArray alloc] init];
    [PragnencyTestArr addObject:@"Positive"];
    [PragnencyTestArr addObject:@"Negative"];
    
    MoodArr = [[NSMutableArray alloc] init];
    [MoodArr addObject:@"Cranky/Irritable/snappy"];
    [MoodArr addObject:@"Teary"];
    [MoodArr addObject:@"Low mood/sad"];
    [MoodArr addObject:@"Fine"];
    [MoodArr addObject:@"good"];
    
    EnergyArr = [[NSMutableArray alloc] init];
    [EnergyArr addObject:@"High"];
    [EnergyArr addObject:@"Average"];
    [EnergyArr addObject:@"Low"];
    
    arrCramps = [[NSMutableArray alloc]init];
    [arrCramps addObject:@"0"];
        [arrCramps addObject:@"1"];
        [arrCramps addObject:@"2"];
        [arrCramps addObject:@"3"];
        [arrCramps addObject:@"4"];
        [arrCramps addObject:@"5"];
        [arrCramps addObject:@"6"];
        [arrCramps addObject:@"7"];
        [arrCramps addObject:@"8"];
        [arrCramps addObject:@"9"];
        [arrCramps addObject:@"10"];
    
    MeedsCheckArr = [[NSMutableArray alloc] init];
    ProcedureCheckArr = [[NSMutableArray alloc]init];
    SymptomsCheckArr = [[NSMutableArray alloc] init];
    CervicalCheckArr = [[NSMutableArray alloc]init];
   
    AdditionalInfoCheckArr = [[NSMutableArray alloc] init];
    
    CommentsView.frame = CGRectMake(CommentsView.frame.origin.x, CommentsView.frame.origin.y, CommentsView.frame.size.width, CommentTextView.frame.origin.y+CommentTextView.frame.size.height+10);
    [btnAddComments setFrame:CGRectMake(btnAddComments.frame.origin.x, CommentTextView.frame.origin.y+CommentTextView.frame.size.height+10, btnAddComments.frame.size.width, btnAddComments.frame.size.height)];
    [btnEditComments setFrame:CGRectMake(btnEditComments.frame.origin.x, CommentTextView.frame.origin.y+CommentTextView.frame.size.height+10, btnEditComments.frame.size.width, btnEditComments.frame.size.height)];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)])
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            CGFloat scale = [UIScreen mainScreen].scale;
            result = CGSizeMake(result.width * scale, result.height * scale);
            
            if(result.height == 960)
            {
//                NSLog(@"iPhone 4 Resolution");
                
            }
            if(result.height == 1136)
            {
//                NSLog(@"iPhone 5 Resolution");
                [btnGeneralCycle setFrame:CGRectMake(btnGeneralCycle.frame.origin.x, btnGeneralCycle.frame.origin.y, btnGeneralCycle.frame.size.width, btnGeneralCycle.frame.size.height+12)];
                [btnTestsMonitor setFrame:CGRectMake(btnTestsMonitor.frame.origin.x, btnTestsMonitor.frame.origin.y, btnTestsMonitor.frame.size.width, btnTestsMonitor.frame.size.height+12)];
                [btnMeds setFrame:CGRectMake(btnMeds.frame.origin.x, btnMeds.frame.origin.y, btnMeds.frame.size.width, btnMeds.frame.size.height+12)];
                [btnSymptoms setFrame:CGRectMake(btnSymptoms.frame.origin.x, btnSymptoms.frame.origin.y, btnSymptoms.frame.size.width, btnSymptoms.frame.size.height+12)];
                [btnComments setFrame:CGRectMake(btnComments.frame.origin.x, btnComments.frame.origin.y, btnComments.frame.size.width, btnComments.frame.size.height+12)];
                [btnMoodEnergy setFrame:CGRectMake(btnMoodEnergy.frame.origin.x, btnMoodEnergy.frame.origin.y, btnMoodEnergy.frame.size.width, btnMoodEnergy.frame.size.height+12)];
                [btnAdditionalInfo setFrame:CGRectMake(btnAdditionalInfo.frame.origin.x, btnAdditionalInfo.frame.origin.y, btnAdditionalInfo.frame.size.width, btnAdditionalInfo.frame.size.height+12)];
                [MainView setFrame:CGRectMake(MainView.frame.origin.x, MainView.frame.origin.y, MainView.frame.size.width, MainView.frame.size.height+125)];
            }
        }
        else
        {
//            NSLog(@"Standard Resolution");
        }
    }
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"FirstLoadArrays"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstLoadArrays"];
        [[NSUserDefaults standardUserDefaults] synchronize];
      
        MedsArray = [[NSMutableArray alloc] init];
        [MedsArray addObject:@"Clomid"];
        [MedsArray addObject:@"Estrogen"];
        [MedsArray addObject:@"FSH"];
        [MedsArray addObject:@"Femara/letrozole"];
        [MedsArray addObject:@"HCG"];
        [MedsArray addObject:@"Metformin"];
        [MedsArray addObject:@"Other Medications"];
        [MedsArray addObject:@"Progestrone"];

        [[NSUserDefaults standardUserDefaults] setObject:MedsArray forKey:@"Meds"];
        
        for (int i=0; i<[MedsArray count]; i++)
            [MeedsCheckArr addObject:@"False"];
        [[NSUserDefaults standardUserDefaults] setObject:MeedsCheckArr forKey:@"MeedsCheckArr"];
//        [MeedsCheckArr removeAllObjects];
//        [MedsArray removeAllObjects];
    
        
        ProcedureArr = [[NSMutableArray alloc]init];
        /*Laparoscopy
         Egg Pick Up
         Embryo Transfer*/
        [ProcedureArr addObject:@"Laparoscopy"];
        [ProcedureArr addObject:@"Egg Pick Up"];
        [ProcedureArr addObject:@"Embryo Transfer"];
        
        [[NSUserDefaults standardUserDefaults] setObject:ProcedureArr forKey:@"Procedure"];
        for (int i=0; i<[ProcedureArr count]; i++)
            [ProcedureCheckArr addObject:@"False"];
        [[NSUserDefaults standardUserDefaults] setObject:ProcedureCheckArr forKey:@"ProcedureCheckArr"];
        //[ProcedureCheckArr removeAllObjects];
        //[ProcedureArr removeAllObjects];
        
        NSLog(@"procedure :: %@",ProcedureArr);
        
        SymptomsArray = [[NSMutableArray alloc] init];
        [SymptomsArray addObject:@"Backache"];
        [SymptomsArray addObject:@"Bloated"];
    
        [SymptomsArray addObject:@"Constipation"];
        [SymptomsArray addObject:@"Cramps"];
        [SymptomsArray addObject:@"Decreased Appetite"];
        [SymptomsArray addObject:@"Diarrhea"];
        [SymptomsArray addObject:@"Dizziness"];
        [SymptomsArray addObject:@"Drinking"];
        [SymptomsArray addObject:@"Exercise"];
        [SymptomsArray addObject:@"Fatigue"];
        [SymptomsArray addObject:@"Fever"];
        [SymptomsArray addObject:@"Sore Breasts"];
        [[NSUserDefaults standardUserDefaults] setObject:SymptomsArray forKey:@"Symptoms"];
        
        for (int i=0; i<[SymptomsArray count]; i++)
            [SymptomsCheckArr addObject:@"False"];
        [[NSUserDefaults standardUserDefaults] setObject:SymptomsCheckArr forKey:@"SymptomsCheckArr"];
        [SymptomsCheckArr removeAllObjects];
        [SymptomsArray removeAllObjects];
        
        for(int i=0; i<[arrCerviaclFluid count];i++)
        {
            [CervicalCheckArr addObject:@"False"];
        }
        [[NSUserDefaults standardUserDefaults] setObject:CervicalCheckArr forKey:@"CervicalCheckArr"];
        [CervicalCheckArr removeAllObjects];
        //[arrCerviaclFluid removeAllObjects];
        
        AdditionalInfoArray = [[NSMutableArray alloc] init];
//        [AdditionalInfoArray addObject:@"Supplymentary 01"];
//        [AdditionalInfoArray addObject:@"Supplymentary 02"];
//        [AdditionalInfoArray addObject:@"Supplymentary 03"];
        [[NSUserDefaults standardUserDefaults] setObject:AdditionalInfoArray forKey:@"AdditionalInfo"];
        
        for (int i=0; i<[AdditionalInfoArray count]; i++)
            [AdditionalInfoCheckArr addObject:@"False"];
        [[NSUserDefaults standardUserDefaults] setObject:AdditionalInfoCheckArr forKey:@"AdditionalInfoCheckArr"];
        
        [AdditionalInfoCheckArr removeAllObjects];
        [AdditionalInfoArray removeAllObjects];
    }
    MedsArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"Meds"]];
    ProcedureArr = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"Procedure"]];
    
    SymptomsArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"Symptoms"]];
    AdditionalInfoArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"AdditionalInfo"]];
    MeedsCheckArr = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"MeedsCheckArr"]];
    ProcedureCheckArr = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"ProcedureCheckArr"]];
    
    SymptomsCheckArr = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"SymptomsCheckArr"]];
    CervicalCheckArr = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"CervicalCheckArr"]];
    AdditionalInfoCheckArr = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"AdditionalInfoCheckArr"]];
    [self resizing];
    
   Cal = [[CKCalendarView alloc]init];

    Cal.delegate = self;    
    CalendarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, Cal.frame.size.height)];
     self.Calendar=[[CKCalendarView alloc]initWithStartDay:startMonday];
    [CalendarView setBackgroundColor:[UIColor whiteColor]];
    [CalendarView addSubview:Cal];
    [MainView addSubview:CalendarView];
    [CalendarView setHidden:YES];
    
    accordion = [[AccordionView alloc] initWithFrame:CGRectMake(10, 0, 300, MainView.frame.size.height)];
    
    
    [self.MainView addSubview:accordion];
    [accordion addHeader:btnGeneralCycle withView:self.GeneralCycleView];
    [accordion addHeader:btnTestsMonitor withView:self.TestMonitorView];
    [accordion addHeader:btnMeds withView:MedsView];
    [accordion addHeader:btnSymptoms withView:SymptomsView];
    [accordion addHeader:btnComments withView:CommentsView];
    [accordion addHeader:btnMoodEnergy withView:MoodEnergyView];
    [accordion addHeader:btnAdditionalInfo withView:AdditionalInfoView];
    [accordion setAllowsMultipleSelection:YES];
    [accordion setNeedsLayout];
    
//    accordion.layer.borderColor=[[UIColor lightGrayColor]CGColor];
//    accordion.layer.borderWidth=0.7;
    
//    [accordion addSubview:AddEdit];
    [MainView addSubview:AddEdit];
    [MainView bringSubviewToFront:AddEdit];
    _imgPopUp.layer.cornerRadius=1;
    _imgPopUp.layer.borderColor=[[UIColor colorWithRed:231/255.0f green:216/255.0f blue:222/255.0f alpha:1]CGColor];
    _imgPopUp.layer.borderWidth=2;
//    AddEdit.layer.cornerRadius=1;
//    AddEdit.layer.borderColor=[[UIColor darkGrayColor]CGColor];
//    AddEdit.layer.borderWidth=2;
    
    self.txtTime.inputView = self.TimePicker;
    self.txtCerviaclFluid.inputView = self.picker;
    self.txtMPS.inputView = self.picker2;
    self.txtIntercourse.inputView = self.picker3;
    self.txtOPK.inputView = self.picker4;
    self.txtMonitor.inputView = self.picker5;
    self.txtFerningTest.inputView = self.picker6;
    self.txtOVWatch.inputView = self.picker7;
    self.txtPregnancyTest.inputView = self.picker8;
    self.txtMood.inputView = self.picker9;
    self.txtEnergy.inputView = self.picker10;
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ToDismissPickers)];
    [self.MainView addGestureRecognizer:tap];
    
    [txtTemperature setInputAccessoryView:self.toolbar];
    [txtTime setInputAccessoryView:self.toolbar];
    [txtCerviaclFluid setInputAccessoryView:self.toolbar];
    [txtMPS setInputAccessoryView:self.toolbar];
    [txtIntercourse setInputAccessoryView:self.toolbar];
    [NoteTextView setInputAccessoryView:self.toolbar];
    [txtOPK setInputAccessoryView:self.toolbar];
    [txtMonitor setInputAccessoryView:self.toolbar];
    [txtFerningTest setInputAccessoryView:self.toolbar];
    [txtOVWatch setInputAccessoryView:self.toolbar];
    [txtPregnancyTest setInputAccessoryView:self.toolbar];
    [CommentTextView setInputAccessoryView:self.toolbar];
    [txtMood setInputAccessoryView:self.toolbar];
    [txtEnergy setInputAccessoryView:self.toolbar];
    [txtCramps setInputAccessoryView:self.toolbar];
    [txtBloodhcg setInputAccessoryView:self.toolbar];
}



#pragma mark UIInterfaceOrientation method


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    CGSize rect = accordion.frame.size;
    NSLog(@"did rotate w%f h%f", rect.width, rect.height);
    
    
    rect = MainView.frame.size;
    NSLog(@" after mainview animate rotation w%f h%f", rect.width, rect.height);
    
    
    [accordion setFrame:CGRectMake(10, 0, 300, rect.height-btnSave.frame.size.height-40)];
    [accordion.scrollView setFrame:accordion.frame];

    
    [accordion setDelegate:self];
    [accordion setNeedsLayout];
    
    
//    rect = accordion.frame.size;
//    NSLog(@"will animate rotation w%f h%f", rect.width, rect.height);
  
}


#pragma mark switch method
- (IBAction) toggleEnabledTextForSwitch1onSomeLabel: (id) sender {
//    if (switch1.on) resLabel.text = @"Enabled";
//    else resLabel.text = @"Disabled";
    if(swBooldTest.on)
    {
        NSLog(@"on");
        [txtBloodhcg setHidden:NO];
        
        
    }
    else
    {
        NSLog(@"off");
        [txtBloodhcg setHidden:YES];
    }
    if(swUrineTest.on)
    {
        NSLog(@"on");
    }
    else
    {
        NSLog(@"off");
    }
}

-(void)saveData
{    if (swBooldTest.on)
{
    NSLog(@"switch on");
    
}
else
{
    NSLog(@"switch off");
}
    
    AddEdit.hidden=YES;
    [_imgShade setHidden:YES];
    [tap setEnabled:YES];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:AddEdit cache:YES];
    [UIView commitAnimations];
    
    //    NSLog(@"Save...");
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    NSString *MeedsCommaArr = [MedsArray componentsJoinedByString:@","];
    NSString *ProcedureCommaArr = [ProcedureArr componentsJoinedByString:@","];
    NSString *SymptomsCommaArr = [SymptomsArray componentsJoinedByString:@","];
    //  NSString *CervicalFluid = [CervicalFluidArr componentsJoinedByString:@","];
    NSString *AdditionalInfoCommaArr = [AdditionalInfoArray componentsJoinedByString:@","];
    
    NSString *MeedsComma = [MeedsCheckArr componentsJoinedByString:@","];
    NSString *procedureComma = [ProcedureCheckArr componentsJoinedByString:@","];
    NSString *SymptomsComma = [SymptomsCheckArr componentsJoinedByString:@","];
    NSLog(@"symptons :: %@",SymptomsComma);
    NSString *cervicalComma = [CervicalCheckArr componentsJoinedByString:@","];
    NSString *AdditionalInfoComma = [AdditionalInfoCheckArr componentsJoinedByString:@","];
    
    NSString *textTemperature = [txtTemperature.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textTime  = [txtTime.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textCerviaclFluid = [txtCerviaclFluid.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textMPS  = [txtMPS.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textIntercourse = [txtIntercourse.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textNoteTextView  = [NoteTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textOPK = [txtOPK.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textMonitor  = [txtMonitor.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textFerningTest = [txtFerningTest.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textOVWatch  = [txtOVWatch.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textPregnancyTest = [txtPregnancyTest.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textCommentTextView = [CommentTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textMood  = [txtMood.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textEnergy  = [txtEnergy.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *objIDFromUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"];
    //    NSLog(@"objIDFromUserDefaults = %@",objIDFromUserDefaults);
    
    /// for edit data
    if ([str isEqualToString:@"ToEdit"])
    {
       
            str=@"---";
            PFQuery *query = [PFQuery queryWithClassName:@"MensturalCycleInfo"];
            [query getObjectInBackgroundWithId:strID block:^(PFObject *testObject, NSError *error) {
                
                
                [testObject setObject:textTemperature forKey:@"menstural_temperature"];
                [testObject setObject:textTime forKey:@"menstural_time"];
                [testObject setObject:cervicalComma forKey:@"menstural_cervical_fluid"];
                [testObject setObject:textMPS forKey:@"menstural_mps"];
                [testObject setObject:textIntercourse forKey:@"menstural_intercourse"];
                [testObject setObject:textNoteTextView forKey:@"menstural_notes"];
                [testObject setObject:textOPK forKey:@"menstural_opk"];
                [testObject setObject:textFerningTest forKey:@"menstural_frening_test"];
                [testObject setObject:textPregnancyTest forKey:@"menstural_pregnency_test"];
                [testObject setObject:textCommentTextView forKey:@"menstural_comment"];
                [testObject setObject:textMood forKey:@"menstural_mood"];
                [testObject setObject:textEnergy forKey:@"menstural_energy"];
                
                [testObject setObject:MeedsComma forKey:@"menstural_meds"];
                [testObject setObject:SymptomsComma forKey:@"menstural_symptoms"];
                [testObject setObject:AdditionalInfoComma forKey:@"menstural_additional_info"];
                [testObject setObject:ProcedureCommaArr forKey:@"menstural_procedure_arr"];
                [testObject setObject:MeedsCommaArr forKey:@"menstural_meds_arr"];
                [testObject setObject:procedureComma forKey:@"menstural_procedure"];
                [testObject setObject:SymptomsCommaArr forKey:@"menstural_symptoms_arr"];
                [testObject setObject:AdditionalInfoCommaArr forKey:@"menstural_additional_info_arr"];
                
                [testObject setObject:objIDFromUserDefaults forKey:@"menstural_user_id"];
                
                if(swBooldTest.on)
                {
                    if([txtBloodhcg.text isEqualToString:@""])
                    {
                        [testObject setObject:@"True" forKey:@"BloodTest"];
                    }
                    else
                    {
                        [testObject setObject:txtBloodhcg.text forKey:@"BloodTest"];
                    }
                }
                else
                {
                    [testObject setObject:@"False" forKey:@"BloodTest"];
                }
                if(swUrineTest.on)
                {
                    [testObject setObject:@"True"  forKey:@"UrineTest"];
                }
                else
                {
                    [testObject setObject:@"False" forKey:@"UrineTest"];
                }
                
                
                [testObject save];
            }];
        
    }
    else
    {
        
        ///// for save data
     
            str=@"ToEdit";
            NSDate *Dat = [DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]];
            NSString *DateToDisplay = [dateFormatter stringFromDate:Dat];
            NSLog(@"date :: %@",DateToDisplay);
            NSLog(@"textTemperature :: %@",textTemperature);
            NSLog(@"textTime :: %@",textTime);
            NSLog(@"textCerviaclFluid :: %@",textCerviaclFluid);
            NSLog(@"textMPS :: %@",textMPS);
            NSLog(@"textIntercourse :: %@",textIntercourse);
            NSLog(@"textNoteTextView :: %@",textNoteTextView);
            NSLog(@"textOPK :: %@",textOPK);
            NSLog(@"textMonitor :: %@",textMonitor);
            NSLog(@"textOVWatch :: %@",textOVWatch);
            NSLog(@"textPregnancyTest :: %@",textPregnancyTest);
            NSLog(@"textCommentTextView :: %@",textCommentTextView);
            NSLog(@"textMood :: %@",textMood);
            NSLog(@"textEnergy :: %@",textEnergy);
            NSLog(@"MeedsComma :: %@",MeedsComma);
            NSLog(@"procedure comma :: %@",procedureComma);
            NSLog(@"SymptomsComma :: %@",SymptomsComma);
            NSLog(@"AdditionalInfoComma :: %@",AdditionalInfoComma);
            NSLog(@"MeedsCommaArr :: %@",MeedsCommaArr);
            NSLog(@"AdditionalInfoCommaArr :: %@",AdditionalInfoCommaArr);
            NSLog(@"SymptomsCommaArr :: %@",SymptomsCommaArr);
            NSLog(@"objIDFromUserDefaults :: %@",objIDFromUserDefaults);
            NSLog(@"cervical :: %@",cervicalComma);
            PFObject *testObject = [PFObject objectWithClassName:@"MensturalCycleInfo"];
            [testObject setObject:DateToDisplay forKey:@"menstural_date"];
            [testObject setObject:textTemperature forKey:@"menstural_temperature"];
            [testObject setObject:textTime forKey:@"menstural_time"];
            [testObject setObject:cervicalComma forKey:@"menstural_cervical_fluid"];
            [testObject setObject:textMPS forKey:@"menstural_mps"];
            [testObject setObject:textIntercourse forKey:@"menstural_intercourse"];
            [testObject setObject:textNoteTextView forKey:@"menstural_notes"];
            [testObject setObject:textOPK forKey:@"menstural_opk"];
            [testObject setObject:textFerningTest forKey:@"menstural_frening_test"];
            [testObject setObject:textPregnancyTest forKey:@"menstural_pregnency_test"];
            [testObject setObject:textCommentTextView forKey:@"menstural_comment"];
            [testObject setObject:textMood forKey:@"menstural_mood"];
            [testObject setObject:textEnergy forKey:@"menstural_energy"];
            
            [testObject setObject:MeedsComma forKey:@"menstural_meds"];
            [testObject setObject:procedureComma forKey:@"menstural_procedure"];
            [testObject setObject:SymptomsComma forKey:@"menstural_symptoms"];
            [testObject setObject:AdditionalInfoComma forKey:@"menstural_additional_info"];
            
            [testObject setObject:MeedsCommaArr forKey:@"menstural_meds_arr"];
            [testObject setObject:SymptomsCommaArr forKey:@"menstural_symptoms_arr"];
            [testObject setObject:AdditionalInfoCommaArr forKey:@"menstural_additional_info_arr"];
            [testObject setObject:ProcedureCommaArr forKey:@"menstural_procedure_arr"];
            [testObject setObject:objIDFromUserDefaults forKey:@"menstural_user_id"];
            if(swBooldTest.on)
            {
                if([txtBloodhcg.text isEqualToString:@""])
                {
                    [testObject setObject:@"True" forKey:@"BloodTest"];
                }
                else
                {
                    [testObject setObject:txtBloodhcg.text forKey:@"BloodTest"];
                }
            }
            else
            {
                [testObject setObject:@"False" forKey:@"BloodTest"];
            }
            if(swUrineTest.on)
            {
                [testObject setObject:@"True"  forKey:@"UrineTest"];
            }
            else
            {
                [testObject setObject:@"False" forKey:@"UrineTest"];
            }
            
            [testObject save];
        
    }
    [SVProgressHUD dismiss];
}

#pragma mark button click event
-(IBAction)btnSave:(id)sender;
{
    if (txtTemperature.text.length==0 )
    {
        UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Some Fields are Empty"
                                                            message:@"Do you want to save data without entered Temprature? "
                                                           delegate:self
                                                  cancelButtonTitle:@"YES"
                                                  otherButtonTitles:@"NO", nil];
        [CheckAlert setDelegate:self];
        CheckAlert.tag = 1001;
        [CheckAlert show];
    }
    else
    {
        [self saveData];
    }
    //
}

#pragma mark fetch data from parse data base
-(void)getDateDATA: (NSDate *)selDate
{
    NSString *objIDFromUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"];
   
    NSString *DateToDisplay = [dateFormatter stringFromDate:selDate];
    
    PFQuery *QUE = [PFQuery queryWithClassName:@"MensturalCycleInfo"];
    [QUE whereKey:@"menstural_user_id" equalTo:objIDFromUserDefaults];
    [QUE whereKey:@"menstural_date" equalTo:DateToDisplay];
   // NSLog(@"que :: %@",[QUE findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)]);
    [QUE findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
    {
        NSLog(@"objects:: %@",objects);
        
        if ([objects count]>0)
        {
            //            NSLog(@"Objects = %@",objects);
            NSString *DateTODisplay1 = [DateToDisplayFormatter stringFromDate:selDate];
            [btnDate setTitle:DateTODisplay1 forState:UIControlStateNormal];
            NSMutableArray *menstural_temperature = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_temperature"]];
            txtTemperature.text = [menstural_temperature objectAtIndex:0];
            
            NSMutableArray *menstural_time = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_time"]];
            txtTime.text = [menstural_time objectAtIndex:0];
            
            strTimer = [menstural_time objectAtIndex:0];
            NSLog(@"strtimer :: %@",strTimer);
            NSMutableArray *menstural_cervical_fluid = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_cervical_fluid"]];
            txtCerviaclFluid.text = [menstural_cervical_fluid objectAtIndex:0];
            
            NSMutableArray *menstural_mps = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_mps"]];
            txtMPS.text = [menstural_mps objectAtIndex:0];
            
            NSMutableArray *menstural_intercourse = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_intercourse"]];
            txtIntercourse.text = [menstural_intercourse objectAtIndex:0];
            
            NSMutableArray *menstural_notes = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_notes"]];
            NoteTextView.text = [menstural_notes objectAtIndex:0];
            
            NSMutableArray *menstural_opk = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_opk"]];
            txtOPK.text = [menstural_opk objectAtIndex:0];
            
            //            NSMutableArray *menstural_monitor = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_monitor"]];
            //            txtMonitor.text = [menstural_monitor objectAtIndex:0];
            
            NSMutableArray *menstural_frening_test = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_frening_test"]];
            txtFerningTest.text = [menstural_frening_test objectAtIndex:0];
            
            //            NSMutableArray *menstural_ov_watch = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_ov_watch"]];
            //            txtOVWatch.text = [menstural_ov_watch objectAtIndex:0];
            
            NSMutableArray *menstural_pregnency_test = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_pregnency_test"]];
            txtPregnancyTest.text = [menstural_pregnency_test objectAtIndex:0];
            
            NSMutableArray *menstural_comment = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_comment"]];
            CommentTextView.text = [menstural_comment objectAtIndex:0];
            
            NSMutableArray *menstural_mood = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_mood"]];
            txtMood.text = [menstural_mood objectAtIndex:0];
            
            NSMutableArray *menstural_energy = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_energy"]];
            txtEnergy.text = [menstural_energy objectAtIndex:0];
            
            NSMutableArray *menstural_meds_arr = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_meds_arr"]];
            NSString *str_meds_arr = [menstural_meds_arr objectAtIndex:0];
            NSArray *Arr_meds_arr = [str_meds_arr componentsSeparatedByString:@","];
            [MedsArray removeAllObjects];
            MedsArray = [[NSMutableArray alloc]initWithArray:Arr_meds_arr];
            //            NSLog(@"MedsArray = %@",MedsArray);
            [tblMeds reloadData];
            
            
            
            
            NSMutableArray *bloodTest = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"BloodTest"]];
            NSLog(@"blood Test :: %@",[bloodTest objectAtIndex:0]);
            if([[bloodTest objectAtIndex:0]isEqualToString:@"False"])
            {
                [txtBloodhcg setHidden:YES];
                [swBooldTest setOn:NO animated:YES];
                
                
                
            }
            else
            {
                [swBooldTest setOn:YES animated:NO];
                [txtBloodhcg setHidden:NO];
                txtBloodhcg.text = [bloodTest objectAtIndex:0];
            }
            
            NSMutableArray *UrineTest = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"UrineTest"]];
            NSLog(@"UrineTest Test :: %@",[UrineTest objectAtIndex:0]);
            if([[UrineTest objectAtIndex:0] isEqualToString:@"False"])
            {
                [swUrineTest setOn:NO animated:YES];
            }
            else
            {
                [swUrineTest setOn:YES animated:YES];
            }
            
//            [tblMeds setFrame:CGRectMake(tblMeds.frame.origin.x, tblMeds.frame.origin.y, tblMeds.frame.size.width, 40*[MedsArray count])];
//            MedsView.frame = CGRectMake(MedsView.frame.origin.x, MedsView.frame.origin.y, MedsView.frame.size.width, tblMeds.frame.size.height + 80);
//            [btnAddMeds setFrame:CGRectMake(btnAddMeds.frame.origin.x, tblMeds.frame.origin.y+tblMeds.frame.size.height+10, btnAddMeds.frame.size.width, btnAddMeds.frame.size.height)];
//            
//            [btnEditMeds setFrame:CGRectMake(btnEditMeds.frame.origin.x, tblMeds.frame.origin.y+tblMeds.frame.size.height+10, btnEditMeds.frame.size.width, btnEditMeds.frame.size.height)];
            [self resizeMeds];
            [accordion setOriginalSize:CGSizeMake(MedsView.frame.size.width, MedsView.frame.size.height) forIndex:2];
            
            NSMutableArray *menstural_symptoms_arr = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_symptoms_arr"]];
            NSString *str_symptoms_arr = [menstural_symptoms_arr objectAtIndex:0];
            NSArray *Arr_symptoms_arr = [str_symptoms_arr componentsSeparatedByString:@","];
            NSLog(@"cramps :: %@",[Arr_symptoms_arr objectAtIndex:3]);
            
            //            txtCramps.text = [menstural_symptoms_arr objectAtIndex:3];
            
            [SymptomsArray removeAllObjects];
            SymptomsArray = [[NSMutableArray alloc]initWithArray:Arr_symptoms_arr];
            //            NSLog(@"SymptomsArray = %@",SymptomsArray);
            [tblSymptoms reloadData];
            
            [tblSymptoms setFrame:CGRectMake(tblSymptoms.frame.origin.x, tblSymptoms.frame.origin.y, tblSymptoms.frame.size.width, 40*[SymptomsArray count])];
            [tblCerviaclFluid setFrame:CGRectMake(tblCerviaclFluid.frame.origin.x, tblCerviaclFluid.frame.origin.y, tblCerviaclFluid.frame.size.width, 40*[arrCerviaclFluid count])];
            SymptomsView .frame = CGRectMake(SymptomsView.frame.origin.x, SymptomsView.frame.origin.y, SymptomsView.frame.size.width, tblSymptoms.frame.size.height + 100);
            [btnAddSymptoms setFrame:CGRectMake(btnAddSymptoms.frame.origin.x, tblSymptoms.frame.origin.y+tblSymptoms.frame.size.height+10, btnAddSymptoms.frame.size.width, btnAddSymptoms.frame.size.height)];
            [btnEditSymptoms setFrame:CGRectMake(btnEditSymptoms.frame.origin.x, tblSymptoms.frame.origin.y+tblSymptoms.frame.size.height+10, btnEditSymptoms.frame.size.width, btnEditSymptoms.frame.size.height)];
            [accordion setOriginalSize:CGSizeMake(SymptomsView.frame.size.width, SymptomsView.frame.size.height) forIndex:3];
            
            NSMutableArray *menstural_additional_info_arr = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_additional_info_arr"]];
            NSString *str_additional_info_arr = [menstural_additional_info_arr objectAtIndex:0];
            NSArray *Arr_additional_info_arr = [str_additional_info_arr componentsSeparatedByString:@","];
            [AdditionalInfoArray removeAllObjects];
            AdditionalInfoArray = [[NSMutableArray alloc]initWithArray:Arr_additional_info_arr];
            //            NSLog(@"AdditionalInfoArray = %@",AdditionalInfoArray);
            [tblAdditionalInfo reloadData];
            
            [tblAdditionalInfo setFrame:CGRectMake(tblAdditionalInfo.frame.origin.x, tblAdditionalInfo.frame.origin.y, tblAdditionalInfo.frame.size.width, 40*[AdditionalInfoArray count])];
            AdditionalInfoView .frame = CGRectMake(AdditionalInfoView.frame.origin.x, AdditionalInfoView.frame.origin.y, AdditionalInfoView.frame.size.width, tblAdditionalInfo.frame.size.height + 70);
            [btnAddAdditionalinfo setFrame:CGRectMake(btnAddAdditionalinfo.frame.origin.x, tblAdditionalInfo.frame.origin.y+tblAdditionalInfo.frame.size.height+10, btnAddAdditionalinfo.frame.size.width, btnAddAdditionalinfo.frame.size.height)];
            [btnEditAdditionalinfo setFrame:CGRectMake(btnEditAdditionalinfo.frame.origin.x, tblAdditionalInfo.frame.origin.y+tblAdditionalInfo.frame.size.height+10, btnEditAdditionalinfo.frame.size.width, btnEditAdditionalinfo.frame.size.height)];
            [accordion setOriginalSize:CGSizeMake(AdditionalInfoView.frame.size.width, AdditionalInfoView.frame.size.height) forIndex:6];
            
            NSMutableArray *menstural_meds = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_meds"]];
            NSString *str_meds = [menstural_meds objectAtIndex:0];
            NSArray *Arr_meds = [str_meds componentsSeparatedByString:@","];
            [MeedsCheckArr removeAllObjects];
            MeedsCheckArr = [[NSMutableArray alloc]initWithArray:Arr_meds];
     NSLog(@"MeedsCheckArr = %@",MeedsCheckArr);
            [tblMeds reloadData];
            
            NSMutableArray *menstural_procedure = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_procedure"]];
            NSString *str_procedure = [menstural_procedure objectAtIndex:0];
            NSArray *Arr_procedure = [str_procedure componentsSeparatedByString:@","];
            [ProcedureCheckArr removeAllObjects];
            ProcedureCheckArr = [[NSMutableArray alloc]initWithArray:Arr_procedure];
            //            NSLog(@"MeedsCheckArr = %@",MeedsCheckArr);
            [tblProcedure reloadData];
            
            
            NSMutableArray *menstural_cervical_arr = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_cervical_fluid"]];
            NSString *str_cervical_arr = [menstural_cervical_arr objectAtIndex:0];
            NSArray *Arr_cervical_arr = [str_cervical_arr componentsSeparatedByString:@","];
            [CervicalCheckArr removeAllObjects];
            CervicalCheckArr = [[NSMutableArray alloc]initWithArray:Arr_cervical_arr];
            //            //            NSLog(@"MedsArray = %@",MedsArray);
            [tblCerviaclFluid reloadData];
            
            
            NSMutableArray *menstural_symptoms = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_symptoms"]];
            NSLog(@"cramps :: %@",[menstural_symptoms objectAtIndex:0]);
            
            
            NSString *str_symptoms = [menstural_symptoms objectAtIndex:0];
            NSArray *Arr_symptoms = [str_symptoms componentsSeparatedByString:@","];
            NSLog(@"value :: %@",[Arr_symptoms objectAtIndex:3] );
            txtCramps.text = [NSString stringWithFormat:@"%@",[Arr_symptoms objectAtIndex:3]];
            strCramps1 = [NSString stringWithFormat:@"%@",[Arr_symptoms objectAtIndex:3]];
            [SymptomsCheckArr removeAllObjects];
            SymptomsCheckArr = [[NSMutableArray alloc]initWithArray:Arr_symptoms];
            //            NSLog(@"SymptomsCheckArr = %@",SymptomsCheckArr);
            [tblSymptoms reloadData];
            
            NSMutableArray *menstural_additional_info = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_additional_info"]];
            NSString *str_additional_info = [menstural_additional_info objectAtIndex:0];
            NSArray *Arr_additional_info = [str_additional_info componentsSeparatedByString:@","];
            [AdditionalInfoCheckArr removeAllObjects];
            AdditionalInfoCheckArr = [[NSMutableArray alloc]initWithArray:Arr_additional_info];
            //            NSLog(@"AdditionalInfoCheckArr = %@",AdditionalInfoCheckArr);
            [tblAdditionalInfo reloadData];
            
            NSMutableArray *objectId = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"objectId"]];
            strID = [objectId objectAtIndex:0];
            str=@"ToEdit";
        }
        else
        {
            str=@"---";
            txtTemperature.text = @"";
            txtTime.text = @"";
            txtCerviaclFluid.text = @"";
            txtMPS.text = @"";
            txtIntercourse.text = @"";
            NoteTextView.text = @"";
            txtOPK.text = @"";
            txtMonitor.text = @"";
            txtFerningTest.text = @"";
            txtOVWatch.text = @"";
            txtPregnancyTest.text = @"";
            CommentTextView.text = @"";
            txtMood.text = @"";
            txtEnergy.text = @"";
            txtCramps.text = @"";
            txtBloodhcg.text =@"";
            [swBooldTest setOn:NO animated:YES];
            [swUrineTest setOn:NO animated:YES];
            [txtBloodhcg setHidden:YES];
            [MeedsCheckArr removeAllObjects];
            [ProcedureCheckArr removeAllObjects];
            [SymptomsCheckArr removeAllObjects];
            [CervicalCheckArr removeAllObjects];
            [AdditionalInfoCheckArr removeAllObjects];
            for (int i=0; i<[MedsArray count]; i++)
                [MeedsCheckArr addObject:@"False"];
            for (int i=0; i<[SymptomsArray count]; i++)
                [SymptomsCheckArr addObject:@"False"];
            for(int i=0;i<[arrCerviaclFluid count];i++)
                [CervicalCheckArr addObject:@"False"];
            for (int i=0; i<[AdditionalInfoArray count]; i++)
                [AdditionalInfoCheckArr addObject:@"False"];
            for (int i=0;i<[ProcedureArr count];i++) {
                [ProcedureCheckArr addObject:@"False"];
            }
            
            [tblMeds reloadData];
            [tblSymptoms reloadData];
            [tblAdditionalInfo reloadData];
            [tblCerviaclFluid reloadData];
            [tblProcedure reloadData];
        }
    }];

}

-(void)Querring
{

    NSString *objIDFromUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"];
//    NSLog(@"objIDFromUserDefaults = %@",objIDFromUserDefaults);
    
    NSDate *Dat = [DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]];
    NSString *DateToDisplay = [dateFormatter stringFromDate:Dat];
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = Dat;
    NSDate *yesterday;
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    NSString *strDate = [NSString stringWithFormat:@"%@",yesterday];
    NSLog(@"yesterday :: %@",strDate);
//    [today release];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    dateFormatter1.dateFormat = @"yyyy-MM-dd";
    
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT+5:30"];
    [dateFormatter setTimeZone:gmt];
    NSString *timeStamp = [dateFormatter stringFromDate:yesterday];
      NSLog(@"yesterday111 :: %@",timeStamp);
//    [dateFormatter1 release];
    
    PFQuery *QUE1 = [PFQuery queryWithClassName:@"MensturalCycleInfo"];
    [QUE1 whereKey:@"menstural_user_id" equalTo:objIDFromUserDefaults];
    [QUE1 whereKey:@"menstural_date" equalTo:timeStamp];
    
    [QUE1 findObjectsInBackgroundWithBlock:^(NSArray *objects1, NSError *error) {
        
        if ([objects1 count]>0)
        {
            NSMutableArray *menstural_time = [[NSMutableArray alloc] initWithArray:[objects1 valueForKey:@"menstural_time"]];
            NSString *strdate = [menstural_time objectAtIndex:0];
            NSLog(@"prevoiuse date time :: %@",strdate);
            strTimer = strdate;
            
        }
    }];
    
    PFQuery *QUE = [PFQuery queryWithClassName:@"MensturalCycleInfo"];
    [QUE whereKey:@"menstural_user_id" equalTo:objIDFromUserDefaults];
    [QUE whereKey:@"menstural_date" equalTo:DateToDisplay];
    
    [QUE findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if ([objects count]>0)
        {
//            NSLog(@"Objects = %@",objects);
            NSMutableArray *menstural_temperature = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_temperature"]];
            txtTemperature.text = [menstural_temperature objectAtIndex:0];
            
            NSMutableArray *menstural_time = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_time"]];
            txtTime.text = [menstural_time objectAtIndex:0];
            
            strTimer = [menstural_time objectAtIndex:0];
            NSLog(@"strtimer :: %@",strTimer);
            NSMutableArray *menstural_cervical_fluid = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_cervical_fluid"]];
            txtCerviaclFluid.text = [menstural_cervical_fluid objectAtIndex:0];
            
            NSMutableArray *menstural_mps = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_mps"]];
            txtMPS.text = [menstural_mps objectAtIndex:0];
            
            NSMutableArray *menstural_intercourse = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_intercourse"]];
            txtIntercourse.text = [menstural_intercourse objectAtIndex:0];
            
            NSMutableArray *menstural_notes = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_notes"]];
            NoteTextView.text = [menstural_notes objectAtIndex:0];
            
            NSMutableArray *menstural_opk = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_opk"]];
            txtOPK.text = [menstural_opk objectAtIndex:0];
            
//            NSMutableArray *menstural_monitor = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_monitor"]];
//            txtMonitor.text = [menstural_monitor objectAtIndex:0];
            
            NSMutableArray *menstural_frening_test = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_frening_test"]];
            txtFerningTest.text = [menstural_frening_test objectAtIndex:0];
            
//            NSMutableArray *menstural_ov_watch = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_ov_watch"]];
//            txtOVWatch.text = [menstural_ov_watch objectAtIndex:0];
            
            NSMutableArray *menstural_pregnency_test = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_pregnency_test"]];
            txtPregnancyTest.text = [menstural_pregnency_test objectAtIndex:0];
            
            NSMutableArray *menstural_comment = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_comment"]];
            CommentTextView.text = [menstural_comment objectAtIndex:0];
            
            NSMutableArray *menstural_mood = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_mood"]];
            txtMood.text = [menstural_mood objectAtIndex:0];
            
            NSMutableArray *menstural_energy = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_energy"]];
            txtEnergy.text = [menstural_energy objectAtIndex:0];
            
            NSMutableArray *menstural_meds_arr = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_meds_arr"]];
            NSString *str_meds_arr = [menstural_meds_arr objectAtIndex:0];
            NSArray *Arr_meds_arr = [str_meds_arr componentsSeparatedByString:@","];
            [MedsArray removeAllObjects];
            MedsArray = [[NSMutableArray alloc]initWithArray:Arr_meds_arr];
//            NSLog(@"MedsArray = %@",MedsArray);
            [tblMeds reloadData];
            


            
            NSMutableArray *bloodTest = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"BloodTest"]];
            NSLog(@"blood Test :: %@",[bloodTest objectAtIndex:0]);
            if([[bloodTest objectAtIndex:0]isEqualToString:@"False"])
            {
                [txtBloodhcg setHidden:YES];
                [swBooldTest setOn:NO animated:YES];
            }
            else
            {
                [swBooldTest setOn:YES animated:NO];
                [txtBloodhcg setHidden:NO];
                txtBloodhcg.text = [bloodTest objectAtIndex:0];
             }
            
            NSMutableArray *UrineTest = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"UrineTest"]];
            NSLog(@"UrineTest Test :: %@",[UrineTest objectAtIndex:0]);
            if([[UrineTest objectAtIndex:0] isEqualToString:@"False"])
            {
                [swUrineTest setOn:NO animated:YES];
            }
            else
            {
                [swUrineTest setOn:YES animated:YES];
            }
            
            if([[SymptomsCheckArr objectAtIndex:3 ] isEqualToString:@"True"])
            {
                NSLog(@"cramps..");
                [crampsView setHidden:YES];
                
            }
//            [tblMeds setFrame:CGRectMake(tblMeds.frame.origin.x, tblMeds.frame.origin.y, tblMeds.frame.size.width, 40*[MedsArray count])];
//            MedsView.frame = CGRectMake(MedsView.frame.origin.x, MedsView.frame.origin.y, MedsView.frame.size.width, tblMeds.frame.size.height + 80);
//            [btnAddMeds setFrame:CGRectMake(btnAddMeds.frame.origin.x, tblMeds.frame.origin.y+tblMeds.frame.size.height+10, btnAddMeds.frame.size.width, btnAddMeds.frame.size.height)];
//            [btnEditMeds setFrame:CGRectMake(btnEditMeds.frame.origin.x, tblMeds.frame.origin.y+tblMeds.frame.size.height+10, btnEditMeds.frame.size.width, btnEditMeds.frame.size.height)];
            [self resizeMeds];
            [accordion setOriginalSize:CGSizeMake(MedsView.frame.size.width, MedsView.frame.size.height) forIndex:2];
            
            NSMutableArray *menstural_symptoms_arr = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_symptoms_arr"]];
            NSString *str_symptoms_arr = [menstural_symptoms_arr objectAtIndex:0];
            NSArray *Arr_symptoms_arr = [str_symptoms_arr componentsSeparatedByString:@","];
            NSLog(@"cramps :: %@",[Arr_symptoms_arr objectAtIndex:3]);
            
//            txtCramps.text = [menstural_symptoms_arr objectAtIndex:3];
            
            [SymptomsArray removeAllObjects];
            SymptomsArray = [[NSMutableArray alloc]initWithArray:Arr_symptoms_arr];
//            NSLog(@"SymptomsArray = %@",SymptomsArray);
            [tblSymptoms reloadData];
            
            [tblSymptoms setFrame:CGRectMake(tblSymptoms.frame.origin.x, tblSymptoms.frame.origin.y, tblSymptoms.frame.size.width, 40*[SymptomsArray count])];
            [tblCerviaclFluid setFrame:CGRectMake(tblCerviaclFluid.frame.origin.x, tblCerviaclFluid.frame.origin.y, tblCerviaclFluid.frame.size.width, 40*[arrCerviaclFluid count])];
            SymptomsView .frame = CGRectMake(SymptomsView.frame.origin.x, SymptomsView.frame.origin.y, SymptomsView.frame.size.width, tblSymptoms.frame.size.height + 100);
            [btnAddSymptoms setFrame:CGRectMake(btnAddSymptoms.frame.origin.x, tblSymptoms.frame.origin.y+tblSymptoms.frame.size.height+10, btnAddSymptoms.frame.size.width, btnAddSymptoms.frame.size.height)];
            [btnEditSymptoms setFrame:CGRectMake(btnEditSymptoms.frame.origin.x, tblSymptoms.frame.origin.y+tblSymptoms.frame.size.height+10, btnEditSymptoms.frame.size.width, btnEditSymptoms.frame.size.height)];
            [accordion setOriginalSize:CGSizeMake(SymptomsView.frame.size.width, SymptomsView.frame.size.height) forIndex:3];
            
            NSMutableArray *menstural_additional_info_arr = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_additional_info_arr"]];
            NSString *str_additional_info_arr = [menstural_additional_info_arr objectAtIndex:0];
            NSArray *Arr_additional_info_arr = [str_additional_info_arr componentsSeparatedByString:@","];
            [AdditionalInfoArray removeAllObjects];
            AdditionalInfoArray = [[NSMutableArray alloc]initWithArray:Arr_additional_info_arr];
//            NSLog(@"AdditionalInfoArray = %@",AdditionalInfoArray);
            [tblAdditionalInfo reloadData];
            
            [tblAdditionalInfo setFrame:CGRectMake(tblAdditionalInfo.frame.origin.x, tblAdditionalInfo.frame.origin.y, tblAdditionalInfo.frame.size.width, 40*[AdditionalInfoArray count])];
            AdditionalInfoView .frame = CGRectMake(AdditionalInfoView.frame.origin.x, AdditionalInfoView.frame.origin.y, AdditionalInfoView.frame.size.width, tblAdditionalInfo.frame.size.height + 70);
            [btnAddAdditionalinfo setFrame:CGRectMake(btnAddAdditionalinfo.frame.origin.x, tblAdditionalInfo.frame.origin.y+tblAdditionalInfo.frame.size.height+10, btnAddAdditionalinfo.frame.size.width, btnAddAdditionalinfo.frame.size.height)];
            [btnEditAdditionalinfo setFrame:CGRectMake(btnEditAdditionalinfo.frame.origin.x, tblAdditionalInfo.frame.origin.y+tblAdditionalInfo.frame.size.height+10, btnEditAdditionalinfo.frame.size.width, btnEditAdditionalinfo.frame.size.height)];
            [accordion setOriginalSize:CGSizeMake(AdditionalInfoView.frame.size.width, AdditionalInfoView.frame.size.height) forIndex:6];
            
            NSMutableArray *menstural_meds = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_meds"]];
            NSString *str_meds = [menstural_meds objectAtIndex:0];
            NSArray *Arr_meds = [str_meds componentsSeparatedByString:@","];
            [MeedsCheckArr removeAllObjects];
            MeedsCheckArr = [[NSMutableArray alloc]initWithArray:Arr_meds];
//            NSLog(@"MeedsCheckArr = %@",MeedsCheckArr);
            [tblMeds reloadData];
            
            NSMutableArray *menstural_procedure = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_procedure"]];
            NSString *str_procedure = [menstural_procedure objectAtIndex:0];
            NSArray *Arr_procedure = [str_procedure componentsSeparatedByString:@","];
            [ProcedureCheckArr removeAllObjects];
            ProcedureCheckArr = [[NSMutableArray alloc]initWithArray:Arr_procedure];
            //            NSLog(@"MeedsCheckArr = %@",MeedsCheckArr);
            [tblProcedure reloadData];
            
            NSMutableArray *menstural_procedure1 = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_procedure_arr"]];
            NSString *str_procedure1 = [menstural_procedure1 objectAtIndex:0];
            NSArray *Arr_procedure1 = [str_procedure1 componentsSeparatedByString:@","];
            [ProcedureArr removeAllObjects];
            ProcedureArr = [[NSMutableArray alloc]initWithArray:Arr_procedure1];
            //            NSLog(@"MedsArray = %@",MedsArray);
            [tblProcedure reloadData];
            
//            [tblProcedure setFrame:CGRectMake(tblProcedure.frame.origin.x, tblProcedure.frame.origin.y, tblProcedure.frame.size.width, 40*[ProcedureArr count])];
//            MedsView .frame = CGRectMake(MedsView.frame.origin.x, MedsView.frame.origin.y, AdditionalInfoView.frame.size.width, tblMeds.frame.size.height + tblProcedure.frame.size.height +200);
//            [btnAddProcedure setFrame:CGRectMake(btnAddProcedure.frame.origin.x, tblProcedure.frame.origin.y+tblProcedure.frame.size.height+10, btnAddProcedure.frame.size.width, btnAddProcedure.frame.size.height)];
//            [btnEditProcedure setFrame:CGRectMake(btnEditProcedure.frame.origin.x, tblProcedure.frame.origin.y+tblProcedure.frame.size.height+10, btnEditProcedure.frame.size.width, btnEditProcedure.frame.size.height)];
            [self resizeMeds];
            [accordion setOriginalSize:CGSizeMake(MedsView.frame.size.width, MedsView.frame.size.height) forIndex:2];
            
            
        NSMutableArray *menstural_cervical_arr = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_cervical_fluid"]];
            NSString *str_cervical_arr = [menstural_cervical_arr objectAtIndex:0];
             NSArray *Arr_cervical_arr = [str_cervical_arr componentsSeparatedByString:@","];
            [CervicalCheckArr removeAllObjects];
            CervicalCheckArr = [[NSMutableArray alloc]initWithArray:Arr_cervical_arr];
            //            //            NSLog(@"MedsArray = %@",MedsArray);
            [tblCerviaclFluid reloadData];

            
            NSMutableArray *menstural_symptoms = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_symptoms"]];
            NSLog(@"cramps :: %@",[menstural_symptoms objectAtIndex:0]);
          
            
            NSString *str_symptoms = [menstural_symptoms objectAtIndex:0];
            NSArray *Arr_symptoms = [str_symptoms componentsSeparatedByString:@","];
              NSLog(@"value :: %@",[Arr_symptoms objectAtIndex:3] );
            txtCramps.text = [NSString stringWithFormat:@"%@",[Arr_symptoms objectAtIndex:3]];
            strCramps1 = [NSString stringWithFormat:@"%@",[Arr_symptoms objectAtIndex:3]];
            [SymptomsCheckArr removeAllObjects];
            SymptomsCheckArr = [[NSMutableArray alloc]initWithArray:Arr_symptoms];
//            NSLog(@"SymptomsCheckArr = %@",SymptomsCheckArr);
            [tblSymptoms reloadData];
            
            NSMutableArray *menstural_additional_info = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_additional_info"]];
            NSString *str_additional_info = [menstural_additional_info objectAtIndex:0];
            NSArray *Arr_additional_info = [str_additional_info componentsSeparatedByString:@","];
            [AdditionalInfoCheckArr removeAllObjects];
            AdditionalInfoCheckArr = [[NSMutableArray alloc]initWithArray:Arr_additional_info];
//            NSLog(@"AdditionalInfoCheckArr = %@",AdditionalInfoCheckArr);
            [tblAdditionalInfo reloadData];
            
            NSMutableArray *objectId = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"objectId"]];
            strID = [objectId objectAtIndex:0];
            str=@"ToEdit";
        }
        else
        {
            str=@"---";
            txtTemperature.text = @"";
            txtTime.text = @"";
            txtCerviaclFluid.text = @"";
            txtMPS.text = @"";
            txtIntercourse.text = @"";
            NoteTextView.text = @"";
            txtOPK.text = @"";
            txtMonitor.text = @"";
            txtFerningTest.text = @"";
            txtOVWatch.text = @"";
            txtPregnancyTest.text = @"";
            CommentTextView.text = @"";
            txtMood.text = @"";
            txtEnergy.text = @"";
            txtCramps.text = @"";
            txtBloodhcg.text =@"";
            [swBooldTest setOn:NO animated:YES];
            [swUrineTest setOn:NO animated:YES];
            [txtBloodhcg setHidden:YES];
            [MeedsCheckArr removeAllObjects];
            [ProcedureCheckArr removeAllObjects];
            [SymptomsCheckArr removeAllObjects];
            [CervicalCheckArr removeAllObjects];
            [AdditionalInfoCheckArr removeAllObjects];
            for (int i=0; i<[MedsArray count]; i++)
                [MeedsCheckArr addObject:@"False"];
            for (int i=0; i<[SymptomsArray count]; i++)
                [SymptomsCheckArr addObject:@"False"];
            for(int i=0;i<[arrCerviaclFluid count];i++)
                [CervicalCheckArr addObject:@"False"];
            for (int i=0; i<[AdditionalInfoArray count]; i++)
                [AdditionalInfoCheckArr addObject:@"False"];
            for(int i=0;i<[ProcedureArr count];i++)
                [ProcedureCheckArr addObject:@"False"];
            [tblMeds reloadData];
            [tblSymptoms reloadData];
            [tblAdditionalInfo reloadData];
            [tblCerviaclFluid reloadData];
            [tblProcedure reloadData];
        }
    }];
}

-(IBAction)btnDateClick:(id)sender
{
  //  [self saveData];
    [CalendarView setHidden:NO];
    [accordion setHidden:YES];
    [btnDate setEnabled:NO];
    [btnPrevious setEnabled:NO];
    [btnNext setEnabled:NO];

    self.Calendar=[[CKCalendarView alloc]initWithStartDay:startMonday];
    self.Calendar.delegate=self;
    [self.Calendar setBackgroundColor:[UIColor whiteColor]];
    [CalendarView setBackgroundColor:[UIColor whiteColor]];
    self.Calendar.onlyShowCurrentMonth=NO;
    self.Calendar.adaptHeightToNumberOfWeeksInMonth=YES;
   
    [self.Calendar setFrame:CGRectMake(0, 0, 320, 320)];
    [CalendarView addSubview:self.Calendar];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:CalendarView cache:YES];
    [UIView commitAnimations];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
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
    PFQuery *query2 = [PFQuery queryWithClassName:@"MensturalCycleInfo"];
    [query2 whereKey:@"menstural_user_id" equalTo:objIDFromUserDefaults];
    [query2 orderByAscending:@"menstural_date"];
    NSLog(@"query :: %@",query2);
    [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
    {
        
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
        [CalendarView setBackgroundColor:[UIColor whiteColor]];
        self.Calendar.onlyShowCurrentMonth=NO;
        self.Calendar.adaptHeightToNumberOfWeeksInMonth=YES;
        //        if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
        //        {
        //            [self.Calendar setFrame:CGRectMake(124, 10, 320, 320)];
        //        }
        //        else
        //        {
        [self.Calendar setFrame:CGRectMake(0, 0, 320, 320)];
        //        }
        [CalendarView addSubview:self.Calendar];
        
        
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
            [Cal reloadData];
        }
        else
        {
            //            NSLog(@"Less Then 5 Data...");
        }
        [SVProgressHUD dismiss];
    }];

    
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
- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    //  self.dateLabel.text = [self.dateFormatter stringFromDate:date];
    MensturalCycleViewController *vc=[[MensturalCycleViewController alloc]init];
    vc.mensDate=date;
    [self.navigationController pushViewController:vc animated:YES];
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

-(IBAction)btnPreviousClick:(id)sender
{
    [self saveData];
    //crampViewShow = false;
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = -1;
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    [Cal selectDate:[DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]] makeVisible:TRUE];
    //[Cal selectDate:[DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]]];
    [btnDate setTitle:[DateToDisplayFormatter stringFromDate:[theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]] options:0]] forState:UIControlStateNormal];
    [self Querring];
}

-(IBAction)btnNextClick:(id)sender
{
    [self saveData];
//    crampViewShow = false;
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 1;
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    
    NSDate *today = [NSDate date];
    NSDate *newDate = [theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]] options:0];
    
    NSComparisonResult result=[today compare:newDate];
    
    if(result==NSOrderedAscending)
    {
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Can not enter Menstrual Cycle information for future dates." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Alert show];
//        [Alert release];
        [SVProgressHUD dismiss];
    }
    else
    {
        [Cal selectDate:[DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]] makeVisible:TRUE];
//        [Cal selectDate:[DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]]];
        [btnDate setTitle:[DateToDisplayFormatter stringFromDate:[theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]] options:0]] forState:UIControlStateNormal];
        [self Querring];
    }
   
//    [Cal selectDate:[DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]]];
//    [btnDate setTitle:[DateToDisplayFormatter stringFromDate:[theCalendar dateByAddingComponents:dayComponent toDate:[DateToDisplayFormatter dateFromString:[btnDate titleForState:UIControlStateNormal]] options:0]] forState:UIControlStateNormal];
//    [self Querring];
}
#pragma mark calender method

- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d
{
    [tap setEnabled:YES];
    [btnDate setEnabled:YES];
    
    [btnPrevious setEnabled:YES];
    [btnNext setEnabled:YES];
    
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 1;
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    
    NSDate *today = [NSDate date];
    NSDate *newDate = [theCalendar dateByAddingComponents:dayComponent toDate:d options:0];
    
    NSComparisonResult result=[today compare:newDate];


    if(result == NSOrderedAscending)
    {
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Can not enter Menustral Information for future dates." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Alert show];
//        [Alert release];
        return;
    }
    else
    {
        [dateFormatter setDateFormat:@"dd-MM-yyy"];
        [btnDate setTitle:[DateToDisplayFormatter stringFromDate:d] forState:UIControlStateNormal];
        [self getDateDATA:d];
    }
    
    [CalendarView setHidden:YES];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:CalendarView cache:YES];
    [UIView commitAnimations];
    [accordion setHidden:NO];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:accordion cache:YES];
    [UIView commitAnimations];
    
    d= nil;
}
- (void)TimePickerChanged:(id)sender
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"hh:mm a"];
    txtTime.text = [outputFormatter stringFromDate:TimePicker.date];
}

- (void)ToDismissPickers
{
//    [txtTemperature resignFirstResponder];
//    [txtTime resignFirstResponder];
//    [txtCerviaclFluid resignFirstResponder];
//    [txtMPS resignFirstResponder];
//    [txtIntercourse resignFirstResponder];
//    [NoteTextView resignFirstResponder];
//    [txtOPK resignFirstResponder];
//    [txtMonitor resignFirstResponder];
//    [txtFerningTest resignFirstResponder];
//    [txtOVWatch resignFirstResponder];
//    [txtPregnancyTest resignFirstResponder];
//    [CommentTextView resignFirstResponder];
//    [txtMood resignFirstResponder];
//    [txtEnergy resignFirstResponder];
//    [txtCramps resignFirstResponder];
//    [txtBloodhcg resignFirstResponder];
    
}



-(IBAction)btnAddNewClick:(id)sender
{
    UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Add New" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    txt = [[UITextField alloc] initWithFrame:CGRectMake(17, 50, 250, 30)];
    [txt setBackgroundColor:[UIColor whiteColor]];
    [txt setDelegate:self];
    [CheckAlert addSubview:txt];
    [CheckAlert bringSubviewToFront:txt];
    [CheckAlert setDelegate:self];
    [CheckAlert show];
//    NSLog(@"From=%@",From);
}

-(IBAction)btnEditExistingClick:(id)sender
{
    
}

-(IBAction)btnCancelPopupClick:(id)sender
{
    AddEdit.hidden=YES;
    [_imgShade setHidden:YES];
    [tap setEnabled:YES];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:AddEdit cache:YES];
    [UIView commitAnimations];
}

#pragma mark alert view
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 11)
    {
       if(buttonIndex == 1)
       {
           NSLog(@"YES");
           NSLog(@"strtimer 22 :: %@",strTimer);
           if([strTimer length] > 0)
           {
              txtTime.text = strTimer;
           }
           else
           {
               UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Set Time"
                                                              message:@"There was no data entered."
                                                             delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil, nil];
               [alert setDelegate:self];
              
               [alert show];
               
                 [TimePicker setHidden:NO];
               
           }
         
           
       }
        else
        {
            NSLog(@"NO");
            [TimePicker setHidden:NO];
        }
    }
    if (buttonIndex == 1)
    {
        if ([From isEqualToString:@"Meds"])
        {
            if(intMedsView == 1)
        {
            From=@"zzz";
            UITextField *textField = [alertView textFieldAtIndex:0];
            [MedsArray addObject:textField.text];
            [MeedsCheckArr addObject:@"False"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Meds"];
            [[NSUserDefaults standardUserDefaults] setObject:MedsArray forKey:@"Meds"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MeedsCheckArr"];
            [[NSUserDefaults standardUserDefaults] setObject:MedsArray forKey:@"MeedsCheckArr"];
            [tblMeds reloadData];
            
//            [tblMeds setFrame:CGRectMake(tblMeds.frame.origin.x, tblMeds.frame.origin.y, tblMeds.frame.size.width, 40*[MedsArray count])];
//            
//         
//            
//            [btnAddMeds setFrame:CGRectMake(btnAddMeds.frame.origin.x, tblMeds.frame.origin.y+tblMeds.frame.size.height+10, btnAddMeds.frame.size.width, btnAddMeds.frame.size.height)];
//            [btnEditMeds setFrame:CGRectMake(btnEditMeds.frame.origin.x, tblMeds.frame.origin.y+tblMeds.frame.size.height+10, btnEditMeds.frame.size.width, btnEditMeds.frame.size.height)];
//            
//            
//             [MedsDetail setFrame:CGRectMake(MedsDetail.frame.origin.x, MedsDetail.frame.origin.y  , MedsDetail.frame.size.width, tblMeds.frame.origin.y +tblMeds.frame.size.height +50)];
//           
//            
//            
//            
////            [ProcedureView setFrame:CGRectMake(ProcedureView.frame.origin.x, MedsDetail.frame.origin.y + MedsDetail.frame.size.height+30 , ProcedureView.frame.size.width, btnEditProcedure.frame.origin.y+btnEditProcedure.frame.size.height +20 )];
//            
//            MedsView.frame = CGRectMake(MedsView.frame.origin.x, MedsView.frame.origin.y, MedsView.frame.size.width,ProcedureView.frame.origin.y+ ProcedureView.frame.size.height +10);
//            NSLog(@"MedsView %@",NSStringFromCGRect(MedsView.frame));
//            
            [self resizing];
            
            [accordion setOriginalSize:CGSizeMake(MedsView.frame.size.width, MedsView.frame.size.height) forIndex:2];
        }
            else
            {
                From=@"zzz";
                UITextField *textField = [alertView textFieldAtIndex:0];
                [ProcedureArr addObject:textField.text];
                [ProcedureCheckArr addObject:@"False"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Procedure"];
                [[NSUserDefaults standardUserDefaults] setObject:ProcedureArr forKey:@"Procedure"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ProcedureCheckArr"];
                [[NSUserDefaults standardUserDefaults] setObject:ProcedureCheckArr forKey:@"ProcedureCheckArr"];
                [tblProcedure reloadData];
//                
//            
//             
//                [tblProcedure setFrame:CGRectMake(tblProcedure.frame.origin.x,  tblProcedure.frame.origin.y, tblProcedure.frame.size.width, 40*[ProcedureArr count])];
//
//                [btnAddProcedure setFrame:CGRectMake(btnAddProcedure.frame.origin.x, tblProcedure.frame.origin.y+tblProcedure.frame.size.height+20, btnAddProcedure.frame.size.width, btnAddProcedure.frame.size.height)];
//                
//                [btnEditProcedure setFrame:CGRectMake(btnEditProcedure.frame.origin.x,tblProcedure.frame.origin.y+tblProcedure.frame.size.height+20, btnEditProcedure.frame.size.width, btnEditProcedure.frame.size.height)];
//                
//                [ProcedureView setFrame:CGRectMake(ProcedureView.frame.origin.x, btnAddMeds.frame.origin.y + btnAddMeds.frame.size.height + 50, ProcedureView.frame.size.width, btnAddProcedure.frame.origin.y + btnAddProcedure.frame.size.height + 20)];
//                
//                   MedsView.frame = CGRectMake(MedsView.frame.origin.x, MedsView.frame.origin.y, MedsView.frame.size.width, tblMeds.frame.size.height +ProcedureView.frame.size.height + 100);
                
                [self resizing];
                [accordion setOriginalSize:CGSizeMake(MedsView.frame.size.width, MedsView.frame.size.height) forIndex:2];
            }
        }
        else if ([From isEqualToString:@"Symptoms"])
        {
            From=@"zzz";
            UITextField *textField = [alertView textFieldAtIndex:0];
            [SymptomsArray addObject:textField.text];
            [SymptomsCheckArr addObject:@"False"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Symptoms"];
            [[NSUserDefaults standardUserDefaults] setObject:SymptomsArray forKey:@"Symptoms"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SymptomsCheckArr"];
            [[NSUserDefaults standardUserDefaults] setObject:SymptomsCheckArr forKey:@"SymptomsCheckArr"];
            [tblSymptoms reloadData];
            
            [tblSymptoms setFrame:CGRectMake(tblSymptoms.frame.origin.x, tblSymptoms.frame.origin.y, tblSymptoms.frame.size.width, 40*[SymptomsArray count])];
            SymptomsView .frame = CGRectMake(SymptomsView.frame.origin.x, SymptomsView.frame.origin.y, SymptomsView.frame.size.width, tblSymptoms.frame.size.height + 100);
            [btnAddSymptoms setFrame:CGRectMake(btnAddSymptoms.frame.origin.x, tblSymptoms.frame.origin.y+tblSymptoms.frame.size.height+10, btnAddSymptoms.frame.size.width, btnAddSymptoms.frame.size.height)];
            [btnEditSymptoms setFrame:CGRectMake(btnEditSymptoms.frame.origin.x, tblSymptoms.frame.origin.y+tblSymptoms.frame.size.height+10, btnEditSymptoms.frame.size.width, btnEditSymptoms.frame.size.height)];
            
            [accordion setOriginalSize:CGSizeMake(SymptomsView.frame.size.width, SymptomsView.frame.size.height) forIndex:3];
        }
        else if ([From isEqualToString:@"Comments"])
        {
            From=@"zzz";
        }
        else if ([From isEqualToString:@"AdditionalInfo"])
        {
            From=@"zzz";
            UITextField *textField = [alertView textFieldAtIndex:0];
            [AdditionalInfoArray addObject:textField.text];
            [AdditionalInfoCheckArr addObject:@"False"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AdditionalInfo"];
            [[NSUserDefaults standardUserDefaults] setObject:AdditionalInfoArray forKey:@"AdditionalInfo"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AdditionalInfoCheckArr"];
            [[NSUserDefaults standardUserDefaults] setObject:AdditionalInfoCheckArr forKey:@"AdditionalInfoCheckArr"];
            [tblAdditionalInfo reloadData];
            
            [tblAdditionalInfo setFrame:CGRectMake(tblAdditionalInfo.frame.origin.x, tblAdditionalInfo.frame.origin.y, tblAdditionalInfo.frame.size.width, 40*[AdditionalInfoArray count])];
            AdditionalInfoView .frame = CGRectMake(AdditionalInfoView.frame.origin.x, AdditionalInfoView.frame.origin.y, AdditionalInfoView.frame.size.width, tblAdditionalInfo.frame.size.height + 70);
            [btnAddAdditionalinfo setFrame:CGRectMake(btnAddAdditionalinfo.frame.origin.x, tblAdditionalInfo.frame.origin.y+tblAdditionalInfo.frame.size.height+10, btnAddAdditionalinfo.frame.size.width, btnAddAdditionalinfo.frame.size.height)];
            [btnEditAdditionalinfo setFrame:CGRectMake(btnEditAdditionalinfo.frame.origin.x, tblAdditionalInfo.frame.origin.y+tblAdditionalInfo.frame.size.height+10, btnEditAdditionalinfo.frame.size.width, btnEditAdditionalinfo.frame.size.height)];
        
            [accordion setOriginalSize:CGSizeMake(AdditionalInfoView.frame.size.width, AdditionalInfoView.frame.size.height) forIndex:6];
        }
        else if ([From isEqualToString:@"Editing"])
        {
            if (idx<100)
            {
                From=@"zzz";
                UITextField *textField = [alertView textFieldAtIndex:0];
                [MedsArray replaceObjectAtIndex:idx withObject:textField.text];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Meds"];
                [[NSUserDefaults standardUserDefaults] setObject:MedsArray forKey:@"Meds"];
                [tblMeds reloadData];
                [tblAddEdit reloadData];
            }
            else if (idx>99 && idx<200)
            {
                From=@"zzz";
                UITextField *textField = [alertView textFieldAtIndex:0];
                [SymptomsArray replaceObjectAtIndex:idx-100 withObject:textField.text];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Symptoms"];
                [[NSUserDefaults standardUserDefaults] setObject:SymptomsArray forKey:@"Symptoms"];
                [tblSymptoms reloadData];
                [tblAddEdit reloadData];
            }
            else if (idx>199 && idx<300)
            {
                From=@"zzz";
                UITextField *textField = [alertView textFieldAtIndex:0];
                [AdditionalInfoArray replaceObjectAtIndex:idx-200 withObject:textField.text];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AdditionalInfo"];
                [[NSUserDefaults standardUserDefaults] setObject:AdditionalInfoArray forKey:@"AdditionalInfo"];
                [tblAdditionalInfo reloadData];
                [tblAddEdit reloadData];
            }
        }
        else
        {
//            [alertView release];
        }
    }
    if(alertView.tag == 1001)
    {
        if(buttonIndex == 1)
        {
            NSLog(@"cancel");
        }
        else
        {
            NSLog(@"OK");
            [self saveData];
        }
    }
    
    
//    [alertView release];
}


#pragma mark
#pragma mark - PickerView Methods...
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == picker)
    {
        return [CervicalFluidArr count];
    }
    else if (pickerView == picker2)
    {
        return [MPSArr count];
    }
    else if (pickerView == picker3)
    {
        return [InterCourseArr count];
    }
    else if (pickerView == picker4)
    {
        return [OPKArr count];
    }
    else if (pickerView == picker5)
    {
        return [MonitorArr count];
    }
    else if (pickerView == picker6)
    {
        return [FerningTestArr count];
    }
    else if (pickerView == picker7)
    {
        return [OVWatchArr count];
    }
    else if (pickerView == picker8)
    {
        return [PragnencyTestArr count];
    }
    else if (pickerView == picker9)
    {
        return [MoodArr count];
    }
    else if (pickerView == picker10)
    {
        return [EnergyArr count];
    }
    else if (pickerView == pkvCramps)
    {
        return [arrCramps count];
    }
    else
    {
        return [ABC count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == picker)
    {
        return [CervicalFluidArr objectAtIndex:row];
    }
    else if (pickerView == picker2)
    {
        return [MPSArr objectAtIndex:row];
    }
    else if (pickerView == picker3)
    {
        return [InterCourseArr objectAtIndex:row];
    }
    else if (pickerView == picker4)
    {
        return [OPKArr objectAtIndex:row];
    }
    else if (pickerView == picker5)
    {
        return [MonitorArr objectAtIndex:row];
    }
    else if (pickerView == picker6)
    {
        return [FerningTestArr objectAtIndex:row];
    }
    else if (pickerView == picker7)
    {
        return [OVWatchArr objectAtIndex:row];
    }
    else if (pickerView == picker8)
    {
        return [PragnencyTestArr objectAtIndex:row];
    }
    else if (pickerView == picker9)
    {
        return [MoodArr objectAtIndex:row];
    }
    else if (pickerView == picker10)
    {
        return [EnergyArr objectAtIndex:row];
    }
    else if (pickerView == pkvCramps)
    {
        return [arrCramps objectAtIndex:row];
    }
    else
    {
        return [ABC objectAtIndex:row];
    }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == picker)
    {
        txtCerviaclFluid.text = [CervicalFluidArr objectAtIndex:row];
    }
    else if (pickerView == picker2)
    {
        txtMPS.text = [MPSArr objectAtIndex:row];
    }
    else if (pickerView == picker3)
    {
        txtIntercourse.text = [InterCourseArr objectAtIndex:row];
    }
    else if (pickerView == picker4)
    {
        txtOPK.text = [OPKArr objectAtIndex:row];
    }
    else if (pickerView == picker5)
    {
        txtMonitor.text = [MonitorArr objectAtIndex:row];
    }
    else if (pickerView == picker6)
    {
        txtFerningTest.text = [FerningTestArr objectAtIndex:row];
    }
    else if (pickerView == picker7)
    {
        txtOVWatch.text = [OVWatchArr objectAtIndex:row];
    }
    else if (pickerView == picker8)
    {
        txtPregnancyTest.text = [PragnencyTestArr objectAtIndex:row];
    }
    else if (pickerView == picker9)
    {
        txtMood.text = [MoodArr objectAtIndex:row];
//        [txtMood resignFirstResponder];
    }
    else if (pickerView == picker10)
    {
        txtEnergy.text = [EnergyArr objectAtIndex:row];
//        [txtEnergy resignFirstResponder];
    }
    else if (pickerView == pkvCramps)
    {
        txtCramps.text = [arrCramps objectAtIndex:row];
//        [txtCramps resignFirstResponder];
    }
    else
    {
        
    }
}




#pragma mark
#pragma mark - TextField & TextView Delegate Methods...
//- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
//{
//    [theTextField resignFirstResponder];
//    return YES;
//}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeTextField=textField;
    if (textField == txtTemperature)
    {
        [textField setKeyboardType:UIKeyboardTypeDefault];
    }
    else if (textField == txtTime)
    {
       //TimePicker.hidden = NO;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Set Time"
                                                            message:@"Did you take your temp at the same time todays you did yesterday?."
                                                           delegate:self
                                                  cancelButtonTitle:@"NO"
                                                  otherButtonTitles:@"YES", nil];
        [alert setDelegate:self];
        alert.tag = 11;
        [alert show];
    }
    else if (textField == txtCerviaclFluid)
    {
        picker.hidden = NO;
        [picker setTag:1];
    }
    else if (textField == txtMPS)
    {
        picker2.hidden = NO;
        [picker setTag:2];
    }
    else if (textField == txtIntercourse)
    {
        picker3.hidden = NO;
        [picker setTag:3];
    }
    else if (textField == txtOPK)
    {
        picker4.hidden = NO;
        [picker setTag:4];
    }
    else if (textField == txtMonitor)
    {
        picker5.hidden = NO;
        [picker setTag:5];
    }
    else if (textField == txtFerningTest)
    {
        picker6.hidden = NO;
        [picker2 setTag:6];
    }
    else if (textField == txtOVWatch)
    {
        picker7.hidden = NO;
        [picker setTag:7];
    }
    else if (textField == txtPregnancyTest)
    {
        picker8.hidden = NO;
        [picker2 setTag:8];
    }
    else if (textField == txtMood)
    {
        picker9.hidden = NO;
        [picker setTag:9];
    }
    else if (textField == txtEnergy)
    {
        picker10.hidden = NO;
        [picker2 setTag:10];
    }
    else if (textField == txtCramps)
    {
        pkvCramps.hidden = NO;
        [pkvCramps setTag:11];
    }
    else
    {
    
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionTransitionCurlUp animations:^{
        CGRect rc = [textView bounds];
        rc = [textView convertRect:rc toView:Scroll];
        rc.origin.x = 0 ;
        rc.origin.y = 110 ;
        CGPoint pt=rc.origin;
        [self.Scroll setContentOffset:pt animated:YES];
    }completion:nil];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==txtCerviaclFluid || textField==txtMPS || textField==txtIntercourse || textField==txtOPK || textField==txtMonitor || textField==txtFerningTest || textField==txtOVWatch || textField==txtPregnancyTest || textField==txtMood || textField==txtEnergy || textField==txtOPK || textField==txtTime || textField==txtCramps)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if([text isEqualToString:@"\n"])
//    {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    else
//    {
//        return YES;
//    }
//}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionTransitionCurlUp animations:^{
        CGRect rc = [textView bounds];
        rc = [textView convertRect:rc toView:Scroll];
        rc.origin.x = 0 ;
        rc.origin.y = 0 ;
        CGPoint pt=rc.origin;
        [self.Scroll setContentOffset:pt animated:YES];
    }completion:nil];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    // Here You can do additional code or task instead of writing with keyboard
    if(textField == txtCramps)
    {
        return NO;
        
    }
    else
    {
        return YES;
    }
}

#pragma mark
#pragma mark - Table Methods...
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"table view in row in section :: %@",tableView);
    if(tableView.tag == 10)
    {
        return [ProcedureArr count];
    }
    if (tableView==tblMeds)
    {
        return [MedsArray count];
    }
    else if (tableView == tblProcedure)
    {
        return [ProcedureArr count];
    }
    else if (tableView == tblSymptoms)
    {
        return [SymptomsArray count];
    }
    else if (tableView == tblAdditionalInfo)
    {
        return [AdditionalInfoArray count];
    }
    else if (tableView == tblCerviaclFluid)
    {
        NSLog(@"count cf :: %d",[arrCerviaclFluid count]);
        return [arrCerviaclFluid count];
//        return 10;
    }
    else
    {
        if ([TableToLoad isEqualToString:@"btnAddMedsClick"])
        {
            return [MedsArray count];
            return [ProcedureArr count];
        }
        
        else if ([TableToLoad isEqualToString:@"btnAddSymptomsClick"])
        {
            return [SymptomsArray count];
        }
        else if ([TableToLoad isEqualToString:@"btnAddAdditionalinfoClick"])
        {
            return [AdditionalInfoArray count];
        }
        else if ([TableToLoad isEqualToString:@"btnEditMedsClick"])
        {
            return [MedsArray count];
        }
        else if ([TableToLoad isEqualToString:@"btnEditSymptomsClick"])
        {
            return [SymptomsArray count];
        }
        else
        {
            return [AdditionalInfoArray count];
        }
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"table view :: %@",tableView);
    static NSString *simpleTableIdentifier = @"MeedsTable";
    MeedsTableCell *cell = (MeedsTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MeedsTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell.SW setOnTintColor:[UIColor colorWithRed:25/255.0f green:167/255.0f blue:249/255.0f alpha:1.00f]];
    [cell.SW setOffTintColor:[UIColor whiteColor]];
    cell.SW.transform = CGAffineTransformMakeScale(0.70, 0.70);
   
    if (tableView==tblMeds)
    {
        
        CheckFOR=@"tblMeds";
        [cell.RowButton setHidden:YES];
        
        cell.lblName.text = [MedsArray objectAtIndex:[indexPath row]];
        [cell.SW setTag:indexPath.row];
        if([MeedsCheckArr count]==0)
        {
            
        }
        else
        {
            
        if ([[MeedsCheckArr objectAtIndex:indexPath.row] isEqualToString:@"True"])
        {
            [cell.SW setOn:YES animated:YES];
           
        }
        else
        {
            [cell.SW setOn:NO animated:YES];
        }
        [cell.SW addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventValueChanged];
        }
    }
    else if (tableView == tblProcedure)
    {
        CheckFOR=@"tblProcedure";
        [cell.RowButton setHidden:YES];
        
        cell.lblName.text = [ProcedureArr objectAtIndex:[indexPath row]];
        [cell.SW setTag:indexPath.row+600];
        if([ProcedureCheckArr count]==0)
        {
        
        }
        else
        {
        if ([[ProcedureCheckArr objectAtIndex:indexPath.row] isEqualToString:@"True"])
        {
            [cell.SW setOn:YES animated:YES];
            
        }
        else
        {
            [cell.SW setOn:NO animated:YES];
        }
        [cell.SW addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventValueChanged];
        }
    }
    else if (tableView == tblCerviaclFluid)
    {
        CheckFOR=@"tblCerviaclFluid";
        [cell.RowButton setHidden:YES];
        
        cell.lblName.text = [arrCerviaclFluid objectAtIndex:[indexPath row]];
        [cell.SW setTag:indexPath.row+400];
        
        if ([CervicalCheckArr count]==0) {
            
        }
        else{
            if ([[CervicalCheckArr objectAtIndex:indexPath.row] isEqualToString:@"True"])
            {
                [cell.SW setOn:YES animated:YES];
                
            }
            else
            {
                [cell.SW setOn:NO animated:YES];
            }
        }
        
        [cell.SW addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventValueChanged];
    }
    else if (tableView == tblSymptoms)
    {
         CheckFOR=@"tblSymptoms";
        [cell.RowButton setHidden:YES];
        cell.lblName.text = [SymptomsArray objectAtIndex:[indexPath row]];
        
           [cell.SW setTag:indexPath.row+100];
        if (indexPath.row==3)
        {
            if ([[SymptomsCheckArr objectAtIndex:indexPath.row] isEqualToString:@"False"]) {
                [crampsView setHidden:YES];
               [cell.SW setOn:NO animated:YES];
                [cell.SW addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventValueChanged];
            }
            else{
                
                [crampsView setHidden:YES];
                [cell.SW setOn:YES animated:YES];
            }
            
        }

        if ([[SymptomsCheckArr objectAtIndex:indexPath.row] isEqualToString:@"True"])
        {
            [cell.SW setOn:YES animated:YES];
            [cell.SW addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventValueChanged];
        }
        else
        {
            [cell.SW setOn:NO animated:YES];
            [cell.SW addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventValueChanged];
        }
        
    }
    else if (tableView == tblAdditionalInfo)
    {
        CheckFOR=@"tblAdditionalInfo";
        [cell.RowButton setHidden:YES];
        cell.lblName.text = [AdditionalInfoArray objectAtIndex:[indexPath row]];
        [cell.SW setTag:indexPath.row+200];
//        NSLog(@"Indexpath.Row = %d", [indexPath row]);
        
        if ([[AdditionalInfoCheckArr objectAtIndex:indexPath.row] isEqualToString:@"True"])
        {
            [cell.SW setOn:YES animated:YES];
        }
        else
        {
            [cell.SW setOn:NO animated:YES];
        }
        [cell.SW addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventValueChanged];
    }
    else if (tableView == tblAddEdit)
    {
        [cell.lblName setTextColor:[UIColor colorWithRed:25/255.0f green:167/255.0f blue:249/255.0f alpha:1]];
        if ([TableToLoad isEqualToString:@"btnEditMedsClick"])
        {
            [cell.lblName setHidden:YES];
            [cell.SW setHidden:YES];
            [cell.RowButton setTag:[indexPath row]];
            [cell.RowButton setTitle:[MedsArray objectAtIndex:[indexPath row]] forState:UIControlStateNormal];
            [cell.RowButton addTarget:self action:@selector(RowtoEdit:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([TableToLoad isEqualToString:@"btnEditSymptomsClick"])
        {
            [cell.lblName setHidden:YES];
            [cell.SW setHidden:YES];
            [cell.RowButton setTag:[indexPath row]+100];
            [cell.RowButton setTitle:[SymptomsArray objectAtIndex:[indexPath row]] forState:UIControlStateNormal];
            [cell.RowButton addTarget:self action:@selector(RowtoEdit:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([TableToLoad isEqualToString:@"btnEditAdditionalinfoClick"])
        {
            [cell.lblName setHidden:YES];
            [cell.SW setHidden:YES];
            [cell.RowButton setTag:[indexPath row]+200];
            [cell.RowButton setTitle:[AdditionalInfoArray objectAtIndex:[indexPath row]] forState:UIControlStateNormal];
            [cell.RowButton addTarget:self action:@selector(RowtoEdit:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    else
    {
//        NSLog(@"Boss...");
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tblSymptoms)
    {
        CheckFOR=@"tblSymptoms";
        
        if([[SymptomsCheckArr objectAtIndex:3 ] isEqualToString:@"True"])
            {
                NSLog(@"cramps..");
                [crampsView setHidden:NO];
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1.0];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:crampsView cache:YES];
                [UIView commitAnimations];
                //[self.view bringSubviewToFront:crampsView];
                
                
            }
     }

}
-(void)RowtoEdit: (id)sender
{
//    NSLog(@"IDX = %d", [sender tag]);
    [self ToDismissPickers];
    UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Edit" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Edit", nil];
    idx=[sender tag];
    [CheckAlert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *textField = [CheckAlert textFieldAtIndex:0];
    if (idx<100)
    {
        textField.text=[MedsArray objectAtIndex:[sender tag]];
    }
    else if (idx>99 && idx<200)
    {
        textField.text=[SymptomsArray objectAtIndex:[sender tag]-100];
    }
    else if (idx>199 && idx<300)
    {
        textField.text=[AdditionalInfoArray objectAtIndex:[sender tag]-200];
    }
    [CheckAlert setDelegate:self];
    [CheckAlert show];
    From=@"Editing";
}
-(void)checkboxClicked:(id)sender
{
    [self ToDismissPickers];
    UISwitch *btnSelected=(UISwitch*) sender;
 //  NSLog(@"cramp : %d",     crampViewShow);
    if (btnSelected.isOn)
    {
        if (btnSelected.tag<100)
        {
            CheckFOR=@"Done";
            [MeedsCheckArr replaceObjectAtIndex:btnSelected.tag withObject:@"True"];
        }
        else if (btnSelected.tag>99 && btnSelected.tag<200)
        {
            CheckFOR=@"Done";
           // NSInteger sectionCount = self.tblSymptoms.numberOfRowsInSection;
            NSLog(@"row :: %@",[SymptomsCheckArr objectAtIndex:0 ]);
            NSLog(@"symptons tag :: %d",btnSelected.tag-100);
            [SymptomsCheckArr replaceObjectAtIndex:btnSelected.tag-100 withObject:@"True"];
            
            if([[SymptomsCheckArr objectAtIndex:3 ] isEqualToString:@"True"])
            {
                NSLog(@"cramps..");
                [crampsView setHidden:NO];
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1.0];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:crampsView cache:YES];
                [UIView commitAnimations];
          
            }

        }
        else if (btnSelected.tag>199 && btnSelected.tag<300)
        {
            CheckFOR=@"Done";
            [AdditionalInfoCheckArr replaceObjectAtIndex:btnSelected.tag-200 withObject:@"True"];
        }
        else if (btnSelected.tag >299 && btnSelected.tag<500)
        {
            CheckFOR=@"Done";
            NSLog(@"tag :: %d",btnSelected.tag-400);
            [CervicalCheckArr replaceObjectAtIndex:btnSelected.tag-400 withObject:@"True"];
        }
        else if (btnSelected.tag >499 && btnSelected.tag<700)
        {
            CheckFOR = @"Done";
            NSLog(@"tag:: %d",btnSelected.tag);
            [ProcedureCheckArr replaceObjectAtIndex:btnSelected.tag-600 withObject:@"True"];
        }
        else
        {
//            NSLog(@"Out Of Coverage...");
        }
    }
    else
    {
        if (btnSelected.tag<100)
        {
            CheckFOR=@"Done";
            [MeedsCheckArr replaceObjectAtIndex:btnSelected.tag withObject:@"False"];
        }
        else if (btnSelected.tag>99 && btnSelected.tag<200)
        {
            CheckFOR=@"Done";
            [SymptomsCheckArr replaceObjectAtIndex:btnSelected.tag-100 withObject:@"False"];

            
        }
        else if (btnSelected.tag >499 && btnSelected.tag<700)
        {
            CheckFOR = @"Done";
            NSLog(@"tag:: %d",btnSelected.tag);
            [ProcedureCheckArr replaceObjectAtIndex:btnSelected.tag-600 withObject:@"False"];
        }

        else if (btnSelected.tag>199 && btnSelected.tag<300)
        {
            CheckFOR=@"Done";
            [AdditionalInfoCheckArr replaceObjectAtIndex:btnSelected.tag-200 withObject:@"False"];
        }
        else
        {
//            NSLog(@"Out Of Coverage...");
        }
    }
   
    [self.revealSideViewController setDirectionsToShowBounce:PPRevealSideDirectionNone];

}


#pragma mark
#pragma mark - Button Clicks...
-(IBAction)btnCrampsClose_click:(id)sender
{
    [crampsView setHidden:YES];
    strCramps = txtCramps.text;
    [SymptomsCheckArr replaceObjectAtIndex:3 withObject:strCramps];
    NSLog(@"cramps :: %@",[SymptomsCheckArr objectAtIndex:3]);
   
}
-(IBAction)btnGeneralCycleClick:(id)sender
{
    NSLog(@"btnGeneralCycleClick");
    [self ToDismissPickers];

}
-(IBAction)btnTestsMonitorClick:(id)sender
{
    NSLog(@"btnTestsMonitorClick");
        [self ToDismissPickers];
}
-(IBAction)btnCalendarClick:(id)sender
{
    
}
-(IBAction)btnMenuClick:(id)sender
{
    [self ToDismissPickers];
    MainMenuViewController *obj = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:[NSBundle mainBundle]];
    [self.revealSideViewController pushViewController:obj onDirection:PPRevealSideDirectionLeft withOffset:50 animated:YES];
//    [obj release];
}
-(IBAction)btnMedsClick:(id)sender
{
    [self ToDismissPickers];
}
-(IBAction)btnSymptomsClick:(id)sender
{
    [self ToDismissPickers];
}
-(IBAction)btnMoodEnergyClick:(id)sender
{
    [self ToDismissPickers];
}
-(IBAction)btnCommentsClick:(id)sender
{
    [self ToDismissPickers];
}
-(IBAction)btnAdditionalInfoClick:(id)sender
{
    [self ToDismissPickers];
}

#pragma mark
#pragma mark - Add/Edit Buttons Click...
-(IBAction)btnAddMedsClick:(id)sender
{
    intMedsView = 1;
    [self ToDismissPickers];
    UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Add New" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    [CheckAlert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [CheckAlert setDelegate:self];
    [CheckAlert show];
    From=@"Meds";
}
-(IBAction)btnAddProcedureClick:(id)sender
{
    intMedsView = 2;
    [self ToDismissPickers];
    UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Add New" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    [CheckAlert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [CheckAlert setDelegate:self];
    [CheckAlert show];
    From=@"Meds";
}
-(IBAction)btnAddSymptomsClick:(id)sender
{
    [self ToDismissPickers];
    UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Add New" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    [CheckAlert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [CheckAlert setDelegate:self];
    [CheckAlert show];
    From=@"Symptoms";
}
-(IBAction)btnAddCommentsClick:(id)sender
{
    [self ToDismissPickers];
    UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Add New" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    [CheckAlert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [CheckAlert setDelegate:self];
    [CheckAlert show];
    From=@"Comments";
}
-(IBAction)btnAddAdditionalinfoClick:(id)sender
{
    [self ToDismissPickers];
    UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Add New" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    [CheckAlert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [CheckAlert setDelegate:self];
    [CheckAlert show];
    From=@"AdditionalInfo";
}

-(IBAction)btnEditMedsClick:(id)sender
{
    [self ToDismissPickers];
    [tap setEnabled:NO];
    TableToLoad=@"btnEditMedsClick";
    [tblAddEdit reloadData];
    From=@"Meds";
    AddEdit.hidden=NO;
    [_imgShade setHidden:NO];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:AddEdit cache:YES];
    [UIView commitAnimations];
}
-(IBAction)btnEditProcedureClick:(id)sender
{
    [self ToDismissPickers];
    [tap setEnabled:NO];
    TableToLoad=@"btnEditProcedureClick";
    [tblAddEdit reloadData];
    From=@"Meds";
    AddEdit.hidden=NO;
    [_imgShade setHidden:NO];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:AddEdit cache:YES];
    [UIView commitAnimations];
}
-(IBAction)btnEditSymptomsClick:(id)sender
{
    [self ToDismissPickers];
    [tap setEnabled:NO];
    TableToLoad=@"btnEditSymptomsClick";
    [tblAddEdit reloadData];
    From=@"Symptoms";
    AddEdit.hidden=NO;
    [_imgShade setHidden:NO];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:AddEdit cache:YES];
    [UIView commitAnimations];
}
-(IBAction)btnEditCommentsClick:(id)sender
{
    [self ToDismissPickers];
    [tap setEnabled:NO];
    TableToLoad=@"btnEditCommentsClick";
    [tblAddEdit reloadData];
    From=@"Comments";
    AddEdit.hidden=NO;
    [_imgShade setHidden:NO];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:AddEdit cache:YES];
    [UIView commitAnimations];
}
-(IBAction)btnEditAdditionalinfoClick:(id)sender
{
    [self ToDismissPickers];
    [tap setEnabled:NO];
    TableToLoad=@"btnEditAdditionalinfoClick";
    [tblAddEdit reloadData];
    From=@"AdditionalInfo";
    AddEdit.hidden=NO;
    [_imgShade setHidden:NO];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:AddEdit cache:YES];
    [UIView commitAnimations];
}

- (IBAction)btnSettings_Click:(id)sender {
    SettingsViewController *vc=[[SettingsViewController alloc]init];
    vc.FromWhere=@"OVT";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btnMinimize_Click:(id)sender {
    [activeTextField resignFirstResponder];
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
//    [_imgPopUp release];
//    [_imgShade release];
//    [super dealloc];
}
@end