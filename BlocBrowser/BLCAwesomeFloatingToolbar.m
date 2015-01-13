//
//  BLCAwesomeFloatingToolbar.m
//  BlocBrowser
//
//  Created by Jenna Miller on 12/12/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "BLCAwesomeFloatingToolbar.h"
@interface BLCAwesomeFloatingToolbar ()

@property (nonatomic, strong) NSArray *currentTitles;
@property (nonatomic, strong) NSArray *colors;

// @property (nonatomic, weak) UIButton *currentButton;

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *forwardButton;
@property (nonatomic, strong) UIButton *stopButton;
@property (nonatomic, strong) UIButton *refreshButton;

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UIPinchGestureRecognizer *pinchGesture;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;


@end

@implementation BLCAwesomeFloatingToolbar

- (void) viewDidLoad {
    
}

- (instancetype) initWithFourButtons :(NSMutableArray *)allTheButtons {

    self = [super init];
    
    if (self) {
        
        self.colors = @[[UIColor colorWithRed:199/255.0 green:158/255.0 blue:203/255.0 alpha:1],
                        [UIColor colorWithRed:255/255.0 green:105/255.0 blue:97/255.0 alpha:1],
                        [UIColor colorWithRed:222/255.0 green:165/255.0 blue:164/255.0 alpha:1],
                        [UIColor colorWithRed:255/255.0 green:179/255.0 blue:71/255.0 alpha:1]];
        
        self.backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.backButton.titleLabel.text = NSLocalizedString(@"Back", @"Back command");
        self.backButton.backgroundColor = [UIColor colorWithRed:199/255.0 green:158/255.0 blue:203/255.0 alpha:0.25];
        self.backButton.userInteractionEnabled = NO;
        [self.backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.forwardButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.forwardButton.titleLabel.text = NSLocalizedString(@"Forward", @"Forward command");
        self.forwardButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:105/255.0 blue:97/255.0 alpha:0.25];
        self.forwardButton.userInteractionEnabled = NO;
        [self.forwardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.stopButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.stopButton.titleLabel.text = NSLocalizedString(@"Stop", @"Stop command");
        self.stopButton.backgroundColor = [UIColor colorWithRed:222/255.0 green:165/255.0 blue:164/255.0 alpha:0.25];
        self.stopButton.userInteractionEnabled = NO;
        [self.stopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.refreshButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.refreshButton.titleLabel.text = NSLocalizedString(@"Refresh", @"Refresh command");
        self.refreshButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:179/255.0 blue:71/255.0 alpha:0.25];
        self.refreshButton.userInteractionEnabled = NO;
        [self.refreshButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        self.allTheButtons = [[NSMutableArray alloc] initWithObjects:self.backButton, self.forwardButton, self.stopButton, self.refreshButton, nil];
     
        
        for (UIButton *thisButton in self.allTheButtons) {
            [self addSubview:thisButton];
        }

        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panFired:)];
        [self addGestureRecognizer:self.panGesture];
        self.pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchFired:)];
        [self addGestureRecognizer:self.pinchGesture];
        self.longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressFired:)];
        [self addGestureRecognizer:self.longPressGesture];
        
        
        BLCAwesomeFloatingToolbar *awesomeToolbar = [[BLCAwesomeFloatingToolbar alloc] initWithFourButtons:(NSMutableArray *)allTheButtons];
        
        [self addSubview:awesomeToolbar];
       
    }

return self;
}

-(IBAction) buttonTapped: (id) sender {
    
}

- (void) layoutSubviews {
    // set the frames for the 4 labels
    
    for (UIButton *thisButton in self.allTheButtons) {
        NSUInteger currentButtonIndex = [self.allTheButtons indexOfObject:thisButton];
        
        CGFloat buttonHeight = CGRectGetHeight(self.bounds) / 2;
        CGFloat buttonWidth = CGRectGetWidth(self.bounds) / 2;
        CGFloat buttonX = 0;
        CGFloat buttonY = 0;
        
        // adjust labelX and labelY for each label
        if (currentButtonIndex < 2) {
            // 0 or 1, so on top
            buttonY = 0;
        } else {
            // 2 or 3, so on bottom
            buttonY = CGRectGetHeight(self.bounds) / 2;
        }
        
        if (currentButtonIndex % 2 == 0) { // is currentLabelIndex evenly divisible by 2?
            // 0 or 2, so on the left
            buttonX = 0;
        } else {
            // 1 or 3, so on the right
            buttonX = CGRectGetWidth(self.bounds) / 2;
        }
        
        thisButton.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
    }
}

#pragma mark - Touch Handling

//- (UIButton *) buttonFromTouches:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    CGPoint location = [touch locationInView:self];
//    UIView *subview = [self hitTest:location withEvent:event];
//    return (UIButton *)subview;
// }

- (void) panFired:(UIPanGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:self];
        
        NSLog(@"New translation: %@", NSStringFromCGPoint(translation));
        
        if ([self.delegate respondsToSelector:@selector(floatingToolbar:didTryToPanWithOffset:)]) {
            [self.delegate floatingToolbar:self didTryToPanWithOffset:translation];
        }
        
        [recognizer setTranslation:CGPointZero inView:self];
    }
}



- (void) pinchFired:(UIPinchGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateRecognized) {
        // resize the awesome toolbar
        static CGPoint center;
        static CGSize initialSize;
        if (recognizer.state == UIGestureRecognizerStateRecognized) {
            
            
            
        }
    }
    
}

- (void) longPressFired:(UILongPressGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateRecognized) {
    self.backButton.backgroundColor = self.forwardButton.backgroundColor;
    self.forwardButton.backgroundColor = self.stopButton.backgroundColor;
    self.stopButton.backgroundColor = self. refreshButton.backgroundColor;
    self.refreshButton.backgroundColor = self.backButton.backgroundColor;
    }
}

#pragma mark - Button Enabling

- (void) setEnabled:(BOOL)enabled forButtonWithTitle:(NSString *)title {
    NSUInteger index = [self.currentTitles indexOfObject:title];
    
    if (index != NSNotFound) {
        UIButton *button = [self.allTheButtons objectAtIndex:index];
        button.userInteractionEnabled = enabled;
        button.alpha = enabled ? 1.0 : 0.25;
    }
}

@end

// for (NSString *currentTitle in self.currentTitles) {
//     UIButton *button = [[UIButton alloc] init];
//     button.userInteractionEnabled = NO;
//     button.alpha = 0.25;

//      NSUInteger currentTitleIndex = [self.currentTitles indexOfObject:currentTitle];
//      NSString *titleForThisButton = [self.currentTitles objectAtIndex:currentTitleIndex];
//      UIColor *colorForThisButton = [self.colors objectAtIndex:currentTitleIndex];
//      [button setBackgroundColor:[UIColor colorForThisButton]];

//    [button setTitle:(@"%@", titleForThisButton) forState:UIControlStateNormal];

//        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

// [buttonsArray addObject:button];
//    }

//  self.buttons = buttonsArray;

//- (void) tapFired:(UITapGestureRecognizer *)recognizer {
//    if (recognizer.state == UIGestureRecognizerStateRecognized) {
//       CGPoint location = [recognizer locationInView:self];
//    UIView *tappedView = [self hitTest:location withEvent:nil];
//
//        if ([self.buttons containsObject:tappedView]) {
//            if ([self.delegate respondsToSelector:@selector(floatingToolbar:didSelectButtonWithTitle:)]) {
//                [self.delegate floatingToolbar:self didSelectButtonWithTitle:((UILabel *)tappedView).text];
//            }
//        }
//    }
// }
