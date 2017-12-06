//
//  UIViewController+HUD.m
//  DLSwiftLearning
//
//  Created by denglong on 04/12/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//

#import "UIViewController+HUD.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <objc/runtime.h>

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation UIViewController (HUD)
- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.label.text = hint;
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    
    [self setHUD:HUD];
}

/**
 显示提醒文字

 @param hint 提醒文字
 */
- (void)showHint:(NSString *)hint{
    //显示提示信息
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
    CGPoint point = hud.offset;
    point.y = 150.f;
    hud.offset = point;
    hud.removeFromSuperViewOnHide = YES;
    
//    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:2];
}

- (void)showHint:(NSString *)hint yOffset:(float)yOffset {
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
    CGPoint point = hud.offset;
    point.y = 150.f;
    point.y += yOffset;
    hud.offset = point;
    
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}

- (void)hideHud{
    [[self HUD] hideAnimated:YES];
}  
@end
