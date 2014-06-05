//
//  StoreTableCell.h
//  BabyMaker
//
//  Created by ajeet Singh on 23/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreTableCell : UITableViewCell
{
    UILabel *lblShortDesc,*lblDetails,*lblCost;
    UIImageView *Img;
}
@property (nonatomic,retain) IBOutlet UILabel *lblShortDesc,*lblDetails,*lblCost;;
@property (nonatomic,retain) IBOutlet UIImageView *Img;;
@end
