Return-Path: <linux-edac+bounces-2583-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593F69D4F79
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2024 16:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE64282546
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2024 15:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E1D6CDBA;
	Thu, 21 Nov 2024 15:11:14 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304001D47DC;
	Thu, 21 Nov 2024 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732201874; cv=none; b=PffAb8QnIboeXkj3awKBzcyMofUH3puvEawXmFWKaLtigor551d5/OmhlMHgaY+151JBbOvs9iWcLY3oDw5b6+Rlf/LkTyEaolN4VavpUUN5/T8UxoPa1xbXUZmGs3FlhdKpwcTdrKTSf5q9N38a5A/dvj0mY6nMUSd1yRfODo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732201874; c=relaxed/simple;
	bh=Qk2ZQQOCaJWeyhioDSxZF/pEd6L3gv2B97TBV9VosJw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FsM21/l74/rwe7KeEmcJlh/pg6r0OwPcIxBPPwziKKLeDlb8TQqyvdgF/6h6XiAcghKVN5Mz0Faem659PqeWuefb3By6dl3ITjUD44aH4/LR6vNWzjdt1c3JMiNJzidZQ8aCfe6xG/nMuH7liWL4OOfQYF0+C7cI17bhhIc9Zhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvM9v5BYXz6L75J;
	Thu, 21 Nov 2024 23:10:43 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D8181140A79;
	Thu, 21 Nov 2024 23:11:07 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 16:11:06 +0100
Date: Thu, 21 Nov 2024 15:11:05 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <nifan.cxl@gmail.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH 01/13] rasdaemon: cxl: Fix logging of memory event type
 of DRAM trace event
Message-ID: <20241121151105.00000d6d@huawei.com>
In-Reply-To: <20241120095923.1891-2-shiju.jose@huawei.com>
References: <20241120095923.1891-1-shiju.jose@huawei.com>
	<20241120095923.1891-2-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 20 Nov 2024 09:59:11 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec rev 3.0 section 8.2.9.2.1.2 defines the DRAM Event Record.
> 
> Fix logging of memory event type field of DRAM trace event.
> For e.g. if value is 0x1 it will be reported as an Invalid Address
> (General Media Event Record - Memory Event Type) instead of Scrub Media
> ECC Error (DRAM Event Record - Memory Event Type) and so on.
> 
> Fixes: 9a2f6186db26 ("rasdaemon: Add support for the CXL dram events")
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


