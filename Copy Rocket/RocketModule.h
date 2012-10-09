//
//  RocketModule.h
//  Copy Rocket
//
//  Created by Stef Thoen on 12-08-12.
//  Copyright (c) 2012 Stef Thoen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RocketModule : NSObject
{
}

- (id)initWithModuleContent:(NSString *)content;

@property (nonatomic, strong) NSString *moduleContent;

@end
