//
//  MenuBlind.h
//  FoldableMenu
//
//  Created by Peter Brock on 09/01/2013.
//  Copyright (c) 2013 Atos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIMenuBlind : UIView

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *tabView;

- (id)initWithContentView:(UIView*)menuContent andTabView:(UIView*)tab;
- (id)initWithFrame:(CGRect)frame andTabSize:(CGSize)tabSize;

- (void)setTabCentreOffset:(CGFloat)tabOffset;
- (void)setHiddenContentViewOrigin:(CGPoint)hiddenOrigin;
- (void)setAnimationVelocity:(CGFloat)newVelocity;

@end
