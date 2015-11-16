//
// Created by ELEKT M on 11/12/15.
// Copyright (c) 2015 ELEKT. All rights reserved.
//

#import "NSMutableDictionary+SafeSetter.h"


@implementation NSMutableDictionary (SafeSetter)

-(void)setObjectIfNotNil:(id)object forKey:(NSString*)key{

    if (object && key) {
        [self setValue:object forKey:key];
    }
}

@end