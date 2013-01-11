//
//  MenuBlind.m
//  FoldableMenu
//
//  Created by Peter Brock on 09/01/2013.
//  Copyright (c) 2013 Atos. All rights reserved.
//

#import "UIMenuBlind.h"

#define DEFAULT_TAB CGSizeMake(25, 20)
#define DEFAULT_VELOCITY 450.0f

@interface UIMenuBlind ()

- (void)initGestureRecognisers;

- (void)handlePan:(UIPanGestureRecognizer*)gesture;
- (void)handleTap:(UITapGestureRecognizer*)gesture;

- (void)animateToEndPointY:(CGFloat)endPoint;

@end

@implementation UIMenuBlind {
    CGPoint panHiddenOrigin;
    CGPoint panStartPoint;
    CGPoint panStartOrigin;
    
    CGFloat animationVelocity;
    
    BOOL isHidden;
}

#pragma mark Initialisation

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame andTabSize:DEFAULT_TAB];
}

- (id)initWithContentView:(UIView*)menuContent andTabView:(UIView*)tab
{
    CGRect targetFrame = CGRectMake(0.0f, 0.0f,
                                    menuContent.frame.size.width, menuContent.frame.size.height + tab.frame.size.height);
    self = [super initWithFrame:targetFrame];
    if (self) {
        
        self.contentView = menuContent;
        self.tabView = tab;
        
        CGRect contentFrame = self.contentView.frame;
        contentFrame.origin = CGPointMake(0.0f, 0.0f);
        self.contentView.frame = contentFrame;
        
        CGRect tabFrame = self.tabView.frame;
        tabFrame.origin = CGPointMake((targetFrame.size.width/2) - (tabFrame.size.width/2), contentFrame.size.height);
        self.tabView.frame = tabFrame;
        
        [self addSubview:self.contentView];
        [self addSubview:self.tabView];
        
        [self initGestureRecognisers];
        
        panHiddenOrigin = self.frame.origin;
        isHidden = YES;
        animationVelocity = DEFAULT_VELOCITY;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andTabSize:(CGSize)tabSize
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        CGRect contentFrame = CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height - tabSize.height);
        CGRect tabFrame = CGRectMake((frame.size.width/2) - (tabSize.width/2), contentFrame.size.height,
                                     tabSize.width, tabSize.height);
        
        self.contentView = [[UIView alloc] initWithFrame:contentFrame];
        self.tabView = [[UIView alloc] initWithFrame:tabFrame];
        
        [self addSubview:self.contentView];
        [self addSubview:self.tabView];
        
        //init display
        [self setBackgroundColor:[UIColor clearColor]];
        [self.contentView setBackgroundColor:[UIColor redColor]];
        [self.tabView setBackgroundColor:[UIColor orangeColor]];
        
        [self initGestureRecognisers];
        
        panHiddenOrigin = self.frame.origin;
        isHidden = YES;
        animationVelocity = DEFAULT_VELOCITY;
    }
    return self;
}

- (void)initGestureRecognisers {

    UIPanGestureRecognizer *panGestureRecogniser = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [panGestureRecogniser setMaximumNumberOfTouches:1];
    [panGestureRecogniser setMinimumNumberOfTouches:1];
    
    [self addGestureRecognizer:panGestureRecogniser];
    
    UITapGestureRecognizer *tapGestureRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [tapGestureRecogniser setNumberOfTapsRequired:1];
    [tapGestureRecogniser setNumberOfTouchesRequired:1];
    
    [self.tabView setUserInteractionEnabled:YES];
    [self.tabView addGestureRecognizer:tapGestureRecogniser];
}

#pragma mark - Customization
- (void)setHiddenContentViewOrigin:(CGPoint)hiddenOrigin {
    
    CGRect newFrame = self.frame;
    newFrame.origin = CGPointMake(hiddenOrigin.x, hiddenOrigin.y - self.contentView.frame.size.height);
    self.frame = newFrame;
    
    panHiddenOrigin = self.frame.origin;
}

- (void)setTabCentreOffset:(CGFloat)tabOffset {
    
    CGRect tabFrame = self.tabView.frame;
    tabFrame.origin.x += tabOffset;
    
    //correct the origin, incase it is too far to the left or the right of the overall blind
    if (tabFrame.origin.x < 0) {
        tabFrame.origin.x = 0;
    } else if ((tabFrame.origin.x + tabFrame.size.width) > self.frame.size.width) {
        tabFrame.origin.x = self.frame.size.width - tabFrame.size.width;
    }
    
    self.tabView.frame = tabFrame;
}

- (void)setAnimationVelocity:(CGFloat)newVelocity {
    animationVelocity = newVelocity;
}

#pragma mark - Gesture Recogization
- (void)handlePan:(UIPanGestureRecognizer*)gesture {
    
    CGPoint translatedPoint = [gesture translationInView:self];
    CGPoint velocity = [gesture velocityInView:self];
    
    if ([gesture state] == UIGestureRecognizerStateBegan) {
        
        panStartOrigin = self.frame.origin;
        panStartPoint = translatedPoint;
        
    } else if ([gesture state] == UIGestureRecognizerStateEnded) {

        CGFloat endOrigin = 0.0f;
        if (velocity.y > 0) {
            endOrigin = panHiddenOrigin.y + self.contentView.frame.size.height;
            isHidden = NO;
        } else {
            endOrigin = panHiddenOrigin.y;
            isHidden = YES;
        }
        
        [self animateToEndPointY:endOrigin];
        
    } else {
        
        if (velocity.y > 0) {
            //going down
        } else {
            //going up
        }
        
        CGRect movedFrame = self.frame;
        
        //move the menu
        movedFrame.origin.y = panStartOrigin.y + (translatedPoint.y - panStartPoint.y);
        
        //cap the movement
        if (movedFrame.origin.y > (panHiddenOrigin.y + self.contentView.frame.size.height)) {
            movedFrame.origin.y = panHiddenOrigin.y + self.contentView.frame.size.height;
        } else if (movedFrame.origin.y < panHiddenOrigin.y) {
            movedFrame.origin.y = panHiddenOrigin.y;
        }
        
        self.frame = movedFrame;
    }
}

- (void)handleTap:(UITapGestureRecognizer*)gesture {
        
    CGFloat endOrigin = 0.0f;
    if (isHidden) {
        endOrigin = panHiddenOrigin.y + self.contentView.frame.size.height;
        isHidden = NO;
    } else {
        endOrigin = panHiddenOrigin.y;
        isHidden = YES;
    }
    
    [self animateToEndPointY:endOrigin];
}

#pragma mark - Animation

- (void)animateToEndPointY:(CGFloat)endPoint {
    CGFloat current = self.frame.origin.y;
    CGFloat distanceLeft = endPoint - current;
    CGFloat duration = fabs(distanceLeft)/animationVelocity;
    
    [UIView animateWithDuration:duration animations:^{
        
        CGRect movedFrame = self.frame;
        movedFrame.origin.y = endPoint;
        self.frame = movedFrame;
    }];
}

@end
