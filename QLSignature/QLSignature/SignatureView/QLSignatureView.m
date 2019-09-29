//
//  QLSignatureView.m
//  QLSignature
//
//  Created by ql on 2019/9/27.
//  Copyright © 2019 qilong. All rights reserved.
//

#import "QLSignatureView.h"

@implementation QLSignatureView{
    /// 签名的线
    UIBezierPath *path;
    /// 上一个点
    CGPoint previousPoint;
    
    /// 储存已写的字
    NSMutableArray *imageArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _lineWidth = 1;
        _lineColor = [UIColor blackColor];
        imageArr = [[NSMutableArray alloc]init];
    }
    return self;
}

#pragma mark ========== 获取两点中点 ==============
CGPoint midpoint(CGPoint p0, CGPoint p1) {
    return (CGPoint) {
        (p0.x + p1.x) / 2.0,
        (p0.y + p1.y) / 2.0
    };
}

#pragma mark ========== 准备开始签名 ==============
- (void)startDraw
{
    // 背景色
    self.backgroundColor = [UIColor whiteColor];
    // 初始化 设置属性
    path = [UIBezierPath bezierPath];
    // 线宽
    path.lineWidth = _lineWidth;
    // 线颜色
}


#pragma mark ========== 画线刚开始，保存上一个点 ==============
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 获取点击点坐标
    UITouch * touch = touches.anyObject;
    CGPoint currentPoint = [touch locationInView:self];
    // 保存成上一点
    previousPoint = currentPoint;
    // 开始点移动到点击点
    [path moveToPoint:currentPoint];
}


#pragma mark ========== 始画线，连接上一个点和当前点 ==============
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 获取点击点坐标
    UITouch * touch = touches.anyObject;
    CGPoint currentPoint = [touch locationInView:self];
    
    // 获取两点中点
    CGPoint midPoint = midpoint(previousPoint, currentPoint);
    // 画曲线
    [path addQuadCurveToPoint:midPoint controlPoint:previousPoint];
    // 替换当前点为上一点
    previousPoint = currentPoint;
    // 画图
    [self setNeedsDisplay];
}


#pragma mark ========== 系统画线方法 ==============
- (void)drawRect:(CGRect)rect
{
    [_lineColor set];
    [path stroke];
}


#pragma mark ========== 重置path ==============
- (void)resetDraw
{
    [self startDraw];
    [self setNeedsDisplay];
    [imageArr removeAllObjects];
}


#pragma mark ========== 保存成图片 ==============
- (void)saveDraw
{
    if (path.isEmpty) {
        NSLog(@"没有签名！");
        return;
    }
    self.signImage = [self captureWithView:self];
    [path removeAllPoints];
    [self setNeedsDisplay];
    // 这里控制范围，范围可以自己定
    if (_imageScale < 0.1) {
        _imageScale = 0.1;
    }
    if (_imageScale > 1) {
        _imageScale = 1;
    }
    if (_imageScale != 1) {
        [self scaleImage];
    }
    UIImage *image = self.signImage;
    [imageArr addObject:image];
    if (imageArr.count == 2) {
        UIImage *combineImg = [self combineImageLeftImage:imageArr[0] RightImage:imageArr[1]];
        [imageArr removeAllObjects];
        [imageArr addObject:combineImg];
    }
    self.signImage = imageArr[0];
    if ([_delegate respondsToSelector:@selector(QLSignatureView:backImage:)]) {
        [_delegate QLSignatureView:self backImage:self.signImage];
    }else{
        NSLog(@"请确认是否已设置QLSignatureView代理？");
    }
}

#pragma mark ========== 缩放图片 ==============
- (UIImage *)scaleImage
{
    // 用这个方法 画质会变渣
//    UIGraphicsBeginImageContext(CGSizeMake(_signImage.size.width * _imageScale, _signImage.size.height * _imageScale));
//    [_signImage drawInRect:CGRectMake(0, 0, _signImage.size.width * _imageScale, _signImage.size.height * _imageScale)];
//    self.signImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    // 判断机型
    if([[UIScreen mainScreen] scale] == 2.0){      // @2x
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(_signImage.size.width * _imageScale, _signImage.size.height * _imageScale), NO, 2.0);
    }else if([[UIScreen mainScreen] scale] == 3.0){ // @3x ( iPhone 6plus 、iPhone 6s plus)
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(_signImage.size.width * _imageScale, _signImage.size.height * _imageScale), NO, 3.0);
    }else{
        UIGraphicsBeginImageContext(CGSizeMake(_signImage.size.width * _imageScale, _signImage.size.height * _imageScale));
    }
    // 绘制改变大小的图片
    [_signImage drawInRect:CGRectMake(0, 0, _signImage.size.width * _imageScale, _signImage.size.height * _imageScale)];
    // 从当前context中创建一个改变大小后的图片
    _signImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    
    return self.signImage;
}


#pragma mark ========== 截屏 ==============
- (UIImage *)captureWithView:(UIView *)view
{
    CGRect screenRect = [view bounds];
    UIGraphicsBeginImageContext(screenRect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark ========== 图片左右拼接 ==============
- (UIImage *)combineImageLeftImage:(UIImage *)LeftImage  RightImage:(UIImage *)rightImage{
    
    UIImage * image1 = LeftImage;
    UIImage * image2 = rightImage;
    
    if (image1 == nil) {
        return image2;
    }
    CGFloat width = image1.size.width + image2.size.width;
    CGFloat height = image1.size.height > image2.size.height ? image1.size.height : image2.size.height;
    CGSize offScreenSize = CGSizeMake(width, height);
    // UIGraphicsBeginImageContext(offScreenSize);用这个重绘图片会模糊
    UIGraphicsBeginImageContextWithOptions(offScreenSize, NO, [UIScreen mainScreen].scale);
    
    CGRect rectUp = CGRectMake(0, 0, image1.size.width, image1.size.height);
    [image1 drawInRect:rectUp];
    
    CGRect rectDown = CGRectMake( rectUp.origin.x + rectUp.size.width , (height - image2.size.height)/2, image2.size.width, image2.size.height);
    [image2 drawInRect:rectDown];
    
    UIImage* imagez = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imagez;
}

@end
