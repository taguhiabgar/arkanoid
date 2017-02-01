//
//  LevelGeneratorViewController.m
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/5/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import "LevelGeneratorViewController.h"
#import "LevelManager.h"
#import "ThemeManager.h"
#import "SizeManager.h"
#import "Constants.h"

@interface LevelGeneratorViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *brickWithOneLifeButton;
@property (weak, nonatomic) IBOutlet UIButton *brickWithTwoLifesButton;
@property (weak, nonatomic) IBOutlet UIButton *brickWithThreeLifesButton;
@property (weak, nonatomic) IBOutlet UIButton *brickWithSuperPowerButton;
@property (weak, nonatomic) IBOutlet UIButton *brickWithVisibilityButton;
@property NSMutableArray* matrixOfBrickTypes;
@property NSInteger activeBrickType;

@end

@implementation LevelGeneratorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // initialize matrix of numbers
    self.matrixOfBrickTypes = [[NSMutableArray alloc] init];
    // setup "Save Level" button
    [self setupSaveLevelButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTitleOfNavigationBar];
    // set background image
    [[self backgroundImageView] setImage:[UIImage imageNamed:[[[ThemeManager sharedThemeManager] currentTheme] backgroundImageName]]];
    // remove all objects from matrix of numbers and fill matrix with empty values
    [self emptyMatrixOfNumbers];
    // setup board of bricks
    [self setupBoardOfBricks];
    // brickWithOneLifeButton set active
    [self setActiveButtonWithType:BrickTypeWithOneLife];
    // set active brick type
    self.activeBrickType = BrickTypeWithOneLife;
    // setup bricks at the bottom of view
    [self setupBrickTypes];
}

- (void)setupBrickTypes
{
    // get image name of brick with one life
    NSString* brickWithOneLifeButtonImageName = [[[[ThemeManager sharedThemeManager] currentTheme] bricksImageNamesDictionary] objectForKey:[NSNumber numberWithInteger:BrickTypeWithOneLife]];
    // set image to brick with one life
    [self.brickWithOneLifeButton setBackgroundImage:[UIImage imageNamed:brickWithOneLifeButtonImageName] forState:UIControlStateNormal];
    // get image name of brick with two lifes
    NSString* brickWithTwoLifesButtonImageName = [[[[ThemeManager sharedThemeManager] currentTheme] bricksImageNamesDictionary] objectForKey:[NSNumber numberWithInteger:BrickTypeWithTwoLifes]];
    // set image to brick with two lifes
    [self.brickWithTwoLifesButton setBackgroundImage:[UIImage imageNamed:brickWithTwoLifesButtonImageName] forState:UIControlStateNormal];
    // get image name of brick with three lifes
    NSString* brickWithThreeLifesButtonImageName = [[[[ThemeManager sharedThemeManager] currentTheme] bricksImageNamesDictionary] objectForKey:[NSNumber numberWithInteger:BrickTypeWithThreeLifes]];
    // set image to brick with three lifes
    [self.brickWithThreeLifesButton setBackgroundImage:[UIImage imageNamed:brickWithThreeLifesButtonImageName] forState:UIControlStateNormal];
    // get image name of brick with super power
    NSString* brickWithSuperPowerButtonImageName = [[[[ThemeManager sharedThemeManager] currentTheme] bricksImageNamesDictionary] objectForKey:[NSNumber numberWithInteger:BrickTypeWithSuperPower]];
    // set image to brick with super power
    [self.brickWithSuperPowerButton setBackgroundImage:[UIImage imageNamed:brickWithSuperPowerButtonImageName] forState:UIControlStateNormal];
    // get image name of brick with visibility
    NSString* brickWithVisibilityButtonImageName = [[[[ThemeManager sharedThemeManager] currentTheme] bricksImageNamesDictionary] objectForKey:[NSNumber numberWithInteger:BrickTypeWithVisibility]];
    // set image to brick with visibility
    [self.brickWithVisibilityButton setBackgroundImage:[UIImage imageNamed:brickWithVisibilityButtonImageName] forState:UIControlStateNormal];
}

- (void)saveLevelButtonAction:(id)sender
{
    if ([self matrixIsEmpty])
        // show alert to tell user matrix is empty
        [self showAlertWithTitle:[EmptyLevelTitleString copy] andMessage:[EmptyLevelMessageString copy] andButtonTitle:[OkString copy]];
    else
        // show alert save level
        [self showAlertSaveLevel];
}

- (void)showAlertSaveLevel
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:[SaveLevelString copy] message:[EnterLevelNameString copy] preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
         textField.placeholder = [LevelNamePlaceholder copy];
         textField.textColor = [[[ThemeManager sharedThemeManager] currentTheme] textsColor];
         textField.clearButtonMode = UITextFieldViewModeWhileEditing;
         textField.borderStyle = UITextBorderStyleRoundedRect;
     }];
    [alertController addAction:[UIAlertAction actionWithTitle:[OkString copy] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                                    NSString* textFieldContent = alertController.textFields[0].text;
                                    if ([textFieldContent isEqualToString:[EmptyString copy]]) {
                                        [self showAlertWithTitle:[FailedToSaveTitleString copy] andMessage:[FailedToSaveMessageString copy] andButtonTitle:[OkString copy]];
                                    } else {
                                        BOOL isReservedCustomLevelName = NO;
                                        // get array of custom levels
                                        NSMutableArray<NSString*>* arrayOfCustomLevels = [[LevelManager sharedLevelManager] getCustomLevelsListFromFile];
                                        // for all custom levels
                                        for (NSInteger index = 0; index < [arrayOfCustomLevels count]; index++) {
                                            // if content of text field is existing custom level name
                                            if ([textFieldContent isEqualToString:arrayOfCustomLevels[index]]) {
                                                isReservedCustomLevelName = YES;
                                                [self showAlertWithTitle:[CannotSaveString copy] andMessage:[NSString stringWithFormat:@"You already have a level with name \"%@\"",textFieldContent] andButtonTitle:[OkString copy]];
                                            }
                                        }
                                        if (!isReservedCustomLevelName) {
                                            BOOL isReservedDefaultLevelName = NO;
                                            // get array of default levels
                                            NSMutableArray<NSString*>* arrayOfDefaultLevels = [[LevelManager sharedLevelManager] getDefaultLevelsListFromFile];
                                            // for all default levels
                                            for (NSInteger index = 0; index < [arrayOfDefaultLevels count]; index++) {
                                                // if content of text field is existing default level name
                                                if ([textFieldContent isEqualToString:arrayOfDefaultLevels[index]]) {
                                                    isReservedDefaultLevelName = YES;
                                                    [self showAlertWithTitle:[CannotSaveString copy] andMessage:[NSString stringWithFormat:@"Level name \"%@\" is a reserved name.",textFieldContent] andButtonTitle:[OkString copy]];
                                                }
                                            }
                                            if (!isReservedDefaultLevelName) {
                                                // add custom level in LevelManager
                                                [[LevelManager sharedLevelManager] addCustomLevelWithMatrix:[self.matrixOfBrickTypes copy] withLevelName:textFieldContent];
                                                // dismiss
                                                [self dismissViewControllerAnimated:YES completion:nil];
                                            }
                                        }
                                    }
                                }]];
    [alertController addAction:[UIAlertAction actionWithTitle:[CancelString copy] style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                                    // dismiss
                                    [self dismissViewControllerAnimated:YES completion:nil];
                                }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message andButtonTitle:(NSString*)buttonTitle
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: title message: message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                                    [self dismissViewControllerAnimated:YES completion:nil];
                                }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)brickImageViewAction:(UITapGestureRecognizer*)sender
{
    NSInteger newBrickType = BrickTypeEmpty;
    // calculate row index and column index by sender's tag
    NSInteger rowIndex = sender.view.tag / AmountOfBoardColumns;
    NSInteger columnIndex = sender.view.tag % AmountOfBoardColumns;
    // check if tapped brick is empty
    if ([[[self.matrixOfBrickTypes objectAtIndex:rowIndex] objectAtIndex:columnIndex] isEqualToNumber:[NSNumber numberWithInteger:BrickTypeEmpty]]) {
        newBrickType = self.activeBrickType;
    }
    // write new brick type in matrix
    [[self.matrixOfBrickTypes objectAtIndex:rowIndex] replaceObjectAtIndex:columnIndex withObject:[NSNumber numberWithInteger:newBrickType]];
    // change current brick's background
    UIImageView* tappedImageView = (UIImageView *)sender.view;
    [tappedImageView setImage:[UIImage imageNamed:[[[[ThemeManager sharedThemeManager] currentTheme] bricksImageNamesDictionary] objectForKey:[NSNumber numberWithInteger:newBrickType]]]];
}

- (void)setupBoardOfBricks
{
    CGFloat freeSpaceFromTop = [[SizeManager sharedSizeManager] freeSpaceFromTop];
    CGFloat freeSpaceFromLeft = [[SizeManager sharedSizeManager] freeSpaceFromLeft];
    CGFloat freeSpaceFromRight = [[SizeManager sharedSizeManager] freeSpaceFromRight];
    CGFloat freeSpaceBetweenBricks = [[SizeManager sharedSizeManager] freeSpaceBetweenBricks];
    CGFloat brickSize;
    // calculate brick's width
    brickSize = ([[UIScreen mainScreen] bounds].size.width - freeSpaceFromLeft - freeSpaceFromRight - (AmountOfBoardColumns - 1) * freeSpaceBetweenBricks) / AmountOfBoardColumns;
    // draw all bricks
    for (NSInteger rowIndex = 0; rowIndex < AmountOfBoardRows; rowIndex++) {
        for (NSInteger columnIndex = 0; columnIndex < AmountOfBoardColumns; columnIndex++) {
            // create frame of a single cell
            CGRect brickFrame = CGRectMake(freeSpaceFromLeft + (brickSize + freeSpaceBetweenBricks) * columnIndex, self.navigationController.navigationBar.frame.size.height + 2 * freeSpaceFromTop + (brickSize + freeSpaceBetweenBricks) * rowIndex, brickSize, brickSize);
            // create cell image view
            UIImageView* brickImageView = [[UIImageView alloc] initWithFrame:brickFrame];
            [brickImageView setImage: [UIImage imageNamed: [[[[ThemeManager sharedThemeManager] currentTheme] bricksImageNamesDictionary] objectForKey:[NSNumber numberWithInteger:BrickTypeEmpty]]]];
            [brickImageView setTag:(rowIndex * AmountOfBoardColumns + columnIndex)];
            // create tap gesture recognizer
            UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(brickImageViewAction:)];
            // enable user interaction
            brickImageView.userInteractionEnabled = YES;
            // add tap gesture recognizer to cell image view
            [brickImageView addGestureRecognizer:tapRecognizer];
            // add cell image view to main view
            [self.view addSubview:brickImageView];
        }
    }
}

- (void)setActiveButtonWithType:(NSInteger)buttonType
{
    [self.brickWithOneLifeButton setAlpha:((buttonType == BrickTypeWithOneLife) ? ActiveButtonAlpha : InactiveButtonAlpha)];
    [self.brickWithTwoLifesButton setAlpha:((buttonType == BrickTypeWithTwoLifes) ? ActiveButtonAlpha : InactiveButtonAlpha)];
    [self.brickWithThreeLifesButton setAlpha:((buttonType == BrickTypeWithThreeLifes) ? ActiveButtonAlpha : InactiveButtonAlpha)];
    [self.brickWithSuperPowerButton setAlpha:((buttonType == BrickTypeWithSuperPower) ? ActiveButtonAlpha : InactiveButtonAlpha)];
    [self.brickWithVisibilityButton setAlpha:((buttonType == BrickTypeWithVisibility) ? ActiveButtonAlpha : InactiveButtonAlpha)];
    // set active brick type
    [self setActiveBrickType:buttonType];
}

// fills matrix with empty values
- (void)emptyMatrixOfNumbers
{
    // remove all objects from matrix of numbers
    [self.matrixOfBrickTypes removeAllObjects];
    // fill matrix with empty values
    for (NSInteger rowIndex = 0; rowIndex < AmountOfBoardRows; rowIndex++) {
        NSMutableArray* currentRow = [[NSMutableArray alloc] init];
        for (NSInteger columnIndex = 0; columnIndex < AmountOfBoardColumns; columnIndex++)
            [currentRow addObject:[NSNumber numberWithInteger:BrickTypeEmpty]];
        [self.matrixOfBrickTypes addObject:currentRow];
    }
}

// check if matrix is empty
- (BOOL)matrixIsEmpty
{
    for (NSInteger rowIndex = 0; rowIndex < AmountOfBoardRows; rowIndex++)
        for (NSInteger columnIndex = 0; columnIndex < AmountOfBoardColumns; columnIndex++)
            if (!([self.matrixOfBrickTypes[rowIndex][columnIndex] isEqualToNumber:[NSNumber numberWithInteger:BrickTypeEmpty]]))
                return NO;
    return YES;
}

- (void)setupSaveLevelButton
{
    UIBarButtonItem* saveLevelButton = [[UIBarButtonItem alloc] initWithTitle:[SaveLevelButtonTitle copy] style:UIBarButtonItemStylePlain target:self action:@selector(saveLevelButtonAction:)];
    self.navigationItem.rightBarButtonItem = saveLevelButton;
}

- (IBAction)brickWithOneLifeButtonAction:(UIButton *)sender
{
    [self setActiveButtonWithType:BrickTypeWithOneLife];
}

- (IBAction)brickWithTwoLifesButtonAction:(UIButton *)sender
{
    [self setActiveButtonWithType:BrickTypeWithTwoLifes];
}

- (IBAction)brickWithThreeLifesButtonAction:(UIButton *)sender
{
    [self setActiveButtonWithType:BrickTypeWithThreeLifes];
}

- (IBAction)brickWithSuperPowerButtonAction:(UIButton *)sender
{
    [self setActiveButtonWithType:BrickTypeWithSuperPower];
}

- (IBAction)brickWithVisibilityButtonAction:(UIButton *)sender
{
    [self setActiveButtonWithType:BrickTypeWithVisibility];
}

- (void)setTitleOfNavigationBar
{
    [self.navigationItem setTitle:[NavigationBarTitleLevelGenerator copy]];
    Theme* currentTheme = [[ThemeManager sharedThemeManager] currentTheme];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[currentTheme textsColor]}];
    [[self.navigationController navigationBar] setBarTintColor:[currentTheme navigationBarColor]];
    [[self.navigationController navigationBar] setTintColor:[currentTheme textsColor]];
}

@end
