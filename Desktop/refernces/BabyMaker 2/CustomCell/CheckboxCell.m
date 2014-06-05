//
//  CheckboxCell.m
//  BabyMaker
//
//  Created by ajeet Singh on 04/09/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "CheckboxCell.h"

@implementation CheckboxCell
@synthesize lblDesc,RowButton,SW;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        SW.transform = CGAffineTransformMakeScale(0.70, 0.70);

    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
       [super setSelected:selected animated:animated];
}

@end
