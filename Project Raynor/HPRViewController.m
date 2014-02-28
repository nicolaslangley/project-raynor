//
//  HPRViewController.m
//  Project Raynor
//
//  Created by Nicolas Langley on 2/27/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#import "HPRViewController.h"
#import "HPRDraggableCardView.h"

@interface HPRViewController ()
@end

@implementation HPRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGRect frame = CGRectMake(70,82,200,240);
    HPRDraggableCardView *card = [[HPRDraggableCardView alloc] initWithFrame:frame];
    [card setDelegate:self];
    [card addGestureRecognizer];
    [self.view addSubview:card];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
