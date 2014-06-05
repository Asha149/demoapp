//
//  EditTextFieldCell.h
//  BabyMaker
//
//  Created by ajeet Singh on 04/09/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditTextFieldCell : UITableViewCell < UITextFieldDelegate >
{
    UITextField *txtField;
}
@property(nonatomic,retain) IBOutlet UITextField *txtField;
@end
