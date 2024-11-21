Return-Path: <linux-edac+bounces-2591-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8534D9D4FC3
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2024 16:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2D128412B
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2024 15:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DACF14B959;
	Thu, 21 Nov 2024 15:33:37 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A679154456;
	Thu, 21 Nov 2024 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203217; cv=none; b=BQq2HbwOapNnOfk/VvUuyC7PZ/sxWBdKoi5TiTXVa2KxH1fQ67Xr+YGXIeOB0Sne6r0mrbZ//EMgdRoWGtgPyLHbMXykrJEetPnycfA/9GOIKvTKk/XiNpYM0m0Q9OtNCl+4vLbrS9WXHiZ4OWYHAeZS2ZbUlPWHAdJ0V+EsuIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203217; c=relaxed/simple;
	bh=6METngbTKefZxWPOVsLzFhHX8zlngxBpEU2AuCO7WOc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahjYyevoc40IPR5ZRUqYNLWQx7GtrDGRpkuJIFEmD2FTQKadiCFjHBwbmXjEY174NNw/GCScjuyhkPP585v9FV9yJqMjgZ1GAyS8jFYDTkwdaTCGN1Ggbgd/hMkOUNWTsJmPLanlzZbO2vmRJpVJbP6mtaeqWbAtggILulKRKg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvMdW1RBSz6J9yF;
	Thu, 21 Nov 2024 23:31:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6466E1402C7;
	Thu, 21 Nov 2024 23:33:31 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 16:33:30 +0100
Date: Thu, 21 Nov 2024 15:33:29 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <nifan.cxl@gmail.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH 09/13] rasdaemon: ras-mc-ctl: Fix logging of memory
 event type in CXL DRAM error table
Message-ID: <20241121153329.000001c0@huawei.com>
In-Reply-To: <20241120095923.1891-10-shiju.jose@huawei.com>
References: <20241120095923.1891-1-shiju.jose@huawei.com>
	<20241120095923.1891-10-shiju.jose@huawei.com>
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

On Wed, 20 Nov 2024 09:59:19 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec rev 3.0 section 8.2.9.2.1.2 defines the DRAM Event Record.
> 
> Fix decoding of memory event type in the CXL DRAM error table in RAS
> SQLite database.
> For e.g. if value is 0x1 it will be logged as an Invalid Address
> (General Media Event Record - Memory Event Type) instead of Scrub Media
> ECC Error (DRAM Event Record - Memory Event Type) and so on.
> 
> Fixes: c38c14afc5d7 ("rasdaemon: ras-mc-ctl: Add support for CXL DRAM trace events")
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Though note I don't really understand this code so only
reviewing based on changes looking correct given what was there
before.

J

