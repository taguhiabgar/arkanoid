//
//  LevelManager.m
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/7/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import "LevelManager.h"
#import "FileManager.h"
#import "Constants.h"

@implementation LevelManager

+ (id)sharedLevelManager
{
    static LevelManager* sharedInstance = nil;
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

- (instancetype)init{
    if(self = [super init]){
        [self setupDefaultLevels];
    }
    return self;
}

- (NSString*)nextLevelOfLevel:(NSString*)levelName
{
    NSMutableArray* arrayOfLevels = [[NSMutableArray alloc] init];
    [arrayOfLevels addObjectsFromArray:[self getCustomLevelsListFromFile]];
    [arrayOfLevels addObjectsFromArray:[self getDefaultLevelsListFromFile]];
    for (NSInteger index = 0; index < [arrayOfLevels count]; index++) {
        if ([arrayOfLevels[index] isEqualToString:levelName]) {
            if (index == [arrayOfLevels count] - 1) {
                return arrayOfLevels[0];
            } else {
                return arrayOfLevels[index + 1];
            }
        }
    }
    if ([arrayOfLevels count] != 0)
        return arrayOfLevels[0];
    return @"";
}

- (void)removeCustomLevelWithName:(NSString*)levelName
{
    [[FileManager sharedFileManager] deleteFileOfLevelWithName:levelName];
}

- (void)setupDefaultLevels
{
    // get default levels list
    NSMutableArray<NSString*>* defaultLevelsArray = [self getDefaultLevelsListFromFile];
    // setup default levels if needed
    if ([defaultLevelsArray count] == 0)
    {
        for (NSInteger defaultLevelIndex = 1; defaultLevelIndex <= AmountOfDefaultLevels; defaultLevelIndex++)
        {
            NSMutableString* currentLevelName = [[NSMutableString alloc] initWithString:[DefaultLevelNameBeginning copy]];
            [currentLevelName appendFormat:@"%ld", (long)defaultLevelIndex];
            [self setupDefaultLevelWithMatrix:[self matrixOfDefaultLevelWithIndex:defaultLevelIndex] andLevelName:currentLevelName];
        }
    }
}

- (void)setupDefaultLevelWithMatrix:(NSMutableArray <NSMutableArray <NSNumber*>*>*)matrix andLevelName:(NSString*)levelName
{
    // write default level to file
    [[FileManager sharedFileManager] saveLevelWithGridOfBricks:matrix toFileWithName:levelName typeOfLevelIsCustom:NO];
}

- (NSMutableArray<NSString*>*)getDefaultLevelsListFromFile
{
    // create array
    NSMutableArray<NSString*>* arrayOfDefaultLevels = [[NSMutableArray alloc] init];
    // fill array with content of file "default levels list"
    arrayOfDefaultLevels = [[FileManager sharedFileManager] readContentFromFileOfDefaultLevelsList];
    if (arrayOfDefaultLevels == nil) {
        arrayOfDefaultLevels = [[NSMutableArray alloc] init];
    }
    return arrayOfDefaultLevels;
}

- (NSMutableArray<NSString*>*)getCustomLevelsListFromFile
{
    // create array
    NSMutableArray<NSString*>* arrayOfCustomLevelsNames = [[NSMutableArray alloc] init];
    // fill array with content of file "custom levels list"
    arrayOfCustomLevelsNames = [[FileManager sharedFileManager] readContentFromFileOfCustomLevelsList];
    if (arrayOfCustomLevelsNames == nil) {
        arrayOfCustomLevelsNames = [[NSMutableArray alloc] init];
    }
    return arrayOfCustomLevelsNames;
}

- (void)addCustomLevelWithMatrix:(NSMutableArray*)matrix withLevelName:(NSString*)levelName
{
    // write custom level to file
    [[FileManager sharedFileManager] saveLevelWithGridOfBricks:matrix toFileWithName:levelName typeOfLevelIsCustom:YES];
}

- (NSMutableArray<NSMutableArray<NSNumber*>*>*)matrixOfDefaultLevelWithIndex:(NSInteger)levelIndex
{
    NSArray* matrix = [[NSMutableArray alloc] init];
    switch (levelIndex) {
        case 1:
            matrix = @[@[@0, @0, @0, @1, @0, @0, @0, @0, @0, @0, ],
                       @[@0, @0, @0, @0, @1, @0, @0, @0, @3, @0, ],
                       @[@0, @0, @0, @1, @0, @0, @3, @5, @0, @0, ],
                       @[@0, @0, @1, @0, @0, @3, @5, @3, @0, @0, ],
                       @[@0, @1, @0, @0, @2, @2, @3, @0, @0, @0, ],
                       @[@1, @0, @0, @4, @4, @2, @0, @0, @1, @0, ],
                       @[@1, @0, @5, @5, @4, @0, @0, @1, @0, @1, ],
                       @[@1, @4, @5, @5, @0, @0, @1, @0, @0, @0, ],
                       @[@0, @1, @4, @0, @0, @1, @0, @0, @0, @0, ],
                       @[@1, @0, @1, @1, @1, @0, @0, @0, @0, @0, ]];
            break;
        case 2:
            matrix = @[@[@0, @0, @0, @0, @5, @5, @0, @0, @0, @0, ],
                       @[@0, @0, @0, @4, @4, @4, @4, @0, @0, @0, ],
                       @[@0, @0, @3, @3, @3, @3, @3, @3, @0, @0, ],
                       @[@0, @2, @2, @2, @0, @0, @2, @2, @2, @0, ],
                       @[@1, @1, @1, @0, @5, @5, @0, @1, @1, @1, ],
                       @[@0, @0, @0, @5, @1, @1, @5, @0, @0, @0, ],
                       @[@0, @0, @0, @0, @5, @5, @0, @0, @0, @0, ],
                       @[@0, @0, @0, @0, @0, @0, @0, @0, @0, @0, ],
                       @[@0, @0, @0, @0, @0, @0, @0, @0, @0, @0, ],
                       @[@0, @0, @0, @0, @0, @0, @0, @0, @0, @0, ]];
            break;
        case 3:
            matrix = @[@[@0, @0, @0, @0, @0, @1, @2, @0, @0, @0, ],
                       @[@0, @0, @0, @0, @0, @1, @2, @0, @0, @0, ],
                       @[@0, @0, @1, @1, @1, @2, @0, @0, @0, @3, ],
                       @[@0, @1, @2, @2, @2, @0, @0, @0, @3, @4, ],
                       @[@0, @1, @2, @2, @2, @0, @0, @3, @4, @5, ],
                       @[@0, @0, @1, @1, @1, @2, @0, @3, @4, @5, ],
                       @[@0, @0, @0, @0, @0, @1, @2, @0, @3, @4, ],
                       @[@0, @0, @0, @0, @0, @1, @2, @0, @0, @3, ],
                       @[@0, @0, @1, @1, @1, @2, @0, @0, @0, @0, ],
                       @[@0, @1, @2, @2, @2, @0, @0, @0, @0, @0, ]];
            break;
        case 4:
            matrix = @[@[@1, @1, @1, @1, @1, @4, @4, @4, @4, @4, ],
                       @[@1, @0, @0, @0, @0, @0, @0, @0, @0, @4, ],
                       @[@1, @0, @2, @2, @2, @5, @5, @5, @0, @4, ],
                       @[@1, @0, @2, @0, @0, @0, @0, @5, @0, @4, ],
                       @[@1, @0, @2, @0, @3, @3, @0, @5, @0, @4, ],
                       @[@1, @0, @2, @0, @3, @3, @0, @5, @0, @4, ],
                       @[@1, @0, @2, @0, @0, @0, @0, @5, @0, @4, ],
                       @[@1, @0, @2, @2, @2, @5, @5, @5, @0, @4, ],
                       @[@1, @0, @0, @0, @0, @0, @0, @0, @0, @4, ],
                       @[@1, @1, @1, @1, @1, @4, @4, @4, @4, @4, ]];
            break;
        case 5:
            matrix = @[@[@2, @0, @0, @1, @1, @1, @1, @0, @0, @5, ],
                       @[@2, @0, @1, @1, @1, @1, @1, @1, @0, @5, ],
                       @[@2, @0, @1, @1, @0, @0, @1, @1, @0, @5, ],
                       @[@2, @0, @0, @0, @0, @0, @1, @1, @0, @5, ],
                       @[@2, @0, @0, @0, @0, @1, @1, @0, @0, @5, ],
                       @[@4, @0, @0, @0, @1, @1, @0, @0, @0, @3, ],
                       @[@4, @0, @0, @0, @1, @1, @0, @0, @0, @3, ],
                       @[@4, @0, @0, @0, @0, @0, @0, @0, @0, @3, ],
                       @[@4, @0, @0, @0, @1, @1, @0, @0, @0, @3, ],
                       @[@4, @0, @0, @0, @1, @1, @0, @0, @0, @3, ]];
            break;
        case 6:
            matrix = @[@[@0, @0, @0, @0, @5, @0, @0, @0, @0, @0, ],
                       @[@0, @0, @0, @5, @2, @5, @0, @0, @0, @0, ],
                       @[@0, @0, @5, @2, @2, @2, @5, @0, @0, @0, ],
                       @[@0, @5, @2, @2, @2, @2, @2, @5, @0, @0, ],
                       @[@0, @5, @5, @2, @2, @2, @5, @5, @0, @0, ],
                       @[@0, @5, @3, @5, @2, @5, @4, @5, @0, @0, ],
                       @[@0, @5, @3, @3, @5, @4, @4, @5, @0, @0, ],
                       @[@0, @0, @5, @3, @5, @4, @5, @0, @0, @0, ],
                       @[@0, @0, @0, @5, @5, @5, @0, @0, @0, @0, ],
                       @[@0, @0, @0, @0, @5, @0, @0, @0, @0, @0, ]];
            break;
        case 7:
            matrix = @[@[@2, @2, @2, @2, @2, @2, @2, @2, @0, @0, ],
                       @[@2, @2, @2, @2, @2, @2, @2, @2, @0, @0, ],
                       @[@0, @0, @0, @2, @2, @4, @4, @0, @0, @0, ],
                       @[@0, @0, @0, @2, @2, @4, @4, @0, @5, @5, ],
                       @[@0, @0, @0, @2, @2, @4, @4, @0, @5, @5, ],
                       @[@1, @1, @0, @2, @2, @4, @4, @0, @0, @0, ],
                       @[@1, @1, @0, @2, @2, @4, @4, @0, @0, @0, ],
                       @[@0, @0, @0, @2, @2, @4, @4, @0, @0, @0, ],
                       @[@0, @0, @4, @4, @4, @4, @4, @4, @4, @4, ],
                       @[@0, @0, @4, @4, @4, @4, @4, @4, @4, @4, ]];
            break;
        case 8:
            matrix = @[@[@1, @1, @1, @1, @1, @0, @0, @0, @5, @4, ],
                       @[@1, @0, @0, @0, @0, @0, @0, @5, @4, @5, ],
                       @[@1, @0, @2, @2, @2, @0, @5, @4, @5, @0, ],
                       @[@1, @0, @2, @0, @0, @0, @4, @5, @0, @0, ],
                       @[@1, @0, @2, @0, @3, @3, @0, @0, @0, @0, ],
                       @[@0, @0, @0, @0, @3, @3, @0, @2, @0, @1, ],
                       @[@0, @0, @4, @5, @0, @0, @0, @2, @0, @1, ],
                       @[@0, @4, @5, @4, @0, @2, @2, @2, @0, @1, ],
                       @[@4, @5, @4, @0, @0, @0, @0, @0, @0, @1, ],
                       @[@5, @4, @0, @0, @0, @1, @1, @1, @1, @1, ]];
            break;
        case 9:
            matrix = @[@[@0, @0, @0, @1, @1, @1, @1, @0, @0, @0, ],
                       @[@0, @0, @1, @2, @2, @2, @2, @1, @0, @0, ],
                       @[@0, @1, @2, @3, @3, @3, @3, @2, @1, @0, ],
                       @[@0, @1, @2, @3, @4, @4, @3, @2, @1, @0, ],
                       @[@0, @0, @0, @0, @0, @4, @3, @2, @1, @0, ],
                       @[@0, @0, @0, @0, @4, @4, @3, @2, @1, @0, ],
                       @[@4, @4, @4, @4, @3, @3, @2, @1, @0, @0, ],
                       @[@3, @3, @3, @3, @2, @2, @1, @0, @0, @5, ],
                       @[@2, @2, @2, @2, @1, @1, @0, @0, @5, @5, ],
                       @[@1, @1, @1, @1, @0, @0, @0, @5, @5, @5, ]];
            break;
        case 10:
            matrix = @[@[@5, @5, @3, @0, @0, @0, @0, @3, @2, @2, ],
                       @[@5, @5, @5, @3, @0, @0, @3, @2, @2, @2, ],
                       @[@0, @0, @5, @5, @3, @3, @2, @2, @0, @0, ],
                       @[@0, @0, @0, @5, @3, @3, @2, @0, @0, @0, ],
                       @[@0, @0, @5, @3, @0, @0, @3, @2, @0, @0, ],
                       @[@0, @0, @2, @3, @0, @0, @3, @5, @0, @0, ],
                       @[@0, @0, @0, @2, @3, @3, @5, @0, @0, @0, ],
                       @[@0, @0, @2, @2, @3, @3, @5, @5, @0, @0, ],
                       @[@2, @2, @2, @3, @0, @0, @3, @5, @5, @5, ],
                       @[@2, @2, @3, @0, @0, @0, @0, @3, @5, @5, ]];
            break;
        default:
            break;
    }
    NSMutableArray* mutableMatrix = [[NSMutableArray alloc] initWithArray:matrix];
    return mutableMatrix;
}

@end
