//
//  DHOptionsMenu.h
//
//  Created by Derk Humblet on 23/06/2017.
//  Copyright © 2017 Derk Humblet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHOptionsMenuItem.h"

//! Project version number for DHOptionsMenu.
FOUNDATION_EXPORT double DHOptionsMenuVersionNumber;

//! Project version string for DHOptionsMenu.
FOUNDATION_EXPORT const unsigned char DHOptionsMenuVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <DHOptionsMenu/PublicHeader.h>

typedef NS_ENUM(NSInteger, DHOptionMenuDirection) {
    DHOptionMenuDirectionDown = 0,
    DHOptionMenuDirectionUp = 1,
    DHOptionMenuDirectionRight = 2,
    DHOptionMenuDirectionLeft = 3,
};

@interface DHOptionMenu : UIView<DHOptionsMenuItemProtocol>

@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGFloat spacing;
@property (nonatomic, assign) BOOL rotateStartMenu;

- (id)initWithFrame:(CGRect)frame
          direction:(DHOptionMenuDirection)direction
          menuItems:(NSArray *)menuItems
        menuHandler:(void (^)(DHOptionsMenuItem *item, NSUInteger index))menuHandler
       closeHandler:(void (^)(void))closeHandler;

- (DHOptionsMenuItem *)menuItemAtIndex:(NSUInteger)index;

- (void)open;

- (void)close;

@end
