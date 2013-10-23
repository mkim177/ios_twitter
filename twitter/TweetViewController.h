//
//  TweetViewController.h
//  twitter
//
//  Created by Mark Kim on 10/21/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "ComposeTweetViewController.h"

@interface TweetViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) Tweet *tweet;

@property (weak, nonatomic) IBOutlet UIToolbar *actionToolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *replyButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *retweetButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addFavoriteButton;

- (void) initWithTweet:(Tweet *) tweet;
- (void) onRetweet;
- (void) onReply;
- (void) onAddFavorite;

@end
