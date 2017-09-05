/*!
 *  @header NSFileManager+SGS.h
 *
 *  @abstract NSFileManager 扩展
 *
 *  @author Created by Lee on 16/4/24.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @brief 使用 [NSFileManager defaultManager] 提供快捷操作文件的扩展方法
 */
@interface NSFileManager (SGS)

/*!
 *  @brief 创建文件夹目录，如果目录路径中间的某个目录不存在将创建
 *
 *  @param path       文件夹路径
 *  @param attributes 文件夹属性
 *
 *  @return 'YES'创建成功，'NO'创建失败
 */
+ (BOOL)createDirectoryAtPath:(NSString *)path attributes:(nullable NSDictionary<NSString *, id> *)attributes;

/*!
 *  @brief 创建文件夹目录
 *
 *  @param path                文件夹路径
 *  @param createIntermediates 如果目录路径中间的某个目录不存在是否创建
 *  @param attributes          文件夹属性
 *  @param error               错误信息
 *
 *  @return 'YES'创建成功，'NO'创建失败
 */
+ (BOOL)createDirectoryAtPath:(NSString *)path withIntermediateDirectories:(BOOL)createIntermediates attributes:(nullable NSDictionary<NSString *, id> *)attributes error:(NSError **)error;

/*!
 *  @brief 拷贝文件或文件夹到指定目录
 *
 *  @param srcPath 文件原路径
 *  @param dstPath 目标路径
 *  @param error   错误信息
 *
 *  @return 'YES'拷贝成功，'NO'拷贝失败
 */
+ (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error;

/*!
 *  @brief 将文件或文件夹移动到指定目录
 *
 *  @param srcPath 文件原路径
 *  @param dstPath 目标路径
 *  @param error   错误信息
 *
 *  @return 'YES'移动成功，'NO'移动失败
 */
+ (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error;

/*!
 *  @brief 创建软链接
 *
 *  @param srcPath 文件原路径
 *  @param dstPath 目标路径
 *  @param error   错误信息
 *
 *  @return 'YES'链接成功，'NO'链接失败
 */
+ (BOOL)linkItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error;

/*!
 *  @brief 删除文件或文件夹
 *
 *  @param path  文件路径
 *  @param error 错误信息
 *
 *  @return 'YES'删除成功，'NO'删除失败
 */
+ (BOOL)removeItemAtPath:(NSString *)path error:(NSError **)error;

/*!
 *  @brief 判断文件或文件夹是否存在
 *
 *  @param path 文件路径
 *
 *  @return 'YES'存在，'NO'不存在
 */
+ (BOOL)fileExistsAtPath:(NSString *)path;

/*!
 *  @brief 判断文件或文件夹是否存在，并且可以区分类型是文件还是文件夹
 *
 *  @param path        文件路径
 *  @param isDirectory 区分类型标识
 *
 *  @return 'YES'存在，'NO'不存在
 */
+ (BOOL)fileExistsAtPath:(NSString *)path isDirectory:(nullable BOOL *)isDirectory;

/*!
 *  @brief 判断文件或文件夹是否可读取
 *
 *  @param path 文件路径
 *
 *  @return 'YES'可读取，'NO'禁止读取
 */
+ (BOOL)isReadableFileAtPath:(NSString *)path;

/*!
 *  @brief 判断文件或文件夹是否可写入
 *
 *  @param path 文件路径
 *
 *  @return 'YES'可写入，'NO'禁止写入
 */
+ (BOOL)isWritableFileAtPath:(NSString *)path;

/*!
 *  @brief 判断文件是否可执行
 *
 *  @param path 文件路径
 *
 *  @return 'YES'可执行，'NO'不可执行
 */
+ (BOOL)isExecutableFileAtPath:(NSString *)path;

/*!
 *  @brief 判断文件或文件夹是否可删除
 *
 *  @param path 文件路径
 *
 *  @return 'YES'可删除，'NO'禁止删除
 */
+ (BOOL)isDeletableFileAtPath:(NSString *)path;

/*!
 *  @brief 浅度遍历指定的目录
 *
 *  @param path  需要遍历的目录
 *  @param error 错误信息
 *
 *  @return 子目录及文件路径 or nil
 */
+ (nullable NSArray<NSString *> *)contentsOfDirectoryAtPath:(NSString *)path error:(NSError **)error;

/*!
 *  @brief 深度遍历指定的目录
 *
 *  @param path  需要遍历的目录
 *  @param error 错误信息
 *
 *  @return 子目录及所有文件路径 or nil
 */
+ (nullable NSArray<NSString *> *)subpathsOfDirectoryAtPath:(NSString *)path error:(NSError **)error;

/*!
 *  @brief 为文件或文件夹设置属性
 *
 *  @param attributes 属性
 *  @param path       文件或文件夹路径
 *  @param error      错误信息
 *
 *  @return 'YES'设置成功，'NO'设置失败
 */
+ (BOOL)setAttributes:(NSDictionary<NSString *, id> *)attributes ofItemAtPath:(NSString *)path error:(NSError **)error;

/*!
 *  @brief 获取文件或文件夹的属性
 *
 *  @param path  文件或文件夹路径
 *  @param error 错误信息
 *
 *  @return 属性 or nil
 */
+ (nullable NSDictionary<NSString *, id> *)attributesOfItemAtPath:(NSString *)path error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END