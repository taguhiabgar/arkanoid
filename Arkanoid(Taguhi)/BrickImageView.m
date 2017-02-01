//
//  BrickImageView.m
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/15/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import "BrickImageView.h"
#import "ThemeManager.h"
#import "Constants.h"

@implementation BrickImageView

- (NSInteger)scoreForCurrentType
{
    switch (self.type) {
        case BrickTypeWithOneLife:
            return ScoreForBrickWithOneLife;
            break;
        case BrickTypeWithTwoLifes:
            return ScoreForBrickWithTwoLifes;
            break;
        case BrickTypeWithThreeLifes:
            return ScoreForBrickWithThreeLifes;
            break;
        case BrickTypeWithSuperPower:
            return ScoreForBrickWithSuperPower;
            break;
        case BrickTypeWithSuperPowerAttackedOnce:
            return ScoreForBrickWithSuperPowerAttackedOnce;
            break;
        case BrickTypeWithSuperPowerAttackedTwice:
            return ScoreForBrickWithSuperPowerAttackedTwice;
            break;
        case BrickTypeWithVisibility:
            return ScoreForBrickWithVisibility;
            break;
        default:
            return 0;
            break;
    }
}

- (BrickType)nextBrickTypeOfBrick:(BrickType)brickType
{
    switch (brickType) {
        case BrickTypeWithOneLife:
            return BrickTypeEmpty;
            break;
        case BrickTypeWithTwoLifes:
            return BrickTypeWithOneLife;
            break;
        case BrickTypeWithThreeLifes:
            return BrickTypeWithTwoLifes;
            break;
        case BrickTypeWithSuperPower:
            return BrickTypeWithSuperPowerAttackedOnce;
            break;
        case BrickTypeWithSuperPowerAttackedOnce:
            return BrickTypeWithSuperPowerAttackedTwice;
            break;
        case BrickTypeWithSuperPowerAttackedTwice:
            return BrickTypeEmpty;
            break;
        case BrickTypeWithVisibility:
            return BrickTypeEmpty;
            break;
        default:
            return BrickTypeEmpty;
            break;
    }
}

- (void)setType:(BrickType)type
{
    _type = type;
    if (type != BrickTypeEmpty)
        [self setImage:[UIImage imageNamed:[[[[ThemeManager sharedThemeManager] currentTheme] bricksImageNamesDictionary] objectForKey:[NSNumber numberWithInteger:type]]]];
}

- (BOOL)willExplodeAfterAttack
{
    if ([self nextBrickTypeOfBrick:self.type] == BrickTypeEmpty)
        return YES;
    else
        return NO;
}

- (void)attack
{
    [self setType:[self nextBrickTypeOfBrick:self.type]];
}

@end
