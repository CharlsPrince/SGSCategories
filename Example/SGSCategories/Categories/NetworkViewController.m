/*!
 @header NetworkViewController.m
 
 @author Created by Lee on 16/9/19.
 
 @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "NetworkViewController.h"
#import <SGSCategories/NSURL+SGS.h>
#import <SGSCategories/NSMutableURLRequest+SGS.h>
#import <SGSCategories/NSURLSession+SGS.h>
#import "NetworkConfig.h"

@interface NetworkViewController ()
@property (weak, nonatomic) IBOutlet UITextView *stringView;
@property (weak, nonatomic) IBOutlet UITextView *jsonView;
@property (weak, nonatomic) IBOutlet UITextView *ldytView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *stringLoadingIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *jsonLoadingIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *ldytLoadingIndicator;

@property (strong, nonatomic) NSURL *pmsBaseURL;
@property (copy, nonatomic) NSString *userId;

@end

@implementation NetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _pmsBaseURL = [NSURL URLWithString:@"http://172.16.44.226:8090/wxzjapp"];
}

- (IBAction)fetchString:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:@"GetRSA" relativeToURL:_pmsBaseURL];
    
    __weak typeof(self) weakSelf = self;
    
    [_stringLoadingIndicator startAnimating];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession]
                                  dataTaskWithURL:url
                                  responseFilter:[NSURLSession responseStringFilter]
                                  success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
                                      
                                      [weakSelf.stringLoadingIndicator stopAnimating];
                                      weakSelf.stringView.text = [NSString stringWithFormat:@"请求成功: \n%@", responseObject];
                                      
                                  } failure:^(NSURLResponse * _Nullable response, NSError * _Nonnull error) {
                                      
                                      [weakSelf.stringLoadingIndicator stopAnimating];
                                      weakSelf.stringView.text = [NSString stringWithFormat:@"请求失败: \n%@", error.localizedDescription];
                                      
                                  }];
    [task resume];
}

- (IBAction)fetchJSON:(UIButton *)sender {
    NSDictionary *params = @{@"loginName": @"benny",
                             @"password": @"7C4A8D09CA3762AF61E59520943DC26494F8941B",
                             @"channelId": @"4827911715829212868"};
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.10.72:8085/hn_ldyt_rmis/service/mobileLogin.do" parameters:params];
    
    __weak typeof(self) weakSelf = self;
    
    [_jsonLoadingIndicator startAnimating];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession]
                                  dataTaskWithURL:url
                                  responseFilter:[NSURLSession responseJSONFilter]
                                  success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
                                      
                                      [weakSelf.jsonLoadingIndicator stopAnimating];
                                      weakSelf.userId = [[responseObject objectForKey:@"results"] objectForKey:@"userID"];
                                      weakSelf.jsonView.text = [NSString stringWithFormat:@"请求成功: \n%@", responseObject];
                                      
                                  } failure:^(NSURLResponse * _Nullable response, NSError * _Nonnull error) {
                                      
                                      [weakSelf.jsonLoadingIndicator stopAnimating];
                                      weakSelf.jsonView.text = [NSString stringWithFormat:@"请求失败: \n%@", error.localizedDescription];
                                      
                                  }];
    [task resume];
}

- (IBAction)fetchLDYTJson:(UIButton *)sender {
    NSString *urlString = @"http://192.168.10.72:8085/hn_ldyt_openapi/api/schedule/findList.do";
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_userId, @"userId", nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest httpRequestWithMethod:SGSHTTPMethodPOST
                                                                    URLString:urlString
                                                                   parameters:params];
    
    __weak typeof(self) weakSelf = self;
    
    [_ldytLoadingIndicator startAnimating];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request
                                        responseFilter:[NetworkConfig ldytResponseFilter]
                                               success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
                                                   
                                                   [weakSelf.ldytLoadingIndicator stopAnimating];
                                                   weakSelf.ldytView.text = [NSString stringWithFormat:@"请求成功: \n%@", responseObject];
                                                   
                                               } failure:^(NSURLResponse * _Nullable response, NSError * _Nonnull error) {
                                                   
                                                   [weakSelf.ldytLoadingIndicator stopAnimating];
                                                   weakSelf.ldytView.text = [NSString stringWithFormat:@"请求失败: \n%@", error.localizedDescription];
                                               }]
     resume];
}

@end
