//
//  SettingsViewController.m
//  BabyMaker
//
//  Created by ajeet Singh on 13/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "SettingsViewController.h"
#import "MainMenuViewController.h"
#import "PPRevealSideViewController.h"
#import "OvulationTrackerCalViewController.h"
#import "CheckboxCell.h"
#import "EditTextFieldCell.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"


@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize txtDateOfBirth,txtFirstDay,txtUsualCycleLength,txtMethodUnits,txtTemperatureMethods,txtPatnerID,txtAdd,txtEdit,txtFirstName,txtImage;
@synthesize Scroll,btnSaveSettings,btnBack,btnCheckBox,btnOk,DescTextView,tblDiagnosis,tblEditDiagnosis,btnAdd,btnEdit,btnCancel,AddEditPopUp,btnDateTime,btnAddPhoto;
@synthesize pickerDateOfBirth, pickerFirstDay, pcikerUnits, pickerTemperatureMethods,FromWhere,OBJECTid,DiagnosisArr,itsToDoChecked,userImage,SW,tempImage;
NSMutableArray *FahrenhitCalcius, *TemperatureMethod;
NSMutableString *fileName;
UIToolbar *keyboardDoneButtonView;
bool checked;
int idx=0;
NSString *is_irregular_cycle,*ForAlertView;
NSMutableArray *CheckArr, *tempChecked;
UIImageView *txtImg;
AppDelegate *app;

- (void)viewDidLoad
{
    [super viewDidLoad];
    checked=true;
    app =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [txtPatnerID setKeyboardType:UIKeyboardTypeEmailAddress];
    itsToDoChecked = [[NSMutableArray alloc] init];
    [tblEditDiagnosis setAllowsSelection:YES];
    CheckArr = [[NSMutableArray alloc]init];
    tempChecked = [[NSMutableArray alloc]init];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    [txtDateOfBirth setBackgroundColor:[UIColor clearColor]];
    SW.transform = CGAffineTransformMakeScale(0.70, 0.70);
    [SW setOn:NO animated:YES];
    [tblDiagnosis setDelegate:self];
    [tblDiagnosis setDataSource:self];
    [tblEditDiagnosis setDelegate:self];
    [tblEditDiagnosis setDataSource:self];
    
    userImage.image = [UIImage imageNamed:@"defaultUser.png"];
    txtImage.text = @"---";
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstUpdate"])
    {
        DiagnosisArr = [[NSMutableArray alloc] init];
        [DiagnosisArr addObject:@"Unexplained Fertility Issue"];
        [DiagnosisArr addObject:@"Secondary Fertility Issue"];
        [DiagnosisArr addObject:@"PCOS/PCO"];
        [DiagnosisArr addObject:@"Recurrent Miscarriage"];
        [DiagnosisArr addObject:@"Endometriosis"];
        [DiagnosisArr addObject:@"Male Fertility Issue"];
        
        CheckArr = [[NSMutableArray alloc] init];
        for (int i = 0; i<[DiagnosisArr count]; i++)
            [CheckArr addObject:@"False"];

        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstUpdate"];
        [[NSUserDefaults standardUserDefaults] synchronize];
               
        [[NSUserDefaults standardUserDefaults] setObject:DiagnosisArr forKey:@"DiagnosisArr"];
        [[NSUserDefaults standardUserDefaults] setObject:CheckArr forKey:@"CheckArr"];
        [DiagnosisArr removeAllObjects];
        [CheckArr removeAllObjects];
    }
    DiagnosisArr = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"DiagnosisArr"]];
    CheckArr = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"CheckArr"]];
    
    [tblDiagnosis setFrame:CGRectMake(tblDiagnosis.frame.origin.x, tblDiagnosis.frame.origin.y, tblDiagnosis.frame.size.width,40*[DiagnosisArr count])];
    [btnAdd setFrame:CGRectMake(btnAdd.frame.origin.x, tblDiagnosis.frame.origin.y+tblDiagnosis.frame.size.height+5, btnAdd.frame.size.width, btnAdd.frame.size.height)];
    [btnEdit setFrame:CGRectMake(btnEdit.frame.origin.x, tblDiagnosis.frame.origin.y+tblDiagnosis.frame.size.height+5, btnEdit.frame.size.width, btnEdit.frame.size.height)];
    [Scroll setContentSize:CGSizeMake(320, btnEdit.frame.origin.y+btnEdit.frame.size.height+40)];
//    [btnSaveSettings setFrame:CGRectMake(btnSaveSettings.frame.origin.x, Scroll.frame.origin.y+Scroll.frame.size.height, btnSaveSettings.frame.size.width, btnSaveSettings.frame.size.height)];
    
    if ([FromWhere isEqualToString:@"OVT"])
    {
        btnBack.hidden=NO;
        [btnDateTime setHidden:YES];
//        NSLog(@"objectId = %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"]);
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
        PFQuery *query = [PFQuery queryWithClassName:@"UserMst"];
        [query getObjectInBackgroundWithId:[[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"] block:^(PFObject *testObject, NSError *error) {
            
            if ([[testObject allKeys] count]==2) {
                UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Warning"
                                                                    message:@"No datas are recorded. Please Enter Your Details"
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancel"
                                                          otherButtonTitles:nil];
                
                [CheckAlert setDelegate:self];
                [CheckAlert show];
                [SVProgressHUD dismiss];
            }
            else{
                txtFirstName.text = [testObject objectForKey:@"user_firstname"];
                txtDateOfBirth.text = [testObject objectForKey:@"user_dob"];
                txtPatnerID.text = [testObject objectForKey:@"user_patner_email"];
                txtFirstDay.text = [testObject objectForKey:@"user_first_day"];
                txtUsualCycleLength.text = [testObject objectForKey:@"user_usual_cycle"];
                is_irregular_cycle = [testObject objectForKey:@"user_is_irregular_cycle"];
                if ([is_irregular_cycle isEqualToString:@"true"])
                {
                    checked=false;
                    is_irregular_cycle=@"true";
                    [SW setOn:YES];
                    [btnCheckBox setBackgroundImage:[UIImage imageNamed:@"toggleno.png"] forState:UIControlStateNormal];
                }
                else
                {
                    checked=true;
                    is_irregular_cycle=@"false";
                    [SW setOn:NO];
                    [btnCheckBox setBackgroundImage:[UIImage imageNamed:@"UnCheck.png"] forState:UIControlStateNormal];
                }
                txtMethodUnits.text = [testObject objectForKey:@"user_temperature_units"];
                if ([txtMethodUnits.text isEqualToString:@"Celsius"])
                {
                    [self.pcikerUnits selectRow:1 inComponent:0 animated:YES];
                }
                txtTemperatureMethods.text = [testObject objectForKey:@"user_temperature_methods"];
                if ([txtTemperatureMethods.text isEqualToString:@"Vaginally"])
                {
                    [self.pickerTemperatureMethods selectRow:1 inComponent:0 animated:YES];
                }
                
                if ([[testObject objectForKey:@"user_image"] isEqualToString:@"---"])
                {
                    userImage.image = [UIImage imageNamed:@"defaultUser.png"];
                    txtImage.text = @"---";
                }
                else
                {
                    [txtImage setText:[testObject objectForKey:@"user_image"]];
                    PFFile *userImageFile = testObject[@"imageFile"];
                    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                        if (!error) {
                            userImage.image = [UIImage imageWithData:imageData];
                        }
                    }];
                }
                
                NSString *str = [testObject objectForKey:@"user_diagnosis"];
                NSArray *Arr = [str componentsSeparatedByString:@","];
                [CheckArr removeAllObjects];
                CheckArr = [[NSMutableArray alloc]initWithArray:Arr];
                
                NSString *str2 = [testObject objectForKey:@"user_diagnosis_arr"];
                NSArray *Arr2 = [str2 componentsSeparatedByString:@","];
                [DiagnosisArr removeAllObjects];
                DiagnosisArr = [[NSMutableArray alloc]initWithArray:Arr2 copyItems:YES];
                [tblDiagnosis reloadData];
                [tblEditDiagnosis reloadData];
                [tblDiagnosis setFrame:CGRectMake(tblDiagnosis.frame.origin.x, tblDiagnosis.frame.origin.y, tblDiagnosis.frame.size.width,40*[DiagnosisArr count] )];
                [btnAdd setFrame:CGRectMake(btnAdd.frame.origin.x, tblDiagnosis.frame.origin.y+tblDiagnosis.frame.size.height+5, btnAdd.frame.size.width, btnAdd.frame.size.height)];
                [btnEdit setFrame:CGRectMake(btnEdit.frame.origin.x, tblDiagnosis.frame.origin.y+tblDiagnosis.frame.size.height+5, btnEdit.frame.size.width, btnEdit.frame.size.height)];
                [Scroll setContentSize:CGSizeMake(Scroll.frame.size.width, btnEdit.frame.origin.y+btnEdit.frame.size.height+20)];
                
                NSDate *dateFromString = [[NSDate alloc] init];
                dateFromString = [dateFormatter dateFromString:txtDateOfBirth.text];
                [pickerDateOfBirth setDate:dateFromString];
                [SVProgressHUD dismiss];
            }
        }];
    }
    else
    {
        btnBack.hidden=YES;
        is_irregular_cycle=@"false";
    }
    [btnBack addTarget:self action:@selector(btnBackClick:) forControlEvents:UIControlEventTouchUpInside];
    
    FahrenhitCalcius = [[NSMutableArray alloc] init];
    [FahrenhitCalcius addObject:@"Fahrenheit"];
    [FahrenhitCalcius addObject:@"Celsius"];
 
    TemperatureMethod = [[NSMutableArray alloc] init];
    [TemperatureMethod addObject:@"Orally"];
    [TemperatureMethod addObject:@"Vaginally"];
    
    [SW setOnTintColor:[UIColor colorWithRed:232/255.0f green:87/255.0f blue:131/255.0f alpha:1.00f]];
    [SW setOffTintColor:[UIColor whiteColor]];
    
    pickerDateOfBirth.datePickerMode = UIDatePickerModeDate;
    pickerDateOfBirth.date = [NSDate date];
    
    pickerFirstDay.datePickerMode = UIDatePickerModeDate;
    pickerFirstDay.date = [NSDate date];
    
    self.txtDateOfBirth.inputView = self.pickerDateOfBirth;
    self.txtFirstDay.inputView = self.pickerFirstDay;
    self.txtMethodUnits.inputView = self.pcikerUnits;
    self.txtTemperatureMethods.inputView = self.pickerTemperatureMethods;
    
    [pickerDateOfBirth addTarget:self action:@selector(DOBChanged:) forControlEvents:UIControlEventValueChanged];
    [pickerFirstDay addTarget:self action:@selector(FirstDayChanged:) forControlEvents:UIControlEventValueChanged];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ToDismissPickers)];    
//    [self.Scroll addGestureRecognizer:tap];
    
    [txtDateOfBirth setInputAccessoryView:self.toolBar];
    [txtFirstDay setInputAccessoryView:self.toolBar];
    [txtUsualCycleLength setInputAccessoryView:self.toolBar];
    [txtMethodUnits setInputAccessoryView:self.toolBar];
    [txtTemperatureMethods setInputAccessoryView:self.toolBar];
    [txtPatnerID setInputAccessoryView:self.toolBar];
    [txtAdd setInputAccessoryView:self.toolBar];
    [txtEdit setInputAccessoryView:self.toolBar];
    [txtFirstName setInputAccessoryView:self.toolBar];
    [txtImage setInputAccessoryView:self.toolBar];
    [DescTextView setInputAccessoryView:self.toolBar];
    
    [self.navigationController setNavigationBarHidden:YES];
}
-(IBAction)SWChanged:(id)sender
{
    if (SW.isOn)
    {
        checked=true;
        is_irregular_cycle=@"true";
        [btnCheckBox setBackgroundImage:[UIImage imageNamed:@"toggleno.png"] forState:UIControlStateNormal];
//        UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Vaginally"
//                                                            message:@"If you are intersted in a consultation by the BabyMaker now or in the Future then we suggest you to record temperature orally."
//                                                           delegate:self
//                                                  cancelButtonTitle:@"Cancel"
//                                                  otherButtonTitles:@"OK", nil];
//        
//        [CheckAlert setDelegate:self];
//        [CheckAlert show];
    }
    else
    {
        checked=false;
        is_irregular_cycle=@"false";
        [btnCheckBox setBackgroundImage:[UIImage imageNamed:@"UnCheck.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)btnMinimize_Click:(id)sender {
    [selectedTextField resignFirstResponder];
    [DescTextView resignFirstResponder];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        if ([ForAlertView isEqualToString:@"Add"])
        {
            ForAlertView=@"zzz";
            UITextField *textField = [alertView textFieldAtIndex:0];
            [DiagnosisArr addObject:textField.text];
            [CheckArr addObject:@"False"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"DiagnosisArr"];
            [[NSUserDefaults standardUserDefaults] setObject:DiagnosisArr forKey:@"DiagnosisArr"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CheckArr"];
            [[NSUserDefaults standardUserDefaults] setObject:CheckArr forKey:@"CheckArr"];
            
            [tblDiagnosis reloadData];
            [tblEditDiagnosis reloadData];
            [tblDiagnosis setFrame:CGRectMake(tblDiagnosis.frame.origin.x, tblDiagnosis.frame.origin.y, tblDiagnosis.frame.size.width,40*[DiagnosisArr count] )];
            [btnAdd setFrame:CGRectMake(btnAdd.frame.origin.x, tblDiagnosis.frame.origin.y+tblDiagnosis.frame.size.height+5, btnAdd.frame.size.width, btnAdd.frame.size.height)];
            [btnEdit setFrame:CGRectMake(btnEdit.frame.origin.x, tblDiagnosis.frame.origin.y+tblDiagnosis.frame.size.height+5, btnEdit.frame.size.width, btnEdit.frame.size.height)];
            [Scroll setContentSize:CGSizeMake(Scroll.frame.size.width, btnEdit.frame.origin.y+btnEdit.frame.size.height+20)];
            
        }
        else if ([ForAlertView isEqualToString:@"Edit"])
        {
            ForAlertView=@"zzz";
            UITextField *textField = [alertView textFieldAtIndex:0];
            [DiagnosisArr replaceObjectAtIndex:idx withObject:textField.text];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"DiagnosisArr"];
            [[NSUserDefaults standardUserDefaults] setObject:DiagnosisArr forKey:@"DiagnosisArr"];
            [tblEditDiagnosis reloadData];
            [tblDiagnosis reloadData];
        }
        else
        {
            [btnCheckBox setBackgroundImage:[UIImage imageNamed:@"toggleno.png"] forState:UIControlStateNormal];
//            UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Vaginally"
//                                                                message:@"If you are intersted in a conclusion by the BabyMaker now or in the Future then we suggest you to record temperature orally.If you are intersted in a conclusion by the BabyMaker now or in the Future then we suggest you to record temperature orally.If you are intersted in a conclusion by the BabyMaker now or in the Future then we suggest you to record temperature orally.If you are intersted in a conclusion by the BabyMaker now or in the Future then we suggest you to record temperature orally.If you are intersted in a conclusion by the BabyMaker now or in the Future then we suggest you to record temperature orally."
//                                                               delegate:self
//                                                      cancelButtonTitle:@"OK"
//                                                      otherButtonTitles:nil, nil];
//            [CheckAlert setDelegate:self];
//            [CheckAlert show];
            txtTemperatureMethods.text=[TemperatureMethod objectAtIndex:0];
            [txtTemperatureMethods resignFirstResponder];
        }
    }
//    [alertView release];
}
- (void)ToDismissPickers
{
    [txtFirstName resignFirstResponder];
    [txtDateOfBirth resignFirstResponder];
    [txtImage resignFirstResponder];
    [txtFirstDay resignFirstResponder];
    [txtUsualCycleLength resignFirstResponder];
    [txtPatnerID resignFirstResponder];
    [txtMethodUnits resignFirstResponder];
    [txtTemperatureMethods resignFirstResponder];
}
- (void)DOBChanged:(id)sender
{
    txtDateOfBirth.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:pickerDateOfBirth.date]];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==txtDateOfBirth || textField==txtFirstDay || textField==txtMethodUnits || textField==txtTemperatureMethods)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}
- (void)FirstDayChanged:(id)sender
{
    txtFirstDay.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:pickerFirstDay.date]];
}

-(IBAction)btnDateTimeClick:(id)sender;
{
    [pickerDateOfBirth setHidden:NO];
}

-(IBAction)btnAddPhoto:(id)sender
{
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.allowsEditing = NO;
    imgPicker.delegate = self;
    [self presentViewController:imgPicker animated:YES completion:nil];
}


#pragma mark
#pragma mark - Button Click Methods...
-(IBAction)btnAddClick:(id)sender;
{
    UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Add New" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    [CheckAlert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [CheckAlert setDelegate:self];
    [CheckAlert show];
    ForAlertView=@"Add";
}
-(IBAction)btnEditClick:(id)sender
{
    AddEditPopUp.hidden=NO;
    tempImage.hidden=NO;
    [Scroll setScrollEnabled:NO];
    [btnSaveSettings setEnabled:NO];
    [btnAdd setEnabled:NO];
    [btnEdit setEnabled:NO];
    AddEditPopUp.layer.cornerRadius=1;
//    AddEditPopUp.layer.borderColor=[[UIColor darkGrayColor]CGColor];
//    AddEditPopUp.layer.borderWidth=2;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:AddEditPopUp cache:YES];
    [UIView commitAnimations];
}
-(IBAction)btnCancelClick:(id)sender
{
    AddEditPopUp.hidden=YES;
    tempImage.hidden=YES;
    [Scroll setScrollEnabled:YES];
    [btnSaveSettings setEnabled:YES];
    [btnAdd setEnabled:YES];
    [btnEdit setEnabled:YES];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:AddEditPopUp cache:YES];
    [UIView commitAnimations];
}

-(IBAction)btnBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)btnCheckBoxClick:(id)sender
{
    if (checked)
    {
        checked=false;
        is_irregular_cycle=@"true";
        [btnCheckBox setBackgroundImage:[UIImage imageNamed:@"toggleno.png"] forState:UIControlStateNormal];
        UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Vaginally"
                                                          message:@"If you are intersted in a consultation by the BabyMaker now or in the Future then we suggest you to record temperature orally."
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"OK", nil];
        
        [CheckAlert setDelegate:self];
        [CheckAlert show];
    }
    else
    {
        checked=true;
        is_irregular_cycle=@"false";
        [btnCheckBox setBackgroundImage:[UIImage imageNamed:@"UnCheck.png"] forState:UIControlStateNormal];
    }
}
-(IBAction)btnSaveSettingsClick:(id)sender
{
    NSString *textFirstName = [txtFirstName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textDateOfBirth = [txtDateOfBirth.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textImage = [txtImage.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textFirstDay  = [txtFirstDay.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textUsualCycleLength = [txtUsualCycleLength.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textMethodUnits  = [txtMethodUnits.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textTemperatureMethods = [txtTemperatureMethods.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textPatnerID  = [txtPatnerID.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (textFirstName.length==0 || textDateOfBirth.length==0 || textImage.length==0 || textFirstDay.length==0 || textUsualCycleLength.length==0 || textMethodUnits.length==0 || textTemperatureMethods.length==0 || textPatnerID.length==0)
    {
        UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Some Fields are Empty"
                                                            message:@"..."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];

//        UIAlertView *CheckAlert = [[UIAlertView alloc]init];
        [CheckAlert setDelegate:self];
        [CheckAlert setTitle:@"Warning"];
        if(!userImage)
        {
            [CheckAlert setMessage:@"Please Add Photo"];
        }
        
        if (textFirstName.length==0)
        {
            [CheckAlert setMessage:@"Please Enter First Name"];
        }
        else if (textDateOfBirth.length==0)
        {
            [CheckAlert setMessage:@"Please Select Date of Birth"];
        }
        else if (textImage.length==0)
        {
            [CheckAlert setMessage:@"Please Select User Image"];
        }
        else if (textFirstDay.length==0)
        {
            [CheckAlert setMessage:@"Please Select First Day of Last Period"];
        }
        else if (textUsualCycleLength.length==0)
        {
            [CheckAlert setMessage:@"Please Enter Usual Cycle in Days"];
        }
        else if (textMethodUnits.length==0)
        {
            [CheckAlert setMessage:@"Please Select Temperature Units"];
        }
        else if (textTemperatureMethods.length==0)
        {
            [CheckAlert setMessage:@"Please Select Temperature Method"];
        }
        else if (textPatnerID.length==0)
        {
            [CheckAlert setMessage:@"Please Enter Partner Email"];
        }
        else
        {
            [CheckAlert setMessage:@"Some Fields are Blank"];
        }
        [CheckAlert show];
    }
    else
    {
        BOOL isValid = [self NSStringIsValidEmail:txtPatnerID.text];
        if (isValid)
        {
            [self saveSettings];
        }
        else
        {
            UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Invalid Patner Email Id"
                                                                message:@"Please enter proper Email ID."
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
            
            [CheckAlert show];
        }
    }
}
-(BOOL)NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
-(void)saveSettings
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CheckArr"];
    [[NSUserDefaults standardUserDefaults] setObject:CheckArr forKey:@"CheckArr"];
    
    NSString *textFirstName = [txtFirstName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textDateOfBirth = [txtDateOfBirth.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textImage = [txtImage.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textFirstDay  = [txtFirstDay.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textUsualCycleLength = [txtUsualCycleLength.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textMethodUnits  = [txtMethodUnits.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textTemperatureMethods = [txtTemperatureMethods.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textPatnerID  = [txtPatnerID.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *StringFromArray2 = [CheckArr componentsJoinedByString:@","];
    NSString *StringFromDiagnosisArr = [DiagnosisArr componentsJoinedByString:@","];
//    NSLog(@"objectId = %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"]);
    PFQuery *query = [PFQuery queryWithClassName:@"UserMst"];
    [query getObjectInBackgroundWithId:[[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"] block:^(PFObject *testObject, NSError *error) {
        
        [testObject setObject:textFirstName forKey:@"user_firstname"];
        [testObject setObject:textDateOfBirth forKey:@"user_dob"];
        [testObject setObject:textImage forKey:@"user_image"];
        
        [self ImageFileName];
        NSData *imageData = UIImagePNGRepresentation(userImage.image);
        PFFile *imageFile = [PFFile fileWithName:fileName data:imageData];
        testObject[@"imageFile"] = imageFile;
        
        [testObject setObject:textPatnerID forKey:@"user_patner_email"];
        [testObject setObject:textFirstDay forKey:@"user_first_day"];
        [testObject setObject:textUsualCycleLength forKey:@"user_usual_cycle"];
        [testObject setObject:is_irregular_cycle forKey:@"user_is_irregular_cycle"];
        [testObject setObject:textMethodUnits forKey:@"user_temperature_units"];
        [testObject setObject:textTemperatureMethods forKey:@"user_temperature_methods"];
        [testObject setObject:StringFromArray2 forKey:@"user_diagnosis"];
        [testObject setObject:StringFromDiagnosisArr forKey:@"user_diagnosis_arr"];
        app.objID = testObject.objectId;
//        NSLog(@"FL = %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"FL"]);
//        NSLog(@"objectId = %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"]);
        [testObject save];
        
        
       
        NSString *DateString = [testObject objectForKey:@"user_dob"];
        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"dd-MM-yyyy"];
        NSDate *birthday = [dateFormatter2 dateFromString:DateString];
        NSDate *now = [NSDate date];
        NSDateComponents* ageComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:birthday toDate:now options:0];
        NSInteger age = [ageComponents year];
        app.Age=[NSString stringWithFormat:@"%d",age];
        
        
        [[NSUserDefaults standardUserDefaults] setValue:textFirstName  forKey:@"UserName"];
        [[NSUserDefaults standardUserDefaults] setValue:app.Age forKey:@"UserAge"];
        
        [[NSUserDefaults standardUserDefaults] setValue:UIImagePNGRepresentation(userImage.image) forKey:@"UserImage"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        [SVProgressHUD dismiss];
         MainMenuViewController *obj=[[MainMenuViewController alloc]init];
//        OvulationTrackerCalViewController *obj=[[OvulationTrackerCalViewController alloc]init];
        [self.navigationController pushViewController:obj animated:YES];
//        [obj release];
        
    }];
}



#pragma mark
#pragma mark - TextField Delegate Methods...
//- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
//{
//    [theTextField resignFirstResponder];
//    return YES;
//}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    selectedTextField=textField;
    if (textField == txtDateOfBirth)
    {
        pickerDateOfBirth.hidden = NO;
        [btnDateTime setHidden:YES];
        [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionTransitionCurlUp animations:^{
            CGRect rc = [textField bounds];
            rc = [textField convertRect:rc toView:Scroll];
            rc.origin.x = 0 ;
            rc.origin.y = 50 ;
            CGPoint pt=rc.origin;
            [self.Scroll setContentOffset:pt animated:YES];
        }completion:nil];
    }
    else if (textField == txtFirstDay)
    {
        pickerFirstDay.hidden = NO;
        [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionTransitionCurlUp animations:^{
            CGRect rc = [textField bounds];
            rc = [textField convertRect:rc toView:Scroll];
            rc.origin.x = 0 ;
            rc.origin.y = 150 ;
            CGPoint pt=rc.origin;
            [self.Scroll setContentOffset:pt animated:YES];
        }completion:nil];
    }
    else if (textField == txtMethodUnits)
    {
        pcikerUnits.hidden = NO;
        [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionTransitionCurlUp animations:^{
            CGRect rc = [textField bounds];
            rc = [textField convertRect:rc toView:Scroll];
            rc.origin.x = 0 ;
            rc.origin.y = 250 ;
            CGPoint pt=rc.origin;
            [self.Scroll setContentOffset:pt animated:YES];
        }completion:nil];
    }
    else if (textField == txtTemperatureMethods)
    {
        pickerTemperatureMethods.hidden = NO;
        [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionTransitionCurlUp animations:^{
            CGRect rc = [textField bounds];
            rc = [textField convertRect:rc toView:Scroll];
            rc.origin.x = 0 ;
            rc.origin.y = 300 ;
            CGPoint pt=rc.origin;
            [self.Scroll setContentOffset:pt animated:YES];
        }completion:nil];
    }
    else if (textField == txtUsualCycleLength)
    {
        [textField setKeyboardType:UIKeyboardTypeNumberPad];
        [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionTransitionCurlUp animations:^{
            CGRect rc = [textField bounds];
            rc = [textField convertRect:rc toView:Scroll];
            rc.origin.x = 0 ;
            rc.origin.y = 200 ;
            CGPoint pt=rc.origin;
            [self.Scroll setContentOffset:pt animated:YES];
        }completion:nil];
    }
    else if (textField == txtPatnerID)
    {
        [textField setKeyboardType:UIKeyboardTypeEmailAddress];
        [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionTransitionCurlUp animations:^{
            CGRect rc = [textField bounds];
            rc = [textField convertRect:rc toView:Scroll];
            rc.origin.x = 0 ;
            rc.origin.y = 350 ;
            CGPoint pt=rc.origin;
            [self.Scroll setContentOffset:pt animated:YES];
        }completion:nil];
    }
    else if (textField == txtFirstName)
    {
        [textField setKeyboardType:UIKeyboardTypeDefault];
    }
    else if (textField == txtImage)
    {
        [textField resignFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
        UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Edit Existing Field" message:@"\n\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Edit", nil];
        txtEdit = [[UITextField alloc] initWithFrame:CGRectMake(17, 50, 250, 30)];
        [txtEdit setBackgroundColor:[UIColor whiteColor]];
        [txtEdit setDelegate:self];
        [CheckAlert addSubview:txtEdit];
        [CheckAlert bringSubviewToFront:txtEdit];
        [CheckAlert setDelegate:self];
        [CheckAlert show];
        ForAlertView=@"Edit";
    }
}


#pragma mark
#pragma mark - ImagePicker Methods...
-(void)uploadPhoto
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSData *imageData = UIImagePNGRepresentation(userImage.image);
    [imageData writeToFile:savedImagePath atomically:NO];
    txtImage.text=fileName;
//    NSLog(@"savedImagePath = %@",savedImagePath);
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo: (NSDictionary *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    userImage.image = image;
//    NSData *imageData = UIImagePNGRepresentation(image);
    [self ImageFileName];
    
//    PFQuery *query = [PFQuery queryWithClassName:@"UserMst"];
//    [query getObjectInBackgroundWithId:[[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"] block:^(PFObject *testObject, NSError *error) {
//        
//        PFFile *imageFile = [PFFile fileWithName:fileName data:imageData];
//        testObject[@"imageFile"] = imageFile;
//        [testObject saveInBackground];
//    }];
    txtImage.text=fileName;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
//    [picker release];
}
//-(void) uploadImage: (NSData *) imageData
//{
//    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
//    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (!error) {
//            PFObject *userPhoto = [PFObject objectWithClassName:@"temp_class"];
//            [userPhoto setObject:imageFile forKey:@"imageFile"];
//        }
//    }];
//}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)ImageFileName
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"ddMMMYY_hhmmssa";
    fileName=[[NSMutableString alloc]initWithString:[[formatter stringFromDate:[NSDate date]] stringByAppendingString:@".png"]];
}


#pragma mark
#pragma mark - PickerView Methods...
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == pcikerUnits)
    {
        return [FahrenhitCalcius count];
    }
    else
    {
        return [TemperatureMethod count];
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == pcikerUnits)
    {
        return [FahrenhitCalcius objectAtIndex:row];
    }
    else
    {
        return [TemperatureMethod objectAtIndex:row];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == pcikerUnits)
    {
        txtMethodUnits.text = [FahrenhitCalcius objectAtIndex:row];
        [txtMethodUnits resignFirstResponder];
    }
    else
    {
        if (row==1)
        {
            txtTemperatureMethods.text = [TemperatureMethod objectAtIndex:row];
            UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Warning"
                                                                message:@"If you are intersted in a consultation by the BabyMaker now or in the Future then we suggest you to record temperature orally, Do you want to record it Orally?"
                                                               delegate:self
                                                      cancelButtonTitle:@"NO"
                                                      otherButtonTitles:@"YES", nil];
            [CheckAlert setDelegate:self];
            [CheckAlert show];
        }
        else
        {
            txtTemperatureMethods.text = [TemperatureMethod objectAtIndex:row];
            [txtTemperatureMethods resignFirstResponder];
        }
    }
}



#pragma mark
#pragma mark - Table Delegate Methods...
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [DiagnosisArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tblDiagnosis)
    {
        static NSString *CellIdentifier = @"Cell";
        CheckboxCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CheckboxCell" owner:self options:nil];
            cell = [topLevelObjects objectAtIndex:0];
        }
        [cell.RowButton setHidden:YES];
        cell.lblDesc.text=[DiagnosisArr objectAtIndex:indexPath.row];
        [cell.SW setTag:indexPath.row];
        [cell.SW setOnTintColor:[UIColor colorWithRed:232/255.0f green:87/255.0f blue:131/255.0f alpha:1.00f]];
        [cell.SW setOffTintColor:[UIColor whiteColor]];
        cell.SW.transform = CGAffineTransformMakeScale(0.80, 0.80);
        
        if ([[CheckArr objectAtIndex:indexPath.row] isEqualToString:@"True"])
        {
            [cell.SW setOn:YES animated:YES];
        }
        else
        {
            [cell.SW setOn:NO animated:YES];
        }
        
        [cell.SW addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventValueChanged];
        
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"Cell";
        CheckboxCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CheckboxCell" owner:self options:nil];
            cell = [topLevelObjects objectAtIndex:0];
        }
        [cell.lblDesc setHidden:YES];
        [cell.SW setHidden:YES];
        [cell.RowButton setHidden:NO];
        [cell.RowButton setTag:[indexPath row]];
        [cell.RowButton setTitle:[DiagnosisArr objectAtIndex:[indexPath row]] forState:UIControlStateNormal];
        [cell.RowButton addTarget:self action:@selector(RowtoEdit:) forControlEvents:UIControlEventTouchUpInside];
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
    }
}
-(void)checkboxClicked: (id)sender
{
    UISwitch *SWSelected=(UISwitch*) sender;
    if (SWSelected.isOn)
    {
        [CheckArr replaceObjectAtIndex:SWSelected.tag withObject:@"True"];
    }
    else
    {
        [CheckArr replaceObjectAtIndex:SWSelected.tag withObject:@"False"];
    }
    
}

-(void)RowtoEdit: (id)sender
{
    idx = [sender tag];
//    NSLog(@"IDX = %d",idx);
    UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Edit" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Edit", nil];
    [CheckAlert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *textField = [CheckAlert textFieldAtIndex:0];
    textField.text=[DiagnosisArr objectAtIndex:[sender tag]];
    [CheckAlert setDelegate:self];
    [CheckAlert show];
    ForAlertView=@"Edit";
}




-(void) dealloc
{
//    [super dealloc];
//    [pickerDateOfBirth release];
//    [pickerFirstDay release];
//    [pcikerUnits release];
//    [pickerTemperatureMethods release];
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

@end
