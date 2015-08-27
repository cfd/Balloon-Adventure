//
//  ViewController.h
//  Balloon Adventure
//
//  Created by Chris on 25/08/2015.
//  Copyright (c) 2015 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController{
    IBOutlet UIImageView* balloon;
    IBOutlet NSLayoutConstraint* horizontalBalloonConstraint;
    
    UIImage* balloonLeft;
    UIImage* balloonRight;
    UIImage* balloonStraight;
    
    NSTimer* birdSpawnTimer;
    NSTimer* cloudSpawnTimer;
    NSTimer* distanceTimer;
    NSTimer* deadTimer;
    double metersTravelled;
    IBOutlet UILabel* scoreLabel;
    
    NSMutableArray* birdies;
    
    BOOL dead;
    
    IBOutlet UIButton* backButton;
    IBOutlet UILabel* finalScoreLabel;
    IBOutlet UILabel* metresLabel;
    
}

-(IBAction)backPressed:(id)sender;


@end

