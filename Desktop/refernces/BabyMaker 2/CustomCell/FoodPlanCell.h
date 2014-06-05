//
//  FoodPlanCell.h
//  BabyMaker
//
//  Created by ajeet Singh on 14/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodPlanCell : UITableViewCell
{
    UILabel *lblMeal,*lblFood;
}
@property (nonatomic,retain) IBOutlet UILabel *lblMeal,*lblFood;
@end
