//
//  HomeViewController.m
//  Balloon Adventure
//
//  Created by Chris on 2/09/2015.
//  Copyright (c) 2015 Chris. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    balloonSpawnTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(makeBalloons) userInfo:nil repeats:YES];

}


-(void)makeBalloons{
    NSLog(@"Balloon");
    int spawnX = arc4random() % (int) [self view].frame.size.width;
    int spawnY = arc4random() & 40;
    //NSLog(@"cloud");
    UIImageView *balloon =[[UIImageView alloc] initWithFrame:CGRectMake(spawnX,spawnY+[self view].frame.size.height,20,40)];
    
    
    
    
    balloon.image = [UIImage imageNamed:@"balloon.png"];
    
    
    
    [self.view addSubview:balloon];
    [self.view sendSubviewToBack:balloon];
    //float delay = arc4random() % 5;
    [UIView animateWithDuration:20.f
                          delay:0.5f
                        options:UIViewAnimationCurveLinear
                     animations:^{
                         balloon.frame = CGRectMake(spawnX, -40, 20, 40);
                     } completion:^(BOOL finished) {
                         [balloon removeFromSuperview];
                     }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
