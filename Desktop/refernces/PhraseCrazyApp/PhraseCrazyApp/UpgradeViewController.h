//
//  UpgradeViewController.h
//  PhraseCrazyApp
//
//  Created by ajeet Singh on 16/09/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface UpgradeViewController : UIViewController<SKProductsRequestDelegate,SKPaymentTransactionObserver>

@end
