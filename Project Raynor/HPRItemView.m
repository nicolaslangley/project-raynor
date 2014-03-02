//
//  HPRDraggableCardView.m
//  Project Raynor
//
//  Created by Nicolas Langley on 2/28/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#import "HPRItemView.h"
#import "HPRCenterViewController.h"

@interface HPRItemView ()
{
    CGPoint offset;
    CGPoint viewOrigin;
}
@end

@implementation HPRItemView


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        offset = self.center;
        int actionIndicatorWidth = 45;
        int actionIndicatorHeight = 25;
        // int titleLabelHeight = 25;
        int border = 10;
        
        [self setBackgroundColor:self.tintColor];
        
        // Create and add image view
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + border,
                                                                       0 + border,
                                                                       self.frame.size.width - (border * 2),
                                                                       self.frame.size.height - (border * 2))];
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.backgroundColor = [UIColor grayColor];
        [self addSubview:self.imageView];
        
        // Get center of frame
        CGPoint frameCenter = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        
        // Create and add left label
        self.leftActionLabel = [[UILabel alloc] initWithFrame:CGRectMake(frameCenter.x - (actionIndicatorWidth / 2), frameCenter.y - (actionIndicatorHeight / 2), actionIndicatorWidth, actionIndicatorHeight)];
        self.leftActionLabel.text = @"NO";
        self.leftActionLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
        self.leftActionLabel.textAlignment = NSTextAlignmentCenter;
        self.leftActionLabel.backgroundColor = [UIColor clearColor];
        self.leftActionLabel.hidden = YES;
        [self addSubview:self.leftActionLabel];
        
        // Create and add right label
        self.rightActionLabel = [[UILabel alloc] initWithFrame:CGRectMake(frameCenter.x - (actionIndicatorWidth / 2), frameCenter.y - (actionIndicatorHeight / 2), actionIndicatorWidth, actionIndicatorHeight)];
        self.rightActionLabel.text = @"YES";
        self.rightActionLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
        self.rightActionLabel.textAlignment = NSTextAlignmentCenter;
        self.rightActionLabel.backgroundColor = [UIColor clearColor];
        self.rightActionLabel.hidden = YES;
        [self addSubview:self.rightActionLabel];
        
        // Note: title label on card temporarily disabled
        // self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,frame.size.width,titleLabelHeight)];
        // self.titleLabel.textColor = self.tintColor;
        // self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        // [self addSubview:self.titleLabel];
        
        // Set origin value
        viewOrigin = self.center;
    }
    return self;
}

#pragma mark - Methods for handling gestures

- (void) addGestureRecognizer {
    
    // Add recognizer to top view
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(handlePan:)];
    [self.panGesture setMaximumNumberOfTouches:1];
    [self addGestureRecognizer:self.panGesture];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    // Handle logic for left and right swipes
    int actionIndicatorThreshold = 0;
    int actionOccurenceThreshold = 100;
    int translationDistance = recognizer.view.center.x - viewOrigin.x;
    if (translationDistance < 0) {
        // Left swipe
        if (-translationDistance > actionIndicatorThreshold) {
            self.leftActionLabel.hidden = NO;
            self.leftActionLabel.textColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:-translationDistance*.008];
            self.leftActionLabel.layer.borderColor = [[UIColor colorWithRed:1.0 green:0 blue:0 alpha:-translationDistance*.008]CGColor];
            [self setTransform:CGAffineTransformMakeRotation
             (((self.center.x - 160.0f)/160.0f) * (M_PI/8))];
            // Perform action if over threshold
            if(-translationDistance > actionOccurenceThreshold){
                [self removeGestureRecognizer:self.panGesture];
                [self performApproval:NO]; // Trigger action
                [self removeFromSuperview];
                return;
            }
        }
    } else {
        // Right swipe
        if (translationDistance > actionIndicatorThreshold) {
            self.rightActionLabel.hidden = NO;
            self.rightActionLabel.textColor = [UIColor colorWithRed:0 green:1.0 blue:0 alpha:translationDistance*.008];
            self.rightActionLabel.layer.borderColor = [[UIColor colorWithRed:0 green:1.0 blue:0 alpha:translationDistance*.008]CGColor];
            [self setTransform:CGAffineTransformMakeRotation
             (((self.center.x - 160.0f)/160.0f) * (M_PI/8))];
            // Perform action if over threshold
            if(translationDistance > actionOccurenceThreshold){
                [self removeGestureRecognizer:self.panGesture];
                [self performApproval:YES]; // Trigger action
                [self removeFromSuperview];
                return;
            }
        }
    }
    // Translate view
    CGPoint translation = [recognizer translationInView:self];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self];
    
    // Return view to intitial state at end of gesture
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            recognizer.view.center = offset;
            self.leftActionLabel.hidden = YES;
            self.rightActionLabel.hidden = YES;
            [UIView beginAnimations:@"rotate" context:nil];
            [UIView setAnimationDuration:0.5];
            self.transform = CGAffineTransformMakeRotation(0);
            [UIView commitAnimations];
        } completion:nil];
    }
}

#pragma mark - Delegate function calls

- (void)performApproval:(BOOL)approval {
    if ([self.delegate respondsToSelector:@selector(processApproval: identifier: cardTag:)]) {
        // Suppress NSNumber to int conversion error
        NSNumber *number = [NSNumber numberWithInteger: self.tag];
        int tagVal = [number intValue];
        [self.delegate processApproval:approval identifier:self.itemIdentifier cardTag:tagVal];
    }
}

@end
