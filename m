Return-Path: <linux-edac+bounces-3856-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5661AAEC07
	for <lists+linux-edac@lfdr.de>; Wed,  7 May 2025 21:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F961C46215
	for <lists+linux-edac@lfdr.de>; Wed,  7 May 2025 19:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC2328DF4C;
	Wed,  7 May 2025 19:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQ+e1aCK"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6D9211278;
	Wed,  7 May 2025 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746645213; cv=none; b=SNij9cvKlhGL7Uovzan5EeQPPOqA+l6VI1WyQSjdasjLBP4NMDjL+FIYgQ6Ho5BuIvPAvnlBZYRYu40rOtcXvAoaE1kCgIpjAr6UJkDwkZxiuNkUfKZmnkcs9T/DYVhwKupR3l26I7ebyxHCjzKTsRoHkhcx1smBr3U1cSDqs/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746645213; c=relaxed/simple;
	bh=fYeOclt3zNcak9bYKpyuSP+QsZjo1hf2ZWvAqD9+c3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DpATyg7iNS1ku1bZz9V4QIAeNS6H6KoERCvvsGOI9kFC7JnKuTZBWtfz/fhdxO/Y2KNuOSosacS9PJMABdqsfwnb+jeigS9rmKpRBa3+usNJjSieEVevtc9bnXtL+ugdIEniDQgS960QSG+txawhulBbsraug4bg0GYmjWfRSlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQ+e1aCK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746645211; x=1778181211;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fYeOclt3zNcak9bYKpyuSP+QsZjo1hf2ZWvAqD9+c3I=;
  b=mQ+e1aCK9y3Y5oevKSJgJ0NT3g/ucELsbvczgmr7igS2QBUicQ6XsGZa
   xRXxEdGI61C0htYaB1YC6YQFS+Sax6ThJF+tLW67y9AHYbtx6i8PeRpG9
   XsG+KIxBAmABgWFLGZDFtZSY7TYjmFqJZ69VeH1Z5ypoohkBd5myXtAqi
   5s5owWN57apn9sf8o5EtQW4oJlKl3UYWPDm4G9rm9fhjWShkFV0Ck1TTZ
   rICwxWwiOMWhzbl6zG2Ji/kUOv+AFjFBmEKBavp2CUe9Is0+VZi6Fr4k7
   7i2jfCMuT2djf5lK1bF711icMIQK9bdH18w0jYemceg5zFYPFtRaqxpkz
   w==;
X-CSE-ConnectionGUID: 4y0R5FLBSRije0OMxoVeNQ==
X-CSE-MsgGUID: cQt/fWSyQ6mGGy2ZNWiLOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="65811066"
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="65811066"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 12:13:29 -0700
X-CSE-ConnectionGUID: iMJ6rn5LShiGoFncdZadTw==
X-CSE-MsgGUID: l86eNEeWROyfPBk0kCZVow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="135984836"
Received: from mgoodin-mobl2.amr.corp.intel.com (HELO [10.125.108.17]) ([10.125.108.17])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 12:13:23 -0700
Message-ID: <83f264f3-4754-4423-9814-99c37134f541@intel.com>
Date: Wed, 7 May 2025 12:13:19 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] cxl/edac: Add CXL memory device memory sparing
 control feature
To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com
Cc: linux-edac@vger.kernel.org, linux-doc@vger.kernel.org, bp@alien8.de,
 tony.luck@intel.com, lenb@kernel.org, Yazen.Ghannam@amd.com,
 mchehab@kernel.org, nifan.cxl@gmail.com, linuxarm@huawei.com,
 tanxiaofei@huawei.com, prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com
References: <20250502084517.680-1-shiju.jose@huawei.com>
 <20250502084517.680-8-shiju.jose@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250502084517.680-8-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/2/25 1:45 AM, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Memory sparing is defined as a repair function that replaces a portion of
> memory with a portion of functional memory at that same DPA. The subclasses
> for this operation vary in terms of the scope of the sparing being
> performed. The cacheline sparing subclass refers to a sparing action that
> can replace a full cacheline. Row sparing is provided as an alternative to
> PPR sparing functions and its scope is that of a single DDR row.
> As per CXL r3.2 Table 8-125 foot note 1. Memory sparing is preferred over
> PPR when possible.
> Bank sparing allows an entire bank to be replaced. Rank sparing is defined
> as an operation in which an entire DDR rank is replaced.
> 
> Memory sparing maintenance operations may be supported by CXL devices
> that implement CXL.mem protocol. A sparing maintenance operation requests
> the CXL device to perform a repair operation on its media.
> For example, a CXL device with DRAM components that support memory sparing
> features may implement sparing maintenance operations.
> 
> The host may issue a query command by setting query resources flag in the
> input payload (CXL spec 3.2 Table 8-120) to determine availability of
> sparing resources for a given address. In response to a query request,
> the device shall report the resource availability by producing the memory
> sparing event record (CXL spec 3.2 Table 8-60) in which the Channel, Rank,
> Nibble Mask, Bank Group, Bank, Row, Column, Sub-Channel fields are a copy
> of the values specified in the request.
> 
> During the execution of a sparing maintenance operation, a CXL memory
> device:
> - may not retain data
> - may not be able to process CXL.mem requests correctly.
> These CXL memory device capabilities are specified by restriction flags
> in the memory sparing feature readable attributes.
> 
> When a CXL device identifies error on a memory component, the device
> may inform the host about the need for a memory sparing maintenance
> operation by using DRAM event record, where the 'maintenance needed' flag
> may set. The event record contains some of the DPA, Channel, Rank,
> Nibble Mask, Bank Group, Bank, Row, Column, Sub-Channel fields that
> should be repaired. The userspace tool requests for maintenance operation
> if the 'maintenance needed' flag set in the CXL DRAM error record.
> 
> CXL spec 3.2 section 8.2.10.7.1.4 describes the device's memory sparing
> maintenance operation feature.
> 
> CXL spec 3.2 section 8.2.10.7.2.3 describes the memory sparing feature
> discovery and configuration.
> 
> Add support for controlling CXL memory device memory sparing feature.
> Register with EDAC driver, which gets the memory repair attr descriptors
> from the EDAC memory repair driver and exposes sysfs repair control
> attributes for memory sparing to the userspace. For example CXL memory
> sparing control for the CXL mem0 device is exposed in
> /sys/bus/edac/devices/cxl_mem0/mem_repairX/
> 
> Use case
> ========
> 1. CXL device identifies a failure in a memory component, report to
>    userspace in a CXL DRAM trace event with DPA and other attributes of
>    memory to repair such as channel, rank, nibble mask, bank Group,
>    bank, row, column, sub-channel.
> 
> 2. Rasdaemon process the trace event and may issue query request in sysfs
> check resources available for memory sparing if either of the following
> conditions met.
>  - 'maintenance needed' flag set in the event record.
>  - 'threshold event' flag set for CVME threshold feature.
>  - When the number of corrected error reported on a CXL.mem media to the
>    userspace exceeds the threshold value for corrected error count defined
>    by the userspace policy.
> 
> 3. Rasdaemon process the memory sparing trace event and issue repair
>    request for memory sparing.
> 
> Kernel CXL driver shall report memory sparing event record to the userspace
> with the resource availability in order rasdaemon to process the event
> record and issue a repair request in sysfs for the memory sparing operation
> in the CXL device.
> 
> Note: Based on the feedbacks from the community 'query' sysfs attribute is
> removed and reporting memory sparing error record to the userspace are not
> supported. Instead userspace issues sparing operation and kernel does the
> same to the CXL memory device, when 'maintenance needed' flag set in the
> DRAM event record.
> 
> Add checks to ensure the memory to be repaired is offline and if online,
> then originates from a CXL DRAM error record reported in the current boot
> before requesting a memory sparing operation on the device.
> 
> Note: Tested for memory sparing control feature with
>       "hw/cxl: Add memory sparing control feature"
>       Repository: "https://gitlab.com/shiju.jose/qemu.git"
>       Branch: cxl-ras-features-2024-10-24
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/edac/memory_repair.rst |  21 +
>  drivers/cxl/core/edac.c              | 548 ++++++++++++++++++++++++++-
>  drivers/edac/mem_repair.c            |   9 +
>  include/linux/edac.h                 |   7 +
>  4 files changed, 583 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/edac/memory_repair.rst b/Documentation/edac/memory_repair.rst
> index 52162a422864..5b1cd8297442 100644
> --- a/Documentation/edac/memory_repair.rst
> +++ b/Documentation/edac/memory_repair.rst
> @@ -119,3 +119,24 @@ sysfs
>  
>  Sysfs files are documented in
>  `Documentation/ABI/testing/sysfs-edac-memory-repair`.
> +
> +Examples
> +--------
> +
> +The memory repair usage takes the form shown in this example:
> +
> +1. CXL memory sparing
> +
> +Memory sparing is defined as a repair function that replaces a portion of
> +memory with a portion of functional memory at that same DPA. The subclass
> +for this operation, cacheline/row/bank/rank sparing, vary in terms of the
> +scope of the sparing being performed.
> +
> +Memory sparing maintenance operations may be supported by CXL devices that
> +implement CXL.mem protocol. A sparing maintenance operation requests the
> +CXL device to perform a repair operation on its media. For example, a CXL
> +device with DRAM components that support memory sparing features may
> +implement sparing maintenance operations.
> +
> +Sysfs files for memory repair are documented in
> +`Documentation/ABI/testing/sysfs-edac-memory-repair`
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 02bd4c675871..19a2e8d09b3d 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -21,7 +21,17 @@
>  #include "core.h"
>  #include "trace.h"
>  
> -#define CXL_NR_EDAC_DEV_FEATURES 2
> +#define CXL_NR_EDAC_DEV_FEATURES 6
> +
> +static bool cxl_is_memdev_memory_online(const struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *port = cxlmd->endpoint;
> +
> +	if (port && cxl_num_decoders_committed(port))
> +		return true;
> +
> +	return false;
> +}
>  
>  #ifdef CONFIG_CXL_EDAC_SCRUB
>  struct cxl_patrol_scrub_context {
> @@ -1116,13 +1126,534 @@ int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_store_rec_dram, "CXL");
> +
> +/*
> + * CXL memory sparing control
> + */
> +enum cxl_mem_sparing_granularity {
> +	CXL_MEM_SPARING_CACHELINE,
> +	CXL_MEM_SPARING_ROW,
> +	CXL_MEM_SPARING_BANK,
> +	CXL_MEM_SPARING_RANK,
> +	CXL_MEM_SPARING_MAX
> +};
> +
> +struct cxl_mem_sparing_context {
> +	struct cxl_memdev *cxlmd;
> +	uuid_t repair_uuid;
> +	u16 get_feat_size;
> +	u16 set_feat_size;
> +	u16 effects;
> +	u8 instance;
> +	u8 get_version;
> +	u8 set_version;
> +	u8 op_class;
> +	u8 op_subclass;
> +	bool cap_safe_when_in_use;
> +	bool cap_hard_sparing;
> +	bool cap_soft_sparing;
> +	u8 channel;
> +	u8 rank;
> +	u8 bank_group;
> +	u32 nibble_mask;
> +	u64 dpa;
> +	u32 row;
> +	u16 column;
> +	u8 bank;
> +	u8 sub_channel;
> +	enum edac_mem_repair_type repair_type;
> +	bool persist_mode;
> +};
> +
> +#define CXL_SPARING_RD_CAP_SAFE_IN_USE_MASK BIT(0)
> +#define CXL_SPARING_RD_CAP_HARD_SPARING_MASK BIT(1)
> +#define CXL_SPARING_RD_CAP_SOFT_SPARING_MASK BIT(2)
> +
> +#define CXL_SPARING_WR_DEVICE_INITIATED_MASK BIT(0)
> +
> +#define CXL_SPARING_QUERY_RESOURCE_FLAG BIT(0)
> +#define CXL_SET_HARD_SPARING_FLAG BIT(1)
> +#define CXL_SPARING_SUB_CHNL_VALID_FLAG BIT(2)
> +#define CXL_SPARING_NIB_MASK_VALID_FLAG BIT(3)
> +
> +#define CXL_GET_SPARING_SAFE_IN_USE(flags) \
> +	(FIELD_GET(CXL_SPARING_RD_CAP_SAFE_IN_USE_MASK, \
> +		  flags) ^ 1)
> +#define CXL_GET_CAP_HARD_SPARING(flags) \
> +	FIELD_GET(CXL_SPARING_RD_CAP_HARD_SPARING_MASK, \
> +		  flags)
> +#define CXL_GET_CAP_SOFT_SPARING(flags) \
> +	FIELD_GET(CXL_SPARING_RD_CAP_SOFT_SPARING_MASK, \
> +		  flags)
> +
> +#define CXL_SET_SPARING_QUERY_RESOURCE(val) \
> +	FIELD_PREP(CXL_SPARING_QUERY_RESOURCE_FLAG, val)
> +#define CXL_SET_HARD_SPARING(val) \
> +	FIELD_PREP(CXL_SET_HARD_SPARING_FLAG, val)
> +#define CXL_SET_SPARING_SUB_CHNL_VALID(val) \
> +	FIELD_PREP(CXL_SPARING_SUB_CHNL_VALID_FLAG, val)
> +#define CXL_SET_SPARING_NIB_MASK_VALID(val) \
> +	FIELD_PREP(CXL_SPARING_NIB_MASK_VALID_FLAG, val)
> +
> +/*
> + * See CXL spec rev 3.2 @8.2.10.7.2.3 Table 8-134 Memory Sparing Feature
> + * Readable Attributes.
> + */
> +struct cxl_memdev_repair_rd_attrbs_hdr {
> +	u8 max_op_latency;
> +	__le16 op_cap;
> +	__le16 op_mode;
> +	u8 op_class;
> +	u8 op_subclass;
> +	u8 rsvd[9];
> +} __packed;
> +
> +struct cxl_memdev_sparing_rd_attrbs {
> +	struct cxl_memdev_repair_rd_attrbs_hdr hdr;
> +	u8 rsvd;
> +	__le16 restriction_flags;
> +} __packed;
> +
> +/*
> + * See CXL spec rev 3.2 @8.2.10.7.1.4 Table 8-120 Memory Sparing Input Payload.
> + */
> +struct cxl_memdev_sparing_in_payload {
> +	u8 flags;
> +	u8 channel;
> +	u8 rank;
> +	u8 nibble_mask[3];
> +	u8 bank_group;
> +	u8 bank;
> +	u8 row[3];
> +	__le16 column;
> +	u8 sub_channel;
> +} __packed;
> +
> +static int
> +cxl_mem_sparing_get_attrbs(struct cxl_mem_sparing_context *cxl_sparing_ctx)
> +{
> +	size_t rd_data_size = sizeof(struct cxl_memdev_sparing_rd_attrbs);
> +	struct cxl_memdev *cxlmd = cxl_sparing_ctx->cxlmd;
> +	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> +	u16 restriction_flags;
> +	size_t data_size;
> +	u16 return_code;
> +	struct cxl_memdev_sparing_rd_attrbs *rd_attrbs __free(kfree) =
> +		kzalloc(rd_data_size, GFP_KERNEL);
> +	if (!rd_attrbs)
> +		return -ENOMEM;
> +
> +	data_size = cxl_get_feature(cxl_mbox, &cxl_sparing_ctx->repair_uuid,
> +				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
> +				    rd_data_size, 0, &return_code);
> +	if (!data_size)
> +		return -EIO;
> +
> +	cxl_sparing_ctx->op_class = rd_attrbs->hdr.op_class;
> +	cxl_sparing_ctx->op_subclass = rd_attrbs->hdr.op_subclass;
> +	restriction_flags = le16_to_cpu(rd_attrbs->restriction_flags);
> +	cxl_sparing_ctx->cap_safe_when_in_use =
> +		CXL_GET_SPARING_SAFE_IN_USE(restriction_flags);
> +	cxl_sparing_ctx->cap_hard_sparing =
> +		CXL_GET_CAP_HARD_SPARING(restriction_flags);
> +	cxl_sparing_ctx->cap_soft_sparing =
> +		CXL_GET_CAP_SOFT_SPARING(restriction_flags);
> +
> +	return 0;
> +}
> +
> +static struct cxl_event_dram *
> +cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
> +		     struct cxl_mem_sparing_context *ctx)
> +{
> +	struct cxl_mem_repair_attrbs attrbs = { 0 };
> +
> +	attrbs.dpa = ctx->dpa;
> +	attrbs.channel = ctx->channel;
> +	attrbs.rank = ctx->rank;
> +	attrbs.nibble_mask = ctx->nibble_mask;
> +	switch (ctx->repair_type) {
> +	case EDAC_REPAIR_CACHELINE_SPARING:
> +		attrbs.repair_type = CXL_CACHELINE_SPARING;
> +		attrbs.bank_group = ctx->bank_group;
> +		attrbs.bank = ctx->bank;
> +		attrbs.row = ctx->row;
> +		attrbs.column = ctx->column;
> +		attrbs.sub_channel = ctx->sub_channel;
> +		break;
> +	case EDAC_REPAIR_ROW_SPARING:
> +		attrbs.repair_type = CXL_ROW_SPARING;
> +		attrbs.bank_group = ctx->bank_group;
> +		attrbs.bank = ctx->bank;
> +		attrbs.row = ctx->row;
> +		break;
> +	case EDAC_REPAIR_BANK_SPARING:
> +		attrbs.repair_type = CXL_BANK_SPARING;
> +		attrbs.bank_group = ctx->bank_group;
> +		attrbs.bank = ctx->bank;
> +	break;
> +	case EDAC_REPAIR_RANK_SPARING:
> +		attrbs.repair_type = CXL_BANK_SPARING;
> +		break;
> +	default:
> +		return NULL;
> +	}
> +
> +	return cxl_find_rec_dram(cxlmd, &attrbs);
> +}
> +
> +static int
> +cxl_mem_perform_sparing(struct device *dev,
> +			struct cxl_mem_sparing_context *cxl_sparing_ctx)
> +{
> +	struct cxl_memdev *cxlmd = cxl_sparing_ctx->cxlmd;
> +	struct cxl_memdev_sparing_in_payload sparing_pi;
> +	struct cxl_event_dram *rec = NULL;
> +	u16 validity_flags = 0;
> +
> +	struct rw_semaphore *region_lock __free(rwsem_read_release) =
> +		rwsem_read_intr_acquire(&cxl_region_rwsem);
> +	if (!region_lock)
> +		return -EINTR;
> +
> +	struct rw_semaphore *dpa_lock __free(rwsem_read_release) =
> +		rwsem_read_intr_acquire(&cxl_dpa_rwsem);
> +	if (!dpa_lock)
> +		return -EINTR;
> +
> +	if (!cxl_sparing_ctx->cap_safe_when_in_use) {
> +		/* Memory to repair must be offline */
> +		if (cxl_is_memdev_memory_online(cxlmd))
> +			return -EBUSY;
> +	} else {
> +		if (cxl_is_memdev_memory_online(cxlmd)) {
> +			rec = cxl_mem_get_rec_dram(cxlmd, cxl_sparing_ctx);
> +			if (!rec)
> +				return -EINVAL;
> +
> +			if (!rec->media_hdr.validity_flags)
> +				return -EINVAL;
> +		}
> +	}
> +
> +	memset(&sparing_pi, 0, sizeof(sparing_pi));
> +	sparing_pi.flags = CXL_SET_SPARING_QUERY_RESOURCE(0);
> +	if (cxl_sparing_ctx->persist_mode)
> +		sparing_pi.flags |= CXL_SET_HARD_SPARING(1);
> +
> +	if (rec)
> +		validity_flags = get_unaligned_le16(rec->media_hdr.validity_flags);
> +
> +	switch (cxl_sparing_ctx->repair_type) {
> +	case EDAC_REPAIR_CACHELINE_SPARING:
> +		sparing_pi.column = cpu_to_le16(cxl_sparing_ctx->column);
> +		if (!rec || (validity_flags & CXL_DER_VALID_SUB_CHANNEL)) {
> +			sparing_pi.flags |= CXL_SET_SPARING_SUB_CHNL_VALID(1);
> +			sparing_pi.sub_channel = cxl_sparing_ctx->sub_channel;
> +		}
> +		fallthrough;
> +	case EDAC_REPAIR_ROW_SPARING:
> +		put_unaligned_le24(cxl_sparing_ctx->row, sparing_pi.row);
> +		fallthrough;
> +	case EDAC_REPAIR_BANK_SPARING:
> +		sparing_pi.bank_group = cxl_sparing_ctx->bank_group;
> +		sparing_pi.bank = cxl_sparing_ctx->bank;
> +		fallthrough;
> +	case EDAC_REPAIR_RANK_SPARING:
> +		sparing_pi.rank = cxl_sparing_ctx->rank;
> +		fallthrough;
> +	default:
> +		sparing_pi.channel = cxl_sparing_ctx->channel;
> +		if ((rec && (validity_flags & CXL_DER_VALID_NIBBLE)) ||
> +		    (!rec && (!cxl_sparing_ctx->nibble_mask ||
> +			     (cxl_sparing_ctx->nibble_mask & 0xFFFFFF)))) {
> +			sparing_pi.flags |= CXL_SET_SPARING_NIB_MASK_VALID(1);
> +			put_unaligned_le24(cxl_sparing_ctx->nibble_mask,
> +					   sparing_pi.nibble_mask);
> +		}
> +		break;
> +	}
> +
> +	return cxl_perform_maintenance(&cxlmd->cxlds->cxl_mbox,
> +				       cxl_sparing_ctx->op_class,
> +				       cxl_sparing_ctx->op_subclass,
> +				       &sparing_pi, sizeof(sparing_pi));
> +}
> +
> +static int cxl_mem_sparing_get_repair_type(struct device *dev, void *drv_data,
> +					   const char **repair_type)
> +{
> +	struct cxl_mem_sparing_context *ctx = drv_data;
> +
> +	switch (ctx->repair_type) {
> +	case EDAC_REPAIR_CACHELINE_SPARING:
> +	case EDAC_REPAIR_ROW_SPARING:
> +	case EDAC_REPAIR_BANK_SPARING:
> +	case EDAC_REPAIR_RANK_SPARING:
> +		*repair_type = edac_repair_type[ctx->repair_type];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +#define CXL_SPARING_GET_ATTR(attrb, data_type)			    \
> +	static int cxl_mem_sparing_get_##attrb(			    \
> +		struct device *dev, void *drv_data, data_type *val) \
> +	{							    \
> +		struct cxl_mem_sparing_context *ctx = drv_data;	    \
> +								    \
> +		*val = ctx->attrb;				    \
> +								    \
> +		return 0;					    \
> +	}
> +CXL_SPARING_GET_ATTR(persist_mode, bool)
> +CXL_SPARING_GET_ATTR(dpa, u64)
> +CXL_SPARING_GET_ATTR(nibble_mask, u32)
> +CXL_SPARING_GET_ATTR(bank_group, u32)
> +CXL_SPARING_GET_ATTR(bank, u32)
> +CXL_SPARING_GET_ATTR(rank, u32)
> +CXL_SPARING_GET_ATTR(row, u32)
> +CXL_SPARING_GET_ATTR(column, u32)
> +CXL_SPARING_GET_ATTR(channel, u32)
> +CXL_SPARING_GET_ATTR(sub_channel, u32)
> +
> +#define CXL_SPARING_SET_ATTR(attrb, data_type)					\
> +	static int cxl_mem_sparing_set_##attrb(struct device *dev,		\
> +						void *drv_data, data_type val)	\
> +	{									\
> +		struct cxl_mem_sparing_context *ctx = drv_data;			\
> +										\
> +		ctx->attrb = val;						\
> +										\
> +		return 0;							\
> +	}
> +CXL_SPARING_SET_ATTR(nibble_mask, u32)
> +CXL_SPARING_SET_ATTR(bank_group, u32)
> +CXL_SPARING_SET_ATTR(bank, u32)
> +CXL_SPARING_SET_ATTR(rank, u32)
> +CXL_SPARING_SET_ATTR(row, u32)
> +CXL_SPARING_SET_ATTR(column, u32)
> +CXL_SPARING_SET_ATTR(channel, u32)
> +CXL_SPARING_SET_ATTR(sub_channel, u32)
> +
> +static int cxl_mem_sparing_set_persist_mode(struct device *dev, void *drv_data,
> +					    bool persist_mode)
> +{
> +	struct cxl_mem_sparing_context *ctx = drv_data;
> +
> +	if ((persist_mode && ctx->cap_hard_sparing) ||
> +	    (!persist_mode && ctx->cap_soft_sparing))
> +		ctx->persist_mode = persist_mode;
> +	else
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
> +static int cxl_get_mem_sparing_safe_when_in_use(struct device *dev,
> +						void *drv_data, bool *safe)
> +{
> +	struct cxl_mem_sparing_context *ctx = drv_data;
> +
> +	*safe = ctx->cap_safe_when_in_use;
> +
> +	return 0;
> +}
> +
> +static int cxl_mem_sparing_get_min_dpa(struct device *dev, void *drv_data,
> +				       u64 *min_dpa)
> +{
> +	struct cxl_mem_sparing_context *ctx = drv_data;
> +	struct cxl_memdev *cxlmd = ctx->cxlmd;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	*min_dpa = cxlds->dpa_res.start;
> +
> +	return 0;
> +}
> +
> +static int cxl_mem_sparing_get_max_dpa(struct device *dev, void *drv_data,
> +				       u64 *max_dpa)
> +{
> +	struct cxl_mem_sparing_context *ctx = drv_data;
> +	struct cxl_memdev *cxlmd = ctx->cxlmd;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	*max_dpa = cxlds->dpa_res.end;
> +
> +	return 0;
> +}
> +
> +static int cxl_mem_sparing_set_dpa(struct device *dev, void *drv_data, u64 dpa)
> +{
> +	struct cxl_mem_sparing_context *ctx = drv_data;
> +	struct cxl_memdev *cxlmd = ctx->cxlmd;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end)
> +		return -EINVAL;
> +
> +	ctx->dpa = dpa;
> +
> +	return 0;
> +}
> +
> +static int cxl_do_mem_sparing(struct device *dev, void *drv_data, u32 val)
> +{
> +	struct cxl_mem_sparing_context *ctx = drv_data;
> +
> +	if (val != EDAC_DO_MEM_REPAIR)
> +		return -EINVAL;
> +
> +	return cxl_mem_perform_sparing(dev, ctx);
> +}
> +
> +#define RANK_OPS                                                             \
> +	.get_repair_type = cxl_mem_sparing_get_repair_type,                  \
> +	.get_persist_mode = cxl_mem_sparing_get_persist_mode,                \
> +	.set_persist_mode = cxl_mem_sparing_set_persist_mode,                \
> +	.get_repair_safe_when_in_use = cxl_get_mem_sparing_safe_when_in_use, \
> +	.get_min_dpa = cxl_mem_sparing_get_min_dpa,                          \
> +	.get_max_dpa = cxl_mem_sparing_get_max_dpa,                          \
> +	.get_dpa = cxl_mem_sparing_get_dpa,                                  \
> +	.set_dpa = cxl_mem_sparing_set_dpa,                                  \
> +	.get_nibble_mask = cxl_mem_sparing_get_nibble_mask,                  \
> +	.set_nibble_mask = cxl_mem_sparing_set_nibble_mask,                  \
> +	.get_rank = cxl_mem_sparing_get_rank,                                \
> +	.set_rank = cxl_mem_sparing_set_rank,                                \
> +	.get_channel = cxl_mem_sparing_get_channel,                          \
> +	.set_channel = cxl_mem_sparing_set_channel,                          \
> +	.do_repair = cxl_do_mem_sparing
> +
> +#define BANK_OPS                                                    \
> +	RANK_OPS, .get_bank_group = cxl_mem_sparing_get_bank_group, \
> +		.set_bank_group = cxl_mem_sparing_set_bank_group,   \
> +		.get_bank = cxl_mem_sparing_get_bank,               \
> +		.set_bank = cxl_mem_sparing_set_bank
> +
> +#define ROW_OPS                                       \
> +	BANK_OPS, .get_row = cxl_mem_sparing_get_row, \
> +		.set_row = cxl_mem_sparing_set_row
> +
> +#define CACHELINE_OPS                                               \
> +	ROW_OPS, .get_column = cxl_mem_sparing_get_column,          \
> +		.set_column = cxl_mem_sparing_set_column,           \
> +		.get_sub_channel = cxl_mem_sparing_get_sub_channel, \
> +		.set_sub_channel = cxl_mem_sparing_set_sub_channel
> +
> +static const struct edac_mem_repair_ops cxl_rank_sparing_ops = {
> +	RANK_OPS,
> +};
> +
> +static const struct edac_mem_repair_ops cxl_bank_sparing_ops = {
> +	BANK_OPS,
> +};
> +
> +static const struct edac_mem_repair_ops cxl_row_sparing_ops = {
> +	ROW_OPS,
> +};
> +
> +static const struct edac_mem_repair_ops cxl_cacheline_sparing_ops = {
> +	CACHELINE_OPS,
> +};
> +
> +struct cxl_mem_sparing_desc {
> +	const uuid_t repair_uuid;
> +	enum edac_mem_repair_type repair_type;
> +	const struct edac_mem_repair_ops *repair_ops;
> +};
> +
> +static const struct cxl_mem_sparing_desc mem_sparing_desc[] = {
> +	{
> +		.repair_uuid = CXL_FEAT_CACHELINE_SPARING_UUID,
> +		.repair_type = EDAC_REPAIR_CACHELINE_SPARING,
> +		.repair_ops = &cxl_cacheline_sparing_ops,
> +	},
> +	{
> +		.repair_uuid = CXL_FEAT_ROW_SPARING_UUID,
> +		.repair_type = EDAC_REPAIR_ROW_SPARING,
> +		.repair_ops = &cxl_row_sparing_ops,
> +	},
> +	{
> +		.repair_uuid = CXL_FEAT_BANK_SPARING_UUID,
> +		.repair_type = EDAC_REPAIR_BANK_SPARING,
> +		.repair_ops = &cxl_bank_sparing_ops,
> +	},
> +	{
> +		.repair_uuid = CXL_FEAT_RANK_SPARING_UUID,
> +		.repair_type = EDAC_REPAIR_RANK_SPARING,
> +		.repair_ops = &cxl_rank_sparing_ops,
> +	},
> +};
> +
> +static int cxl_memdev_sparing_init(struct cxl_memdev *cxlmd,
> +				   struct edac_dev_feature *ras_feature,
> +				   const struct cxl_mem_sparing_desc *desc,
> +				   u8 repair_inst)
> +{
> +	struct cxl_mem_sparing_context *cxl_sparing_ctx;
> +	struct cxl_feat_entry *feat_entry;
> +	int ret;
> +
> +	feat_entry = cxl_feature_info(to_cxlfs(cxlmd->cxlds),
> +				      &desc->repair_uuid);
> +	if (!feat_entry)
> +		return -EOPNOTSUPP;
> +
> +	if (!(le32_to_cpu(feat_entry->flags) & CXL_FEATURE_F_CHANGEABLE))
> +		return -EOPNOTSUPP;
> +
> +	cxl_sparing_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_sparing_ctx),
> +				       GFP_KERNEL);
> +	if (!cxl_sparing_ctx)
> +		return -ENOMEM;
> +
> +	*cxl_sparing_ctx = (struct cxl_mem_sparing_context){
> +		.get_feat_size = le16_to_cpu(feat_entry->get_feat_size),
> +		.set_feat_size = le16_to_cpu(feat_entry->set_feat_size),
> +		.get_version = feat_entry->get_feat_ver,
> +		.set_version = feat_entry->set_feat_ver,
> +		.effects = le16_to_cpu(feat_entry->effects),
> +		.cxlmd = cxlmd,
> +		.repair_type = desc->repair_type,
> +		.instance = repair_inst++,
> +	};
> +	uuid_copy(&cxl_sparing_ctx->repair_uuid, &desc->repair_uuid);
> +
> +	ret = cxl_mem_sparing_get_attrbs(cxl_sparing_ctx);
> +	if (ret)
> +		return ret;
> +
> +	if ((cxl_sparing_ctx->cap_soft_sparing &&
> +	     cxl_sparing_ctx->cap_hard_sparing) ||
> +	    cxl_sparing_ctx->cap_soft_sparing)
> +		cxl_sparing_ctx->persist_mode = 0;
> +	else if (cxl_sparing_ctx->cap_hard_sparing)
> +		cxl_sparing_ctx->persist_mode = 1;
> +	else
> +		return -EOPNOTSUPP;
> +
> +	ras_feature->ft_type = RAS_FEAT_MEM_REPAIR;
> +	ras_feature->instance = cxl_sparing_ctx->instance;
> +	ras_feature->mem_repair_ops = desc->repair_ops;
> +	ras_feature->ctx = cxl_sparing_ctx;
> +
> +	return 0;
> +}
>  #endif /* CONFIG_CXL_EDAC_MEM_REPAIR */
>  
>  int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
>  {
>  	struct edac_dev_feature ras_features[CXL_NR_EDAC_DEV_FEATURES];
>  	int num_ras_features = 0;
> -#if defined(CONFIG_CXL_EDAC_SCRUB) || defined(CONFIG_CXL_EDAC_ECS)
> +#ifdef CONFIG_CXL_EDAC_MEM_REPAIR
> +	u8 repair_inst = 0;
> +#endif
> +#if defined(CONFIG_CXL_EDAC_SCRUB) || defined(CONFIG_CXL_EDAC_ECS) || \
> +	defined(CXL_EDAC_MEM_REPAIR)
>  	int rc;
>  #endif
>  
> @@ -1153,6 +1684,19 @@ int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
>  	cxlmd->array_err_rec = array_rec;
>  	xa_init(&array_rec->rec_gen_media);
>  	xa_init(&array_rec->rec_dram);
> +
> +	for (int i = 0; i < CXL_MEM_SPARING_MAX; i++) {
> +		rc = cxl_memdev_sparing_init(cxlmd,
> +					     &ras_features[num_ras_features],
> +					     &mem_sparing_desc[i], repair_inst);
> +		if (rc == -EOPNOTSUPP)
> +			continue;
> +		if (rc < 0)
> +			return rc;
> +
> +		repair_inst++;
> +		num_ras_features++;
> +	}
>  #endif
>  	char *cxl_dev_name __free(kfree) =
>  		kasprintf(GFP_KERNEL, "cxl_%s", dev_name(&cxlmd->dev));
> diff --git a/drivers/edac/mem_repair.c b/drivers/edac/mem_repair.c
> index 3b1a845457b0..d1a8caa85369 100755
> --- a/drivers/edac/mem_repair.c
> +++ b/drivers/edac/mem_repair.c
> @@ -45,6 +45,15 @@ struct edac_mem_repair_context {
>  	struct attribute_group group;
>  };
>  
> +const char * const edac_repair_type[] = {
> +	[EDAC_REPAIR_PPR] = "ppr",
> +	[EDAC_REPAIR_CACHELINE_SPARING] = "cacheline-sparing",
> +	[EDAC_REPAIR_ROW_SPARING] = "row-sparing",
> +	[EDAC_REPAIR_BANK_SPARING] = "bank-sparing",
> +	[EDAC_REPAIR_RANK_SPARING] = "rank-sparing",
> +};
> +EXPORT_SYMBOL_GPL(edac_repair_type);
> +
>  #define TO_MR_DEV_ATTR(_dev_attr)      \
>  	container_of(_dev_attr, struct edac_mem_repair_dev_attr, dev_attr)
>  
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index 451f9c152c99..fa32f2aca22f 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -745,9 +745,16 @@ static inline int edac_ecs_get_desc(struct device *ecs_dev,
>  #endif /* CONFIG_EDAC_ECS */
>  
>  enum edac_mem_repair_type {
> +	EDAC_REPAIR_PPR,
> +	EDAC_REPAIR_CACHELINE_SPARING,
> +	EDAC_REPAIR_ROW_SPARING,
> +	EDAC_REPAIR_BANK_SPARING,
> +	EDAC_REPAIR_RANK_SPARING,
>  	EDAC_REPAIR_MAX
>  };
>  
> +extern const char * const edac_repair_type[];
> +
>  enum edac_mem_repair_cmd {
>  	EDAC_DO_MEM_REPAIR = 1,
>  };


