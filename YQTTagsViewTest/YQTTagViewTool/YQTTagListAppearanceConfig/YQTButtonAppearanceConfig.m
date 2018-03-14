//
//  YQTButtonAppearanceConfig.m
//  YQTTagsViewTest
//
//  Created by J on 2018/3/14.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTButtonAppearanceConfig.h"
#import "UIImage+Stretchable.h"

@interface YQTButtonAppearanceConfig() {
    UIImage *_disabledBGImage;
}
@property(nonatomic,strong)UIColor *disabledBGColor;
@property(nonatomic,strong)UIColor *disabledBorderColor;
@end
@implementation YQTButtonAppearanceConfig
+(instancetype)defaultConfig {
    
    YQTButtonAppearanceConfig *config = [[YQTButtonAppearanceConfig alloc]init];
    config.normalTitleColor(Color(@"#FFFFFF")).selectTitleColor(Color(@"#FFFFFF"));
    config.normalBGColor(Color(@"#15A6EE")).selectBGColor(Color(@"#15A6EE"));
    config.normalBorderColor(Color(@"#15A6EE")).selectBorderColor(Color(@"#15A6EE"));
    config.YQTButtonDisabledBGColor(Color(@"#EDEDED"));
    
    config.titleFont(YQKINGFONT(18));
    
    return config;
}

//set
-(void)setTarget:(id)target {
    _target = target;
}
-(void)setSel:(SEL)sel {
    _sel = sel;
}
-(void)setNormalImage:(UIImage *)normalImage {
    _normalImage = normalImage;
}
-(void)setSelectedImage:(UIImage *)selectedImage {
    _selectedImage = selectedImage;
}
-(void)setDisabledBGColor:(UIColor *)disabledBGColor {
    _disabledBGColor = disabledBGColor;
}


//get
-(UIImage *)disabledBGImage{
    if (!_disabledBGImage) {
        CGSize size = CGSizeMake(1, 1);
        if (self.cornerRadius) {
            size = CGSizeMake(self.cornerRadius*2, self.cornerRadius*2);
        }
        UIColor *bgColor = self.disabledBGColor?self.disabledBGColor:[UIColor clearColor];
        
        UIColor *borderColor = self.disabledBorderColor?self.disabledBorderColor:[UIColor clearColor];
        
        UIImage *image = [UIImage hyb_imageWithColor:bgColor toSize:size cornerRadius:self.cornerRadius backgroundColor:bgColor borderColor:borderColor borderWidth:self.borderWidth];
        _disabledBGImage = image.stretchableImage;
        
    }
    return  _disabledBGImage;
}
-(YQTButtonAppearanceConfig *(^)(id))YQTButtonTarget {
    return ^(id target){
        self.target = target;
        return self;
    };
}
-(YQTButtonAppearanceConfig *(^)(SEL))YQTButtonSEL {
    return ^(SEL sel){
        self.sel = sel;
        return self;
    };
}
-(YQTButtonAppearanceConfig *(^)(NSString *))YQTButtonNormalImage {
    return ^(NSString *name){
        self.normalImage = [UIImage imageNamed:name];
        return self;
    };
}
-(YQTButtonAppearanceConfig *(^)(NSString *))YQTButtonSelectedImage {
    return ^(NSString *name){
        self.selectedImage = [UIImage imageNamed:name];
        return self;
    };
}
-(YQTButtonAppearanceConfig *(^)(UIColor *))YQTButtonDisabledBGColor {
    return ^(UIColor *color){
        self.disabledBGColor = color;
        return self;
    };
}
-(YQTButtonAppearanceConfig *(^)(UIColor *))YQTButtonDisabledBorderColor {
    return ^(UIColor *color){
        self.disabledBorderColor = color;
        return self;
    };
}
@end
