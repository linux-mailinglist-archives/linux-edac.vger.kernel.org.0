Return-Path: <linux-edac+bounces-3922-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C877AB8D90
	for <lists+linux-edac@lfdr.de>; Thu, 15 May 2025 19:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766129E15EB
	for <lists+linux-edac@lfdr.de>; Thu, 15 May 2025 17:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63BF25A626;
	Thu, 15 May 2025 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aLJ/1FvL"
X-Original-To: linux-edac@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCB0AD51;
	Thu, 15 May 2025 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329508; cv=none; b=Qkv4h7NYsz56wp+BhmQm8L61B/vqxHh53ZQwdBERr9eHRumpYqlP+Ue0Nd/KPrTp7k/9K0y6yDX8WSJY6wd64ASjkrzC6zs3ANM9U8beTRiZExCFVI+X7+xlAAaJAj7Q0yIOAtCbEFoMykDQfZzVTmJ71OkW+cHMZ8XFYXjiCMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329508; c=relaxed/simple;
	bh=wsGF4OsDMyaa+R62thlurPMRdzyGrkqKmM3+seX1/NU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJ7rvje/SuO+N5vmidHW5XZ5irIAr+E6vZpvyEQhqzT2qAaOFKwnLBqcucvvWqB0ask8tW6TfOOAKp+VQAGVfM2pOSZCfgY80p8ZbrRS5KXAPMbCt0wI1Y7SI7Ls+akzT8pTbgpTkDocM+fl5n8y/u/nmMa/qlmEaJ5XAnK3lqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aLJ/1FvL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=YvSXorUyf0f1h3hEkLq7sK0DPOGsoMputyGNv8Rgm3U=; b=aLJ/1FvLVdegqi55dnpCCJ+GEd
	w291W6/YF3tv6qWxZRI7cDvxxe9o3Q7JXjNVgIgOYdp9bNCWgoziny1r9CodRmyD0ned+SIVN2/zu
	y7z3SJOUpyY8Ravr9NkiZ2thuWHkkMMCCXxiPHgAzn/IiJT/xGjiVGzrJv/AB5EQwrpKvst2SLXgQ
	c+3vEraGMZuXX9d3r2hVZkP8tcJXQqNGJTxBBXabU8NF8YQCCML1NjaG3uCjtPT1P4ao+8Yz2NViJ
	VRi0vFFZ6u9zX7vWwH43CJNVwG3E8kbNHLTn1QpBsEJ1xhACFXF79bBitPIX2yfcM//rcW+RFK4om
	3OCXgSuw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uFcDp-0000000HVek-3XEg;
	Thu, 15 May 2025 17:18:18 +0000
Message-ID: <be15a320-66fa-48f4-8299-7628a9bfdb35@infradead.org>
Date: Thu, 15 May 2025 10:18:11 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] EDAC: Update documentation for the CXL memory
 patrol scrub control feature
To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 dave@stgolabs.net, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com
Cc: linux-edac@vger.kernel.org, linux-doc@vger.kernel.org, bp@alien8.de,
 tony.luck@intel.com, lenb@kernel.org, Yazen.Ghannam@amd.com,
 mchehab@kernel.org, nifan.cxl@gmail.com, linuxarm@huawei.com,
 tanxiaofei@huawei.com, prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com
References: <20250515115927.772-1-shiju.jose@huawei.com>
 <20250515115927.772-2-shiju.jose@huawei.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250515115927.772-2-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/25 4:59 AM, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Update the Documentation/edac/scrub.rst to include use cases and
> policies for CXL memory device-based, CXL region-based patrol scrub
> control and CXL Error Check Scrub (ECS).
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  Documentation/edac/scrub.rst | 76 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst
> index daab929cdba1..5c99f42eae0a 100644
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

   no comma:              ^

> +attributes for error count mode, threshold number of errors per segment
> +(indicating how many segments have at least that number of errors) for
> +reporting errors, and reset the ECS counter. Thus, the responsibility for
> +initiating Error Check Scrub on a memory device may lie with the memory
> +controller or platform when unexpectedly high error rates are detected.
> +
> +Sysfs files for scrubbing are documented in
> +`Documentation/ABI/testing/sysfs-edac-ecs`

-- 
~Randy


