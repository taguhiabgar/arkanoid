//
//  ThemeManager.m
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/7/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import "ThemeManager.h"
#import "Constants.h"
@implementation ThemeManager

+ (id)sharedThemeManager
{
    static ThemeManager* sharedInstance = nil;
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

- (instancetype)init{
    if(self = [super init]){
        // initialize arrayOfThemes
        self.arrayOfThemes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setupThemes
{
    [self setupYellowOrangeTheme];
    [self setupOrangeRoseTheme];
    [self setupGreenBlueTheme];
    // define which theme is default in the shared manager
    if ([self.arrayOfThemes count] > 0)
        [[ThemeManager sharedThemeManager] setCurrentTheme:[[[ThemeManager sharedThemeManager] arrayOfThemes] objectAtIndex:0]];
}

- (void)setupYellowOrangeTheme
{
    // create yellow-orange theme
    Theme* yellowOrangeTheme = [[Theme alloc] init];
    // set properties values of yellow-orange theme
    [yellowOrangeTheme setIPadInsctructionsImageName:[YellowOrangeThemeInstructionsImageNameIPad copy]];
    [yellowOrangeTheme setIPhoneInstructionsImageName:[YellowOrangeThemeInstructionsImageNameIPhone copy]];
    [yellowOrangeTheme setBackgroundImageName:[YellowOrangeThemeBackgroundImageName copy]];
    [yellowOrangeTheme setIPadHallOfFameBackgroundImageName:[YellowOrangeThemeHallOfFameBackgroundImageNameIPad copy]];
    [yellowOrangeTheme setIPhoneHallOfFameBackgroundImageName:[YellowOrangeThemeHallOfFameBackgroundImageNameIPhone copy]];
    [yellowOrangeTheme setThemeTitle:[YellowOrangeThemeTitle copy]];
    [yellowOrangeTheme setPlatformImageName:[YellowOrangeThemePlatformImageName copy]];
    // set texts color of yellow-orange theme
    [yellowOrangeTheme setTextsColor:[UIColor colorWithRed:YellowOrangeThemeTextsColorRed
                                                     green:YellowOrangeThemeTextsColorGreen
                                                      blue:YellowOrangeThemeTextsColorBlue
                                                     alpha:YellowOrangeThemeTextsColorAlpha]];
    // set buttons background color of yellow-orange theme
    [yellowOrangeTheme setButtonsBackgroundColor:[UIColor colorWithRed:YellowOrangeThemeButtonsBackgroundColorRed
                                                                 green:YellowOrangeThemeButtonsBackgroundColorGreen
                                                                  blue:YellowOrangeThemeButtonsBackgroundColorBlue
                                                                 alpha:YellowOrangeThemeButtonsBackgroundColorAlpha]];
    // first color of table view cell
    [yellowOrangeTheme setLevelsTableViewBackgroundColorFirst:[UIColor colorWithRed:YellowOrangeThemeLevelsTableViewBackgroundColorFirstRed
                                                                              green:YellowOrangeThemeLevelsTableViewBackgroundColorFirstGreen
                                                                               blue:YellowOrangeThemeLevelsTableViewBackgroundColorFirstBlue
                                                                              alpha:YellowOrangeThemeButtonsBackgroundColorAlpha]];
    // second color of table view cell
    [yellowOrangeTheme setLevelsTableViewBackgroundColorSecond:[UIColor colorWithRed:YellowOrangeThemeLevelsTableViewBackgroundColorSecondRed
                                                                              green:YellowOrangeThemeLevelsTableViewBackgroundColorSecondGreen
                                                                               blue:YellowOrangeThemeLevelsTableViewBackgroundColorSecondBlue
                                                                              alpha:YellowOrangeThemeButtonsBackgroundColorAlpha]];
    // set navigation bar color of yellow-orange theme
    [yellowOrangeTheme setNavigationBarColor:[UIColor colorWithRed:YellowOrangeThemeNavigationBarColorRed
                                                             green:YellowOrangeThemeNavigationBarColorGreen
                                                              blue:YellowOrangeThemeNavigationBarColorBlue
                                                             alpha:YellowOrangeThemeNavigationBarColorAlpha]];
    // create bricks images names dictionary and initialize with values
    yellowOrangeTheme.bricksImageNamesDictionary = [[NSDictionary alloc] init];
    yellowOrangeTheme.bricksImageNamesDictionary = @{
                                                     [NSNumber numberWithInteger:BrickTypeEmpty] : YellowOrangeThemeBrickTypeEmptyImageName,
                                                     [NSNumber numberWithInteger:BrickTypeWithOneLife] : YellowOrangeThemeBrickTypeWithOneLifeImageName,
                                                     [NSNumber numberWithInteger:BrickTypeWithTwoLifes] : YellowOrangeThemeBrickTypeWithTwoLifesImageName,
                                                     [NSNumber numberWithInteger:BrickTypeWithThreeLifes] : YellowOrangeThemeBrickTypeWithThreeLifesImageName,
                                                     [NSNumber numberWithInteger:BrickTypeWithSuperPower] : YellowOrangeThemeBrickTypeWithSuperPowerImageName,
                                                     [NSNumber numberWithInteger:BrickTypeWithSuperPowerAttackedOnce] : YellowOrangeThemeBrickTypeWithSuperPowerAttackedOnceImageName,
                                                     [NSNumber numberWithInteger:BrickTypeWithSuperPowerAttackedTwice] : YellowOrangeThemeBrickTypeWithSuperPowerAttackedTwiceImageName,
                                                     [NSNumber numberWithInteger:BrickTypeWithVisibility] : YellowOrangeThemeBrickTypeWithVisibilityImageName,
                                                     };
    // add yellow-orange theme to shared theme manager
    [[[ThemeManager sharedThemeManager] arrayOfThemes] addObject:yellowOrangeTheme];
}

- (void)setupOrangeRoseTheme
{
    // create orange-rose theme
    Theme* orangeRoseTheme = [[Theme alloc] init];
    // set properties values of orange-rose theme
    [orangeRoseTheme setIPadInsctructionsImageName:[OrangeRoseThemeInstructionsImageNameIPad copy]];
    [orangeRoseTheme setIPhoneInstructionsImageName:[OrangeRoseThemeInstructionsImageNameIPhone copy]];
    [orangeRoseTheme setBackgroundImageName:[OrangeRoseThemeBackgroundImageName copy]];
    [orangeRoseTheme setIPadHallOfFameBackgroundImageName:[OrangeRoseThemeHallOfFameBackgroundImageNameIPad copy]];
    [orangeRoseTheme setIPhoneHallOfFameBackgroundImageName:[OrangeRoseThemeHallOfFameBackgroundImageNameIPhone copy]];
    [orangeRoseTheme setThemeTitle:[OrangeRoseThemeTitle copy]];
    [orangeRoseTheme setPlatformImageName:[OrangeRoseThemePlatformImageName copy]];
    // set texts color of orange-rose theme
    [orangeRoseTheme setTextsColor:[UIColor colorWithRed:OrangeRoseThemeTextsColorRed
                                                   green:OrangeRoseThemeTextsColorGreen
                                                    blue:OrangeRoseThemeTextsColorBlue
                                                   alpha:OrangeRoseThemeTextsColorAlpha]];
    // set buttons background color of orange-rose theme
    [orangeRoseTheme setButtonsBackgroundColor:[UIColor colorWithRed:OrangeRoseThemeButtonsBackgroundColorRed
                                                               green:OrangeRoseThemeButtonsBackgroundColorGreen
                                                                blue:OrangeRoseThemeButtonsBackgroundColorBlue
                                                               alpha:OrangeRoseThemeButtonsBackgroundColorAlpha]];
    // first color of table view cell
    [orangeRoseTheme setLevelsTableViewBackgroundColorFirst:[UIColor colorWithRed:OrangeRoseThemeLevelsTableViewBackgroundColorFirstRed
                                                                              green:OrangeRoseThemeLevelsTableViewBackgroundColorFirstGreen
                                                                               blue:OrangeRoseThemeLevelsTableViewBackgroundColorFirstBlue
                                                                              alpha:OrangeRoseThemeButtonsBackgroundColorAlpha]];
    // second color of table view cell
    [orangeRoseTheme setLevelsTableViewBackgroundColorSecond:[UIColor colorWithRed:OrangeRoseThemeLevelsTableViewBackgroundColorSecondRed
                                                                               green:OrangeRoseThemeLevelsTableViewBackgroundColorSecondGreen
                                                                                blue:OrangeRoseThemeLevelsTableViewBackgroundColorSecondBlue
                                                                               alpha:OrangeRoseThemeButtonsBackgroundColorAlpha]];
    // set navigation bar color of orange-rose theme
    [orangeRoseTheme setNavigationBarColor:[UIColor colorWithRed:OrangeRoseThemeNavigationBarColorRed
                                                           green:OrangeRoseThemeNavigationBarColorGreen
                                                            blue:OrangeRoseThemeNavigationBarColorBlue
                                                           alpha:OrangeRoseThemeNavigationBarColorAlpha]];
    // create bricks images names dictionary and initialize with values
    orangeRoseTheme.bricksImageNamesDictionary = [[NSDictionary alloc] init];
    orangeRoseTheme.bricksImageNamesDictionary = @{
                                                   [NSNumber numberWithInteger:BrickTypeEmpty] : OrangeRoseThemeBrickTypeEmptyImageName,
                                                   [NSNumber numberWithInteger:BrickTypeWithOneLife] : OrangeRoseThemeBrickTypeWithOneLifeImageName,
                                                   [NSNumber numberWithInteger:BrickTypeWithTwoLifes] : OrangeRoseThemeBrickTypeWithTwoLifesImageName,
                                                   [NSNumber numberWithInteger:BrickTypeWithThreeLifes] : OrangeRoseThemeBrickTypeWithThreeLifesImageName,
                                                   [NSNumber numberWithInteger:BrickTypeWithSuperPower] : OrangeRoseThemeBrickTypeWithSuperPowerImageName,
                                                   [NSNumber numberWithInteger:BrickTypeWithSuperPowerAttackedOnce] : OrangeRoseThemeBrickTypeWithSuperPowerAttackedOnceImageName,
                                                   [NSNumber numberWithInteger:BrickTypeWithSuperPowerAttackedTwice] : OrangeRoseThemeBrickTypeWithSuperPowerAttackedTwiceImageName,
                                                   [NSNumber numberWithInteger:BrickTypeWithVisibility] : OrangeRoseThemeBrickTypeWithVisibilityImageName,
                                                   };
    // add orange-rose theme to shared theme manager
    [[[ThemeManager sharedThemeManager] arrayOfThemes] addObject:orangeRoseTheme];
}

- (void)setupGreenBlueTheme
{
    // create green-blue theme
    Theme* greenBlueTheme = [[Theme alloc] init];
    [greenBlueTheme setIPadInsctructionsImageName:[GreenBlueThemeInstructionsImageNameIPad copy]];
    [greenBlueTheme setIPhoneInstructionsImageName:[GreenBlueThemeInstructionsImageNameIPhone copy]];
    [greenBlueTheme setBackgroundImageName:[GreenBlueThemeBackgroundImageName copy]];
    [greenBlueTheme setIPadHallOfFameBackgroundImageName:[GreenBlueThemeHallOfFameBackgroundImageNameIPad copy]];
    [greenBlueTheme setIPhoneHallOfFameBackgroundImageName:[GreenBlueThemeHallOfFameBackgroundImageNameIPhone copy]];
    [greenBlueTheme setThemeTitle:[GreenBlueThemeTitle copy]];
    [greenBlueTheme setPlatformImageName:[GreenBlueThemePlatformImageName copy]];
    // set texts color of orange-rose theme
    [greenBlueTheme setTextsColor:[UIColor colorWithRed:GreenBlueThemeTextsColorRed
                                                  green:GreenBlueThemeTextsColorGreen
                                                   blue:GreenBlueThemeTextsColorBlue
                                                  alpha:GreenBlueThemeTextsColorAlpha]];
    // set buttons background color of orange-rose theme
    [greenBlueTheme setButtonsBackgroundColor:[UIColor colorWithRed:GreenBlueThemeButtonsBackgroundColorRed
                                                              green:GreenBlueThemeButtonsBackgroundColorGreen
                                                               blue:GreenBlueThemeButtonsBackgroundColorBlue
                                                              alpha:GreenBlueThemeButtonsBackgroundColorAlpha]];
    // first color of table view cell
    [greenBlueTheme setLevelsTableViewBackgroundColorFirst:[UIColor colorWithRed:GreenBlueThemeLevelsTableViewBackgroundColorFirstRed
                                                                              green:GreenBlueThemeLevelsTableViewBackgroundColorFirstGreen
                                                                               blue:GreenBlueThemeLevelsTableViewBackgroundColorFirstBlue
                                                                              alpha:GreenBlueThemeButtonsBackgroundColorAlpha]];
    // second color of table view cell
    [greenBlueTheme setLevelsTableViewBackgroundColorSecond:[UIColor colorWithRed:GreenBlueThemeLevelsTableViewBackgroundColorSecondRed
                                                                               green:GreenBlueThemeLevelsTableViewBackgroundColorSecondGreen
                                                                                blue:GreenBlueThemeLevelsTableViewBackgroundColorSecondBlue
                                                                               alpha:GreenBlueThemeButtonsBackgroundColorAlpha]];
    // set navigation bar color of orange-rose theme
    [greenBlueTheme setNavigationBarColor:[UIColor colorWithRed:GreenBlueThemeNavigationBarColorRed
                                                          green:GreenBlueThemeNavigationBarColorGreen
                                                           blue:GreenBlueThemeNavigationBarColorBlue
                                                          alpha:GreenBlueThemeNavigationBarColorAlpha]];
    // create bricks images names dictionary and initialize with values
    greenBlueTheme.bricksImageNamesDictionary = [[NSDictionary alloc] init];
    greenBlueTheme.bricksImageNamesDictionary = @{
                                                  [NSNumber numberWithInteger:BrickTypeEmpty] : GreenBlueThemeBrickTypeEmptyImageName,
                                                  [NSNumber numberWithInteger:BrickTypeWithOneLife] : GreenBlueThemeBrickTypeWithOneLifeImageName,
                                                  [NSNumber numberWithInteger:BrickTypeWithTwoLifes] : GreenBlueThemeBrickTypeWithTwoLifesImageName,
                                                  [NSNumber numberWithInteger:BrickTypeWithThreeLifes] : GreenBlueThemeBrickTypeWithThreeLifesImageName,
                                                  [NSNumber numberWithInteger:BrickTypeWithSuperPower] : GreenBlueThemeBrickTypeWithSuperPowerImageName,
                                                  [NSNumber numberWithInteger:BrickTypeWithSuperPowerAttackedOnce] : GreenBlueThemeBrickTypeWithSuperPowerAttackedOnceImageName,
                                                  [NSNumber numberWithInteger:BrickTypeWithSuperPowerAttackedTwice] : GreenBlueThemeBrickTypeWithSuperPowerAttackedTwiceImageName,
                                                  [NSNumber numberWithInteger:BrickTypeWithVisibility] : GreenBlueThemeBrickTypeWithVisibilityImageName,
                                                  };
    // add green-blue theme to shared theme manager
    [[[ThemeManager sharedThemeManager] arrayOfThemes] addObject:greenBlueTheme];
}

@end
