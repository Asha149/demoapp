//
//  ShareViewController.m
//  BabyMaker
//
//  Created by ajeet Singh on 14/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "ShareViewController.h"
#import "MainMenuViewController.h"
#import "PPRevealSideViewController.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import <MessageUI/MessageUI.h>

@interface ShareViewController ()

@end

@implementation ShareViewController
@synthesize btnMenu,btnSave,btnCancel,picker1,picker2,txtData,txtTo,DataImage,DataTextView;
NSMutableArray *ABC;
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
    [btnMenu addTarget:self action:@selector(btnMenuClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:self.btnSave];
    [self.view bringSubviewToFront:self.btnCancel];
    [self.shareScroll setContentSize:CGSizeMake(320, btnSave.frame.origin.y+btnSave.frame.size.height+100)];
    
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
    
    ABC = [[NSMutableArray alloc] init];
    [ABC addObject:@"Temperature Chart"];
    [ABC addObject:@"Meal Diary Tracker"];
    [ABC addObject:@"Exercise Log"];
    [ABC addObject:@"Menstrual Cycle"];
    [ABC addObject:@"Stress Management"];
    [ABC addObject:@"All"];
    
    self.txtData.inputView = self.picker1;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)])
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            CGFloat scale = [UIScreen mainScreen].scale;
            result = CGSizeMake(result.width * scale, result.height * scale);
            
            if(result.height == 960)
            {
                NSLog(@"iPhone 4 Resolution");
                
            }
            if(result.height == 1136)
            {
                NSLog(@"iPhone 5 Resolution");
                [DataImage setFrame:CGRectMake(DataImage.frame.origin.x, DataImage.frame.origin.y, DataImage.frame.size.width, DataImage.frame.size.height+80)];
                [btnSave setFrame:CGRectMake(btnSave.frame.origin.x, btnSave.frame.origin.y+80, btnSave.frame.size.width, btnSave.frame.size.height)];
                [btnCancel setFrame:CGRectMake(btnCancel.frame.origin.x, btnCancel.frame.origin.y+80, btnCancel.frame.size.width, btnCancel.frame.size.height)];
            }
        }
        else{
            NSLog(@"Standard Resolution");
        }
    }

//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ToDismissPickers)];
//    [self.view addGestureRecognizer:tap];
    
    [txtData setInputAccessoryView:self.tooBar];
    [txtTo setInputAccessoryView:self.tooBar];
    [DataTextView setInputAccessoryView:self.tooBar];
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
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
                    
                    [SVProgressHUD dismiss];
                }];

                
            }];
            
        }];
        
    }];
    
}

- (void)ToDismissPickers
{
    [txtData resignFirstResponder];
    [txtTo resignFirstResponder];
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


#pragma mark
#pragma mark - Button Click Methods...
-(IBAction)btnSaveClick:(id)sender
{
    NSLog(@"btnSaveClick");
    NSString *textData = [txtData.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *textTo = [txtTo.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (textData.length == 0 || textTo.length == 0)
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
                NSString *emailTitle = [NSString stringWithFormat:@"%@ from BabyMaker app",textData];
                NSString *messageBody = [NSString stringWithFormat:@"%@",DataTextView.text];
                NSArray *toRecipents = [NSArray arrayWithObject:textTo];
                MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
                mc.mailComposeDelegate = self;
                [mc setSubject:emailTitle];
                [mc setMessageBody:messageBody isHTML:NO];
                [mc setToRecipients:toRecipents];
                if ([From isEqualToString:@"Ovulation"])
                {
                    UIImage *pic = DataImage.image;
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
    txtTo.text=@"";
    DataTextView.text=@"";
    [DataImage setImage:nil];
}

- (IBAction)btnMinimize_Click:(id)sender {
    [txtData resignFirstResponder];
    [txtTo resignFirstResponder];
    [DataTextView resignFirstResponder];
}

-(IBAction)btnMenuClick:(id)sender
{
    [self ToDismissPickers];
    MainMenuViewController *obj = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:[NSBundle mainBundle]];
    [self.revealSideViewController pushViewController:obj onDirection:PPRevealSideDirectionLeft withOffset:50 animated:YES];
//    [obj release];
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
    return [ABC count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [ABC objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component
{
    txtData.text = [ABC objectAtIndex:row];
    if (row==0)
    {
        NSLog(@"Ovulation Tracker...");
        From=@"Ovulation";
        [DataTextView setHidden:YES];
        [DataImage setHidden:NO];
        DataTextView.text=@"";
        DataImage.image=app.OvulationImage;
        [self.view bringSubviewToFront:DataImage];
        
    }
    else if (row==1)
    {
        NSLog(@"Meal Diary Tracker...");
        From=@"---";
        [DataTextView setHidden:NO];
        [DataImage setHidden:YES];
        DataTextView.text=@"";
        DataTextView.text = MealDiaryTracker;
    }
    else if (row==2)
    {
        NSLog(@"Exercise Log...");
        From=@"---";
        [DataTextView setHidden:NO];
        [DataImage setHidden:YES];
        DataTextView.text=@"";
        DataTextView.text = ExerciseLog;
    }
    else if (row==3)
    {
        
        NSLog(@"Menstural Cycle...");
        From=@"---";
        [DataTextView setHidden:NO];
        [DataImage setHidden:YES];
        DataTextView.text=@"";
        DataTextView.text = MensturalInfo;
    }
    else if (row==4)
    {
        NSLog(@"Stress Management...");
        From=@"---";
        [DataTextView setHidden:NO];
        [DataImage setHidden:YES];
        DataTextView.text=@"";
        DataTextView.text = StressManagement;
    }
    else if (row==5)
    {
        DataTextView.text=[NSString stringWithFormat:@"\nMEAL INFORMATION \n%@ \n\nEXERCISE INFORMATION \n%@ \n\nMENSTRUAL INFORMTATION \n%@ \n\nSTRESS MANAGEMENT \n%@",MealDiaryTracker, ExerciseLog, MensturalInfo ,StressManagement];
    }
}


#pragma mark
#pragma mark - TextField Delegate Methods...
//-(BOOL)textFieldShouldReturn:(UITextField *)theTextField
//{
//    [theTextField resignFirstResponder];
//    return YES;
//}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == txtData)
    {
        picker1.hidden = NO;
    }
}
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
void CreatePDFFile (CGRect pageRect, const char *filename)
{
    // This code block sets up our PDF Context so that we can draw to it
    CGContextRef pdfContext;
    CFStringRef path;
    CFURLRef url;
    CFMutableDictionaryRef myDictionary = NULL;
    
    // Create a CFString from the filename we provide to this method when we call it
    path = CFStringCreateWithCString (NULL, filename,
                                      kCFStringEncodingUTF8);
    
    // Create a CFURL using the CFString we just defined
    url = CFURLCreateWithFileSystemPath (NULL, path,
                                         kCFURLPOSIXPathStyle, 0);
    CFRelease (path);
    // This dictionary contains extra options mostly for 'signing' the PDF
    myDictionary = CFDictionaryCreateMutable(NULL, 0,
                                             &kCFTypeDictionaryKeyCallBacks,
                                             &kCFTypeDictionaryValueCallBacks);
    
    CFDictionarySetValue(myDictionary, kCGPDFContextTitle, CFSTR("My PDF File"));
    CFDictionarySetValue(myDictionary, kCGPDFContextCreator, CFSTR("My Name"));
    // Create our PDF Context with the CFURL, the CGRect we provide, and the above defined dictionary
    pdfContext = CGPDFContextCreateWithURL (url, &pageRect, myDictionary);
    // Cleanup our mess
    CFRelease(myDictionary);
    CFRelease(url);
    // Done creating our PDF Context, now it's time to draw to it
    
    // Starts our first page
    CGContextBeginPage (pdfContext, &pageRect);
    
    // Draws a black rectangle around the page inset by 50 on all sides
    CGContextStrokeRect(pdfContext, CGRectMake(50, 50, pageRect.size.width - 100, pageRect.size.height - 100));
    
    // This code block will create an image that we then draw to the page
    const char *picture = "Picture";
    CGImageRef image;
    CGDataProviderRef provider;
    CFStringRef picturePath;
    CFURLRef pictureURL;
    
    picturePath = CFStringCreateWithCString (NULL, picture,
                                             kCFStringEncodingUTF8);
    pictureURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), picturePath, CFSTR("png"), NULL);
    CFRelease(picturePath);
    provider = CGDataProviderCreateWithURL (pictureURL);
    CFRelease (pictureURL);
    image = CGImageCreateWithPNGDataProvider (provider, NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease (provider);
    CGContextDrawImage (pdfContext, CGRectMake(200, 200, 207, 385),image);
    CGImageRelease (image);
    // End image code
    
    // Adding some text on top of the image we just added
    CGContextSelectFont (pdfContext, "Helvetica", 16, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode (pdfContext, kCGTextFill);
    CGContextSetRGBFillColor (pdfContext, 0, 0, 0, 1);
    const char *text = "Hello World!";
    CGContextShowTextAtPoint (pdfContext, 260, 390, text, strlen(text));
    // End text
    
    // We are done drawing to this page, let's end it
    // We could add as many pages as we wanted using CGContextBeginPage/CGContextEndPage
    CGContextEndPage (pdfContext);
    
    // We are done with our context now, so we release it
    CGContextRelease (pdfContext);
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
-(void)dealloc
{
//    [_shareScroll release];
//    [super dealloc];
//    [picker1 release];
//    [picker2 release];
}

@end
