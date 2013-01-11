//
//  BlindViewController.m
//  FoldableMenu
//
//  Created by Peter Brock on 09/01/2013.
//  Copyright (c) 2013 Atos. All rights reserved.
//

#import "BlindViewController.h"
#import "UIMenuBlind.h"
#import "BlindContentView.h"

@interface BlindViewController ()

@end

@implementation BlindViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIImageView *tabView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BlindTab.png"]];
    BlindContentView *contentView = [BlindContentView loadFromNib];
    BlindContentGoCompletionBlock goCompletionBlock = ^(NSString *text) {
        self.textLabel.text = text;
    };
    [contentView setCompletionBlock:goCompletionBlock];
    
    UIMenuBlind *menu = [[UIMenuBlind alloc] initWithContentView:contentView andTabView:tabView];
    [menu setHiddenContentViewOrigin:CGPointMake(0.0f, 0.0f)];
    [self.view addSubview:menu];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTextLabel:nil];
    [super viewDidUnload];
}
@end
