//
//  EducationCell.h
//  BabyMaker
//
//  Created by ajeet Singh on 11/10/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EducationCell : UITableViewCell
{
    UILabel *lblDescription;
}
@property (retain, nonatomic) IBOutlet UIImageView *imgPlay;
@property (nonatomic,retain) IBOutlet UILabel *lblDescription;
@end
