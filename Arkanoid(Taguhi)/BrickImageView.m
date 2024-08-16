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
        case BrickTypeWithTwoLifes:
            return ScoreForBrickWithTwoLifes;
        case BrickTypeWithThreeLifes:
            return ScoreForBrickWithThreeLifes;
        case BrickTypeWithSuperPower:
            return ScoreForBrickWithSuperPower;
        case BrickTypeWithSuperPowerAttackedOnce:
            return ScoreForBrickWithSuperPowerAttackedOnce;
        case BrickTypeWithSuperPowerAttackedTwice:
            return ScoreForBrickWithSuperPowerAttackedTwice;
        case BrickTypeWithVisibility:
            return ScoreForBrickWithVisibility;
        default:
            return 0;
    }
}

- (BrickType)nextBrickTypeOfBrick:(BrickType)brickType
{
    switch (brickType) {
        case BrickTypeWithOneLife:
            return BrickTypeEmpty;
        case BrickTypeWithTwoLifes:
            return BrickTypeWithOneLife;
        case BrickTypeWithThreeLifes:
            return BrickTypeWithTwoLifes;
        case BrickTypeWithSuperPower:
            return BrickTypeWithSuperPowerAttackedOnce;
        case BrickTypeWithSuperPowerAttackedOnce:
            return BrickTypeWithSuperPowerAttackedTwice;
        case BrickTypeWithSuperPowerAttackedTwice:
            return BrickTypeEmpty;
        case BrickTypeWithVisibility:
            return BrickTypeEmpty;
        default:
            return BrickTypeEmpty;
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
    return ([self nextBrickTypeOfBrick:self.type] == BrickTypeEmpty);
}

- (void)attack
{
    [self setType:[self nextBrickTypeOfBrick:self.type]];
}

@end
