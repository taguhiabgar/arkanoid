//
//  SizeManager.m
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/20/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import "SizeManager.h"
#import "ThemeManager.h"
#import "Constants.h"

@import UIKit.UIDevice;

@interface SizeManager ()

@property BOOL isIPhoneDevice;

@end

@implementation SizeManager

+ (id)sharedSizeManager
{
    static SizeManager* sharedInstance = nil;
    @synchronized(self) {
        if (sharedInstance == nil)
        {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

- (instancetype)init{
    if(self = [super init])
        [self setIsIPhoneDevice:[[UIDevice currentDevice].model isEqualToString:[IPhoneDeviceName copy]]];
    return self;
}

- (CGFloat)screenLeftXCoordinate
{
    return self.viewFrame.origin.x;
}

- (CGFloat)screenRightXCoordinate
{
    return (self.viewFrame.origin.x + self.viewFrame.size.width);
}

- (CGFloat)screenTopYCoordinate
{
    return self.navigationBarHeight;
}

- (CGFloat)ballWidthAndHeight
{
    return self.isIPhoneDevice ? BallSizeForIPhone : BallSizeForIPad;
}

- (CGFloat)freeSpaceFromTop
{
    return self.isIPhoneDevice ? FreeSpaceForBricksFromTopForIPhone : FreeSpaceForBricksFromTopForIPad;
}

- (CGFloat)freeSpaceFromBottom
{
    return self.isIPhoneDevice ? FreeSpaceForBricksFromBottomForIPhone : FreeSpaceForBricksFromBottomForIPad;
}

- (CGFloat)freeSpaceFromLeft
{
    return self.isIPhoneDevice ? FreeSpaceForBricksFromLeftForIPhone : FreeSpaceForBricksFromLeftForIPad;
}

- (CGFloat)freeSpaceFromRight
{
    return self.isIPhoneDevice ? FreeSpaceForBricksFromRightForIPhone : FreeSpaceForBricksFromRightForIPad;
}
- (CGFloat)freeSpaceBetweenBricks
{
    return self.isIPhoneDevice ? FreeSpaceBetweenBricksForIPhone : FreeSpaceBetweenBricksForIPad;
}

- (CGFloat)buttonsCornerRadius
{
    return self.isIPhoneDevice ? ButtonsCornerRadiusForIPhone : ButtonsCornerRadiusForIPad;
}

- (CGFloat)buttonsFontSize
{
    return self.isIPhoneDevice ? ButtonsFontSizeForIPhone : ButtonsFontSizeForIPad;
}

- (NSString*)hallOfFameBackgroundImageName
{
    if (self.isIPhoneDevice)
        return [[[ThemeManager sharedThemeManager] currentTheme] iPhoneHallOfFameBackgroundImageName];
    else
        return [[[ThemeManager sharedThemeManager] currentTheme] iPadHallOfFameBackgroundImageName];
}

- (NSString*)instructionsImageName
{
    if (self.isIPhoneDevice)
        return [[[ThemeManager sharedThemeManager] currentTheme] iPhoneInstructionsImageName];
    else
        return [[[ThemeManager sharedThemeManager] currentTheme] iPadInsctructionsImageName];
}

- (CGFloat)platformFreeSpaceFromBottom
{
    return self.isIPhoneDevice ? FreeSpaceFromBottomForPlatformForIPhone : FreeSpaceFromBottomForPlatformForIPad;
}

- (CGSize)platformSize
{
    if (self.isIPhoneDevice)
        return CGSizeMake(PlatformWidthForIPhone, PlatformHeightForIPhone);
    else
        return CGSizeMake(PlatformWidthForIPad, PlatformHeightForIPad);
}

@end
