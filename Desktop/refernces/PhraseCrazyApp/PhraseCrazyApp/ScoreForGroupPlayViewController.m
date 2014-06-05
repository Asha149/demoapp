//
//  ScoreForGroupPlayViewController.m
//  PhraseCrazyApp
//
//  Created by ajeet Singh on 21/10/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "ScoreForGroupPlayViewController.h"
#import "ViewController.h"

@interface ScoreForGroupPlayViewController ()

@end

@implementation ScoreForGroupPlayViewController
@synthesize lblMessage,lblScore1,lblScore2;
@synthesize strMessage,strScore1,strScore2;
@synthesize btnBack;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"Score :: %@",strScore1);
    NSLog(@"Score :: %@",strScore2);
    
    lblScore1.text = strScore1;
    lblScore2.text = strScore2;
    lblMessage .text = strMessage;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)btnback_click:(id)sender
{
    ViewController *vc = [[ViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
