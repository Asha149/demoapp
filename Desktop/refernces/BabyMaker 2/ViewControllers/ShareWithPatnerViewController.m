//
//  ShareWithPatnerViewController.m
//  BabyMaker
//
//  Created by ajeet Singh on 16/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "ShareWithPatnerViewController.h"
#import "MainMenuViewController.h"
#import "PPRevealSideViewController.h"
#import "AppDelegate.h"
#import <MessageUI/MessageUI.h>

@interface ShareWithPatnerViewController ()

@end

@implementation ShareWithPatnerViewController
@synthesize btnMenu,txtData,txtTo,MessageTextView,LoadDataView,Scroll,DataPickerView,btnSend,btnCancel,DataTextView;
NSMutableArray *tempArray;
NSString *OvulationDesc,*MealDesc,*ExerciseDesc,*MensturalDesc,*StressDesc,*ExerciseDuration,*MealTitle,*MensturalTemperature,*MensturalTime,*MensturalNotes,*MensturalComment;
NSString *OvulationDate,*MealDate,*ExerciseDate,*MensturalDate,*StressDate;
NSString *StressManagement,*ExerciseLog,*MealDiaryTracker,*MensturalInfo,*From;
AppDelegate *app;

#pragma mark
#pragma mark - View-lifeCycle Methods...
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    app =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [Scroll setContentSize:CGSizeMake(320, 500)];
    [btnMenu addTarget:self action:@selector(btnMenuClick:) forControlEvents:UIControlEventTouchUpInside];
    
    OvulationDesc=@"";
    MealDesc=@"";
    ExerciseDesc=@"";
    MensturalDesc=@"";
    StressDesc=@"";
    OvulationDate=@"";
    MealDate=@"";
    ExerciseDate=@"";
    MensturalDate=@"";
    StressDate=@"";
    StressManagement=@"";
    ExerciseLog=@"";
    MealDiaryTracker=@"";
    MensturalInfo=@"";
    ExerciseDuration=@"";
    MealTitle=@"";
    MensturalTemperature=@"";
    MensturalTime=@"";
    MensturalNotes=@"";
    MensturalComment=@"";
    From=@"";
    
    tempArray = [[NSMutableArray alloc] init];
    [tempArray addObject:@"Ovulation Tracker"];
    [tempArray addObject:@"Meal Diary Tracker"];
    [tempArray addObject:@"Exercise Log"];
    [tempArray addObject:@"Menstural Cycle"];
    [tempArray addObject:@"Stress Management"];
    
    self.txtData.inputView = self.DataPickerView;
    DataPickerView.showsSelectionIndicator = YES;
    
    PFQuery *query = [PFQuery queryWithClassName:@"UserMst"];
    [query getObjectInBackgroundWithId:[[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"] block:^(PFObject *testObject, NSError *error) {
        
        txtTo.text = [testObject objectForKey:@"user_patner_email"];
        
    }];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ToDismissPickers)];
//    [self.view addGestureRecognizer:tap];
    
    [txtData setInputAccessoryView:self.toolBar];
    [txtTo setInputAccessoryView:self.toolBar];
    [MessageTextView setInputAccessoryView:self.toolBar];
    [DataTextView setInputAccessoryView:self.toolBar];
}

- (void)ToDismissPickers
{
    [txtData resignFirstResponder];
    [txtTo resignFirstResponder];
    [MessageTextView resignFirstResponder];
}
//- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
//{
//    [theTextField resignFirstResponder];
//    return YES;
//}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==txtData)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if([text isEqualToString:@"\n"])
//    {
//        [textView resignFirstResponder];
//    }
//    return YES;
//}



#pragma mark
#pragma mark - Button Click Methods...
-(IBAction)btnMenuClick:(id)sender
{
    [self ToDismissPickers];
    MainMenuViewController *obj = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:[NSBundle mainBundle]];
    [self.revealSideViewController pushViewController:obj onDirection:PPRevealSideDirectionLeft withOffset:50 animated:YES];
//    [obj release];
}
-(IBAction)btnSendClick:(id)sender
{
    NSLog(@"btnSendClick");
    NSString *textData = [txtData.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textTo = [txtTo.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *MessageText = [MessageTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (textData.length == 0 || textTo.length == 0 || MessageText.length == 0)
    {
        UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Some Fields are Empty"
                                                            message:@"Please enter some data in the Blank fields."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
        [CheckAlert show];
//        [CheckAlert release];
    }
    else
    {
        if ([self NSStringIsValidEmail:textTo])
        {
            if ([MFMailComposeViewController canSendMail])
            {
                NSString *emailTitle = textData;
                NSString *messageBody = [NSString stringWithFormat:@"%@ \n\n %@",MessageText,DataTextView.text];
                NSArray *toRecipents = [NSArray arrayWithObject:textTo];
                MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
                mc.mailComposeDelegate = self;
                [mc setSubject:emailTitle];
                [mc setMessageBody:messageBody isHTML:NO];
                [mc setToRecipients:toRecipents];
                if ([From isEqualToString:@"Ovulation"])
                {
                    UIImage *pic = LoadDataView.image;
                    NSData *exportData = UIImageJPEGRepresentation(pic ,1.0);
                    [mc addAttachmentData:exportData mimeType:@"image/jpeg" fileName:@"Picture.jpeg"];
                }                
                [self presentViewController:mc animated:YES completion:NULL];
            }
            else
            {
                UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Cant Send Mail"
                                                                    message:@"Device CanNot Send Email..."
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                [CheckAlert show];
//                [CheckAlert release];
            }
        }
        else
        {
            UIAlertView *CheckAlert = [[UIAlertView alloc]initWithTitle:@"Invalid Email Id"
                                                                message:@"Please enter proper Email ID."
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
            [CheckAlert show];
//            [CheckAlert release];
        }
    }
}
-(IBAction)btnCancelClick:(id)sender
{
    NSLog(@"btnCancelClick");
    txtData.text=@"";
//    txtTo.text=@"";
    MessageTextView.text=@"";
    DataTextView.text=@"";
    [LoadDataView setImage:nil];
}

- (IBAction)btnMinimize_Click:(id)sender {
    [txtData resignFirstResponder];
    [txtTo resignFirstResponder];
    [MessageTextView resignFirstResponder];
    [DataTextView resignFirstResponder];
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
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


#pragma mark
#pragma mark - PickerView Methods...
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [tempArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [tempArray objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component
{
    txtData.text = [tempArray objectAtIndex:row];
    if (row==0)
    {
        NSLog(@"Ovulation Tracker...");
        From=@"Ovulation";
        [DataTextView setHidden:YES];
        [LoadDataView setHidden:NO];
        DataTextView.text=@"";
        LoadDataView.image=app.OvulationImage;
    }
    else if (row==1)
    {
        NSLog(@"Meal Diary Tracker...");
        From=@"---";
        [DataTextView setHidden:NO];
        [LoadDataView setHidden:YES];
        DataTextView.text=@"";
        
        NSString *objIDFromUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"];
        NSLog(@"objIDFromUserDefaults = %@",objIDFromUserDefaults);
        
        PFQuery *QUE = [PFQuery queryWithClassName:@"MealInfo"];
        [QUE whereKey:@"meal_user_id" equalTo:objIDFromUserDefaults];
        [QUE findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            if ([objects count]>0)
            {
                MealDiaryTracker=@"";
                for (int i=0; i<[objects count]; i++)
                {
                    NSMutableArray *meal_date = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"meal_date"]];
                    MealDate = [meal_date objectAtIndex:i];
                    
                    NSMutableArray *meal_comment = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"meal_comment"]];
                    MealDesc = [meal_comment objectAtIndex:i];
                    
                    NSMutableArray *meal_title = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"meal_title"]];
                    MealTitle = [meal_title objectAtIndex:i];
                    
                    MealDiaryTracker = [MealDiaryTracker stringByAppendingString:[NSString stringWithFormat:@"\n%@ : %@ : %@ ", MealDate,MealDesc,MealTitle]];
                }
            }
            DataTextView.text = MealDiaryTracker;
        }];
    }
    else if (row==2)
    {
        NSLog(@"Exercise Log...");
        From=@"---";
        [DataTextView setHidden:NO];
        [LoadDataView setHidden:YES];
        DataTextView.text=@"";
        NSString *objIDFromUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"];
        NSLog(@"objIDFromUserDefaults = %@",objIDFromUserDefaults);
        
        PFQuery *QUE = [PFQuery queryWithClassName:@"ExerciseLog"];
        [QUE whereKey:@"exercise_user_id" equalTo:objIDFromUserDefaults];
        [QUE findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            if ([objects count]>0)
            {
                ExerciseLog=@"";
                for (int i=0; i<[objects count]; i++)
                {
                    NSMutableArray *exercise_date = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"exercise_date"]];
                    ExerciseDate = [exercise_date objectAtIndex:i];
                    
                    NSMutableArray *exercise_title = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"exercise_title"]];
                    ExerciseDesc = [exercise_title objectAtIndex:i];
                    
                    NSMutableArray *exercise_duration = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"exercise_duration"]];
                    ExerciseDuration = [exercise_duration objectAtIndex:i];
                    
                    ExerciseLog = [ExerciseLog stringByAppendingString:[NSString stringWithFormat:@"\n%@ : %@ : %@ Minutes", ExerciseDate,ExerciseDesc,ExerciseDuration]];
                }
            }
            DataTextView.text = ExerciseLog;
        }];
    }
    else if (row==3)
    {
        NSLog(@"Menstural Cycle...");
        From=@"---";
        [DataTextView setHidden:NO];
        [LoadDataView setHidden:YES];
        DataTextView.text=@"";
        
        NSString *objIDFromUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"];
        NSLog(@"objIDFromUserDefaults = %@",objIDFromUserDefaults);
        
        PFQuery *QUE = [PFQuery queryWithClassName:@"MensturalCycleInfo"];
        [QUE whereKey:@"menstural_user_id" equalTo:objIDFromUserDefaults];
        [QUE findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            if ([objects count]>0)
            {
                MensturalInfo=@"";
                for (int i=0; i<[objects count]; i++)
                {
                    NSMutableArray *menstural_date = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_date"]];
                    MensturalDate = [menstural_date objectAtIndex:i];
                    
                    NSMutableArray *menstural_temperature = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_temperature"]];
                    MensturalTemperature = [menstural_temperature objectAtIndex:i];
                    
                    NSMutableArray *menstural_time = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_time"]];
                    MensturalTime = [menstural_time objectAtIndex:i];
                    
                    NSMutableArray *menstural_notes = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_notes"]];
                    MensturalNotes = [menstural_notes objectAtIndex:i];
                    
                    NSMutableArray *menstural_comment = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"menstural_comment"]];
                    MensturalComment = [menstural_comment objectAtIndex:i];
                    
                    MensturalInfo = [MensturalInfo stringByAppendingString:[NSString stringWithFormat:@"\n%@ : %@ Degree : %@ \n%@ \n%@ ", MensturalDate,MensturalTemperature,MensturalTime,MensturalNotes,MensturalComment]];
                }
            }
            DataTextView.text = MensturalInfo;
        }];
    }
    else if (row==4)
    {
        NSLog(@"Stress Management...");
        From=@"---";
        [DataTextView setHidden:NO];
        [LoadDataView setHidden:YES];
        DataTextView.text=@"";
        NSString *objIDFromUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"];
        NSLog(@"objIDFromUserDefaults = %@",objIDFromUserDefaults);
        
        PFQuery *QUE = [PFQuery queryWithClassName:@"StressMgt"];
        [QUE whereKey:@"stress_user_id" equalTo:objIDFromUserDefaults];
        [QUE findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            if ([objects count]>0)
            {
                StressManagement=@"";
                for (int i=0; i<[objects count]; i++)
                {
                    NSMutableArray *stress_date = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"stress_date"]];
                    StressDate = [stress_date objectAtIndex:i];
                    
                    NSMutableArray *stress_description = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"stress_description"]];
                    StressDesc = [stress_description objectAtIndex:i];
                    
                    StressManagement = [StressManagement stringByAppendingString:[NSString stringWithFormat:@"\n%@ : %@", StressDate,StressDesc]];
                }
            }
            DataTextView.text = StressManagement;
        }];
    }
}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == txtData)
    {
        DataPickerView.hidden = NO;
        DataPickerView.showsSelectionIndicator = YES;
    }    
}


#pragma mark
#pragma mark - Common Methods...
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
