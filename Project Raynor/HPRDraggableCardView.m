//
//  HPRDraggableCardView.m
//  Project Raynor
//
//  Created by Nicolas Langley on 2/28/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#import "HPRDraggableCardView.h"

@interface HPRDraggableCardView ()
{
    CGPoint offset;
    CGPoint viewOrigin;
}
@end

@implementation HPRDraggableCardView


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        offset = self.center;
        int actionIndicatorWidth = 45;
        int actionIndicatorHeight = 25;
        
        // Create and add image view
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.backgroundColor = [UIColor grayColor];
        [self addSubview:self.imageView];
        
        // Get center of frame
        CGPoint frameCenter = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        
        // Create and add left label
        self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(frameCenter.x - (actionIndicatorWidth / 2), frameCenter.y - (actionIndicatorHeight / 2), actionIndicatorWidth, actionIndicatorHeight)];
        self.leftLabel.text = @"NO";
        self.leftLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
        self.leftLabel.textAlignment = NSTextAlignmentCenter;
        self.leftLabel.backgroundColor = [UIColor clearColor];
        self.leftLabel.hidden = YES;
        [self addSubview:self.leftLabel];
        
        // Create and add right label
        self.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(frameCenter.x - (actionIndicatorWidth / 2), frameCenter.y - (actionIndicatorHeight / 2), actionIndicatorWidth, actionIndicatorHeight)];
        self.rightLabel.text = @"YES";
        self.rightLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
        self.rightLabel.textAlignment = NSTextAlignmentCenter;
        self.rightLabel.backgroundColor = [UIColor clearColor];
        self.rightLabel.hidden = YES;
        [self addSubview:self.rightLabel];
        
        // Set origin value
        viewOrigin = self.center;
    }
    return self;
}

- (void) addGestureRecognizer {
    
    // Add recognizer to top view
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(handlePan:)];
    [self.panGesture setDelegate:self];
    [self.panGesture setMaximumNumberOfTouches:1];
    [self addGestureRecognizer:self.panGesture];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    // Handle logic for left and right swipes
    int actionIndicatorThreshold = 0;
    int translationDistance = recognizer.view.center.x - viewOrigin.x;
    if (translationDistance < 0) {
        // Left swipe
        if (-translationDistance > actionIndicatorThreshold) {
            self.leftLabel.hidden = NO;
            self.leftLabel.textColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:-translationDistance*.008];
            self.leftLabel.layer.borderColor = [[UIColor colorWithRed:1.0 green:0 blue:0 alpha:-translationDistance*.008]CGColor];
            [self setTransform:CGAffineTransformMakeRotation
             (((self.center.x - 160.0f)/160.0f) * (M_PI/8))];
        }
    } else {
        // Right swipe
        if (translationDistance > actionIndicatorThreshold) {
            self.rightLabel.hidden = NO;
            self.rightLabel.textColor = [UIColor colorWithRed:0 green:1.0 blue:0 alpha:translationDistance*.008];
            self.rightLabel.layer.borderColor = [[UIColor colorWithRed:0 green:1.0 blue:0 alpha:translationDistance*.008]CGColor];
            [self setTransform:CGAffineTransformMakeRotation
             (((self.center.x - 160.0f)/160.0f) * (M_PI/8))];
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
            self.leftLabel.hidden = YES;
            self.rightLabel.hidden = YES;
            [UIView beginAnimations:@"rotate" context:nil];
            [UIView setAnimationDuration:0.5];
            self.transform = CGAffineTransformMakeRotation(0);
            [UIView commitAnimations];
        } completion:nil];
    }
}

@end
