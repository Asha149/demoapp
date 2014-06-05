//
//  CheckboxCell.h
//  BabyMaker
//
//  Created by ajeet Singh on 04/09/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBSwitch.h"

@interface CheckboxCell : UITableViewCell
{
    UILabel *lblDesc;
    UIButton *RowButton;
//    UISwitch *SW;
}
@property(nonatomic,retain) IBOutlet UILabel *lblDesc;
@property(nonatomic,retain) IBOutlet UIButton *RowButton;
@property (nonatomic,retain) IBOutlet MBSwitch *SW;
@end
