//
//  MealDiaryCell.m
//  BabyMaker
//
//  Created by ajeet Singh on 03/09/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "MealDiaryCell.h"

@implementation MealDiaryCell
@synthesize lblTimeDuration,lbldesc;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
