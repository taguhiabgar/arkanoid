//
//  Theme.h
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/7/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Theme : NSObject

@property NSString* backgroundImageName;
@property NSString* platformImageName;
@property NSString* themeTitle;
@property UIColor* textsColor;
@property UIColor* buttonsBackgroundColor;
@property UIColor* navigationBarColor;
@property NSDictionary* bricksImageNamesDictionary;
@property UIColor* levelsTableViewBackgroundColorFirst;
@property UIColor* levelsTableViewBackgroundColorSecond;
@property NSString* iPhoneHallOfFameBackgroundImageName;
@property NSString* iPadHallOfFameBackgroundImageName;
@property NSString* iPhoneInstructionsImageName;
@property NSString* iPadInsctructionsImageName;

@end
