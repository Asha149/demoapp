//
//  ViewController.m
//  PhraseCrazyApp
//
//  Created by ajeet Singh on 10/09/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "ViewController.h"
#import "PlayGameViewController.h"
#import "GameRuleViewController.h"
#import "TipsViewController.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import "SelectTeamAndTimeViewController.h"
#import "GroupPlayViewController.h"

#define IN_APP_PURCHASE_MESSAGE @"Do you want to purchase this App? Once purchased, App with 3000+ phrases will be stored in your device."



@interface ViewController ()

@end

@implementation ViewController
@synthesize btnPlayGame;
@synthesize btnGroupPlay,btnTeamPlay,btnclose;
@synthesize alertview;
@synthesize img;

AppDelegate *app;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [alertview setHidden:YES];
    [img setHidden:YES];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark click event
-(IBAction)btnPlayGame_click:(id)sender
{
//    UIAlertView *alert = [[UIAlertView alloc]
//                          initWithTitle:@""
//                          message:@""
//                          delegate:self
//                          cancelButtonTitle:nil
//                          otherButtonTitles:@"Group Play",@"Team Play",
//                          nil];
//
//    alert.tag = 1;
//    [alert show];
    
    [alertview setHidden:NO];
    [img setHidden:NO];
   
//    PlayGameViewController *vc = [[PlayGameViewController alloc]init];
//    [self presentViewController:vc animated:YES completion:nil];
}

-(IBAction)btnGameRule_click:(id)sender
{
    GameRuleViewController *vc = [[GameRuleViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

-(IBAction)btnUpgrade_click:(id)sender
{
   
    if(app.flag == 0)
    {
        askToPurchase = [[UIAlertView alloc]
                     initWithTitle:@"In app Purchase"
                     message:IN_APP_PURCHASE_MESSAGE
                     delegate:self
                     cancelButtonTitle:nil
                     otherButtonTitles:@"Yes", @"No", nil];
        askToPurchase.delegate = self;
        askToPurchase.tag = 2;
        [askToPurchase show];
        [askToPurchase release];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]
                         initWithTitle:@"Purchase"
                         message:@"You have already purchased"
                         delegate:self
                         cancelButtonTitle:nil
                         otherButtonTitles:@"OK", @"Cancel", nil];
        alert.delegate = self;
        alert.tag = 2;
        [alert show];
        [alert release];
    }
}
#pragma mark purchgase app
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 2)
    {
        if (alertView==askToPurchase)
        {
            if (buttonIndex==0)
            {
                // user tapped YES, but we need to check if IAP is enabled or not.
                if ([SKPaymentQueue canMakePayments])
                {
                    //            [SVProgressHUD showWithStatus:@"Loading..."];
                    NSLog(@"can make payment");
//                    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:@"com.lanetteam.mypurchase"]];
                    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:@"com.qfcinc.mypurchase"]];
                    request.delegate = self;
                    [request start];
            
            
                } else {
                    NSLog(@"can not make payment");
                    UIAlertView *tmp = [[UIAlertView alloc]
                                initWithTitle:@"Prohibited"
                                message:@"Parental Control is enabled, cannot make a purchase!"
                                delegate:self
                                cancelButtonTitle:nil
                                otherButtonTitles:@"Ok", nil];
                    [tmp show];
                    [tmp release];
                }
            }

        }
    }
    else if (alertView.tag == 77)
    {
        if(buttonIndex == 0)
        {
            ViewController * vc = [[ViewController alloc]init];
            [self presentViewController:vc animated:YES completion:nil];
        }
    }
    else
    {
        if (buttonIndex == 0){
            app.IsTimed = FALSE;
            
            GroupPlayViewController *vc = [[GroupPlayViewController alloc]init];
            [self presentViewController:vc animated:YES completion:nil];

        }
        else
        {
            
            app.IsTimed = TRUE;
            SelectTeamAndTimeViewController *vc = [[SelectTeamAndTimeViewController alloc]init];
            [self presentViewController:vc animated:YES completion:nil];
            
        }

    }
}
-(IBAction)btnGroupPlay_click:(id)sender
{
    app.IsTimed = FALSE;
    
    GroupPlayViewController *vc = [[GroupPlayViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}
-(IBAction)btnTeamPlay_click:(id)sender
{
    app.IsTimed = TRUE;
    SelectTeamAndTimeViewController *vc = [[SelectTeamAndTimeViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}
-(IBAction)btnClose_click:(id)sender
{
    [alertview setHidden:YES];
    [img setHidden:YES];
}
#pragma mark StoreKit Delegate

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                // show wait view here
                //statusLabel.text = @"Processing...";
                
                NSLog(@"Processing...");
                break;
                
            case SKPaymentTransactionStatePurchased:
                
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                //                [SVProgressHUD dismiss];
                NSUserDefaults *isPurchased = [NSUserDefaults standardUserDefaults];
                [isPurchased setInteger:1 forKey:@"purchased"];
                AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                app.flag = 1;
//                PlayGameViewController *vc = [[PlayGameViewController alloc]init];
//                [self presentViewController:vc animated:YES completion:nil];
                NSLog(@"Done!");
               break;
                
            case SKPaymentTransactionStateRestored:
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                //                [SVProgressHUD dismiss];
                
                NSLog(@"restored!");
                break;
                
            case SKPaymentTransactionStateFailed:
                
                if (transaction.error.code != SKErrorPaymentCancelled) {
                    NSLog(@"Error payment cancelled");
                }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                //                [SVProgressHUD dismiss];
                
                NSLog(@"Purchase error");
                break;
                
            default:
                break;
        }
    }
}

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    //picsjoiner.${PRODUCT_NAME:rfc1034identifier}
    // remove wait view here
    //statusLabel.text = @"";
    NSLog(@"receive response");
    
    SKProduct *validProduct = nil;
    int count = [response.products count];
    
    NSLog(@"result is %@",response.products);
    
    if (count>0) {
         
        validProduct = [response.products objectAtIndex:0];
        SKPayment *payment = [SKPayment paymentWithProduct:validProduct];
        //SKPayment *payment = [SKPayment paymentWithProductIdentifier:@"com.emirbytes.IAPNoob.01"];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
        
        
        
        
    } else {
        //        [SVProgressHUD dismiss];
        UIAlertView *alert1 = [[UIAlertView alloc]
                            initWithTitle:@"Not Available"
                            message:@"No products to purchase"
                            delegate:self
                            cancelButtonTitle:nil
                            otherButtonTitles:@"Ok", nil];
        alert1.tag = 77;
    
        [alert1 show];
        [alert1 release];
    }
    
    
}

-(void)requestDidFinish:(SKRequest *)request
{
    [request release];
}

-(void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    //    [SVProgressHUD dismiss];
    NSLog(@"Failed to connect with error: %@", [error localizedDescription]);
}  


@end
