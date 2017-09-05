//
//  DateViewController.m
//  SGSLibraryDemo
//
//  Created by Lee on 16/8/24.
//  Copyright © 2016年 arKenLee. All rights reserved.
//

#import "DateViewController.h"
#import "DatePickerViewController.h"
#import "NSDate+SGS.h"
#import "NSDateFormatter+SGS.h"


@interface DateViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSDate *date;

@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (IBAction)selectDate:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    DatePickerViewController *dpVC = [sb instantiateViewControllerWithIdentifier:@"DatePicker"];
    
    [dpVC setCallBack:^(NSDate * _Nullable date) {
        if (date != nil) {
            self.date = date;
            [self.tableView reloadData];
        }
    }];
    
    dpVC.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    dpVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    dpVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:dpVC animated:YES completion:nil];
}

- (NSArray *)titles {
    return Lazy(_titles, @[@"yyyy-MM-dd'T'HH:mm:ss+0800", @"yyyy-MM-dd HH:mm:ss", @"yyyy-M-d H:mm", @"yyyy-MM", @"yyyy年M月", @"yyyy-MM-dd", @"yyyy年M月d日", @"MM-dd", @"M月d日", @"AM/PM h:mm", @"常用格式"]);
}

- (void)handleCell:(UITableViewCell *)cell withSection:(NSInteger)section {
    if (_date == nil) return;
    
    switch (section) {
        case 0:
            cell.textLabel.text = _date.stringWithISO8601InternetDateTimeFormat;
            break;
        case 1:
            cell.textLabel.text = _date.stringWithISO8601FullDateAndTimeFormat;
            break;
        case 2:
            cell.textLabel.text = _date.stringWithShortCommonFormat;
            break;
        case 3:
            cell.textLabel.text = _date.stringWithISO8601YearAndMonthFormat;
            break;
        case 4:
            cell.textLabel.text = _date.stringWithYearAndMonthFormatOnChinese;
            break;
        case 5:
            cell.textLabel.text = _date.stringWithISO8601FullDateFormat;
            break;
        case 6:
            cell.textLabel.text = _date.stringWithYearMonthAndDayFormatOnChinese;
            break;
        case 7:
            cell.textLabel.text = _date.stringWithISO8601MonthAndDayFormat;
            break;
        case 8:
            cell.textLabel.text = _date.stringWithMonthAndDayFormatOnChinese;
            break;
        case 9:
            cell.textLabel.text = _date.stringWithHourAndMinuteFormatOnChinese;
            break;
        case 10:
            cell.textLabel.text = [_date stringWithCommonFormatAndShowThisYear:NO];
            break;
            
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.titles[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [self handleCell:cell withSection:indexPath.section];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0;
}

@end
