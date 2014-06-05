//
//  ViewController.h
//  PhraseCrazyApp
//
//  Created by ajeet Singh on 10/09/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface ViewController : UIViewController <SKProductsRequestDelegate,SKPaymentTransactionObserver>
{
     UIAlertView *askToPurchase;
}
@property (nonatomic,retain)IBOutlet UIButton *btnPlayGame;
@property (nonatomic,retain)IBOutlet UIButton *btnGroupPlay,*btnTeamPlay,*btnclose;
@property (nonatomic,retain)IBOutlet UIView *alertview;
@property (nonatomic,retain) IBOutlet UIImageView *img;

-(IBAction)btnPlayGame_click:(id)sender;
-(IBAction)btnGameRule_click:(id)sender;
-(IBAction)btnUpgrade_click:(id)sender;

@end
