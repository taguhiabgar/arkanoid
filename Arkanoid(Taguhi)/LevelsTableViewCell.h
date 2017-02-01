//
//  LevelsTableViewCell.h
//  Arkanoid(Taguhi)
//
//  Created by Taguhi Abgaryan on 9/13/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelsTableViewCell : UITableViewCell

@property (nonatomic, strong, readwrite) NSString* levelName;
@property (weak, nonatomic) IBOutlet UILabel *levelNameLabel;
@property (nonatomic, strong, readwrite) UIColor* backgroundViewColor;

@end
