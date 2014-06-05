//
//  MealInfoPageViewController.h
//  BabyMaker
//
//  Created by ajeet Singh on 12/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MealInfoPageViewController : UIViewController < UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource >
{
    UILabel *lblProteins, *lblCarbohydrate, *lblFats, *lblFoodPlan;
    UITextView *ProteinsTextView, *CarbohydrateTextView, *FatsTextView;
    UIScrollView *Scroll;
    UITableView *tblFoodPlan;
    UINavigationBar *bar;
    UIButton *btnBack;
}
@property (nonatomic,retain) IBOutlet UILabel *lblProteins, *lblCarbohydrate, *lblFats, *lblFoodPlan;
@property (nonatomic,retain) IBOutlet UITextView *ProteinsTextView, *CarbohydrateTextView, *FatsTextView;
@property (nonatomic,retain) IBOutlet UIScrollView *Scroll;
@property (nonatomic,retain) IBOutlet UITableView *tblFoodPlan;
@property (nonatomic,retain) IBOutlet UINavigationBar *bar;
@property (nonatomic,retain) IBOutlet UIButton *btnBack;
@end
