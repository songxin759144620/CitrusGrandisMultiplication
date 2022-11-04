//
//  MBProgressHUD+XM.h
//  HUD
//
//  Created by 大大东 on 2020/6/2.
//  Copyright © 2020 大大东. All rights reserved.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@protocol XM_MBHUDTouchThroughProtocol <NSObject>
/// ViewController实现才有效
/// 一个便捷的方案 ViewController增加 允许touch事件穿透HUD的视图区域
/// 一般这里return页面中的 关闭/返回按钮 (用以解决 hud 动画过程中页面无法关闭的 问题)
- (nullable UIView *)hud_allowTouchAreaView;
@end


@interface MBProgressHUD (XM)

/// 一个允许事件穿透的Rect (坐标系必须是相对于 HUD 视图的)
/// 默认HUD弹出时大小和父视图相同，会遮挡点击事件，可以通过此属性允许部分区域点击可以穿透hud
@property (nonatomic) CGRect allowTouchRect;


/// 一个提示
/// @param message 展示的文本
/// @param view    如果为nil, 自动取AppDelegate.window
+ (void)xm_showTipMessage:(NSString *)message inview:(nullable UIView *)view;

/// 一个提示
/// @param message    展示的文本
/// @param detaileMsg 展示的子文本
/// @param aTime      显示时长
/// @param view       如果为nil, 自动取AppDelegate.window
/// @param config     自定义配置
+ (void)xm_showTipMessage:(NSString *)message detaileMsg:(nullable NSString *)detaileMsg time:(CGFloat)aTime inview:(nullable UIView *)view hudConfig:(void(^ _Nullable)(MBProgressHUD *hud))config;

// 一个提示 对号
+ (void)xm_showTipSuccess:(NSString *)Message inview:(nullable UIView *)view;
// 一个提示 哭脸
+ (void)xm_showTipError:(NSString *)Message inview:(nullable UIView *)view;
// 一个提示 笑脸
+ (void)xm_showTipInfo:(NSString *)Message inview:(nullable UIView *)view;
// 一个提示 叹号
+ (void)xm_showTipWarning:(NSString *)Message inview:(nullable UIView *)view;

// 一个提示 自定义图片
+ (void)xm_showTipWithCustomView:(UIView *)customView message:(nullable NSString *)message inview:(nullable UIView *)view time:(CGFloat)aTime hudConfig:(void(^ _Nullable)(MBProgressHUD *hud))config;




/// 一个Loading
/// @param message  展示的文本
/// @param view     如果为nil, 自动取AppDelegate.window
+ (void)xm_showLoading:(nullable NSString *)message inview:(nullable UIView *)view;

/// 一个Loading
/// @param message  展示的文本
/// @param graceTime  延迟xx时间显示 用于避免持续时间极短的loading
/// @param view     如果为nil, 自动取AppDelegate.window
+ (void)xm_showLoading:(nullable NSString *)message graceTime:(NSTimeInterval)graceTime inview:(nullable UIView *)view;

/// 一个Loading
/// @param cusView 自定义的view
/// @param message 文本
/// @param view    如果为nil, 自动取AppDelegate.window
/// @param config 自定义配置回调
+ (void)xm_showLoadingWithCustomView:(UIView *)cusView message:(nullable NSString *)message inview:(nullable UIView *)view hudConfig:(void (^ _Nullable)(MBProgressHUD *))config;



/// 隐藏hud
/// @param view 如果为nil, 自动取AppDelegate.window
+ (void)xm_hideAllHUD:(nullable UIView *)view;

@end
NS_ASSUME_NONNULL_END
