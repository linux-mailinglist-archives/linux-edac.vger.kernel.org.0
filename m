Return-Path: <linux-edac+bounces-3780-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 482E8A9FA46
	for <lists+linux-edac@lfdr.de>; Mon, 28 Apr 2025 22:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5006C3B9811
	for <lists+linux-edac@lfdr.de>; Mon, 28 Apr 2025 20:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB177297A5C;
	Mon, 28 Apr 2025 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWWUMq7K"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385681A7262;
	Mon, 28 Apr 2025 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745871257; cv=none; b=cMJIJ5M2kThpymuLFvekyIlb82Ib26uq3M2FnuKLP4moHFcmZOPPbLWr/SzSZXowJ3P+588Yxjc+7r2TaV2bBofwx3kjReRzxViuAg+NsBhxR3i2B3v9xcsVqSq/UUXSzaiWx9XTHDMQPuN/sH+DTdEL19wZP7JKXncDJzKBVpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745871257; c=relaxed/simple;
	bh=jTWbJb+lEXQZP9dnjw7jiyRsnqeUGH8qRZ0vzYVWEec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+HTn5JvYG4iGsCp1PQJrlXoyyY5+XeZsenxC4zuvKtNWbf+TdaYL6nKfy+Cm6Ae62iE1LfvVsDM+oqhssWajMRp1Lt+0Mkj9ukvZ/GyjRrqg8r9z+WRoIg28pxpjYO6jPZUKbRJ3bHe5DC97D6Jg6jL4+XPWvvzPZ6RRKolSyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NWWUMq7K; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745871255; x=1777407255;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jTWbJb+lEXQZP9dnjw7jiyRsnqeUGH8qRZ0vzYVWEec=;
  b=NWWUMq7K9qdbIZyn4+uf3xufMPSM5Z/U+VppaqcO/cRSqxedp8/yM3uZ
   8GwNTNXTsV7zNyWnG6biPywhav22DDllCL2a5Bb975ayqk9gYmDltyLxP
   mPTBey6K5rEd5Rx0F6nA5t+DpFbCyO2EnplN910u2eu7Zzz/zjojGrSBa
   uf5hr4vXd0Vr3qIPzBc0qP40dGpN8rh+umxKA/MU7TCTzJAVQ4u/RPozM
   k2VjqivSiJc7glZI5+uOpPdITFgp8acpJyfOmoyT36LNbEgKKiseq8i8B
   Hp6jpRzFVvpUAyGuNvpve9HJ/sHYQxdx5Ez65DuMMDZ/O/Ikyrir9gurN
   g==;
X-CSE-ConnectionGUID: Zru+8fLyScSoO7UP3IyTHg==
X-CSE-MsgGUID: DsznE3CmRr+FPC2DLomSSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58846869"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="58846869"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 13:14:14 -0700
X-CSE-ConnectionGUID: c/7z4qTIShW5Dg7RTuDTSA==
X-CSE-MsgGUID: cd+Ds/M0TBikqrJ2DthBIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="164579332"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.95]) ([10.125.109.95])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 13:14:13 -0700
Message-ID: <0f6fd481-4a74-4461-b6a1-49a45d4e5d55@intel.com>
Date: Mon, 28 Apr 2025 13:14:12 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] cxl/edac: Add CXL memory device ECS control
 feature
To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com, jonathan.cameron@huawei.com, dave@stgolabs.net,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com
Cc: linux-edac@vger.kernel.org, linux-doc@vger.kernel.org, bp@alien8.de,
 tony.luck@intel.com, lenb@kernel.org, leo.duran@amd.com,
 Yazen.Ghannam@amd.com, mchehab@kernel.org, nifan.cxl@gmail.com,
 linuxarm@huawei.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
 roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
 wanghuiqiang@huawei.com
References: <20250407174920.625-1-shiju.jose@huawei.com>
 <20250407174920.625-5-shiju.jose@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250407174920.625-5-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/7/25 10:49 AM, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.2 section 8.2.10.9.11.2 describes the DDR5 ECS (Error Check
> Scrub) control feature.
> The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
> Specification (JESD79-5) and allows the DRAM to internally read, correct
> single-bit errors, and write back corrected data bits to the DRAM array
> while providing transparency to error counts.
> 
> The ECS control allows the requester to change the log entry type, the ECS
> threshold count (provided the request falls within the limits specified in
> DDR5 mode registers), switch between codeword mode and row count mode, and
> reset the ECS counter.
> 
> Register with EDAC device driver, which retrieves the ECS attribute
> descriptors from the EDAC ECS and exposes the ECS control attributes to
> userspace via sysfs. For example, the ECS control for the memory media FRU0
> in CXL mem0 device is located at /sys/bus/edac/devices/cxl_mem0/ecs_fru0/
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/Kconfig     |  17 ++
>  drivers/cxl/core/edac.c | 363 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 378 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index af72416edcd4..51987f2a2548 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -147,6 +147,23 @@ config CXL_EDAC_SCRUB
>  	  (e.g. scrub rates for the patrol scrub feature).
>  	  Otherwise say 'n'.
>  
> +config CXL_EDAC_ECS
> +	bool "Enable CXL Error Check Scrub (Repair)"
> +	depends on CXL_EDAC_MEM_FEATURES
> +	depends on EDAC_ECS
> +	help
> +	  The CXL EDAC ECS control is optional and allows host to
> +	  control the ECS feature configurations of CXL memory expander
> +	  devices.
> +
> +	  When enabled 'cxl_mem' EDAC devices are published with memory
> +	  ECS control attributes as described by
> +	  Documentation/ABI/testing/sysfs-edac-ecs.
> +
> +	  Say 'y' if you have an expert need to change default settings
> +	  of a memory ECS feature established by the platform/device.
> +	  Otherwise say 'n'.
> +
>  config CXL_PORT
>  	default CXL_BUS
>  	tristate
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 3a4f9ed726d3..a624fc90caf9 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -19,7 +19,7 @@
>  #include <cxlmem.h>
>  #include "core.h"
>  
> -#define CXL_NR_EDAC_DEV_FEATURES 1
> +#define CXL_NR_EDAC_DEV_FEATURES 2
>  
>  #ifdef CONFIG_CXL_EDAC_SCRUB
>  struct cxl_patrol_scrub_context {
> @@ -441,11 +441,361 @@ static int cxl_region_scrub_init(struct cxl_region *cxlr,
>  }
>  #endif /* CONFIG_CXL_EDAC_SCRUB */
>  
> +#ifdef CONFIG_CXL_EDAC_ECS
> +struct cxl_ecs_context {
> +	u16 num_media_frus;
> +	u16 get_feat_size;
> +	u16 set_feat_size;
> +	u8 get_version;
> +	u8 set_version;
> +	u16 effects;
> +	struct cxl_memdev *cxlmd;
> +};
> +
> +/*
> + * See CXL spec rev 3.2 @8.2.10.9.11.2 Table 8-225 DDR5 ECS Control Feature
> + * Readable Attributes.
> + */
> +struct cxl_ecs_fru_rd_attrbs {
> +	u8 ecs_cap;
> +	__le16 ecs_config;
> +	u8 ecs_flags;
> +} __packed;
> +
> +struct cxl_ecs_rd_attrbs {
> +	u8 ecs_log_cap;
> +	struct cxl_ecs_fru_rd_attrbs fru_attrbs[];
> +} __packed;
> +
> +/*
> + * See CXL spec rev 3.2 @8.2.10.9.11.2 Table 8-226 DDR5 ECS Control Feature
> + * Writable Attributes.
> + */
> +struct cxl_ecs_fru_wr_attrbs {
> +	__le16 ecs_config;
> +} __packed;
> +
> +struct cxl_ecs_wr_attrbs {
> +	u8 ecs_log_cap;
> +	struct cxl_ecs_fru_wr_attrbs fru_attrbs[];
> +} __packed;
> +
> +#define CXL_ECS_LOG_ENTRY_TYPE_MASK GENMASK(1, 0)
> +#define CXL_ECS_REALTIME_REPORT_CAP_MASK BIT(0)
> +#define CXL_ECS_THRESHOLD_COUNT_MASK GENMASK(2, 0)
> +#define CXL_ECS_COUNT_MODE_MASK BIT(3)
> +#define CXL_ECS_RESET_COUNTER_MASK BIT(4)
> +#define CXL_ECS_RESET_COUNTER 1
> +
> +enum {
> +	ECS_THRESHOLD_256 = 256,
> +	ECS_THRESHOLD_1024 = 1024,
> +	ECS_THRESHOLD_4096 = 4096,
> +};
> +
> +enum {
> +	ECS_THRESHOLD_IDX_256 = 3,
> +	ECS_THRESHOLD_IDX_1024 = 4,
> +	ECS_THRESHOLD_IDX_4096 = 5,
> +};
> +
> +static const u16 ecs_supp_threshold[] = {
> +	[ECS_THRESHOLD_IDX_256] = 256,
> +	[ECS_THRESHOLD_IDX_1024] = 1024,
> +	[ECS_THRESHOLD_IDX_4096] = 4096,
> +};
> +
> +enum {
> +	ECS_LOG_ENTRY_TYPE_DRAM = 0x0,
> +	ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU = 0x1,
> +};
> +
> +enum cxl_ecs_count_mode {
> +	ECS_MODE_COUNTS_ROWS = 0,
> +	ECS_MODE_COUNTS_CODEWORDS = 1,
> +};
> +
> +static int cxl_mem_ecs_get_attrbs(struct device *dev,
> +				  struct cxl_ecs_context *cxl_ecs_ctx,
> +				  int fru_id, u8 *log_cap, u16 *config)
> +{
> +	struct cxl_memdev *cxlmd = cxl_ecs_ctx->cxlmd;
> +	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> +	struct cxl_ecs_fru_rd_attrbs *fru_rd_attrbs;
> +	size_t rd_data_size;
> +	size_t data_size;
> +
> +	rd_data_size = cxl_ecs_ctx->get_feat_size;
> +
> +	struct cxl_ecs_rd_attrbs *rd_attrbs __free(kvfree) =
> +		kvzalloc(rd_data_size, GFP_KERNEL);
> +	if (!rd_attrbs)
> +		return -ENOMEM;
> +
> +	data_size = cxl_get_feature(cxl_mbox, &CXL_FEAT_ECS_UUID,
> +				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
> +				    rd_data_size, 0, NULL);
> +	if (!data_size)
> +		return -EIO;
> +
> +	fru_rd_attrbs = rd_attrbs->fru_attrbs;
> +	*log_cap = rd_attrbs->ecs_log_cap;
> +	*config = le16_to_cpu(fru_rd_attrbs[fru_id].ecs_config);
> +
> +	return 0;
> +}
> +
> +static int cxl_mem_ecs_set_attrbs(struct device *dev,
> +				  struct cxl_ecs_context *cxl_ecs_ctx,
> +				  int fru_id, u8 log_cap, u16 config)
> +{
> +	struct cxl_memdev *cxlmd = cxl_ecs_ctx->cxlmd;
> +	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> +	struct cxl_ecs_fru_rd_attrbs *fru_rd_attrbs;
> +	struct cxl_ecs_fru_wr_attrbs *fru_wr_attrbs;
> +	size_t rd_data_size, wr_data_size;
> +	u16 num_media_frus, count;
> +	size_t data_size;
> +
> +	num_media_frus = cxl_ecs_ctx->num_media_frus;
> +	rd_data_size = cxl_ecs_ctx->get_feat_size;
> +	wr_data_size = cxl_ecs_ctx->set_feat_size;
> +	struct cxl_ecs_rd_attrbs *rd_attrbs __free(kvfree) =
> +		kvzalloc(rd_data_size, GFP_KERNEL);
> +	if (!rd_attrbs)
> +		return -ENOMEM;
> +
> +	data_size = cxl_get_feature(cxl_mbox, &CXL_FEAT_ECS_UUID,
> +				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
> +				    rd_data_size, 0, NULL);
> +	if (!data_size)
> +		return -EIO;
> +
> +	struct cxl_ecs_wr_attrbs *wr_attrbs __free(kvfree) =
> +		kvzalloc(wr_data_size, GFP_KERNEL);
> +	if (!wr_attrbs)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Fill writable attributes from the current attributes read
> +	 * for all the media FRUs.
> +	 */
> +	fru_rd_attrbs = rd_attrbs->fru_attrbs;
> +	fru_wr_attrbs = wr_attrbs->fru_attrbs;
> +	wr_attrbs->ecs_log_cap = log_cap;
> +	for (count = 0; count < num_media_frus; count++)
> +		fru_wr_attrbs[count].ecs_config =
> +			fru_rd_attrbs[count].ecs_config;
> +
> +	fru_wr_attrbs[fru_id].ecs_config = cpu_to_le16(config);
> +
> +	return cxl_set_feature(cxl_mbox, &CXL_FEAT_ECS_UUID,
> +			       cxl_ecs_ctx->set_version, wr_attrbs,
> +			       wr_data_size,
> +			       CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET,
> +			       0, NULL);
> +}
> +
> +static u8 cxl_get_ecs_log_entry_type(u8 log_cap, u16 config)
> +{
> +	return FIELD_GET(CXL_ECS_LOG_ENTRY_TYPE_MASK, log_cap);
> +}
> +
> +static u16 cxl_get_ecs_threshold(u8 log_cap, u16 config)
> +{
> +	u8 index = FIELD_GET(CXL_ECS_THRESHOLD_COUNT_MASK, config);
> +
> +	return ecs_supp_threshold[index];
> +}
> +
> +static u8 cxl_get_ecs_count_mode(u8 log_cap, u16 config)
> +{
> +	return FIELD_GET(CXL_ECS_COUNT_MODE_MASK, config);
> +}
> +
> +#define CXL_ECS_GET_ATTR(attrb)						    \
> +	static int cxl_ecs_get_##attrb(struct device *dev, void *drv_data,  \
> +				       int fru_id, u32 *val)		    \
> +	{								    \
> +		struct cxl_ecs_context *ctx = drv_data;			    \
> +		u8 log_cap;						    \
> +		u16 config;						    \
> +		int ret;						    \
> +									    \
> +		ret = cxl_mem_ecs_get_attrbs(dev, ctx, fru_id, &log_cap,    \
> +					     &config);			    \
> +		if (ret)						    \
> +			return ret;					    \
> +									    \
> +		*val = cxl_get_ecs_##attrb(log_cap, config);		    \
> +									    \
> +		return 0;						    \
> +	}
> +
> +CXL_ECS_GET_ATTR(log_entry_type)
> +CXL_ECS_GET_ATTR(count_mode)
> +CXL_ECS_GET_ATTR(threshold)
> +
> +static int cxl_set_ecs_log_entry_type(struct device *dev, u8 *log_cap,
> +				      u16 *config, u32 val)
> +{
> +	if (val != ECS_LOG_ENTRY_TYPE_DRAM &&
> +	    val != ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU)
> +		return -EINVAL;
> +
> +	*log_cap = FIELD_PREP(CXL_ECS_LOG_ENTRY_TYPE_MASK, val);
> +
> +	return 0;
> +}
> +
> +static int cxl_set_ecs_threshold(struct device *dev, u8 *log_cap, u16 *config,
> +				 u32 val)
> +{
> +	*config &= ~CXL_ECS_THRESHOLD_COUNT_MASK;
> +
> +	switch (val) {
> +	case ECS_THRESHOLD_256:
> +		*config |= FIELD_PREP(CXL_ECS_THRESHOLD_COUNT_MASK,
> +				      ECS_THRESHOLD_IDX_256);
> +		break;
> +	case ECS_THRESHOLD_1024:
> +		*config |= FIELD_PREP(CXL_ECS_THRESHOLD_COUNT_MASK,
> +				      ECS_THRESHOLD_IDX_1024);
> +		break;
> +	case ECS_THRESHOLD_4096:
> +		*config |= FIELD_PREP(CXL_ECS_THRESHOLD_COUNT_MASK,
> +				      ECS_THRESHOLD_IDX_4096);
> +		break;
> +	default:
> +		dev_dbg(dev, "Invalid CXL ECS threshold count(%d) to set\n",
> +			val);
> +		dev_dbg(dev, "Supported ECS threshold counts: %u, %u, %u\n",
> +			ECS_THRESHOLD_256, ECS_THRESHOLD_1024,
> +			ECS_THRESHOLD_4096);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_set_ecs_count_mode(struct device *dev, u8 *log_cap, u16 *config,
> +				  u32 val)
> +{
> +	if (val != ECS_MODE_COUNTS_ROWS && val != ECS_MODE_COUNTS_CODEWORDS) {
> +		dev_dbg(dev, "Invalid CXL ECS scrub mode(%d) to set\n", val);
> +		dev_dbg(dev,
> +			"Supported ECS Modes: 0: ECS counts rows with errors,"
> +			" 1: ECS counts codewords with errors\n");
> +		return -EINVAL;
> +	}
> +
> +	*config &= ~CXL_ECS_COUNT_MODE_MASK;
> +	*config |= FIELD_PREP(CXL_ECS_COUNT_MODE_MASK, val);
> +
> +	return 0;
> +}
> +
> +static int cxl_set_ecs_reset_counter(struct device *dev, u8 *log_cap,
> +				     u16 *config, u32 val)
> +{
> +	if (val != CXL_ECS_RESET_COUNTER)
> +		return -EINVAL;
> +
> +	*config &= ~CXL_ECS_RESET_COUNTER_MASK;
> +	*config |= FIELD_PREP(CXL_ECS_RESET_COUNTER_MASK, val);
> +
> +	return 0;
> +}
> +
> +#define CXL_ECS_SET_ATTR(attrb)						    \
> +	static int cxl_ecs_set_##attrb(struct device *dev, void *drv_data,  \
> +					int fru_id, u32 val)		    \
> +	{								    \
> +		struct cxl_ecs_context *ctx = drv_data;			    \
> +		u8 log_cap;						    \
> +		u16 config;						    \
> +		int ret;						    \
> +									    \
> +		if (!capable(CAP_SYS_RAWIO))				    \
> +			return -EPERM;					    \
> +									    \
> +		ret = cxl_mem_ecs_get_attrbs(dev, ctx, fru_id, &log_cap,    \
> +					     &config);			    \
> +		if (ret)						    \
> +			return ret;					    \
> +									    \
> +		ret = cxl_set_ecs_##attrb(dev, &log_cap, &config, val);     \
> +		if (ret)						    \
> +			return ret;					    \
> +									    \
> +		return cxl_mem_ecs_set_attrbs(dev, ctx, fru_id, log_cap,    \
> +					      config);			    \
> +	}
> +CXL_ECS_SET_ATTR(log_entry_type)
> +CXL_ECS_SET_ATTR(count_mode)
> +CXL_ECS_SET_ATTR(reset_counter)
> +CXL_ECS_SET_ATTR(threshold)
> +
> +static const struct edac_ecs_ops cxl_ecs_ops = {
> +	.get_log_entry_type = cxl_ecs_get_log_entry_type,
> +	.set_log_entry_type = cxl_ecs_set_log_entry_type,
> +	.get_mode = cxl_ecs_get_count_mode,
> +	.set_mode = cxl_ecs_set_count_mode,
> +	.reset = cxl_ecs_set_reset_counter,
> +	.get_threshold = cxl_ecs_get_threshold,
> +	.set_threshold = cxl_ecs_set_threshold,
> +};
> +
> +static int cxl_memdev_ecs_init(struct cxl_memdev *cxlmd,
> +			       struct edac_dev_feature *ras_feature)
> +{
> +	struct cxl_ecs_context *cxl_ecs_ctx;
> +	struct cxl_feat_entry *feat_entry;
> +	int num_media_frus;
> +
> +	feat_entry =
> +		cxl_feature_info(to_cxlfs(cxlmd->cxlds), &CXL_FEAT_ECS_UUID);
> +	if (!feat_entry)
> +		return -EOPNOTSUPP;
> +
> +	if (!(le32_to_cpu(feat_entry->flags) & CXL_FEATURE_F_CHANGEABLE))
> +		return -EOPNOTSUPP;
> +
> +	num_media_frus = (le16_to_cpu(feat_entry->get_feat_size) -
> +			  sizeof(struct cxl_ecs_rd_attrbs)) /
> +			 sizeof(struct cxl_ecs_fru_rd_attrbs);
> +	if (!num_media_frus)
> +		return -EOPNOTSUPP;
> +
> +	cxl_ecs_ctx =
> +		devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ecs_ctx), GFP_KERNEL);
> +	if (!cxl_ecs_ctx)
> +		return -ENOMEM;
> +
> +	*cxl_ecs_ctx = (struct cxl_ecs_context){
> +		.get_feat_size = le16_to_cpu(feat_entry->get_feat_size),
> +		.set_feat_size = le16_to_cpu(feat_entry->set_feat_size),
> +		.get_version = feat_entry->get_feat_ver,
> +		.set_version = feat_entry->set_feat_ver,
> +		.effects = le16_to_cpu(feat_entry->effects),
> +		.num_media_frus = num_media_frus,
> +		.cxlmd = cxlmd,
> +	};
> +
> +	ras_feature->ft_type = RAS_FEAT_ECS;
> +	ras_feature->ecs_ops = &cxl_ecs_ops;
> +	ras_feature->ctx = cxl_ecs_ctx;
> +	ras_feature->ecs_info.num_media_frus = num_media_frus;
> +
> +	return 0;
> +}
> +#endif /* CONFIG_CXL_EDAC_ECS */
> +
>  int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
>  {
>  	struct edac_dev_feature ras_features[CXL_NR_EDAC_DEV_FEATURES];
>  	int num_ras_features = 0;
> -#if defined(CONFIG_CXL_EDAC_SCRUB)
> +#if defined(CONFIG_CXL_EDAC_SCRUB) || defined(CONFIG_CXL_EDAC_ECS)
>  	int rc;
>  #endif
>  
> @@ -458,6 +808,15 @@ int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
>  		num_ras_features++;
>  #endif
>  
> +#ifdef CONFIG_CXL_EDAC_ECS
> +	rc = cxl_memdev_ecs_init(cxlmd, &ras_features[num_ras_features]);
> +	if (rc < 0 && rc != -EOPNOTSUPP)
> +		return rc;
> +
> +	if (rc != -EOPNOTSUPP)
> +		num_ras_features++;
> +#endif
> +
>  	char *cxl_dev_name __free(kfree) =
>  		kasprintf(GFP_KERNEL, "cxl_%s", dev_name(&cxlmd->dev));
>  	if (!cxl_dev_name)


