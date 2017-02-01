//
//  PlatformManager.m
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/15/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import "PlatformManager.h"
#import "SizeManager.h"
#import "Constants.h"

@implementation PlatformManager

+ (id)sharedPlatformManager
{
    static PlatformManager* sharedInstance = nil;
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

// returns (0,0) point if ball falls below platform
- (CGVector)directionVectorAfterHittingPlatform:(CGRect)platformFrame ballFrame:(CGRect)ballFrame directionVector:(CGVector)ballDirectionVector
{
    CGFloat heightForDirectionVector = [self heightForDirectionVector];
    // if ball falls below platform
    if (ballFrame.origin.x + ballFrame.size.width < platformFrame.origin.x ||
        platformFrame.origin.x + platformFrame.size.width < ballFrame.origin.x)
    {
        return CGVectorMake(0, 0);
    }
    else
    {
        CGFloat ballCenterXCoordinate = ballFrame.origin.x + ballFrame.size.width / CoefficientForHeight;
        CGFloat platformCenterXCoordinate = platformFrame.origin.x + platformFrame.size.width / 2.0;
        
        if (platformCenterXCoordinate >= ballCenterXCoordinate - Epsilon && platformCenterXCoordinate <= ballCenterXCoordinate + Epsilon) {
            // --hit platform at center point
            // invert ball's direction vector
            return CGVectorMake(ballDirectionVector.dx, -ballDirectionVector.dy);
        }
        else
        {
            CGPoint startPoint = CGPointMake(platformCenterXCoordinate, platformFrame.origin.y);
            CGPoint endPoint = CGPointMake(ballCenterXCoordinate, platformFrame.origin.y - heightForDirectionVector);
            return [self vectorByStartPoint:startPoint andEndPoint:endPoint];
        }
    }    
}

- (CGVector)vectorByStartPoint:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint
{
    return CGVectorMake(endPoint.x - startPoint.x, endPoint.y - startPoint.y);
}

- (CGFloat)heightForDirectionVector
{
    return [self platformSize].width / CoefficientForDirectionVector;
}

- (CGFloat)freeSpaceFromBottom
{
    return [[SizeManager sharedSizeManager] platformFreeSpaceFromBottom];
}

- (CGSize)platformSize
{
    return [[SizeManager sharedSizeManager] platformSize];
}

@end
