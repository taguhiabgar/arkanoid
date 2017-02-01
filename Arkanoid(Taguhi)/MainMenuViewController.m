//
//  MainMenuViewController.m
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/2/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import "MainMenuViewController.h"
#import "LevelsViewController.h"
#import "ThemeManager.h"
#import "SizeManager.h"
#import "Constants.h"

@interface MainMenuViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UIButton *hallOfFameButton;
@property (weak, nonatomic) IBOutlet UIButton *instructionsButton;
@property (weak, nonatomic) IBOutlet UIButton *levelGeneratorButton;
@property TableViewMode mode;

@end

@implementation MainMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // set main view frame in SizeManager
    [[SizeManager sharedSizeManager] setViewFrame:self.view.frame];
    // set navigation bar height in SizeManager
    [[SizeManager sharedSizeManager] setNavigationBarHeight:self.navigationController.navigationBar.frame.size.height];
    // setup themes in Theme Manager
    [[ThemeManager sharedThemeManager] setupThemes];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateView];
}

- (void)updateView
{
    // setup buttons
    [self setupButtons];
    // setup navigation bar
    [self setupNavigationBar];
    // set background image
    [[self backgroundImageView] setImage:[UIImage imageNamed:[[[ThemeManager sharedThemeManager] currentTheme] backgroundImageName]]];
}

- (void)setupButtons
{
    // create empty array of buttons
    NSMutableArray <UIButton *> * arrayOfButtons = [[NSMutableArray alloc] init];
    // add all buttons to arrayOfButtons
    [arrayOfButtons addObject:self.playButton];
    [arrayOfButtons addObject:self.settingsButton];
    [arrayOfButtons addObject:self.hallOfFameButton];
    [arrayOfButtons addObject:self.instructionsButton];
    [arrayOfButtons addObject:self.levelGeneratorButton];
    // for all buttons
    for (NSInteger index = 0; index < [arrayOfButtons count]; index++) {
        // set corner radius of current button
        [[arrayOfButtons[index] layer] setCornerRadius:[[SizeManager sharedSizeManager] buttonsCornerRadius]];
        // set current button background color with alpha component
        [arrayOfButtons[index] setBackgroundColor:[[[[ThemeManager sharedThemeManager] currentTheme] buttonsBackgroundColor] colorWithAlphaComponent:ButtonsBackgroundColorAlphaComponent]];
        // set current button title color
        [arrayOfButtons[index] setTitleColor:[[[ThemeManager sharedThemeManager] currentTheme] textsColor] forState:UIControlStateNormal];
        // set current button font size
        [arrayOfButtons[index].titleLabel setFont:[UIFont systemFontOfSize:[[SizeManager sharedSizeManager] buttonsFontSize]]];
    }
}

- (IBAction)playButtonAction:(UIButton *)sender
{
    self.mode = LevelsMode;
    [self performSegueWithIdentifier:[SegueIdentifierShowLevelsVC copy] sender:self];
}

- (IBAction)settingsButtonAction:(UIButton *)sender
{
    [self performSegueWithIdentifier:[SegueIdentifierShowSettingsVC copy] sender:self];
}

- (IBAction)hallOfFameButtonAction:(UIButton *)sender
{
    self.mode = HallOfFameMode;
    [self performSegueWithIdentifier:[SegueIdentifierShowLevelsVC copy] sender:self];
}

- (IBAction)instructionsButtonAction:(UIButton *)sender
{
    [self performSegueWithIdentifier:[SegueIdentifierShowInstructionsVC copy] sender:self];
}

- (IBAction)levelGeneratorButtonAction:(UIButton *)sender
{
    [self performSegueWithIdentifier:[SegueIdentifierShowLevelGeneratorVC copy] sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:[SegueIdentifierShowLevelsVC copy]])
    {
        LevelsViewController* levelsVC = segue.destinationViewController;
        levelsVC.mode = self.mode;
    }
}

- (void)setupNavigationBar
{
    // set title text
    [self.navigationItem setTitle:[NavigationBarTitle copy]];
    Theme* currentTheme = [[ThemeManager sharedThemeManager] currentTheme];
    // set title color
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[currentTheme textsColor]}];
    // set bar background color
    [[self.navigationController navigationBar] setBarTintColor:[currentTheme navigationBarColor]];
    // set tint color
    [[self.navigationController navigationBar] setTintColor:[currentTheme textsColor]];
}

@end
