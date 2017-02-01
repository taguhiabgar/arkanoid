//
//  SizeManager.h
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/20/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreGraphics;

@interface SizeManager : NSObject

+ (id)sharedSizeManager;

@property CGRect viewFrame;
@property CGFloat navigationBarHeight;
// screen
- (CGFloat)screenLeftXCoordinate;
- (CGFloat)screenRightXCoordinate;
- (CGFloat)screenTopYCoordinate;
// ball size
- (CGFloat)ballWidthAndHeight;
// free space
- (CGFloat)freeSpaceFromTop;
- (CGFloat)freeSpaceFromBottom;
- (CGFloat)freeSpaceFromLeft;
- (CGFloat)freeSpaceFromRight;
- (CGFloat)freeSpaceBetweenBricks;
// buttons
- (CGFloat)buttonsCornerRadius;
- (CGFloat)buttonsFontSize;
// platform
- (CGFloat)platformFreeSpaceFromBottom;
- (CGSize)platformSize;
// hall of fame
- (NSString*)hallOfFameBackgroundImageName;
// instructions
- (NSString*)instructionsImageName;

@end
