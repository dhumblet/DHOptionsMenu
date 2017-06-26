//
//  DHOptionsMenu.h
//
//  Created by Derk Humblet on 23/06/2017.
//  Copyright © 2017 Derk Humblet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHOptionsMenuItem.h"


typedef NS_ENUM(NSInteger, DHOptionsMenuAlignment) {
    DHOptionsMenuAlignLeft = 0,
    DHOptionsMenuAlignRight = 1,
};

@protocol DHOptionsMenuDelegate
- (void)selectedMenuItem:(DHOptionsMenuItem*)item;
- (void)menuDidHide;
@end

@interface DHOptionsMenu : UIView<DHOptionsMenuItemDelegate>

- (id)initWithItems:(NSArray *)menuItems
     andItemSpacing:(CGFloat)spacing
   andItemAlignment:(DHOptionsMenuAlignment)alignment
andCallingComponent:(UIView*)caller
       withDelegate:(id<DHOptionsMenuDelegate>)delegate;

- (void)show;
- (void)hide;

@end
