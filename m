Return-Path: <linux-edac+bounces-3855-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2183BAAEBC1
	for <lists+linux-edac@lfdr.de>; Wed,  7 May 2025 21:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC99464F70
	for <lists+linux-edac@lfdr.de>; Wed,  7 May 2025 19:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ADC28DF1F;
	Wed,  7 May 2025 19:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AcwW2SpW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C4121504D;
	Wed,  7 May 2025 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644959; cv=none; b=GQTq3aqv4MtqYxuzUmxNkhHH8FArX0SVVsyWNygwp/JfpyXLQm0ufmhdzcZF7EOrWkgZT+WIXzqG7jwQsA7K7R9CqpR2q4GZLKUCn1Nd7UGByDSWyO9XQDwUIFzNN8tTatSriKgNgXxWjMlgSB31lmYMhoxgUXS/HOejw2cfYCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644959; c=relaxed/simple;
	bh=t5MQmQHSTWO3B0yqLva7uytfLjumGSshvEaDfC7ArPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vvv7k2pKw4y5fBIOxkqkUg7OiQk0eL/7N6gcY286VT/bmHcukW8p0EnpjwklpjtbsyUn2qPL9Fd5udutzuafDmKxKL6sZegN7lGus/8XfXcciJf1ev8qw0VbLssRLFpbhvReAtwg4Z5N+8xpP64sW4f+KGhBF4uyiFX+Jqdv51U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AcwW2SpW; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746644957; x=1778180957;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t5MQmQHSTWO3B0yqLva7uytfLjumGSshvEaDfC7ArPM=;
  b=AcwW2SpWRYY+BHB/YXKGuViwBrjM2tUGRh2SwBdlXnTV3NdaR2AyhACf
   CEBAU5xFeoViGfVufmxdKBklbeYqt9tW5ifNH99+VPHWJ44ZV9OIcrkWI
   UlOAVAwa3LAF6XZMyS/5sAyI/mJ4uYz0OHM/HYqacIecv2zmFjY3AmUsE
   P2BiGFaeXw9K0or+iYKoijsZ0OGkxjKitBqebNdDL5KbybTbHFLfpJOzx
   yHfwoGvLUwSjmLB+lJbMmcqTKbf6VNnCLg7vriSEQWaKokn7WfynB1kTD
   fSeStYHWjROA8IBIItAbltoWcLmOkPh6E87icEo0BgF9cRWy8r4JLghqv
   Q==;
X-CSE-ConnectionGUID: LU0Oa9yWQ1eJd1SgarpLng==
X-CSE-MsgGUID: /Rcw/m50RTqb3gTMrnOSYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48302580"
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="48302580"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 12:09:16 -0700
X-CSE-ConnectionGUID: rghuTaSDRy66xiiN3PuyJw==
X-CSE-MsgGUID: 7zywI6P8S92SmyFh4ltKuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="135757344"
Received: from mgoodin-mobl2.amr.corp.intel.com (HELO [10.125.108.17]) ([10.125.108.17])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 12:09:14 -0700
Message-ID: <cbcf0502-9a80-4f48-a533-bc1b0bbb12fa@intel.com>
Date: Wed, 7 May 2025 12:09:12 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] EDAC: Update documentation for the CXL memory
 patrol scrub control feature
To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com
Cc: linux-edac@vger.kernel.org, linux-doc@vger.kernel.org, bp@alien8.de,
 tony.luck@intel.com, lenb@kernel.org, Yazen.Ghannam@amd.com,
 mchehab@kernel.org, nifan.cxl@gmail.com, linuxarm@huawei.com,
 tanxiaofei@huawei.com, prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com
References: <20250502084517.680-1-shiju.jose@huawei.com>
 <20250502084517.680-2-shiju.jose@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250502084517.680-2-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/2/25 1:45 AM, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Update the Documentation/edac/scrub.rst to include use cases and
> policies for CXL memory device-based, CXL region-based patrol scrub
> control and CXL Error Check Scrub (ECS).
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/edac/scrub.rst | 76 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst
> index daab929cdba1..89a33ef3fde3 100644
> --- a/Documentation/edac/scrub.rst
> +++ b/Documentation/edac/scrub.rst
> @@ -264,3 +264,79 @@ Sysfs files are documented in
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
> +The following are the use cases identified why we might increase the scrub rate.
> +
> +- Scrubbing is needed at device granularity because a device is showing
> +  unexpectedly high errors.
> +
> +- Scrubbing may apply to memory that isn't online at all yet. Likely this
> +  is a system wide default setting on boot.
> +
> +- Scrubbing at a higher rate because the monitor software has determined that
> +  more reliability is necessary for a particular data set. This is called
> +  Differentiated Reliability.
> +
> +1.1. Device based scrubbing
> +
> +CXL memory is exposed to memory management subsystem and ultimately userspace
> +via CXL devices. Device-based scrubbing is used for the first use case
> +described in "Section 1 CXL Memory Patrol Scrub".
> +
> +When combining control via the device interfaces and region interfaces,
> +"see Section 1.2 Region based scrubbing".
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
> +Region-based scrubbing is used for the third use case described in
> +"Section 1 CXL Memory Patrol Scrub".
> +
> +Userspace must follow below set of rules on how to set the scrub rates for any
> +mixture of requirements.
> +
> +1. Taking each region in turn from lowest desired scrub rate to highest and set
> +   their scrub rates. Later regions may override the scrub rate on individual
> +   devices (and hence potentially whole regions).
> +
> +2. Take each device for which enhanced scrubbing is required (higher rate) and
> +   set those scrub rates. This will override the scrub rates of individual devices,
> +   setting them to the maximum rate required for any of the regions they help back,
> +   unless a specific rate is already defined.
> +
> +Sysfs files for scrubbing are documented in
> +`Documentation/ABI/testing/sysfs-edac-scrub`
> +
> +2. CXL memory Error Check Scrub (ECS)
> +
> +The Error Check Scrub (ECS) feature enables a memory device to perform error
> +checking and correction (ECC) and count single-bit errors. The associated
> +memory controller sets the ECS mode with a trigger sent to the memory
> +device. CXL ECS control, allows the host, thus the userspace, to change the
> +attributes for error count mode, threshold number of errors per segment
> +(indicating how many segments have at least that number of errors) for
> +reporting errors, and reset the ECS counter. Thus, the responsibility for
> +initiating Error Check Scrub on a memory device may lie with the memory
> +controller or platform when unexpectedly high error rates are detected.
> +
> +Sysfs files for scrubbing are documented in
> +`Documentation/ABI/testing/sysfs-edac-ecs`


