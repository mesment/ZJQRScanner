//
//  ZJTestViewController.m
//  ZJQRCodeScaner
//
//  Created by ZeroJ on 16/11/1.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJTestViewController.h"
#import "ZJQRScannerView.h"
#import "ZJQRScanerHelper.h"
#import "ZJProgressHUD.h"
@interface ZJTestViewController ()
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImage *qrImage;

@property (strong, nonatomic) ZJQRScannerView *scanner;
@end

@implementation ZJTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 停止
    [_scanner stopScanning];
}

- (void)startScanner {
    [ZJProgressHUD showStatus:@"需要真机测试" andAutoHideAfterTime:1.0];
    
    _scanner = [ZJQRScannerView new];
    _scanner.frame = self.view.bounds;
    [self.view addSubview:_scanner];

    // 开始扫描
    [_scanner startScanning];
    // 扫描完成
    [_scanner setScannerFinishHandler:^(ZJQRScannerView *scanner, NSString *resultString) {
        // 扫描结束
        NSLog(@"内容是%@", resultString);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setQrImage:(UIImage *)qrImage {
    _imageView = [[UIImageView alloc] initWithImage:qrImage];
    _imageView.center = self.view.center;
    [self.view addSubview:_imageView];
}

- (void)createCodeWithQRString:(NSString *)qrString andLogoImage:(UIImage *)logo {
    UIImage *qrImage = [ZJQRScanerHelper createQRCodeWithString:qrString withSideLength:200.f];
    // 改变颜色
    qrImage = [ZJQRScanerHelper changeColorForQRImage:qrImage backgroundColor:[UIColor redColor] frontColor:[UIColor blueColor]];
    if (logo) {
        qrImage = [ZJQRScanerHelper composeQRCodeImage:qrImage withImage:logo withImageSideLength:40.f];

    }
    self.qrImage = qrImage;

}

- (void)recognizedQRImage:(UIImage *)qrImage {
    NSString *result = [ZJQRScanerHelper recognizeQRCodeFromImage:qrImage];
    NSLog(@"二维码内容: %@", result);
    [ZJProgressHUD showStatus:[NSString stringWithFormat:@"二维码内容:%@", result] andAutoHideAfterTime:2.0];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
