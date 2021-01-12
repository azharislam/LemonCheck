//
//  Copyright (c) 2019 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

@import XCTest;

@import FirebaseStorageUI;
@import OCMock;

#import "UIImageView+FirebaseStorage.h"

@interface FUIImageViewCategoryTests : XCTestCase
@property (nonatomic, readwrite) FIRStorageReference *ref;
@property (nonatomic, readwrite) UIImageView *imageView;
@property (nonatomic, readwrite) SDImageCache *cache;
@end

@implementation FUIImageViewCategoryTests

- (void)setUp {
  [super setUp];
  self.ref = OCMClassMock([FIRStorageReference class]);
  OCMStub([self.ref bucket]).andReturn(@"bucket");
  OCMStub([self.ref fullPath]).andReturn(@"path/to/image.png");
  self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
}

- (void)tearDown {
  [super tearDown];
}

- (void)testItCreatesADownloadTaskIfCacheIsEmpty {
  OCMStub([self.ref dataWithMaxSize:512 completion:[OCMArg any]])
  .andReturn(OCMClassMock([FIRStorageDownloadTask class]));
  [self.imageView sd_setImageWithStorageReference:self.ref
                                     maxImageSize:512
                                 placeholderImage:nil
                                       completion:^(UIImage *image,
                                                    NSError *error,
                                                    SDImageCacheType cacheType,
                                                    FIRStorageReference * storageRef) {
                                         XCTAssert(self.imageView.image == image, @"expected download to populate image");
                                         XCTAssertNil(error, @"expected successful download to not produce an error");
                                         XCTAssertNotNil(self.imageView.sd_currentDownloadTask, @"expected image view with empty cache to attempt a download");
                                       }];
}

- (void)testItDoesNotCreateADownloadIfImageIsCached {
  OCMStub([self.ref dataWithMaxSize:4096 completion:[OCMArg any]])
  .andReturn(OCMClassMock([FIRStorageDownloadTask class]));
  UIImage *image = [[UIImage alloc] init];
  self.cache = [SDImageCache sharedImageCache];
  NSURL *url = [NSURL sd_URLWithStorageReference:self.ref];
  [self.cache storeImage:image forKey:url.absoluteString completion:nil];
  [self.imageView sd_setImageWithStorageReference:self.ref
                                     maxImageSize:4096
                                 placeholderImage:nil
                                       completion:nil];
  XCTAssertEqual(self.imageView.image, image, @"expected image view to use cached image");
  [self.cache clearDiskOnCompletion:nil];
  [self.cache clearMemory];
}

- (void)testItRaisesAnErrorIfDownloadingFails {
  [self.imageView sd_setImageWithStorageReference:self.ref
                                     maxImageSize:512
                                 placeholderImage:nil
                                       completion:^(UIImage *image,
                                                    NSError *error,
                                                    SDImageCacheType cacheType,
                                                    FIRStorageReference *storageRef) {
                                         XCTAssertNil(image, @"expected failed download to not return an image");
                                         XCTAssertNil(self.imageView.image, @"expected failed download to not populate image");
                                         XCTAssertNotNil(error, @"expected failed download to produce an error");
                                       }];
}

- (void)testItSetsAPlaceholder {
  UIImage *placeholder = [[UIImage alloc] init];
  [self.imageView sd_setImageWithStorageReference:self.ref
                                     maxImageSize:4096
                                 placeholderImage:placeholder
                                       completion:nil];
  XCTAssertEqual(self.imageView.image, placeholder, @"expected image view to use placeholder on failed download");
}

- (void)testItCancelsTheCurrentDownloadWhenSettingAnImage {
  OCMStub([self.ref dataWithMaxSize:512 completion:[OCMArg any]])
  .andReturn(OCMClassMock(NSClassFromString(@"FIRStorageDownloadTask"))); // Must using `NSClassFromString` instead of `FIRStorageDownloadTask.class` for OCMock, or the isKindOfClass: failed.
  [self.imageView sd_setImageWithStorageReference:self.ref
                                     maxImageSize:512
                                 placeholderImage:nil
                                          options:SDWebImageFromLoaderOnly // Disable cache
                                       completion:nil];
  FIRStorageDownloadTask *download = self.imageView.sd_currentDownloadTask;
  self.ref = OCMClassMock([FIRStorageReference class]);
  [self.imageView sd_setImageWithStorageReference:self.ref
                                     maxImageSize:512
                                 placeholderImage:nil
                                       completion:nil];
  OCMVerify([download cancel]);
}

- (void)testLoaderWithNilStorageReference {
  [FUIStorageImageLoader.sharedLoader requestImageWithURL:nil
                                                  options:0
                                                  context:nil
                                                 progress:nil
                                                completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                                                  XCTAssertNil(image);
                                                  XCTAssertNotNil(error);
                                                }];
  NSURL *httpURL = [NSURL URLWithString:@"www.google.com"];
  [FUIStorageImageLoader.sharedLoader requestImageWithURL:httpURL
                                                  options:0
                                                  context:nil
                                                 progress:nil
                                                completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                                                  XCTAssertNil(image);
                                                  XCTAssertNotNil(error);
                                                }];
}

@end
