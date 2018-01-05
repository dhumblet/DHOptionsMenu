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
@property (nonatomic, assign) UIView* parentView;
@property (nonatomic, assign) CGSize offset;
@end

@implementation DHOptionsMenu

#pragma mark - Initialization

- (id)initWithItems:(NSArray *)menuItems
     andItemSpacing:(CGFloat)spacing
   andItemAlignment:(DHOptionsMenuAlignment)alignment
andCallingComponent:(UIView*)caller
       withDelegate:(id<DHOptionsMenuDelegate>)delegate {
    return [self initWithItems:menuItems
                andItemSpacing:spacing
              andItemAlignment:alignment
           andCallingComponent:caller
                     andOffset:CGSizeMake(0, 0)
                  withDelegate:delegate];
}

- (id)initWithItems:(NSArray *)menuItems
     andItemSpacing:(CGFloat)spacing
   andItemAlignment:(DHOptionsMenuAlignment)alignment
andCallingComponent:(UIView*)caller
          andOffset:(CGSize)offset
       withDelegate:(id<DHOptionsMenuDelegate>)delegate {
    if (self = [super initWithFrame:[[UIScreen mainScreen] bounds]]) {
        self.menuItems = menuItems;
        self.itemSpacing = spacing;
        self.alignment = alignment;
        self.caller = caller;
        self.offset = offset;
        self.delegate = delegate;
    }
    return self;
}

#pragma mark - Show/hide menu

- (void)showInView:(UIView *)view {
    self.parentView = view;
    DHOptionsMenuItem *previousItem = nil;
    DHOptionsMenuItem *firstItem = nil;
    CGFloat maxWidth = 0.f;
    CGPoint startPoint;

    for (int i = 0; i < [self.menuItems count]; i++) {
        DHOptionsMenuItem* item = [self.menuItems objectAtIndex:i];
        if (previousItem) {
            // Calculate new startpoint based on the previous item
            startPoint = CGPointMake(startPoint.x, startPoint.y + previousItem.itemSize.height + self.itemSpacing);
        } else {
            startPoint = [self getFirstStartPointForItemSize:item.itemSize];
        }
        item.delegate = self;
        item.menuIndex = i;
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
    
    // Add menu to parentview
    [self.parentView addSubview:self];
}

- (CGPoint)getFirstStartPointForItemSize:(CGSize)itemSize {
    switch (self.alignment) {
        default:
        case DHOptionsMenuAlignLeft:
            return CGPointMake(self.caller.frame.origin.x + self.offset.width, self.caller.frame.origin.y + self.caller.frame.size.height + self.itemSpacing + self.offset.height);
        case DHOptionsMenuAlignRight:
            return CGPointMake(self.caller.frame.origin.x + self.caller.frame.size.width - itemSize.width + self.offset.width, self.caller.frame.origin.y + self.caller.frame.size.height + self.itemSpacing + self.offset.height);
        case DHOptionsMenuAlignCenter:
            return CGPointMake(self.caller.frame.origin.x + self.caller.frame.size.width/2 - itemSize.width/2 + self.offset.width, self.caller.frame.origin.y + self.caller.frame.size.height + self.itemSpacing + self.offset.height);
    }
}

- (void)hide {
    [self removeFromSuperview];
    if (self.delegate) {
        [self.delegate menuDidHide];
    }
}

#pragma mark - User interaction

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
