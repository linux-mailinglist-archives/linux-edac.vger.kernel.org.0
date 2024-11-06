Return-Path: <linux-edac+bounces-2465-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B359F9BFA39
	for <lists+linux-edac@lfdr.de>; Thu,  7 Nov 2024 00:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74127283F05
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2024 23:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F23020CCF3;
	Wed,  6 Nov 2024 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BsKD38Ak"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB108168BD;
	Wed,  6 Nov 2024 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730936097; cv=none; b=qgirOg8rAgte/L8eFa+VY35IbY+XRzJzVPWDFnshjHfjzrtyi7BJEc8fmoZne7MASsXZ8tbGir7lK8fqIlaByAe4NH5XEMrwSizRT3a7TO6C/IBm0mIxrodp8SfhLjmpVqT4j72M99f1mtF1bQR3BuGVQNIgPJBGvGORTGhxZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730936097; c=relaxed/simple;
	bh=eSWnXMt84uuSKv4n1E/4P/zRZgnj3xbM9RKn/bEzlmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z619IIwy3YJwVkeuLnKcP+az9t7TL4/8JsLXgrSMThbeTZrcxY6iB4XqMsqzTpbMq91yR9J3YdPBWuDc6pLxaRk6cvtOa4K4D3rRP7kLjljU087cByNGDlA+bnE2hQpkXUdMVQIjEmaWA8I2Zth3tTOss3go5nJRrWreylaNl60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BsKD38Ak; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730936095; x=1762472095;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eSWnXMt84uuSKv4n1E/4P/zRZgnj3xbM9RKn/bEzlmg=;
  b=BsKD38AkrULm+wr/zQ9BPWj/Th71Jlc8hELZfr8kp/iga8RUwf85eMqX
   /J+PKkZY0cKZtphZr3IqDifpRuO6wJ7Z057lUP1Z57BV/rg1h4DPtrx7d
   FYvZM/MxjpUEeCXYQvjAau4J7f30AcfN7AuisKDjlGCLZdT8faARXi/Qd
   9OWgLo277GX2xR8getPyHAlZ5GjsXnAMagdrc/DEvk6uImihefUpaPU3b
   LI10lE6FnNQ9gXCt1zZS3iEifCWYAa68F2FOpFvNf/MG/CEZfK7/khZ4G
   srOnZmc+Wv4FrTRWAEvway4mU8c3sBQmsseSrPPVY6JdstL+PcZ9KEk0o
   Q==;
X-CSE-ConnectionGUID: 7+WQTGzNRFy/00KuDUOY4w==
X-CSE-MsgGUID: kTqo1h6UTqyOMrnV/nzpTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53317603"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="53317603"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 15:34:54 -0800
X-CSE-ConnectionGUID: NF0vpozUQTikJA2BFFTzYg==
X-CSE-MsgGUID: o1lNPTweSA64xESvsANXgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,264,1725346800"; 
   d="scan'208";a="84912598"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO [10.125.110.92]) ([10.125.110.92])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 15:34:51 -0800
Message-ID: <49228a3c-23b0-4aac-9c7f-e605045e3c8f@intel.com>
Date: Wed, 6 Nov 2024 16:34:49 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 04/15] cxl: Add Get Supported Features command for
 kernel usage
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
References: <20241101091735.1465-1-shiju.jose@huawei.com>
 <20241101091735.1465-5-shiju.jose@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241101091735.1465-5-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/1/24 2:17 AM, shiju.jose@huawei.com wrote:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> CXL spec r3.1 8.2.9.6.1 Get Supported Features (Opcode 0500h)
> The command retrieve the list of supported device-specific features
> (identified by UUID) and general information about each Feature.
> 
> The driver will retrieve the feature entries in order to make checks and
> provide information for the Get Feature and Set Feature command. One of
> the main piece of information retrieved are the effects a Set Feature
> command would have for a particular feature.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Co-developed-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Found couple endien conversion changes below:

> ---
>  drivers/cxl/core/mbox.c      | 175 +++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h         |  47 ++++++++++
>  drivers/cxl/pci.c            |   4 +
>  include/cxl/mailbox.h        |   4 +
>  include/uapi/linux/cxl_mem.h |   1 +
>  5 files changed, 231 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 5175138c4fb7..5045960e3bfe 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -67,6 +67,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
>  	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>  	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
> +	CXL_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD, 0),
>  };
>  
>  /*
> @@ -795,6 +796,180 @@ static const uuid_t log_uuid[] = {
>  	[VENDOR_DEBUG_UUID] = DEFINE_CXL_VENDOR_DEBUG_UUID,
>  };
>  
> +static void cxl_free_features(void *features)
> +{
> +	kvfree(features);
> +}
> +
> +static int cxl_get_supported_features_count(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
> +	struct cxl_mbox_get_sup_feats_out mbox_out;
> +	struct cxl_mbox_get_sup_feats_in mbox_in;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int rc;
> +
> +	memset(&mbox_in, 0, sizeof(mbox_in));
> +	mbox_in.count = sizeof(mbox_out);

mbox_in.count = cpu_to_le32(sizeof(mbox_out));

> +	memset(&mbox_out, 0, sizeof(mbox_out));
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
> +		.size_in = sizeof(mbox_in),
> +		.payload_in = &mbox_in,
> +		.size_out = sizeof(mbox_out),
> +		.payload_out = &mbox_out,
> +		.min_out = sizeof(mbox_out),
> +	};
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +	if (rc < 0)
> +		return rc;
> +
> +	cxl_mbox->num_features = le16_to_cpu(mbox_out.supported_feats);
> +	if (!cxl_mbox->num_features)
> +		return -ENOENT;
> +
> +	return 0;
> +}
> +
> +int cxl_get_supported_features(struct cxl_memdev_state *mds)
> +{
> +	int remain_feats, max_size, max_feats, start, rc;
> +	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
> +	int feat_size = sizeof(struct cxl_feat_entry);
> +	struct cxl_mbox_get_sup_feats_out *mbox_out;
> +	struct cxl_mbox_get_sup_feats_in mbox_in;
> +	int hdr_size = sizeof(*mbox_out);
> +	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_mem_command *cmd;
> +	void *ptr;
> +
> +	/* Get supported features is optional, need to check */
> +	cmd = cxl_mem_find_command(CXL_MBOX_OP_GET_SUPPORTED_FEATURES);
> +	if (!cmd)
> +		return -EOPNOTSUPP;
> +	if (!test_bit(cmd->info.id, mds->enabled_cmds))
> +		return -EOPNOTSUPP;
> +
> +	rc = cxl_get_supported_features_count(cxlds);
> +	if (rc)
> +		return rc;
> +
> +	struct cxl_feat_entry *entries __free(kvfree) =
> +		kvmalloc(cxl_mbox->num_features * feat_size, GFP_KERNEL);
> +
> +	if (!entries)
> +		return -ENOMEM;
> +
> +	cxl_mbox->entries = no_free_ptr(entries);
> +	rc = devm_add_action_or_reset(cxl_mbox->host, cxl_free_features,
> +				      cxl_mbox->entries);
> +	if (rc)
> +		return rc;
> +
> +	max_size = cxl_mbox->payload_size - hdr_size;
> +	/* max feat entries that can fit in mailbox max payload size */
> +	max_feats = max_size / feat_size;
> +	ptr = &cxl_mbox->entries[0];
> +
> +	mbox_out = kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
> +	if (!mbox_out)
> +		return -ENOMEM;
> +
> +	start = 0;
> +	remain_feats = cxl_mbox->num_features;
> +	do {
> +		int retrieved, alloc_size, copy_feats;
  +		int num_entries;
> +
> +		if (remain_feats > max_feats) {
> +			alloc_size = sizeof(*mbox_out) + max_feats * feat_size;
> +			remain_feats = remain_feats - max_feats;
> +			copy_feats = max_feats;
> +		} else {
> +			alloc_size = sizeof(*mbox_out) + remain_feats * feat_size;
> +			copy_feats = remain_feats;
> +			remain_feats = 0;
> +		}
> +
> +		memset(&mbox_in, 0, sizeof(mbox_in));
> +		mbox_in.count = alloc_size;
> +		mbox_in.start_idx = start;
mbox_in.count = cpu_to_le32(alloc_size);
mbox_in.start_idx = cpu_to_le16(start);


> +		memset(mbox_out, 0, alloc_size);
> +		mbox_cmd = (struct cxl_mbox_cmd) {
> +			.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
> +			.size_in = sizeof(mbox_in),
> +			.payload_in = &mbox_in,
> +			.size_out = alloc_size,
> +			.payload_out = mbox_out,
> +			.min_out = hdr_size,
> +		};
> +		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +		if (rc < 0)
> +			goto err;
> +		if (mbox_cmd.size_out <= hdr_size) {
> +			rc = -ENXIO;
> +			goto err;
> +		}
> +
> +		/*
> +		 * Make sure retrieved out buffer is multiple of feature
> +		 * entries.
> +		 */
> +		retrieved = mbox_cmd.size_out - hdr_size;
> +		if (retrieved % feat_size) {
> +			rc = -ENXIO;
> +			goto err;
> +		}
> +

  +		num_entries = le16_to_cpu(mbox_out->num_entries);
> +		/*
> +		 * If the reported output entries * defined entry size !=
> +		 * retrieved output bytes, then the output package is incorrect.
> +		 */
> +		if (mbox_out->num_entries * feat_size != retrieved) {
if (num_entries * feat_size != retrieved) {
> +			rc = -ENXIO;
> +			goto err;
> +		}
> +
> +		memcpy(ptr, mbox_out->ents, retrieved);
> +		ptr += retrieved;
> +		/*
> +		 * If the number of output entries is less than expected, add the
> +		 * remaining entries to the next batch.
> +		 */
> +		remain_feats += copy_feats - mbox_out->num_entries;
> +		start += mbox_out->num_entries;
remain_feat += copy_feats - num_entries;
start += num_entries;

> +	} while (remain_feats);
> +
> +	kfree(mbox_out);
> +	return 0;
> +
> +err:
> +	kfree(mbox_out);
> +	cxl_mbox->num_features = 0;
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
> +
> +int cxl_get_supported_feature_entry(struct cxl_memdev_state *mds, const uuid_t *feat_uuid,
> +				    struct cxl_feat_entry *feat_entry_out)
> +{
> +	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct cxl_feat_entry *feat_entry;
> +	int count;
> +
> +	/* Check CXL dev supports the feature */
> +	feat_entry = &cxlds->cxl_mbox.entries[0];
> +	for (count = 0; count < cxlds->cxl_mbox.num_features; count++, feat_entry++) {
> +		if (uuid_equal(&feat_entry->uuid, feat_uuid)) {
> +			memcpy(feat_entry_out, feat_entry, sizeof(*feat_entry_out));
> +			return 0;
> +		}
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_supported_feature_entry, CXL);
> +
>  /**
>   * cxl_enumerate_cmds() - Enumerate commands for a device.
>   * @mds: The driver data for the operation
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 2a25d1957ddb..f88b10188632 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -530,6 +530,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
>  	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
>  	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
> +	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>  	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>  	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
> @@ -813,6 +814,48 @@ enum {
>  	CXL_PMEM_SEC_PASS_USER,
>  };
>  
> +/* Get Supported Features (0x500h) CXL r3.1 8.2.9.6.1 */
> +struct cxl_mbox_get_sup_feats_in {
> +	__le32 count;
> +	__le16 start_idx;
> +	u8 reserved[2];
> +} __packed;
> +
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
> +struct cxl_feat_entry {
> +	uuid_t uuid;
> +	__le16 id;
> +	__le16 get_feat_size;
> +	__le16 set_feat_size;
> +	__le32 attr_flags;
> +	u8 get_feat_ver;
> +	u8 set_feat_ver;
> +	__le16 set_effects;
> +	u8 reserved[18];
> +} __packed;
> +
> +struct cxl_mbox_get_sup_feats_out {
> +	__le16 num_entries;
> +	__le16 supported_feats;
> +	u8 reserved[4];
> +	struct cxl_feat_entry ents[] __counted_by_le(supported_feats);
> +} __packed;
> +
>  int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>  			  struct cxl_mbox_cmd *cmd);
>  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
> @@ -872,4 +915,8 @@ struct cxl_hdm {
>  struct seq_file;
>  struct dentry *cxl_debugfs_create_dir(const char *dir);
>  void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
> +
> +int cxl_get_supported_features(struct cxl_memdev_state *mds);
> +int cxl_get_supported_feature_entry(struct cxl_memdev_state *mds, const uuid_t *feat_uuid,
> +				    struct cxl_feat_entry *feat_entry_out);
>  #endif /* __CXL_MEM_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 188412d45e0d..5c2926eec3c3 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -887,6 +887,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_get_supported_features(mds);
> +	if (rc)
> +		dev_dbg(&pdev->dev, "No features enumerated.\n");
> +
>  	rc = cxl_set_timestamp(mds);
>  	if (rc)
>  		return rc;
> diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
> index bacd111e75f1..cc66afec3473 100644
> --- a/include/cxl/mailbox.h
> +++ b/include/cxl/mailbox.h
> @@ -14,6 +14,8 @@ struct cxl_mbox_cmd;
>   * @mbox_mutex: mutex protects device mailbox and firmware
>   * @mbox_wait: rcuwait for mailbox
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
> + * @num_features: number of supported features
> + * @entries: list of supported feature entries.
>   */
>  struct cxl_mailbox {
>  	struct device *host;
> @@ -21,6 +23,8 @@ struct cxl_mailbox {
>  	struct mutex mbox_mutex; /* lock to protect mailbox context */
>  	struct rcuwait mbox_wait;
>  	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
> +	int num_features;
> +	struct cxl_feat_entry *entries;
>  };
>  
>  int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host);
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index c6c0fe27495d..bd2535962f70 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -50,6 +50,7 @@
>  	___C(GET_LOG_CAPS, "Get Log Capabilities"),			  \
>  	___C(CLEAR_LOG, "Clear Log"),					  \
>  	___C(GET_SUP_LOG_SUBLIST, "Get Supported Logs Sub-List"),	  \
> +	___C(GET_SUPPORTED_FEATURES, "Get Supported Features"),		  \
>  	___C(MAX, "invalid / last command")
>  
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a


