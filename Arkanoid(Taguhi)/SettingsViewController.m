//
//  SettingsViewController.m
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/7/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SettingsViewController.h"
#import "ThemeManager.h"
#import "SizeManager.h"
#import "Constants.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *themesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *orangeRoseThemeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *yellowOrangeThemeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *greenBlueThemeImageView;
@property (weak, nonatomic) IBOutlet UIButton *yellowOrangeThemeButton;
@property (weak, nonatomic) IBOutlet UIButton *orangeRoseThemeButton;
@property (weak, nonatomic) IBOutlet UIButton *greenBlueThemeButton;

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateView];
    // setup all themes
    [self setupAllThemes];
    // set theme buttons titles
    [self setThemeButtonsTitles];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupThemesLabel];
}

- (void)updateView
{
    // setup navigation bar
    [self setTitleOfNavigationBar];
    // set background image
    [[self backgroundImageView] setImage:[UIImage imageNamed:[[[ThemeManager sharedThemeManager] currentTheme] backgroundImageName]]];
    // setup buttons
    [self setupButtons];
}

- (void)setupButtons
{
    [self setupThemeButton:self.yellowOrangeThemeButton];
    [self setupThemeButton:self.orangeRoseThemeButton];
    [self setupThemeButton:self.greenBlueThemeButton];
}

- (void)setThemeButtonsTitles
{
    [self.yellowOrangeThemeButton setTitle:[[[[ThemeManager sharedThemeManager] arrayOfThemes] objectAtIndex:0] themeTitle] forState:UIControlStateNormal];
    [self.orangeRoseThemeButton setTitle:[[[[ThemeManager sharedThemeManager] arrayOfThemes] objectAtIndex:1] themeTitle] forState:UIControlStateNormal];
    [self.greenBlueThemeButton setTitle:[[[[ThemeManager sharedThemeManager] arrayOfThemes] objectAtIndex:2] themeTitle] forState:UIControlStateNormal];
}

- (void)setupThemeButton:(UIButton*)button
{
    // set corner radius of yellowOrangeThemeButton
    [[button layer] setCornerRadius:[[SizeManager sharedSizeManager] buttonsCornerRadius]];
    // set yellowOrangeThemeButton background color with alpha component
    [button setBackgroundColor:[[[[ThemeManager sharedThemeManager] currentTheme] buttonsBackgroundColor] colorWithAlphaComponent:ButtonsBackgroundColorAlphaComponent]];
    // set yellowOrangeThemeButton title color
    [button setTitleColor:[[[ThemeManager sharedThemeManager] currentTheme] textsColor] forState:UIControlStateNormal];
}

- (IBAction)themeButtonAction:(UIButton *)sender
{
    // change current theme
    [[ThemeManager sharedThemeManager] setCurrentTheme:[[[ThemeManager sharedThemeManager] arrayOfThemes] objectAtIndex:sender.tag]];
    // update view
    [self updateView];
}

- (void)setupAllThemes
{
    [self.yellowOrangeThemeImageView setImage:[UIImage imageNamed:[[[[ThemeManager sharedThemeManager] arrayOfThemes] objectAtIndex:0] backgroundImageName]]];
    [self.orangeRoseThemeImageView setImage:[UIImage imageNamed:[[[[ThemeManager sharedThemeManager] arrayOfThemes] objectAtIndex:1] backgroundImageName]]];
    [self.greenBlueThemeImageView setImage:[UIImage imageNamed:[[[[ThemeManager sharedThemeManager] arrayOfThemes] objectAtIndex:2] backgroundImageName]]];
}

- (void)setupThemesLabel
{
    // set text
    [self.themesLabel setText:[ThemesLabelText copy]];
    // set text color
    [self.themesLabel setTextColor:[UIColor whiteColor]];
}


- (void)setTitleOfNavigationBar {
    [self.navigationItem setTitle:[NavigationBarTitleSettings copy]];
    Theme* currentTheme = [[ThemeManager sharedThemeManager] currentTheme];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[currentTheme textsColor]}];
    [[self.navigationController navigationBar] setBarTintColor:[currentTheme navigationBarColor]];
    [[self.navigationController navigationBar] setTintColor:[currentTheme textsColor]];
}

@end
