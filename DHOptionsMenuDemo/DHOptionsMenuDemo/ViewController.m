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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - Touch Actions

- (IBAction)leftTopButtonTouched:(id)sender {
    [self showMenuForButton:sender];
}

- (IBAction)rightTopButtonTouched:(id)sender {
    [self showMenuForButton:sender];
}


#pragma mark - DHOptionsMenu

- (void)showMenuForButton:(UIButton *)button {
    NSArray *menuTitles = @[@"Menu item one", @"Menu item 2", @"Menu item 3"];
    NSMutableArray *menus = [NSMutableArray array];
    
    CGSize itemSize = CGSizeMake(200, 45);
    for (NSString *title in menuTitles) {
        [menus addObject:[[DHOptionsMenuItem alloc] initWithText:title
                                                   andTitleColor:[UIColor blueColor]
                                              andBackgroundColor:[UIColor whiteColor]
                                                         andSize:itemSize]];
    }
    
    self.menu = [[DHOptionsMenu alloc] initWithFrame:self.view.frame
                                           menuItems:menus
                                             spacing:1
                                              caller:button
                                            delegate:self];
    
    [self.view addSubview:self.menu];
    [self.menu show];
}

#pragma mark - DHOptionsMenuDelegate 

- (void)selectedMenuItem:(DHOptionsMenuItem *)item {
    NSLog(@"Selected menu item '%@'", item.text);
}

- (void)menuClosed {
    NSLog(@"Close");
    [self.menu removeFromSuperview];
    self.menu = nil;
}
@end
