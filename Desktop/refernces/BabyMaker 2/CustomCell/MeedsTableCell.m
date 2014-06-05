//
//  MeedsTableCell.m
//  BabyMaker
//
//  Created by ajeet Singh on 22/08/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "MeedsTableCell.h"

@implementation MeedsTableCell
@synthesize lblName,RowButton,SW;
NSMutableArray *MedsArray,*SymptomsArray,*AdditionalInfoArray,*NewArray;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NewArray = [[NSMutableArray alloc] init];
        if(![[NSUserDefaults standardUserDefaults] boolForKey:@"FirstLoadArrays"])
        {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstLoadArrays"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            MedsArray = [[NSMutableArray alloc] init];
            [MedsArray addObject:@"Clomid"];
            [MedsArray addObject:@"Estrogen"];
            [MedsArray addObject:@"FSH"];
            [MedsArray addObject:@"Femara/letrozole"];
            [MedsArray addObject:@"HCG"];
            [MedsArray addObject:@"IVF Transfer"];
            [MedsArray addObject:@"Metformin"];
            [MedsArray addObject:@"Other Medications"];
            [MedsArray addObject:@"Progestrone"];
            [[NSUserDefaults standardUserDefaults] setObject:MedsArray forKey:@"Meds"];
            [MedsArray removeAllObjects];
            
            
            SymptomsArray = [[NSMutableArray alloc] init];
            [SymptomsArray addObject:@"Backache"];
            [SymptomsArray addObject:@"Bloated"];
            [SymptomsArray addObject:@"Breast Self Exam"];
            [SymptomsArray addObject:@"Constipation"];
            [SymptomsArray addObject:@"Cramps"];
            [SymptomsArray addObject:@"Decreased Appetite"];
            [SymptomsArray addObject:@"Diarrhea"];
            [SymptomsArray addObject:@"Dizziness"];
            [SymptomsArray addObject:@"Drinking"];
            [SymptomsArray addObject:@"Exercise"];
            [SymptomsArray addObject:@"Fatigue"];
            [SymptomsArray addObject:@"Feaver"];
            [SymptomsArray addObject:@"Frequent"];
            [SymptomsArray addObject:@"Sore Breasts"];
            [[NSUserDefaults standardUserDefaults] setObject:SymptomsArray forKey:@"Symptoms"];
            [SymptomsArray removeAllObjects];
            
            
            AdditionalInfoArray = [[NSMutableArray alloc] init];
            [AdditionalInfoArray addObject:@"Supplymentary 01"];
            [AdditionalInfoArray addObject:@"Supplymentary 02"];
            [AdditionalInfoArray addObject:@"Supplymentary 03"];
            [[NSUserDefaults standardUserDefaults] setObject:AdditionalInfoArray forKey:@"AdditionalInfo"];
            [AdditionalInfoArray removeAllObjects];
            
            
        }
        MedsArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"Meds"]];
        SymptomsArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"Symptoms"]];
        AdditionalInfoArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"AdditionalInfo"]];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
