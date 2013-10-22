//
//  TweetViewController.h
//  twitter
//
//  Created by Mark Kim on 10/21/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *twitterController;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) Tweet *tweet;

- (IBAction)twitterAction:(id)sender;
- (void) initWithTweet:(Tweet *) tweet;

@end
