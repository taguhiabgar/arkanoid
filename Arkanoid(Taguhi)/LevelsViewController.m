//
//  LevelsViewController.m
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/5/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import "LevelsViewController.h"
#import "GameViewController.h"
#import "HighestScoreViewController.h"
#import "LevelsTableViewCell.h"
#import "LevelManager.h"
#import "ThemeManager.h"
#import "FileManager.h"
#import "Constants.h"

@interface LevelsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *levelsTableView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property NSMutableArray* levelsTableViewData;

@end

@implementation LevelsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavigationBar];
    // set background image
    [[self backgroundImageView] setImage:[UIImage imageNamed:[[[ThemeManager sharedThemeManager] currentTheme] backgroundImageName]]];
    NSString* levelsTableViewCellNib = [TableViewCellNibName copy];
    // register custom table view cell
    [self.levelsTableView registerNib:[UINib nibWithNibName:levelsTableViewCellNib bundle:nil] forCellReuseIdentifier:[CellReuseIdentifier copy]];
    [self fillLevelsTableViewData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* levelName = self.levelsTableViewData[indexPath.section][indexPath.row];
    UIColor* backgroundViewColor = (indexPath.row % 2 == 0) ? [[[ThemeManager sharedThemeManager] currentTheme] levelsTableViewBackgroundColorFirst] : [[[ThemeManager sharedThemeManager] currentTheme] levelsTableViewBackgroundColorSecond];
    UIColor* textsColor = [[[ThemeManager sharedThemeManager] currentTheme] textsColor];
    LevelsTableViewCell* cell = (LevelsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[CellReuseIdentifier copy]];
    if(cell == nil)
        cell = [[[NSBundle mainBundle] loadNibNamed:[TableViewCellNibName copy] owner:nil options:nil] objectAtIndex: 0];
    [cell setLevelName:levelName];
    cell.backgroundViewColor = backgroundViewColor;
    [cell.levelNameLabel setTextColor:textsColor];
    return cell;
}

- (void)fillLevelsTableViewData
{
    self.levelsTableViewData = [[NSMutableArray alloc] init];
    // get array of custom levels
    NSMutableArray<NSString*>* customLevelsArray = [[LevelManager sharedLevelManager] getCustomLevelsListFromFile];
    if (customLevelsArray == nil)
        customLevelsArray = [[NSMutableArray alloc] init];
    // add custom levels array to table view data
    [self.levelsTableViewData addObject:customLevelsArray];
    // get array of default levels
    NSMutableArray<NSString*>* defaultLevelsArray = [[LevelManager sharedLevelManager] getDefaultLevelsListFromFile];
    if (defaultLevelsArray == nil)
        defaultLevelsArray = [[NSMutableArray alloc] init];
    // add default levels array to table view data
    [self.levelsTableViewData addObject:defaultLevelsArray];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.levelsTableViewData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.levelsTableViewData[section] count];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel* label = [[UILabel alloc] init];
    label.text = (section == SectionIndexCustomLevels) ? [CustomLevelsSectionName copy] : [DefaultLevelsSectionName copy];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:[[[ThemeManager sharedThemeManager] currentTheme] textsColor]];
    [label setTextColor:[UIColor whiteColor]];
    return label;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.levelsTableViewData[indexPath.section] removeObjectAtIndex:indexPath.row];
    [self.levelsTableView reloadData];
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *) indexPath
{
    if (indexPath.section == SectionIndexCustomLevels) {
        // "delete" action for cells of custom levels section
        UITableViewRowAction* actionDelete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath)
        {
            // remove selected level
            [[LevelManager sharedLevelManager] removeCustomLevelWithName:self.levelsTableViewData[indexPath.section][indexPath.row]];
            // remove level name from table view data
            [self.levelsTableViewData[indexPath.section] removeObjectAtIndex:indexPath.row];
            // reload data
            [self.levelsTableView reloadData];
        }];
        return @[actionDelete];
    } else {
        // no action for cells of default levels section
        return @[];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.mode == HallOfFameMode)
        // show HighestScoreViewController
        [self performSegueWithIdentifier:[SegueIdentifierShowHighestScoreVC copy] sender:self];
    else
        // show GameViewController
        [self performSegueWithIdentifier:[SegueIdentifierShowGameVC copy] sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (self.mode == HallOfFameMode)
    {
        HighestScoreViewController* highestScoreVC = segue.destinationViewController;
        NSIndexPath *selectedPath = [self.levelsTableView indexPathForSelectedRow];
        NSString* levelName = self.levelsTableViewData[selectedPath.section][selectedPath.row];
        // set level name
        highestScoreVC.levelName = levelName;
        // set mode
        highestScoreVC.mode = WatchMode;
        // set player name
        highestScoreVC.playerName = [[FileManager sharedFileManager] getUsernameWithHighestScoreForLevel:levelName];
        // set score
        highestScoreVC.score = [[FileManager sharedFileManager] getHighestScoreForLevel:levelName];
    }
    else
    {
        GameViewController *gameVC = segue.destinationViewController;
        NSIndexPath *selectedPath = [self.levelsTableView indexPathForSelectedRow];
        // set level name of GameViewController
        gameVC.levelName = self.levelsTableViewData[selectedPath.section][selectedPath.row];
    }
}

- (void)setupNavigationBar
{
    if (self.mode == HallOfFameMode)
        [self.navigationItem setTitle:[NavigationBarTitleHallOfFame copy]];
    else
        [self.navigationItem setTitle:[NavigationBarTitleLevels copy]];
    Theme* currentTheme = [[ThemeManager sharedThemeManager] currentTheme];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[ currentTheme textsColor]}];
    [[self.navigationController navigationBar] setBarTintColor:[currentTheme navigationBarColor]];
    [[self.navigationController navigationBar] setTintColor:[currentTheme textsColor]];
}

@end
