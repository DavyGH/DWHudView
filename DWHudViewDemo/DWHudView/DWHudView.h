//
//  DWHudView.h
//  DWHudViewDemo
//
//  Created by CrazyDavy on 2018/5/25.
//  Copyright © 2018年 Crazy Davy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWHudView : UIView

- (instancetype)initWithImageName:(NSString *)imageName Title:(NSString *)title;

- (void)show;

- (void)hide;

@end
