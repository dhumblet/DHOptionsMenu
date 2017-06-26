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

@protocol DHOptionsMenuItemDelegate <NSObject>
- (void)selectedMenuItem:(DHOptionsMenuItem *)item;
@end

@interface DHOptionsMenuItem : UILabel
@property (nonatomic) CGSize itemSize;
@property (nonatomic) NSUInteger menuIndex;
@property (nonatomic, weak) id<DHOptionsMenuItemDelegate> delegate;

- (id)initWithText:(NSString*)text
       andItemSize:(CGSize)itemSize;

- (id)initWithText:(NSString*)text
       andItemSize:(CGSize)itemSize
           andFont:(UIFont*)font
      andTextColor:(UIColor*)textColor andHighlightedTextColor:(UIColor*)highlightedTextColor
andBackgroundColor:(UIColor*)backgroundColor andHighlightedBackgroundColor:(UIColor*)highlightedBackgroundColor;

@end
