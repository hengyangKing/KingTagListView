//
//  YQTAssignVocabularyOptionsModel.m
//  YIQITeacher
//
//  Created by J on 2018/1/31.
//  Copyright © 2018年 17zuoye. All rights reserved.
//

#import "YQTAssignVocabularyOptionsModel.h"
@implementation YQTAssignVocabularyOptionsDeleteModel
-(NSMutableArray *)words {
    if (!_words) {
        _words = [NSMutableArray array];
    }
    return _words;
}
-(NSMutableArray *)content_types {
    if (!_content_types) {
        _content_types = [NSMutableArray array];
    }
    return _content_types;
}
@end

@interface YQTAssignVocabularyOptionsModel()

@end
@implementation YQTAssignVocabularyOptionsModel

+(NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"content_types" : [YQTAssignVocabularyOptionsContentType class],
             @"words" :
                 [YQTAssignVocabularyOptionsWord class],
             @"related_catalogs" : [YQTAssignVocabularyOptionsRelatedcCatalogs class]
             };
}
-(YQTAssignVocabularyOptionsDeleteModel *)deleteModel {
    if (!_deleteModel) {
        _deleteModel = [[YQTAssignVocabularyOptionsDeleteModel alloc]init];
    }
    return _deleteModel;
}
#pragma mark func

///选中某个题型
-(void)selectContent_type:(NSUInteger)index {
    YQTAssignVocabularyOptionsContentType * content_type = self.content_types[index];
    content_type.selected = !content_type.selected;
    if ([ self.deleteModel.content_types containsObject:content_type]) {
        //包含
        [ self.deleteModel.content_types removeObject:content_type];
    }else{
        //不包含
        [ self.deleteModel.content_types addObject:content_type];
    }
}

///选中某个单词
-(void)selectWord:(NSUInteger)index {
    //词汇或句子
    YQTAssignVocabularyOptionsWord * word = self.words[index];
    word.selected = !word.selected;//反选
    if ([self.deleteModel.words containsObject:word]) {
        //包含
        [self.deleteModel.words removeObject:word];
    }else{
        //不包含
        [self.deleteModel.words addObject:word];
    }
}
///全选某类tag
-(void)selectAllWords {
    //刷新数据
    [self.words makeObjectsPerformSelector:@selector(setSelected:) withObject:@(YES)];
    [self.deleteModel.words removeAllObjects];
    [self.deleteModel.words addObjectsFromArray:[self.words copy]];
    
}
///全部反选某类tag
-(void)unSelectAllWords {
    //刷新数据
    [self.words makeObjectsPerformSelector:@selector(setIsSelect:) withObject:@(NO)];
    [self.deleteModel.words removeAllObjects];
}
-(NSDictionary *)commitPar {
    ///ti
    return [NSDictionary dictionary];
}
@end
