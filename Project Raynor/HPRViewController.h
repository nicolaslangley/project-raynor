//
//  HPRViewController.h
//  Project Raynor
//
//  Created by Nicolas Langley on 2/27/14.
//  Copyright (c) 2014 Hierarchy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPRCardView.h"

@interface HPRViewController : UIViewController <HPRCardViewDelegate>

- (void)populateCardStack:(NSArray *)data;
- (void)processAction:(BOOL)result title:(NSString *)title cardTag:(int)cardTag;

@end
