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

@end

@implementation DHOptionsMenu

- (id)initWithFrame:(CGRect)frame
          menuItems:(NSArray *)menuItems
            spacing:(CGFloat)spacing
             caller:(UIView*)caller
           delegate:(id<DHOptionsMenuDelegate>)delegate {
    
    if (self = [super initWithFrame:frame]) {
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
        }
        previousItem = item;
    }
}

- (void)hide {
    if (self.delegate) {
        [self.delegate menuClosed];
    }
}

#pragma mark - Touch

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    // if the menu is animating, prevent touches
    if (self.isAnimating) {
        return NO;
    }
    // if the menu state is expanding, everywhere can be touch
    // otherwise, only the add button are can be touch
    if (self.isExpanded) {
        return YES;
    } else {
        return CGRectContainsPoint([[self menuItemAtIndex:0] frame], point);
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self hide];
}

#pragma mark - FloatingActionMenuItemDelegate

- (void)floatingActionMenuItemDidTouch:(DHOptionsMenuItem *)item {
    if (item.tag == 0) {
        [self hide];
        return;
    }
    
    if (self.delegate) {
        [self.delegate selectedMenuItem:item];
    }
}



@end
