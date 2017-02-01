//
//  ThemeManager.h
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/7/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Theme.h"

@interface ThemeManager : NSObject

+ (id)sharedThemeManager;

@property (atomic, strong, readwrite) Theme* currentTheme;
@property (atomic, strong, readwrite) NSMutableArray* arrayOfThemes;

- (void)setupThemes;

@end
