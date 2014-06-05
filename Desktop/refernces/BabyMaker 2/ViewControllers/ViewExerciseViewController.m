//
//  ViewExerciseViewController.m
//  BabyMaker
//
//  Created by ajeet Singh on 19/09/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "ViewExerciseViewController.h"
#import "SVProgressHUD.h"
#import "ViewExerciseCell.h"

@interface ViewExerciseViewController ()

@end

@implementation ViewExerciseViewController
@synthesize tblExercise,btnBack,dateString;
NSMutableArray *ExerciseArray,*DurationArray;

#pragma mark
#pragma mark - View-lifeCycle Methods...
- (void)viewDidLoad
{
    [super viewDidLoad];
    ExerciseArray = [[NSMutableArray alloc] init];
    DurationArray = [[NSMutableArray alloc] init];
    
    ///---
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyy"];
    DateToDisplayFormatter = [[NSDateFormatter alloc]init];
    [DateToDisplayFormatter setDateFormat:@"dd MMMM, yyyy"];
    
    NSDate *Dat = [DateToDisplayFormatter dateFromString:dateString];
    NSString *DateToDisplay = [dateFormatter stringFromDate:Dat];
    
    NSString *objIDFromUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectId"];
    NSLog(@"objIDFromUserDefaults = %@",objIDFromUserDefaults);
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    PFQuery *QUE = [PFQuery queryWithClassName:@"ExerciseLog"];
    [QUE whereKey:@"exercise_user_id" equalTo:objIDFromUserDefaults];
    [QUE whereKey:@"exercise_date" equalTo:DateToDisplay];
    [QUE findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if ([objects count]>0)
        {
            ExerciseArray = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"exercise_title"]];
            DurationArray = [[NSMutableArray alloc] initWithArray:[objects valueForKey:@"exercise_duration"]];
        }
        else
        {
            UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"No Data Found" message:@"There is no data on selected Date." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [Alert show];
//            [Alert release];
        }
        [tblExercise reloadData];
        [tblExercise setFrame:CGRectMake(tblExercise.frame.origin.x, tblExercise.frame.origin.y, tblExercise.frame.size.width, ExerciseArray.count*45)];
        [SVProgressHUD dismiss];
    }];
    
    [tblExercise setFrame:CGRectMake(tblExercise.frame.origin.x, tblExercise.frame.origin.y, tblExercise.frame.size.width, ExerciseArray.count*45)];
}
-(IBAction)btnbackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark
#pragma mark - TableView Methods...
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ExerciseArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ViewExerciseCell";
    ViewExerciseCell *cell = (ViewExerciseCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ViewExerciseCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    cell.lblExercise.text = [ExerciseArray objectAtIndex:[indexPath row]];
    cell.lblDuration.text = [NSString stringWithFormat:@"%@",[DurationArray objectAtIndex:[indexPath row]]];
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
