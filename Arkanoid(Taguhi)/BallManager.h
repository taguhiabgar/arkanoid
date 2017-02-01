//
//  BallManager.h
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/15/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BrickImageView.h"
#import "Constants.h"
@import CoreGraphics;

@interface BallManager : NSObject

+ (id)sharedBallManager;

// ball movement direction
@property (nonatomic) CGVector directionVector;
// unit for ball movement (for recursive movement)
@property CGFloat unit;

// ball velocity
- (CGFloat)ballVelocity;
// find point which belongs to line
- (CGFloat)xCoordinateOfPointWithYCoordinate:(CGFloat)yCoordinate onLineFrom:(CGPoint)startPoint to:(CGPoint)destinationPoint;
- (CGFloat)yCoordinateOfPointWithXCoordinate:(CGFloat)xCoordinate onLineFrom:(CGPoint)startPoint to:(CGPoint)destinationPoint;
// invert direction vector
- (CGVector)invertDirectionVector:(CGVector)directionVector AfterHittingWall:(WallType)wall;
// make vector by two point
- (CGVector)vectorFrom:(CGPoint)startPoint to:(CGPoint)endPoint;
// get size of ball
- (CGSize)ballSize;
// calculate time by velocity and distance
- (CGFloat)timeByBallVelocity:(CGFloat)velocity andDistance:(CGFloat)distance;
// distance between two points
- (CGFloat)distanceFrom:(CGPoint)firstPoint to:(CGPoint)secondPoint;
// normalize vector
- (CGVector)normalizeVector:(CGVector)vector;

@end
