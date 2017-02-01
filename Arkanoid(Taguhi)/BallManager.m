//
//  BallManager.m
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/15/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import "BallManager.h"
#import "BrickImageView.h"
#import "SizeManager.h"
#import "Constants.h"

@implementation BallManager

+ (id)sharedBallManager
{
    static BallManager* sharedInstance = nil;
    @synchronized(self) {
        if (sharedInstance == nil)
        {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

- (CGVector)invertDirectionVector:(CGVector)directionVector AfterHittingWall:(WallType)wall;
{
    CGVector invertedVector;
    switch (wall)
    {
        case NoWall:
            invertedVector = directionVector;
            break;
        case TopWall:
            invertedVector = CGVectorMake(directionVector.dx, -directionVector.dy);
            break;
        case BottomWall:
            invertedVector = CGVectorMake(directionVector.dx, -directionVector.dy);
            break;
        case LeftWall:
            invertedVector = CGVectorMake(-directionVector.dx, directionVector.dy);
            break;
        case RightWall:
            invertedVector = CGVectorMake(-directionVector.dx, directionVector.dy);
            break;
        default:
            break;
    }
    return invertedVector;
}

- (CGFloat)xCoordinateOfPointWithYCoordinate:(CGFloat)yCoordinate onLineFrom:(CGPoint)startPoint to:(CGPoint)destinationPoint
{
    CGFloat x1 = startPoint.x;
    CGFloat y1 = startPoint.y;
    CGFloat x2 = destinationPoint.x;
    CGFloat y2 = destinationPoint.y;
    CGFloat y3 = yCoordinate;
    CGFloat x3 = x2 + (y2 - y3) * (x2 - x1) / (y1 - y2);
    return x3;
}

- (CGFloat)yCoordinateOfPointWithXCoordinate:(CGFloat)xCoordinate onLineFrom:(CGPoint)startPoint to:(CGPoint)destinationPoint
{
    CGFloat x1 = startPoint.x;
    CGFloat y1 = startPoint.y;
    CGFloat x2 = destinationPoint.x;
    CGFloat y2 = destinationPoint.y;
    CGFloat x3 = xCoordinate;
    CGFloat y3 = y2 + (y2 - y1) * (x2 - x3) / (x1 - x2);
    return y3;
}

@synthesize directionVector = _directionVector;

- (void)setDirectionVector:(CGVector)directionVector
{
    _directionVector = [self normalizeVector:directionVector];
}

- (CGVector)vectorFrom:(CGPoint)startPoint to:(CGPoint)endPoint
{
    return CGVectorMake(endPoint.x - startPoint.x, endPoint.y - startPoint.y);
}

- (CGVector)directionVector
{
    return [self normalizeVector:_directionVector];
}

- (CGVector)normalizeVector:(CGVector)vector
{
    if (vector.dx > self.unit || vector.dy > self.unit) {
        if (vector.dx < vector.dy) {
            return CGVectorMake(self.unit * vector.dx / vector.dy, self.unit);
        } else {
            return CGVectorMake(self.unit, self.unit * vector.dy / vector.dx);
        }
    } else {
        return vector;
    }
}

- (CGSize)ballSize
{
    CGFloat ballWidthAndHeight = [[SizeManager sharedSizeManager] ballWidthAndHeight];
    return CGSizeMake(ballWidthAndHeight, ballWidthAndHeight);
}

- (CGFloat)timeByBallVelocity:(CGFloat)velocity andDistance:(CGFloat)distance;
{
    CGFloat time = distance / velocity;
    return time;
}

- (CGFloat)ballVelocity
{
    return BallVelocity;
}

- (CGFloat)distanceFrom:(CGPoint)firstPoint to:(CGPoint)secondPoint
{
    return sqrt((secondPoint.x - firstPoint.x) * (secondPoint.x - firstPoint.x) + (secondPoint.y - firstPoint.y) * (secondPoint.y - firstPoint.y));
}

@end
