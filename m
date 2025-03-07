Return-Path: <linux-edac+bounces-3293-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F09A55CC1
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 02:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994B41882C77
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 01:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD0A13FD72;
	Fri,  7 Mar 2025 01:11:59 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC1C13D89D;
	Fri,  7 Mar 2025 01:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309919; cv=none; b=m5Z1H3c07wsQl1DglUhizc96NffoP/e6VaGfKJ36gfHx/xoZICe5AwwKq87H/tyB73KAYjnGeV6chrcCjQU6XZtBIPlKOpq6NuZj7RADqX9zjFZl6BIdH/1czRAYMHmZ5p4oL8G082pNE6bZdolzEOufsB0TwHjhGbhGIlBw2lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309919; c=relaxed/simple;
	bh=HL1NXGy0UL40qvin8QQARna26W2dZvjP7vmgRecMvJU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLC+INzGJnaBWlJKRRJgmwCx6DjDFZfAwa2ejcJv97r+GEM7N/9qj1RJJz3a9Oi5rOn2/kseaB0qkcNfHqt1h0+gE9d0wq9ddMcrepG/4B69F+bAakJx6l6px+q1fZ/dscruYpGMby1dxkrp7EBHZoQYuS6UY9WrCyIVjpk5cro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z87Tf0gM1z6J6F2;
	Fri,  7 Mar 2025 09:08:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A8C7140C98;
	Fri,  7 Mar 2025 09:11:53 +0800 (CST)
Received: from localhost (10.48.43.65) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Mar
 2025 02:11:42 +0100
Date: Fri, 7 Mar 2025 09:11:37 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <david@redhat.com>,
	<Vilas.Sridharan@amd.com>, <linux-edac@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH 8/8] cxl/memfeature: Add CXL memory device memory
 sparing control feature
Message-ID: <20250307091137.00006a0a@huawei.com>
In-Reply-To: <20250227223816.2036-9-shiju.jose@huawei.com>
References: <20250227223816.2036-1-shiju.jose@huawei.com>
	<20250227223816.2036-9-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 27 Feb 2025 22:38:15 +0000
<shiju.jose@huawei.com> wrote:

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
>  - If the previous case is not enough, may be when the number of corrected
>    error reported on a CXL.mem media to the user space exceeds an error
>    threshold set in the userspace policy.
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
> Tested for memory sparing control feature with
>    "hw/cxl: Add memory sparing control feature"
>    Repository: "https://gitlab.com/shiju.jose/qemu.git"
>    Branch: cxl-ras-features-2024-10-24
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Similar comment to earlier on maybe using single line comments
in more places rather than multiline.  Perhaps worth doing
that if you are respinning for other reasons.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> +static int cxl_mem_do_sparing_op(struct device *dev,
> +				 struct cxl_mem_sparing_context *cxl_sparing_ctx,
> +				 struct cxl_memdev_sparing_params *rd_params)
> +{
> +	struct cxl_memdev *cxlmd = cxl_sparing_ctx->cxlmd;
> +	struct cxl_memdev_sparing_in_payload sparing_pi;
> +	struct cxl_event_dram *rec = NULL;
> +	u16 validity_flags = 0;
> +
> +	if (!rd_params->cap_safe_when_in_use) {
> +		/*
> +		 * Memory to repair must be offline
> +		 */
> +		if (cxl_are_decoders_committed(cxlmd))
> +			return -EBUSY;
> +		/*
> +		 * offline, so good for repair
> +		 */
More places as below where a single line comment would be fine
and make a reader scroll a bit less.
> +static int cxl_memdev_sparing_init(struct cxl_memdev *cxlmd,
> +				   struct edac_dev_feature *ras_feature,
> +				   const struct cxl_mem_sparing_desc *desc,
> +				   u8 repair_inst)
> +{
> +	struct cxl_mem_sparing_context *cxl_sparing_ctx;
> +	struct cxl_memdev_sparing_params rd_params;
> +	struct cxl_feat_entry *feat_entry;
> +	int ret;
> +
> +	feat_entry = cxl_get_feature_entry(cxlmd->cxlds, &desc->repair_uuid);
> +	if (IS_ERR(feat_entry))
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
> +	*cxl_sparing_ctx = (struct cxl_mem_sparing_context) {
> +		.get_feat_size = le16_to_cpu(feat_entry->get_feat_size),
> +		.set_feat_size = le16_to_cpu(feat_entry->set_feat_size),
> +		.get_version = feat_entry->get_feat_ver,
> +		.set_version = feat_entry->set_feat_ver,
> +		.effects = le16_to_cpu(feat_entry->effects),
> +		.cxlmd = cxlmd,
> +		.repair_type = desc->repair_type,
> +		.granularity = desc->granularity,
> +		.instance = repair_inst++,
> +	};
> +	uuid_copy(&cxl_sparing_ctx->repair_uuid, &desc->repair_uuid);
> +
> +	/*
> +	 * Read CXL device's sparing capabilities.
a below.
> +	 */
> +	ret = cxl_mem_sparing_get_attrs(cxl_sparing_ctx, &rd_params);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Set default value for persist_mode.
> +	 */

If respining some of these comments don't need to be multiline.



