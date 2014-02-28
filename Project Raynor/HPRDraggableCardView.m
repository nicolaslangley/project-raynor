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
        int padding = 0;
        
        // Create and add image view
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, padding, self.frame.size.width, self.frame.size.height - padding)];
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.backgroundColor = [UIColor grayColor];
        [self addSubview:self.imageView];
        
        // Create and add left label
        self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - actionIndicatorWidth - padding, frame.size.height/2-padding, actionIndicatorWidth, actionIndicatorHeight)];
        self.leftLabel.text = @"NO";
        self.leftLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
        self.leftLabel.textAlignment = NSTextAlignmentCenter;
        self.leftLabel.backgroundColor = [UIColor clearColor];
        self.leftLabel.hidden = YES;
        [self addSubview:self.leftLabel];
        
        // Create and add right label
        self.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - actionIndicatorWidth - padding, frame.size.height/2-padding, actionIndicatorWidth, actionIndicatorHeight)];
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
    // Translate image view position
    CGPoint translation = [recognizer translationInView:self];
    CGPoint imageViewPosition = self.imageView.center;
    imageViewPosition.x += translation.x;
    self.imageView.center = imageViewPosition;
    [recognizer setTranslation:CGPointZero inView:self];
    
    // Handle logic for left and right swipes
    int actionIndicatorThreshold = 0;
    int dragDistance = translation.x;
    int translationDistance = dragDistance;
    if (translationDistance < 0) {
        if (-translationDistance > actionIndicatorThreshold) {
            self.leftLabel.hidden = NO;
        }
    } else {
        if (translationDistance > actionIndicatorThreshold) {
            self.rightLabel.hidden = NO;
        }
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        self.imageView.center = viewOrigin;
        self.leftLabel.hidden = YES;
        self.rightLabel.hidden = YES;
    }
}

@end
