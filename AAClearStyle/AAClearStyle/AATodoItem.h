//
//  AATodoItem.h
//  AAClearStyle
//
//  Created by An, Fowafolo on 16/8/16.
//  Copyright © 2016年 An, Fowafolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AATodoItem : NSObject

@property (nonatomic, copy) NSString* text;
@property (nonatomic) BOOL completed;

- (id)initWithText:(NSString *)text;

+ (id)toDoItemWithText:(NSString *)text;

@end
