//
//  ComposeTweetViewController.m
//  twitter
//
//  Created by Mark Kim on 10/21/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "ComposeTweetViewController.h"

@interface ComposeTweetViewController ()

@end

@implementation ComposeTweetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tweetTextView.text = @"What's happening?";
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
