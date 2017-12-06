//
//  UIViewController+HUD.h
//  DLSwiftLearning
//
//  Created by denglong on 04/12/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)
- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)hideHud;

- (void)showHint:(NSString *)hint;

// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;  
@end
