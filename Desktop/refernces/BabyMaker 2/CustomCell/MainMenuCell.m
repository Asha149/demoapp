//
//  MainMenuCell.m
//  BabyMaker
//
//  Created by ajeet Singh on 24/09/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "MainMenuCell.h"

@implementation MainMenuCell
@synthesize lblDesc,img,imgBackground;

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

- (void)dealloc {
//    [super dealloc];
}
@end
