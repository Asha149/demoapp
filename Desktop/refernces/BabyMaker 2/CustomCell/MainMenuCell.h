//
//  MainMenuCell.h
//  BabyMaker
//
//  Created by ajeet Singh on 24/09/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuCell : UITableViewCell
{
    UILabel *lblDesc;
    UIImageView *img;
}
@property (nonatomic,retain) IBOutlet UILabel *lblDesc;
@property (nonatomic,retain) IBOutlet UIImageView *img;
@property (retain, nonatomic) IBOutlet UIImageView *imgBackground;
@end
