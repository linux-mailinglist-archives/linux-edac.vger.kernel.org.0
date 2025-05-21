Return-Path: <linux-edac+bounces-3987-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B44AC00D5
	for <lists+linux-edac@lfdr.de>; Thu, 22 May 2025 01:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7731A1BA43A5
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 23:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288162367A3;
	Wed, 21 May 2025 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0a17WM3"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F151D63CD;
	Wed, 21 May 2025 23:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747871737; cv=none; b=GrSVSzKYh1IeCMh5sny2Ay2iBFUPOu1V3DPuZ9rD/j79OoebNbm1gyDVx1TR+bbAb68Ac781GkmLDo4avieJf3qmIH7rS6TYOunDfq8w572vxtgCUWp1hc3xxKU8QnIykBjzGWGevLkEkPWuvr2l5VwyJwA2Tkhuu7I2P7c44/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747871737; c=relaxed/simple;
	bh=pJrvsKXRNyYWqRuGICKAgkDS4VPEKfwvebNviFOseJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cztyKtYJfESG7fwTve9ys0c4NErHdIu6PWGQhJjtVJSdK2a7XhgAHhL/G4MjupaocL/oleZBHxSJHUtZXWCdzWzTp+RpxCgrDPjgGQcU54x/2G7W8s1aUW673SF/G76DbpGei6vsWgGD2rLzowdKWRatVS1qhTV1AR1VCdUpqyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0a17WM3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747871735; x=1779407735;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pJrvsKXRNyYWqRuGICKAgkDS4VPEKfwvebNviFOseJM=;
  b=O0a17WM3nmCQYGGJkoBgD2HHbopgWhxo4jOShkN1PgLbFWTOZXk5/pIc
   q50KHUVBO82wlba9VNo1xTtLzzeFV04YkggYm1kPduNc6lX7ZXigenXT4
   rM9fUJ4VJPoB4UbGKPfB6634MD0XrKysup1mD21rmgoBXQV3YSV2ifSlT
   yVYDD054KYVcJUDnb2U1zVyggrvgUJYnUTRxh5RpcEyohwq0WgepufJXA
   E4aSD5npuRYIVvk+uj0YIo8ITbIZvWDrCvphTUD7MpkV/36RvvZDf7Q3j
   mHDLAypJpfWHZM/YZVknUTDcFjAq6E8HZKXfCQ09GyCB9xOmqkXscLOE3
   A==;
X-CSE-ConnectionGUID: R24+F4yxSGKfT/JGRTcN3w==
X-CSE-MsgGUID: PVLSzqhYRL26yOPB/s9bSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49798110"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="49798110"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:55:34 -0700
X-CSE-ConnectionGUID: ml66DW2VTLmcB7ytKNvP9Q==
X-CSE-MsgGUID: qCkwn21kTOixB0CerhIkKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="145284455"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.109.106]) ([10.125.109.106])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:55:33 -0700
Message-ID: <c27f5629-e8f9-4b28-bc1d-1fae315d8010@intel.com>
Date: Wed, 21 May 2025 16:55:30 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/8] cxl/edac: Add CXL memory device patrol scrub
 control feature
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 linux-edac@vger.kernel.org, linux-doc@vger.kernel.org, bp@alien8.de,
 tony.luck@intel.com, lenb@kernel.org, Yazen.Ghannam@amd.com,
 mchehab@kernel.org, nifan.cxl@gmail.com, linuxarm@huawei.com,
 tanxiaofei@huawei.com, prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com
References: <20250521124749.817-1-shiju.jose@huawei.com>
 <20250521124749.817-4-shiju.jose@huawei.com>
 <20250521154026.0000172f@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250521154026.0000172f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/21/25 7:40 AM, Jonathan Cameron wrote:
> On Wed, 21 May 2025 13:47:41 +0100
> <shiju.jose@huawei.com> wrote:
> 
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL spec 3.2 section 8.2.10.9.11.1 describes the device patrol scrub
>> control feature. The device patrol scrub proactively locates and makes
>> corrections to errors in regular cycle.
>>
>> Allow specifying the number of hours within which the patrol scrub must be
>> completed, subject to minimum and maximum limits reported by the device.
>> Also allow disabling scrub allowing trade-off error rates against
>> performance.
>>
>> Add support for patrol scrub control on CXL memory devices.
>> Register with the EDAC device driver, which retrieves the scrub attribute
>> descriptors from EDAC scrub and exposes the sysfs scrub control attributes
>> to userspace. For example, scrub control for the CXL memory device
>> "cxl_mem0" is exposed in /sys/bus/edac/devices/cxl_mem0/scrubX/.
>>
>> Additionally, add support for region-based CXL memory patrol scrub control.
>> CXL memory regions may be interleaved across one or more CXL memory
>> devices. For example, region-based scrub control for "cxl_region1" is
>> exposed in /sys/bus/edac/devices/cxl_region1/scrubX/.
>>
>> [dj: Add cxl_test inclusion of edac.o]
>> [dj: Check return from cxl_feature_info() with IS_ERR]
> 
> Trivial question on these.  What do they reflect?  Some changes
> Dave made on a prior version? Or changes in response to feedback
> (in which case they should be below the ---)

Ah those are the notations I inserted when I pulled the the branch for merge testing and Shiju picked up. Normally those would go to Linus. But in this case, it can be dropped since there is another reversion for the series and the changes and folded in by Shiju.

DJ

> 
>>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> 
> A couple of formatting trivial things inline from the refactors
> in this version. Maybe Dave can tweak them whilst applying if
> nothing else comes up?
> 
> J
> 
>> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
>> new file mode 100644
>> index 000000000000..eae99ed7c018
>> --- /dev/null
>> +++ b/drivers/cxl/core/edac.c
>> @@ -0,0 +1,520 @@
> 
>> +static int cxl_scrub_get_attrbs(struct cxl_patrol_scrub_context *cxl_ps_ctx,
>> +				u8 *cap, u16 *cycle, u8 *flags, u8 *min_cycle)
>> +{
>> +	struct cxl_mailbox *cxl_mbox;
>> +	u8 min_scrub_cycle = U8_MAX;
>> +	struct cxl_region_params *p;
>> +	struct cxl_memdev *cxlmd;
>> +	struct cxl_region *cxlr;
>> +	int i, ret;
>> +
>> +	if (!cxl_ps_ctx->cxlr) {
>> +		cxl_mbox = &cxl_ps_ctx->cxlmd->cxlds->cxl_mbox;
>> +		return cxl_mem_scrub_get_attrbs(cxl_mbox, cap, cycle,
>> +						flags, min_cycle);
>> +	}
>> +
>> +	struct rw_semaphore *region_lock __free(rwsem_read_release) =
>> +	rwsem_read_intr_acquire(&cxl_region_rwsem);
> 
> Trivial but that should be indented one tab more.
> 
>> +	if (!region_lock)
>> +		return -EINTR;
>> +
>> +	cxlr = cxl_ps_ctx->cxlr;
>> +	p = &cxlr->params;
>> +
>> +	for (i = 0; i < p->nr_targets; i++) {
>> +		struct cxl_endpoint_decoder *cxled = p->targets[i];
>> +
>> +		cxlmd = cxled_to_memdev(cxled);
>> +		cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>> +		ret = cxl_mem_scrub_get_attrbs(cxl_mbox, cap, cycle,
>> +					       flags, min_cycle);
> 
> Maybe move flags to previous line.
> 
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (min_cycle)
>> +			min_scrub_cycle =
>> +				min(*min_cycle, min_scrub_cycle);
> 
> No need for the line wrap any more.
> 
> 
>> +	}
>> +
>> +	if (min_cycle)
>> +		*min_cycle = min_scrub_cycle;
>> +
>> +	return 0;
>> +}
> 
> 


