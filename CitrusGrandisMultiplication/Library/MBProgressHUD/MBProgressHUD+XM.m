//
//  MBProgressHUD+XM.m
//
//
//  Created by 大大东 on 2020/6/2.
//  Copyright © 2020 大大东. All rights reserved.
//

#import "MBProgressHUD+XM.h"
#import <objc/runtime.h>


static CGFloat _defult_dutation = 1.8;

@implementation MBProgressHUD (XM)

- (CGRect)allowTouchRect {
    NSValue *val = objc_getAssociatedObject(self, @selector(allowTouchRect));
    if (val) {
        return [val CGRectValue];
    }
    
    // 向下找到第一个vc
    UIResponder *vc = self.nextResponder;
    while (vc) {
        if ([vc isKindOfClass:[UIViewController class]]) {
            break;
        }
        vc = vc.nextResponder;
    }
    
    if (vc && [vc respondsToSelector:@selector(hud_allowTouchAreaView)]) {
        __weak  id<XM_MBHUDTouchThroughProtocol> target = vc;
        UIView *view = [target hud_allowTouchAreaView];
        if (view && view.window == self.window) {
            CGRect rect = [view convertRect:view.bounds toView:self];
            // 取相交rect
            return CGRectIntersection(rect, self.bounds);
        }
    }
    return CGRectZero;
}
- (void)setAllowTouchRect:(CGRect)allowTouchRect {
    if (CGRectIsEmpty(allowTouchRect)) {
        return;
    }
    objc_setAssociatedObject(self, @selector(allowTouchRect), [NSValue valueWithCGRect:allowTouchRect], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {

    if (CGRectContainsPoint(self.allowTouchRect, point)) {
        // 在允许区域
        return NO;
    }
    return [super pointInside:point withEvent:event];
}

#pragma mark - Private

+ (MBProgressHUD*)p_createMBProgressHUDviewWithMessage:(NSString *)message inView:(UIView *)inview {
    UIView  *view = inview ? inview : (UIView*)[UIApplication sharedApplication].delegate.window;
    
    [self xm_hideAllHUD:view];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.label.text = message;
    hud.label.numberOfLines = 0;
    hud.removeFromSuperViewOnHide = YES;
    // 默认拦截手势 tip需要关掉
    hud.userInteractionEnabled = YES;
    // 文字 菊花颜色
    hud.contentColor = UIColor.whiteColor;
    // hudView背景
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor.blackColor colorWithAlphaComponent:0.75];
    hud.bezelView.layer.cornerRadius = 12.f;
    // 
    [view addSubview:hud];
    
    return hud;
}

#pragma mark - ------------------- show Tip----------------------------
+ (void)xm_showTipMessage:(NSString *)message inview:(UIView *)view {
    [self xm_showTipMessage:message detaileMsg:nil time:_defult_dutation inview:view hudConfig:nil];
}

+ (void)xm_showTipMessage:(NSString *)message detaileMsg:(NSString *)detaileMsg time:(CGFloat)aTime inview:(UIView *)view hudConfig:(void (^)(MBProgressHUD *))config {
    
    MBProgressHUD *hud = [self p_createMBProgressHUDviewWithMessage:message inView:view];
    hud.mode = MBProgressHUDModeText;
    if (detaileMsg) {
        hud.detailsLabel.text = detaileMsg;
    }
    hud.userInteractionEnabled = NO;
    // 顺序不能变
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:aTime];
    if (config) {
        config(hud);
    }
}

#pragma mark-------------------- show Tip(Image) ----------------------------

+ (void)xm_showTipSuccess:(NSString *)Message inview:(UIView *)view {
    NSString *name = @"MBHUD_Success.png";
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
    [self xm_showTipWithCustomView:imgView message:Message inview:view time:_defult_dutation hudConfig:nil];
}
+ (void)xm_showTipError:(NSString *)Message inview:(UIView *)view {
    NSString *name = @"MBHUD_Error.png";
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
    [self xm_showTipWithCustomView:imgView message:Message inview:view time:_defult_dutation hudConfig:nil];

}
+ (void)xm_showTipInfo:(NSString *)Message inview:(UIView *)view {
    NSString *name = @"MBHUD_Info.png";
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
    [self xm_showTipWithCustomView:imgView message:Message inview:view time:_defult_dutation hudConfig:nil];

}
+ (void)xm_showTipWarning:(NSString *)Message inview:(UIView *)view {
    NSString *name = @"MBHUD_Warn.png";
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
    [self xm_showTipWithCustomView:imgView message:Message inview:view time:_defult_dutation hudConfig:nil];
}

+ (void)xm_showTipWithCustomView:(UIView *)customView message:(NSString *)message inview:(UIView *)view time:(CGFloat)aTime hudConfig:(void (^)(MBProgressHUD *))config {
    
    MBProgressHUD *hud = [self p_createMBProgressHUDviewWithMessage:message inView:view];
    hud.customView = customView;
    hud.mode = MBProgressHUDModeCustomView;
    hud.userInteractionEnabled = NO;
    // 顺序不能变
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:aTime];
    if (config) {
        config(hud);
    }
}
#pragma mark - ------------------- show Activity----------------------------

+ (void)xm_showLoading:(NSString *)message inview:(UIView *)view {
    [self xm_showLoading:message graceTime:0 inview:view];
}

+ (void)xm_showLoading:(NSString *)message graceTime:(NSTimeInterval)graceTime inview:(UIView *)view {
    
    MBProgressHUD *hud  =  [self p_createMBProgressHUDviewWithMessage:message inView:view];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.graceTime = graceTime;
    [hud showAnimated:YES];
}

+ (void)xm_showLoadingWithCustomView:(UIView *)cusView message:(NSString *)message inview:(UIView *)view hudConfig:(void (^)(MBProgressHUD *))config {
    
    MBProgressHUD *hud  =  [self p_createMBProgressHUDviewWithMessage:message inView:view];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = cusView;
    [hud showAnimated:YES];
    if (config) {
        config(hud);
    }
}

+ (void)xm_hideAllHUD:(UIView *)view {
    UIView  *winView = view ? : (UIView*)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:winView animated:YES];
}

@end

