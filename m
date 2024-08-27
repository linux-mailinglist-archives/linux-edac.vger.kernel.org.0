Return-Path: <linux-edac+bounces-1739-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209F996135D
	for <lists+linux-edac@lfdr.de>; Tue, 27 Aug 2024 17:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EDC1284BC3
	for <lists+linux-edac@lfdr.de>; Tue, 27 Aug 2024 15:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3331C68AE;
	Tue, 27 Aug 2024 15:53:02 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B5E1C232B;
	Tue, 27 Aug 2024 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773982; cv=none; b=j4PYajqTBZR1W2zMuLmAREExHoj6U0kB10yqrv2pMqBYVj4gU48oNSwRvtyF4TWd/RPTj2yanb0PbsZ1f3+WgSKkbKeru1H193fZA8GNjgArTVuO5FFys0RQ/mMYZ2Sa4s/1o64p80of2U8Z42xpHxEgWzxVf1diAwnDGMZKoy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773982; c=relaxed/simple;
	bh=RNaAW124fmdhNZJn1lu+heIm0NL9erecJidndO6UzRY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOFUs8tKNqNBq4YVh3oY8MHh3AsoKPG0fHWsQ68LC6BdwpresPgU46DG6vXqzKqCElxZPJAxwFR8ZXQREDuUQhYloya7ffSbGS1f5Tw/vNxSMYqrPOUvzrSH4+yg8L5TZ8C3ehJut34sMUkaV1TfJIOtbkDKy9qDU725gaJAXrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtX6X4WzNz6K9Bp;
	Tue, 27 Aug 2024 23:49:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F013140B38;
	Tue, 27 Aug 2024 23:52:56 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 16:52:55 +0100
Date: Tue, 27 Aug 2024 16:52:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC: <linux-cxl@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-mm@kvack.org>, <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <bp@alien8.de>, <dave.jiang@intel.com>,
	<dave@stgolabs.net>, <ira.weiny@intel.com>, <james.morse@arm.com>,
	<linmiaohe@huawei.com>, <mchehab@kernel.org>, <nao.horiguchi@gmail.com>,
	<rric@kernel.org>, <tony.luck@intel.com>
Subject: Re: [PATCH v4 2/2] cxl: avoid duplicated report from MCE & device
Message-ID: <20240827165255.00003184@Huawei.com>
In-Reply-To: <20240808151328.707869-3-ruansy.fnst@fujitsu.com>
References: <20240808151328.707869-1-ruansy.fnst@fujitsu.com>
	<20240808151328.707869-3-ruansy.fnst@fujitsu.com>
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

On Thu,  8 Aug 2024 23:13:28 +0800
Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

> Since CXL device is a memory device, while CPU is consuming a poison
> page of CXL device, it always triggers a MCE (via interrupt #18) and
> calls memory_failure() to handle POISON page, no matter which-First path
> is configured.  CXL device could also find and report the POISON, kernel
> now not only traces but also calls memory_failure() to handle it, which
> is marked as "NEW" in the figure blow.
> ```
> 1.  MCE (interrupt #18, while CPU consuming POISON)
>      -> do_machine_check()
>        -> mce_log()
>          -> notify chain (x86_mce_decoder_chain)
>            -> memory_failure() <---------------------------- EXISTS  
> 2.a FW-First (optional, CXL device proactively find&report)
>      -> CXL device -> Firmware
>        -> OS: ACPI->APEI->GHES->CPER -> CXL driver -> trace  
>                                                   \-> memory_failure()
>                                                       ^----- NEW
> 2.b OS-First (optional, CXL device proactively find&report)
>      -> CXL device -> MSI
>        -> OS: CXL driver -> trace  
>                         \-> memory_failure()
>                             ^------------------------------- NEW
> ```
> 
> But in this way, the memory_failure() could be called twice or even at
> same time, as is shown in the figure above: (1.) and (2.a or 2.b),
> before the POISON page is cleared.  memory_failure() has it own mutex
> lock so it actually won't be called at same time and the later call
> could be avoided because HWPoison bit has been set.  However, assume
> such a scenario, "CXL device reports POISON error" triggers 1st call,
> user see it from log and want to clear the poison by executing `cxl
> clear-poison` command, and at the same time, a process tries to access
> this POISON page, which triggers MCE (it's the 2nd call).

Attempting to clear poison in a page that is online seems unwise.
Does that ever make sense today?

>  Since there
> is no lock between the 2nd call with clearing poison operation, race
> condition may happen, which may cause HWPoison bit of the page in an
> unknown state.

As long as that state is always wrong in the sense we think it's poisoned
when it isn't we don't care.
> 
> Thus, we have to avoid the 2nd call. This patch[2] introduces a new
> notifier_block into `x86_mce_decoder_chain` and a POISON cache list, to
> stop the 2nd call of memory_failure(). It checks whether the current
> poison page has been reported (if yes, stop the notifier chain, don't
> call the following memory_failure() to report again).
> 

If we do want to do this, it belongs in the generic code, not arch specific
part. Can we do similar in memory failure?

To RAS reviewers, this isn't a new problem unique to CXL. Does a solution
like this make sense in practice, or are we fine to always let two reports
for the same error get handled?


Jonathan




