//
//  MealInfoPageViewController.m
//  BabyMaker
//
//  Created by ajeet Singh on 12/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "MealInfoPageViewController.h"
#import "MealDiaryTrackerViewController.h"
#import "MealDiaryDetailsViewController.h"
#import "FoodPlanCell.h"
#import "MainMenuViewController.h"
#import "PPRevealSideViewController.h"

@interface MealInfoPageViewController ()

@end

@implementation MealInfoPageViewController
@synthesize lblProteins,lblCarbohydrate,lblFats,lblFoodPlan;
@synthesize ProteinsTextView,CarbohydrateTextView,FatsTextView;
@synthesize Scroll,tblFoodPlan,bar,btnBack;
NSMutableArray *MealTime;

#pragma mark
#pragma mark - View-lifeCycle Methods...
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    [btnBack addTarget:self action:@selector(btnBackClick:) forControlEvents:UIControlEventTouchUpInside];
    [Scroll setContentSize:CGSizeMake(320, Scroll.frame.size.height+150)];
    
    MealTime = [[NSMutableArray alloc] init];
    [MealTime addObject:@"BreakFast"];
    [MealTime addObject:@"Lunch"];
    [MealTime addObject:@"Snacks"];
    [MealTime addObject:@"Dinner"];
    
    [tblFoodPlan setFrame:CGRectMake(tblFoodPlan.frame.origin.x, tblFoodPlan.frame.origin.y, tblFoodPlan.frame.size.width, 40*([MealTime count]+1))];
    [Scroll setContentSize:CGSizeMake(Scroll.frame.size.width, tblFoodPlan.frame.origin.y+tblFoodPlan.frame.size.height+10)];
    
    [tblFoodPlan setDelegate:self];
    [tblFoodPlan setDataSource:self];
    [tblFoodPlan reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [tblFoodPlan setDelegate:self];
    [tblFoodPlan setDataSource:self];
    [tblFoodPlan reloadData];
}
-(IBAction)btnBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

#pragma mark
#pragma mark - Table View Methods...
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [MealTime count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"FoodPlan";
    FoodPlanCell *cell = (FoodPlanCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FoodPlanCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    if (indexPath.row==0) {
        [cell.lblMeal setText:@"Meal"];
        [cell.lblFood setText:@"Food"];
        [cell.lblMeal setFont:[UIFont systemFontOfSize:16]];
        [cell.lblFood setFont:[UIFont systemFontOfSize:16]];
        [cell.lblMeal setTextAlignment:NSTextAlignmentCenter];
        [cell.lblFood setTextAlignment:NSTextAlignmentCenter];
    }
    else{
        cell.lblMeal.text = [MealTime objectAtIndex:[indexPath row]-1];
        cell.lblFood.text = [MealTime objectAtIndex:[indexPath row]-1];
    }
    
//    if (indexPath.row%2==0) {
//        [cell.contentView setBackgroundColor:[UIColor colorWithRed:237/255.0f green:237/255.0f blue:237/255.0f alpha:1]];
//    }
//    else{
//    }
    return cell;
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
