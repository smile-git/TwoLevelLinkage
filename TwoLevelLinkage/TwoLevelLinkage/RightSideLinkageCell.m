//
//  RightSideLinkageCell.m
//  TwoLevelLinkage
//
//  Created by ZWX on 18/01/2018.
//  Copyright © 2018 ZWX. All rights reserved.
//

#import "RightSideLinkageCell.h"

@interface RightSideLinkageCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@end

@implementation RightSideLinkageCell

- (void)setupCell {
    
    [super setupCell];
}

- (void)buildSubview {
    
    [super buildSubview];
    
//    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]
}

- (void)loadContent {
    
    [super loadContent];
}



+ (CGFloat)cellHeightWithData:(id)data {
    
    return 60.f;
}

@end
