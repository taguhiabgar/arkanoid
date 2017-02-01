//
//  GameViewController.m
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/5/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import "GameViewController.h"
#import "BrickImageView.h"
#import "FileManager.h"
#import "BallManager.h"
#import "SizeManager.h"
#import "ThemeManager.h"
#import "LevelManager.h"
#import "PlatformManager.h"
#import "Constants.h"

static const NSInteger NoBrickToAttack = -1; // index of brick

@interface GameViewController ()

// score
@property NSInteger score;
// lives
@property NSInteger lives;
// size of brick
@property CGFloat brickSize;
// background image
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
// score label
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
// lives label
@property (weak, nonatomic) IBOutlet UILabel *livesLabel;
// array of bricks
@property (strong, readwrite, atomic) NSMutableArray<BrickImageView*>* arrayOfBricks;
// platform
@property UIImageView* platform;
// ball
@property UIImageView* ball;
// user's name
@property NSString* username;
@property BOOL gameEnded;


@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setBackgroundImage];
    [self createBall];
    [self createPlatform];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.gameEnded = NO;
    self.arrayOfBricks = [[NSMutableArray alloc] init];
    self.score = ScoreStartingValue;
    self.lives = LivesStartingValue;
    [self setupNavigationBar];
    [self updateLabels];
    // show popup with level information
    [self showAlert];
}

-(void) viewWillDisappear:(BOOL)animated
{
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound)
    {
        // --navigation button (back button) was pressed
        // kill all animations
        [[self.view layer] removeAllAnimations];
    }
    // remove all bricks from main view
    [self removeAllBricks];
    [super viewWillDisappear:animated];
}

// delegate's method
- (void)loadNextLevel
{
    self.levelName = [[LevelManager sharedLevelManager] nextLevelOfLevel:self.levelName];
}

- (void)showScoreViewController
{
    // show HighestScoreViewController
    [self performSegueWithIdentifier:[ScoreSegueIdentifier copy] sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    HighestScoreViewController* highestScoreVC = segue.destinationViewController;
    // set delegate
    highestScoreVC.delegate = self;
    // set player name
    highestScoreVC.playerName = self.username;
    // set score
    highestScoreVC.score = [[NSNumber numberWithInteger:self.score] stringValue];
    if (self.lives == 0) {
        highestScoreVC.mode = LoseMode;
        // set navigation bar title
        highestScoreVC.levelName = self.levelName;
    } else {
        highestScoreVC.mode = WinMode;
        // set level name
        highestScoreVC.levelName = self.levelName;
    }
}

- (void)removeAllBricks
{
    for (NSInteger index = 0; index < [self.arrayOfBricks count]; index++)
        [self.arrayOfBricks[index] removeFromSuperview];
}

- (void)setBackgroundImage
{
    [self.backgroundImageView setImage:[UIImage imageNamed:[[[ThemeManager sharedThemeManager] currentTheme] backgroundImageName]]];
    [self.backgroundImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer* tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnBackgroundImageView:)];
    [self.backgroundImageView addGestureRecognizer:tapGestureRecognizer];
}

- (BOOL)arrayOfBricksIsEmpty
{
    NSInteger amount = 0;
    for (NSInteger index = 0; index < [self.arrayOfBricks count]; index++)
        if (!self.arrayOfBricks[index].isHidden)
            amount++;
    if (amount == 0)
        return YES;
    return NO;
}

- (void)handleTapOnBackgroundImageView:(UITapGestureRecognizer*)tapGestureRecognizer
{
    if (counter++ == 0)
    {
        // get ball's current location (center point of ball's frame)
        CGPoint ballStartLocation = CGPointMake(self.ball.frame.origin.x + self.ball.frame.size.width / 2.0, self.ball.frame.origin.y + self.ball.frame.size.height / 2.0);
        // get tapped point
        CGPoint touchPoint = [tapGestureRecognizer locationInView:self.backgroundImageView];
        // set direction vector of ball
        [[BallManager sharedBallManager] setDirectionVector:CGVectorMake(touchPoint.x - ballStartLocation.x, touchPoint.y - ballStartLocation.y)];
        // get direction vector (normalized)
        CGVector directionVector = [[BallManager sharedBallManager] directionVector];
        // calculate direction point
        CGPoint directionPoint = CGPointMake(ballStartLocation.x + directionVector.dx, ballStartLocation.y + directionVector.dy);
        // move ball with calculated direction vector
        [self moveBallToPoint:directionPoint fromStartPoint:ballStartLocation];
    }
}

- (void)ballHitsPlatformAtPoint:(CGPoint)nextPoint withNewDirectionVector:(CGVector)newDirectionVector
{
    // calculate destination point
    CGPoint destinationPoint = CGPointMake(nextPoint.x + newDirectionVector.dx, nextPoint.y + newDirectionVector.dy);
    [[BallManager sharedBallManager] setDirectionVector:newDirectionVector];
    [self moveBallToPoint:destinationPoint fromStartPoint:nextPoint];
}

- (void)ballHitsBrickAtIndex:(NSInteger)index fromPoint:(CGPoint)startPoint atPoint:(CGPoint)nextPoint
{
    // check if index is valid
    if ([self.arrayOfBricks count] != 0 && (index >= 0 && index < [self.arrayOfBricks count]))
    {
        CGRect ballCurrentFrame = self.ball.frame;
        CGRect brickFrame = self.arrayOfBricks[index].frame;
        WallType wall;
        // point where ball hits brick
        CGPoint destinationPoint;
        // direction vector after collision
        CGVector newDirectionVector;
        // direction vector before collision
        CGVector currentDirectionVector = [[BallManager sharedBallManager] vectorFrom:startPoint to:nextPoint];
        if (ballCurrentFrame.origin.y > brickFrame.origin.y + brickFrame.size.height) {
            // ball is lower than brick
            wall = BottomWall;
            destinationPoint.y = brickFrame.origin.y + brickFrame.size.height + ballCurrentFrame.size.height / 2.0;
        } else {
            if (ballCurrentFrame.origin.y + ballCurrentFrame.size.height < brickFrame.origin.y) {
                // ball is higher than brick
                wall = TopWall;
                destinationPoint.y = brickFrame.origin.y - ballCurrentFrame.size.height / 2.0;
            } else {
                if (ballCurrentFrame.origin.x > brickFrame.origin.x + brickFrame.size.width) {
                    // ball is on brick's right side
                    wall = RightWall;
                    destinationPoint.x = brickFrame.origin.x + brickFrame.size.width + ballCurrentFrame.size.width / 2.0;
                } else {
                    // ball is on brick's left side
                    wall = LeftWall;
                    destinationPoint.x = brickFrame.origin.x - ballCurrentFrame.size.width / 2.0;
                }
            }
        }
        // calculate other coordinate of destination point
        if (wall == TopWall || wall == BottomWall) {
            destinationPoint.x = [[BallManager sharedBallManager] xCoordinateOfPointWithYCoordinate:destinationPoint.y onLineFrom:startPoint to:nextPoint];
        } else {
            destinationPoint.y = [[BallManager sharedBallManager] yCoordinateOfPointWithXCoordinate:destinationPoint.x onLineFrom:startPoint to:nextPoint];
        }
        // calculate direction vector after collision
        newDirectionVector = [[BallManager sharedBallManager] invertDirectionVector:currentDirectionVector AfterHittingWall:wall];
        [[BallManager sharedBallManager] setDirectionVector:newDirectionVector];
        // -- calculate animation duration
        CGFloat distance = [[BallManager sharedBallManager] distanceFrom:startPoint to:destinationPoint];
        CGFloat ballVelocity = [[BallManager sharedBallManager] ballVelocity];
        CGFloat animationDuration = [[BallManager sharedBallManager] timeByBallVelocity:ballVelocity andDistance:distance];
        CGPoint newDestinationPoint = CGPointMake(destinationPoint.x + newDirectionVector.dx, destinationPoint.y + newDirectionVector.dy);
        // move ball to destination point
        [UIView animateWithDuration:animationDuration delay:0.0 options: UIViewAnimationOptionCurveLinear animations:^{
            self.ball.frame = CGRectMake(destinationPoint.x - self.ball.frame.size.width / 2.0, destinationPoint.y - self.ball.frame.size.height / 2.0, self.ball.frame.size.width, self.ball.frame.size.height);
        } completion:^(BOOL finished) {
            [self attackBrickAtIndex:index];
            [self.view addSubview:self.ball];
            [self moveBallToPoint:newDestinationPoint fromStartPoint:nextPoint];
        }];
    }
}

- (void)touchesMoved:(NSSet<UITouch*>*)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    CGRect platformNewFrame = CGRectMake(touchLocation.x, self.platform.frame.origin.y, self.platform.frame.size.width, self.platform.frame.size.height);
    [self.platform setFrame:platformNewFrame];
}

- (NSInteger)indexOfBrickContainingBall:(CGRect)ballFrame
{
    NSInteger amountOfBricks = [self.arrayOfBricks count];
    for (NSInteger index = 0; index < amountOfBricks; index++)
    {
        if (self.arrayOfBricks[index].hidden == NO)
        {
            CGRect brickFrame = self.arrayOfBricks[index].frame;
            if (CGRectIntersectsRect(brickFrame, ballFrame))
            {
                return index;
            }
        }
    }
    return NoBrickToAttack;
}

- (void)updateLabels
{
    [self setScoreLabelText:self.score];
    [self setLivesLabelText:self.lives];
}

- (void)setScoreLabelText:(NSInteger)score
{
    // score label text
    NSString* scoreString = [[NSString alloc] initWithFormat:@"%@%ld", ScoreLabelText, (long)score];
    // set score label text
    [self.scoreLabel setText:scoreString];
}

- (void)setLivesLabelText:(NSInteger)lives
{
    if (!self.gameEnded)
    {
        if (lives == 0)
        {
            [self endOfGame];
            return;
        }
        // lives label text
        NSString* livesString = [[NSString alloc] initWithFormat:@"%@%ld", LivesLabelText, (long)self.lives];
        // set lives label text
        [self.livesLabel setText:livesString];
    }
}

- (void)prepareForStart
{
    counter = 0;
    [self setupBricks];
    [self setupPlatform];
    [self setupBall];
}

- (void)ballFallsBelowPlatform
{
    counter = 0;
    [self setupBall];
    [self setupPlatform];
    [self decreaseLives];
}

- (void)decreaseLives
{
    if (!self.gameEnded)
    {
        [self setLives:(self.lives - 1)];
        [self updateLabels];
    }
}

- (void)addScore:(NSInteger)score
{
    [self setScore:(self.score + score)];
    [self updateLabels];
}

- (void)endOfGame
{
    self.gameEnded = YES;
    // show alert "Enter your name" to get user's name
    [self askUserToEnterName];
}

- (void)askUserToEnterName
{
    // kill all animations
    [[self.view layer] removeAllAnimations];
    // create alert
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:[EndOfGameString copy]  message:[EnterNameString copy] preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = [YourNameString copy];
        textField.textColor = [[[ThemeManager sharedThemeManager] currentTheme] textsColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:[OkTitle copy] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString* textFieldContent = alertController.textFields[0].text;
        self.username = textFieldContent;
        // show highest score view controller
        [self showScoreViewController];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)attackBrickAtIndex:(NSInteger)index
{
    // if index is valid
    if ([self.arrayOfBricks count] != 0 && (index >= 0 && index < [self.arrayOfBricks count]))
    {
        // add score
        [self addScore:(self.arrayOfBricks[index].scoreForCurrentType)];
        if ([self.arrayOfBricks[index] willExplodeAfterAttack])
        {
            // animate explosion
            CGRect frame = self.arrayOfBricks[index].frame;
            [UIView animateWithDuration:BrickExplodeDuration delay:BrickExplodeDelay options: UIViewAnimationOptionCurveEaseInOut animations:^{
                self.arrayOfBricks[index].frame = CGRectMake(frame.origin.x + frame.size.width / 2.0, frame.origin.y, 0.0, frame.size.height);
            } completion:^(BOOL finished) {
                [self.arrayOfBricks[index] setHidden:YES];
                if ([self arrayOfBricksIsEmpty])
                    [self endOfGame];
            }];
        }
        else
        {
            [self.arrayOfBricks[index] attack];
        }
    }
}

- (void)setupPlatform
{
    // calculate size of platform
    CGSize platformSize = [[PlatformManager sharedPlatformManager] platformSize];
    // calculate origin of platform
    CGPoint platformOrigin = CGPointMake((self.view.frame.size.width - platformSize.width) / 2.0, self.view.frame.size.height - [[PlatformManager sharedPlatformManager] freeSpaceFromBottom] - platformSize.height);
    self.platform.frame = CGRectMake(platformOrigin.x, platformOrigin.y, platformSize.width, platformSize.height);
    // set image
    [self.platform setImage:[UIImage imageNamed:[[[ThemeManager sharedThemeManager] currentTheme] platformImageName]]];
    // add platform to main view
    [self.view addSubview:self.platform];
}

- (void)setupBall
{
    // calculate ball size
    CGSize ballSize = [[BallManager sharedBallManager] ballSize];
    // calculate ball origin
    CGPoint ballOrigin = CGPointMake((self.view.frame.size.width - ballSize.width) / 2.0, self.platform.frame.origin.y - ballSize.height);
    self.ball.frame = CGRectMake(ballOrigin.x, ballOrigin.y, ballSize.width, ballSize.height);
    // add platform to main view
    [self.view addSubview:self.ball];
}

- (void)createBall
{
    // calculate ball size
    CGSize ballSize = [[BallManager sharedBallManager] ballSize];
    // calculate ball origin
    CGPoint ballOrigin = CGPointMake((self.view.frame.size.width - ballSize.width) / 2.0, self.platform.frame.origin.y - ballSize.height);
    // create frame of ball
    CGRect ballFrame = CGRectMake(ballOrigin.x, ballOrigin.y, ballSize.width, ballSize.height);
    // create ball
    self.ball = [[UIImageView alloc] initWithFrame:ballFrame];
    // set image
    [self.ball setImage:[UIImage imageNamed:[BallImageName copy]]];
    // add platform to main view
    [self.view addSubview:self.ball];
}

- (void)createPlatform
{
    // calculate size of platform
    CGSize platformSize = [[PlatformManager sharedPlatformManager] platformSize];
    // calculate origin of platform
    CGPoint platformOrigin = CGPointMake((self.view.frame.size.width - platformSize.width) / 2.0, self.view.frame.size.height - [[PlatformManager sharedPlatformManager] freeSpaceFromBottom] - platformSize.height);
    // create platform's frame
    CGRect platformFrame = CGRectMake(platformOrigin.x, platformOrigin.y, platformSize.width, platformSize.height);
    // create platform
    self.platform = [[UIImageView alloc] initWithFrame:platformFrame];
    // add platform to main view
    [self.view addSubview:self.platform];
}

- (void)showAlert
{
    counter = 0;
    NSString* title = self.levelName;
    NSString* message = [PopupMessage copy];
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:[PopupNewLevelButtonTitle copy] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                                    // prepare to start the game
                                    [self prepareForStart];
                                    // dismiss alert
                                    [self dismissViewControllerAnimated:YES completion:nil];
                                }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)setupNavigationBar {
    [self.navigationItem setTitle:self.levelName];
    Theme* currentTheme = [[ThemeManager sharedThemeManager] currentTheme];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[currentTheme textsColor]}];
    [[self.navigationController navigationBar] setBarTintColor:[currentTheme navigationBarColor]];
    [[self.navigationController navigationBar] setTintColor:[currentTheme textsColor]];
}

- (void)setupBricks
{
    // get array of bricks of current level
    NSMutableArray<NSMutableArray<NSNumber*>*>* gridOfBricks = [[FileManager sharedFileManager] readGridOfBricksFromFileWithName:self.levelName];
    // calculate brick's width
    self.brickSize = ([[UIScreen mainScreen] bounds].size.width - [[SizeManager sharedSizeManager] freeSpaceFromLeft] - [[SizeManager sharedSizeManager] freeSpaceFromRight] - (AmountOfBoardColumns - 1) * [[SizeManager sharedSizeManager] freeSpaceBetweenBricks]) / AmountOfBoardColumns;
    CGFloat brickYCoordinateStartValue = self.scoreLabel.frame.origin.y + self.scoreLabel.frame.size.height + [[SizeManager sharedSizeManager] freeSpaceFromTop];
    // calculate unit for ball movement
    [[BallManager sharedBallManager] setUnit:(self.brickSize / 2.0)];
    // for all bricks in matrix
    for (NSInteger rowIndex = 0; rowIndex < [gridOfBricks count]; rowIndex++) {
        for (NSInteger columnIndex = 0; columnIndex < [gridOfBricks[rowIndex] count]; columnIndex++) {
            NSInteger currentBrickValue = [gridOfBricks[rowIndex][columnIndex] integerValue];
            if (currentBrickValue != BrickTypeEmpty) {
                // create frame of current brick
                CGRect brickFrame = CGRectMake([self.arrayOfBricks lastObject].frame.origin.x + [self.arrayOfBricks lastObject].frame.size.width / 2, [self.arrayOfBricks lastObject].frame.origin.y, 0, [self.arrayOfBricks lastObject].frame.size.height);
                // create brick
                BrickImageView* brickImageView = [[BrickImageView alloc] initWithFrame:brickFrame];
                // set current brick's type
                [brickImageView setType:currentBrickValue];
                // add current brick to array of bricks
                [self.arrayOfBricks addObject:brickImageView];
                // add current brick to main view
                [self.view addSubview:brickImageView];
                [UIView animateWithDuration:BrickAppearDuration delay:(rowIndex * [gridOfBricks[rowIndex] count] + columnIndex) / CoeffficientForBrickAppearDelay options: UIViewAnimationOptionCurveEaseInOut animations:^{
                    [self.arrayOfBricks lastObject].frame = CGRectMake([[SizeManager sharedSizeManager] freeSpaceFromLeft] + (self.brickSize + [[SizeManager sharedSizeManager] freeSpaceBetweenBricks]) * columnIndex, brickYCoordinateStartValue + (self.brickSize + [[SizeManager sharedSizeManager] freeSpaceBetweenBricks]) * rowIndex, self.brickSize, self.brickSize);;
                } completion:^(BOOL finished) {}];
            }
        }
    }
}

- (void)moveBallToPoint:(CGPoint)destinationPoint fromStartPoint:(CGPoint)startPoint
{
    CGPoint nextPoint = destinationPoint;
    // --check if destination point is outside of screen
    if (nextPoint.x > self.view.frame.origin.x) {
        if (nextPoint.x < self.view.frame.origin.x + self.view.frame.size.width) {
            if (nextPoint.y > self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height) {
                if (nextPoint.y < self.platform.frame.origin.y) {
                    NSInteger indexOfBrick = [self indexOfBrickContainingBall:CGRectMake(nextPoint.x - self.ball.frame.size.width / 2.0, nextPoint.y - self.ball.frame.size.height / 2.0, self.ball.frame.size.width, self.ball.frame.size.height)];
                    if (indexOfBrick != NoBrickToAttack) {
                        // ball hits brick
                        [self ballHitsBrickAtIndex:indexOfBrick fromPoint:startPoint atPoint:nextPoint];
                        return;
                    }
                } else {
                    // ball and platform have same height
                    CGRect platformFrame = self.platform.frame;
                    CGRect ballFrame = self.ball.frame;
                    if (ballFrame.origin.x + ballFrame.size.width >= platformFrame.origin.x && ballFrame.origin.x <= platformFrame.origin.x + platformFrame.size.width) {
                        // ball hits platform
                        CGVector currentDirectionVector = [[BallManager sharedBallManager] vectorFrom:startPoint to:destinationPoint];
                        CGVector newDirectionVector = [[PlatformManager sharedPlatformManager] directionVectorAfterHittingPlatform:platformFrame ballFrame:ballFrame directionVector:currentDirectionVector];
                        // normalize new direction vector
                        newDirectionVector = [[BallManager sharedBallManager] normalizeVector:newDirectionVector];
                        // calculate point where ball hits platform
                        nextPoint.y = self.platform.frame.origin.y - self.ball.frame.size.height / 2.0;
                        nextPoint.x = [[BallManager sharedBallManager] xCoordinateOfPointWithYCoordinate:nextPoint.y onLineFrom:startPoint to:destinationPoint];
                        // hit platform and change direction
                        [self ballHitsPlatformAtPoint:nextPoint withNewDirectionVector:newDirectionVector];
                        return;
                    } else {
                        // ball falls below platform
                        [self ballFallsBelowPlatform];
                        return;
                    }
                }
            } else {
                // ball hits top wall
                nextPoint.y = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height + self.ball.frame.size.height / 2.0;
                nextPoint.x = [[BallManager sharedBallManager] xCoordinateOfPointWithYCoordinate:nextPoint.y onLineFrom:startPoint to:destinationPoint];
                CGVector newVector = [[BallManager sharedBallManager] invertDirectionVector:[[BallManager sharedBallManager] directionVector] AfterHittingWall:TopWall];
                [[BallManager sharedBallManager] setDirectionVector:newVector];
            }
        } else {
            // ball hits right wall
            nextPoint.x = self.view.frame.origin.x + self.view.frame.size.width - self.ball.frame.size.width / 2.0;
            nextPoint.y = [[BallManager sharedBallManager] yCoordinateOfPointWithXCoordinate:nextPoint.x onLineFrom:startPoint to:destinationPoint];
            CGVector newVector = [[BallManager sharedBallManager] invertDirectionVector:[[BallManager sharedBallManager] directionVector] AfterHittingWall:RightWall];
            [[BallManager sharedBallManager] setDirectionVector:newVector];
        }
    } else {
        // ball hits left wall
        nextPoint.x = self.view.frame.origin.x + self.ball.frame.size.width / 2.0;
        nextPoint.y = [[BallManager sharedBallManager] yCoordinateOfPointWithXCoordinate:nextPoint.x onLineFrom:startPoint to:destinationPoint];
        CGVector newVector = [[BallManager sharedBallManager] invertDirectionVector:[[BallManager sharedBallManager] directionVector] AfterHittingWall:LeftWall];
        [[BallManager sharedBallManager] setDirectionVector:newVector];
    }
    CGFloat distance = [[BallManager sharedBallManager] distanceFrom:startPoint to:nextPoint];
    CGFloat animationDuration = [[BallManager sharedBallManager] timeByBallVelocity:[[BallManager sharedBallManager] ballVelocity] andDistance:distance];
    CGPoint newDestinationPoint = CGPointMake(nextPoint.x + [[BallManager sharedBallManager] directionVector].dx, nextPoint.y + [[BallManager sharedBallManager] directionVector].dy);
    // move ball to destination point
    [UIView animateWithDuration:animationDuration delay:0.0 options: UIViewAnimationOptionCurveLinear animations:^{
        self.ball.frame = CGRectMake(nextPoint.x - self.ball.frame.size.width / 2.0, nextPoint.y - self.ball.frame.size.height / 2.0, self.ball.frame.size.width, self.ball.frame.size.height);
    } completion:^(BOOL finished) {
        [self.view addSubview:self.ball];
        [self moveBallToPoint:newDestinationPoint fromStartPoint:nextPoint];
    }];
}

@end
