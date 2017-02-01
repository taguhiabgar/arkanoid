//
//  HighestScoreViewController.m
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/16/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import "HighestScoreViewController.h"
#import "GameViewController.h"
#import "ThemeManager.h"
#import "LevelManager.h"
#import "SizeManager.h"
#import "FileManager.h"
#import "Constants.h"

@interface HighestScoreViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property NSString* nameOfLevel;

@end

@implementation HighestScoreViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // set back button
    [self setBackButton];
    // save score and username if needed
    [self saveScoreAndUsername];
    // setup background image
    [self setupBackgroundImageView];
    // setup "Share" button
    [self setupShareButton];
    // setup navigation bar
    [self setTitleOfNavigationBar];
    // setup labels
    [self setupLabels];
}

- (void)showRootViewController
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

// default share
- (void)shareText:(NSString *)text andImage:(UIImage *)image andUrl:(NSURL *)url
{
    NSMutableArray *sharingItems = [NSMutableArray new];
    if (text != nil) {
        [sharingItems addObject:text];
    }
    if (image != nil) {
        [sharingItems addObject:image];
    }
    if (url != nil) {
        [sharingItems addObject:url];
    }
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
}

// "back" button action
- (void)backButtonAction
{
    if (self.mode == WinMode)
    {
        [self.delegate loadNextLevel];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setBackButton
{
    NSString* title = [[NSString alloc] init];
    switch (self.mode) {
        case WinMode:
            title = [NextLevelTitle copy];
            self.nameOfLevel = [[LevelManager sharedLevelManager] nextLevelOfLevel:self.levelName];
            break;
        case LoseMode:
            title = [TryAgainTitle copy];
            self.nameOfLevel = self.levelName;
            break;
        case WatchMode:
            title = [HallOfFameTitle copy];
            break;
        default:
            break;
    }
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction)];
    [self.navigationItem setLeftBarButtonItem:backItem];
}

- (void)saveScoreAndUsername
{
    [[FileManager sharedFileManager] setHighestScore:[self.score integerValue] forLevel:self.levelName andUsername:self.playerName];
}

- (void)shareButtonAction:(id)sender
{
    NSString* text = [NSString stringWithFormat:@"Just got %ld points in \"%@\" level in Arkanoid. What is your high score?",(long)[self score],[self levelName]];
    [self shareText:text andImage:nil andUrl:nil];
}

- (void)setupShareButton
{
    UIBarButtonItem* shareButton = [[UIBarButtonItem alloc] initWithTitle:[ShareButtonTitle copy] style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonAction:)];
    self.navigationItem.rightBarButtonItem = shareButton;
}

- (void)setupLabels
{
    [self setupLabel:self.scoreLabel];
    [self setupLabel:self.nameLabel];
    [self.scoreLabel setText:self.score];
    [self.nameLabel setText:self.playerName];
}

- (void)setupLabel:(UILabel*)label
{
    // set text color
    [label setTextColor:[[[ThemeManager sharedThemeManager] currentTheme] textsColor]];
    // set corner radius
    [[label layer] setCornerRadius:[[SizeManager sharedSizeManager] buttonsCornerRadius]];
}

- (void)setupBackgroundImageView
{
    [[self backgroundImageView] setImage:[UIImage imageNamed:[[SizeManager sharedSizeManager] hallOfFameBackgroundImageName]]];
}

- (void)setTitleOfNavigationBar
{
    if (self.mode == LoseMode)
        [self.navigationItem setTitle:[GameOverText copy]];
    else
        [self.navigationItem setTitle:self.levelName];
    Theme* currentTheme = [[ThemeManager sharedThemeManager] currentTheme];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[currentTheme textsColor]}];
    [[self.navigationController navigationBar] setBarTintColor:[currentTheme navigationBarColor]];
    [[self.navigationController navigationBar] setTintColor:[currentTheme textsColor]];
}

@end
