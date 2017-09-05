/*!
 @header CALayerViewController.m
  
 @author Created by Lee on 16/9/14.
 
 @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "CALayerViewController.h"
#import "CALayer+SGS.h"
#import "CALayerPresentingViewController.h"

@interface CALayerViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *transTypes;
@property (nonatomic, assign) SGSTransitionType transType;
@property (nonatomic, assign) NSInteger idx;
@end

@implementation CALayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"淡出淡入";
    _transType = SGSTransitionTypeFade;
    
    NSMutableArray *imgs = [NSMutableArray array];
    NSArray *imgNames = @[@"国情专题", @"规划专题", @"基础地图"];
    for (NSString *name in imgNames) {
        UIImage *image = [UIImage imageNamed:name];
        if (image) [imgs addObject:image];
    }
    
    _images          = imgs.copy;
    _imageView.image = _images.firstObject;
    _idx             = 0;
    _label.text = @(_idx).description;
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeView:)];
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipe];

    NSArray *directions = @[@(UISwipeGestureRecognizerDirectionRight),
                           @(UISwipeGestureRecognizerDirectionLeft),
                           @(UISwipeGestureRecognizerDirectionUp),
                           @(UISwipeGestureRecognizerDirectionDown)];
    
    for (NSNumber *dir in directions) {
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeImageView:)];
        swipe.direction = dir.unsignedIntegerValue;
        [_imageView addGestureRecognizer:swipe];
    }
}

// 选择动画类型
- (IBAction)selectAnimType:(UIBarButtonItem *)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"选择动画类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [self.transTypes enumerateObjectsUsingBlock:^(NSString * title, NSUInteger idx, BOOL * stop) {
        [actionSheet addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.navigationItem.title = title;
            self.transType = idx;
        }]];
    }];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

// 弹出视图
- (void)swipeView:(UISwipeGestureRecognizer *)sender {
    CALayerPresentingViewController *vc = [[CALayerPresentingViewController alloc] init];
    vc.transType = _transType;
    [self.navigationController pushViewController:vc animated:NO];
    [self.navigationController.view.layer addTransitionWithAnimType:_transType direction:SGSTransitionDirectionTop timing:kNilOptions duration:0.4];
}

// 滑动切换图片
- (void)swipeImageView:(UISwipeGestureRecognizer *)sender {
    NSInteger index = 0;
    SGSTransitionDirection direction = kNilOptions;
    
    if (sender.direction & UISwipeGestureRecognizerDirectionRight) {
        index = [self nextIndex];
        direction = SGSTransitionDirectionLeft;
    } else if (sender.direction & UISwipeGestureRecognizerDirectionLeft) {
        index = [self prevIndex];
        direction = SGSTransitionDirectionRight;
    } else if (sender.direction & UISwipeGestureRecognizerDirectionUp) {
        index = [self prevIndex];
        direction = SGSTransitionDirectionTop;
    } else if (sender.direction & UISwipeGestureRecognizerDirectionDown) {
        index = [self nextIndex];
        direction = SGSTransitionDirectionBottom;
    }
    
    UIImage *img = _images[index];
    _imageView.image = img;
    _label.text = @(index).description;
    
    // 添加过场动画
    [_imageView.layer addTransitionWithAnimType:_transType direction:direction timing:kNilOptions duration:-1];
}

- (NSInteger)nextIndex {
    _idx++;
    if (_idx >= _images.count) {
        _idx = 0;
    }
    return _idx;
}

- (NSInteger)prevIndex {
    _idx--;
    if (_idx < 0) {
        _idx = _images.count - 1;
    }
    return _idx;
}

- (NSArray *)transTypes {
    if (!_transTypes) {
        _transTypes = @[@"淡出淡入", @"新视图移动到旧视图上", @"新视图推出旧视图",
                        @"移开旧视图显示新视图", @"翻转效果", @"立方体翻转效果", @"收缩效果",
                        @"波纹效果", @"向上翻页效果", @"向下翻页效果", @"摄像头打开效果",
                        @"摄像头关闭效果"];
    }
    return _transTypes;
}

@end
