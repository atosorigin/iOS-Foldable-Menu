//
//  ViewController.h
//  FoldableMenu
//
//  Created by Mike Williams on 07/01/2013.
//  Copyright (c) 2013 Atos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MultiFoldView.h"
#import "PaperFoldView.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) PaperFoldView *paperFoldView;
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *containerView;

- (IBAction)testClicked:(id)sender;
@end
