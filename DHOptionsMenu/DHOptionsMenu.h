//
//  DHOptionsMenu.h
//
//  Created by Derk Humblet on 23/06/2017.
//  Copyright © 2017 Derk Humblet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHOptionsMenuItem.h"


@protocol DHOptionsMenuDelegate

- (void)selectedMenuItem:(DHOptionsMenuItem*)item;
- (void)menuClosed;

@end

@interface DHOptionsMenu : UIView<DHOptionsMenuItemProtocol>

@property (nonatomic, assign) BOOL rotateStartMenu;

- (id)initWithFrame:(CGRect)frame
          menuItems:(NSArray *)menuItems
            spacing:(CGFloat)spacing
             caller:(UIView*)caller
           delegate:(id<DHOptionsMenuDelegate>)delegate;

- (DHOptionsMenuItem *)menuItemAtIndex:(NSUInteger)index;

- (void)show;
- (void)hide;

@end
