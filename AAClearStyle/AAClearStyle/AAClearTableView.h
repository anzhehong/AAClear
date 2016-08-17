//
//  AAClearTableView.h
//  AAClearStyle
//
//  Created by An, Fowafolo on 16/8/17.
//  Copyright © 2016年 An, Fowafolo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AAClearTableViewDataSource <NSObject>

// Informs the datasource that a new item has been added at the top of the table
- (void) itemAdded;

// Informs the datasource that a new item has been added at the given index
- (void) itemAddedAtIndex:(NSInteger)index;

@end

extern const float AA_ROW_HEIGHT;

@interface AAClearTableView : UITableView <AAClearTableViewDataSource>

@property (nonatomic, assign) id<AAClearTableViewDataSource> myDataSource;

@end
