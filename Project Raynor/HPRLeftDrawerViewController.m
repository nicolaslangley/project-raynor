//
//  HPRLeftDrawerViewController.m
//  Project Raynor
//
//  Created by Nicolas Langley on 3/1/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#import "HPRLeftDrawerViewController.h"
#import "HPRTableViewController.h"

@protocol LeftDrawerViewController <NSObject>

- (void)closeDrawer;

@end

@interface HPRLeftDrawerViewController ()

@end

@implementation HPRLeftDrawerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    // Add button for returning to center
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(closeDrawer)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"Close Drawer" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 420.0, 160.0, 40.0);
    [self.view addSubview:button];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeDrawer
{
    [self.drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        NSLog(@"Drawer closed completion");
    }];
}

@end
