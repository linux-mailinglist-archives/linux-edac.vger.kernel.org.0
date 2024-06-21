Return-Path: <linux-edac+bounces-1340-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA74912D3C
	for <lists+linux-edac@lfdr.de>; Fri, 21 Jun 2024 20:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3AF1F25FCF
	for <lists+linux-edac@lfdr.de>; Fri, 21 Jun 2024 18:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F65D1684AA;
	Fri, 21 Jun 2024 18:33:23 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5077716A924
	for <linux-edac@vger.kernel.org>; Fri, 21 Jun 2024 18:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718994803; cv=none; b=Vun01z6vV8srESpyD/Q2DPwX13qnWenLeQfpyBvHM7CYinZp+yHrH8ls+5puuDNn83dOGjE97VlNF9mulRm/b57+YMlnnSA0PQEV82kQWOm/IepdFwKncNlnBtjalLuAyKtrxkX2mGh0Ofrbjyf4r17jyQHcaDCmZQwi10lgXoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718994803; c=relaxed/simple;
	bh=uCLqzM/byq1KpJWm93hbn7C50XMi+GyhzzS/6R5QP18=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=duB2/RxXXfmp/ACG2oxSUqx1l8wsENq6GnbZ7qQmZ1dtLxZ6il4bROw/+kgTDR6lIt4UTDjyBy14IXNL10ogUBSQUAOM5AcBCk2RkXNq4Gp82FR2se+tAAtoGabHfxzQ271YoCR4dRU7FuOMNCI3BaDxcXsxf20ssI1XQTe5aRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W5Qvk2Xz4z6K6Sk;
	Sat, 22 Jun 2024 02:32:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8DC95140B38;
	Sat, 22 Jun 2024 02:33:17 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Jun
 2024 19:33:17 +0100
Date: Fri, 21 Jun 2024 19:33:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-edac@vger.kernel.org>,
	<mchehab+huawei@kernel.org>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 1/1] hw/arm: FW first ARM processor error injection.
Message-ID: <20240621193316.00000d83@Huawei.com>
In-Reply-To: <20240621165115.336-1-shiju.jose@huawei.com>
References: <20240621165115.336-1-shiju.jose@huawei.com>
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
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 21 Jun 2024 17:51:15 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
Thanks for posting this.

Given this is going to linux-edac, probably should mention
this is QEMU based error injection.  For cross postings
between kernel related and qemu lists I tend to stick
qemu in the [] of the patch description.

> 
> Add support for FW first ARM processor error injection.
> 
> Compliance with N.2.4.4 ARM Processor Error Section in
> UEFI 2.9A/2.10 specs.
> 
> Examples,
> { "execute": "arm-inject-error",
>       "arguments": {
>         "errortypes": ['cache-error']
>       }
> }
> 
> { "execute": "arm-inject-error",
>       "arguments": {
>         "errortypes": ['tlb-error']
>       }
> }
> 
> { "execute": "arm-inject-error",
>       "arguments": {
>         "errortypes": ['bus-error']
>       }
> }
> 
> { "execute": "arm-inject-error",
>       "arguments": {
>         "errortypes": ['cache-error', 'tlb-error']
>       }
> }
> 
> { "execute": "arm-inject-error",
>       "arguments": {
>         "errortypes": ['cache-error', 'tlb-error', 'bus-error', 'micro-arch-error']
>       }
> }
> etc.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

With a few minor tweaks to build files, this is on my cxl gitlab qemu staging
branch as that happens to have other injection stuff (this obviously has little
to do with CXL!)

http://gitlab.com/jic23/qemu/ cxl-2024-06-21

Note I haven't tested that branch beyond a quick boot test, so it might get
some revisions early next week.

Jonathan

