//
//  CHYSlider.m
//  CHYSliderDemo
//
//  Created by Chen Chris on 8/16/12.
//  Copyright (c) 2012 ciderstudios.com. All rights reserved.
//

#import "CHYSlider.h"
#import <QuartzCore/QuartzCore.h>

@interface CHYSlider ()
- (void)commonInit;
- (float)xForValue:(float)value;
- (float)valueForX:(float)x;
- (float)stepMarkerXCloseToX:(float)x;
- (NSString *)valueStringFormat;                // form value string format with given decimal places
@end

@implementation CHYSlider
@synthesize value = _value;
@synthesize minimumValue = _minimumValue;
@synthesize maximumValue = _maximumValue;
@synthesize continuous = _continuous;
@synthesize labelOnThumb = _labelOnThumb;
@synthesize decimalPlaces = _decimalPlaces;
@synthesize isFontSize = _isFontSize;

#pragma mark - UIView methods
- (id)initWithFrame:(CGRect)frame withIsFontSize:(BOOL)_isSize
{
    self = [super initWithFrame:frame];
    if (self) {
        _isFontSize = _isSize;
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _isFontSize = YES;
        [self commonInit];
    }
    return self;    
}

// re-layout subviews in case of first initialization and screen orientation changes
// track_grey.png and track_orange.png original size: 384x64
// thumb.png original size: 91x98
- (void)layoutSubviews
{
    // the track background
    _trackImageViewNormal.frame = self.bounds;
    
    _labelOnThumb.frame = CGRectMake(0, 0, 30, self.bounds.size.height);
    _labelOnThumb.center = CGPointMake([self xForValue:_value], CGRectGetMidY(_trackImageViewNormal.frame));
}

#pragma mark - Accessor Overriding

- (void)setValue:(float)value
{
    if (value < _minimumValue || value > _maximumValue) {
        return;
    }
    
    _value = value;
    
    _labelOnThumb.center = CGPointMake([self xForValue:value], _labelOnThumb.center.y);
    
    if (_isFontSize)
    {
        _labelOnThumb.text = [NSString stringWithFormat:[self valueStringFormat], _value];
    }
    else
    {
       _labelOnThumb.backgroundColor = [self getColor];
    }
    
    [self setNeedsDisplay];
}

#pragma mark - Helpers
- (void)commonInit
{
    _value = 0.f;
    _minimumValue = 0.f;
    _maximumValue = 1.f;
    _continuous = YES;
    _thumbOn = NO;
    _decimalPlaces = 0;
    
    self.backgroundColor = [UIColor clearColor];
    
    // the track background images
    _trackImageViewNormal = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"track_grey.png"]];
    [self addSubview:_trackImageViewNormal];
    
    // value labels
    _labelOnThumb = [[UILabel alloc] init];
    _labelOnThumb.layer.cornerRadius = 4.f;
    
    if (_isFontSize)
    {
        _labelOnThumb.textAlignment = NSTextAlignmentCenter;
        _labelOnThumb.text = [NSString stringWithFormat:[self valueStringFormat], _value];
        _labelOnThumb.textColor = [UIColor whiteColor];
        _labelOnThumb.backgroundColor = [UIColor colorWithRed:227/255.0 green:134/255.0 blue:59/255.0 alpha:1.0];
    }
    else
    {
        _labelOnThumb.backgroundColor = [self getColor];
    }
    
    [self addSubview:_labelOnThumb];
}

- (float)xForValue:(float)value
{
    return self.frame.size.width * (value - _minimumValue) / (_maximumValue - _minimumValue);
}

- (float)valueForX:(float)x
{
    return _minimumValue + x / self.frame.size.width * (_maximumValue - _minimumValue);
}

- (float)stepMarkerXCloseToX:(float)x
{
    float xPercent = MIN(MAX(x / self.frame.size.width, 0), 1);
    float stepPercent = 1.f / 5.f;
    float midStepPercent = stepPercent / 2.f;
    int stepIndex = 0;
    while (xPercent > midStepPercent) {
        stepIndex++;
        midStepPercent += stepPercent;
    }
    
    return stepPercent * (float)stepIndex * self.frame.size.width;
}

- (NSString *)valueStringFormat
{
    return [NSString stringWithFormat:@"%%.%df", _decimalPlaces];
}

#pragma mark - Touch events handling
-(BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint touchPoint = [touch locationInView:self];
    if(CGRectContainsPoint(_labelOnThumb.frame, touchPoint))
    {
        _thumbOn = YES;
    }
    else
    {
        _thumbOn = NO;
    }
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    if (_thumbOn)
    {
        _value = [self valueForX:_labelOnThumb.center.x];
        if (_isFontSize)
        {
            _labelOnThumb.text = [NSString stringWithFormat:[self valueStringFormat], _value];
        }
        else
        {
            _labelOnThumb.backgroundColor = [self getColor];
        }
        
        if (_sliderValueBlock)
        {
            _sliderValueBlock(_isFontSize, _value, _labelOnThumb.backgroundColor);
        }
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    _thumbOn = NO;
}

-(UIColor *)getColor
{
    float wholeValue = _maximumValue - _minimumValue;
    float percent = (_value - _minimumValue) / wholeValue;
    return [UIColor colorWithRed:percent green:25/255.0 blue:38/255.0 alpha:1.0];
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    if(!_thumbOn) return YES;
    
    CGPoint touchPoint = [touch locationInView:self];
    
    _labelOnThumb.center = CGPointMake( MIN( MAX( [self xForValue:_minimumValue], touchPoint.x), [self xForValue:_maximumValue]), _labelOnThumb.center.y);
    if (_continuous)
    {
        _value = [self valueForX:_labelOnThumb.center.x];
        if (_isFontSize)
        {
            _labelOnThumb.text = [NSString stringWithFormat:[self valueStringFormat], _value];
        }
        else
        {
            _labelOnThumb.backgroundColor = [self getColor];
        }
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    
    [self setNeedsDisplay];
    return YES;
}

@end
