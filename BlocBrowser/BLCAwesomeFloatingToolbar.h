//
//  BLCAwesomeFloatingToolbar.h
//  BlocBrowser
//
//  Created by Jenna Miller on 12/12/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLCAwesomeFloatingToolbar;

@protocol BLCAwesomeFloatingToolbarDelegate <NSObject>

// @property (readwrite, copy) NSMutableArray *allTheButtons;

@optional

- (void) floatingToolbar:(BLCAwesomeFloatingToolbar *)toolbar didSelectButtonWithTitle:(NSString *)title;
- (void) floatingToolbar:(BLCAwesomeFloatingToolbar *)toolbar didTryToPanWithOffset:(CGPoint)offset;
- (void) floatingToolbar:(BLCAwesomeFloatingToolbar *)toolbar didTryToResize:(CGPoint)scale;
                                                                   
@end

@interface BLCAwesomeFloatingToolbar : UIView

- (instancetype) initWithFourButtons:(NSMutableArray *)buttons;

- (void) setEnabled:(BOOL)enabled forButtonWithTitle:(NSString *)title;

@property (nonatomic, strong) NSMutableArray *allTheButtons;
@property (nonatomic, weak) id <BLCAwesomeFloatingToolbarDelegate> delegate;


@end