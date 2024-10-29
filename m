Return-Path: <linux-edac+bounces-2325-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6D49B4E87
	for <lists+linux-edac@lfdr.de>; Tue, 29 Oct 2024 16:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2817EB23998
	for <lists+linux-edac@lfdr.de>; Tue, 29 Oct 2024 15:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9AF194AD8;
	Tue, 29 Oct 2024 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AMkjx5Ew"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896D4802;
	Tue, 29 Oct 2024 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217075; cv=none; b=fbBfpt+SL9KB/3wpksYWYB2lAjUzTEhB8Ho93pLxoswx38rb9iP73W/4zvxchixWDS0S+6y0icRU7XiaXFc+NA1omqfAFrYmJVwhpg3vJNAELjnGJdW9VEBdqgLiXnpvPQU5SI/hvKHTyb004a0pFXo57c7USlzlZVWSq7//6J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217075; c=relaxed/simple;
	bh=f4jBgYZUSlfCMfcNx8h+IWGcspxRNAhi0goxFixH12A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BTkYhDtiSXMtJFv8As0spNJCbZ/GwZOc0JFVP7kohAbQpg8Yz5xvT1vU8eFpJIUEAHC6LYdZsZmE1SRnYqiZR+XCcSESGfzzCdzLivpQaOL0ZEKeChqQMJpeIenp5SrlEzLGToP2LqnOSVpM6/wAWcJT12PB87hgbEpF58z8IUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AMkjx5Ew; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730217074; x=1761753074;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f4jBgYZUSlfCMfcNx8h+IWGcspxRNAhi0goxFixH12A=;
  b=AMkjx5EwZx5Fpcf8HHP9/G8JzjEssRQ+KNhLD+b/mgRGiorekKaNTWc7
   pCuA2yRaZzMvaKGnlDeG0u0X6YLBu4/pGTRY2dJfo2UCp5+migrFwbicd
   Q5EaXmh0lzZaUqQcVav3ha/j4V9K/h4RqrjzjSJZwkmw7fdecCfrrL0hl
   Dc6UOOvSNqCwMHOLc4YAbPNDOlPbCQ7IkoGiqEvGYTLJHgIu7FN5Rb3oJ
   VOiRMjfDb47HYLRUDdMDWjUIR6doDnWKdONbnPCvV0RrpQekn2/nSVXqK
   +xnmD1O4LE7bPmlZkngcdaQcul0ysjBgOj7mUc6xuiTyf5oo9sovW6iKc
   w==;
X-CSE-ConnectionGUID: 3yH8xzAnRiOupfd8zbZ6jg==
X-CSE-MsgGUID: OwhPSZJhSAiOSG0LlL2uzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="30076192"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="30076192"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:51:12 -0700
X-CSE-ConnectionGUID: JcMIYN3xQ6ag+n1CrRZq5A==
X-CSE-MsgGUID: TzldkHpsTc60iL7s/0Xj0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="86563041"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.125.108.71]) ([10.125.108.71])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:51:09 -0700
Message-ID: <1bb31599-b103-45d2-b553-5facdb111941@intel.com>
Date: Tue, 29 Oct 2024 08:51:08 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 06/14] cxl/mbox: Add SET_FEATURE mailbox command
To: shiju.jose@huawei.com, linux-edac@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: bp@alien8.de, tony.luck@intel.com, rafael@kernel.org, lenb@kernel.org,
 mchehab@kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, gregkh@linuxfoundation.org,
 sudeep.holla@arm.com, jassisinghbrar@gmail.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, david@redhat.com,
 Vilas.Sridharan@amd.com, leo.duran@amd.com, Yazen.Ghannam@amd.com,
 rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
 dave.hansen@linux.intel.com, naoya.horiguchi@nec.com, james.morse@arm.com,
 jthoughton@google.com, somasundaram.a@hpe.com, erdemaktas@google.com,
 pgonda@google.com, duenwen@google.com, gthelen@google.com,
 wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
 wbs@os.amperecomputing.com, nifan.cxl@gmail.com, tanxiaofei@huawei.com,
 prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com, linuxarm@huawei.com
References: <20241025171356.1377-1-shiju.jose@huawei.com>
 <20241025171356.1377-7-shiju.jose@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241025171356.1377-7-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 10:13 AM, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for SET_FEATURE mailbox command.
> 
> CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
> CXL devices support features with changeable attributes.
> The settings of a feature can be optionally modified using Set Feature
> command.
> CXL spec 3.1 section 8.2.9.6.3 describes Set Feature command.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/mbox.c | 73 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 34 +++++++++++++++++++
>  2 files changed, 107 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 3cd4bce2872d..4b9e62de164b 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1011,6 +1011,79 @@ size_t cxl_get_feature(struct cxl_memdev_state *mds, const uuid_t feat_uuid,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
>  
> +/*
> + * FEAT_DATA_MIN_PAYLOAD_SIZE - min extra number of bytes should be
> + * available in the mailbox for storing the actual feature data so that
> + * the feature data transfer would work as expected.
> + */
> +#define FEAT_DATA_MIN_PAYLOAD_SIZE 10
> +int cxl_set_feature(struct cxl_memdev_state *mds,
> +		    const uuid_t feat_uuid, u8 feat_version,
> +		    void *feat_data, size_t feat_data_size,
> +		    u8 feat_flag)
> +{
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +	struct cxl_memdev_set_feat_pi {
> +		struct cxl_mbox_set_feat_hdr hdr;
> +		u8 feat_data[];
> +	}  __packed;
> +	size_t data_in_size, data_sent_size = 0;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	size_t hdr_size;
> +	int rc = 0;
> +
> +	struct cxl_memdev_set_feat_pi *pi __free(kfree) =
> +					kmalloc(cxl_mbox->payload_size, GFP_KERNEL);
> +	pi->hdr.uuid = feat_uuid;
> +	pi->hdr.version = feat_version;
> +	feat_flag &= ~CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK;
> +	feat_flag |= CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET;
> +	hdr_size = sizeof(pi->hdr);
> +	/*
> +	 * Check minimum mbox payload size is available for
> +	 * the feature data transfer.
> +	 */
> +	if (hdr_size + FEAT_DATA_MIN_PAYLOAD_SIZE > cxl_mbox->payload_size)
> +		return -ENOMEM;
> +
> +	if ((hdr_size + feat_data_size) <= cxl_mbox->payload_size) {
> +		pi->hdr.flags = cpu_to_le32(feat_flag |
> +				       CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER);
> +		data_in_size = feat_data_size;
> +	} else {
> +		pi->hdr.flags = cpu_to_le32(feat_flag |
> +				       CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER);
> +		data_in_size = cxl_mbox->payload_size - hdr_size;
> +	}
> +
> +	do {
> +		pi->hdr.offset = cpu_to_le16(data_sent_size);
> +		memcpy(pi->feat_data, feat_data + data_sent_size, data_in_size);
> +		mbox_cmd = (struct cxl_mbox_cmd) {
> +			.opcode = CXL_MBOX_OP_SET_FEATURE,
> +			.size_in = hdr_size + data_in_size,
> +			.payload_in = pi,
> +		};
> +		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +		if (rc < 0)
> +			return rc;
> +
> +		data_sent_size += data_in_size;
> +		if (data_sent_size >= feat_data_size)
> +			return 0;
> +
> +		if ((feat_data_size - data_sent_size) <= (cxl_mbox->payload_size - hdr_size)) {
> +			data_in_size = feat_data_size - data_sent_size;
> +			pi->hdr.flags = cpu_to_le32(feat_flag |
> +					       CXL_SET_FEAT_FLAG_FINISH_DATA_TRANSFER);
> +		} else {
> +			pi->hdr.flags = cpu_to_le32(feat_flag |
> +					       CXL_SET_FEAT_FLAG_CONTINUE_DATA_TRANSFER);
> +		}
> +	} while (true);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_feature, CXL);
> +
>  /**
>   * cxl_enumerate_cmds() - Enumerate commands for a device.
>   * @mds: The driver data for the operation
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 0c152719669a..fb356be8b426 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -532,6 +532,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
>  	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
>  	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
> +	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>  	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>  	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
> @@ -879,6 +880,35 @@ struct cxl_mbox_get_feat_in {
>  	u8 selection;
>  }  __packed;
>  
> +/*
> + * Set Feature CXL 3.1 Spec 8.2.9.6.3
> + */
> +
> +/*
> + * Set Feature input payload
> + * CXL rev 3.1 section 8.2.9.6.3 Table 8-101
> + */
> +/* Set Feature : Payload in flags */
> +#define CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK	GENMASK(2, 0)
> +enum cxl_set_feat_flag_data_transfer {
> +	CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER,
> +	CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER,
> +	CXL_SET_FEAT_FLAG_CONTINUE_DATA_TRANSFER,
> +	CXL_SET_FEAT_FLAG_FINISH_DATA_TRANSFER,
> +	CXL_SET_FEAT_FLAG_ABORT_DATA_TRANSFER,
> +	CXL_SET_FEAT_FLAG_DATA_TRANSFER_MAX
> +};
> +
> +#define CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET	BIT(3)
> +
> +struct cxl_mbox_set_feat_hdr {
> +	uuid_t uuid;
> +	__le32 flags;
> +	__le16 offset;
> +	u8 version;
> +	u8 rsvd[9];
> +}  __packed;
> +
>  int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>  			  struct cxl_mbox_cmd *cmd);
>  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
> @@ -945,4 +975,8 @@ int cxl_get_supported_feature_entry(struct cxl_memdev_state *mds, const uuid_t *
>  size_t cxl_get_feature(struct cxl_memdev_state *mds, const uuid_t feat_uuid,
>  		       enum cxl_get_feat_selection selection,
>  		       void *feat_out, size_t feat_out_size);
> +int cxl_set_feature(struct cxl_memdev_state *mds,
> +		    const uuid_t feat_uuid, u8 feat_version,
> +		    void *feat_data, size_t feat_data_size,
> +		    u8 feat_flag);
>  #endif /* __CXL_MEM_H__ */


