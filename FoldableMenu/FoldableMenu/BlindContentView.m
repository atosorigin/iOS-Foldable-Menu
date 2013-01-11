//
//  BlindContentView.m
//  FoldableMenu
//
//  Created by Peter Brock on 10/01/2013.
//  Copyright (c) 2013 Atos. All rights reserved.
//

#import "BlindContentView.h"

@implementation BlindContentView

+ (BlindContentView*)loadFromNib
{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"BlindContentView" owner:self options:NULL];
    NSEnumerator *nibEnumerator = [nibContents objectEnumerator];
    BlindContentView *customView = nil;
    NSObject* nibItem = nil;
    while ((nibItem = [nibEnumerator nextObject]) != nil) {
        if ([nibItem isKindOfClass:[BlindContentView class]]) {
            customView = (BlindContentView*)nibItem;
            break;
        }
    }
    
    return customView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BlindBG.png"]]];
}

- (IBAction)goPressed:(id)sender {
    
    [self.textField resignFirstResponder];
    
    if (self.completionBlock) {
        self.completionBlock(self.textField.text);
    }
}

@end
