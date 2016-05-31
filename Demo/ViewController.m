//
//  ViewController.m
//  MenuPopOverView
//
//  Created by Camel Yang on 4/4/14.
//  Copyright (c) 2014 camelcc. All rights reserved.
//

#import "ViewController.h"

#import "MenuPopOverView.h"

#import "CHYSlider.h"

@interface ViewController () <MenuPopOverViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
//    [self.view addGestureRecognizer:tap];
    
    UILabel *stringLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 100, 100, 40)];
    stringLabel.text = @"字符串测试";
    [self.view addSubview:stringLabel];
    stringLabel.backgroundColor = [UIColor redColor];
    stringLabel.userInteractionEnabled = YES;
    
    [stringLabel addGestureRecognizer:tap];
    
    UILabel *controlLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 400, 100, 40)];
    controlLabel.text = @"control测试";
    [self.view addSubview:controlLabel];
    controlLabel.backgroundColor = [UIColor redColor];
    controlLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped1:)];
    [controlLabel addGestureRecognizer:tap1];
}

- (void)tapped1:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self.view];
    
    CHYSlider *testControl = [[CHYSlider alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 40, 50)];
    testControl.backgroundColor = [UIColor brownColor];
    
    testControl.minimumValue = 10;
    testControl.maximumValue = 40;
    testControl.value = 20;
    
    MenuPopOverView *popOver = [[MenuPopOverView alloc] init];
    popOver.delegate = self;
    [popOver presentPopoverFromRect:CGRectMake(point.x, point.y, 0, 0) inView:self.view withControl:testControl];
}

- (void)tapped:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self.view];
    MenuPopOverView *popOver = [[MenuPopOverView alloc] init];
    popOver.delegate = self;
//    [popOver presentPopoverFromRect:CGRectMake(point.x, point.y, 0, 0) inView:self.view withStrings:@[@"Test1", @"TestAAAAAAA", @"t", @"example", @"loooooooooooooooongbutton"]];
    [popOver presentPopoverFromRect:CGRectMake(point.x, point.y, 0, 0) inView:self.view withStrings:@[@"Test1"]];
}

- (void)popoverView:(MenuPopOverView *)popoverView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"select at %ld", (long)index);
}

- (void)popoverViewDidDismiss:(MenuPopOverView *)popoverView {
    NSLog(@"popOver dismissed.");
}

@end
