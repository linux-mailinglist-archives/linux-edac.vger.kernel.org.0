Return-Path: <linux-edac+bounces-654-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A64386110D
	for <lists+linux-edac@lfdr.de>; Fri, 23 Feb 2024 13:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE031C2124D
	for <lists+linux-edac@lfdr.de>; Fri, 23 Feb 2024 12:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94817C6E5;
	Fri, 23 Feb 2024 12:08:28 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C0D7C099;
	Fri, 23 Feb 2024 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690108; cv=none; b=EqOQlKx0eLtNyiFouykPfNY1o7/FV0SkimAoIelNj5+bSdjafc4qAimsXTF0J9StTgs5kZgDGqB9bmuCUmdGw+91nCBHT1bKgp4HTHqwE5QSmxpaEPKrN8nOylPiKt/6xBp48nYZcj+WE6AGrXLly/cRQLTLDfbjQxlnMgrn0dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690108; c=relaxed/simple;
	bh=kbwCh5ivkreyialYBJQE89WYwcGywhW6JhNL6UddKKo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JwFrFQbvJ+WkSWRlT5EkDsXKo8lRtMd0VCGlyy3pOsWIxLiTSpWu+vRjMn0U9kVNbyageK3wK0mpYz2WBI+2CJMiVwJQimMfUMJYp2ORUnYCfBvtMoRDdR/AlZ4tI0QXwec8t4U6ien7R/dX/QYeqD5qlHesVKlKOQkoQzZKeNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Th7w71fm3z6K6B1;
	Fri, 23 Feb 2024 20:04:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F56D140B33;
	Fri, 23 Feb 2024 20:08:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 23 Feb
 2024 12:08:15 +0000
Date: Fri, 23 Feb 2024 12:08:13 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Shuai Xue <xueshuai@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
	Ira Weiny <ira.weiny@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
	"james.morse@arm.com" <james.morse@arm.com>, <rafael@kernel.org>,
	<wangkefeng.wang@huawei.com>, <tanxiaofei@huawei.com>,
	<mawupeng1@huawei.com>, <linmiaohe@huawei.com>, <naoya.horiguchi@nec.com>,
	<gregkh@linuxfoundation.org>, <will@kernel.org>, <jarkko@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-edac@vger.kernel.org>, <x86@kernel.org>, <justin.he@arm.com>,
	<ardb@kernel.org>, <ying.huang@intel.com>, <ashish.kalra@amd.com>,
	<baolin.wang@linux.alibaba.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <lenb@kernel.org>, <hpa@zytor.com>,
	<robert.moore@intel.com>, <lvying6@huawei.com>, <xiexiuqi@huawei.com>,
	<zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v11 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
Message-ID: <20240223120813.00005d1f@Huawei.com>
In-Reply-To: <65d82c9352e78_24f3f294d5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
	<20240204080144.7977-2-xueshuai@linux.alibaba.com>
	<20240219092528.GTZdMeiDWIDz613VeT@fat_crate.local>
	<bdf15819-46e0-498f-97e1-a0183f257086@linux.alibaba.com>
	<65d82c9352e78_24f3f294d5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 22 Feb 2024 21:26:43 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Shuai Xue wrote:
> > 
> > 
> > On 2024/2/19 17:25, Borislav Petkov wrote:  
> > > On Sun, Feb 04, 2024 at 04:01:42PM +0800, Shuai Xue wrote:  
> > >> Synchronous error was detected as a result of user-space process accessing
> > >> a 2-bit uncorrected error. The CPU will take a synchronous error exception
> > >> such as Synchronous External Abort (SEA) on Arm64. The kernel will queue a
> > >> memory_failure() work which poisons the related page, unmaps the page, and
> > >> then sends a SIGBUS to the process, so that a system wide panic can be
> > >> avoided.
> > >>
> > >> However, no memory_failure() work will be queued when abnormal synchronous
> > >> errors occur. These errors can include situations such as invalid PA,
> > >> unexpected severity, no memory failure config support, invalid GUID
> > >> section, etc. In such case, the user-space process will trigger SEA again.
> > >> This loop can potentially exceed the platform firmware threshold or even
> > >> trigger a kernel hard lockup, leading to a system reboot.
> > >>
> > >> Fix it by performing a force kill if no memory_failure() work is queued
> > >> for synchronous errors.
> > >>
> > >> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> > >> ---
> > >>  drivers/acpi/apei/ghes.c | 9 +++++++++
> > >>  1 file changed, 9 insertions(+)
> > >>
> > >> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > >> index 7b7c605166e0..0892550732d4 100644
> > >> --- a/drivers/acpi/apei/ghes.c
> > >> +++ b/drivers/acpi/apei/ghes.c
> > >> @@ -806,6 +806,15 @@ static bool ghes_do_proc(struct ghes *ghes,
> > >>  		}
> > >>  	}
> > >>  
> > >> +	/*
> > >> +	 * If no memory failure work is queued for abnormal synchronous
> > >> +	 * errors, do a force kill.
> > >> +	 */
> > >> +	if (sync && !queued) {
> > >> +		pr_err("Sending SIGBUS to current task due to memory error not recovered");
> > >> +		force_sig(SIGBUS);
> > >> +	}  
> > > 
> > > Except that there are a bunch of CXL GUIDs being handled there too and
> > > this will sigbus those processes now automatically.  
> > 
> > Before the CXL GUIDs added, @Tony confirmed that the HEST notifications are always
> > asynchronous on x86 platform, so only Synchronous External Abort (SEA) on ARM is
> > delivered as a synchronous notification.
> > 
> > Will the CXL component trigger synchronous events for which we need to terminate the
> > current process by sending sigbus to process?  
> 
> None of the CXL component errors should be handled as synchronous
> events. They are either asynchronous protocol errors, or effectively
> equivalent to CPER_SEC_PLATFORM_MEM notifications.

Not a good example, CPER_SEC_PLATFORM_MEM is sometimes signaled via SEA.



