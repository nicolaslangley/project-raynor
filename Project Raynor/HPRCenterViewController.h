//
//  HPRViewController.h
//  Project Raynor
//
//  Created by Nicolas Langley on 2/27/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MMDrawerController.h>
#import <Parse/Parse.h>
#import "HPRItemView.h"
#import "HPRLogInViewController.h"

@interface HPRCenterViewController : UIViewController <HPRCardViewDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property MMDrawerController *drawerController;
@property HPRLogInViewController *logInViewController;
@property UILabel *userLabel;

- (void)populateCardData:(NSArray *)data;
- (void)processApproval:(BOOL)approval identifier:(NSString *)identifier cardTag:(int)cardTag;
- (void)reloadCardData:(UIButton *)sender;
- (void)openLeftDrawer;

@end
