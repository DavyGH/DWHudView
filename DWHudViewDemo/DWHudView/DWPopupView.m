//
//  DWPopupView.m
//  DWHudViewDemo
//
//  Created by CrazyDavy on 2018/5/25.
//  Copyright © 2018年 Crazy Davy. All rights reserved.
//

#import "DWPopupView.h"

#define DW_SCREEN_W [UIScreen mainScreen].bounds.size.width

#define DW_Popup_H 64
#define DW_CLEARANCE 10
#define DW_BG_W DW_SCREEN_W - (DW_CLEARANCE * 2)

#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

@interface DWPopupView ()
// UI
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLab;

// Parameter
@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *title;

@end

@implementation DWPopupView

#pragma - life cycle

- (void)dealloc
{
    NSLog(@"delloc");
}

- (instancetype)initWithImageName:(NSString *)imageName Title:(NSString *)title
{
    self = [super initWithFrame:CGRectMake(0, 0, DW_SCREEN_W, DW_Popup_H)];
    if (self) {
        _imageName = imageName?imageName:@"";
        _title = title?title:@"";
    }
    return self;
}

#pragma mark - event -

- (void)showPopupViewWithCompleted:(void (^)(void))completed
{
    [self configUI];
    [self showAnimationWithCompleted:completed];
}

- (void)hide
{
    [UIView animateWithDuration:.15 animations:^{
        self.bgView.transform = CGAffineTransformMakeScale(0.05, 0.05);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)configUI
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.imageView];
    [self.bgView addSubview:self.titleLab];
}

- (void)showAnimationWithCompleted:(void (^)(void))completed
{
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:0 animations:^{
        self.bgView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        if (KIsiPhoneX) {
            self.bgView.frame = CGRectMake(DW_CLEARANCE, 40, DW_BG_W, DW_Popup_H);
        }else{
            self.bgView.frame = CGRectMake(DW_CLEARANCE, 20, DW_BG_W, DW_Popup_H);
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.5 delay:self.title.length*.1 options:0 animations:^{
            self.bgView.frame = CGRectMake(DW_CLEARANCE, -DW_Popup_H, DW_BG_W, DW_Popup_H);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            if (completed) {
                completed();                
            }
        }];
    }];
}


#pragma mark - lazy load -

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(DW_CLEARANCE, -DW_Popup_H, DW_BG_W, DW_Popup_H)];
        _bgView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 8.0;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, DW_Popup_H - 50, 40, 40)];
        _imageView.image = [UIImage imageNamed:_imageName];
    }
    return _imageView;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(80, DW_Popup_H - 50, DW_BG_W - 80, 40)];
        _titleLab.font = [UIFont systemFontOfSize:16];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.text = _title;
    }
    return _titleLab;
}

@end
