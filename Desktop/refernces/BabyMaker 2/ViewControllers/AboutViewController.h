//
//  AboutViewController.h
//  BabyMaker
//
//  Created by ajeet Singh on 14/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController < UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView *Scroll;
    UIImageView *BookImage;
    UITextView *TextViewSharkeys, *TextviewContactDetails;
    UILabel *lbltitle, *lblAuthor, *lblPublication, *lblPrice, *lblExtra;
}
@property (retain, nonatomic) IBOutlet UITableView *tblAbout;
@property (nonatomic,retain) IBOutlet UIScrollView *Scroll;
@property (nonatomic,retain) IBOutlet UIButton *btnMenu;
@property (nonatomic,retain) IBOutlet UIImageView *BookImage;
@property (nonatomic,retain) IBOutlet UITextView *TextViewSharkeys, *TextviewContactDetails;
@property (nonatomic,retain) IBOutlet UILabel *lbltitle, *lblAuthor, *lblPublication, *lblPrice, *lblExtra;
@end
