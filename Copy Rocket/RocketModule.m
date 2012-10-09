//
//  RocketModule.m
//  Copy Rocket
//
//  Created by Stef Thoen on 12-08-12.
//  Copyright (c) 2012 Stef Thoen. All rights reserved.
//

#import "RocketModule.h"

@implementation RocketModule
@synthesize moduleContent;

- (id)initWithModuleContent:(NSString *)content
{
    self = [super init];
    
    if (self) {
        [self setModuleContent:content];
    }
    
    return self;
}

@end
