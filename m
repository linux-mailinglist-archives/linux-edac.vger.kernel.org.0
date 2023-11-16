Return-Path: <linux-edac+bounces-36-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B9A7EDCE7
	for <lists+linux-edac@lfdr.de>; Thu, 16 Nov 2023 09:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06D628100E
	for <lists+linux-edac@lfdr.de>; Thu, 16 Nov 2023 08:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF76111A5;
	Thu, 16 Nov 2023 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7CvO+dU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F671A4;
	Thu, 16 Nov 2023 00:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700123352; x=1731659352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=1CVrMRbvtQ3pJscWj0o6EOAB5D9FaFRwLJwW7gUZatg=;
  b=b7CvO+dUQ36ZI/CzrwqxT29/PAnVdJgCSiDTTTIJgs7RCyKABjpNnlyc
   PTGBWe3hYNujUxjM+3yVUD2chlCGfw9XXF5NeasdlZIVC4lhZaRK99Hpk
   UJ/NISAwzqOtCZwEVFhEnq700hdNPo4aSGjaAvB+odw3HsxxhqwRnOFxn
   HHOsZQ0Q8A4w09uMZh4aIgOUVEvyZVu+WY0um7UinphQINwcUO4SdQsRO
   0T6fhHknyOuLA9Grenxbxswlkrxpy4WxfxL5bGhO8z3J139I5e1eIm9Ag
   NjwAcsyvlkF+HKwDonbOVecVziiYQheuO9G7ricDQRlFbU1j/74RQ/i7n
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="376087763"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="376087763"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 00:29:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="855909743"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="855909743"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 00:29:08 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: andriy.shevchenko@linux.intel.com
Cc: bp@alien8.de,
	james.morse@arm.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	rric@kernel.org,
	tony.luck@intel.com,
	qiuxu.zhuo@intel.com
Subject: Re: [PATCH v1 2/3] EDAC, pnd2: Apply bit macros and helpers where it makes sense
Date: Thu, 16 Nov 2023 16:28:57 +0800
Message-Id: <20231116082857.89714-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231115154940.664664-2-andriy.shevchenko@linux.intel.com>
References: <20231115154940.664664-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ...
> 
> Apply bit macros (BIT()/BIT_ULL()/GENMASK()/etc) and helpers
> (is_power_of_2()/for_each_set_bit()/etc) where it makes sense.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/edac/pnd2_edac.c | 39 ++++++++++++++++++---------------------
>  1 file changed, 18 insertions(+), 21 deletions(-)
> 
> ...
> @@ -328,7 +328,7 @@ static void mk_region_mask(char *name, struct region *rp, u64 base, u64 mask)
>  		pr_info(FW_BUG "MOT mask cannot be zero\n");
>  		return;
>  	}
> -	if (mask != GENMASK_ULL(PND_MAX_PHYS_BIT, __ffs(mask))) {
> +	if (is_power_of_2(mask)) {

The original code verifies whether the 'mask' contains consecutive 1s between the
most significant bit 'PND_MAX_PHYS_BIT' and the least significant bit '__ffs(mask)'.
It isn't the check whether the 'mask' is power of 2.

>  		pr_info(FW_BUG "MOT mask not power of two\n");

This original pr_info "MOT mask not power of two" is incorrect.
May need to update it like:

  		pr_info(FW_BUG "MOT mask is invalid\n");

> ...
>  /* addrdec values */
>  #define AMAP_1KB	0
> @@ -1061,12 +1061,13 @@ static int check_channel(int ch)
>  
>  static int apl_check_ecc_active(void)
>  {
> -	int	i, ret = 0;
> +	unsigned int i;
> +	int ret;

Need to initialize the 'ret' to 0.

The LKP reported this warnning as well:
https://lore.kernel.org/all/202311160352.PfYDQfkU-lkp@intel.com/

>  
>  	/* Check dramtype and ECC mode for each present DIMM */
> -	for (i = 0; i < APL_NUM_CHANNELS; i++)
> -		if (chan_mask & BIT(i))
> -			ret += check_channel(i);
> +	for_each_set_bit(i, &chan_mask, APL_NUM_CHANNELS)
> +		ret += check_channel(i);
> +
>  	return ret ? -EINVAL : 0;
>  }
>  ...

Thanks!
-Qiuxu

