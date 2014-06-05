//
//  ViewController.h
//  BabyMaker
//
//  Created by ajeet Singh on 12/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MBSwitch.h"

@interface ViewController : UIViewController <UIScrollViewDelegate,UITextFieldDelegate>
{
    UIButton *checkbox, *btnAccept, *btnCancel, *btnRegister, *btnCancel2, *btnMenu;
    UITextView *ConditionTextView;
    UIScrollView *ScrollView;
    UIView *popupView;
    UITextField *txtemail,*txtpass;
//    UISwitch *SW;
}
@property (nonatomic,retain) IBOutlet UIButton *checkbox, *btnAccept, *btnCancel, *btnCancel2, *btnMenu;
@property (nonatomic,retain) IBOutlet UITextView *ConditionTextView;
@property (nonatomic,retain) IBOutlet UIScrollView *ScrollView;
@property (nonatomic,retain) IBOutlet UIView *popupView;
@property (nonatomic,retain) IBOutlet UITextField *txtemail,*txtpass;
@property (nonatomic,retain) IBOutlet MBSwitch *SW;
@property (retain, nonatomic) IBOutlet UIImageView *imgBackView;
@property (nonatomic,retain) IBOutlet UIButton *btnRegister;
@property(assign) CGPoint oriCenter;
@property(assign) float f;

-(IBAction)checkboxClick:(id)sender;
-(IBAction)btnAcceptClick:(id)sender;
-(IBAction)btnCancelClick:(id)sender;
-(IBAction)btnRegisterClick:(id)sender;
-(IBAction)btnCancel2Click:(id)sender;
-(IBAction)SWChanged:(id)sender;
@end
