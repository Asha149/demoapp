//
//  StoreTableCell.m
//  BabyMaker
//
//  Created by ajeet Singh on 23/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "StoreTableCell.h"

@implementation StoreTableCell
@synthesize lblShortDesc,lblDetails,lblCost,Img;

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
}

@end
