//
//  PhraseDatabaseClass.h
//  PhraseCrazyApp
//
//  Created by ajeet Singh on 11/09/13.
//  Copyright (c) 2013 ajeet Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h" 

@interface PhraseDatabaseClass : NSObject
{
    sqlite3 *_database;
}
+ (PhraseDatabaseClass *)database;
- (NSArray *)getPhrases;
@end
