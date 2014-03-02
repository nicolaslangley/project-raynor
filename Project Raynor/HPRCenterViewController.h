//
//  HPRViewController.h
//  Project Raynor
//
//  Created by Nicolas Langley on 2/27/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MMDrawerController.h>
#import "HPRItemView.h"

@interface HPRCenterViewController : UIViewController <HPRCardViewDelegate>

@property MMDrawerController *drawerController;

- (void)populateCardData:(NSArray *)data;
- (void)processApproval:(BOOL)approval identifier:(NSString *)identifier cardTag:(int)cardTag;
- (void)reloadCardData:(UIButton *)sender;
- (void)openLeftDrawer;

@end
