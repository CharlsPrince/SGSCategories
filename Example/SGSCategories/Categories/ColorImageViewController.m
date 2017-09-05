//
//  ColorImageViewController.m
//  SGSLibraryDemo
//
//  Created by Lee on 16/8/24.
//  Copyright © 2016年 arKenLee. All rights reserved.
//

#import "ColorImageViewController.h"
#import "UIColor+SGS.h"
#import "UIImage+SGS.h"

@interface ColorImageViewController ()
@property (weak, nonatomic) IBOutlet UITextField *colorField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (assign, nonatomic) CGSize imgSize;
@property (copy, nonatomic) NSString *hexStr;
@property (assign, nonatomic) int flag;
@property (assign, nonatomic) CGFloat angle;
@end

@implementation ColorImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imgSize = _imageView.bounds.size;
    
    // 默认图片
    self.hexStr = @"#ffffff";
    UIColor *color = [UIColor colorWithHexString:self.hexStr];
    _imageView.image = [UIImage imageWithColor:color size:_imgSize];
    _flag = 1;
    _angle = 0;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)saveColor {
    NSString *hexStr = _colorField.text;
    if (hexStr.length == 0) {
        [self showAlert:@"颜色值不能为空" message:@"请重新输入"];
        return NO;
    }
    
    self.hexStr = hexStr;
    return YES;
}

- (UIImage *)rectImg {
    UIColor *color = [UIColor colorWithHexString:self.hexStr];
    if (color == nil) {
        [self showAlert:@"输入的颜色值不合法" message:@"请重新输入"];
        return nil;
    }
    
    return [UIImage imageWithColor:color size:_imgSize];
}

- (UIImage *)roundRectImg {
    UIImage *img = [self rectImg];
    return [img roundRectWithCornerRadius:30];
}

- (UIImage *)roundImage {
    UIImage *img = [self rectImg];
    return [img roundImage];
}

- (IBAction)createColorImg:(UIButton *)sender {
    if ([self saveColor]) {
        _flag = 1;
        _angle = 0;
        _imageView.image = [self rectImg];
    }
}

- (IBAction)createRoundRectImg:(UIButton *)sender {
    if ([self saveColor]) {
        _flag = 2;
        _angle = 0;
        _imageView.image = [self roundRectImg];
    }
}

- (IBAction)createCircleImg:(UIButton *)sender {
    if ([self saveColor]) {
        _flag = 3;
        _angle = 0;
        _imageView.image = [self roundImage];
    }
}

- (IBAction)left:(UIButton *)sender {
    UIImage *img = _imageView.image;
    if (img) {
        switch (_flag) {
            case 1:
                img = [self rectImg];
                break;
                
            case 2:
                img = [self roundRectImg];
                break;
                
            case 3:
                img = [self roundImage];
                break;
                
            default:
                break;
        }
        
        _angle += 30.0;
        _imageView.image = [img rotate:DegreesToRadians(_angle) fitSize:NO];
    }
}

- (IBAction)right:(UIButton *)sender {
    UIImage *img = _imageView.image;
    if (img) {
        switch (_flag) {
            case 1:
                img = [self rectImg];
                break;
                
            case 2:
                img = [self roundRectImg];
                break;
                
            case 3:
                img = [self roundImage];
                break;
                
            default:
                break;
        }
        
        _angle -= 30.0;
        _imageView.image = [img rotate:DegreesToRadians(_angle) fitSize:NO];
    }
}



@end
