//
//  PlatformManager.h
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/15/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreGraphics;

@interface PlatformManager : NSObject

+ (id)sharedPlatformManager;

- (CGSize)platformSize;
- (CGFloat)freeSpaceFromBottom;
- (CGVector)directionVectorAfterHittingPlatform:(CGRect)platformFrame ballFrame:(CGRect)ballFrame directionVector:(CGVector)ballDirectionVector;

@end
