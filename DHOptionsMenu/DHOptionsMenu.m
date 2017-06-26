//
//  DHOptionsMenu.m
//  DHOptionsMenu
//
//  Created by Derk Humblet on 23/06/2017.
//  Copyright © 2017 Derk Humblet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHOptionsMenu.h"

@interface DHOptionsMenu ()

@property (nonatomic) CGRect menuRect;
@property (nonatomic, copy) NSArray *menuItems;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, assign) DHOptionsMenuAlignment alignment;
@property (nonatomic, assign) UIView* caller;
@property (nonatomic, weak) id<DHOptionsMenuDelegate> delegate;

@end

@implementation DHOptionsMenu

- (id)initWithItems:(NSArray *)menuItems

     andItemSpacing:(CGFloat)spacing
   andItemAlignment:(DHOptionsMenuAlignment)alignment
andCallingComponent:(UIView*)caller
       withDelegate:(id<DHOptionsMenuDelegate>)delegate {
    if (self = [super initWithFrame:[[UIScreen mainScreen] bounds]]) {
        self.menuItems = menuItems;
        self.itemSpacing = spacing;
        self.alignment = alignment;
        self.caller = caller;
        self.delegate = delegate;
    }
    return self;
}

- (DHOptionsMenuItem *)menuItemAtIndex:(NSUInteger)index {
    if (index < self.menuItems.count) {
        return self.menuItems[index];
    }
    return nil;
}

- (CGPoint)getFirstStartPointForItemSize:(CGSize)itemSize {
    switch (self.alignment) {
        default:
        case DHOptionsMenuAlignLeft:
            return CGPointMake(self.caller.frame.origin.x, self.caller.frame.origin.y + self.caller.frame.size.height + self.itemSpacing);
        case DHOptionsMenuAlignRight:
            return CGPointMake(self.caller.frame.origin.x + self.caller.frame.size.width - itemSize.width, self.caller.frame.origin.y + self.caller.frame.size.height + self.itemSpacing);
    }
}

- (void)show {
    DHOptionsMenuItem *previousItem = nil;
    DHOptionsMenuItem *firstItem = nil;
    CGFloat maxWidth = 0.f;
    CGPoint startPoint;

    for (DHOptionsMenuItem* item in self.menuItems) {
        if (previousItem) {
            // Calculate new startpoint based on the previous item
            startPoint = CGPointMake(startPoint.x, startPoint.y + previousItem.itemSize.height + self.itemSpacing);
        } else {
            startPoint = [self getFirstStartPointForItemSize:item.itemSize];
        }
        item.delegate = self;
        // Set item frame
        item.frame = CGRectMake(startPoint.x, startPoint.y, item.itemSize.width, item.itemSize.height);
        if (item.itemSize.width > maxWidth) {
            maxWidth = item.itemSize.width;
        }
        
        // Add item
        if (previousItem) {
            [self insertSubview:item belowSubview:previousItem];
        } else {
            [self addSubview:item];
            firstItem = item;
        }
        
        // Next iteration
        previousItem = item;
    }
    // Calculate rect for the visible menu
    self.menuRect = CGRectMake(firstItem.frame.origin.x, firstItem.frame.origin.y, maxWidth, previousItem.frame.origin.y - firstItem.frame.origin.y);
}

- (void)hide {
    if (self.delegate) {
        [self.delegate menuClosed];
    }
}

#pragma mark - Touch

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(self.menuRect, point)) {
        [self hide];
    }
    
}

#pragma mark - DHOptionsMenuItemDelegate

- (void)selectedMenuItem:(DHOptionsMenuItem *)item {
    if (self.delegate) {
        [self.delegate selectedMenuItem:item];
    }
}



@end
