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
    self.textLabel.text = self.tweet.text;
    self.userNameLabel.text = [NSString stringWithFormat:@"%@ @%@",self.tweet.username,self.tweet.screenName];
    self.dateLabel.text = self.tweet.createdDate;
    
    NSURL * imageURL = [NSURL URLWithString:self.tweet.profilePicUrl];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    
    //NSLog(@"%@, %@, %f, %f", tweet.username, tweet.createdDate, image.size.width, image.size.height);
    
    [self.profileImageView setImage:image];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)twitterAction:(id)sender {
    switch (self.twitterController.selectedSegmentIndex) {
        case 0:
            NSLog(@"Reply to tweet");
            break;
        case 1:
            NSLog(@"Retweet");
            break;
        case 2:
            NSLog(@"Add to favorites");
            break;

        default:
            break;
    }
}

- (void) initWithTweet:(Tweet *)tweet
{
    self.tweet = tweet;
}

@end
