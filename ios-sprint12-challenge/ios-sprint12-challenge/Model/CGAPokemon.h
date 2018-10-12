//
//  CGAPokemon.h
//  ios-sprint12-challenge
//
//  Created by Conner on 10/12/18.
//  Copyright © 2018 Conner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGAPokemon : NSObject
- (instancetype)initWithPokemon:(NSString *)name url:(NSString *)url;
- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;
@property NSString *name;
@property NSString *url;
@end

NS_ASSUME_NONNULL_END
