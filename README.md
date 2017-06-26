DHOptionsMenu
=============
An Android inspired options menu for iOS.

## Screenshot
[![](https://github.com/dhumblet/DHOptionsMenu/blob/master/Demo.gif)](https://github.com/dhumblet/DHOptionsMenu/blob/master/Demo.gif)

## Installation

#### Using CocoaPods:
```
pod 'DHOptionsMenu', '~> 0.1'
```

#### Manual installation

Simple copy the [files](https://github.com/dhumblet/DHOptionsMenu/tree/master/DHOptionsMenu) to a folder named "DHOptionsMenu" in your project.

## How to use

- Import [DHOptionsMenu](https://github.com/dhumblet/DHOptionsMenu/blob/master/DHOptionsMenu/DHOptionsMenu.h)
``` objc
#import "DHOptionsMenu.h"
```

- Implement [DHOptionsMenuDelegate](https://github.com/dhumblet/DHOptionsMenu/blob/master/DHOptionsMenu/DHOptionsMenu.h)
``` objc
@interface ViewController : UIViewController<DHOptionsMenuDelegate>
``` 

``` objc
#pragma mark - DHOptionsMenuDelegate 

- (void)selectedMenuItem:(DHOptionsMenuItem *)item { }

- (void)menuDidHide { }
``` 

- Create menu items
``` objc
[[DHOptionsMenuItem alloc] initWithText:@"Text"
                            andItemSize:CGSizeMake(200, 40)
                                andFont:[UIFont fontWithName:@"System" size:10]
                           andTextColor:[UIColor blackColor]
                andHighlightedTextColor:[UIColor blackColor]
                     andBackgroundColor:[UIColor whiteColor]
          andHighlightedBackgroundColor:[UIColor whiteColor]];
``` 

- Create menu 
``` objc
    [[DHOptionsMenu alloc] initWithItems:menuItems
                          andItemSpacing:1
                        andItemAlignment:DHOptionsMenuAlignLeft
                     andCallingComponent:button // The UIView that triggered showing the menu
                            withDelegate:self];
``` 

- Show menu
``` objc
	[menu showInView:self.view];
``` 

- Hide menu 
``` objc
	[menu hide];
``` 

## Alignment
- DHOptionsMenuAlignLeft: Aligns menu items with the left side of the view that triggered the menu
- DHOptionsMenuAlignRight: Aligns menu items with the right side of the view that triggered the menu
    