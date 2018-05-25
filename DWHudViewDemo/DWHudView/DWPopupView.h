//
//  DWPopupView.h
//  DWHudViewDemo
//
//  Created by CrazyDavy on 2018/5/25.
//  Copyright © 2018年 Crazy Davy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWPopupView : UIView

- (instancetype)initWithImageName:(NSString *)imageName Title:(NSString *)title;

- (void)showPopupViewWithCompleted:(void(^)(void))completed;

@end
