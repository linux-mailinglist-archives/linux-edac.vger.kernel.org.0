Return-Path: <linux-edac+bounces-3979-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF202ABF7FD
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 16:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD181B67FA3
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 14:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAD21D7995;
	Wed, 21 May 2025 14:40:36 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E48A14A627;
	Wed, 21 May 2025 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747838436; cv=none; b=hnpFC1a17OJ/Y/+lrDkvCWlkaDYHs4XVFteYhDXPrSBqiqpVZM5V8DgtjOirpd/rPjzBcm0rtpmA8Km89zsqrdra/widA0nAfNELlU8eYkkVYsFh+gy6RQmcl/W6d/Uq48cjMWwpCg7TSnQpIsEtB7Wn0LOEiKgScFNktT1SqK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747838436; c=relaxed/simple;
	bh=RLaDbMKe1QMLAmmsFpGpDxPHWTIKB8SXXMCzWBZ4ypY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CtFHeUxeNRpv8Fyl08muWnv4GpXWCSPjDaebO+hdxtPI27nI20UbW3lHlTbtno6Q9V7NwHL6OqBL3GhAqW8h4i5GkrXuTYvPFBP1BrcKQ0AYxa0Yltb6WQPiZ4TVQU1qIPdqpHp/9GNsMx6rJ2suLKMywLtxU9ON1KLkTa3BHmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2YwT0L3Gz6GD9V;
	Wed, 21 May 2025 22:39:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 56959140392;
	Wed, 21 May 2025 22:40:30 +0800 (CST)
Received: from localhost (10.195.34.206) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 May
 2025 16:40:29 +0200
Date: Wed, 21 May 2025 15:40:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <lenb@kernel.org>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>, <nifan.cxl@gmail.com>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>
Subject: Re: [PATCH v6 3/8] cxl/edac: Add CXL memory device patrol scrub
 control feature
Message-ID: <20250521154026.0000172f@huawei.com>
In-Reply-To: <20250521124749.817-4-shiju.jose@huawei.com>
References: <20250521124749.817-1-shiju.jose@huawei.com>
	<20250521124749.817-4-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 21 May 2025 13:47:41 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.2 section 8.2.10.9.11.1 describes the device patrol scrub
> control feature. The device patrol scrub proactively locates and makes
> corrections to errors in regular cycle.
> 
> Allow specifying the number of hours within which the patrol scrub must be
> completed, subject to minimum and maximum limits reported by the device.
> Also allow disabling scrub allowing trade-off error rates against
> performance.
> 
> Add support for patrol scrub control on CXL memory devices.
> Register with the EDAC device driver, which retrieves the scrub attribute
> descriptors from EDAC scrub and exposes the sysfs scrub control attributes
> to userspace. For example, scrub control for the CXL memory device
> "cxl_mem0" is exposed in /sys/bus/edac/devices/cxl_mem0/scrubX/.
> 
> Additionally, add support for region-based CXL memory patrol scrub control.
> CXL memory regions may be interleaved across one or more CXL memory
> devices. For example, region-based scrub control for "cxl_region1" is
> exposed in /sys/bus/edac/devices/cxl_region1/scrubX/.
> 
> [dj: Add cxl_test inclusion of edac.o]
> [dj: Check return from cxl_feature_info() with IS_ERR]

Trivial question on these.  What do they reflect?  Some changes
Dave made on a prior version? Or changes in response to feedback
(in which case they should be below the ---)

> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

A couple of formatting trivial things inline from the refactors
in this version. Maybe Dave can tweak them whilst applying if
nothing else comes up?

J

> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> new file mode 100644
> index 000000000000..eae99ed7c018
> --- /dev/null
> +++ b/drivers/cxl/core/edac.c
> @@ -0,0 +1,520 @@

> +static int cxl_scrub_get_attrbs(struct cxl_patrol_scrub_context *cxl_ps_ctx,
> +				u8 *cap, u16 *cycle, u8 *flags, u8 *min_cycle)
> +{
> +	struct cxl_mailbox *cxl_mbox;
> +	u8 min_scrub_cycle = U8_MAX;
> +	struct cxl_region_params *p;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_region *cxlr;
> +	int i, ret;
> +
> +	if (!cxl_ps_ctx->cxlr) {
> +		cxl_mbox = &cxl_ps_ctx->cxlmd->cxlds->cxl_mbox;
> +		return cxl_mem_scrub_get_attrbs(cxl_mbox, cap, cycle,
> +						flags, min_cycle);
> +	}
> +
> +	struct rw_semaphore *region_lock __free(rwsem_read_release) =
> +	rwsem_read_intr_acquire(&cxl_region_rwsem);

Trivial but that should be indented one tab more.

> +	if (!region_lock)
> +		return -EINTR;
> +
> +	cxlr = cxl_ps_ctx->cxlr;
> +	p = &cxlr->params;
> +
> +	for (i = 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +
> +		cxlmd = cxled_to_memdev(cxled);
> +		cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> +		ret = cxl_mem_scrub_get_attrbs(cxl_mbox, cap, cycle,
> +					       flags, min_cycle);

Maybe move flags to previous line.

> +		if (ret)
> +			return ret;
> +
> +		if (min_cycle)
> +			min_scrub_cycle =
> +				min(*min_cycle, min_scrub_cycle);

No need for the line wrap any more.


> +	}
> +
> +	if (min_cycle)
> +		*min_cycle = min_scrub_cycle;
> +
> +	return 0;
> +}


