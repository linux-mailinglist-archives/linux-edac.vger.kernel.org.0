Return-Path: <linux-edac+bounces-3868-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DB3AAF72F
	for <lists+linux-edac@lfdr.de>; Thu,  8 May 2025 11:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622474C3237
	for <lists+linux-edac@lfdr.de>; Thu,  8 May 2025 09:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4197F4B1E48;
	Thu,  8 May 2025 09:52:12 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD515A945;
	Thu,  8 May 2025 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746697932; cv=none; b=rUDJ8zki2L4oY9+EH1xwbVB7UzBM0D7ZzamJnzP8mtrMnMrpx9TFsh9XfjPWX1flYZNqU2sONqsY8fHyHJbkNGoUeZBX8BYQgHg9HJWSFSLKoEQVrBIze1j8OjyYOM2NoS48dS1fKvGuCf4l7ZCyJ2Ru3Xs7X/6vpcwP/ADVmNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746697932; c=relaxed/simple;
	bh=smR+sa3ThfinspiI9/1lrpMdzZOk1s6VFWqxY9XLyZY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LhbCMEtDRbP973yfN8jm+WWjVsBciA/qLY0CPXk/imrzqTL8kwWhTOSGvr+kKWzARUFMTTDfKFNQg1v0u1zjyyUQ5cm/jAV+/6V+wMIvbZ5vvQF2ect1CCx5bk2SXcSakFtAzhU4/gYXtEIZqpUTHAmmU8eX5o2hZYMtpgz8IP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZtS8R2vccz6K9TX;
	Thu,  8 May 2025 17:51:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 72C4F1402CB;
	Thu,  8 May 2025 17:52:07 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 8 May
 2025 11:52:06 +0200
Date: Thu, 8 May 2025 10:52:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <lenb@kernel.org>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>, <nifan.cxl@gmail.com>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>
Subject: Re: [PATCH v4 1/8] EDAC: Update documentation for the CXL memory
 patrol scrub control feature
Message-ID: <20250508105205.00007499@huawei.com>
In-Reply-To: <20250502084517.680-2-shiju.jose@huawei.com>
References: <20250502084517.680-1-shiju.jose@huawei.com>
	<20250502084517.680-2-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 2 May 2025 09:45:09 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Update the Documentation/edac/scrub.rst to include use cases and
> policies for CXL memory device-based, CXL region-based patrol scrub
> control and CXL Error Check Scrub (ECS).
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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


