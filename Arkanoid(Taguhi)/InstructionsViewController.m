//
//  InstructionsViewController.m
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/2/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import "InstructionsViewController.h"
#import "ThemeManager.h"
#import "SizeManager.h"
#import "Constants.h"

@interface InstructionsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation InstructionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleOfNavigationBar];
    [[self backgroundImageView] setImage:[UIImage imageNamed:[[SizeManager sharedSizeManager] instructionsImageName]]];
}

- (void)setTitleOfNavigationBar {
    [self.navigationItem setTitle:[NavigationBarTitleInstructions copy]];
    Theme* currentTheme = [[ThemeManager sharedThemeManager] currentTheme];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[currentTheme textsColor]}];
    [[self.navigationController navigationBar] setBarTintColor:[currentTheme navigationBarColor]];
    [[self.navigationController navigationBar] setTintColor:[currentTheme textsColor]];
}

@end
