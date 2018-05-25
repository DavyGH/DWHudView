//
//  DWHudManager.m
//  DWHudViewDemo
//
//  Created by CrazyDavy on 2018/5/25.
//  Copyright © 2018年 Crazy Davy. All rights reserved.
//

#import "DWHudManager.h"
#import "DWHudView.h"
#import "DWPopupView.h"

@interface DWHudManager ()

@property(nonatomic ,strong) DWHudView *hudView;

@property(nonatomic ,strong) DWPopupView *popupView;

@end

@implementation DWHudManager

static DWHudManager *dwHudManager = nil;
static dispatch_once_t onceToken;

#pragma mark - life cycle -
+ (instancetype)sharedInstance
{
    dispatch_once(&onceToken, ^{
        dwHudManager = [[DWHudManager alloc] init];
    });
    return dwHudManager;
}

- (void)attempDealloc
{
    onceToken = 0;
    dwHudManager = nil;
}

#pragma mark - setter -
- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
}

#pragma mark - loading -
- (void)showLoading
{
    _hudView = [[DWHudView alloc] initWithImageName:_imageName Title:_title];
    [_hudView show];
}

- (void)hideLoading
{
    [_hudView hide];
    _hudView = nil;
}

#pragma mark - popup -
- (void)showPopupWithTitle:(NSString *)title imageName:(NSString *)imageName
{
    __weak typeof(self) weakSelf = self;
    _popupView = [[DWPopupView alloc] initWithImageName:imageName Title:title];
    [_popupView showPopupViewWithCompleted:^{
        weakSelf.popupView = nil;
    }];
}

@end
