Return-Path: <linux-edac+bounces-2324-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A441E9B4E70
	for <lists+linux-edac@lfdr.de>; Tue, 29 Oct 2024 16:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3901F238E5
	for <lists+linux-edac@lfdr.de>; Tue, 29 Oct 2024 15:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB926195B33;
	Tue, 29 Oct 2024 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gh4vP0AI"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F10F195F04;
	Tue, 29 Oct 2024 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216879; cv=none; b=Xfcmz/2xtm5FQSl12UoM+gOvEY0sesdeW9QMAQaIIiFVe73WxE0K4SnqHh+Ybi+HcCG1DbAQyGbqMm2yuUEUdvOzJBaXkzuilbiuc5B8oIohLKa2GWEJn+vOPwmq9t7YPJr2eEkvKMGsSQfldLroV7QIc4xLTnbPvsia+VJQHLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216879; c=relaxed/simple;
	bh=1r7A7ww7pBafTuQhRqV8UGyD9vtwIwKAIJ+slSK3Huo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7X0ErKpSLsn2zZR+gyzAmj3hog/TZGzuNo64SYKvmqUsOjBDGjhPgm7cuAT3fLMxd+x5Mltcc+OHkJpmDQ3OTWKqNHw7O42NbtGAMPFf8JQ7SfTZCn0syrhKVL2N2gJvxS0Tn2tN9FW616Zsf2n/anB/exPoeJu+1PHR2QywaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gh4vP0AI; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730216877; x=1761752877;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1r7A7ww7pBafTuQhRqV8UGyD9vtwIwKAIJ+slSK3Huo=;
  b=Gh4vP0AI5Sra2qpiFAKJtsQZs8QaPxQtmCx0IcHt0CMRsoeCehZiKuum
   kSQQOrhGCYA+jsVTXMLKLCbGjatRTLZWo3ZHOBMum/nIk5r25JqTbhGH8
   MP9pGPki2I5ZmEY27qOsQyGcdhVVbxT/gBudRAy6TgWR3c4Y8ZmkTSHdL
   vVAZGFZMDXZ5UvIkvDTF9GYgx3Ccz7RR+BhjeIqzYUi1SyGRuiIdkCtnb
   bllf0/ng39/dZyv+VrNzzzsTIp2qPI4ag7yOoFfM4uww9Fy3DECLrIFY+
   PamjqvDpzzvKeN25s+xfXu8a+EQafm7mgouyokg9uQMrclHS8QCAneZ1Q
   g==;
X-CSE-ConnectionGUID: 0zhCKl19QeKFP5amqKNYcg==
X-CSE-MsgGUID: MvcSMe6YQbuOvXxcs9g9qA==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="55271699"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="55271699"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:47:56 -0700
X-CSE-ConnectionGUID: V5pPOSHlTGSDjrkfWJdvXQ==
X-CSE-MsgGUID: A3P6Yq5GSUSlKa7JmZm7uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="112817297"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.125.108.71]) ([10.125.108.71])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:47:53 -0700
Message-ID: <c0081406-b320-4495-9a32-f4cc3e881920@intel.com>
Date: Tue, 29 Oct 2024 08:47:51 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 05/14] cxl/mbox: Add GET_FEATURE mailbox command
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
 <20241025171356.1377-6-shiju.jose@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241025171356.1377-6-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 10:13 AM, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for GET_FEATURE mailbox command.
> 
> CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
> The settings of a feature can be retrieved using Get Feature command.
> CXL spec 3.1 section 8.2.9.6.2 describes Get Feature command.
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/mbox.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 26 ++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 5045960e3bfe..3cd4bce2872d 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -970,6 +970,47 @@ int cxl_get_supported_feature_entry(struct cxl_memdev_state *mds, const uuid_t *
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_get_supported_feature_entry, CXL);
>  
> +size_t cxl_get_feature(struct cxl_memdev_state *mds, const uuid_t feat_uuid,
> +		       enum cxl_get_feat_selection selection,
> +		       void *feat_out, size_t feat_out_size)
> +{
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +	size_t data_to_rd_size, size_out;
> +	struct cxl_mbox_get_feat_in pi;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	size_t data_rcvd_size = 0;
> +	int rc;
> +
> +	if (!feat_out || !feat_out_size)
> +		return 0;
> +
> +	size_out = min(feat_out_size, cxl_mbox->payload_size);
> +	pi.uuid = feat_uuid;
> +	pi.selection = selection;
> +	do {
> +		data_to_rd_size = min(feat_out_size - data_rcvd_size,
> +				      cxl_mbox->payload_size);
> +		pi.offset = cpu_to_le16(data_rcvd_size);
> +		pi.count = cpu_to_le16(data_to_rd_size);
> +
> +		mbox_cmd = (struct cxl_mbox_cmd) {
> +			.opcode = CXL_MBOX_OP_GET_FEATURE,
> +			.size_in = sizeof(pi),
> +			.payload_in = &pi,
> +			.size_out = size_out,
> +			.payload_out = feat_out + data_rcvd_size,
> +			.min_out = data_to_rd_size,
> +		};
> +		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +		if (rc < 0 || !mbox_cmd.size_out)
> +			return 0;
> +		data_rcvd_size += mbox_cmd.size_out;
> +	} while (data_rcvd_size < feat_out_size);
> +
> +	return data_rcvd_size;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
> +
>  /**
>   * cxl_enumerate_cmds() - Enumerate commands for a device.
>   * @mds: The driver data for the operation
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index f88b10188632..0c152719669a 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -531,6 +531,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
>  	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
>  	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
> +	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>  	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>  	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
> @@ -856,6 +857,28 @@ struct cxl_mbox_get_sup_feats_out {
>  	struct cxl_feat_entry ents[] __counted_by_le(supported_feats);
>  } __packed;
>  
> +/*
> + * Get Feature CXL 3.1 Spec 8.2.9.6.2
> + */
> +
> +/*
> + * Get Feature input payload
> + * CXL rev 3.1 section 8.2.9.6.2 Table 8-99
> + */
> +enum cxl_get_feat_selection {
> +	CXL_GET_FEAT_SEL_CURRENT_VALUE,
> +	CXL_GET_FEAT_SEL_DEFAULT_VALUE,
> +	CXL_GET_FEAT_SEL_SAVED_VALUE,
> +	CXL_GET_FEAT_SEL_MAX
> +};
> +
> +struct cxl_mbox_get_feat_in {
> +	uuid_t uuid;
> +	__le16 offset;
> +	__le16 count;
> +	u8 selection;
> +}  __packed;
> +
>  int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>  			  struct cxl_mbox_cmd *cmd);
>  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
> @@ -919,4 +942,7 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
>  int cxl_get_supported_features(struct cxl_memdev_state *mds);
>  int cxl_get_supported_feature_entry(struct cxl_memdev_state *mds, const uuid_t *feat_uuid,
>  				    struct cxl_feat_entry *feat_entry_out);
> +size_t cxl_get_feature(struct cxl_memdev_state *mds, const uuid_t feat_uuid,
> +		       enum cxl_get_feat_selection selection,
> +		       void *feat_out, size_t feat_out_size);
>  #endif /* __CXL_MEM_H__ */


