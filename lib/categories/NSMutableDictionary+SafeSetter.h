//
// Created by ELEKT M on 11/12/15.
// Copyright (c) 2015 ELEKT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (SafeSetter)

-(void)setObjectIfNotNil:(id)object forKey:(NSString*)key;

@end