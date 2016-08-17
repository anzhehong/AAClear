//
//  AAClearTableViewController.h
//  AAClearStyle
//
//  Created by An, Fowafolo on 16/8/16.
//  Copyright © 2016年 An, Fowafolo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AATodoItem.h"
#import "AAClearCell.h"


static NSString* const reuseIdentifier = @"AAClearCell";

@interface AAClearTableViewController : UITableViewController <AAClearCellDelegate>

@end
