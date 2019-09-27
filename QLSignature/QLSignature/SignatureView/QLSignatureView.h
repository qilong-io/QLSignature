//
//  QLSignatureView.h
//  QLSignature
//
//  Created by ql on 2019/9/27.
//  Copyright © 2019 qilong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QLSignatureView;

NS_ASSUME_NONNULL_BEGIN


@protocol QLsignViewDelegate <NSObject>


- (void)QLSignatureView:(QLSignatureView *)signatureview backImage:(UIImage *)image;

@end


@interface QLSignatureView : UIView

/// 线宽 默认1
@property (nonatomic, assign) CGFloat lineWidth;
/// 线颜色 默认黑
@property (nonatomic, strong) UIColor *lineColor;
/// 生成图片的缩放比例 默认1不缩放 范围0.1~1.0
@property (nonatomic, assign) CGFloat imageScale;
/// 生成的图片
@property (nonatomic, strong) UIImage *signImage;

@property (nonatomic,weak)id<QLsignViewDelegate>delegate;

/// 初始化视图之后调用 准备画图
- (void)startDraw;
/// 重置
- (void)resetDraw;
/// 保存成图片
- (void)saveDraw;
/// 截屏
- (UIImage *)captureWithView:(UIView *)view;



@end


NS_ASSUME_NONNULL_END
