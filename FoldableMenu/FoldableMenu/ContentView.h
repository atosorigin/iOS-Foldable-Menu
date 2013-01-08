//
//  ContentView.h
//  FoldableMenu
//
//  Created by Peter Brock on 08/01/2013.
//  Copyright (c) 2013 Atos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentView : UIView

+ (ContentView*)loadFromNibWithPanDelegate:(id<UIGestureRecognizerDelegate>)delegate;

@property (strong, nonatomic) IBOutlet UIView *tabView;
@end
