Return-Path: <linux-edac+bounces-1938-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D578698AA6B
	for <lists+linux-edac@lfdr.de>; Mon, 30 Sep 2024 18:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605DC1F23CE4
	for <lists+linux-edac@lfdr.de>; Mon, 30 Sep 2024 16:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20975193418;
	Mon, 30 Sep 2024 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7BaN4o9"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5B3824A3;
	Mon, 30 Sep 2024 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715558; cv=none; b=qh/FI+kKNL2cK758udxWAIJFqwCPhgZwQGR6TDxteKSajfrGyj48KJejchRZjwYVLm9poPF//0KI8/csMCAWy94pQeWzf4cwv9Q/bcEZvSdN3U2JVmLzjh2qFpSScU81OH8HJj9Klx2v+FxNWHnwZVdY4DqxxWSonwlpKeqykXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715558; c=relaxed/simple;
	bh=mejX5KlryBRXSTtjex2odlDbpqIl2cbM70qBFZFdl6c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9i6vdt8N9XIMTqEm+JOzEJT7UnIQBwTN47shdDkN+UzcxzXW1paqIGFb0CfjvgZDF3JkiiUNO2e9zTHZ8phXUuzhaGE/X5X6ivvWASO3mrG/yMk8j4fYJ5gps8k/fBtWUr+AfIUOpdps/437H+GWJmi3dnY+FY1SZm/IF+ivSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7BaN4o9; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6de14e0f050so37536087b3.0;
        Mon, 30 Sep 2024 09:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727715555; x=1728320355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qwExymp8z6/0tjlloTrSYWWOshTAEGnshQb8H1Fv5Cg=;
        b=l7BaN4o99uCSna+u+A4fcqOJjvvjnD1zy77Gfjx6GTa6Nrmrglc+S4ufOowZcauRlN
         zhwyMf6+7eXL1VMDDieOQHjfCqpBRPO/KSdhb84ee/+AI+zKumLCB4mzAOEEtHBJ+a1U
         yCUWtwcH5K4fmIlCxA1czX/M8ko9Sy2Ji8wyobex6EO/eqSMr7TUpLPSQrSwq1zyDvIE
         Hcv0grqZBdWoktmrkg4UeetxylwldaxAxJ8iP2TwmR+vnYoFDHY+xnxA4lETSBHqZhlv
         po7l/e40qc8GBOPD22jNgCPXTsKO+9gJnZGna5Gm7r6/VGu9oJgo5PuIlzJ3m8zldjrU
         AXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727715555; x=1728320355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwExymp8z6/0tjlloTrSYWWOshTAEGnshQb8H1Fv5Cg=;
        b=H0H4JB4XbNrL5YTAAuJj+2990alI4vWyknkypLEA56jvJHSYcRFHTDdZYbrrg5Osvw
         GVIlHl5rGlSlPhjRP+y+7izAb3cnHc4eEqQwQkWdAyqSXAN6ouneFTLRWP9sucrKhRR5
         +lAAC7z/If17NoT31EwoiEgHOBcNyzil9OEIsKYJ4gOfER39IHdD/FD5rQBLof8FDs6s
         bVTK7OHKLDXS3B29N49YLfTpfVauDIBO7fdyfvg2VAIbls5G7c9QfT/XQvB+pfnZvFEB
         KgSCIBYNKWtetgSsm44L4T16A37dvX1edgprmTLU21nLYG1oLmdKcTGfOB9haQv53Qrh
         rX6w==
X-Forwarded-Encrypted: i=1; AJvYcCVJAxWC86FoDvVhx5jxen/4XR0wbiI3hjesFQ0hL66eafqcVvXzTNwM4NTBT0cKOiPHOvwOKnIvYF76LsW2@vger.kernel.org, AJvYcCWYVws66uFSp6O0IvflNVuFfmgEXB4OWSMPSvW/9Gl4iwpBbL/YQ6i4z3xUZN4Kb20pMR+rkMQvtoOs@vger.kernel.org, AJvYcCX6N8GKVV2Qg6te2ERzfAsdeNqAG0/fBnxJjGhE9oIe0OcetU7YTG06tGrvN7Ey2CCK4Zh9nUrPcBWZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yynwdusty5uAHXUYw3zh3qY59CQssPnDHMMncXQPPOt9dEKALQq
	3UhSbLrA2JBauHEa+UFRzuWoOTxJKepBQYDe2pDijNe1TJSrxo4X
X-Google-Smtp-Source: AGHT+IGdCw6IHDEfxfOgc07NtnjK/791nXenJL9nHV1zg9PEk+IYfqHNVrUbSJV0U1xsPpgO/Vpxgw==
X-Received: by 2002:a05:690c:2512:b0:6e2:2600:ed86 with SMTP id 00721157ae682-6e2475e320amr59611887b3.45.1727715555187;
        Mon, 30 Sep 2024 09:59:15 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2452f7e13sm14583537b3.26.2024.09.30.09.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 09:59:14 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 30 Sep 2024 09:58:53 -0700
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bp@alien8.de, tony.luck@intel.com,
	rafael@kernel.org, lenb@kernel.org, mchehab@kernel.org,
	dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, david@redhat.com, Vilas.Sridharan@amd.com,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, rientjes@google.com,
	jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, mike.malvestuto@intel.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com, jgroves@micron.com,
	vsalve@micron.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v12 09/17] cxl/mbox: Add SET_FEATURE mailbox command
Message-ID: <ZvrYzavk1UrNRBnT@fan>
References: <20240911090447.751-1-shiju.jose@huawei.com>
 <20240911090447.751-10-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911090447.751-10-shiju.jose@huawei.com>

On Wed, Sep 11, 2024 at 10:04:38AM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for SET_FEATURE mailbox command.
> 
> CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
> CXL devices supports features with changeable attributes.
s/supports/support/

Fan
> The settings of a feature can be optionally modified using Set Feature
> command.
> CXL spec 3.1 section 8.2.9.6.3 describes Set Feature command.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/mbox.c | 73 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 34 +++++++++++++++++++
>  2 files changed, 107 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 3dfe411c6556..806b1c8087b0 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1006,6 +1006,79 @@ size_t cxl_get_feature(struct cxl_dev_state *cxlds, const uuid_t feat_uuid,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
>  
> +/*
> + * FEAT_DATA_MIN_PAYLOAD_SIZE - min extra number of bytes should be
> + * available in the mailbox for storing the actual feature data so that
> + * the feature data transfer would work as expected.
> + */
> +#define FEAT_DATA_MIN_PAYLOAD_SIZE 10
> +int cxl_set_feature(struct cxl_dev_state *cxlds,
> +		    const uuid_t feat_uuid, u8 feat_version,
> +		    void *feat_data, size_t feat_data_size,
> +		    u8 feat_flag)
> +{
> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
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
> index 57c9294bb7f3..b565a061a4e3 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -488,6 +488,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
>  	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
>  	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
> +	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>  	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>  	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
> @@ -835,6 +836,35 @@ struct cxl_mbox_get_feat_in {
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
> @@ -901,4 +931,8 @@ int cxl_get_supported_feature_entry(struct cxl_dev_state *cxlds, const uuid_t *f
>  size_t cxl_get_feature(struct cxl_dev_state *cxlds, const uuid_t feat_uuid,
>  		       enum cxl_get_feat_selection selection,
>  		       void *feat_out, size_t feat_out_size);
> +int cxl_set_feature(struct cxl_dev_state *cxlds,
> +		    const uuid_t feat_uuid, u8 feat_version,
> +		    void *feat_data, size_t feat_data_size,
> +		    u8 feat_flag);
>  #endif /* __CXL_MEM_H__ */
> -- 
> 2.34.1
> 

-- 
Fan Ni

