//
//  BlindContentView.h
//  FoldableMenu
//
//  Created by Peter Brock on 10/01/2013.
//  Copyright (c) 2013 Atos. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BlindContentGoCompletionBlock) (NSString *goText);

@interface BlindContentView : UIView

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, copy) BlindContentGoCompletionBlock completionBlock;

+ (BlindContentView*)loadFromNib;

- (IBAction)goPressed:(id)sender;

@end
