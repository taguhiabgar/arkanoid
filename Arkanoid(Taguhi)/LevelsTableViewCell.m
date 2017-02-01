//
//  LevelsTableViewCell.m
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/13/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import "LevelsTableViewCell.h"

@implementation LevelsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)setBackgroundViewColor:(UIColor *)backgroundViewColor
{
    _backgroundViewColor = backgroundViewColor;
    self.backgroundColor = backgroundViewColor;
}

- (void)awakeFromNib {
    [self.levelNameLabel setText:self.levelName];
}

- (void)setLevelName:(NSString *)levelName
{
    _levelName = levelName;
    [self.levelNameLabel setText:levelName];  
}

@end
