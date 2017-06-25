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
- (void)floatingActionMenuItemDidTouch:(DHOptionsMenuItem *)item;

@end

@interface DHOptionsMenuItem : UILabel

@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic) CGPoint nearPoint;
@property (nonatomic) CGPoint farPoint;
@property (nonatomic) CGSize itemSize;/**< Default is image size */

@property (nonatomic, weak) id<DHOptionsMenuItemProtocol> delegate;

- (id)initWithText:(NSString*)text
                andTitleColor:(UIColor*)titleColor
           andBackgroundColor:(UIColor*)backgroundColor
                      andSize:(CGSize)size;
@end
