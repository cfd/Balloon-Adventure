//
//  ViewController.m
//  Balloon Adventure
//
//  Created by Chris on 25/08/2015.
//  Copyright (c) 2015 Chris. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    birdies = [[NSMutableArray alloc] init];
    balloonLeft = [UIImage imageNamed:@"balloonleft.png"];
    balloonRight = [UIImage imageNamed:@"balloonright.png"];
    balloonStraight = [UIImage imageNamed:@"balloon.png"];
    [self startDeviceMotion];
    birdSpawnTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(makeBirds) userInfo:nil repeats:YES];
    cloudSpawnTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(makeClouds) userInfo:nil repeats:YES];
    distanceTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(countScore) userInfo:nil repeats:YES];
    deadTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(checkDead) userInfo:nil repeats:YES];
   
}

-(void)viewDidAppear:(BOOL)animated{
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)countScore{
    //NSLog(@"score: %f", metersTravelled);
    metersTravelled+=0.1;
    scoreLabel.text = [NSString stringWithFormat: @"%.2fm", metersTravelled];
}


-(void)makeClouds{
    
    for(int i=0; i<=1; i++){
        int spawnX = arc4random() % (int) [self view].frame.size.width - 50;
        int spawnY = arc4random() % 100;
        //NSLog(@"cloud");
        UIImageView *cloud =[[UIImageView alloc] initWithFrame:CGRectMake(spawnX,-60-spawnY,100,60)];
        
        
        
        int cloudNum = arc4random() % 3;
        switch (cloudNum) {
            case 0:
                cloud.image = [UIImage imageNamed:@"cloud1.png"];
                break;
            case 1:
                cloud.image = [UIImage imageNamed:@"cloud2.png"];
                break;
            case 2:
                cloud.image = [UIImage imageNamed:@"cloud3.png"];
                break;
                
            default:
                break;
        }
        
        
        [self.view addSubview:cloud];
        [self.view sendSubviewToBack:cloud];
        //float delay = arc4random() % 5;
        [UIView animateWithDuration:6.f
                              delay:0.5f
                            options:UIViewAnimationCurveLinear
                         animations:^{
                             cloud.frame = CGRectMake(spawnX, [self view].frame.size.height, 100, 60);
                         } completion:^(BOOL finished) {
                             [cloud removeFromSuperview];
                         }];
        
    }
}

    

-(void)makeBirds{
    
    int numOfBirds = arc4random() % 3;
    
    for (int i = 0; i <= numOfBirds; i++) {
    
        int spawnY;
        int spawnX;
        UIImage* birdyImage1;
        UIImage* birdyImage2;
        
        
        int targetX;
        //aims at balloon
        int offset = arc4random() % 100;
        switch (arc4random() % 2) {
            case 0:
                targetX = balloon.center.x + offset;
                break;
                
            case 1:
                targetX = balloon.center.x - offset;
                break;
                
            default:
                break;
        }
        
        
        //random target Y
        //int targetX = arc4random() % (int) [self view].frame.size.width;
        //or do like 400 or 410 ? :/
        int targetY = [self view].frame.size.height;
        
        
        switch (arc4random() % 3) {
                //spawn at random height on left (-)
            case 0:
                spawnX = 0;
                spawnY = arc4random() % (int) self.view.frame.size.height/2 - 100;
                birdyImage1 = [UIImage imageNamed:@"birdbackwardwingdown.png"];
                birdyImage2 = [UIImage imageNamed:@"birdbackwardwingup.png"];
                break;
                //spawn at random height on left (+)
            case 1:
                spawnX = [self view].frame.size.width - 20;
                spawnY = arc4random() % (int) self.view.frame.size.height/2 - 100;
                birdyImage1 = [UIImage imageNamed:@"birdwingdown.png"];
                birdyImage2 = [UIImage imageNamed:@"birdwingup.png"];
                break;
                //spawn at top (y = 0)
            case 2:
                spawnX = arc4random() % (int) [self view].frame.size.width;
                spawnY = 0;
                if(spawnX <= [self view].frame.size.width/2){
                    birdyImage1 = [UIImage imageNamed:@"birdbackwardwingdown.png"];
                    birdyImage2 = [UIImage imageNamed:@"birdbackwardwingup.png"];
                } else {
                    birdyImage1 = [UIImage imageNamed:@"birdwingdown.png"];
                    birdyImage2 = [UIImage imageNamed:@"birdwingup.png"];
                }
                break;
                
            default:
                break;
        }
        
        //NSLog(@"Spawn birdy");
        UIImageView *birdy =[[UIImageView alloc] initWithFrame:CGRectMake(spawnX,spawnY,20,20)];
        
        //birdy.image = birdyImage1;
        
        NSMutableArray *birdyImages = [[NSMutableArray alloc] initWithCapacity:2];
        
        //NSLog(@"%@", birdyImage1);
        
        [birdyImages addObject:birdyImage1];
        [birdyImages addObject:birdyImage2];
        
        
        birdy.animationImages = birdyImages;
        birdy.animationDuration = 1;
        birdy.animationRepeatCount = 0;
        [birdy startAnimating];
        
        [self.view addSubview:birdy];
        [birdies addObject:birdy];
        
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:2.0];
//        birdy.frame = CGRectMake(targetX, targetY, birdy.frame.size.width, birdy.frame.size.height);
//        [UIView commitAnimations];
        
        
        
        
        [UIView animateWithDuration:2.f
                              delay:0.0f
                            options:UIViewAnimationCurveLinear
                         animations:^{
                             birdy.frame = CGRectMake(targetX, targetY, birdy.frame.size.width, birdy.frame.size.height);
                         } completion:^(BOOL finished) {
                             [birdy removeFromSuperview];
                             [birdies removeObject:birdy];
                         }];
        
    }
    

    
    
    
}

-(void)checkDead{
    for(int i = 0; i < [birdies count]; i++) {
        UIImageView *birdy = [birdies objectAtIndex:i];
        
        //        if(birdy.center.x >= balloon.center.x-10 && birdy.center.x <= balloon.center.x+10 && birdy.center.y >= balloon.center.y-20 && birdy.center.y <= balloon.center.y+20){
        //            NSLog(@"dead");
        //        }
        
        CGRect flyingBirdy = [[birdy.layer presentationLayer] frame];
        if (CGRectIntersectsRect(flyingBirdy, balloon.frame)) {
            [birdSpawnTimer invalidate];
            birdSpawnTimer = nil;
            [deadTimer invalidate];
            deadTimer = nil;
            [cloudSpawnTimer invalidate];
            cloudSpawnTimer = nil;
            [distanceTimer invalidate];
            distanceTimer = nil;
            dead = YES;
            
        }
    }
}

- (CMMotionManager *)motionManager
{
    CMMotionManager *motionManager = nil;
    
    id appDelegate = [UIApplication sharedApplication].delegate;
    
    if ([appDelegate respondsToSelector:@selector(motionManager)]) {
        motionManager = [appDelegate motionManager];
    }
    

    return motionManager;
}


- (void)startDeviceMotion{
    [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc]init] withHandler:^(CMAccelerometerData *data,NSError *error)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             
             //NSLog(@"X: %f Y: %f, Z: %f", data.acceleration.x, data.acceleration.y, data.acceleration.z);
             
             //balloon.center = CGPointMake(balloon.center.x + (data.acceleration.x * 20), balloon.center.y);
             [balloon layoutIfNeeded];
             horizontalBalloonConstraint.constant += data.acceleration.x * 20;
             //NSLog(@"X: %f", data.acceleration.x);
             
             if (data.acceleration.x <= -0.04) {
                 balloon.image = balloonLeft;
             } else if(data.acceleration.x >= 0.02){
                 balloon.image = balloonRight;
             } else {
                 balloon.image = balloonStraight;
             }
             
             
             if(horizontalBalloonConstraint.constant >= [self view].frame.size.width/2 - 10){
                 horizontalBalloonConstraint.constant = [self view].frame.size.width/2 - 10;
             } else if(horizontalBalloonConstraint.constant <= -[self view].frame.size.width/2 + 10){
                 horizontalBalloonConstraint.constant = -[self view].frame.size.width/2 + 10;
                 
             }
             
             
             //do on a timer every 1 second with random spawn and target points
             //do similar for clouds which spawn at top and go vertically down
             //destroy objects at y=height
             //if bird hit balloon, game over
             //clouds must be behind balloon and birds

             if(dead){
                 dead = NO;
                 NSLog(@"doing dead thing");
                 [self.motionManager stopAccelerometerUpdates];
                 UIImageView *deadBalloon =[[UIImageView alloc] initWithFrame:CGRectMake(balloon.center.x,balloon.center.y,20,40)];
                 [balloon removeFromSuperview];
                 deadBalloon.image = [UIImage imageNamed:@"deadballoon.png"];
                 [self.view addSubview:deadBalloon];
                 scoreLabel.hidden = YES;
                 
                 
                 [UIView animateWithDuration:3.f
                                       delay:0.0f
                                     options:UIViewAnimationCurveLinear
                                  animations:^{
                                      deadBalloon.frame = CGRectMake(balloon.center.x, self.view.frame.size.height, deadBalloon.frame.size.width, deadBalloon.frame.size.height);
                                  } completion:^(BOOL finished) {
                                      [deadBalloon removeFromSuperview];
                                      
                                      [self animateScoreAndPresentBackButton];
                                      
                                  }];
                 
             }
             
             
             
         });
     }];
}

-(IBAction)backPressed:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)animateScoreAndPresentBackButton{
    finalScoreLabel.hidden = NO;
    backButton.hidden = NO;
    metresLabel.hidden = NO;
    finalScoreLabel.text = [NSString stringWithFormat:@"%.2f", metersTravelled];
    CATransition* labelTransition = [CATransition animation];
    labelTransition.type = kCATransitionPush;
    labelTransition.subtype = kCATransitionFromBottom;
    [finalScoreLabel.layer addAnimation:labelTransition forKey:@"push-transition"];
    
    CATransition* metresTransition = [CATransition animation];
    metresTransition.type = kCATransitionPush;
    metresTransition.subtype = kCATransitionFromBottom;
    [metresLabel.layer addAnimation:metresTransition forKey:@"push-transition"];
    
    CATransition* buttonTransition = [CATransition animation];
    buttonTransition.type = kCATransitionPush;
    buttonTransition.subtype = kCATransitionFromBottom;
    [backButton.layer addAnimation:buttonTransition forKey:@"push-transition"];
    
    
    
}

@end
