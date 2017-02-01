//
//  Constants.h
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/5/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import <UIKit/UIKit.h>

// ------------------------------------------------------------------------------------------------
// --- Global Constants ---------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------

// bricks types
typedef NS_ENUM(NSInteger, BrickType) {
    BrickTypeEmpty,
    BrickTypeWithOneLife,
    BrickTypeWithTwoLifes,
    BrickTypeWithThreeLifes,
    BrickTypeWithSuperPower,
    BrickTypeWithVisibility,
    BrickTypeWithSuperPowerAttackedOnce,
    BrickTypeWithSuperPowerAttackedTwice
};

// walls types
typedef NS_ENUM(NSInteger, WallType) {
    RightWall,
    LeftWall,
    TopWall,
    BottomWall,
    Platform,
    NoWall
};

// table view modes
typedef NS_ENUM(NSInteger, TableViewMode) {
    HallOfFameMode,
    LevelsMode,
};

// HighestScoreViewController modes
typedef NS_ENUM(NSInteger, HighestScoreMode) {
    WinMode,
    LoseMode,
    WatchMode,
};

// board
static const NSInteger AmountOfBoardRows = 10;
static const NSInteger AmountOfBoardColumns = 10;

// score
static const NSInteger ScoreStartingValue = 0;

// lives
static const NSInteger LivesStartingValue = 3;

// ball image name
static const NSString* BallImageName = @"whiteBall";

// score for bricks
static const NSInteger ScoreForBrickWithOneLife = 1;
static const NSInteger ScoreForBrickWithTwoLifes = 2;
static const NSInteger ScoreForBrickWithThreeLifes = 3;
static const NSInteger ScoreForBrickWithSuperPower = 4;
static const NSInteger ScoreForBrickWithSuperPowerAttackedOnce = 3;
static const NSInteger ScoreForBrickWithSuperPowerAttackedTwice = 2;
static const NSInteger ScoreForBrickWithVisibility = 2;

// ------------------------------------------------------------------------------------------------
// --- Buttons Constants --------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------

// buttons background color alpha component
static const CGFloat ButtonsBackgroundColorAlphaComponent = 0.7;

// ------------------------------------------------------------------------------------------------
// --- Game View Controller Constants -------------------------------------------------------------
// ------------------------------------------------------------------------------------------------

// popup
static const NSString* PopupMessage = @"";
static const NSString* PopupNewLevelButtonTitle = @"Start New";
static const NSString* PopupLoadLevelButtonTitle = @"Load Saved";

// score label
static const NSString* ScoreLabelText = @"Score: ";

// lives label
static const NSString* LivesLabelText = @"Lives: ";

// explode brick
static CGFloat BrickExplodeDuration = 0.2;
static CGFloat BrickExplodeDelay = 0.0;

// appear brick
static CGFloat BrickAppearDuration = 0.35;
static const CGFloat CoeffficientForBrickAppearDelay = 200.0;

// segue identifier
static const NSString* ScoreSegueIdentifier = @"ScoreSegueIdentifier";

// counter for tap on main view
static NSInteger counter = 0;

// alert >> enter user name
static const NSString* OkTitle = @"OK";
static const NSString* EndOfGameString = @"End of game";
static const NSString* EnterNameString = @"Enter your name";
static const NSString* YourNameString = @"Your name";

// ------------------------------------------------------------------------------------------------
// --- Main Menu View Controller Constants --------------------------------------------------------
// ------------------------------------------------------------------------------------------------

// segue identifiers
static const NSString* SegueIdentifierShowLevelsVC = @"ShowLevelsViewController";
static const NSString* SegueIdentifierShowSettingsVC = @"ShowSettingsViewController";
static const NSString* SegueIdentifierShowInstructionsVC = @"ShowInstructionsViewController";
static const NSString* SegueIdentifierShowLevelGeneratorVC = @"ShowLevelGeneratorViewController";

// navigation bar title
static const NSString* NavigationBarTitle = @"Menu";

// ------------------------------------------------------------------------------------------------
// --- Level Generator View Controller Constants --------------------------------------------------
// ------------------------------------------------------------------------------------------------

// navigation bar title
static const NSString* NavigationBarTitleLevelGenerator = @"Level Generator";

// active button alpha
static const CGFloat ActiveButtonAlpha = 1.0;

// inactive button alpha
static const CGFloat InactiveButtonAlpha = 0.3;

// title of "Save Level" button
static const NSString* SaveLevelButtonTitle = @"Save";

// empty string
static const NSString* EmptyString = @"";

// alert actions titles
static const NSString* OkString = @"OK";
static const NSString* CancelString = @"Cancel";

// alert >> empty level
static const NSString* EmptyLevelTitleString = @"Empty Level";
static const NSString* EmptyLevelMessageString = @"Please ensure that the level contains at least one brick.";

// alert >> save level
static const NSString* SaveLevelString = @"Save Level";
static const NSString* EnterLevelNameString = @"Enter a name for the level";
static const NSString* LevelNamePlaceholder = @"level name";

// alert >> failed to save
static const NSString* FailedToSaveTitleString = @"Failed To Save";
static const NSString* FailedToSaveMessageString = @"Level name is required.";
static const NSString* CannotSaveString = @"Can't Save";

// ------------------------------------------------------------------------------------------------
// --- Levels View Controller Constants -----------------------------------------------------------
// ------------------------------------------------------------------------------------------------

static const NSString* NavigationBarTitleLevels = @"Levels";
static const NSString* NavigationBarTitleHallOfFame = @"Hall Of Fame";
static const NSString* TableViewCellNibName = @"LevelsTableViewCell";
static const NSString* SegueIdentifierShowGameVC = @"GameSegueIdentifier";
static const NSString* SegueIdentifierShowHighestScoreVC = @"HallOfFameSegueIdentifier";
static const NSString* CellReuseIdentifier = @"reuse";
static const NSString* CustomLevelsSectionName = @"Custom Levels";
static const NSString* DefaultLevelsSectionName =@"Default Levels";
static const NSInteger SectionIndexCustomLevels = 0;

// ------------------------------------------------------------------------------------------------
// --- Highest Score View Controller Constants ----------------------------------------------------
// ------------------------------------------------------------------------------------------------

// share button
static const NSString* ShareButtonTitle = @"Share";

// game over
static const NSString* GameOverText = @"Game Over";

// back button titles
static const NSString* TryAgainTitle = @"Try Again";
static const NSString* NextLevelTitle = @"Next Level";
static const NSString* HallOfFameTitle = @"Hall Of Fame";

// ------------------------------------------------------------------------------------------------
// --- Settings View Controller Constants ---------------------------------------------------------
// ------------------------------------------------------------------------------------------------

static const NSString* NavigationBarTitleSettings = @"Settings";
static const NSString* ThemesLabelText = @"Themes";

// ------------------------------------------------------------------------------------------------
// --- Instructions View Controller Constants -----------------------------------------------------
// ------------------------------------------------------------------------------------------------

static const NSString* NavigationBarTitleInstructions = @"Instructions";

// ------------------------------------------------------------------------------------------------
// --- ThemeManagerConstants.h
// ------------------------------------------------------------------------------------------------

// maximum value of color in RGB format
static const CGFloat MaximumValueOfRGB = 255.0;

// ------------------------------------------------------------------------------------------------
// --- Ball Manager Constants ---------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------

// ball velocity
static const CGFloat BallVelocity = 300.0;

// ball animation delay
static const CGFloat BallAnimationDelay = 0.0;

// ------------------------------------------------------------------------------------------------
// --- Size Manager Constants ---------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------

// iPhone device name
static const NSString* IPhoneDeviceName = @"iPhone";

// ball size
static const CGFloat BallSizeForIPhone = 23;
static const CGFloat BallSizeForIPad = 30;

// platform width
static const CGFloat PlatformWidthForIPhone = 100;
static const CGFloat PlatformWidthForIPad = 150;

// platform height
static const CGFloat PlatformHeightForIPhone = 10;
static const CGFloat PlatformHeightForIPad = 20;

// free space from bottom
static const CGFloat FreeSpaceFromBottomForPlatformForIPhone = 30.0;
static const CGFloat FreeSpaceFromBottomForPlatformForIPad = 100.0;

// margins of bricks' grid for iPhone
static const CGFloat FreeSpaceForBricksFromLeftForIPhone = 20.0;
static const CGFloat FreeSpaceForBricksFromRightForIPhone = 20.0;
static const CGFloat FreeSpaceForBricksFromTopForIPhone = 20.0;
static const CGFloat FreeSpaceForBricksFromBottomForIPhone = 20.0;
static const CGFloat FreeSpaceBetweenBricksForIPhone = 2.0;

// margins of bricks' grid for iPad
static const CGFloat FreeSpaceForBricksFromLeftForIPad = 150.0;
static const CGFloat FreeSpaceForBricksFromRightForIPad = 150.0;
static const CGFloat FreeSpaceForBricksFromTopForIPad = 50.0;
static const CGFloat FreeSpaceForBricksFromBottomForIPad = 50.0;
static const CGFloat FreeSpaceBetweenBricksForIPad = 5.0;

// buttons corner radius
static const CGFloat ButtonsCornerRadiusForIPhone = 14.0;
static const CGFloat ButtonsCornerRadiusForIPad = 35.0;

// buttons font size
static const CGFloat ButtonsFontSizeForIPhone = 20.0;
static const CGFloat ButtonsFontSizeForIPad = 32.0;

// ------------------------------------------------------------------------------------------------
// --- File Manager Constants ---------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------

static const NSString* FileNameOfCustomLevelsList = @"CustomLevelsListFile";
static const NSString* FileNameOfDefaultLevelsList = @"DefaultLevelsListFile";
static const NSString* HighestScoreString = @"HighestScore";
static const NSString* UsernameString = @"Username";
static const NSString* NoUsernameString = @"No One";

// ------------------------------------------------------------------------------------------------
// --- Level Manager Constants --------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------

static const NSInteger AmountOfDefaultLevels = 10;
static const NSString* DefaultLevelNameBeginning = @"Level ";

// ------------------------------------------------------------------------------------------------
// --- Platform Manager Constants -----------------------------------------------------------------
// ------------------------------------------------------------------------------------------------

static const CGFloat Epsilon = 3.0;
static const CGFloat CoefficientForHeight = 15.0;
static const CGFloat CoefficientForDirectionVector = 10.0;

// ------------------------------------------------------------------------------------------------
// --- Yellow-Orange Theme Constants --------------------------------------------------------------
// ------------------------------------------------------------------------------------------------

// background image name
static const NSString* YellowOrangeThemeBackgroundImageName = @"yellow_orange";

// instructions image name for iPhone
static const NSString* YellowOrangeThemeInstructionsImageNameIPhone = @"YellowOrangeInstructionsIphone";

// instructions image name for iPad
static const NSString* YellowOrangeThemeInstructionsImageNameIPad = @"YellowOrangeInstructionsIpad";

// hall of fame background image name for iPhone
static const NSString* YellowOrangeThemeHallOfFameBackgroundImageNameIPhone = @"iPhoneHallOfFameYellowOrange";

// hall of fame background image name for iPad
static const NSString* YellowOrangeThemeHallOfFameBackgroundImageNameIPad = @"iPadHallOfFameYellowOrange";

// platform image name
static const NSString* YellowOrangeThemePlatformImageName = @"YellowOrangeBrick0";

// theme title
static const NSString* YellowOrangeThemeTitle = @"Yellow-Orange";

// texts color
static const CGFloat YellowOrangeThemeTextsColorRed = 220.0 / MaximumValueOfRGB;
static const CGFloat YellowOrangeThemeTextsColorGreen = 20.0 / MaximumValueOfRGB;
static const CGFloat YellowOrangeThemeTextsColorBlue = 60.0 / MaximumValueOfRGB;
static const CGFloat YellowOrangeThemeTextsColorAlpha = 1.0;

// buttons background color
static const CGFloat YellowOrangeThemeButtonsBackgroundColorRed = 248.0 / MaximumValueOfRGB;
static const CGFloat YellowOrangeThemeButtonsBackgroundColorGreen = 248.0 / MaximumValueOfRGB;
static const CGFloat YellowOrangeThemeButtonsBackgroundColorBlue = 255.0 / MaximumValueOfRGB;
static const CGFloat YellowOrangeThemeButtonsBackgroundColorAlpha = 1.0;

// navigation bar color
static const CGFloat YellowOrangeThemeNavigationBarColorRed = 255.0 / MaximumValueOfRGB;
static const CGFloat YellowOrangeThemeNavigationBarColorGreen = 228.0 / MaximumValueOfRGB;
static const CGFloat YellowOrangeThemeNavigationBarColorBlue = 225.0 / MaximumValueOfRGB;
static const CGFloat YellowOrangeThemeNavigationBarColorAlpha = 1.0;

// levels table view cell color first
static const CGFloat YellowOrangeThemeLevelsTableViewBackgroundColorFirstRed = 255.0 / MaximumValueOfRGB;
static const CGFloat YellowOrangeThemeLevelsTableViewBackgroundColorFirstGreen = 246.0 / MaximumValueOfRGB;
static const CGFloat YellowOrangeThemeLevelsTableViewBackgroundColorFirstBlue = 143.0 / MaximumValueOfRGB;

// levels table view cell color second
static const CGFloat YellowOrangeThemeLevelsTableViewBackgroundColorSecondRed = 255.0 / MaximumValueOfRGB;
static const CGFloat YellowOrangeThemeLevelsTableViewBackgroundColorSecondGreen = 255.0 / MaximumValueOfRGB;
static const CGFloat YellowOrangeThemeLevelsTableViewBackgroundColorSecondBlue = 224.0 / MaximumValueOfRGB;

// brick type image names
static const NSString* YellowOrangeThemeBrickTypeEmptyImageName = @"YellowOrangeBrick0";
static const NSString* YellowOrangeThemeBrickTypeWithOneLifeImageName = @"YellowOrangeBrick1";
static const NSString* YellowOrangeThemeBrickTypeWithTwoLifesImageName = @"YellowOrangeBrick2";
static const NSString* YellowOrangeThemeBrickTypeWithThreeLifesImageName = @"YellowOrangeBrick3";
static const NSString* YellowOrangeThemeBrickTypeWithSuperPowerImageName = @"YellowOrangeBrick4";
static const NSString* YellowOrangeThemeBrickTypeWithSuperPowerAttackedOnceImageName = @"YellowOrangeBrick5";
static const NSString* YellowOrangeThemeBrickTypeWithSuperPowerAttackedTwiceImageName = @"YellowOrangeBrick6";
static const NSString* YellowOrangeThemeBrickTypeWithVisibilityImageName = @"YellowOrangeBrick7";

// ------------------------------------------------------------------------------------------------
// --- Orange-Rose Theme Constants ----------------------------------------------------------------
// ------------------------------------------------------------------------------------------------

// background image name
static const NSString* OrangeRoseThemeBackgroundImageName = @"orange_rose";

// instructions image name for iPhone
static const NSString* OrangeRoseThemeInstructionsImageNameIPhone = @"OrangeRoseInstructionsIphone";

// instructions image name for iPad
static const NSString* OrangeRoseThemeInstructionsImageNameIPad = @"OrangeRoseInstructionsIpad";

// hall of fame background image name for iPhone
static const NSString* OrangeRoseThemeHallOfFameBackgroundImageNameIPhone = @"iPhoneHallOfFameOrangeRose";

// hall of fame background image name for iPad
static const NSString* OrangeRoseThemeHallOfFameBackgroundImageNameIPad = @"iPadHallOfFameOrangeRose";

// platform image name
static const NSString* OrangeRoseThemePlatformImageName = @"OrangeRoseBrick0";

// theme title
static const NSString* OrangeRoseThemeTitle = @"Orange-Rose";

// texts color
static const CGFloat OrangeRoseThemeTextsColorRed = 220.0 / MaximumValueOfRGB;
static const CGFloat OrangeRoseThemeTextsColorGreen = 20.0 / MaximumValueOfRGB;
static const CGFloat OrangeRoseThemeTextsColorBlue = 60.0 / MaximumValueOfRGB;
static const CGFloat OrangeRoseThemeTextsColorAlpha = 1.0;

// buttons background color
static const CGFloat OrangeRoseThemeButtonsBackgroundColorRed = 248.0 / MaximumValueOfRGB;
static const CGFloat OrangeRoseThemeButtonsBackgroundColorGreen = 248.0 / MaximumValueOfRGB;
static const CGFloat OrangeRoseThemeButtonsBackgroundColorBlue = 255.0 / MaximumValueOfRGB;
static const CGFloat OrangeRoseThemeButtonsBackgroundColorAlpha = 1.0;

// navigation bar color
static const CGFloat OrangeRoseThemeNavigationBarColorRed = 216.0 / MaximumValueOfRGB;
static const CGFloat OrangeRoseThemeNavigationBarColorGreen = 192.0 / MaximumValueOfRGB;
static const CGFloat OrangeRoseThemeNavigationBarColorBlue = 216.0 / MaximumValueOfRGB;
static const CGFloat OrangeRoseThemeNavigationBarColorAlpha = 1.0;

// levels table view cell color first
static const CGFloat OrangeRoseThemeLevelsTableViewBackgroundColorFirstRed = 238.0 / MaximumValueOfRGB;
static const CGFloat OrangeRoseThemeLevelsTableViewBackgroundColorFirstGreen = 224.0 / MaximumValueOfRGB;
static const CGFloat OrangeRoseThemeLevelsTableViewBackgroundColorFirstBlue = 229.0 / MaximumValueOfRGB;

// levels table view cell color second
static const CGFloat OrangeRoseThemeLevelsTableViewBackgroundColorSecondRed = 255.0 / MaximumValueOfRGB;
static const CGFloat OrangeRoseThemeLevelsTableViewBackgroundColorSecondGreen = 182.0 / MaximumValueOfRGB;
static const CGFloat OrangeRoseThemeLevelsTableViewBackgroundColorSecondBlue = 193.0 / MaximumValueOfRGB;

// brick type image names
static const NSString* OrangeRoseThemeBrickTypeEmptyImageName = @"OrangeRoseBrick0";
static const NSString* OrangeRoseThemeBrickTypeWithOneLifeImageName = @"OrangeRoseBrick1";
static const NSString* OrangeRoseThemeBrickTypeWithTwoLifesImageName = @"OrangeRoseBrick2";
static const NSString* OrangeRoseThemeBrickTypeWithThreeLifesImageName = @"OrangeRoseBrick3";
static const NSString* OrangeRoseThemeBrickTypeWithSuperPowerImageName = @"OrangeRoseBrick4";
static const NSString* OrangeRoseThemeBrickTypeWithSuperPowerAttackedOnceImageName = @"OrangeRoseBrick5";
static const NSString* OrangeRoseThemeBrickTypeWithSuperPowerAttackedTwiceImageName = @"OrangeRoseBrick6";
static const NSString* OrangeRoseThemeBrickTypeWithVisibilityImageName = @"OrangeRoseBrick7";


// ------------------------------------------------------------------------------------------------
// --- Green-Blue Theme Constants -----------------------------------------------------------------
// ------------------------------------------------------------------------------------------------

// background image name
static const NSString* GreenBlueThemeBackgroundImageName = @"green_blue";

// instructions image name for iPhone
static const NSString* GreenBlueThemeInstructionsImageNameIPhone = @"GreenBlueInstructionsIphone";

// instructions image name for iPad
static const NSString* GreenBlueThemeInstructionsImageNameIPad = @"GreenBlueInstructionsIpad";

// hall of fame background image name for iPhone
static const NSString* GreenBlueThemeHallOfFameBackgroundImageNameIPhone = @"iPhoneHallOfFameGreenBlue";

// hall of fame background image name for iPad
static const NSString* GreenBlueThemeHallOfFameBackgroundImageNameIPad = @"iPadHallOfFameGreenBlue";

// platform image name
static const NSString* GreenBlueThemePlatformImageName = @"GreenBlueBrick0";

// theme title
static const NSString* GreenBlueThemeTitle = @"Green-Blue";

// texts color
static const CGFloat GreenBlueThemeTextsColorRed = 0.0 / MaximumValueOfRGB;
static const CGFloat GreenBlueThemeTextsColorGreen = 0.0 / MaximumValueOfRGB;
static const CGFloat GreenBlueThemeTextsColorBlue = 139.0 / MaximumValueOfRGB;
static const CGFloat GreenBlueThemeTextsColorAlpha = 1.0;

// buttons background color
static const CGFloat GreenBlueThemeButtonsBackgroundColorRed = 240.0 / MaximumValueOfRGB;
static const CGFloat GreenBlueThemeButtonsBackgroundColorGreen = 255.0 / MaximumValueOfRGB;
static const CGFloat GreenBlueThemeButtonsBackgroundColorBlue = 255.0 / MaximumValueOfRGB;
static const CGFloat GreenBlueThemeButtonsBackgroundColorAlpha = 1.0;

// navigation bar color
static const CGFloat GreenBlueThemeNavigationBarColorRed = 255.0 / MaximumValueOfRGB;
static const CGFloat GreenBlueThemeNavigationBarColorGreen = 255.0 / MaximumValueOfRGB;
static const CGFloat GreenBlueThemeNavigationBarColorBlue = 255.0 / MaximumValueOfRGB;
static const CGFloat GreenBlueThemeNavigationBarColorAlpha = 0.4;

// levels table view cell color first
static const CGFloat GreenBlueThemeLevelsTableViewBackgroundColorFirstRed = 240.0 / MaximumValueOfRGB;
static const CGFloat GreenBlueThemeLevelsTableViewBackgroundColorFirstGreen = 255.0 / MaximumValueOfRGB;
static const CGFloat GreenBlueThemeLevelsTableViewBackgroundColorFirstBlue = 240.0 / MaximumValueOfRGB;

// levels table view cell color second
static const CGFloat GreenBlueThemeLevelsTableViewBackgroundColorSecondRed = 198.0 / MaximumValueOfRGB;
static const CGFloat GreenBlueThemeLevelsTableViewBackgroundColorSecondGreen = 226.0 / MaximumValueOfRGB;
static const CGFloat GreenBlueThemeLevelsTableViewBackgroundColorSecondBlue = 255.0 / MaximumValueOfRGB;

// brick type image names
static const NSString* GreenBlueThemeBrickTypeEmptyImageName = @"GreenBlueBrick0";
static const NSString* GreenBlueThemeBrickTypeWithOneLifeImageName = @"GreenBlueBrick1";
static const NSString* GreenBlueThemeBrickTypeWithTwoLifesImageName = @"GreenBlueBrick2";
static const NSString* GreenBlueThemeBrickTypeWithThreeLifesImageName = @"GreenBlueBrick3";
static const NSString* GreenBlueThemeBrickTypeWithSuperPowerImageName = @"GreenBlueBrick4";
static const NSString* GreenBlueThemeBrickTypeWithSuperPowerAttackedOnceImageName = @"GreenBlueBrick5";
static const NSString* GreenBlueThemeBrickTypeWithSuperPowerAttackedTwiceImageName = @"GreenBlueBrick6";
static const NSString* GreenBlueThemeBrickTypeWithVisibilityImageName = @"GreenBlueBrick7";









