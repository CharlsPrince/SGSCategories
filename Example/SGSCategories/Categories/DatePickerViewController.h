//
//  DatePickerViewController.h
//  SGSLibraryDemo
//
//  Created by Lee on 16/8/24.
//  Copyright © 2016年 arKenLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerViewController : UIViewController

@property (nullable, nonatomic, copy) void(^callBack)(NSDate * _Nullable date);

@end
