

#import "PhraseDatabaseClass.h"
#import "PhraseObjectClass.h"

@implementation PhraseDatabaseClass

static PhraseDatabaseClass *_database;

+ (PhraseDatabaseClass *)database
{
    
    if (_database == nil) {
        _database = [[PhraseDatabaseClass alloc] init];
    }
    return _database;
}

- (id)init {
    if ((self = [super init])) {
        NSString *sqLiteDb = [[NSBundle mainBundle] pathForResource:@"dbPhraseCrazyApp" ofType:@"sqlite"];
        
        if (sqlite3_open([sqLiteDb UTF8String], &_database) != SQLITE_OK) {
            NSLog(@"Failed to open database!");
        }
    }
    return self;
}

- (void)dealloc {
    sqlite3_close(_database);
    [super dealloc];
}

- (NSArray *)getPhrases {
    
    NSMutableArray *retval = [[[NSMutableArray alloc] init] autorelease];
    NSString *query = @"SELECT * FROM tblPhrases";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
           
            char *phraseChars = (char *) sqlite3_column_text(statement, 1);
            
            NSString *phrase = [[NSString alloc] initWithUTF8String:phraseChars];
          
//            FailedBankInfo *info = [[FailedBankInfo alloc] initWithUniqueId:uniqueId name:name city:city state:state];
            PhraseObjectClass *obj = [[PhraseObjectClass alloc]initWithPhrase:phrase];
            [retval addObject:obj];
            [phrase release];
            
        }
        sqlite3_finalize(statement);
    }
    return retval;
    
}

@end
