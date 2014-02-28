//
//  HPRDraggableCardView.h
//  Project Raynor
//
//  Created by Nicolas Langley on 2/28/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RateView;

@protocol HPRDraggableCardViewDelegate <NSObject>
@end

@interface HPRDraggableCardView : UIView <HPRDraggableCardViewDelegate>

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UILabel *leftLabel;
@property (nonatomic) UILabel *rightLabel;
@property (nonatomic) UIPanGestureRecognizer *panGesture;
@property (assign) id <HPRDraggableCardViewDelegate> delegate;

- (void)addGestureRecognizer;
- (void)handlePan:(UIPanGestureRecognizer *)recognizer;

@end
