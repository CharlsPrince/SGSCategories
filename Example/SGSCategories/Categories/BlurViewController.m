//
//  BlurViewController.m
//  SGSCategories
//
//  Created by Lee on 16/9/2.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "BlurViewController.h"
#import <SGSCategories/UIVisualEffectView+SGS.h>

@interface BlurViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation BlurViewController

- (IBAction)blurEffect:(UIButton *)sender {
    UIVisualEffectView *blurView = [UIVisualEffectView blurViewWithFrame:self.view.bounds
                                                             effectStyle:UIBlurEffectStyleDark];
    
    [blurView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                    initWithTarget:self action:@selector(tapBlurView:)]];
    
    UILabel *label = [self labelWithFrame:_imageView.frame];
    [blurView.contentView addSubview:label];
    
    [self.view addSubview:blurView];
}

- (IBAction)blurEffectAndVibrancy:(UIButton *)sender {
    UIVisualEffectView *blurView = [UIVisualEffectView blurViewWithFrame:self.view.bounds
                                                             effectStyle:UIBlurEffectStyleDark
                                                           vibrancyFrame:_imageView.frame];
    
    [blurView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                    initWithTarget:self action:@selector(tapBlurView:)]];
    
    UIVisualEffectView *vibrancyView = blurView.contentView.subviews.firstObject;
    
    UILabel *label = [self labelWithFrame:_imageView.bounds];
    [vibrancyView.contentView addSubview:label];
    
    [self.view addSubview:blurView];
}

- (void)tapBlurView:(UITapGestureRecognizer *)sender {
    [sender.view removeFromSuperview];
}

- (UILabel *)labelWithFrame:(CGRect)frame {

    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    
    label.text          = @"Vibrancy Effect";
    label.font          = [UIFont systemFontOfSize:30];
    label.textColor     = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}

@end
