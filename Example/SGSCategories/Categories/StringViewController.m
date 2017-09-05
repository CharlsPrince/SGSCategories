//
//  StringViewController.m
//  SGSLibraryDemo
//
//  Created by Lee on 16/8/24.
//  Copyright © 2016年 arKenLee. All rights reserved.
//

#import "StringViewController.h"
#import "NSString+SGS.h"

/**
 *  32020019780916151X
 *  320200199002234457
 *  320200198901273439
 *  32020019850623347X
 *  320200198008177639
 */

@interface StringViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextField *cardField;
@property (weak, nonatomic) IBOutlet UITextField *mobilePhoneField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *postcodeField;
@property (weak, nonatomic) IBOutlet UITextField *qqField;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *ipv4Field;
@property (weak, nonatomic) IBOutlet UITextView *jsonField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewBottomLayout;

@property (strong, nonatomic) NSDictionary *json;

@end

@implementation StringViewController

#pragma mark - Override
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Notification

- (void)keyboardWillShow:(NSNotification *)noti {
    CGRect kbFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 获取不到键盘高度
    if (CGRectIsNull(kbFrame)) return;
    
    __weak typeof(&*self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.scrollViewBottomLayout.constant = kbFrame.size.height;
    }];
}

- (void)keyboardWillHide:(NSNotification *)noti {
    __weak typeof(&*self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.scrollViewBottomLayout.constant = 0;
    }];
}

#pragma mark - Private
- (void)check:(BOOL)check msg:(NSString *)msg {
    if (check) {
        [self showAlert:[@"有效的" stringByAppendingString:msg] message:nil];
    } else {
        [self showAlert:[@"无效的" stringByAppendingString:msg] message:nil];
    }
}

#pragma mark - Actions

- (IBAction)tapContentView:(UITapGestureRecognizer *)sender {
    [sender.view endEditing:YES];
}

- (IBAction)verifyCard:(UIButton *)sender {
    NSString *text = _cardField.text;
    [self check:text.validIdentificationCard msg:@"身份证号"];
}

- (IBAction)verifyMobilePhone:(UIButton *)sender {
    NSString *text = _mobilePhoneField.text;
    [self check:text.validChineseMobilePhoneNumber msg:@"中国手机号"];
}

- (IBAction)verifyPhone:(UIButton *)sender {
    NSString *text = _phoneField.text;
    [self check:text.validChinesePhoneNumber msg:@"中国座机号"];
}

- (IBAction)verifyEmail:(UIButton *)sender {
    NSString *text = _emailField.text;
    [self check:text.validEmail msg:@"电子邮箱"];
}

- (IBAction)verifyPostcode:(UIButton *)sender {
    NSString *text = _postcodeField.text;
    [self check:text.validPostcode msg:@"邮编"];
}

- (IBAction)verifyQQNumber:(UIButton *)sender {
    // 不以0开头的5-12位数字
    NSString *text = _qqField.text;
    [self check:text.validQQ msg:@"QQ号"];
}

- (IBAction)verifyUserName:(UIButton *)sender {
    // 5-20位 字母、数字或下划线或.
    NSString *text = _userNameField.text;
    [self check:text.validAccount msg:@"用户名"];
}

- (IBAction)verifyPassword:(UIButton *)sender {
    // 6-18位 大小写字母、数字、以及特殊字符
    // 特殊字符包括：空格!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
    NSString *text = _passwordField.text;
    [self check:text.validPassword msg:@"密码"];
}

- (IBAction)verifyIPV4:(UIButton *)sender {
    NSString *text = _ipv4Field.text;
    [self check:text.validIPv4 msg:@"IPv4地址"];
}

- (IBAction)json:(UIButton *)sender {

    NSString *jsonStr = [NSString stringWithJSONObject:self.json];
    NSString *jsonObj = jsonStr.toJSONObject;
        
    _jsonField.text = [NSString stringWithFormat:@"JSON字符串:\n%@\n\nJSON:\n%@", jsonStr, jsonObj.description];
}

#pragma mark - getter & setter
- (NSDictionary *)json {
    return Lazy(_json,  @{@"class1": @[@{@"p1": @{@"name": @"张三", @"age": @(20)}},
                                       @{@"p2": @{@"name": @"李四", @"age": @(15)}}],
                          @"class2": @[@{@"p1": @{@"name": @"王五", @"age": @(18)}}]});
}
@end
