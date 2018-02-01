//
//  YQTAssignVocabularyOptionsModel.h
//  YIQITeacher
//
//  Created by J on 2018/1/31.
//  Copyright © 2018年 17zuoye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQTAssignVocabularyOptionsRelatedcCatalogs.h"
#import "YQTAssignVocabularyOptionsContentType.h"
#import "YQTAssignVocabularyOptionsWord.h"
#import "YQTAssignVocabularyOptionsCategory.h"

///需要删除的数据model
@interface YQTAssignVocabularyOptionsDeleteModel : NSObject
@property(nonatomic,strong)NSMutableArray *words;
@property(nonatomic,strong)NSMutableArray *content_types;
@end


@interface YQTAssignVocabularyOptionsModel : NSObject


@property(nonatomic,copy)NSString *_id;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *custom_name;
@property(nonatomic,copy)NSString *description_list;
@property(nonatomic,copy)NSString *objective_id;

///提交题目时直接回传给server
@property (nonatomic,copy)NSArray<YQTAssignVocabularyOptionsRelatedcCatalogs *> *related_catalogs;


@property(nonatomic,copy)NSString *deleted_at;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,assign)NSInteger single;
@property(nonatomic,strong)NSDictionary *knowledge_points_list;

///题目类型
@property(nonatomic,copy)NSArray<YQTAssignVocabularyOptionsContentType *> *content_types;

@property(nonatomic,copy)NSString *practice_type;

///词汇类型
@property(nonatomic,copy)NSArray<YQTAssignVocabularyOptionsWord *> *words;





////题库
//@property(nonatomic,copy)NSArray<YQTAssignVocabularyOptionsQuestionBox *> *question_boxes;

@property(nonatomic,strong)YQTAssignVocabularyOptionsCategory *category;



#pragma mark div par
@property(nonatomic,strong)YQTAssignVocabularyOptionsDeleteModel *deleteModel;

///提交请求参数
@property(nonatomic,copy,readonly)NSDictionary *commitPar;


#pragma mark func
///选中某个题型
-(void)selectContent_type:(NSUInteger)index;

///选中某个单词
-(void)selectWord:(NSUInteger)index;


///全选某类tag
-(void)selectAllWords;


///全部反选某类tag
-(void)unSelectAllWords;


@end
