/*!
 @header CALayerPresentingViewController.m
  
 @author Created by Lee on 16/9/14.
 
 @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "CALayerPresentingViewController.h"

@interface CALayerPresentingViewController ()

@end

@implementation CALayerPresentingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeView:)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipe];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

- (void)swipeView:(UISwipeGestureRecognizer *)sender {
    [self.navigationController.view.layer addTransitionWithAnimType:_transType direction:SGSTransitionDirectionBottom timing:kNilOptions duration:0.4];
    [self.navigationController popViewControllerAnimated:NO];
}

@end
