Return-Path: <linux-edac+bounces-1917-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1F4983A6F
	for <lists+linux-edac@lfdr.de>; Tue, 24 Sep 2024 01:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC59283F18
	for <lists+linux-edac@lfdr.de>; Mon, 23 Sep 2024 23:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444E512C522;
	Mon, 23 Sep 2024 23:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ggzm9+oK"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CB44086A;
	Mon, 23 Sep 2024 23:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727134449; cv=none; b=vEQ2EJuiDJ9yDH6a0266TGD5q37vqcE5IXy3S3DOvk2CZ18WpmR7Sbc1yNjzKMTBNCc8ir5gR+ETixRaZMudmV6odjPDTgIx+HKHtFY64IWtYKNH8a6MevFLQZLkHKlkGq9rjdi1Xt3nNwSykUHxgQXSGDmMxK4uSQU5rVXXgKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727134449; c=relaxed/simple;
	bh=hSD0i85j+tjvKFYyuQIW0mIfubhRUwbT1lcGFlgwZb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZRZDmvVPHpVqxRbPDrDouzMQTk0gwbtg67vYEcvIvUJRVR444yj8N4plcoWm49YarQRN3ytkQzTaCidF4M8lyhAOUPvh5TeqiBSpjP1gUn6IjlJu+YSPaDXylcsHH+jWwa2hK0a5EktCNjLGUtdFfSZ2Quh9xx0MiccpyypiU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ggzm9+oK; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727134447; x=1758670447;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hSD0i85j+tjvKFYyuQIW0mIfubhRUwbT1lcGFlgwZb8=;
  b=Ggzm9+oKWYpmuqFSX65YaEjWzs/rquT+2YiMnh33VwvE0Weo0M+DVe0H
   0erKMiuF6X9G6y+GMNcQXOgLcTp1S11uCHQ8Gy4q6qp4y3m5lKmpE2qa6
   6c6j3xEvt4lDiIIa5Y+eLrlZKp4mUUytILZEB9YQ2cu5MEo5rASQtg3yp
   Fz+3THm/NkdIv3g4AxUMsiu1oKDox2rUZIseQRBfT8/g15qspgEyip2k1
   k1PraqYCnJBCra95dZRm5LuQDs60riHpkT8i3kgYBMjfeSmd9dTx7JOV2
   RNbvPFAS0R1WDFCcQlZCLcrzKgnKLrJOkoaXrU00A6qin7fGrDe+NO/jS
   g==;
X-CSE-ConnectionGUID: NCC1l884SSq5vKvGobZ4cA==
X-CSE-MsgGUID: Z4903ea1RSysucm6djya8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="37469731"
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="37469731"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 16:34:06 -0700
X-CSE-ConnectionGUID: G+BMe5cWR3CZ7Q3uhVgorQ==
X-CSE-MsgGUID: NiifIsfgTY2r28Cytw8kRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="71219457"
Received: from tcingleb-desk1.amr.corp.intel.com (HELO [10.125.110.203]) ([10.125.110.203])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 16:33:56 -0700
Message-ID: <2a811714-b354-4da9-993c-9dabdbabb86e@intel.com>
Date: Mon, 23 Sep 2024 16:33:55 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 07/17] cxl: Add Get Supported Features command for
 kernel usage
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
References: <20240911090447.751-1-shiju.jose@huawei.com>
 <20240911090447.751-8-shiju.jose@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240911090447.751-8-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/11/24 2:04 AM, shiju.jose@huawei.com wrote:
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
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/mbox.c      | 175 +++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h         |  51 ++++++++++
>  drivers/cxl/pci.c            |   4 +
>  include/uapi/linux/cxl_mem.h |   1 +
>  4 files changed, 231 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index fa1ee495a4e3..fe965ec5802f 100644
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
> @@ -790,6 +791,180 @@ static const uuid_t log_uuid[] = {
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
> +	cxlds->num_features = le16_to_cpu(mbox_out.supported_feats);
> +	if (!cxlds->num_features)
> +		return -ENOENT;
> +
> +	return 0;
> +}
> +
> +int cxl_get_supported_features(struct cxl_dev_state *cxlds)
> +{
> +	int remain_feats, max_size, max_feats, start, rc;
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
> +	if (!test_bit(cmd->info.id, cxl_mbox->enabled_cmds))
> +		return -EOPNOTSUPP;
> +
> +	rc = cxl_get_supported_features_count(cxlds);
> +	if (rc)
> +		return rc;
> +
> +	struct cxl_feat_entry *entries __free(kvfree) =
> +		kvmalloc(cxlds->num_features * feat_size, GFP_KERNEL);
> +
> +	if (!entries)
> +		return -ENOMEM;
> +
> +	cxlds->entries = no_free_ptr(entries);
> +	rc = devm_add_action_or_reset(cxl_mbox->host, cxl_free_features,
> +				      cxlds->entries);
> +	if (rc)
> +		return rc;
> +
> +	max_size = cxl_mbox->payload_size - hdr_size;
> +	/* max feat entries that can fit in mailbox max payload size */
> +	max_feats = max_size / feat_size;
> +	ptr = &cxlds->entries[0];
> +
> +	mbox_out = kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
> +	if (!mbox_out)
> +		return -ENOMEM;
> +
> +	start = 0;
> +	remain_feats = cxlds->num_features;
> +	do {
> +		int retrieved, alloc_size, copy_feats;
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
> +		if (rc < 0) {
> +			kfree(mbox_out);
> +			return rc;
> +		}
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
> +		/*
> +		 * If the reported output entries * defined entry size !=
> +		 * retrieved output bytes, then the output package is incorrect.
> +		 */
> +		if (mbox_out->num_entries * feat_size != retrieved) {
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
> +	} while (remain_feats);
> +
> +	kfree(mbox_out);
> +	return 0;
> +
> +err:
> +	kfree(mbox_out);
> +	cxlds->num_features = 0;
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
> +
> +int cxl_get_supported_feature_entry(struct cxl_dev_state *cxlds, const uuid_t *feat_uuid,
> +				    struct cxl_feat_entry *feat_entry_out)
> +{
> +	struct cxl_feat_entry *feat_entry;
> +	int count;
> +
> +	/* Check CXL dev supports the feature */
> +	feat_entry = &cxlds->entries[0];
> +	for (count = 0; count < cxlds->num_features; count++, feat_entry++) {
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
> index d7c6ffe2a884..5d149e64c247 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -389,6 +389,8 @@ struct cxl_dpa_perf {
>   * @ram_res: Active Volatile memory capacity configuration
>   * @serial: PCIe Device Serial Number
>   * @type: Generic Memory Class device or Vendor Specific Memory device
> + * @features: number of supported features
> + * @entries: list of supported feature entries.
>   */
>  struct cxl_dev_state {
>  	struct device *dev;
> @@ -404,6 +406,8 @@ struct cxl_dev_state {
>  	u64 serial;
>  	enum cxl_devtype type;
>  	struct cxl_mailbox cxl_mbox;
> +	int num_features;
> +	struct cxl_feat_entry *entries;

Hi Shiju,
Going back and refactoring the fwctl code, I think this needs to stay with cxl_mailbox. Otherwise it makes it really hard to verify the feature effects for userspace. Preferably I don't think we want to expose 'struct cxl_dev_state' to fwctl if we don't need to.

DJ

>  };
>  
>  /**
> @@ -482,6 +486,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
>  	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
>  	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
> +	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>  	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>  	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
> @@ -765,6 +770,48 @@ enum {
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
> +	struct cxl_feat_entry ents[] __counted_by(le32_to_cpu(supported_feats));
> +} __packed;
> +
>  int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>  			  struct cxl_mbox_cmd *cmd);
>  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
> @@ -824,4 +871,8 @@ struct cxl_hdm {
>  struct seq_file;
>  struct dentry *cxl_debugfs_create_dir(const char *dir);
>  void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
> +
> +int cxl_get_supported_features(struct cxl_dev_state *cxlds);
> +int cxl_get_supported_feature_entry(struct cxl_dev_state *cxlds, const uuid_t *feat_uuid,
> +				    struct cxl_feat_entry *feat_entry_out);
>  #endif /* __CXL_MEM_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 3c73de475bf3..cec88e3a1754 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -872,6 +872,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_get_supported_features(cxlds);
> +	if (rc)
> +		dev_dbg(&pdev->dev, "No features enumerated.\n");
> +
>  	rc = cxl_set_timestamp(mds);
>  	if (rc)
>  		return rc;
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


