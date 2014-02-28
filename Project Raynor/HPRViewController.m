//
//  HPRViewController.m
//  Project Raynor
//
//  Created by Nicolas Langley on 2/27/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#import "HPRViewController.h"

@interface HPRViewController ()

@end

@implementation HPRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.imageView setUserInteractionEnabled:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    // Get translation of gesture
    CGPoint translation = [recognizer translationInView:self.view];
    int minStartActionIndicator = 50;
    int maxStartActionIndication = 30;
    int minPerformAction = 30;
    int maxPerformAction = 30;
    int dragDistanceX = translation.x;
    UIView *imView = recognizer.view;
    if (dragDistanceX < 0) {
        // Handle left drag
        if (-dragDistanceX > minStartActionIndicator) {
            // TODO: rotate image properly when this is selected
            [imView setTransform:CGAffineTransformMakeRotation(((imView.center.x - 160.0f)/160.0f) * (M_PI/8))];
            self.leftLabel.hidden = NO;
        } else {
            self.leftLabel.hidden = YES;
        }
    } else {
        // Handle right drag
        if (dragDistanceX > minStartActionIndicator) {
            // TODO: rotate image properly when this is selected
            [imView setTransform:CGAffineTransformMakeRotation(((imView.center.x - 160.0f)/160.0f) * (M_PI/8))];
            self.rightLabel.hidden = NO;
        } else {
            self.rightLabel.hidden = YES;
        }
    }
    
    // Handle end of gesture
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        self.leftLabel.hidden = YES;
        self.rightLabel.hidden = YES;
    }
}
@end
