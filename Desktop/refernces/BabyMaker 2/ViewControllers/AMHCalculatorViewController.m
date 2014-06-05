//
//  AMHCalculatorViewController.m
//  BabyMaker
//
//  Created by ajeet Singh on 14/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "AMHCalculatorViewController.h"
#import "MainMenuViewController.h"
#import "PPRevealSideViewController.h"

@interface AMHCalculatorViewController ()

@end

@implementation AMHCalculatorViewController
@synthesize btnMenu,btnArticle,btnAudio,btnVideo,btnCalculate,btnRadioPMOL,btnRadioNGML,SW;
@synthesize ResultTextView,txtAge,txtFrame,Scroll;
@synthesize ArticleView,AudioView,VideoView;
bool checked=true;

#pragma mark
#pragma mark - View-lifeCycle Methods...
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [btnMenu addTarget:self action:@selector(btnMenuClick:) forControlEvents:UIControlEventTouchUpInside];
    [Scroll setContentSize:CGSizeMake(320, accordion.frame.origin.y+accordion.frame.size.height+10)];
    [txtAge setKeyboardType:UIKeyboardTypeNumberPad];
    [txtFrame setKeyboardType:UIKeyboardTypeNumberPad];
    SW.transform = CGAffineTransformMakeScale(0.80, 0.80);
    [SW setOn:NO animated:YES];
    
//    [btnArticle setBackgroundImage:[UIImage imageNamed:@"btn_accordian2.png"] forState:UIControlStateNormal];
//    [btnAudio setBackgroundImage:[UIImage imageNamed:@"btn_accordian2.png"] forState:UIControlStateNormal];
//    [btnVideo setBackgroundImage:[UIImage imageNamed:@"btn_accordian2.png"] forState:UIControlStateNormal];
    
    [btnCalculate setBackgroundImage:[UIImage imageNamed:@"btn_black.png"] forState:UIControlStateSelected];
    
    [btnArticle setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btnAudio setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btnVideo setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    accordion = [[AccordionView alloc] initWithFrame:CGRectMake(10, 0, 280, _accordianView.frame.size.height)];
    [_accordianView addSubview:accordion];
    [accordion addHeader:btnArticle withView:ArticleView];
    [accordion addHeader:btnAudio withView:AudioView];
    [accordion addHeader:btnVideo withView:VideoView];
    [accordion setAllowsMultipleSelection:YES];
    [accordion setNeedsLayout];
    
   [SW setOnTintColor:[UIColor colorWithRed:0/255.0f green:206/255.0f blue:155/255.0f alpha:1.00f]];
    [SW setOffTintColor:[UIColor whiteColor]];
    
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
                [ResultTextView setFrame:CGRectMake(ResultTextView.frame.origin.x, ResultTextView.frame.origin.y, ResultTextView.frame.size.width, ResultTextView.frame.size.height)];
                [accordion setFrame:CGRectMake(accordion.frame.origin.x, accordion.frame.origin.y, accordion.frame.size.width, accordion.frame.size.height)];
            }
        }
        else{
            NSLog(@"Standard Resolution");
        }
    }
    
   
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ToHideKeypad)];
    [self.view addGestureRecognizer:tap];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
    {
        [Scroll setContentSize:CGSizeMake(Scroll.frame.size.width, Scroll.frame.size.height)];
        NSLog(@"3.5..");
    }
    else
    {
        [Scroll setContentSize:CGSizeMake(Scroll.frame.size.width, Scroll.frame.size.height)];
        NSLog(@"4.0");
    }
    

}

-(void)viewWillAppear:(BOOL)animated
{
    [_accordianView setFrame:CGRectMake(_accordianView.frame.origin.x, ResultTextView.frame.origin.y+ResultTextView.frame.size.height+20, _accordianView.frame.size.width, _accordianView.frame.size.height)];
    [Scroll setContentSize:CGSizeMake(320, _accordianView.frame.origin.y+_accordianView.frame.size.height)];
}

-(IBAction)SWChanged:(id)sender
{
    if (SW.isOn)
    {
        NSLog(@"ON");
        checked=true;
    }
    else
    {
        checked=false;
        NSLog(@"OFF");
    }
}
- (void)ToHideKeypad
{
    [txtAge resignFirstResponder];
    [txtFrame resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    [theTextField resignFirstResponder];
    return YES;
}


#pragma mark
#pragma mark - Button Click Methods...
-(IBAction)btnCalculateClick:(id)sender
{
    NSLog(@"Calculate Clicked...");
    int age = [txtAge.text intValue];
    int frame = [txtFrame.text intValue];
    
    int result = age+frame;
    if (checked)
    {
        ResultTextView.text = [NSString stringWithFormat:@"The ng/ml is Checked Result is %d",result];
    }
    else
    {
        ResultTextView.text = [NSString stringWithFormat:@"The Pmo/L is Checked Result is %d",result];
    }
}

-(IBAction)btnMenuClick:(id)sender
{
//    [theTextField resignFirstResponder];
//    return YES;
    [self ToHideKeypad];
    MainMenuViewController *obj = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:[NSBundle mainBundle]];
    [self.revealSideViewController pushViewController:obj onDirection:PPRevealSideDirectionLeft withOffset:50 animated:YES];
//    [obj release];
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

- (void)dealloc {
//    [_accordianView release];
//    [super dealloc];
}
@end
