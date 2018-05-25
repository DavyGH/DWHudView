//
//  DWHudView.m
//  DWHudViewDemo
//
//  Created by CrazyDavy on 2018/5/25.
//  Copyright © 2018年 Crazy Davy. All rights reserved.
//

#import "DWHudView.h"
#import "DWDealConstant.h"

#define DW_SCREEN_W [UIScreen mainScreen].bounds.size.width
#define DW_SCREEN_H [UIScreen mainScreen].bounds.size.height
#define DW_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define DW_LAB_W 200
#define DW_CLEARANCE 100
#define DW_BG_W DW_SCREEN_W - (DW_CLEARANCE * 2)

#define DW_FONT(font) [UIFont systemFontOfSize:font]

@interface DWHudView ()
// UI
@property (nonatomic, strong) UIView *alphaBGView;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLab;

// Parameter
@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *title;

@end

@implementation DWHudView

#pragma - life cycle

- (void)dealloc
{
    NSLog(@"delloc");
}

- (instancetype)initWithImageName:(NSString *)imageName Title:(NSString *)title
{
    self = [super initWithFrame:CGRectMake(0, 0, DW_SCREEN_W, DW_SCREEN_H)];
    if (self) {
        _imageName = imageName?imageName:@"";
        _title = title?title:@"loading...";
    }
    return self;
}

#pragma mark - event -

- (void)show
{
    [self configUI];
    [self dealBGView];
    [self showAnimation];
    [self showFlipAnimation];
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
    
    [self addSubview:self.alphaBGView];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.imageView];
    [self.bgView addSubview:self.titleLab];
}

- (void)dealBGView
{
    CGFloat Y = [DWDealConstant getLabMaxY:self.titleLab] + 25;
    _bgView.frame = CGRectMake(_bgView.frame.origin.x, _bgView.frame.origin.y, _bgView.frame.size.width, Y);
}

- (void)showAnimation
{
    self.bgView.transform = CGAffineTransformMakeScale(0.05, 0.05);
    [UIView animateWithDuration:.15
                     animations:^{
                         self.bgView.transform = CGAffineTransformMakeScale(1.05, 1.05);
                     }completion:^(BOOL finish){
                         [UIView animateWithDuration:.15
                                          animations:^{
                                              self.bgView.transform = CGAffineTransformMakeScale(0.95, 0.95);
                                          }completion:^(BOOL finish){
                                              [UIView animateWithDuration:.15
                                                               animations:^{
                                                                   self.bgView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                                               }];
                                          }];
                     }];
}

- (void)showFlipAnimation
{
    NSString *keyPath = @"transform.rotation.y";
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue = @(0);
    animation.toValue = @(M_PI*2);
    animation.duration = 3.0;
    animation.repeatCount = HUGE_VALF;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.imageView.layer addAnimation:animation forKey:@"animation"];
}

#pragma mark - lazy load -

- (UIView *)alphaBGView
{
    if (!_alphaBGView) {
        _alphaBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DW_SCREEN_W, DW_SCREEN_H)];
        _alphaBGView.backgroundColor = [UIColor blackColor];
        _alphaBGView.alpha = 0.5;
    }
    return _alphaBGView;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(DW_CLEARANCE, DW_SCREEN_H/3, DW_BG_W, DW_BG_W)];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 6.0;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 20, DW_BG_W - 80, DW_BG_W - 80)];
        _imageView.image = [UIImage imageNamed:_imageName];
    }
    return _imageView;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake((DW_BG_W - DW_LAB_W)/2, [DWDealConstant getImageViewMaxY:_imageView] + 10, DW_LAB_W, [DWDealConstant getTextHeight:_title Font:DW_FONT(16)])];
        _titleLab.font = DW_FONT(16);
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.numberOfLines = 0;
        _titleLab.text = _title;
    }
    return _titleLab;
}

@end
