//
//  DHOptionsMenuItem.h
//  DHOptionsMenu
//
//  Created by Derk Humblet on 23/06/2017.
//  Copyright © 2017 Derk Humblet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DHOptionsMenuItem;

@protocol DHOptionsMenuItemProtocol <NSObject>

@required
- (void)selectedMenuItem:(DHOptionsMenuItem *)item;

@end

@interface DHOptionsMenuItem : UILabel

@property (nonatomic) CGSize itemSize;

@property (nonatomic, weak) id<DHOptionsMenuItemProtocol> delegate;

- (id)initWithText:(NSString*)text
                andTitleColor:(UIColor*)titleColor
           andBackgroundColor:(UIColor*)backgroundColor
                      andSize:(CGSize)size;
@end
