//
//  ViewExerciseCell.h
//  BabyMaker
//
//  Created by ajeet Singh on 21/10/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewExerciseCell : UITableViewCell
{
    UILabel *lblExercise,*lblDuration;
}
@property (nonatomic,retain) IBOutlet UILabel *lblExercise,*lblDuration;
@end
