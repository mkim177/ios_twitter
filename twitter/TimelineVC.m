//
//  TimelineVC.m
//  twitter
//
//  Created by Timothy Lee on 8/4/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TweetCell.h"
#import "TimelineVC.h"
#import "TweetViewController.h"
#import "ComposeTweetViewController.h"

NSString * const UpdateTimeline = @"UpdateTimeline";

@interface TimelineVC ()

@property (nonatomic, strong) NSMutableArray *tweets;
@property (nonatomic, strong) TweetCell *offscreenCell;

- (void)onNewTweetButton;
- (void)onSignOutButton;
- (void)reload;

@end

@implementation TimelineVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Twitter";
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:UpdateTimeline object:nil];
        
        [self reload];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *customNib = [UINib nibWithNibName:@"TweetCell" bundle:nil];
    [self.tableView registerNib:customNib forCellReuseIdentifier:@"TweetCell"];

    //Add a pull to refresh control
    UIRefreshControl *rc = [[UIRefreshControl alloc]init];
    rc.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh"];
    [rc addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;

    //moved the sign out button to top left
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onSignOutButton)];
    
    //add a compose new tweet button to the top right
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onNewTweetButton)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TweetCell";
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Tweet *tweet = self.tweets[indexPath.row];
    [cell initWithTweet:tweet];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //add a tweet view to the stack on select
    TweetViewController *tvc = [[TweetViewController alloc] init];
    [tvc initWithTweet:self.tweets[indexPath.row]];
    
    [self.navigationController pushViewController:tvc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //for offscreen cells
    return 80.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.offscreenCell == nil) {
        self.offscreenCell = [[TweetCell alloc] init];
    }
    
    Tweet *tweet = self.tweets[indexPath.row];
    
    //use the offscreen cell to check cell height
    [self.offscreenCell initWithTweet:tweet];
    [self.offscreenCell setNeedsLayout];
    [self.offscreenCell layoutIfNeeded];
    
    //get the height for the cell
    CGFloat height = [self.offscreenCell cellHeight];
    
    return height;
}

- (void)onNewTweetButton {
    //create a compose VC
    ComposeTweetViewController *ctvc = [[ComposeTweetViewController alloc] init];
    [self.navigationController pushViewController:ctvc animated:YES];
}

- (void)onSignOutButton {
    [User setCurrentUser:nil];
}

- (void)reload {
    [[TwitterClient instance] homeTimelineWithCount:20 sinceId:0 maxId:0 success:^(AFHTTPRequestOperation *operation, id response) {
        [self.refreshControl endRefreshing];
        
        NSLog(@"%@", response);
        self.tweets = [Tweet tweetsWithArray:response];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Do nothing
    }];
}

@end
