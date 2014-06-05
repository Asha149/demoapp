//
//  StoreViewController.m
//  BabyMaker
//
//  Created by ajeet Singh on 14/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "StoreViewController.h"
#import "MainMenuViewController.h"
#import "PPRevealSideViewController.h"
#import "StoreTableCell.h"

@interface StoreViewController ()

@end

@implementation StoreViewController
@synthesize btnMenu,tbl01,btnBooks,btnCDs;
NSString *FlagString;

#pragma mark
#pragma mark - View-lifeCycle Methods...
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    FlagString = @"Books";
    [btnMenu addTarget:self action:@selector(btnMenuClick:) forControlEvents:UIControlEventTouchUpInside];
    [Segment setSelectedSegmentIndex:0];
    if (Segment.selectedSegmentIndex==0)
    {
        [tbl01 setTag:0];
    }
    else
    {
        [tbl01 setTag:1];
    }
    
    [tbl01 reloadData];
}
-(IBAction)changeSeg
{
	if(Segment.selectedSegmentIndex == 0)
    {
        [tbl01 setTag:0];
        [tbl01 reloadData];
	}
	if(Segment.selectedSegmentIndex == 1)
    {
        [tbl01 setTag:1];
        [tbl01 reloadData];
	}
}
-(IBAction)btnMenuClick:(id)sender
{
    MainMenuViewController *obj = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:[NSBundle mainBundle]];
    [self.revealSideViewController pushViewController:obj onDirection:PPRevealSideDirectionLeft withOffset:50 animated:YES];
//    [obj release];
}
-(IBAction)btnBooksClick:(id)sender
{
    if ([FlagString isEqualToString:@"CDs"])
    {
        [btnBooks setBackgroundImage:[UIImage imageNamed:@"book_hover.png"] forState:UIControlStateNormal];
        [btnCDs setBackgroundImage:[UIImage imageNamed:@"cd_hover.png"] forState:UIControlStateNormal];
       
        FlagString=@"Books";
        [tbl01 setTag:0];
        [tbl01 reloadData];
    }
}
-(IBAction)btnCDsClick:(id)sender
{
    if ([FlagString isEqualToString:@"Books"])
    {
        [btnBooks setBackgroundImage:[UIImage imageNamed:@"books_icon.png"] forState:UIControlStateNormal];
        [btnCDs setBackgroundImage:[UIImage imageNamed:@"cds.png"] forState:UIControlStateNormal];
        FlagString=@"CDs";
        [tbl01 setTag:1];
        [tbl01 reloadData];
    }
}



#pragma mark
#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tbl01.tag == 0)
    {
        return 10;
    }
    else
    {
        return 7;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"StoreTable";
    StoreTableCell *cell = (StoreTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StoreTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    if (tbl01.tag == 0)
    {
        cell.lblShortDesc.text = @"This is Books Description";
        cell.lblDetails.text = @"Book Details";
        cell.lblCost.text = @"Cost : 1000";
    }
    else
    {
        cell.lblShortDesc.text = @"This is CD Description";
        cell.lblDetails.text = @"CD Details";
        cell.lblCost.text = @"Cost : 1000";        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
