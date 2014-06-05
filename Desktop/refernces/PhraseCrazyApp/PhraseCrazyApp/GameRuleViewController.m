//
//  GameRuleViewController.m
//  PhraseCrazyApp
//
//  Created by ajeet Singh on 13/09/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "GameRuleViewController.h"
#import "ViewController.h"

@interface GameRuleViewController ()

@end

@implementation GameRuleViewController
@synthesize txtFullGroup,txtTeamStyle;
@synthesize btnBack,scrollRule;
@synthesize lblTips;
@synthesize lblGroup;
@synthesize lblTeam;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *strTeam1 = @"(4 or more players / Faster pace & more competitive playing)";
    
    NSString *strTeam2 = @"Divide into teams and enter the number of teams. Enter the number of minutes for each turn. Select a team and player to be the starting team and clue-giver. Clue-giver pushes Start button and begins making up and giving clues to his/her team. Team players may talk freely with each other and clue-giver during the game. The team guesses as many phrases as possible before time is up. Verbal clues and gestures are legal. Clue-giver hits Success button each time someone guesses a phrase, which adds a point to their team’s score. Keywords in the phrase cannot be said by the clue-giver till the word is guessed. If clue-giver says a keyword before it is guessed, choose a new phrase. When a team’s time runs out, it’s the next team’s turn. Teams rotate clue-givers.";
//    NSString *strTeam = [NSString stringWithFormat:@"%@%@",strTeam1,strTeam2];
    lblGroup.text = @"(2 or more players / More casual playing)";
    txtTeamStyle.text = strTeam2;
    lblTeam .text = strTeam1;
    
    txtFullGroup.text = @"Choose a player to be the beginning clue-giver. Clue-giver pushes Start button and begins making up clues for his/her selected phrase. Clue-giver gives as many clues as needed till a player guesses the phrase. Verbal clues and gestures are legal. Clue-giver cannot say a keyword in the phrase till the word is guessed. If clue-giver says a keyword before it is guessed, choose a new phrase. Players may talk freely with each other and clue-giver during the game. When the phrase is guessed your turn is over, and it’s another player’s turn to be the clue-giver.";
    NSLog(@"%d",[txtFullGroup.text length]);
    
    lblTips.text = @"Tell the players the number of words in the saying. Focus on the key words. ‘Sounds like’ and ‘Opposite meaning clues’ work well. Re-say guessed words often. Make up alternate meaning clues. Create as many clues as you wish for each saying. Verbal clues and gestures are legal. If things aren’t going well with a phrase, simply select a different one (timer remains running in team style). You can modify the rules to fit your group.";
    
    NSLog(@"length of full group :: %d",txtFullGroup.text.length);
    NSLog(@"length of txtTeamStyle group :: %d",txtTeamStyle.text.length);
    NSLog(@"length of lbltips :: %d",lblTips.text.length);
    
    
}
-(void)viewWillAppear:(BOOL)animated{
   
    [scrollRule setContentSize:CGSizeMake(scrollRule.frame.size.width, 1200)];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)btnBack_click:(id)sender
{
    ViewController *vc = [[ViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
