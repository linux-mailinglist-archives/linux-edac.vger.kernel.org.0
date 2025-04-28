Return-Path: <linux-edac+bounces-3778-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D7EA9F7A5
	for <lists+linux-edac@lfdr.de>; Mon, 28 Apr 2025 19:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19CB3AB882
	for <lists+linux-edac@lfdr.de>; Mon, 28 Apr 2025 17:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E74418DB0A;
	Mon, 28 Apr 2025 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUpOSGmF"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D618615A;
	Mon, 28 Apr 2025 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745862324; cv=none; b=rdookYJBRhxpCErVkyO5WQClU2A7di/eXwnda+d8zuYwpOw7rjXK7pnK7JJ16cvP7bJYICHPE+dutWgEagHZUD98sr14NDmXInSueM+3Qy1fDI7aPEn1cD3kLRexyOSOUi3BW5EIi3TazvyvtV9R/XlpfezbRT6rzoai5E3oQyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745862324; c=relaxed/simple;
	bh=pEkLPCxrK6MRihvOD42HM1PHWTgQhgfindR0VeQwYSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1z97o0GeHFT7OfnXx0avYOnj6IWtnc+KMlW3tuyWnQ/rcvNE42ng5YzTXU0X1WPVctPhfrWJvvNMv4/iGkvDXMJN+e3cIJk68BxIQ5MdFokaTJg9971e0vaalmK5plKy/8nrNUTGo7IWJjR9wpT5zhQBw+O+WRSYkT86D0QEt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUpOSGmF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745862323; x=1777398323;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pEkLPCxrK6MRihvOD42HM1PHWTgQhgfindR0VeQwYSE=;
  b=lUpOSGmFK+TjWHHaIOjfkzPpqLetNquFrJ885R3/3jt8aafr+xkitX3e
   HL1UGF2yPJWVzeTmTfWQNDCrXsbKrUrJJBHGiCgsg1SPM+uJswOSy6zvZ
   4LHZhjY3e8Fpv/eNfFhDdjwDUjiCo+Im0QilLyt+ObD1jDdYUyOBlIz4l
   TYx/NwhIrKwjix88bzSkKR5/yJWSqQGkTx4t6yjgOPg/+6zbZAc97xj/u
   DRcehH6F8jJtsox0G72O2DoSAGVAG9gSsMuqDhPxVWmPwaxWGPOYJx8QO
   WBYVyEHBo2LSnyf5VrvZg3SuccgsHCy3Q4/s1b6W63ZWgzODBUPcs+HPF
   w==;
X-CSE-ConnectionGUID: i5MIJY+SSveniFY2r0LvOQ==
X-CSE-MsgGUID: +wSt64SiTGCNKdRwf7tflg==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="69965950"
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; 
   d="scan'208";a="69965950"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 10:45:22 -0700
X-CSE-ConnectionGUID: 4vKxyPyFQDmXQWazhOacSQ==
X-CSE-MsgGUID: HUp3WDwMSz+0y0oI+SX6YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; 
   d="scan'208";a="138582991"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.95]) ([10.125.109.95])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 10:45:20 -0700
Message-ID: <2df68c68-f1a8-4327-abc9-d265326c133d@intel.com>
Date: Mon, 28 Apr 2025 10:45:08 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] EDAC: Update documentation for the CXL memory
 patrol scrub control feature
To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com, jonathan.cameron@huawei.com, dave@stgolabs.net,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com
Cc: linux-edac@vger.kernel.org, linux-doc@vger.kernel.org, bp@alien8.de,
 tony.luck@intel.com, lenb@kernel.org, leo.duran@amd.com,
 Yazen.Ghannam@amd.com, mchehab@kernel.org, nifan.cxl@gmail.com,
 linuxarm@huawei.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
 roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
 wanghuiqiang@huawei.com
References: <20250407174920.625-1-shiju.jose@huawei.com>
 <20250407174920.625-2-shiju.jose@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250407174920.625-2-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/7/25 10:49 AM, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Update the Documentation/edac/scrub.rst to include usecases and
> policies for CXL memory device-based, CXL region-based patrol scrub
> control and CXL Error Check Scrub (ECS).
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  Documentation/edac/scrub.rst | 75 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst
> index daab929cdba1..6132853a02fe 100644
> --- a/Documentation/edac/scrub.rst
> +++ b/Documentation/edac/scrub.rst
> @@ -264,3 +264,78 @@ Sysfs files are documented in
>  `Documentation/ABI/testing/sysfs-edac-scrub`
>  
>  `Documentation/ABI/testing/sysfs-edac-ecs`
> +
> +Examples
> +--------
> +
> +The usage takes the form shown in these examples:
> +
> +1. CXL memory Patrol Scrub
> +
> +The following are the usecases identified why we might increase the scrub rate.
> +
> +- Scrubbing is needed at device granularity because a device is showing
> +  unexpectedly high errors, the scrub control needs to be at device
> +  granularity

Not sure what the second part of the sentence has to do with defining the use case.
When the per device control is detailed in 1.1, you can refer to the first use case.

> +
> +- Scrubbing may apply to memory that isn't online at all yet.Likely this
space after period

> +  is setting system wide defaults on boot.

is a system wide default setting on boot.

> +
> +- Scrubbing at higher rate because software has decided that we want
> +  more reliability for particular data, calling this Differentiated
> +  Reliability.  That data sits in a region which may cover part of multiple
> +  devices. The region interfaces are about supporting this use case.

Please consider:
Scrubbing at a higher rate because the monitor software has determined that
more reliability is necessary for a particular data set. This is called
Differentiated Reliability.

The last sentence is not needed. When describing region scrubbing in 1.2, the third use
case can be referred to.

> +
> +1.1. Device based scrubbing
> +
> +CXL memory is exposed to memory management subsystem and ultimately userspace
> +via CXL devices.
> +
> +When combining control via the device interfaces and region interfaces see
> +1.2 Region bases scrubbing.

"see section 1.2 ..."

> +
> +Sysfs files for scrubbing are documented in
> +`Documentation/ABI/testing/sysfs-edac-scrub`
> +
> +1.2. Region based scrubbing
> +
> +CXL memory is exposed to memory management subsystem and ultimately userspace
> +via CXL regions. CXL Regions represent mapped memory capacity in system
> +physical address space. These can incorporate one or more parts of multiple CXL
> +memory devices with traffic interleaved across them. The user may want to control
> +the scrub rate via this more abstract region instead of having to figure out the
> +constituent devices and program them separately. The scrub rate for each device
> +covers the whole device. Thus if multiple regions use parts of that device then
> +requests for scrubbing of other regions may result in a higher scrub rate than
> +requested for this specific region.
> +
> +Userspace must follow below set of rules on how to set the scrub rates for any
> +mixture of requirements.
> +
> +1. Taking each region in turn from lowest desired scrub rate to highest and set
> +   their scrub rates. Later regions may override the scrub rate on individual
> +   devices (and hence potentially whole regions).
> +
> +2. Take each device for which enhanced scrubbing is required (higher rate) and
> +   set those scrub rates. This will override the scrub rates of individual devices

> +   leaving any that are not specifically set to scrub at the maximum rate required
> +   for any of the regions they are involved in backing.

I'm having trouble understanding what the second part of this sentence is attempting to convey.

> +
> +Sysfs files for scrubbing are documented in
> +`Documentation/ABI/testing/sysfs-edac-scrub`
> +
> +2. CXL memory Error Check Scrub (ECS)
> +
> +The Error Check Scrub (ECS) feature enables a memory device to perform error
> +checking and correction (ECC) and count single-bit errors. The associated
> +memory controller triggers the ECS mode with a trigger sent to the memory
> +device. However, CXL ECS control allows the user to change the attributes
> +for error count mode and threshold for reporting errors and reset the ECS

CXL ECX control allows the user to change the attributes for error count mode,
the threshold for reporting errors, and reset the ECS counter.

I think that's where the commas should go to make the sentence clearer.

> +counter only. Thus, the scope of start Error Check Scrub on a memory device
> +lies within a memory controller or platform when it is detecting unexpectedly
> +high errors. Userspace allows to control the error count mode, threshold
> +number of errors for a segment count indicating a number of segments
> +having at least a threshold number of errors and reset the ECS counter.

Need a comman before 'and'. Although the middle part is excessively long and hard to digest.
Please consider rephrase.

> +
> +Sysfs files for scrubbing are documented in
> +`Documentation/ABI/testing/sysfs-edac-ecs`


