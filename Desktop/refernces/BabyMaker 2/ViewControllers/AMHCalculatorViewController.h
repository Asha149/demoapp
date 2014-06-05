//
//  AMHCalculatorViewController.h
//  BabyMaker
//
//  Created by ajeet Singh on 14/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccordionView.h"
#import "MBSwitch.h"

@interface AMHCalculatorViewController : UIViewController < UIScrollViewDelegate,UITextFieldDelegate >
{
    AccordionView *accordion;
    UIScrollView *Scroll;
    UITextField *txtAge,*txtFrame;
    UITextView *ResultTextView;
    UIButton *btnArticle,*btnAudio,*btnVideo,*btnCalculate;
    UIView *ArticleView,*AudioView,*VideoView;
    MBSwitch *SW;
}
@property (nonatomic,retain) IBOutlet UIScrollView *Scroll;
@property (nonatomic,retain) IBOutlet UIButton *btnMenu;
@property (nonatomic,retain) IBOutlet UITextField *txtAge,*txtFrame;
@property (nonatomic,retain) IBOutlet UITextView *ResultTextView;
@property (nonatomic,retain) IBOutlet UIButton *btnArticle,*btnAudio,*btnVideo,*btnCalculate,*btnRadioPMOL,*btnRadioNGML;
@property (nonatomic,retain) IBOutlet UIView *ArticleView,*AudioView,*VideoView;
@property (retain, nonatomic) IBOutlet UIView *accordianView;

@property (nonatomic,retain) IBOutlet MBSwitch *SW;

-(IBAction)btnCalculateClick:(id)sender;
-(IBAction)SWChanged:(id)sender;
@end
