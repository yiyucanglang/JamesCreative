//
//  RAMBlockB.m
//  RAMUtilDemo
//
//  Created by 裘俊云 on 2018/12/21.
//  Copyright © 2018 裘俊云. All rights reserved.
//

#import "RAMBlockB.h"
#import "RAMExport.h"
#import "ONLDynamicLoader.h"

#define DYTestBlock(param1, block)\
NSLog(@"param1 : %@", (param1));\
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{\
    int blockParam1 = 1;\
NSString *blockParam2 = [NSString stringWithFormat:@"哈哈 : %@", param1];\
    block(blockParam1, blockParam2);\
});\

@implementation RAMBlockB





//DYTestBlock(sss, block)

//RAM_BLOCKS_EXPORT(A, <#block#>)

RAM_BLOCKS_EXPORT(A, ^(void){
    printf("\nRAMBlockB:test block A");
})

RAM_BLOCKS_EXPORT(C, ^(void){
    printf("\nRAMBlockB:test block C");
        
})


CRDYML_FUNCTIONS_EXPORT_BEGIN(LEVEL_A)
NSLog(@"=====LEVEL_A=ssssssssssssss=========");
CRDYML_FUNCTIONS_EXPORT_END(LEVEL_A)
@end
