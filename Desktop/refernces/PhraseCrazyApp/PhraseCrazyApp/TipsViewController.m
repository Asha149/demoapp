//
//  TipsViewController.m
//  PhraseCrazyApp
//
//  Created by ajeet Singh on 16/09/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "TipsViewController.h"
#import "ViewController.h"

@interface TipsViewController ()

@end

@implementation TipsViewController
@synthesize txtTips;

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
    [txtTips setText:@"Tell players the number of words in the saying. Focus on key words. ‘Sounds like’ and ‘Opposite meaning clues’ work well. Re-say guessed words. Make up alternate meaning clues as players get more experience. Create as many clues as you wish for each saying !"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)btnBack:(id)sender
{
    ViewController *vc = [[ViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
