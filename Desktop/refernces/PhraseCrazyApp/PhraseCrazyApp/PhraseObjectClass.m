//
//  PhraseObjectClass.m
//  PhraseCrazyApp
//
//  Created by ajeet Singh on 11/09/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import "PhraseObjectClass.h"

@implementation PhraseObjectClass
@synthesize Phrases = _Phrases;

-(id)initWithPhrase:(NSString *)Phrase
{
     if ((self = [super init]))
     {
         self.Phrases = Phrase;
     }
    return self;
}

- (void) dealloc
{
    self.Phrases = nil;
    [super dealloc];
}

@end
