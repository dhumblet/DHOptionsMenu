//
//  DHOptionsMenuItem.m
//  DHOptionsMenu
//
//  Created by Derk Humblet on 23/06/2017.
//  Copyright © 2017 Derk Humblet. All rights reserved.
//

#import "DHOptionsMenuItem.h"

@interface DHOptionsMenuItem ()
@property (nonatomic, strong) UIColor *normalBackgroundColor;
@property (nonatomic, strong) UIColor *highlightedBackgroundColor;

@end

@implementation DHOptionsMenuItem

#pragma mark - Initialization

- (id)initWithText:(NSString*)text
       andItemSize:(CGSize)itemSize {
    if (self = [super init]) {
        self.text = text;
        self.itemSize = itemSize;
        
        self.bounds = CGRectMake(0, 0, self.itemSize.width, self.itemSize.height);
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (id)initWithText:(NSString*)text
       andItemSize:(CGSize)itemSize
           andFont:(UIFont*)font
      andTextColor:(UIColor*)textColor andHighlightedTextColor:(UIColor*)highlightedTextColor
andBackgroundColor:(UIColor*)backgroundColor andHighlightedBackgroundColor:(UIColor*)highlightedBackgroundColor {
    if (self = [super init]) {
        self.text = text;
        self.itemSize = itemSize;
        self.font = font;
        self.textColor = textColor;
        self.highlightedTextColor = highlightedTextColor;
        self.backgroundColor = backgroundColor;
        self.normalBackgroundColor = backgroundColor;
        self.highlightedBackgroundColor = highlightedBackgroundColor;

        self.bounds = CGRectMake(0, 0, self.itemSize.width, self.itemSize.height);
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bounds = CGRectMake(0, 0, self.itemSize.width, self.itemSize.height);
}

#pragma mark - User interaction

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    [self highlight:YES];
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    CGPoint location = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(self.bounds, location)) {
        [self highlight:NO];
    }
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
    CGPoint location = [[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(self.bounds, location)) {
        if ([self.delegate respondsToSelector:@selector(selectedMenuItem:)]) {
            [self highlight:NO];
            [self.delegate selectedMenuItem:self];
        }
    }
}

- (void)touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event {
    [self highlight:NO];
}

#pragma mark - Highlight helper method

- (void)highlight:(BOOL)highlighted {
    self.highlighted = highlighted;
    self.backgroundColor = highlighted ? self.highlightedBackgroundColor : self.normalBackgroundColor;
}


@end
