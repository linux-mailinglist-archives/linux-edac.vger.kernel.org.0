Return-Path: <linux-edac+bounces-4260-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BB1AE9DD9
	for <lists+linux-edac@lfdr.de>; Thu, 26 Jun 2025 14:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1E71899D74
	for <lists+linux-edac@lfdr.de>; Thu, 26 Jun 2025 12:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118712E11BF;
	Thu, 26 Jun 2025 12:51:51 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0143225B30A;
	Thu, 26 Jun 2025 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942310; cv=none; b=iCxhr9tWLpBQ38UI1XM+khHOYnNw1jSUGjJksdnpMRDhsZ+vXOY3bZXLcK+YypiVijrQGpNZ48o6SMB8B3dMxK5kDan1SioTdXeIyzBDrxVVbeE2IpCSuis7xQEvZNw0uRF04Ub2UD85xIC4Ydjahl5/7ckugQ1ECDD108ReKDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942310; c=relaxed/simple;
	bh=EPQkNCZl/P+7ztePCyqmZaljOKue1/126ei5E/j2mkQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QZqJeb+n+gedEdddVqQkTLND6FvippxRm/o0ZrhpIfGcKdusadpMPCjnkx0bL+tx4F0eChYxyWBpGIIv1V2SpEcTsVonxUo6klUPqEZUmlhMZifxPYvPqp7wBnIJ8IFsORYx5PJdB+Ki/AS06KQwghSujWLk1PiOxO6e6uJ40qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bSdpW2h3Cz6M4g3;
	Thu, 26 Jun 2025 20:50:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8136F140426;
	Thu, 26 Jun 2025 20:51:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 26 Jun
 2025 14:51:45 +0200
Date: Thu, 26 Jun 2025 13:51:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-edac@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<lenb@kernel.org>, <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linuxarm@huawei.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH v2 1/1] EDAC: Fix lockdep splat caused by edac features
 code
Message-ID: <20250626135144.00002973@huawei.com>
In-Reply-To: <20250626101344.1726-1-shiju.jose@huawei.com>
References: <20250626101344.1726-1-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 26 Jun 2025 11:13:44 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Fix the lockdep splat caused by missing sysfs_attr_init() calls
> for the recently added EDAC feature's sysfs attributes.
> 
> In lockdep_init_map_type(), the check for the lock-class key
> if (!static_obj(key) && !is_dynamic_key(key)) causes the splat.
> 
> Backtrace:
> RIP: 0010:lockdep_init_map_type+0x131/0x270
> Call Trace:
>  __kernfs_create_file+0x77/0xf0
> sysfs_add_file_mode_ns+0x86/0x140
> internal_create_group+0x1cc/0x4b0
> internal_create_groups+0x42/0xa0
> device_add+0x310/0x860
> ? __init_waitqueue_head+0x4a/0x60
> edac_dev_register+0x3ff/0x480
> devm_cxl_memdev_edac_register+0x509/0x640 [cxl_core]
> ? lock_acquire+0xc4/0x2d0
> ? find_held_lock+0x2b/0x80
> ? cxl_mem_probe+0x21e/0x360 [cxl_mem]
> ? cxl_mem_probe+0x21e/0x360 [cxl_mem]
> ? lockdep_hardirqs_on+0x78/0x100
> ? cxl_mem_probe+0x226/0x360 [cxl_mem]
> cxl_mem_probe+0x226/0x360 [cxl_mem]
> 
> Fixes: f90b738166fe ("EDAC: Add scrub control feature")
> Fixes: bcbd069b11b0 ("EDAC: Add a Error Check Scrub control feature")
> Fixes: 699ea5219c4b ("EDAC: Add a memory repair control feature")
> Reported-by: Dave Jiang <dave.jiang@intel.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

