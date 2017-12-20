//
//  AdData.m
//  YU-IOS
//
//  Created by yuhao on 2017/12/8.
//  Copyright © 2017年 yuhao. All rights reserved.
//

#import "AdData.h"
#import "AdModel.h"
#import "GDataXMLNode.h"

@interface AdData()

@property (nonatomic, strong) AdModel *adModel;

@end

@implementation AdData

#pragma mark -
#pragma mark load  data

- (void)loadAdData:(NSString *)urlstr Result:(void(^)(NSArray *resultArr))getresult{
    
    YHDatasourceNetData *netdata = [[YHDatasourceNetData alloc] init];
    NSMutableArray *netArr = [[NSMutableArray alloc] init];
    [netdata RequestXML:urlstr Parameter:nil completion:^(id  _Nonnull result, BOOL isSuccess) {
        if (isSuccess) {
            GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:result options:0 error:nil];
            GDataXMLElement *rootElement = [document rootElement];
            GDataXMLElement *controller = [[rootElement elementsForName:@"controller"] lastObject];
            GDataXMLElement *idElement = [[controller elementsForName:@"id"] lastObject];
            GDataXMLElement *showElement = [[controller elementsForName:@"show"] lastObject];
            GDataXMLElement *imagesE = [[controller elementsForName:@"images"] lastObject];
            NSArray *images = [imagesE elementsForName:@"image"];
            
            for (GDataXMLElement *image in images) {
                AdModel *model = [[AdModel alloc] init];
                model.ad_id = idElement.stringValue;
                model.adShow = [showElement.stringValue boolValue];
                model.ad_url = image.stringValue;
                GDataXMLNode *w = [image attributeForName:@"w"];
                GDataXMLNode *h = [image attributeForName:@"h"];
                if (w) {
                    model.w = [w.stringValue floatValue];
                }
                if (h) {
                    model.h = [h.stringValue floatValue];
                }
                [netArr addObject:model];
            }
            getresult(netArr);
        }else{
            
        }
    }];
}

@end
