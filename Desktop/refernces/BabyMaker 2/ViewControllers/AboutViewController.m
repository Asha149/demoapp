//
//  AboutViewController.m
//  BabyMaker
//
//  Created by ajeet Singh on 14/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "AboutViewController.h"
#import "MainMenuViewController.h"
#import "PPRevealSideViewController.h"
#import "AboutCell.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
@synthesize btnMenu,Scroll,BookImage,TextViewSharkeys,TextviewContactDetails;
@synthesize lbltitle,lblAuthor,lblPublication,lblPrice,lblExtra,tblAbout;


#pragma mark
#pragma mark - View-lifeCycle Methods...
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [btnMenu addTarget:self action:@selector(btnMenuClick:) forControlEvents:UIControlEventTouchUpInside];
    TextViewSharkeys.textAlignment = NSTextAlignmentJustified;
    TextviewContactDetails.textAlignment = NSTextAlignmentJustified;
    
    [tblAbout setFrame:CGRectMake(tblAbout.frame.origin.x, tblAbout.frame.origin.y, tblAbout.frame.size.width, 80*4+35)];
    
        [self.Scroll setContentSize:CGSizeMake(320,tblAbout.frame.size.height+160)];
    
  //  [Scroll setContentSize:CGSizeMake(Scroll.frame.size.width,  tblAbout.frame.origin.y+tblAbout.frame.size.height-180)];
    
    
}
-(IBAction)btnMenuClick:(id)sender
{
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
//    [super dealloc];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"AboutCell";
    AboutCell *cell = (AboutCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AboutCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    return cell;
}

@end
