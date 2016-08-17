//
//  AAClearPullToAdd.h
//  AAClearStyle
//
//  Created by An, Fowafolo on 16/8/17.
//  Copyright © 2016年 An, Fowafolo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAClearCell.h"
#import "AAClearTableView.h"

@interface AAClearPullToAdd : NSObject <UITableViewDelegate>

// associates this behaviour with the given table
- (id)initWithTableView:(AAClearTableView*)tableView;

@end
