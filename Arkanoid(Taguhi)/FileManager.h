//
//  FileManager.h
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/9/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

+ (id)sharedFileManager;

// read list of default levels names
- (NSMutableArray<NSString*>*)readContentFromFileOfDefaultLevelsList;
// read list of custom levels names
- (NSMutableArray<NSString*>*)readContentFromFileOfCustomLevelsList;
// add new custom level
- (void)saveLevelWithGridOfBricks:(NSMutableArray<NSMutableArray<NSNumber*>*>*)gridOfBricks toFileWithName:(NSString*)levelName typeOfLevelIsCustom:(BOOL)isCustomLevel;
// get matrix by level name
- (NSMutableArray<NSMutableArray<NSNumber*>*>*)readGridOfBricksFromFileWithName:(NSString*)levelName;
// delete level
- (void)deleteFileOfLevelWithName:(NSString*)levelName;
// set score and username
- (void)setHighestScore:(NSInteger)score forLevel:(NSString*)levelName andUsername:(NSString*)username;
// get score
- (NSString*)getHighestScoreForLevel:(NSString*)levelName;
// get username
- (NSString*)getUsernameWithHighestScoreForLevel:(NSString*)levelName;

@end
