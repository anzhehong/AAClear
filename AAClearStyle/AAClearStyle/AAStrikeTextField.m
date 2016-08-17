//
//  AAStrikeLabel.m
//  AAClearStyle
//
//  Created by An, Fowafolo on 16/8/17.
//  Copyright © 2016年 An, Fowafolo. All rights reserved.
//

#import "AAStrikeTextField.h"

@implementation AAStrikeTextField {
    bool _strikeThrough;
    CALayer* _strikeThroughLayer;
}

const float STRIKEOUT_THICKNESS = 2.0f;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _strikeThroughLayer = [CALayer layer];
        _strikeThroughLayer.backgroundColor = [[UIColor whiteColor] CGColor];
        _strikeThroughLayer.hidden = YES;
        [self.layer addSublayer:_strikeThroughLayer];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self resizeStrikeThrough];
}

- (void)setText:(NSString* )text {
    [super setText:text];
    [self resizeStrikeThrough];
}

/**
 *  resizes the strikethrough layer to match the current label text
 */
- (void)resizeStrikeThrough {
    CGSize textSize = [self.text sizeWithFont:self.font];
    _strikeThroughLayer.frame = CGRectMake(0, self.bounds.size.height / 2,
                                           textSize.width, STRIKEOUT_THICKNESS);
}

#pragma mark - property setter
- (void)setStrikeThrough:(bool)strikeThrough {
    _strikeThrough = strikeThrough;
    _strikeThroughLayer.hidden = !strikeThrough;
}

@end
