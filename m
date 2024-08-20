Return-Path: <linux-edac+bounces-1701-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C309590A1
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 00:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6882850A1
	for <lists+linux-edac@lfdr.de>; Tue, 20 Aug 2024 22:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEFD1C7B7D;
	Tue, 20 Aug 2024 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEA4amKq"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8902191F92;
	Tue, 20 Aug 2024 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724193969; cv=none; b=Yu08Ht8i1iBv/qzFDAcBLJw9nEyBA3ix62XWTPmpPAIMc0LP4NvLkSAZCq3wDdnlMYLufsPUZXsSqZ3F/TAe8RbrXZ7X2ImegUY0T0wxZAQwNm20zA/M8bImgA1s3EaT5ERiiY+8FqT1H9DtfboRlFVp/uTOeJ2PRSYiqHJjB3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724193969; c=relaxed/simple;
	bh=F3PA9yHyrbjgiUFut2vhgib1ni2rF84nJs2tKUq25NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgpfOMieqsn+UhvXhTmPqaOjcIYplLeblFM0FFXjgjrg11zjF9jrIZ6fzOodKYXW2BrRVlVzjk/rOhs7caqKKBkkIC6EyA3X78HqNE1kaAJf52ZCLfIFQY6n+zpFKbdA4tM8Iw4nrpKgtJXBWWEWRhQlyRjRnNp3gCBvv6kkcOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nEA4amKq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724193964; x=1755729964;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F3PA9yHyrbjgiUFut2vhgib1ni2rF84nJs2tKUq25NM=;
  b=nEA4amKqh1evUGAZMfo2uAbOdt9C02UXSj6KcyalVAhhddpVRVmvaQTT
   pzvNkv1Z74BYuD+LsgiB9X3ta9bUU+EDx6sHhj8GPZuKS3XnYxMxRVkfm
   dNUFAylxqx0Luzz3rJA3n+UwBcWPZyULKGHoJKrFC9RfDLV5h+b7ENjzL
   73R+HzzWRAxPUNEbvPOrFYXepXZBGdIVTI7k4vNJbLJJDyEsbgqzX107l
   xEo3gM6Ee/JR7zgwV2iUqHdtTaxecdF3Y3BvKoLbCkigJan9b4aCLFksc
   xDIcbh47BN1HmB9w6Dc1zG0MzvzY4URokVRMwIA4NeBMaSGya3oIkz37C
   Q==;
X-CSE-ConnectionGUID: G/id1pCdRie7GHY35SJYjg==
X-CSE-MsgGUID: xhyg5DYrSsu/qfiu/ygG/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="39984499"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="39984499"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 15:46:03 -0700
X-CSE-ConnectionGUID: GQ3XMDjfQcC8bIXChJYsxg==
X-CSE-MsgGUID: Oy9LSQUsQmiUWU5Tpk9pAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="65576969"
Received: from cdpresto-mobl2.amr.corp.intel.com.amr.corp.intel.com (HELO [10.125.108.88]) ([10.125.108.88])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 15:46:01 -0700
Message-ID: <8b78d617-26f6-45a2-87d7-d3b66f5e7277@intel.com>
Date: Tue, 20 Aug 2024 15:46:00 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 04/14] cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox
 command
To: shiju.jose@huawei.com, linux-edac@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: bp@alien8.de, tony.luck@intel.com, rafael@kernel.org, lenb@kernel.org,
 mchehab@kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, david@redhat.com,
 Vilas.Sridharan@amd.com, leo.duran@amd.com, Yazen.Ghannam@amd.com,
 rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
 dave.hansen@linux.intel.com, naoya.horiguchi@nec.com, james.morse@arm.com,
 jthoughton@google.com, somasundaram.a@hpe.com, erdemaktas@google.com,
 pgonda@google.com, duenwen@google.com, mike.malvestuto@intel.com,
 gthelen@google.com, wschwartz@amperecomputing.com,
 dferguson@amperecomputing.com, wbs@os.amperecomputing.com,
 nifan.cxl@gmail.com, jgroves@micron.com, vsalve@micron.com,
 tanxiaofei@huawei.com, prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com, linuxarm@huawei.com
References: <20240816164238.1902-1-shiju.jose@huawei.com>
 <20240816164238.1902-5-shiju.jose@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240816164238.1902-5-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/16/24 9:42 AM, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for GET_SUPPORTED_FEATURES mailbox command.
> 
> CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
> CXL devices support features with changeable attributes.
> 
> CXL spec 3.1 section 8.2.9.6.1 describes Get Supported features command.
> Get Supported Features retrieves the list of supported device specific
> features. The settings of a feature can be retrieved using Get Feature
> and optionally modified using Set Feature.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/mbox.c | 68 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 63 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 131 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2626f3fff201..760fa3e1075f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1324,6 +1324,74 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
>  
> +int cxl_get_supported_features(struct cxl_memdev_state *mds,
> +			       u32 count, u16 start_index,
> +			       struct cxl_mbox_get_supp_feats_out *feats_out)
> +{
> +	struct cxl_mbox_get_supp_feats_in pi;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int rc;
> +
> +	pi.count = cpu_to_le32(count);
> +	pi.start_index = cpu_to_le16(start_index);
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
> +		.size_in = sizeof(pi),
> +		.payload_in = &pi,
> +		.size_out = count,
> +		.payload_out = feats_out,
> +		.min_out = sizeof(*feats_out),
> +	};
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	if (rc < 0)
> +		return rc;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
> +
> +int cxl_get_supported_feature_entry(struct cxl_memdev_state *mds, const uuid_t *feat_uuid,
> +				    struct cxl_mbox_supp_feat_entry *feat_entry_out)

Hi Shiju,
thoughts on storing all the supported features meta info from GET_SUPPORTED_FEATURES command in the cxl core driver during device enumeration and the CXL EDAC code can just query the core instead of reading from the device? Just looking forward to supporting other read/set features operations in the future and avoiding going through this entire read and find routine for each feature.

DJ 

> +{
> +	struct cxl_mbox_supp_feat_entry *feat_entry;
> +	int feat_index, feats_out_size;
> +	int nentries, count;
> +	int ret;
> +
> +	feat_index = 0;
> +	feats_out_size = sizeof(struct cxl_mbox_get_supp_feats_out) +
> +				sizeof(struct cxl_mbox_supp_feat_entry);
> +	struct cxl_mbox_get_supp_feats_out *feats_out __free(kfree) =
> +					kmalloc(feats_out_size, GFP_KERNEL);
> +	if (!feats_out)
> +		return -ENOMEM;
> +
> +	while (true) {
> +		memset(feats_out, 0, feats_out_size);
> +		ret = cxl_get_supported_features(mds, feats_out_size,
> +						 feat_index, feats_out);
> +		if (ret)
> +			return ret;
> +
> +		nentries = feats_out->nr_entries;
> +		if (!nentries)
> +			return -EOPNOTSUPP;
> +
> +		/* Check CXL memdev supports the feature */
> +		feat_entry = feats_out->feat_entries;
> +		for (count = 0; count < nentries; count++, feat_entry++) {
> +			if (uuid_equal(&feat_entry->uuid, feat_uuid)) {
> +				memcpy(feat_entry_out, feat_entry,
> +				       sizeof(*feat_entry_out));
> +				return 0;
> +			}
> +		}
> +		feat_index += nentries;
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_supported_feature_entry, CXL);
> +
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr)
>  {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index af8169ccdbc0..9939c771f642 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -531,6 +531,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
>  	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
>  	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
> +	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>  	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>  	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
> @@ -700,6 +701,63 @@ struct cxl_mbox_set_timestamp_in {
>  
>  } __packed;
>  
> +/*
> + * Get Supported Features CXL 3.1 Spec 8.2.9.6.1
> + */
> +
> +/*
> + * Get Supported Features input payload
> + * CXL rev 3.1 section 8.2.9.6.1 Table 8-95
> + */
> +struct cxl_mbox_get_supp_feats_in {
> +	__le32 count;
> +	__le16 start_index;
> +	u8 rsvd[2];
> +} __packed;
> +
> +/*
> + * Get Supported Features Supported Feature Entry
> + * CXL rev 3.1 section 8.2.9.6.1 Table 8-97
> + */
> +/* Supported Feature Entry : Payload out attribute flags */
> +#define CXL_FEAT_ENTRY_FLAG_CHANGABLE	BIT(0)
> +#define CXL_FEAT_ENTRY_FLAG_DEEPEST_RESET_PERSISTENCE_MASK	GENMASK(3, 1)
> +#define CXL_FEAT_ENTRY_FLAG_PERSIST_ACROSS_FIRMWARE_UPDATE	BIT(4)
> +#define CXL_FEAT_ENTRY_FLAG_SUPPORT_DEFAULT_SELECTION	BIT(5)
> +#define CXL_FEAT_ENTRY_FLAG_SUPPORT_SAVED_SELECTION	BIT(6)
> +
> +enum cxl_feat_attr_value_persistence {
> +	CXL_FEAT_ATTR_VALUE_PERSISTENCE_NONE,
> +	CXL_FEAT_ATTR_VALUE_PERSISTENCE_CXL_RESET,
> +	CXL_FEAT_ATTR_VALUE_PERSISTENCE_HOT_RESET,
> +	CXL_FEAT_ATTR_VALUE_PERSISTENCE_WARM_RESET,
> +	CXL_FEAT_ATTR_VALUE_PERSISTENCE_COLD_RESET,
> +	CXL_FEAT_ATTR_VALUE_PERSISTENCE_MAX
> +};
> +
> +struct cxl_mbox_supp_feat_entry {
> +	uuid_t uuid;
> +	__le16 index;
> +	__le16 get_size;
> +	__le16 set_size;
> +	__le32 attr_flags;
> +	u8 get_version;
> +	u8 set_version;
> +	__le16 set_effects;
> +	u8 rsvd[18];
> +}  __packed;
> +
> +/*
> + * Get Supported Features output payload
> + * CXL rev 3.1 section 8.2.9.6.1 Table 8-96
> + */
> +struct cxl_mbox_get_supp_feats_out {
> +	__le16 nr_entries;
> +	__le16 nr_supported;
> +	u8 rsvd[4];
> +	struct cxl_mbox_supp_feat_entry feat_entries[];
> +} __packed;
> +
>  /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
>  struct cxl_mbox_poison_in {
>  	__le64 offset;
> @@ -831,6 +889,11 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			    enum cxl_event_type event_type,
>  			    const uuid_t *uuid, union cxl_event *evt);
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
> +int cxl_get_supported_features(struct cxl_memdev_state *mds,
> +			       u32 count, u16 start_index,
> +			       struct cxl_mbox_get_supp_feats_out *feats_out);
> +int cxl_get_supported_feature_entry(struct cxl_memdev_state *mds, const uuid_t *feat_uuid,
> +				    struct cxl_mbox_supp_feat_entry *feat_entry_out);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr);

