//
//  DHOptionsMenuItem.m
//  DHOptionsMenu
//
//  Created by Derk Humblet on 23/06/2017.
//  Copyright © 2017 Derk Humblet. All rights reserved.
//

#import "DHOptionsMenuItem.h"

@implementation DHOptionsMenuItem

- (id)initWithText:(NSString*)text
                andTitleColor:(UIColor*)titleColor
           andBackgroundColor:(UIColor*)backgroundColor
                      andSize:(CGSize)size {
    if (self = [super init]) {
        self.text = text;
        self.textColor = titleColor;
        self.backgroundColor = backgroundColor;
        self.itemSize = size;
        self.bounds = CGRectMake(0, 0, self.itemSize.width, self.itemSize.height);
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bounds = CGRectMake(0, 0, self.itemSize.width, self.itemSize.height);
}

#pragma mark - Action

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.highlighted = YES;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    // if move out, cancel highlighted.
    CGPoint location = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(self.bounds, location)) {
        self.highlighted = NO;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.highlighted = NO;
    // if stop in the area, response to the touches event.
    CGPoint location = [[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(self.bounds, location)) {
        if ([self.delegate respondsToSelector:@selector(floatingActionMenuItemDidTouch:)]) {
            [self.delegate floatingActionMenuItemDidTouch:self];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    self.highlighted = NO;
}


@end
