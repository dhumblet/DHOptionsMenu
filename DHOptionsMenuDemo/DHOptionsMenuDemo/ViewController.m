//
//  ViewController.m
//  DHOptionsMenuDemo
//
//  Created by Derk Humblet on 23/06/2017.
//  Copyright © 2017 Derk Humblet. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) DHOptionsMenu* menu;
@property (weak, nonatomic) IBOutlet UILabel *selectedLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - Touch Actions

- (IBAction)leftTopButtonTouched:(id)sender {
    [self showMenuForButton:sender withAlignment:DHOptionsMenuAlignLeft];
}

- (IBAction)rightTopButtonTouched:(id)sender {
    [self showMenuForButton:sender withAlignment:DHOptionsMenuAlignRight];
}


#pragma mark - DHOptionsMenu

- (void)showMenuForButton:(UIButton*)button withAlignment:(DHOptionsMenuAlignment)alignment {
    NSArray *menuTitles;
    switch (alignment) {
        default:
        case DHOptionsMenuAlignLeft:
            menuTitles = @[@"Left item one", @"Left item two", @"Left item three"];
            break;
        case DHOptionsMenuAlignRight:
            menuTitles = @[@"Right item one", @"Right item two", @"Right item three"];
            break;
            
    }
    NSMutableArray *menus = [NSMutableArray array];
    
    for (NSString *title in menuTitles) {
        [menus addObject:[[DHOptionsMenuItem alloc] initWithText:title
                                                    andItemSize:CGSizeMake(200, 40)
                                                        andFont:[UIFont fontWithName:@"System" size:10]
                                                   andTextColor:[self colorFromHex:0xfefefe]
                                        andHighlightedTextColor:[self colorFromHex:0xf7f7f7]
                                             andBackgroundColor:[self colorFromHex:0x009fe3]
                                  andHighlightedBackgroundColor:[self colorFromHex:0x42b3e3]]];
    }
    
    self.menu = [[DHOptionsMenu alloc] initWithItems:menus
                                      andItemSpacing:1
                                    andItemAlignment:alignment
                                 andCallingComponent:button
                                        withDelegate:self];
    
    [self.view addSubview:self.menu];
    [self.menu show];
}

#pragma mark - DHOptionsMenuDelegate 

- (void)selectedMenuItem:(DHOptionsMenuItem *)item {
    [self.selectedLabel setText:[NSString stringWithFormat:@"Selected\n%@", item.text]];
    [self.menu hide];
}

- (void)menuDidHide {
    [self.menu removeFromSuperview];
    self.menu = nil;
}

#pragma mark - Helper methods

- (UIColor*)colorFromHex:(int)rgbValue {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                           green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
                            blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
                           alpha:1.0];
}
@end
