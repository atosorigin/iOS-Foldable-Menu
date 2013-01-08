//
//  ContentView.m
//  FoldableMenu
//
//  Created by Peter Brock on 08/01/2013.
//  Copyright (c) 2013 Atos. All rights reserved.
//

#import "ContentView.h"

@implementation ContentView

+ (ContentView*)loadFromNibWithPanDelegate:(id<UIGestureRecognizerDelegate>)delegate {
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"ContentView" owner:self options:NULL];
    NSEnumerator *nibEnumerator = [nibContents objectEnumerator];
    ContentView *customView = nil;
    NSObject* nibItem = nil;
    while ((nibItem = [nibEnumerator nextObject]) != nil) {
        if ([nibItem isKindOfClass:[ContentView class]]) {
            customView = (ContentView*)nibItem;
            break;
        }
    }
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:delegate action:@selector(onContentViewPanned:)];
	//panGestureRecognizer.delegate = delegate;
    [customView.tabView addGestureRecognizer:panGestureRecognizer];
    
    return customView;
}

@end
