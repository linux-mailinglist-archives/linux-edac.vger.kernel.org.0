Return-Path: <linux-edac+bounces-2048-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9ED99D2FE
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 17:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0EEE1F24F01
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 15:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCE21BFE0D;
	Mon, 14 Oct 2024 15:29:08 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EC11D0490;
	Mon, 14 Oct 2024 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919748; cv=none; b=EfWM/OTl4Yu4pHfwTYMcevkJ1kqy+VxIlOki2vX0UNoPkKscWXMqaI/wwDc5wRopK5URaDzbl1Cg63/TT7LFXvQnLK1fimK0/9AsZXLpA4B3RZKjvonTUOj9S/qXG8uSE8VN1gcNS/bD92VcUwh4mxkszxk29sdJ+Ae/MiEpse8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919748; c=relaxed/simple;
	bh=UGy2SwRvnSWU52bBfkJxu3GqglzWihxSmimXlWUaqnY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAeCiTQ2PtvYbyZeMnNHiqhrp/u23xP5OEdV2MQHyx9dDbhAMQHFuUo3QbKfnPsZmNGGHS9KU1zVLyE24TIV0wEQKZdSK3W1Qdi0JBx4cDC5SYz4ozz0j15JGG4coZazEqOvjH19JfYr1FtBIqo8JY7djw6n5LSD7ZSlnyfSih4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XS1Lh1Zr4z6G9YN;
	Mon, 14 Oct 2024 23:27:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1145A140A77;
	Mon, 14 Oct 2024 23:28:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 17:28:57 +0200
Date: Mon, 14 Oct 2024 16:28:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>,
	<leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v13 10/18] cxl/memfeature: Add CXL memory device patrol
 scrub control feature
Message-ID: <20241014162856.00007752@Huawei.com>
In-Reply-To: <20241009124120.1124-11-shiju.jose@huawei.com>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
	<20241009124120.1124-11-shiju.jose@huawei.com>
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

On Wed, 9 Oct 2024 13:41:11 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
> feature. The device patrol scrub proactively locates and makes corrections
> to errors in regular cycle.
> 
> Allow specifying the number of hours within which the patrol scrub must be
> completed, subject to minimum and maximum limits reported by the device.
> Also allow disabling scrub allowing trade-off error rates against
> performance.
> 
> Add support for CXL memory device based patrol scrub control.
> Register with EDAC device driver , which gets the scrub attr descriptors
> from EDAC scrub and exposes sysfs scrub control attributes to the
> userspace. For example CXL device based scrub control for the CXL mem0
> device is exposed in /sys/bus/edac/devices/cxl_mem0/scrubX/
> 
> Also add support for region based CXL memory patrol scrub control.
> CXL memory region may be interleaved across one or more CXL memory devices.
> For example region based scrub control for CXL region1 is exposed in
> /sys/bus/edac/devices/cxl_region1/scrubX/
> 
> Open Questions:
> Q1: CXL 3.1 spec defined patrol scrub control feature at CXL memory devices
> with supporting set scrub cycle and enable/disable scrub. but not based on
> HPA range. Thus presently scrub control for a region is implemented based
> on all associated CXL memory devices.

That is exactly what I'd expect.

> What is the exact use case for the CXL region based scrub control?
> How the HPA range, which Dan asked for region based scrubbing is used?
> Does spec change is required for patrol scrub control feature with support
> for setting the HPA range?

Can't discuss future spec here :(  + we should support current specification
even if it is changing (can't say if it is!)

This came up at LPC briefly. The HPA range is only useful as a userspace
short cut to find the right control.  So not necessary initially for
the reason you state - we can't control it.

Whilst we may scrub by region, it's just a way to control scrubbing of
a set of interleaved devices.  So what you have here is fine as it
stands.

> 
> Q2: Both CXL device based and CXL region based scrub control would be
> enabled at the same time in a system?

Typically no, but we should make the interface do something consistent.

1) Go with highest scrub frequency requested via either path.
2) Go with latest scrub frequency to be requested.

Given it is a corner case I don't think we care which.

The device based scrub is appropriate for 'pre use' scrub control
to find out if we have dodgy hardware.
Region scrub is the logical thing to do once it is in use. In some
cases the region will include the whole of all devices in an interleave
set.

So I don't see either of these questions as a blocker on current
implementation.

> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
A few trivial things inline.

> ---
>  Documentation/edac/edac-scrub.rst |  74 ++++++
>  drivers/cxl/Kconfig               |  18 ++
>  drivers/cxl/core/Makefile         |   1 +
>  drivers/cxl/core/memfeature.c     | 383 ++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c         |   6 +
>  drivers/cxl/cxlmem.h              |   7 +
>  drivers/cxl/mem.c                 |   4 +
>  7 files changed, 493 insertions(+)
>  create mode 100644 Documentation/edac/edac-scrub.rst
>  create mode 100644 drivers/cxl/core/memfeature.c
> 
> diff --git a/Documentation/edac/edac-scrub.rst b/Documentation/edac/edac-scrub.rst
> new file mode 100644
> index 000000000000..243035957e99
> --- /dev/null
> +++ b/Documentation/edac/edac-scrub.rst
> @@ -0,0 +1,74 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===================
> +EDAC Scrub control
> +===================
> +
> +Copyright (c) 2024 HiSilicon Limited.
> +
> +:Author:   Shiju Jose <shiju.jose@huawei.com>
> +:License:  The GNU Free Documentation License, Version 1.2
> +          (dual licensed under the GPL v2)
> +:Original Reviewers:
> +
> +- Written for: 6.12

Update to 6.13

> +- Updated for:

> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 99b5c25be079..b717a152d2a5 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -145,4 +145,22 @@ config CXL_REGION_INVALIDATION_TEST
>  	  If unsure, or if this kernel is meant for production environments,
>  	  say N.
>  
> +config CXL_RAS_FEAT
> +	tristate "CXL: Memory RAS features"
> +	depends on CXL_PCI
> +	depends on CXL_MEM
> +	depends on EDAC
> +	help
> +	  The CXL memory RAS feature control is optional allows host to control
> +	  the RAS features configurations of CXL Type 3 devices.
> +
> +	  Registers with the EDAC device subsystem to expose control attributes
> +	  of CXL memory device's RAS features to the user.
> +	  Provides interface functions to support configuring the CXL memory
> +	  device's RAS features.
> +
> +	  Say 'y/n' to enable/disable CXL.mem device'ss RAS features control.

's or s' but not 'ss
(singular or plural forms)

> +	  See section 8.2.9.9.11 of CXL 3.1 specification for the detailed
> +	  information of CXL memory device features.
> +
>  endif

> diff --git a/drivers/cxl/core/memfeature.c b/drivers/cxl/core/memfeature.c
> new file mode 100644
> index 000000000000..84d6e887a4fa
> --- /dev/null
> +++ b/drivers/cxl/core/memfeature.c
> @@ -0,0 +1,383 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * CXL memory RAS feature driver.
> + *
> + * Copyright (c) 2024 HiSilicon Limited.
> + *
> + *  - Supports functions to configure RAS features of the
> + *    CXL memory devices.
> + *  - Registers with the EDAC device subsystem driver to expose
> + *    the features sysfs attributes to the user for configuring
> + *    CXL memory RAS feature.
> + */
> +
> +#define pr_fmt(fmt)	"CXL MEM FEAT: " fmt
> +
> +#include <cxlmem.h>
> +#include <linux/cleanup.h>
> +#include <linux/limits.h>
> +#include <cxl.h>

Reorder includes to put the cxl ones at the end and others
in alphabetical order.

> +#include <linux/edac.h>
>
> +static int cxl_ps_get_attrs(struct device *dev, void *drv_data,
> +			    struct cxl_memdev_ps_params *params)
> +{
> +	struct cxl_patrol_scrub_context *cxl_ps_ctx = drv_data;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_dev_state *cxlds;
> +	struct cxl_memdev_state *mds;
> +	u16 min_scrub_cycle = 0;
> +	int i, ret;
> +
> +	if (cxl_ps_ctx->cxlr) {
> +		struct cxl_region *cxlr = cxl_ps_ctx->cxlr;
> +		struct cxl_region_params *p = &cxlr->params;
> +
> +		for (i = p->interleave_ways - 1; i >= 0; i--) {
> +			struct cxl_endpoint_decoder *cxled = p->targets[i];
> +
> +			cxlmd = cxled_to_memdev(cxled);
> +			cxlds = cxlmd->cxlds;
> +			mds = to_cxl_memdev_state(cxlds);
> +			ret = cxl_mem_ps_get_attrs(mds, params);
> +			if (ret)
> +				return ret;
> +
> +			if (params->min_scrub_cycle_hrs > min_scrub_cycle)
> +				min_scrub_cycle = params->min_scrub_cycle_hrs;
> +		}
> +		params->min_scrub_cycle_hrs = min_scrub_cycle;
> +		return 0;
> +	}
> +	cxlmd = cxl_ps_ctx->cxlmd;
> +	cxlds = cxlmd->cxlds;
> +	mds = to_cxl_memdev_state(cxlds);
> +
See below - this is the similar example I refer to.

> +	return cxl_mem_ps_get_attrs(mds, params);
> +}

> +
> +static int cxl_ps_set_attrs(struct device *dev, void *drv_data,
> +			    struct cxl_memdev_ps_params *params,
> +			    enum cxl_scrub_param param_type)
> +{
> +	struct cxl_patrol_scrub_context *cxl_ps_ctx = drv_data;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_dev_state *cxlds;
> +	struct cxl_memdev_state *mds;
> +	int ret, i;
> +
> +	if (cxl_ps_ctx->cxlr) {
> +		struct cxl_region *cxlr = cxl_ps_ctx->cxlr;
> +		struct cxl_region_params *p = &cxlr->params;
> +
> +		for (i = p->interleave_ways - 1; i >= 0; i--) {
> +			struct cxl_endpoint_decoder *cxled = p->targets[i];
> +
> +			cxlmd = cxled_to_memdev(cxled);
> +			cxlds = cxlmd->cxlds;
> +			mds = to_cxl_memdev_state(cxlds);
> +			ret = cxl_mem_ps_set_attrs(dev, drv_data, mds,
> +						   params, param_type);
> +			if (ret)
> +				return ret;
> +		}

Maybe return here?

> +	} else {
> +		cxlmd = cxl_ps_ctx->cxlmd;
> +		cxlds = cxlmd->cxlds;
> +		mds = to_cxl_memdev_state(cxlds);
> +
> +		return cxl_mem_ps_set_attrs(dev, drv_data, mds, params, param_type);

Then indent of this hunk can drop. Similar to the case above.

> +	}
> +
> +	return 0;
> +}


