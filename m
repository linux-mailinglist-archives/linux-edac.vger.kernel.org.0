Return-Path: <linux-edac+bounces-3945-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CA8ABC8F7
	for <lists+linux-edac@lfdr.de>; Mon, 19 May 2025 23:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CADE21B63126
	for <lists+linux-edac@lfdr.de>; Mon, 19 May 2025 21:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C068119B3EC;
	Mon, 19 May 2025 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWwgfnLA"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB21044C94;
	Mon, 19 May 2025 21:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689356; cv=none; b=BgpSFtHH0tis7LqyMz3XGS6sILS0dVdy3e4ddhddTThU9RtBUvqYWMrKpYj//KmDBpI11/FK+gNC2YFzPJZQLhJSwVOx3HGmipZ/UPzUQ92rFhkyVDgl/0j1sy/iGzqZKaTYNja8xfRWG/QrmKpHrhO0vAMbgK23Hn4L9FpkIf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689356; c=relaxed/simple;
	bh=q9qwNaODRuqjRaJTbhk5zwI6yO3x5hPEYFNx1zI1FUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AekCZrDVvQUKkZ95YYooJ5/RvxoyX/V47ErTI7vgtfkDxqG8CXc1yr9lUeD+ZZuw+oqAPmZMMb8a7boyJwMt4QzC25o6RX8yA/cRmM4cMj93r5ki02+D32Lf+viRraVJqGKYImbOe5Oa1bcvOyXzM0VHDyhxDLLNyvHPGDuC6t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZWwgfnLA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747689355; x=1779225355;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q9qwNaODRuqjRaJTbhk5zwI6yO3x5hPEYFNx1zI1FUM=;
  b=ZWwgfnLALp2t+tikGlr9rT8AUnBNpk8VqbVwDLQZ+OcdNobdVJgcUSAJ
   ATvfv7MzlFCOKxeTuZW9OHiA4VNpJG+7cPeD3hi/G4tZ7YPJh+mS5g/Sb
   aqVQFzhUI7ntINNBR8LJixGO0GOK8wIfHivGFzktMIbJyXCJlWylszgCx
   N+Q1PUfbdN7qtoB87t5OkoqkuhGgPAY14naYdMtXvvBsvz/BkcPLnJf1C
   JoIY4HGmwVWC30n7xX7R5ugZErf6heXVWuljmUTQy8H9hrShD4YhZ1O+L
   MXDKn7lrwQyuhw/MM5nfCDhkGnnIW/p0BSyojd9MyShiGAg+SptLQI426
   A==;
X-CSE-ConnectionGUID: z3t77QUUTPyal+LIvsE6jg==
X-CSE-MsgGUID: tUborw4nTzOy/q/H3riDKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="60240720"
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="60240720"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 14:15:36 -0700
X-CSE-ConnectionGUID: mqNqNsnTQRCMjTzIhRhGfw==
X-CSE-MsgGUID: 1H2HJeZGS8S/sVfk0sDQ/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="143485110"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO [10.125.109.80]) ([10.125.109.80])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 14:15:34 -0700
Message-ID: <43de25e8-cbce-43f5-931d-3b9edc3f45eb@intel.com>
Date: Mon, 19 May 2025 14:15:32 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] cxl/edac: Add CXL memory device memory sparing
 control feature
To: Alison Schofield <alison.schofield@intel.com>, shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 jonathan.cameron@huawei.com, dave@stgolabs.net, vishal.l.verma@intel.com,
 ira.weiny@intel.com, linux-edac@vger.kernel.org, linux-doc@vger.kernel.org,
 bp@alien8.de, tony.luck@intel.com, lenb@kernel.org, Yazen.Ghannam@amd.com,
 mchehab@kernel.org, nifan.cxl@gmail.com, linuxarm@huawei.com,
 tanxiaofei@huawei.com, prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com
References: <20250515115927.772-1-shiju.jose@huawei.com>
 <20250515115927.772-8-shiju.jose@huawei.com>
 <aCucI3TPynSycGug@aschofie-mobl2.lan>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aCucI3TPynSycGug@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/19/25 2:01 PM, Alison Schofield wrote:
> On Thu, May 15, 2025 at 12:59:23PM +0100, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
> 
> snip
> 
>> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
>> index 489c9996bfbc..395d56457931 100644
>> --- a/drivers/cxl/core/edac.c
>> +++ b/drivers/cxl/core/edac.c
>> @@ -21,7 +21,17 @@
>>  #include "core.h"
>>  #include "trace.h"
>>  
>> -#define CXL_NR_EDAC_DEV_FEATURES 2
>> +#define CXL_NR_EDAC_DEV_FEATURES 6
>> +
>> +static bool cxl_is_memdev_memory_online(const struct cxl_memdev *cxlmd)
>> +{
>> +	struct cxl_port *port = cxlmd->endpoint;
>> +
>> +	if (port && cxl_num_decoders_committed(port))
>> +		return true;
>> +
>> +	return false;
>> +}
>>  
> 
> Looks like above fcn needs to be inside the below #ifdef.
> Smatch is warning this when EDAC_SCRUB is off
> 
> drivers/cxl/core/edac.c:27:13: warning: ‘cxl_is_memdev_memory_online’ defined but not used [-Wunused-function]
>    27 | static bool cxl_is_memdev_memory_online(const struct cxl_memdev *cxlmd)
> 
> 
>>  #ifdef CONFIG_CXL_EDAC_SCRUB

I think the function can be moved to above cxl_mem_perform_sparing() as that is the only function that calls it. I'll do that when I apply if there's nothing else major need to be changed.

DJ


> 
> snip to end.
> 


