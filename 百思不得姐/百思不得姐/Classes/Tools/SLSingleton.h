//
//  SLSingleton.h
//  百思不得姐
//
//  Created by Anthony on 2017/4/8.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

// .h文件
#define SLSingletonH(name) + (instancetype)shared##name;

// .m文件
#if __has_feature(objc_arc)

// ARC
#define SLSingletonM(name) \
static id instance_; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance_ = [super allocWithZone:zone]; \
}); \
return instance_; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance_ = [[self alloc] init]; \
}); \
return instance_; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return instance_; \
}

#else

// MRCSingleton
#define SLSingletonM(name) \
static id instance_; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance_ = [super allocWithZone:zone]; \
}); \
return instance_; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance_ = [[self alloc] init]; \
}); \
return instance_; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return instance_; \
} \
\
- (oneway void)release { } \
- (id)retain { return self; } \
- (NSUInteger)retainCount { return 1;} \
- (id)autorelease { return self;}

#endif
