Return-Path: <linux-edac+bounces-2445-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5229BD348
	for <lists+linux-edac@lfdr.de>; Tue,  5 Nov 2024 18:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31041C2276C
	for <lists+linux-edac@lfdr.de>; Tue,  5 Nov 2024 17:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E452D1E25FB;
	Tue,  5 Nov 2024 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWSw5Uk8"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BA91E2007;
	Tue,  5 Nov 2024 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827345; cv=none; b=Z6SMYZw8IgZzFFkqtkNlsP4fttC9RNzMBhhfoVmDaPTdTD9Y3Y+G8SDcksKOB63HexPSZu2t+Nwi/9qQBguuPlAxAXp1GOuQ1KEDI5OSIxLTTXkl6TX6EfQdxqP19ocjRxhM0Hpe+AmZrWhtt2szwemaVyXQZk6BTmKn20tj6k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827345; c=relaxed/simple;
	bh=fOVeXbQGB4t/BL9BtTDqtV361bSwIcfJ/2tZaOWzY+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gH1+GzA2PXv9Ieo6b6ht9NQv+orYlsTJmgP841UT2+6OeYfWOZwWgFr+1su4gKw7QnwIsiBuGo8k93G3WN9eRK14auqsCigNOPSCVxm5AnNafns6Nqx+PIpvurobGVKxIsawcdr/oKVN5IJGi2oFn7JVQ7V7UpfnlXpUZExWa2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWSw5Uk8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730827345; x=1762363345;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fOVeXbQGB4t/BL9BtTDqtV361bSwIcfJ/2tZaOWzY+8=;
  b=EWSw5Uk8uHbQgK4F0Oawk9wCGYwwlX1+vnlKbU+ZJeaRZME9MpZNjpjB
   FBPTZrZlsihA93T3tR6TzU4UVVJMFmOvTq5mQMkZ2xtw3n7ooGFujIKPC
   vGBxxdg0j+9v4ctca3O0HApR4HCJdAE8MC32ogsdqsSfLvBZINng28fup
   CSGg/BMSjK8vModcskywROJYu0G/F4ButVQNCuPy6j7u0+hJPj5wRHtKM
   lYKvAcGktEfQClK8l8nUY9SBI4jVmjmaBq2KdNLBrZTmbtACHs43bRPIF
   wOOX9Lw5+V9ed321RpFxLGIHDVFUbiJBDNjPDzRwMQR44iL33xsYDg0lA
   w==;
X-CSE-ConnectionGUID: SYwGG+QHQhuZA+w4Li+FnA==
X-CSE-MsgGUID: jo7JziRUQr6b/wG/uXh/Qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30545372"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30545372"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 09:22:23 -0800
X-CSE-ConnectionGUID: 8eL9tSElRCKhFF2qqTPsUw==
X-CSE-MsgGUID: dVJ9YNh1Sra4CUon2yA5JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="114875996"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.125.109.253]) ([10.125.109.253])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 09:22:18 -0800
Message-ID: <ddac43ee-858c-4cd6-8319-b3c594d10752@intel.com>
Date: Tue, 5 Nov 2024 10:22:17 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 12/15] cxl/mbox: Add support for PERFORM_MAINTENANCE
 mailbox command
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
 <20241101091735.1465-13-shiju.jose@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241101091735.1465-13-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/1/24 2:17 AM, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for PERFORM_MAINTENANCE mailbox command.
> 
> CXL spec 3.1 section 8.2.9.7.1 describes the Perform Maintenance command.
> This command requests the device to execute the maintenance operation
> specified by the maintenance operation class and the maintenance operation
> subclass.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/mbox.c | 35 +++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 17 +++++++++++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 4b9e62de164b..381cf9d61c85 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1084,6 +1084,41 @@ int cxl_set_feature(struct cxl_memdev_state *mds,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_set_feature, CXL);
>  
> +int cxl_do_maintenance(struct cxl_memdev_state *mds,
> +		       u8 class, u8 subclass,
> +		       void *data_in, size_t data_in_size)
> +{
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +	struct cxl_memdev_maintenance_pi {
> +		struct cxl_mbox_do_maintenance_hdr hdr;
> +		u8 data[];
> +	}  __packed;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	size_t hdr_size;
> +
> +	struct cxl_memdev_maintenance_pi *pi __free(kfree) =
> +					kmalloc(cxl_mbox->payload_size, GFP_KERNEL);
> +	pi->hdr.op_class = class;
> +	pi->hdr.op_subclass = subclass;
> +	hdr_size = sizeof(pi->hdr);
> +	/*
> +	 * Check minimum mbox payload size is available for
> +	 * the maintenance data transfer.
> +	 */
> +	if (hdr_size + data_in_size > cxl_mbox->payload_size)
> +		return -ENOMEM;
> +
> +	memcpy(pi->data, data_in, data_in_size);
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_DO_MAINTENANCE,
> +		.size_in = hdr_size + data_in_size,
> +		.payload_in = pi,
> +	};
> +
> +	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_do_maintenance, CXL);
> +
>  /**
>   * cxl_enumerate_cmds() - Enumerate commands for a device.
>   * @mds: The driver data for the operation
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 9259c5d70a65..28290f7c89f7 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -533,6 +533,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
>  	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
>  	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
> +	CXL_MBOX_OP_DO_MAINTENANCE	= 0x0600,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>  	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>  	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
> @@ -909,6 +910,19 @@ struct cxl_mbox_set_feat_hdr {
>  	u8 rsvd[9];
>  }  __packed;
>  
> +/*
> + * Perform Maintenance CXL 3.1 Spec 8.2.9.7.1
> + */
> +
> +/*
> + * Perform Maintenance input payload
> + * CXL rev 3.1 section 8.2.9.7.1 Table 8-102
> + */
> +struct cxl_mbox_do_maintenance_hdr {
> +	u8 op_class;
> +	u8 op_subclass;
> +}  __packed;
> +
>  int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>  			  struct cxl_mbox_cmd *cmd);
>  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
> @@ -986,4 +1000,7 @@ int cxl_set_feature(struct cxl_memdev_state *mds,
>  		    const uuid_t feat_uuid, u8 feat_version,
>  		    void *feat_data, size_t feat_data_size,
>  		    u8 feat_flag);
> +int cxl_do_maintenance(struct cxl_memdev_state *mds,
> +		       u8 class, u8 subclass,
> +		       void *data_in, size_t data_in_size);
>  #endif /* __CXL_MEM_H__ */


