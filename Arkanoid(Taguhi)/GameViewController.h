//
//  GameViewController.h
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/5/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighestScoreViewController.h"

@interface GameViewController : UIViewController <LevelNameDelegate>

@property NSString* levelName;

@end
