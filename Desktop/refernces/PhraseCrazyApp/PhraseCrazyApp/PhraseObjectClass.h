//
//  PhraseObjectClass.h
//  PhraseCrazyApp
//
//  Created by ajeet Singh on 11/09/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhraseObjectClass : NSObject
{
    int Id;
    NSString *_Phrases;
}
@property (nonatomic,retain)NSString *Phrases;

- (id)initWithPhrase:(NSString *)Phrases;
@end
