//
//  CustomCell.m
//  LunBoDemo
//
//  Created by Ted on 16/5/12.
//  Copyright © 2016年 Ted. All rights reserved.
//

#import "YFLBCell.h"
#import "YFLBBannerView.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kNavigationBarHeight  64.0
#define kBannerHeight 240.0

@interface YFLBCell () <ZYBannerViewDataSource, ZYBannerViewDelegate>

@property (nonatomic, strong) YFLBBannerView *banner;

@end

@implementation YFLBCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupBanner];
        self.banner.shouldLoop = NO;
        self.banner.showFooter = YES;
        self.banner.autoScroll = YES;
        self.banner.scrollInterval = 3.0f;
    }
    return self;
}

- (void)setupBanner
{
    // 初始化
    self.banner = [[YFLBBannerView alloc] init];
    self.banner.dataSource = self;
    self.banner.delegate = self;
    [self.contentView addSubview:self.banner];
    
    // 设置frame
    self.banner.frame = CGRectMake(0,
                                   kNavigationBarHeight,
                                   kScreenWidth,
                                   kBannerHeight);
}

#pragma mark - ZYBannerViewDataSource

// 返回Banner需要显示Item(View)的个数
- (NSInteger)numberOfItemsInBanner:(YFLBBannerView *)banner
{
    return self.dataArray.count;
}

// 返回Banner在不同的index所要显示的View (可以是完全自定义的view, 且无需设置frame)
- (UIView *)banner:(YFLBBannerView *)banner viewForItemAtIndex:(NSInteger)index {
    // 取出数据
    NSString *imageName = self.dataArray[index];
    
    // 创建将要显示控件
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return imageView;
}

// 返回Footer在不同状态时要显示的文字
- (NSString *)banner:(YFLBBannerView *)banner titleForFooterWithState:(ZYBannerFooterState)footerState
{
    if (footerState == ZYBannerFooterStateIdle) {
        return @"拖动进入下一页";
    } else if (footerState == ZYBannerFooterStateTrigger) {
        return @"释放进入下一页";
    }
    return nil;
}

#pragma mark - ZYBannerViewDelegate

// 在这里实现点击事件的处理
- (void)banner:(YFLBBannerView *)banner didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"点击了第%ld个项目", index);
}

// 在这里实现拖动footer后的事件处理
- (void)bannerFooterDidTrigger:(YFLBBannerView *)banner
{
    NSLog(@"触发了footer");
}


#pragma mark Getter

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@"pic1.jpg", @"pic2.jpg", @"pic3.jpg", @"pic4.jpg", @"pic5.jpg"];
    }
    return _dataArray;
}

@end
