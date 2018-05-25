//
//  ViewController.m
//  DWHudViewDemo
//
//  Created by CrazyDavy on 2018/5/25.
//  Copyright © 2018年 Crazy Davy. All rights reserved.
//

#import "ViewController.h"
#import "DWHudManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click:(id)sender {
    [[DWHudManager sharedInstance] showLoading];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[DWHudManager sharedInstance] hideLoading];
    });
}

- (IBAction)popup:(id)sender {
    [[DWHudManager sharedInstance] showPopupWithTitle:@"I'm title" imageName:@"loading"];
}

@end
