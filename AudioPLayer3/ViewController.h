//
//  ViewController.h
//  AudioPLayer3
//
//  Created by REVE Systems on 31/7/23.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UILabel *audioLengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *elapsedTimeLabel;
@property (strong, nonatomic) NSTimer *sliderTimer;

- (IBAction)sliderValueChanged:(UISlider *)sender;
- (IBAction)pauseButtonTapped:(UIButton *)sender;

@end


