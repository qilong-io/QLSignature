//
//  ViewController.m
//  QLSignature
//
//  Created by ql on 2019/9/27.
//  Copyright © 2019 qilong. All rights reserved.
//

#import "ViewController.h"
#import "QLSignatureView.h"

@interface ViewController ()<QLsignViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *signatureBackView;
@property (weak, nonatomic) IBOutlet UIImageView *signatureImageView;

@property (nonatomic, strong) QLSignatureView *signView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.signatureBackView.layer.borderWidth = 2;
    self.signatureBackView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.signatureBackView addSubview:self.signView];
}

- (IBAction)saveAction:(UIButton *)sender {
    [_signView saveDraw];
}

- (IBAction)reSignatureAction:(UIButton *)sender {
    [_signView resetDraw];
    self.signatureImageView.image = nil;
}

- (void)QLSignatureView:(QLSignatureView *)signatureview backImage:(UIImage *)image{
    self.signatureImageView.image = image;
}

#pragma mark ========== signView ==============
- (QLSignatureView *)signView{
    if (!_signView) {
        _signView = [[QLSignatureView alloc] initWithFrame:self.signatureBackView.bounds];
        _signView.lineColor = [UIColor redColor];
        _signView.lineWidth = 4;
        _signView.imageScale = 0.5;
        _signView.delegate = self;
        [_signView startDraw];
    }
    return _signView;
}

@end
