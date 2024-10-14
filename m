Return-Path: <linux-edac+bounces-2058-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 969DA99D51E
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 19:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F591F242D0
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059741BFE10;
	Mon, 14 Oct 2024 17:00:37 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800851AB6DC;
	Mon, 14 Oct 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925236; cv=none; b=FkAArZ0j1j3+ylrC5QBN4Y5rhT89FYxbyBh4EO13Wc/rf5/nDq05eFzvrWzw1/0Viisd4x4OMAp7yNw0E9YxggTfDyOxD3S4rXZOp7YO4Drlj4Olj/w6Q/uZD0SJ4rT68W0V6NBVIbxi4ypPg8/2Qq32IazirbXl0gY3XeiRHek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925236; c=relaxed/simple;
	bh=VP0g8shd0BXsf7rD5u6CIZRbX5Ew+8vAMWJRLG6RIjI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMgndSoWSPJocJPFhCB/WOO5RoHw7MtoJDf3kiEo64Kdv25ocWWejaCGErDdknMce/FsNPcTdOa3Jl92hXTb5L1DEJFedI7BEJ+8hQlTK+cUU+bE5FnJErKCn8LL8zE8unagGMnUubKLluG/pNbh7J1Mh/wO8hI4wwqxg974QzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XS3Jz2ddYz6LCdw;
	Tue, 15 Oct 2024 00:56:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B7E13140D26;
	Tue, 15 Oct 2024 01:00:30 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 19:00:29 +0200
Date: Mon, 14 Oct 2024 18:00:27 +0100
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
Subject: Re: [PATCH v13 18/18] cxl/memfeature: Add CXL memory device memory
 sparing control feature
Message-ID: <20241014180027.00001d1e@Huawei.com>
In-Reply-To: <20241009124120.1124-19-shiju.jose@huawei.com>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
	<20241009124120.1124-19-shiju.jose@huawei.com>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 9 Oct 2024 13:41:19 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Memory sparing is defined as a repair function that replaces a portion of
> memory with a portion of functional memory at that same DPA. The subclasses
> for this operation vary in terms of the scope of the sparing being
> performed. The cacheline sparing subclass refers to a sparing action that
> can replace a full cacheline. Row sparing is provided as an alternative to
> PPR sparing functions and its scope is that of a single DDR row. Bank
> sparing allows an entire bank to be replaced. Rank sparing is defined as
> an operation in which an entire DDR rank is replaced.
> 
> Memory sparing maintenance operations may be supported by CXL devices
> that implement CXL.mem protocol. A sparing maintenance operation requests
> the CXL device to perform a repair operation on its media.
> For example, a CXL device with DRAM components that support memory sparing
> features may implement sparing maintenance operations.
> 
> The host may issue a query command by setting query resources flag in the
> input payload (CXL spec 3.1 Table 8-105) to determine availability of
> sparing resources for a given address. In response to a query request,
> the device shall report the resource availability by producing the memory
> sparing event record (CXL spec 3.1 Table 8-48) in which the Channel, Rank,
> Nibble Mask, Bank Group, Bank, Row, Column, Sub-Channel fields are a copy
> of the values specified in the request.
> 
> During the execution of a sparing maintenance operation, a CXL memory
> device:
> - May or may not retain data
> - May or may not be able to process CXL.mem requests correctly.
> These CXL memory device capabilities are specified by restriction flags
> in the memory sparing feature readable attributes.
> 
> When a CXL device identifies a failure on a memory component, the device
> may inform the host about the need for a memory sparing maintenance
> operation by using an Event Record, where the maintenance needed flag may
> set. The event record specifies some of the DPA, Channel, Rank, Nibble
> Mask, Bank Group, Bank, Row, Column, Sub-Channel fields that should be
> repaired. The userspace tool requests for maintenance operation if the
> number of corrected error reported on a CXL.mem media exceeds error
> threshold.
> 
> CXL spec 3.1 section 8.2.9.7.1.4 describes the device's memory sparing
> maintenance operation feature.
Push these references into the code as well as comments.
> 
> CXL spec 3.1 section 8.2.9.7.2.3 describes the memory sparing feature
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
>    userspace in a CXL generic/DRAM trace event.
> 2. Rasdaemon process the trace event and issue query request in sysfs to
> check resources available for memory sparing if either of the following
> conditions met.
>  - number of corrected error reported on a CXL.mem media exceeds error
> threshold
>  - maintenance needed flag set in the event record.
> 3. CXL device shall report the resource availability by producing the
> memory sparing event record in which the channel, rank, nibble mask, bank
> Group, bank, row, column, sub-channel fields are a copy of the values
> specified in the request. The query resource command shall return error
> (invalid input) if the controller does not support reporting resource is
> available.
> 4. Rasdaemon process the memory sparing trace event and issue repair
> request for memory sparing.
> 
> Kernel CXL driver shall report memory sparing event record to the userspace
> with the resource availability in order rasdaemon to process the event
> record and issue a repair request in sysfs for the memory sparing operation
> in the CXL device.
> 
> Tested for memory sparing control feature with
>    "hw/cxl: Add memory sparing control feature"
>    Repository: "https://gitlab.com/shiju.jose/qemu.git"
>    Branch: cxl-ras-features-2024-10-02
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Main thing in here is we need some references to the spec.
Some of the details are not that easy to find.
Otherwise some suggested refactors around the locking.

Thanks,

Jonathan

> ---
>  drivers/cxl/core/memfeature.c | 503 +++++++++++++++++++++++++++++++++-
>  1 file changed, 499 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/memfeature.c b/drivers/cxl/core/memfeature.c
> index a0c9a6bd73c0..ecebdf0176ed 100644
> --- a/drivers/cxl/core/memfeature.c
> +++ b/drivers/cxl/core/memfeature.c

> +struct cxl_memdev_sparing_rd_attrs {
> +	u8 max_op_latency;
> +	__le16 op_cap;
> +	__le16 op_mode;
> +	u8 op_class;
> +	u8 op_subclass;
> +	u8 rsvd[10];

If you do the separate common maint header as suggested
in review of previous patch then there is
still one byte of extra rsvd to have here.
Got to love a trailing structure that starts with a reserved
byte...

> +	__le16 restriction_flags;
> +}  __packed;
> +
> +struct cxl_memdev_sparing_wr_attrs {
> +	__le16 op_mode;
> +}  __packed;
> +
> +struct cxl_memdev_sparing_maintenance_attrs {

This is called the memory sparing input payload in the spec.
Maybe name it closer to that?  + a reference. Took some finding!

> +	u8 flags;
> +	u8 channel;
> +	u8 rank;
> +	u8 nibble_mask[3];
> +	u8 bank_group;
> +	u8 bank;
> +	u8 row[3];
> +	u16 column;
> +	u8 sub_channel;
> +}  __packed;

> +static int cxl_mem_sparing_set_attrs(struct device *dev, void *drv_data,
> +				     enum cxl_mem_sparing_param_type param_type)
> +{
> +	struct cxl_memdev_sparing_maintenance_attrs maintenance_attrs;
> +	struct cxl_mem_sparing_context *cxl_sparing_ctx = drv_data;
> +	struct cxl_memdev *cxlmd = cxl_sparing_ctx->cxlmd;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct cxl_memdev_sparing_params rd_params;
> +	struct cxl_region *cxlr;
> +	int ret;
> +
> +	ret = cxl_mem_sparing_get_attrs(dev, drv_data, &rd_params);
> +	if (ret) {
> +		dev_err(dev, "Get cxlmemdev sparing params failed ret=%d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	switch (param_type) {
> +	case CXL_MEM_SPARING_PARAM_DO_QUERY:
> +	case CXL_MEM_SPARING_PARAM_DO_REPAIR:
> +		ret = down_read_interruptible(&cxl_region_rwsem);
I think this should be refactored to take this semaphore
then call another function.

		ret = down_read_interruptible(&cxl_region_rwsem);
		if (ret)
			return ret;
		ret = do_sparing_op();
		up_read(&cxl_region_rwsem);
		if (ret)
			return ret;


The reason being it is far too easy to miss a path.
Maybe we will get a nicer conditional guard shortly but we shouldn't
wait for that.

> +		if (ret)
> +			return ret;
> +		if (!rd_params.cap_safe_when_in_use && cxl_sparing_ctx->dpa) {
> +			/* Check if DPA is mapped */
> +			ret = down_read_interruptible(&cxl_dpa_rwsem);
> +			if (ret) {
> +				up_read(&cxl_region_rwsem);
> +				return ret;
> +			}
> +
> +			cxlr = cxl_dpa_to_region(cxlmd, cxl_sparing_ctx->dpa);
> +			up_read(&cxl_dpa_rwsem);

Feels like maybe a cxl_dpa_to_region_locked() is useful?  Perhaps a job for
another day though.

> +			if (cxlr) {
> +				dev_err(dev, "CXL can't do PPR as DPA is mapped\n");
> +				up_read(&cxl_region_rwsem);
> +				return -EBUSY;
> +			}
> +		}
> +
> +		memset(&maintenance_attrs, 0, sizeof(maintenance_attrs));
> +		if (param_type == CXL_MEM_SPARING_PARAM_DO_QUERY) {
> +			maintenance_attrs.flags = CXL_MEMDEV_SPARING_QUERY_RESOURCE_FLAG;
> +		} else {
> +			maintenance_attrs.flags =
> +				FIELD_PREP(CXL_MEMDEV_SPARING_QUERY_RESOURCE_FLAG, 0);
> +			/* Do need set hard sparing, sub-channel & nb mask flags for query? */
> +			if (cxl_sparing_ctx->persist_mode == EDAC_MEM_REPAIR_HARD)
> +				maintenance_attrs.flags |=
> +					FIELD_PREP(CXL_MEMDEV_SET_HARD_SPARING_FLAG, 1);
> +			if (cxl_sparing_ctx->sub_channel)
> +				maintenance_attrs.flags |=
> +					FIELD_PREP(CXL_MEMDEV_SPARING_SUB_CHANNEL_VALID_FLAG, 1);
> +			if (cxl_sparing_ctx->nibble_mask)
> +				maintenance_attrs.flags |=
> +					FIELD_PREP(CXL_MEMDEV_SPARING_NIB_MASK_VALID_FLAG, 1);
> +		}
> +		/* Common atts for all memory sparing types */
> +		maintenance_attrs.channel = cxl_sparing_ctx->channel;
> +		maintenance_attrs.rank = cxl_sparing_ctx->rank;
> +		*((u32 *)&maintenance_attrs.nibble_mask[0]) = cxl_sparing_ctx->nibble_mask;
> +
> +		if (cxl_sparing_ctx->repair_type == EDAC_TYPE_CACHELINE_MEM_SPARING ||
> +		    cxl_sparing_ctx->repair_type == EDAC_TYPE_ROW_MEM_SPARING ||
> +		    cxl_sparing_ctx->repair_type == EDAC_TYPE_BANK_MEM_SPARING) {
> +			maintenance_attrs.bank_group = cxl_sparing_ctx->bank_group;
> +			maintenance_attrs.bank = cxl_sparing_ctx->bank;
> +		}
> +		if (cxl_sparing_ctx->repair_type == EDAC_TYPE_CACHELINE_MEM_SPARING ||
> +		    cxl_sparing_ctx->repair_type == EDAC_TYPE_ROW_MEM_SPARING)
> +			*((u32 *)&maintenance_attrs.row[0]) = cxl_sparing_ctx->row;
> +		if (cxl_sparing_ctx->repair_type == EDAC_TYPE_CACHELINE_MEM_SPARING) {
> +			maintenance_attrs.column = cxl_sparing_ctx->column;
> +			maintenance_attrs.sub_channel = cxl_sparing_ctx->sub_channel;
> +		}
> +
> +		ret = cxl_do_maintenance(mds, rd_params.op_class, rd_params.op_subclass,
> +					 &maintenance_attrs, sizeof(maintenance_attrs));
> +		if (ret) {
> +			dev_err(dev, "CXL do mem sparing maintenance failed ret=%d\n", ret);
> +			up_read(&cxl_region_rwsem);
> +			return ret;
> +		}
> +		up_read(&cxl_region_rwsem);
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int cxl_mem_sparing_get_persist_mode_avail(struct device *dev, void *drv_data,
> +						  char *buf)
> +{
> +	return sysfs_emit(buf, "%u\n", EDAC_MEM_REPAIR_SOFT);
As before, if only supporting soft (which is fine for now) then
make it clear in the patch description.

> +}
> +
> +static int cxl_mem_sparing_get_persist_mode(struct device *dev, void *drv_data,
> +					    u32 *persist_mode)
> +{
> +	struct cxl_mem_sparing_context *ctx = drv_data;
> +
> +	*persist_mode = ctx->persist_mode;
> +
> +	return 0;
> +}

> +
> +#define RANK_OPS \
> +	.get_repair_type = cxl_mem_sparing_get_repair_type, \
> +	.get_persist_mode_avail = cxl_mem_sparing_get_persist_mode_avail, \
> +	.get_persist_mode = cxl_mem_sparing_get_persist_mode, \
> +	.set_persist_mode = cxl_mem_sparing_set_persist_mode, \
> +	.get_repair_safe_when_in_use = cxl_get_mem_sparing_safe_when_in_use, \
> +	.get_dpa_support = cxl_get_sparing_dpa_support, \
> +	.set_dpa = cxl_set_mem_sparing_dpa, \
> +	.set_nibble_mask = cxl_set_mem_sparing_nibble_mask, \
> +	.set_rank = cxl_set_mem_sparing_rank, \
> +	.set_channel = cxl_set_mem_sparing_channel, \
> +	.do_query = cxl_do_query_mem_sparing, \
> +	.do_repair = cxl_do_mem_sparing
> +
> +#define BANK_OPS \
> +	RANK_OPS, \
> +	.set_bank_group = cxl_set_mem_sparing_bank_group, \
> +	.set_bank = cxl_set_mem_sparing_bank
> +
> +#define ROW_OPS \
> +	BANK_OPS, \
> +	.set_row = cxl_set_mem_sparing_row
> +
> +#define CACHELINE_OPS \
> +	ROW_OPS, \
> +	.set_column = cxl_set_mem_sparing_column, \
> +	.set_sub_channel = cxl_set_mem_sparing_sub_channel
> +
> +static const struct edac_mem_repair_ops cxl_rank_sparing_ops = {
> +	RANK_OPS
> +};
> +
> +static const struct edac_mem_repair_ops cxl_bank_sparing_ops = {
> +	BANK_OPS
> +};
> +
> +static const struct edac_mem_repair_ops cxl_row_sparing_ops = {
> +	ROW_OPS
> +};
> +
> +static const struct edac_mem_repair_ops cxl_cacheline_sparing_ops = {
> +	CACHELINE_OPS
I'd add trailing commas.  Whilst we don't expect to add stuff after
these we 'might'.
> +};
> +
> +struct cxl_mem_sparing_desc {
> +	const uuid_t repair_uuid;
> +	enum edac_mem_repair_type repair_type;
> +	enum edac_mem_repair_persist_mode persist_mode;
> +	enum cxl_mem_sparing_granularity granularity;
> +	const struct edac_mem_repair_ops *repair_ops;
> +};
> +
> +static struct cxl_mem_sparing_desc mem_sparing_desc[] = {
const?

> +	{
> +		.repair_uuid = CXL_CACHELINE_SPARING_UUID,
> +		.repair_type = EDAC_TYPE_CACHELINE_MEM_SPARING,
> +		.persist_mode = EDAC_MEM_REPAIR_SOFT,
> +		.granularity = CXL_MEM_SPARING_CACHELINE,
> +		.repair_ops = &cxl_cacheline_sparing_ops,
> +	},
> +	{
> +		.repair_uuid = CXL_ROW_SPARING_UUID,
> +		.repair_type = EDAC_TYPE_ROW_MEM_SPARING,
> +		.persist_mode = EDAC_MEM_REPAIR_SOFT,
> +		.granularity = CXL_MEM_SPARING_ROW,
> +		.repair_ops = &cxl_row_sparing_ops,
> +	},
> +	{
> +		.repair_uuid = CXL_BANK_SPARING_UUID,
> +		.repair_type = EDAC_TYPE_BANK_MEM_SPARING,
> +		.persist_mode = EDAC_MEM_REPAIR_SOFT,
> +		.granularity = CXL_MEM_SPARING_BANK,
> +		.repair_ops = &cxl_bank_sparing_ops,
> +	},
> +	{
> +		.repair_uuid = CXL_RANK_SPARING_UUID,
> +		.repair_type = EDAC_TYPE_RANK_MEM_SPARING,
> +		.persist_mode = EDAC_MEM_REPAIR_SOFT,
> +		.granularity = CXL_MEM_SPARING_RANK,
> +		.repair_ops = &cxl_rank_sparing_ops,
> +	},
> +};
> +
>  int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
>  {
>  	struct edac_dev_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
> @@ -1022,6 +1479,7 @@ int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
>  	char cxl_dev_name[CXL_SCRUB_NAME_LEN];
>  	struct cxl_ecs_context *cxl_ecs_ctx;
>  	struct cxl_ppr_context *cxl_sppr_ctx;
> +	struct cxl_mem_sparing_context *cxl_sparing_ctx;
>  	int rc, i, num_ras_features = 0;
>  	int num_media_frus;
>  	u8 scrub_inst = 0, repair_inst = 0;
> @@ -1125,15 +1583,15 @@ int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
>  		rc = cxl_get_supported_feature_entry(mds, &cxl_sppr_uuid,
>  						     &feat_entry);
>  		if (rc < 0)
> -			goto feat_register;
> +			goto feat_mem_sparing;
>  
>  		if (!(feat_entry.attr_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
> -			goto feat_register;
> +			goto feat_mem_sparing;
Trivial but maybe change labels to 
feat_sppr_done: 
etc so that you can provide them only when adding the new features
rather than always having to update when next feature is added.
Will reduce patch set a little is size which is nice and I think
will be no less clear.

>  
>  		cxl_sppr_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_sppr_ctx),
>  					    GFP_KERNEL);
>  		if (!cxl_sppr_ctx)
> -			goto feat_register;
> +			goto feat_mem_sparing;


