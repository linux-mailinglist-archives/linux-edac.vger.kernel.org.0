Return-Path: <linux-edac+bounces-37-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D124C7EDCEF
	for <lists+linux-edac@lfdr.de>; Thu, 16 Nov 2023 09:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8949C280F68
	for <lists+linux-edac@lfdr.de>; Thu, 16 Nov 2023 08:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543B428F4;
	Thu, 16 Nov 2023 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CQr29r+9"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDABD19D;
	Thu, 16 Nov 2023 00:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700123560; x=1731659560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=MMCaN/5GWIE2n5sG2o8nbRvRmppWHioLWqGH43Qh3e8=;
  b=CQr29r+9j1LaUhbtalo/h4IEoCVPnf0tnW8hAYslyk9YLfsVgKLXFI6z
   gVRVuLlb8lq3PoCiovHIZP6MNpLRhyT/2bRa4EDgStX/1DO2BuPdLhV4b
   vQ0LZZDfXzU17CHKTP11JMIKEZ7Nh7o0oXKmtQb42c6mCtwz0oiAXUTnp
   cBiIvKElWuVUL/e8kxa4TxDonqMPyZe2+5oOWaPQQZCIyQdd+CuYzLuZK
   dXA09pM2M/SMYT7b+4R2Wf3CwZCKuHPG6SyKrfPUUUcp8Ld6qZetROLR0
   m0CLEyzN5+xEr/u1005QU1UslwS1c20zDRdTufExuezQ2YyyExJYi2kSi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="457535315"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="457535315"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 00:32:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="1012540683"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="1012540683"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 00:32:37 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: andriy.shevchenko@linux.intel.com
Cc: bp@alien8.de,
	james.morse@arm.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	rric@kernel.org,
	tony.luck@intel.com,
	qiuxu.zhuo@intel.com
Subject: [PATCH v1 3/3] EDAC, pnd2: Sort headers alphabetically
Date: Thu, 16 Nov 2023 16:32:25 +0800
Message-Id: <20231116083225.89978-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231115154940.664664-3-andriy.shevchenko@linux.intel.com>
References: <20231115154940.664664-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ...
> 
> Sort the headers in alphabetic order in order to ease
> the maintenance for this part.

This patch LGTM. Thanks!

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/edac/pnd2_edac.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
> index 676e02c8dc43..1bbedd59e36b 100644
> --- a/drivers/edac/pnd2_edac.c
> +++ b/drivers/edac/pnd2_edac.c
> @@ -16,19 +16,20 @@
>   * rank, bank, row and column using the appropriate "dunit_ops" functions/parameters.
>   */
>  
> -#include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/pci.h>
> -#include <linux/pci_ids.h>
> -#include <linux/slab.h>
> +#include <linux/bitmap.h>
>  #include <linux/delay.h>
>  #include <linux/edac.h>
> -#include <linux/mmzone.h>
> -#include <linux/sizes.h>
> -#include <linux/smp.h>
> -#include <linux/bitmap.h>
> +#include <linux/init.h>
>  #include <linux/math64.h>
> +#include <linux/mmzone.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/pci_ids.h>
> +#include <linux/sizes.h>
> +#include <linux/slab.h>
> +#include <linux/smp.h>
> +
>  #include <linux/platform_data/x86/p2sb.h>
>  
>  #include <asm/cpu_device_id.h>

