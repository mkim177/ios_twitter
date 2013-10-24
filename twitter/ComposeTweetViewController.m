//
//  ComposeTweetViewController.m
//  twitter
//
//  Created by Mark Kim on 10/21/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TimelineVC.h"
#import "ComposeTweetViewController.h"

@interface ComposeTweetViewController ()

-(void)onTweet;

@end

@implementation ComposeTweetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Compose";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tweetTextView.delegate = self;
    
    if (self.replyTweet != nil) {
        //same vc is used for replies if a replyTweet is set
        self.title = @"Reply";
        self.tweetTextView.text = [NSString stringWithFormat:@"@%@ ", self.replyTweet.screenName];
    }
    
    //add the publish button to the top right
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweet)];
    
    //set user values in the UI
    self.userNameLabel.text = [[User currentUser] valueOrNilForKeyPath:@"name"];
    
    NSString *screenName = [[User currentUser] valueOrNilForKeyPath:@"screen_name"];
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", screenName];
    
    NSString *profilePicUrl = [[User currentUser] valueOrNilForKeyPath:@"profile_image_url"];
    if (profilePicUrl != nil) {
        NSURL *imageURL = [NSURL URLWithString:profilePicUrl];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
        
        [self.profileImageView setImage:image];
    }
    
    [self.tweetTextView becomeFirstResponder];
}

// using the UITextView delegate method to check text length
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //alert the user if text limit is reached
    if (textView.text.length > 140) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Uh-oh!" message:@"Your Tweet might be too long. Stick to less than 140 characters." delegate:self cancelButtonTitle:@"Darn" otherButtonTitles:@"Ok", nil];

        [av show];
        
        //truncate text to keep it within the boundary
        textView.text = [textView.text substringToIndex:139];
        
        return NO;
    }
    return YES;
}

- (void)onTweet
{
    NSString *tweet = self.tweetTextView.text;
    
    if (self.replyTweet != nil) {
        [[TwitterClient instance] replyWithTweetIdAndString:self.replyTweet.tweetId reply:tweet success:^(AFHTTPRequestOperation *operation, id response) {
            [[NSNotificationCenter defaultCenter] postNotificationName:UpdateTimeline object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", [error description]);
        }];
    }
    else {
        [[TwitterClient instance] submitTweetWithMessage:tweet success:^(AFHTTPRequestOperation *operation, id response) {
            [[NSNotificationCenter defaultCenter] postNotificationName:UpdateTimeline object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", [error description]);
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
