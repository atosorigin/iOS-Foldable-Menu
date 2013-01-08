//
//  ViewController.m
//  FoldableMenu
//
//  Created by Mike Williams on 07/01/2013.
//  Copyright (c) 2013 Atos. All rights reserved.
//

#import "ViewController.h"
#import "ContentView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"view frame at viewDidLoad [%@]", NSStringFromCGRect(_containerView.frame));
    
    _paperFoldView = [[PaperFoldView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    [_containerView addSubview:_paperFoldView];
    
    //_mapView = [[MKMapView alloc] initWithFrame:_paperFoldView.frame];
    //[_paperFoldView setCenterContentView:_mapView];
    //UIView *temp = [[UIView alloc] initWithFrame:_paperFoldView.frame];
    //[temp setBackgroundColor:[UIColor greenColor]];
    ContentView *cv = [ContentView loadFromNibWithPanDelegate:_paperFoldView];
    [_paperFoldView setCenterContentView: cv];
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0,0,[self.view bounds].size.width,60)];
    [_topView setBackgroundColor:[UIColor redColor]];
    UILabel *topLabel = [[UILabel alloc] initWithFrame:_topView.frame];
    [topLabel setText:@"A"];
    [topLabel setBackgroundColor:[UIColor clearColor]];
    [topLabel setFont:[UIFont boldSystemFontOfSize:50]];
    [topLabel setTextAlignment:UITextAlignmentCenter];
    [_topView addSubview:topLabel];
    
    ShadowView *topShadowView = [[ShadowView alloc] initWithFrame:CGRectMake(0,_topView.frame.size.height-5,_topView.frame.size.width,5) foldDirection:FoldDirectionVertical];
    [topShadowView setColorArrays:@[[UIColor colorWithWhite:0 alpha:0.3],[UIColor clearColor]]];
    [_topView addSubview:topShadowView];
    
    [_paperFoldView setTopFoldContentView:_topView topViewFoldCount:1 topViewPullFactor:0.9];
    [_paperFoldView setPaperFoldInitialPanDirection:PaperFoldInitialPanDirectionVertical];
    
    //[_paperFoldView setEnableTopFoldDragging:NO];
    
    /*
     
#warning disabling scroll, requires tapping cell twice to select cells. to be fixed
    [_centerTableView setScrollEnabled:NO];
    //[_paperFoldView setEnableHorizontalEdgeDragging:YES];
     
     */
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    NSLog(@"view frame at viewDidLayout [%@]", NSStringFromCGRect(_containerView.frame));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testClicked:(id)sender {
    if (_paperFoldView.state == PaperFoldStateDefault) {
        [_paperFoldView setPaperFoldState:PaperFoldStateTopUnfolded];
    } else {
        [_paperFoldView setPaperFoldState:PaperFoldStateDefault];
    }
}
@end
