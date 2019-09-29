# QLSignature
iOS 手写签名
### 使用场景
用于电子版文件协议在手机上手写签名

### pod 导入
pod 'QLSignature', '~> 0.3'

### 使用方法

```
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

#pragma mark ========== QLsignViewDelegate ==============
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
```

可设置属性

```
/// 线宽 默认1
@property (nonatomic, assign) CGFloat lineWidth;
/// 线颜色 默认黑
@property (nonatomic, strong) UIColor *lineColor;
/// 生成图片的缩放比例 默认1不缩放 范围0.1~1.0
@property (nonatomic, assign) CGFloat imageScale;
```