//
//  DatePickerViewController.m
//  SGSLibraryDemo
//
//  Created by Lee on 16/8/24.
//  Copyright © 2016年 arKenLee. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) NSDate *date;
@end

@implementation DatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _date = _datePicker.date;
}

- (void)dealloc
{
    NSLog(@"DatePickerViewController 销毁");
}

- (IBAction)dateChange:(UIDatePicker *)sender {
    _date = sender.date;
}

- (IBAction)okButtonClicked:(UIButton *)sender {
    if (self.callBack != nil) {
        self.callBack(_date);
    }
    
    [self dismiss];
    
}

- (IBAction)cancelButtonClicked:(UIButton *)sender {
    if (self.callBack != nil) {
        self.callBack(nil);
    }
    
    [self dismiss];
}

- (void)dismiss {
    self.callBack = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
