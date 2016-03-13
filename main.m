//
//  main.m
//  dictionary
//
//  Created by Abhishek Chatterjee on 3/11/16.
//  Copyright © 2016 achatterjee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ReplaceExtensions)
- (NSString *)stringByReplacingStringsFromDictionary:(NSDictionary *)dict;
@end

@implementation NSString (ReplaceExtensions)
-(NSString*)stringByReplacingStringsFromDictionary:(NSDictionary*)dict
{
    NSMutableString *string = self.mutableCopy;
    for(NSString *key in dict)
        [string replaceOccurrencesOfString:key withString:dict[key] options:0 range:NSMakeRange(0, string.length)];
    return string.copy;
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if(argc != 2)
        {
            printf("Usage: define <word to define>\n");
            return -1;
        }
                   
        NSString * search = [NSString stringWithCString: argv[1] encoding: NSUTF8StringEncoding];
                   
        CFStringRef def = DCSCopyTextDefinition(NULL,
                                         (__bridge CFStringRef)search,
                                         CFRangeMake(0, [search length]));
        
        NSString * output = [NSString stringWithFormat: @"Definition of <%@>:\n%@\n", search, (__bridge NSString *)def];
        
        NSDictionary *replacements = [NSDictionary dictionaryWithObjectsAndKeys:
                                      @"", @"▶",
                                      @"\n\033[1mnoun\033[0m\n", @" noun",
                                      @"\n\033[1mverb\033[0m\n",@" verb",
                                      @"\n\033[1madjective\033[0m\n" , @" adjective",
                                      @"\n\033[1mpronoun\033[0m\n",@" pronoun",
                                      @"\n\033[1madverb\033[0m\n",@" adverb",
                                      @"\n\033[1mORIGIN\033[0m\n", @"ORIGIN",
                                      @"\n\033[1mDERIVATIVES\033[0m\n",@"DERIVATIVES",
                                      @"\n\033[1mPHRASES\033[0m\n", @"PHRASES",
                                      @"\n\t•", @" •",
                                      @"\n1 ", @" 1 ",
                                      @"\n2 ", @" 2 ",
                                      @"\n3 ", @" 3 ",
                                      @"\n4 ", @" 4 ",
                                      @"\n5 ", @" 5 ",
                                      @"\n6 ", @" 6 ",
                                      @"\n7 ", @" 7 ",
                                      @"\n8 ", @" 8 ",
                                      @"\n9 ", @" 9 ",
                                      nil];
        
        output = [output stringByReplacingStringsFromDictionary:replacements];
        
        
        printf("%s", [output UTF8String]);
    }
    return 0;
}
