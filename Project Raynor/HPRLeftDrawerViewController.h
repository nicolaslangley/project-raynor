//
//  HPRLeftDrawerViewController.h
//  Project Raynor
//
//  Created by Nicolas Langley on 3/1/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MMDrawerController.h>

@interface HPRLeftDrawerViewController : UIViewController

@property MMDrawerController *drawerController;

- (void)closeDrawer;

@end
