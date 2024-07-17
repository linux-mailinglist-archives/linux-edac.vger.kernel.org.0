Return-Path: <linux-edac+bounces-1536-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2101B933D5D
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jul 2024 15:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445551C23199
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jul 2024 13:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BFF1802A7;
	Wed, 17 Jul 2024 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD3vorJU"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539A26FC7;
	Wed, 17 Jul 2024 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721221699; cv=none; b=cF7Fhx+BmijiQG4Kw6E0FiaPcvvrV0E/uK1DDF6T7kDLNAgkvQmsBVSOqGN6evZ4GOkrGVTAwwq2VX5+WLCgEDShXgX8duV3iRC2pJj+dDKmltozD15FsrTV8lAtWKBLYPfI4wCw2IMpXzeQRtzUqNjZrBz6S8lBJj6WgUIBAP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721221699; c=relaxed/simple;
	bh=k3720juOhnRd/ZG9JvQtXh8lx9+/XF03JrXIdTvq5gE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1hDWEX4T27Lgs+tNQAO6YIlkKakA4Z1OJF8F6EUWxEuV18QqC863SGLIE1uEMWBjsT+adPOvRQ69WSMLU7R+NNiXlHHLdXf9XCCNs07AgtG8v62Boqn8PbaxLBKMrBCVGhsVcWbbic1kavb0s/UwYyUBF5BhUYaHC7b5w7qiK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iD3vorJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029B3C32782;
	Wed, 17 Jul 2024 13:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721221698;
	bh=k3720juOhnRd/ZG9JvQtXh8lx9+/XF03JrXIdTvq5gE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iD3vorJU1yTZZWpHNFxZipQJE8j3soAxob/gNdtQU9vADwYpFcnNlYaK3dR2Z5/qB
	 KsGhoR9TfzR9ShmGS2ZwrsgjKXYcrrPedI81ofzAiP1unhGy8kqqVC/jwz0yhRZldo
	 Y13TYwbh5H1YcVKL97atz6CBjv8OzzXa6c89+FabaAiICKM26Ws3jGwKCWa9z7hPRh
	 VPLyzeBmBTZNnzMpqcukmaKhecaV4TAzZaNiE6zxlnC31hGvWlG/9aaL9hY1VuQn1M
	 /ztyGw/lo/UY9BLFGlnuWnZHfeLYrpMtwDxMRl7ZqfC6L6jluZP/iuIBm4sw9vHeKW
	 pYXXT3MVaLDHg==
Date: Wed, 17 Jul 2024 15:08:07 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: <shiju.jose@huawei.com>
Cc: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
 <rafael@kernel.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
 <dan.j.williams@intel.com>, <dave@stgolabs.net>,
 <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
 <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
 <ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>,
 <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
 <jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
 <naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
 <somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
 <duenwen@google.com>, <mike.malvestuto@intel.com>, <gthelen@google.com>,
 <wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
 <wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>,
 <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
 <roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
 <wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [RFC PATCH v9 03/11] EDAC: Add EDAC ECS control driver
Message-ID: <20240717150807.70c9ef90@foz.lan>
In-Reply-To: <20240716150336.2042-4-shiju.jose@huawei.com>
References: <20240716150336.2042-1-shiju.jose@huawei.com>
	<20240716150336.2042-4-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 16 Jul 2024 16:03:27 +0100
<shiju.jose@huawei.com> escreveu:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add EDAC ECS (Error Check Scrub) control driver supports configuring
> the memory device's ECS feature.
> 
> The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
> Specification (JESD79-5) and allows the DRAM to internally read, correct
> single-bit errors, and write back corrected data bits to the DRAM array
> while providing transparency to error counts.
> 
> The DDR5 device contains number of memory media FRUs per device. The
> DDR5 ECS feature and thus the ECS control driver supports configuring
> the ECS parameters per FRU.
> 
> The memory devices supports ECS feature register with the EDAC ECS driver

typo:
	supports -> support

> and thus with the generic EDAC RAS feature driver, which adds the sysfs
> ECS control interface. The ECS control attributes are exposed to the
> userspace in /sys/bus/edac/devices/<dev-name>/ecs_fruX/.
> 
> Generic EDAC ECS driver and the common sysfs ECS interface promotes
> unambiguous control from the userspace irrespective of the underlying
> devices, support ECS feature.
> 
> The support for ECS feature is added separately because the DDR5 ECS
> feature's control attributes are dissimilar from those of the scrub
> feature.
> 
> Note: Documentation can be added if necessary.

Please document.

> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/edac/Makefile            |   2 +-
>  drivers/edac/edac_ecs.c          | 396 +++++++++++++++++++++++++++++++
>  drivers/edac/edac_ras_feature.c  |   5 +
>  include/linux/edac_ras_feature.h |  36 +++
>  4 files changed, 438 insertions(+), 1 deletion(-)
>  create mode 100755 drivers/edac/edac_ecs.c
> 
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index de56cbd039eb..c1412c7d3efb 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -10,7 +10,7 @@ obj-$(CONFIG_EDAC)			:= edac_core.o
>  
>  edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
>  edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o
> -edac_core-y	+= edac_ras_feature.o edac_scrub.o
> +edac_core-y	+= edac_ras_feature.o edac_scrub.o edac_ecs.o
>  
>  edac_core-$(CONFIG_EDAC_DEBUG)		+= debugfs.o
>  
> diff --git a/drivers/edac/edac_ecs.c b/drivers/edac/edac_ecs.c
> new file mode 100755
> index 000000000000..37dabd053c36
> --- /dev/null
> +++ b/drivers/edac/edac_ecs.c
> @@ -0,0 +1,396 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ECS driver supporting controlling on die error check scrub
> + * (e.g. DDR5 ECS). The common sysfs ECS interface promotes
> + * unambiguous access from the userspace.
> + *
> + * Copyright (c) 2024 HiSilicon Limited.
> + */
> +
> +#define pr_fmt(fmt)     "EDAC ECS: " fmt
> +
> +#include <linux/edac_ras_feature.h>
> +
> +#define EDAC_ECS_FRU_NAME "ecs_fru"
> +
> +enum edac_ecs_attributes {
> +	ecs_log_entry_type,
> +	ecs_log_entry_type_per_dram,
> +	ecs_log_entry_type_per_memory_media,
> +	ecs_mode,
> +	ecs_mode_counts_rows,
> +	ecs_mode_counts_codewords,
> +	ecs_reset,
> +	ecs_name,
> +	ecs_threshold,
> +	ecs_max_attrs
> +};

Please use uppercase for enums.

> +
> +struct edac_ecs_dev_attr {
> +	struct device_attribute dev_attr;
> +	int fru_id;
> +};
> +
> +struct edac_ecs_fru_context {
> +	char name[EDAC_RAS_NAME_LEN];
> +	struct edac_ecs_dev_attr ecs_dev_attr[ecs_max_attrs];
> +	struct attribute *ecs_attrs[ecs_max_attrs + 1];
> +	struct attribute_group group;
> +};
> +
> +struct edac_ecs_context {
> +	u16 num_media_frus;
> +	struct edac_ecs_fru_context *fru_ctxs;
> +};
> +
> +#define to_ecs_dev_attr(_dev_attr)	\
> +	container_of(_dev_attr, struct edac_ecs_dev_attr, dev_attr)
> +
> +static ssize_t log_entry_type_show(struct device *ras_feat_dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ops;
> +	u64 val;
> +	int ret;
> +
> +	ret = ops->get_log_entry_type(ras_feat_dev->parent, ctx->ecs.private,
> +				      ecs_dev_attr->fru_id, &val);
> +	if (ret)
> +		return ret;

Same notes as patch 2/11 with regards to sysfs documentation/store/show.

Also, it is hard to review this patch without the ABI documentation.

Regards,
Mauro

Thanks,
Mauro

