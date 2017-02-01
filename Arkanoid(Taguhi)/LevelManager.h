//
//  LevelManager.h
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/7/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LevelManager : NSObject

+ (id)sharedLevelManager;

- (void)addCustomLevelWithMatrix:(NSMutableArray*)matrix withLevelName:(NSString*)levelName;
- (NSMutableArray<NSString*>*)getCustomLevelsListFromFile;
- (NSMutableArray<NSString*>*)getDefaultLevelsListFromFile;
- (void)removeCustomLevelWithName:(NSString*)levelName;
- (NSString*)nextLevelOfLevel:(NSString*)levelName;

@end
