Return-Path: <linux-edac+bounces-2056-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEC599D4D7
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 18:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917681F239FE
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 16:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA7D1B4F24;
	Mon, 14 Oct 2024 16:39:04 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF55149C4A;
	Mon, 14 Oct 2024 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923944; cv=none; b=AvGiX3EhHqf+UQx9LlyYkY1CiIPYcF7BWQeCkaOUz9v2JZ20rnBF+2UyuZSgIDoKj5TTz+l196aj1EA526DMPMQrjuIONiYC+xDWY8qay47LdUH+nFFUo7LCLSmdxexgFGbAGRVZrZiIeWOzYuZSmk0aEznFvlfigMAd57P6CpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923944; c=relaxed/simple;
	bh=2JDF6PCOFCzENieguuUSYha0+anV0VrNaBNW3TdLdio=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AgBiFBjgBgEaaP4DNM5FslR97WB5fqziZCLppZEpEsgySBegoW/rjLf0kKsh91ryIsnwVzfPW3Em9zwLSlm5UgODFgNvBWstjRrokYb4QJK4XOyReliTRQjDuiw+kftw5oYLTLm5CS4zJgtOmjGdpTGbSpxbRczx9eWERTZxgfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XS2wf5jf2z6HJnN;
	Tue, 15 Oct 2024 00:38:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F13D0140C72;
	Tue, 15 Oct 2024 00:38:58 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 18:38:57 +0200
Date: Mon, 14 Oct 2024 17:38:55 +0100
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
Subject: Re: [PATCH v13 17/18] cxl/memfeature: Add CXL memory device PPR
 control feature
Message-ID: <20241014173855.0000583c@Huawei.com>
In-Reply-To: <20241009124120.1124-18-shiju.jose@huawei.com>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
	<20241009124120.1124-18-shiju.jose@huawei.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 9 Oct 2024 13:41:18 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Post Package Repair (PPR) maintenance operations may be supported by CXL
> devices that implement CXL.mem protocol. A PPR maintenance operation
> requests the CXL device to perform a repair operation on its media.
> For example, a CXL device with DRAM components that support PPR features
> may implement PPR Maintenance operations. DRAM components may support two
> types of PPR: Hard PPR (hPPR), for a permanent row repair, and Soft PPR
> (sPPR), for a temporary row repair. sPPR is much faster than hPPR, but the
> repair is lost with a power cycle.
> 
> During the execution of a PPR Maintenance operation, a CXL memory device:
> - May or may not retain data
> - May or may not be able to process CXL.mem requests correctly, including
> the ones that target the DPA involved in the repair.
> These CXL Memory Device capabilities are specified by Restriction Flags
> in the sPPR Feature and hPPR Feature.
> 
> sPPR maintenance operation may be executed at runtime, if data is retained
> and CXL.mem requests are correctly processed. For CXL devices with DRAM
> components, hPPR maintenance operation may be executed only at boot because
> data would not be retained.
> When a CXL device identifies a failure on a memory component, the device
> may inform the host about the need for a PPR maintenance operation by using
> an Event Record, where the Maintenance Needed flag is set. The Event Record
> specifies the DPA that should be repaired. A CXL device may not keep track
> of the requests that have already been sent and the information on which
> DPA should be repaired may be lost upon power cycle.
> The userspace tool requests for maintenance operation if the number of
> corrected error reported on a CXL.mem media exceeds error threshold.
> 
> CXL spec 3.1 section 8.2.9.7.1.2 describes the device's sPPR (soft PPR)
> maintenance operation and section 8.2.9.7.1.3 describes the device's
> hPPR (hard PPR) maintenance operation feature.
> 
> CXL spec 3.1 section 8.2.9.7.2.1 describes the sPPR feature discovery and
> configuration.
> 
> CXL spec 3.1 section 8.2.9.7.2.2 describes the hPPR feature discovery and
> configuration.
> 
> Add support for controlling CXL memory device PPR feature.
> Register with EDAC driver, which gets the memory repair attr descriptors
> from the EDAC memory repair driver and exposes sysfs repair control
> attributes for PRR to the userspace. For example CXL PPR control for the
> CXL mem0 device is exposed in /sys/bus/edac/devices/cxl_mem0/mem_repairX/
> 
> Tested with QEMU patch for CXL PPR feature.
> https://lore.kernel.org/all/20240730045722.71482-1-dave@stgolabs.net/
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Trivial comments inline.  This description should call out that initial
support is sPPR only, though hPPR is very easy to add.

Jonathan

> ---
>  drivers/cxl/core/memfeature.c | 335 +++++++++++++++++++++++++++++++++-
>  1 file changed, 329 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/memfeature.c b/drivers/cxl/core/memfeature.c
> index 567406566c77..a0c9a6bd73c0 100644
> --- a/drivers/cxl/core/memfeature.c
> +++ b/drivers/cxl/core/memfeature.c
> @@ -18,8 +18,9 @@
>  #include <linux/limits.h>
>  #include <cxl.h>
>  #include <linux/edac.h>
> +#include "core.h"
>  
> -#define CXL_DEV_NUM_RAS_FEATURES	2
> +#define CXL_DEV_NUM_RAS_FEATURES	3
>  #define CXL_DEV_HOUR_IN_SECS	3600
>  
>  #define CXL_SCRUB_NAME_LEN	128
> @@ -723,6 +724,294 @@ static const struct edac_ecs_ops cxl_ecs_ops = {
>  	.set_threshold = cxl_ecs_set_threshold,
>  };
>  
> +/* CXL memory soft PPR & hard PPR control definitions */
Add some specification references for the various structures
etc.

> +static const uuid_t cxl_sppr_uuid =
> +	UUID_INIT(0x892ba475, 0xfad8, 0x474e, 0x9d, 0x3e, 0x69, 0x2c, 0x91,     \
> +		  0x75, 0x68, 0xbb);
> +
> +static const uuid_t cxl_hppr_uuid =
> +	UUID_INIT(0x80ea4521, 0x786f, 0x4127, 0xaf, 0xb1, 0xec, 0x74, 0x59,     \
> +		  0xfb, 0x0e, 0x24);
> +

> +#define CXL_MEMDEV_PPR_DEVICE_INITIATED_MASK BIT(0)
> +#define CXL_MEMDEV_PPR_FLAG_DPA_SUPPORT_MASK BIT(0)
> +#define CXL_MEMDEV_PPR_FLAG_NIBBLE_SUPPORT_MASK BIT(1)
> +#define CXL_MEMDEV_PPR_FLAG_MEM_SPARING_EV_REC_SUPPORT_MASK BIT(2)
> +
> +#define CXL_MEMDEV_PPR_RESTRICTION_FLAG_MEDIA_ACCESSIBLE_MASK BIT(0)
> +#define CXL_MEMDEV_PPR_RESTRICTION_FLAG_DATA_RETAINED_MASK BIT(2)
> +
> +#define CXL_MEMDEV_PPR_SPARING_EV_REC_EN_MASK BIT(0)
> +
> +struct cxl_memdev_ppr_rd_attrs {
> +	u8 max_op_latency;
> +	__le16 op_cap;
> +	__le16 op_mode;
> +	u8 op_class;
> +	u8 op_subclass;
> +	u8 rsvd[9];

Down to here is the common header. Maybe break that out as a separate
structure as we will get more maintenance features.
Also makes the spec reference simpler as some of the flags are
in the generic part (the device initiated one)


> +	u8 ppr_flags;
> +	__le16 restriction_flags;
> +	u8 ppr_op_mode;
> +}  __packed;
> +


> +
> +static int cxl_do_query_ppr(struct device *dev, void *drv_data)
> +{
> +	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
> +
> +	if (!cxl_ppr_ctx->dpa)
> +		return -EINVAL;
> +
> +	return cxl_mem_ppr_set_attrs(dev, drv_data, CXL_PPR_PARAM_DO_QUERY);
> +}
> +
> +static int cxl_do_ppr(struct device *dev, void *drv_data)
> +{
> +	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
> +	int ret;
> +
> +	if (!cxl_ppr_ctx->dpa)
> +		return -EINVAL;

blank line here (as in do_query above)

> +	ret = cxl_mem_ppr_set_attrs(dev, drv_data, CXL_PPR_PARAM_DO_PPR);
> +
> +	return ret;
return cxl_mem_ppr_set_attrs()

> +}



