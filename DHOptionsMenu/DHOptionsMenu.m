//
//  DHOptionsMenu.m
//  DHOptionsMenu
//
//  Created by Derk Humblet on 23/06/2017.
//  Copyright © 2017 Derk Humblet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHOptionsMenu.h"

static const CGFloat kLSAnimationDurationStartMenuRotate = 0.25;
static const CGFloat kLSAnimationDelay = 0.036f;
static const CGFloat kLSAnimationDuration = 0.3f;
static NSString * const kLSKeyAnimationGroupID = @"AnimationGroupID";
static NSString * const kLSKeyFirstAnimationGroupValue = @"FirstAnimationGroup";
static NSString * const kLSKeyLastAnimationGroupValue = @"LastAnimationGroup";

@interface DHOptionsMenu ()

@property (nonatomic, copy) NSArray *menuItems;
@property (nonatomic, weak) id<DHOptionsMenuDelegate> delegate;

@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, assign) BOOL isExpanded;
@property (nonatomic, assign) CGFloat itemSpacing;

@property (nonatomic, strong) NSTimer *animationTimer;
@property (nonatomic, assign) NSInteger animationTag;
@property (nonatomic, assign) UIView* caller;

@property (nonatomic) CGRect menuRect;

@end

@implementation DHOptionsMenu

- (id)initWithFrame:(CGRect)frame
          menuItems:(NSArray *)menuItems
            spacing:(CGFloat)spacing
             caller:(UIView*)caller
           delegate:(id<DHOptionsMenuDelegate>)delegate {
    
    if (self = [super initWithFrame:[[UIScreen mainScreen] bounds]]) {
        self.menuItems = menuItems;
        self.delegate = delegate;
        self.caller = caller;
        self.itemSpacing = spacing;
    }
    return self;
}

- (DHOptionsMenuItem *)menuItemAtIndex:(NSUInteger)index {
    if (index < self.menuItems.count) {
        return self.menuItems[index];
    }
    return nil;
}

//- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg waitUntilDone:(BOOL)wait {

- (void)show {
    DHOptionsMenuItem *previousItem = nil;
    DHOptionsMenuItem *firstItem = nil;
    CGPoint startPoint = CGPointMake(self.caller.frame.origin.x, self.caller.frame.origin.y + self.caller.frame.size.height + self.itemSpacing);
    
    for (DHOptionsMenuItem* item in self.menuItems) {
        item.delegate = self;
        // Set item frame
        item.frame = CGRectMake(startPoint.x, startPoint.y, item.itemSize.width, item.itemSize.height);
        // Calculate new startpoint for next item
        startPoint = CGPointMake(startPoint.x, startPoint.y + item.itemSize.height + self.itemSpacing);
        
        if (previousItem) {
            [self insertSubview:item belowSubview:previousItem];
        } else {
            [self addSubview:item];
            firstItem = item;
        }
        previousItem = item;
    }
    
    self.menuRect = CGRectMake(firstItem.frame.origin.x, firstItem.frame.origin.y, firstItem.frame.size.width, previousItem.frame.origin.y - firstItem.frame.origin.y);
}

- (void)hide {
    if (self.delegate) {
        [self.delegate menuClosed];
    }
}

#pragma mark - Touch

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    return CGRectContainsPoint(self.menuRect, point);
//}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];

    if (!CGRectContainsPoint(self.menuRect, point)) {
        [self hide];
    }
    
}

#pragma mark - FloatingActionMenuItemDelegate

- (void)selectedMenuItem:(DHOptionsMenuItem *)item {
    if (self.delegate) {
        [self.delegate selectedMenuItem:item];
    }
}



@end
