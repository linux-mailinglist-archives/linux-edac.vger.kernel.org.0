Return-Path: <linux-edac+bounces-1738-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F16961332
	for <lists+linux-edac@lfdr.de>; Tue, 27 Aug 2024 17:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE3E1F24348
	for <lists+linux-edac@lfdr.de>; Tue, 27 Aug 2024 15:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B911C6F48;
	Tue, 27 Aug 2024 15:46:18 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368B61C688B;
	Tue, 27 Aug 2024 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773578; cv=none; b=fuoX24OyyYI1wwKiHS+KTAuVcS5Pqr1HEIMvKtGelN0k/CKS2JYcfLkRryNRobXXuw8cq947EaQgqYlFj5GfxXzm1xXZp1uw6iwwPxhFP01+DYbLyQHUrOiLcijhhH6UKmu/5gn7Bi44KZZSsvYLnw2VvPgHIReXHYndmwlD5Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773578; c=relaxed/simple;
	bh=XAoMNamzIiaOVrn0SzSh4hNY0XWU0tL27X8Bod5ewuU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eWokqBOqpNT+Xl5XRbXK4ybaLNzobFznlHQrZHOID6PXsYWoTl4LSAvtyH9qoZD1ARZGvOBbODk5R2zBvZde3N26rfqpVr81+V/Mk32/J7v8DWZclvQnufU6pHFCBmj9hjxdGJopPW+HC30cIRVaA8zwADvF36UX8x88v8nD9Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtWym5vKrz6DBht;
	Tue, 27 Aug 2024 23:42:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BEA9C140447;
	Tue, 27 Aug 2024 23:46:11 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 16:46:11 +0100
Date: Tue, 27 Aug 2024 16:46:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC: <linux-cxl@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-mm@kvack.org>, <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <bp@alien8.de>, <dave.jiang@intel.com>,
	<dave@stgolabs.net>, <ira.weiny@intel.com>, <james.morse@arm.com>,
	<linmiaohe@huawei.com>, <mchehab@kernel.org>, <nao.horiguchi@gmail.com>,
	<rric@kernel.org>, <tony.luck@intel.com>, <shiju.jose@huawei.com>
Subject: Re: [PATCH v4 1/2] cxl/core: introduce device reporting poison
 hanlding
Message-ID: <20240827164610.00002f4d@Huawei.com>
In-Reply-To: <20240808151328.707869-2-ruansy.fnst@fujitsu.com>
References: <20240808151328.707869-1-ruansy.fnst@fujitsu.com>
	<20240808151328.707869-2-ruansy.fnst@fujitsu.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu,  8 Aug 2024 23:13:27 +0800
Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

> CXL device can find&report memory problems, even before MCE is detected
> by CPU.  AFAIK, the current kernel only traces POISON error event
> from FW-First/OS-First path, but it doesn't handle them, neither
> notify processes who are using the POISON page like MCE does.
> 
> Thus, user have to read logs from trace and find out which device
> reported the error and which applications are affected.  That is not
> an easy work and cannot be handled in time. 

These are async reports, so I'm not sure what 'in time' really means here.
If we get synchronous poison from a processor access it will be handled
via traditional means (MCE, ARM SEA etc)

Whether to handle async error reports (typically from scrub or because
the memory device received poison from someone else) the same way
should perhaps be a policy decision.  It should match what we do
for firmware first async reports though (any policy controls make sense
for both).

An example of this would be that an host OS might attempt a polite close
of an application might attempt a polite if we know there is poison
somewhere in a dataset it has access to. If that poison is never seen
synchronously (because that data is not read) then it my close
successfully rather than being killed.

If it's injected poison and we didn't see it synchronously we might
well not want to kill anything.

> Thus, it is needed to add
> the feature to make the work done automatically and quickly.  Once CXL
> device reports the POISON error (via FW-First/OS-First), kernel
> handles it immediately, similar to the flow when a MCE is triggered.
> 
> The current call trace of error reporting&handling looks like this:
> ```
> 1.  MCE (interrupt #18, while CPU consuming POISON)
>      -> do_machine_check()
>        -> mce_log()
>          -> notify chain (x86_mce_decoder_chain)
>            -> memory_failure()  
> 
> 2.a FW-First (optional, CXL device proactively find&report)
>      -> CXL device -> Firmware
>        -> OS: ACPI->APEI->GHES->CPER -> CXL driver -> trace  
>                                                   \-> memory_failure()
>                                                       ^----- ADD
> 2.b OS-First (optional, CXL device proactively find&report)
>      -> CXL device -> MSI
>        -> OS: CXL driver -> trace  
>                         \-> memory_failure()
>                             ^------------------------------- ADD
> ```
> This patch adds calling memory_failure() while CXL device reporting
> error is received, marked as "ADD" in figure above.

Typo in patch title.  handling
I've also dropped qemu-devel as this doesn't have anything to do with qemu.

> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Experienced RAS folk in the CC, how do you want this to work for
asynchoronous memory errors on CXL devices?



