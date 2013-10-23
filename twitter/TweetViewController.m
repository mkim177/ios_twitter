//
//  TweetViewController.m
//  twitter
//
//  Created by Mark Kim on 10/21/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TweetViewController.h"

@interface TweetViewController ()

@end

@implementation TweetViewController

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
    // Do any additional setup after loading the view from its nib.
    
    //set the Tweet View UI with data from the tweet model
    self.textLabel.text = self.tweet.text;
    self.userNameLabel.text = [NSString stringWithFormat:@"%@ @%@",self.tweet.username,self.tweet.screenName];
    self.dateLabel.text = self.tweet.createdDate;
    
    // handle the image again - need a better way to do this
    NSURL * imageURL = [NSURL URLWithString:self.tweet.profilePicUrl];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    
    [self.profileImageView setImage:image];
    
    NSString *myScreenName = [[User currentUser] valueOrNilForKeyPath:@"screen_name"];
    
    //setup button actions
    [self.replyButton setTarget:self];
    [self.replyButton setAction:@selector(onReply)];
    
    //don't allow user to retweet their own post or if already retweeted
    if (self.tweet.retweeted || [self.tweet.screenName isEqualToString:myScreenName]) {
        self.retweetButton.enabled = NO;
    }
    else {
        [self.retweetButton setTarget:self];
        [self.retweetButton setAction:@selector(onRetweet)];
    }

    //don't allow user to favorite their own post or if already favorited
    if (self.tweet.favorited || [self.tweet.screenName isEqualToString:myScreenName]) {
        self.addFavoriteButton.enabled = NO;
    }
    else {
        [self.addFavoriteButton setTarget:self];
        [self.addFavoriteButton setAction:@selector(onAddFavorite)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onAddFavorite
{
    [[TwitterClient instance] addFavoriteWithTweetId:self.tweet.tweetId success:^(AFHTTPRequestOperation *operation, id response) {
        self.addFavoriteButton.enabled = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error description]);
    }];
   
}

- (void)onReply
{
    // use ComposeTweetViewController for a reply, but set a replyTweet
    ComposeTweetViewController *ctvc = [[ComposeTweetViewController alloc]init];
    ctvc.replyTweet = self.tweet;
    [self.navigationController pushViewController:ctvc animated:YES];
}

- (void)onRetweet
{
    [[TwitterClient instance] retweetWithTweetId:self.tweet.tweetId success:^(AFHTTPRequestOperation *operation, id response) {
        self.retweetButton.enabled = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error description]);
    }];
    
}

// function to pass a tweet to this controller
- (void) initWithTweet:(Tweet *)tweet
{
    self.tweet = tweet;
}

@end
