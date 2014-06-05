//
//  MealDiaryCell.h
//  BabyMaker
//
//  Created by ajeet Singh on 03/09/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MealDiaryCell : UITableViewCell
{
    UILabel *lblTimeDuration,*lbldesc;
}
@property(nonatomic,retain) IBOutlet UILabel *lblTimeDuration,*lbldesc;
@end
