//
//  CHYSlider.h
//  CHYSliderDemo
//
//  Created by Chen Chris on 8/16/12.
//  Copyright (c) 2012 ciderstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHYSlider : UIControl {
    BOOL _thumbOn;                              // track the current touch state of the slider
    UIImageView *_trackImageViewNormal;         // slider track image in normal state
}

/**
 same properties by referring UISlider
 */
@property(nonatomic) float value;                           // default 0.0. this value will be pinned to min/max
@property(nonatomic) float minimumValue;                    // default 0.0. the current value may change if outside new min value
@property(nonatomic) float maximumValue;                    // default 1.0. the current value may change if outside new max value
@property(nonatomic,getter=isContinuous) BOOL continuous;   // if set, value change events are generated any time the value changes due to dragging. default = YES

@property (nonatomic) BOOL isFontSize;//是否为设置字体大小,默认情况下是设置字体大小，默认值为YES

@property (nonatomic, strong) void (^sliderValueBlock)(BOOL isSize, float fontSize, UIColor *selectColor);

/**
 Use these properties to customize UILabel font and color
 */
@property(nonatomic) UILabel *labelOnThumb;                 // overlayed above the thumb knob, moves along with the thumb You may customize its `font`, `textColor` and other properties.

@property(nonatomic) int decimalPlaces;                     // determin how many decimal places are displayed in the value labels

- (id)initWithFrame:(CGRect)frame withIsFontSize:(BOOL)_isSize;

@end
