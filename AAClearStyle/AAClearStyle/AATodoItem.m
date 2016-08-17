//
//  AATodoItem.m
//  AAClearStyle
//
//  Created by An, Fowafolo on 16/8/16.
//  Copyright © 2016年 An, Fowafolo. All rights reserved.
//

#import "AATodoItem.h"

@implementation AATodoItem

- (id)initWithText:(NSString *)text {
    if (self = [super init]) {
        self.text = text;
    }
    return self;
}

+ (id)toDoItemWithText:(NSString *)text {
    return [[AATodoItem alloc]initWithText:text];
}

@end
