//
//  AAClearTableViewController.m
//  AAClearStyle
//
//  Created by An, Fowafolo on 16/8/16.
//  Copyright © 2016年 An, Fowafolo. All rights reserved.
//

#import "AAClearTableViewController.h"



@interface AAClearTableViewController () {
    NSMutableArray* _toDoItems;
}

@end

@implementation AAClearTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    [self setDefaultItems];
    
    //Set the estimated height for tableview cell
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    //Cannot use it if you want to load the cell from the interface builder.
//    [self.tableView registerClass:[AAClearCell class] forCellReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDefaultItems {
    // create a dummy to-do list
    _toDoItems = [[NSMutableArray alloc] init];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Feed the cat"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Buy eggs"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Pack bags for WWDC"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Rule the web"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Buy a new iPhone"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Find missing socks"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Write a new tutorial"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Master Objective-C"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Remember your wedding anniversary!Remember your wedding anniversary!Remember your wedding anniversary!"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Drink less beer"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Learn to draw"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Take the car to the garage"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Sell things on eBay"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Learn to juggle"]];
    [_toDoItems addObject:[AATodoItem toDoItemWithText:@"Give up"]];
}

- (UIColor*)colorForIndex:(NSInteger) index {
    NSUInteger itemCount = _toDoItems.count - 1;
    float val = ((float)index / (float)itemCount) * 0.6;
    return [UIColor colorWithRed:1.0 green:val blue:0.1 alpha:1.0];
}

#pragma mark - AAClearCell delegate
- (void)toDoItemDeleted:(id)toDoItem {
    NSUInteger index = [_toDoItems indexOfObject:toDoItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [_toDoItems removeObject:toDoItem];
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"%lu", (unsigned long)_toDoItems.count);
    return _toDoItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AAClearCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSInteger index = indexPath.row;
    AATodoItem *item = _toDoItems[index];
    cell.delegate = self;
    cell.todoItem = item;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [self colorForIndex:indexPath.row];
}

@end