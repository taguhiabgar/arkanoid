//
//  HighestScoreViewController.h
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/16/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@protocol LevelNameDelegate <NSObject>

- (void)loadNextLevel;

@end

@interface HighestScoreViewController : UIViewController

@property NSString* levelName;
@property NSString* playerName;
@property NSString* score;
@property HighestScoreMode mode;
@property (nonatomic, weak) id <LevelNameDelegate> delegate;

@end
