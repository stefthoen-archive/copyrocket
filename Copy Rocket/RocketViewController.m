//
//  ViewController.m
//  Copy Rocket
//
//  Created by Stef Thoen on 12-08-12.
//  Copyright (c) 2012 Stef Thoen. All rights reserved.
//

#import "RocketViewController.h"
#import "RocketModule.h"
#import "AFNetworking.h"
#import "SendGridClient.h"

@interface RocketViewController ()

@end

@implementation RocketViewController {
    NSMutableArray *_modules;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        _modules = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.    
}

- (void)viewDidUnload
{
    emailTextField = nil;
    rocketTableView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didReceiveNewDataFromPasteboard:(UIPasteboard *)pasteboard
{
    RocketModule *module = [[RocketModule alloc] initWithModuleContent:[pasteboard string]];
    [_modules addObject:module];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_modules count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RocketModuleTableViewCell"];
    
    NSInteger row = [indexPath indexAtPosition:1];
    
    cell.textLabel.text = ((RocketModule *)[_modules objectAtIndex:row]).moduleContent;
    
    return cell;
}

- (void)refresh {
    
    NSURL *baseURL = [NSURL URLWithString:@"https://sendgrid.com/"];
    
    SendGridClient *client = [[SendGridClient alloc] initWithBaseURL:baseURL];
    NSString *text = [[NSString alloc] init];
    
    for (RocketModule *module in _modules) {
        text = [text stringByAppendingString:module.moduleContent];
        //NSLog(@"Email tekst: %@", module.moduleContent);
    }
    
    NSLog(@"Email tekst: %@", text);
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"baardbaard", @"api_user",
                            @"uZwzFQMtPZ7JrJy6MMgv", @"api_key",
                            @"Nieuw mailtje!", @"subject",
                            @"stef@baardbaard.nl", @"to",
                            text, @"text",
                            @"stef@baardbaard.nl", @"from",
                            nil];
        
    NSURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path:@"api/mail.send.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    }];
        
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"text/html",nil]];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                             NSLog(@"success: %@", JSON);
                                         } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id json) {
                                             NSLog(@"error: %@", error);
                                         }];
    
    [operation start];
        
    [self performSelector:@selector(stopLoading) withObject:nil];
}

@end
