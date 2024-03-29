//
//  HPRDraggableCardView.h
//  Project Raynor
//
//  Created by Nicolas Langley on 2/28/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RateView;

@protocol HPRCardViewDelegate <NSObject>
- (void)processApproval:(BOOL)approval identifier:(NSString *)identifier cardTag:(int)cardTag;
@end

@interface HPRItemView : UIView

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UILabel *leftActionLabel;
@property (nonatomic) UILabel *rightActionLabel;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UIPanGestureRecognizer *panGesture;
@property (assign) id delegate;
@property (nonatomic) NSString *itemIdentifier;

- (void)addGestureRecognizer;
- (void)handlePan:(UIPanGestureRecognizer *)recognizer;
- (void)performApproval:(BOOL)approval;

@end
