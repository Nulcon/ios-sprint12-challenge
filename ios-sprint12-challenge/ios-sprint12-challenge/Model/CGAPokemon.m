//
//  CGAPokemon.m
//  ios-sprint12-challenge
//
//  Created by Conner on 10/12/18.
//  Copyright © 2018 Conner. All rights reserved.
//

#import "CGAPokemon.h"

@implementation CGAPokemon

- (instancetype)initWithPokemon:(NSString *)name url:(NSString *)url {
    self = [super init];
    if (self) {
        _name = name;
        _url = url;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSString *url = dictionary[@"url"];
    
    if (!name || !url) {
        return nil;
    }
    
    return [self initWithPokemon:name url:url];
}

@end
