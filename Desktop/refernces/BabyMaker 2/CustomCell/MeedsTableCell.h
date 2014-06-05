//
//  MeedsTableCell.h
//  BabyMaker
//
//  Created by ajeet Singh on 22/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBSwitch.h"

@interface MeedsTableCell : UITableViewCell
{
    UIButton *RowButton;
    UILabel *lblName;
}
@property (nonatomic,retain) IBOutlet UIButton *RowButton;
@property (nonatomic,retain) IBOutlet UILabel *lblName;
@property (nonatomic,retain) IBOutlet MBSwitch *SW;

@end
