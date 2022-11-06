//
//  CALayer+BorderColor.m
//  CitrusGrandisMultiplication
//
//  Created by xin   song on 2022/11/6.
//

#import "CALayer+BorderColor.h"
#import <UIKit/UIKit.h>

@implementation CALayer (BorderColor)
- (void)setBorderColorWithUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}
@end
