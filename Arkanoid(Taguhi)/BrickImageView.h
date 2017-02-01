//
//  BrickImageView.h
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/15/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface BrickImageView : UIImageView

@property (nonatomic) BrickType type;
@property (nonatomic, readonly) NSInteger scoreForCurrentType;

- (void)attack;
- (BOOL)willExplodeAfterAttack;

@end
