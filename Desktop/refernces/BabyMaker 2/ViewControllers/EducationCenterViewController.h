//
//  EducationCenterViewController.h
//  BabyMaker
//
//  Created by ajeet Singh on 14/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface EducationCenterViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,MPMediaPickerControllerDelegate>
{

}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollEducation;
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
@property (weak, nonatomic) IBOutlet UITableView *tblEducation;
@property (strong, nonatomic) IBOutlet UIView *viewArticle;
@property (weak, nonatomic) IBOutlet UISwitch *switchNotification;

- (IBAction)btnMenuClick:(id)sender;
- (IBAction)btnUploadAudio_Click:(id)sender;
@end
