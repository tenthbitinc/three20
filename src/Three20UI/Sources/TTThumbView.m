//
// Copyright 2009-2011 Facebook
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "Three20UI/TTThumbView.h"

// Style
#import "Three20Style/TTGlobalStyle.h"
#import "Three20Style/TTDefaultStyleSheet.h"

// Network
#import "Three20Network/TTGlobalNetwork.h"
#import "Three20Network/TTURLCache.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTThumbView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame {
  	self = [super initWithFrame:frame];
		if (self) {

    self.backgroundColor = TTSTYLEVAR(thumbnailBackgroundColor);
    self.clipsToBounds = YES;

    [self setStylesWithSelector:@"thumbView:"];

    UIViewAutoresizing lblMask,stripMask;
    CGRect containerRect = CGRectMake(0, frame.size.height-16, frame.size.width, 16);
    videoIconStrip_ = [[UIView alloc] initWithFrame:containerRect];
    videoIconStrip_.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    videoIconStrip_.userInteractionEnabled = NO;
    stripMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    videoIconStrip_.autoresizingMask = stripMask;
    UIImage *cameraThumbnail = TTIMAGE(@"bundle://Three20.bundle/images/cameraThumbnailIcon.png");
    videoIconImage_ = [[UIImageView alloc] initWithImage:cameraThumbnail];
    videoIconImage_.center = CGPointMake(11, 8);
    videoIconLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width-7, 16)];
    lblMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth;
    videoIconLabel_.autoresizingMask = lblMask;
    videoIconLabel_.backgroundColor = [UIColor clearColor];
    videoIconLabel_.textAlignment = UITextAlignmentRight;
            videoIconLabel_.font = [UIFont boldSystemFontOfSize:11];
    videoIconLabel_.textColor = [UIColor whiteColor];
    [videoIconStrip_ addSubview:videoIconImage_];
    [videoIconStrip_ addSubview:videoIconLabel_];
    [self addSubview:videoIconStrip_];
  }

  return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void) dealloc
{
    [videoIconStrip_ release];
    [videoIconImage_ release];
    [videoIconLabel_ release];
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)thumbURL {
  return [self imageForState:UIControlStateNormal];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setThumbURL:(NSString*)URL {
  [self setImage:URL forState:UIControlStateNormal];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void) setVideo:(BOOL) isVideo withTime:(NSTimeInterval) videoTime {
    if (!isVideo) {
        videoIconStrip_.hidden = YES;
        return;
    }
    videoIconStrip_.hidden = NO;
    NSInteger videoTimeInt = videoTime;
    if (videoTime) {
        NSUInteger minutes = videoTimeInt/60;
        NSUInteger seconds = videoTimeInt%60;
        videoIconLabel_.text = [NSString stringWithFormat:@"%d:%02d",minutes,seconds];
    }else{
        videoIconLabel_.text = @"";
    }
}

@end
