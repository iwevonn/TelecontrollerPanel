//
//  ViewController.m
//  TelecontrollerPanel
//
//  Created by evonn iw on 2019/3/2.
//  Copyright © 2019 iwevonn. All rights reserved.
//

#import "ViewController.h"
#include <math.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *upLeftView;
@property (weak, nonatomic) IBOutlet UIImageView *upRightView;
@property (weak, nonatomic) IBOutlet UIImageView *downLeftView;
@property (weak, nonatomic) IBOutlet UIImageView *downRightView;

@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIImageView *centerUpView;
@property (weak, nonatomic) IBOutlet UIImageView *centerLeftView;
@property (weak, nonatomic) IBOutlet UIImageView *centerDownView;
@property (weak, nonatomic) IBOutlet UIImageView *centerRightView;
@property (weak, nonatomic) IBOutlet UIImageView *centerCircleView;

@property (weak, nonatomic) UIImageView *dirTagView;
@property (weak, nonatomic) UIImageView *cenTagView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


//telecontroller panel
- (IBAction)controlHandle:(UITapGestureRecognizer *)sender {
    UIView *view = sender.view;
    CGFloat width = view.frame.size.width;
    CGFloat height = view.frame.size.height;
    CGPoint point = [sender locationInView:view];
    CGPoint centerPoint = view.center;
    CGFloat orignX = point.x;
    CGFloat orignY = point.y;
    UIImageView *tempView = nil;
    
    //上-左
    NSArray *upLeftPoints = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],
                              [NSValue valueWithCGPoint:CGPointMake(0,height/2)],
                              [NSValue valueWithCGPoint:CGPointMake(width/2,0)]];
    //上-右
    NSArray *upRightPoints = @[[NSValue valueWithCGPoint:CGPointMake(width/2, 0)],
                               [NSValue valueWithCGPoint:CGPointMake(width,height/2)],
                               [NSValue valueWithCGPoint:CGPointMake(width,0)]];
    //下-左
    NSArray *downLeftPoints = @[[NSValue valueWithCGPoint:CGPointMake(0, height/2)],
                                [NSValue valueWithCGPoint:CGPointMake(0,height)],
                                [NSValue valueWithCGPoint:CGPointMake(width/2,height)]];
    //下-右
    NSArray *downRightPoints = @[[NSValue valueWithCGPoint:CGPointMake(width,height/2)],
                                 [NSValue valueWithCGPoint:CGPointMake(width/2,height)],
                                 [NSValue valueWithCGPoint:CGPointMake(width,height)]];
    //内-上
    NSArray *centerUpPoints_1 = @[[NSValue valueWithCGPoint:CGPointMake(width/2,0)],
                                  [NSValue valueWithCGPoint:CGPointMake(width/4,height/4)],
                                  [NSValue valueWithCGPoint:centerPoint]];
    NSArray *centerUpPoints_2 = @[[NSValue valueWithCGPoint:CGPointMake(width/2,0)],
                                  [NSValue valueWithCGPoint:CGPointMake(width*0.75,height/4)],
                                  [NSValue valueWithCGPoint:centerPoint]];
    //内-左
    NSArray *centerLeftPoints_1 = @[[NSValue valueWithCGPoint:CGPointMake(width/4,height/4)],
                                    [NSValue valueWithCGPoint:CGPointMake(0,height/2)],
                                    [NSValue valueWithCGPoint:centerPoint]];
    NSArray *centerLeftPoints_2 = @[[NSValue valueWithCGPoint:CGPointMake(0,height/2)],
                                    [NSValue valueWithCGPoint:CGPointMake(width/4,height*0.75)],
                                    [NSValue valueWithCGPoint:centerPoint]];
    //内-下
    NSArray *centerDownPoints_1 = @[[NSValue valueWithCGPoint:CGPointMake(width/4,height*0.75)],
                                    [NSValue valueWithCGPoint:CGPointMake(width/2,height)],
                                    [NSValue valueWithCGPoint:centerPoint]];
    NSArray *centerDownPoints_2 = @[[NSValue valueWithCGPoint:CGPointMake(width/2,height)],
                                    [NSValue valueWithCGPoint:CGPointMake(width*0.75,height*0.75)],
                                    [NSValue valueWithCGPoint:centerPoint]];
    //内-右
    NSArray *centerRightPoints_1 = @[[NSValue valueWithCGPoint:CGPointMake(width*0.75,height/4)],
                                     [NSValue valueWithCGPoint:CGPointMake(width,height/2)],
                                     [NSValue valueWithCGPoint:centerPoint]];
    NSArray *centerRightPoints_2 = @[[NSValue valueWithCGPoint:CGPointMake(width,height/2)],
                                     [NSValue valueWithCGPoint:CGPointMake(width*0.75,height*0.75)],
                                     [NSValue valueWithCGPoint:centerPoint]];
    
    //上-左
    if ([self point:point inTriangleVertexPointsArea:upLeftPoints]) {
        tempView = self.upLeftView;
    }
    //上-右
    else if ([self point:point inTriangleVertexPointsArea:upRightPoints]) {
        tempView = self.upRightView;
    }
    //下-左
    else if ([self point:point inTriangleVertexPointsArea:downLeftPoints]) {
        tempView = self.downLeftView;
    }
    //下-右
    else if ([self point:point inTriangleVertexPointsArea:downRightPoints]) {
        tempView = self.downRightView;
    }
    //内-中 (width*0.25, height*0.25)
    else if (orignX > width * 0.375 &&
             orignX < width * 0.625 &&
             orignY > height * 0.375 &&
             orignY < height * 0.625) {
        tempView = self.centerCircleView;
    }
    //内-上
    else if ([self point:point inTriangleVertexPointsArea:centerUpPoints_1] ||
             [self point:point inTriangleVertexPointsArea:centerUpPoints_2]) {
        tempView = self.centerUpView;
    }
    //内-左
    else if ([self point:point inTriangleVertexPointsArea:centerLeftPoints_1] ||
             [self point:point inTriangleVertexPointsArea:centerLeftPoints_2]) {
        tempView = self.centerLeftView;
    }
    //内-下
    else if ([self point:point inTriangleVertexPointsArea:centerDownPoints_1] ||
             [self point:point inTriangleVertexPointsArea:centerDownPoints_2]) {
        tempView = self.centerDownView;
    }
    //内-右
    else if ([self point:point inTriangleVertexPointsArea:centerRightPoints_1] ||
             [self point:point inTriangleVertexPointsArea:centerRightPoints_2]) {
        tempView = self.centerRightView;
    }
    //设置点击效果
    tempView.highlighted = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        tempView.highlighted = NO;
    });
}


//三角形面积（海伦公式）,分割后三角形总面积 == 原始总面积
- (BOOL)point:(CGPoint)point inTriangleVertexPointsArea:(NSArray<NSValue *> *)vertexPoints {
    if (vertexPoints.count == 3) {
        CGPoint point0 = [vertexPoints[0] CGPointValue];
        CGPoint point1 = [vertexPoints[1] CGPointValue];
        CGPoint point2 = [vertexPoints[2] CGPointValue];
        
        float s = [self sign:point0 point1:point1 point2:point2];
        float s0 = [self sign:point point1:point0 point2:point1];
        float s1 = [self sign:point point1:point1 point2:point2];
        float s2 = [self sign:point point1:point2 point2:point0];
        NSLog(@"%f, %f", floor(s), floor(s0 + s1 + s2));
        return (floor(s) == floor(s0 + s1 + s2));
    }
    return NO;
}

- (CGFloat)sign:(CGPoint)point point1:(CGPoint)point1 point2:(CGPoint)point2 {
    float a = sqrt(pow(point.x-point1.x,2) + pow(point.y-point1.y,2));
    float b = sqrt(pow(point2.x-point1.x,2) + pow(point2.y-point1.y,2));
    float c = sqrt(pow(point.x-point2.x,2) + pow(point.y-point2.y,2));
    float p = (a+b+c)/2;
    return sqrt(p*(p-a)*(p-b)*(p-c));
}

@end
