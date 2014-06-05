//
//  MealDiaryDetailsViewController.h
//  BabyMaker
//
//  Created by ajeet Singh on 15/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MealDiaryDetailsViewController : UIViewController < UIScrollViewDelegate, UITextViewDelegate >
{
    UIScrollView *Scroll;
    UILabel *lblDate,*lbltitle,*lblTime;
    UITextView *CommentTexView;
    UIButton *btnBack, *btnInfo;
    NSDateFormatter *dateFormatter,*DateToDisplayFormatter;
}
@property (nonatomic,retain) IBOutlet UIScrollView *Scroll;
@property (nonatomic,retain) IBOutlet UIButton *btnBack, *btnInfo;
@property (nonatomic,retain) IBOutlet UILabel *lblDate,*lbltitle,*lblTime;
@property (nonatomic,retain) IBOutlet UITextView *CommentTexView;
@property (nonatomic,retain) NSString *myDateString,*mytitle,*myComment,*myObjID,*isToEdit;
@property (weak, nonatomic) IBOutlet UIButton *btnDone;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;

-(IBAction)btnDoneClick:(id)sender;
-(IBAction)btnCancelClick:(id)sender;
- (IBAction)btnMinimize_Click:(id)sender;
@end
