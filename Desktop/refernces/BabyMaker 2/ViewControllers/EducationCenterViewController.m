//
//  EducationCenterViewController.m
//  BabyMaker
//
//  Created by ajeet Singh on 14/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "EducationCenterViewController.h"
#import "MainMenuViewController.h"
#import "PPRevealSideViewController.h"
#import "StoreTableCell.h"
#import "EducationCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface EducationCenterViewController ()

@end

@implementation EducationCenterViewController

#pragma mark
#pragma mark - View-lifeCycle Methods...

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.tblEducation setFrame:CGRectMake(self.tblEducation.frame.origin.x, self.tblEducation.frame.origin.y, self.tblEducation.frame.size.width, 100*3)];
    [self.viewArticle setFrame:CGRectMake(self.viewArticle.frame.origin.x, self.viewArticle.frame.origin.y, self.viewArticle.frame.size.width, self.tblEducation.frame.origin.y+self.tblEducation.frame.size.height+10)];

    [self.scrollEducation setContentSize:CGSizeMake(320, self.viewArticle.frame.origin.y+self.viewArticle.frame.size.height)];
    
    [self.switchNotification setOnTintColor:[UIColor colorWithRed:159/255.0f green:65/255.0f blue:155/255.0f alpha:1.00f]];
//    [self.switchNotification setOffTintColor:[UIColor whiteColor]];
//    [self.scrollEducation setContentSize:CGSizeMake(320, 1414)];
}

-(void)viewWillDisappear:(BOOL)animated
{
  
}

#pragma mark
#pragma mark - UITableView delegate methods

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"StoreTable";
    StoreTableCell *cell = (StoreTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StoreTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.lblShortDesc.text = @"Article link";
    cell.lblDetails.text = @"Details about article";
    [cell.lblCost setHidden:YES];
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
- (void)didReceiveMemoryWarnings
{
    [super didReceiveMemoryWarning];
}

#pragma mark
#pragma mark - Button Click Methods...
- (IBAction)btnMenuClick:(id)sender {
    MainMenuViewController *obj = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:[NSBundle mainBundle]];
    [self.revealSideViewController pushViewController:obj onDirection:PPRevealSideDirectionLeft withOffset:50 animated:YES];
}

- (IBAction)btnUploadAudio_Click:(id)sender {
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    mediaPicker.delegate = self;
    mediaPicker.allowsPickingMultipleItems = NO;
    [self presentViewController:mediaPicker animated:YES completion:nil];
}

- (void)mediaPicker: (MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"You picked : %@",mediaItemCollection);
}

-(void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
