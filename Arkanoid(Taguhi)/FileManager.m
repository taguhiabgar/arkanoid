//
//  FileManager.m
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/9/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import "FileManager.h"
#import "Constants.h"

@implementation FileManager

+ (id)sharedFileManager
{
    static FileManager* sharedInstance = nil;
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    return self;
}

- (NSString*)keyForHighestScoreForLevel:(NSString*)levelName
{
    NSMutableString* key = [[NSMutableString alloc] init];
    [key appendString:levelName];
    [key appendString:[HighestScoreString copy]];
    return key;
}

- (NSString*)keyForUsernameForLevel:(NSString*)levelName
{
    NSMutableString* key = [[NSMutableString alloc] init];
    [key appendString:levelName];
    [key appendString:[UsernameString copy]];
    return key;
}

- (void)setHighestScore:(NSInteger)score forLevel:(NSString*)levelName andUsername:(NSString*)username
{
    // get key for score
    NSString* scoreKey = [self keyForHighestScoreForLevel:levelName];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:scoreKey] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:scoreKey];
    }
    NSString* scoreString = [[NSNumber numberWithInteger:score] stringValue];
    NSString* savedScore = [self getHighestScoreForLevel:levelName];
    if (score >= [savedScore integerValue]) {
        // save score
        [[NSUserDefaults standardUserDefaults] setObject:scoreString forKey:scoreKey];
        // get key for username
        NSString* usernameKey = [self keyForUsernameForLevel:levelName];
        // save username
        [[NSUserDefaults standardUserDefaults] setObject:username forKey:usernameKey];
        // synchronize
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    // synchronize
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString*)getHighestScoreForLevel:(NSString*)levelName
{
    // get key of highest score
    NSString* key = [self keyForHighestScoreForLevel:levelName];
    // get value for key
    NSString* score = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (score == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return @"0";
    }
    return score;
}

- (NSString*)getUsernameWithHighestScoreForLevel:(NSString*)levelName
{
    // get key of username
    NSString* key = [self keyForUsernameForLevel:levelName];
    // get value for key
    NSString* username = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (username == nil)
        return [NoUsernameString copy];
    return username;
}

// add new level name to list of level names
- (void)addToFileOfCustomLevelsListNewCustomLevelWithName:(NSString*)levelName levelTypeIsDefault:(BOOL)isDefault
{
    // get list of levels names
    NSMutableArray<NSString*>* listOfLevelsNames = isDefault ? [self readContentFromFileOfDefaultLevelsList] : [self readContentFromFileOfCustomLevelsList];
    if (listOfLevelsNames == nil)
    {
        listOfLevelsNames = [[NSMutableArray alloc] init];
    }    
    // add new level name to list of custom levels names
    [listOfLevelsNames addObject:levelName];
    // get path
    NSString* fileName = isDefault ? [FileNameOfDefaultLevelsList copy] : [FileNameOfCustomLevelsList copy];
    NSString *archivePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:fileName];
    // archive array of custom levels names
    [NSKeyedArchiver archiveRootObject:listOfLevelsNames toFile:archivePath];
}

- (NSMutableArray<NSString*>*)readContentFromFileOfCustomLevelsList
{
    return [self readLevelsListOfType:NO];
}

- (NSMutableArray<NSString*>*)readContentFromFileOfDefaultLevelsList
{
    return [self readLevelsListOfType:YES];
}

- (NSMutableArray<NSString*>*)readLevelsListOfType:(BOOL)isDefault
{
    // get path
    NSString* fileName = (isDefault ? [FileNameOfDefaultLevelsList copy] : [FileNameOfCustomLevelsList copy]);
    NSString *archivePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:fileName];
    // read list of levels names from path
    NSMutableArray<NSString*>* listOfLevelsNames = [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
    // return list of levels names
    return listOfLevelsNames;
}

// delete name of custom level from list of custom levels
- (void)deleteFromFileWithCustomLevelsListTheLevelWithName:(NSString*)levelName
{
    // get list of custom levels names
    NSMutableArray<NSString*>* listOfCustomLevelsNames = [self readContentFromFileOfCustomLevelsList];
    if (listOfCustomLevelsNames != nil) {
        // find and remove object with given levelName
        for (NSInteger index = 0; index < [listOfCustomLevelsNames count]; index++)
            if ([listOfCustomLevelsNames[index] isEqualToString:levelName])
            {
                [listOfCustomLevelsNames removeObjectAtIndex:index];
                break;
            }
        // get path
        NSString *archivePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:[FileNameOfCustomLevelsList copy]];
        // archive array of custom levels names
        [NSKeyedArchiver archiveRootObject:listOfCustomLevelsNames toFile:archivePath];
    }
}

- (void)saveLevelWithGridOfBricks:(NSMutableArray<NSMutableArray<NSNumber*>*>*)gridOfBricks toFileWithName:(NSString*)levelName typeOfLevelIsCustom:(BOOL)isCustomLevel
{
    // get path
    NSString *archivePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:levelName];
    // archive matrix of bricks
    BOOL success = [NSKeyedArchiver archiveRootObject:gridOfBricks toFile:archivePath];
    if(success) {
        if (isCustomLevel) {
            // add name of new custom level to list of custom levels
            [self addToFileOfCustomLevelsListNewCustomLevelWithName:levelName levelTypeIsDefault:NO];
        } else {
            // add name of new default level to list of default levels
            [self addToFileOfCustomLevelsListNewCustomLevelWithName:levelName levelTypeIsDefault:YES];
        }
    }
}

- (NSMutableArray<NSMutableArray<NSNumber*>*>*)readGridOfBricksFromFileWithName:(NSString*)levelName
{
    // get path
    NSString *archivePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:levelName];
    // read matrix from path
    NSMutableArray<NSMutableArray<NSNumber*>*>* matrixOfBricks = [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
    // return matrix
    return matrixOfBricks;
}

- (void)deleteFileOfLevelWithName:(NSString*)levelName
{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:levelName];
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    if (success)
        // delete custom level name from list of custom levels names 
        [self deleteFromFileWithCustomLevelsListTheLevelWithName:levelName];
    // remove level from list of custom levels
    [self deleteFromFileWithCustomLevelsListTheLevelWithName:levelName];
}

@end
