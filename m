Return-Path: <linux-edac+bounces-2122-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BD09A1E93
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 11:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FADAB238AB
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 09:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583401D90AD;
	Thu, 17 Oct 2024 09:39:33 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F1F13AA4E;
	Thu, 17 Oct 2024 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157973; cv=none; b=lNJKuh2/oBb7+bF2LjKgZoodMeN2VBYggbMr2i0OIdrkhT6xd4pOgDDrgK1S5PXxQWf4I9w0lBOXfhehLffv8CymSLewxsRERYoGbb3UhuJTCsWd+Qn0P+jKLu6P8htQpdHYSgKZsG2BjG5WgTCw7XAbI/sfQulU11NwOQbyg7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157973; c=relaxed/simple;
	bh=DSgUWFQ/auaLINQJmmQujRCU4A1PnCPi/te5rgU51hQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1H9IlfWBHwCu0MFj689Jn4xCd/DRPcRDqKK3/gkUKJfMn+bVciUXr87T0CTTGbvWmGyq1hd5FAAqnIOfi4MfxhFjC32GPaIIwv3TDzAvy5ahsE8s5DGMw4Myr01RIsNkMKDuYGcTHsHyiZ8ZkJfkO76QlaUVSyLUEjYc17qmf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTjT32j0Bz6JBQb;
	Thu, 17 Oct 2024 17:38:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 40E151400C9;
	Thu, 17 Oct 2024 17:39:27 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 11:39:25 +0200
Date: Thu, 17 Oct 2024 10:39:23 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <mark.rutland@arm.com>, <catalin.marinas@arm.com>, <mingo@redhat.com>,
	<robin.murphy@arm.com>, <bp@alien8.de>, <rafael@kernel.org>,
	<wangkefeng.wang@huawei.com>, <tanxiaofei@huawei.com>,
	<mawupeng1@huawei.com>, <tony.luck@intel.com>, <linmiaohe@huawei.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <tongtiangen@huawei.com>,
	<gregkh@linuxfoundation.org>, <will@kernel.org>, <jarkko@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-edac@vger.kernel.org>, <x86@kernel.org>, <justin.he@arm.com>,
	<ardb@kernel.org>, <ying.huang@intel.com>, <ashish.kalra@amd.com>,
	<baolin.wang@linux.alibaba.com>, <tglx@linutronix.de>,
	<dave.hansen@linux.intel.com>, <lenb@kernel.org>, <hpa@zytor.com>,
	<robert.moore@intel.com>, <lvying6@huawei.com>, <xiexiuqi@huawei.com>,
	<zhuo.song@linux.alibaba.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v14 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
Message-ID: <20241017103923.00007033@Huawei.com>
In-Reply-To: <20241014084240.18614-2-xueshuai@linux.alibaba.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
	<20241014084240.18614-2-xueshuai@linux.alibaba.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 14 Oct 2024 16:42:38 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> Synchronous error was detected as a result of user-space process accessing
> a 2-bit uncorrected error. The CPU will take a synchronous error exception
> such as Synchronous External Abort (SEA) on Arm64. The kernel will queue a
> memory_failure() work which poisons the related page, unmaps the page, and
> then sends a SIGBUS to the process, so that a system wide panic can be
> avoided.
> 
> However, no memory_failure() work will be queued when abnormal synchronous
> errors occur. These errors can include situations such as invalid PA,
> unexpected severity, no memory failure config support, invalid GUID
> section, etc. In such case, the user-space process will trigger SEA again.
> This loop can potentially exceed the platform firmware threshold or even
> trigger a kernel hard lockup, leading to a system reboot.
> 
> Fix it by performing a force kill if no memory_failure() work is queued
> for synchronous errors.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

The subtle cases in here are the various other forms of delayed handling
buried in some of the record handling that don't set queued.
I've been through them all and have convinced myself that either 
hey should never be synchronous or that there is no attempt to
recover in kernel today (non memory things such as CXL protocol
collapse, which might I guess be detected synchronously on a read
- though I'd expect poison and a memory error first) so the correct
thing to do is what you have here.

Fiddly code though with a lot of paths, so more eyes welcome!

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

+CC linux-cxl for info.
 
> ---
>  drivers/acpi/apei/ghes.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index ada93cfde9ba..f2ee28c44d7a 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -801,6 +801,16 @@ static bool ghes_do_proc(struct ghes *ghes,
>  		}
>  	}
>  
> +	/*
> +	 * If no memory failure work is queued for abnormal synchronous
> +	 * errors, do a force kill.
> +	 */
> +	if (sync && !queued) {
> +		pr_err("%s:%d: hardware memory corruption (SIGBUS)\n",
> +			current->comm, task_pid_nr(current));
> +		force_sig(SIGBUS);
> +	}
> +
>  	return queued;
>  }
>  


