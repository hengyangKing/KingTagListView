//
//  YQTAssignVocabularyOptionsRelatedcCatalogs.h
//  YIQITeacher
//
//  Created by J on 2018/2/1.
//  Copyright © 2018年 17zuoye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQTAssignVocabularyOptionsRelatedcCatalogs :NSObject
@property(nonatomic,copy)NSString * series_id;
@property(nonatomic,copy)NSString * book_id;
@property(nonatomic,copy)NSString * unit_id;
@property(nonatomic,copy)NSString * lesson_id;
@property(nonatomic,copy)NSString * section_id;
@property(nonatomic,assign)NSInteger term_type;
@property(nonatomic,assign)NSInteger class_level;
@property(nonatomic,assign)BOOL book_not_empty;
@property(nonatomic,assign)BOOL book_empty;
@end
