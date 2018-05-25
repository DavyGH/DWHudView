//
//  DWHudManager.h
//  DWHudViewDemo
//
//  Created by CrazyDavy on 2018/5/25.
//  Copyright © 2018年 Crazy Davy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWHudManager : NSObject

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *title;

+ (instancetype)sharedInstance;

- (void)attempDealloc;

#pragma mark - loading -
- (void)showLoading;

- (void)hideLoading;

#pragma mark - popup -
- (void)showPopupWithTitle:(NSString *)title imageName:(NSString *)imageName;

@end
