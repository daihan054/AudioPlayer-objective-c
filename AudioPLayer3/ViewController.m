//
//  ViewController.m
//  AudioPLayer3
//
//  Created by REVE Systems on 31/7/23.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Song" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.slider.maximumValue = self.audioPlayer.duration;
    self.sliderTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    
    [self updateAudioLengthLabel];
    [self updateElapsedTimeLabel];
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    [self.audioPlayer stop];
    [self.audioPlayer setCurrentTime:self.slider.value];
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
    [self updateElapsedTimeLabel];
    [self updatePlayButtonImage];
}

- (IBAction)pauseButtonTapped:(UIButton *)sender {
    if (self.audioPlayer.isPlaying) {
        [self.audioPlayer pause];
        [self.sliderTimer invalidate];
        self.sliderTimer = nil;
    } else {
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        self.sliderTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    }
    [self updateElapsedTimeLabel];
    [self updatePlayButtonImage];
}

- (void)updatePlayButtonImage {
    if (self.audioPlayer.isPlaying) {
        [self.pauseButton setImage:[UIImage systemImageNamed:@"pause.fill"] forState:UIControlStateNormal];
    } else {
        [self.pauseButton setImage:[UIImage systemImageNamed:@"play.fill"] forState:UIControlStateNormal];
    }
}

- (void)updateProgress {
    [self updateElapsedTimeLabel];
    [self updatePlayButtonImage];
    
    if (!self.audioPlayer.isPlaying) {
        [self.sliderTimer invalidate];
        self.sliderTimer = nil;
    }
}

- (void)updateAudioLengthLabel {
    NSInteger audioLength = (NSInteger)self.audioPlayer.duration;
    NSInteger minutes = audioLength / 60;
    NSInteger seconds = audioLength % 60;
    
    self.audioLengthLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
}

- (void)updateElapsedTimeLabel {
    NSInteger elapsedTime = (NSInteger)self.audioPlayer.currentTime;
    NSInteger minutes = elapsedTime / 60;
    NSInteger seconds = elapsedTime % 60;
    
    self.elapsedTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
    [self.slider setValue:self.audioPlayer.currentTime animated:YES];
}

@end

