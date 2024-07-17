Return-Path: <linux-edac+bounces-1544-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C20CA93430D
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jul 2024 22:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D371C21408
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jul 2024 20:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681671836D8;
	Wed, 17 Jul 2024 20:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtoj9gkj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC715179AD;
	Wed, 17 Jul 2024 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721247259; cv=none; b=V1UaS1fhlAAsL9N+KzSlwDgbnVYBWJmpxPVXGavN/ZVKqeTu3rgYsI3vgf1Xz/xYn32o9YSjOtBSFs4Q9iFtgQsJStJa1NA2fr4hcxfzs4kyTOskgXVDx5ubWHdtI9OeSRxzmavPwP7GZ+QQg4LeK7vreto91tvBG8RFHDdlLBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721247259; c=relaxed/simple;
	bh=xNNbEltvBNstAuzXBHYrUPFYJmSVyE1LGy8LE3b3HnA=;
	h=Message-ID:From:Date:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZyJiPzKycMzSBjk6SK0vL8mGcZT8oxmoZJoVBOahuUdPkWYrMcZdZ3loDX3fo/d87x71zxRH4gDk3EBwlv0iE8cnFiMJI0pOdGouKIVvE7GDncE5rs5unGCHqG1YoiyCsV68I9Vnjp7/eO/hPuX2PqTw5PcaPLQnuKTehp52Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtoj9gkj; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70af5fbf0d5so31837b3a.1;
        Wed, 17 Jul 2024 13:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721247257; x=1721852057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=daNuErFTSxwNgtYvkZnLX9Xo2Y1uZdZanNQORu0umVM=;
        b=mtoj9gkjhYVKlIQgsg0OVlH9+taaCUaJeK2INVPsW7kvJiU0lmcvSNphewtrv0rEsN
         lY0JOF8VjmzCp8b8fMoriMgFYbgWXE1d807uYb0mqUXdI+Qd7oMRaOAxy1VI2qeKQ3BK
         Y3CLQwKSwDQuabsfqRyEvoq/i41c+d3k5F2Um0pUD9TFgHgXVZ6V0CaEGqFztd00a2fC
         pi0Fw3tjkJlPKoAXly/jU7HUELt2/Esrtp7hOGy8NUi6+PG0RO7h7PnLE0yUhk21yVhh
         /eYQfZhEDaZTSmpf3fIZqvBEnzfNqHmdf08ngNAK1jCUBgnA4yHTHnGJCTUTMo14Hmfo
         +uKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721247257; x=1721852057;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daNuErFTSxwNgtYvkZnLX9Xo2Y1uZdZanNQORu0umVM=;
        b=eUbZSV4ImaA4jI0nbuZ7nN05BJCUcuXU6t/gNtrBRx4MkCb5Rwdy+vXOspqTh6D5Ny
         RYLhI2JL2hOEQSRCA4H7UTNcY7gb0fCuBnjKtZcU4rBum+hVJzpCoSy/0Exr5wAktntW
         K+9B/6nd+3iFrA/zHkxz90ZysgjyJyI/ZhiVLAsCCRekWN9YKGP8ybi+gK05KT/Z6sJZ
         GlYi7q1qj38PykUADf+klCZJ/s/+dZDnWV222AK43M3bi5o08Aqi2Pk5Wl8oh0Xvyuko
         C/1NEmhPROOnIX2LXxxkg1KsDAxu5P88AbCaEHSVVohXYLzF5NeKbJGZVj1JF6NG3K59
         DZUA==
X-Forwarded-Encrypted: i=1; AJvYcCWcevZ6JuZY6wze4bxtGZrnncyAMWu8ecQTThGE0xIU1b+lffO3tUJTPJ/kUWHdW3K6A7tdLWGkOph3k/kyxGBjWkBKEE15a6aNy0YvvEFDGjCmKuRSZFY2LdO7ItKPQJ5dAFiYuqtdbuc//LanhDfXfVyeyt7Bj1Cb8vmHt7/WvR0sJA==
X-Gm-Message-State: AOJu0YwXwLRnsuiyW43xUs1OLnm/k8TnCwCb3ZsfkTWBvidK1rVhC1Ln
	peasey7SOejTYHPkwVU9t61HP7hsWd41xHFMuEbHGeIm1YV2MWDdmjyvGM7Lm7o=
X-Google-Smtp-Source: AGHT+IF5kHZANzfmOuN3NHMVCFtUNfv4eZvOTbdQnE/ovfd+OsiFk9AgplhBsKw31KkgMYYXs29mag==
X-Received: by 2002:a05:6a00:1ace:b0:705:ade3:2e79 with SMTP id d2e1a72fcca58-70ceebbff83mr1025900b3a.13.1721247256867;
        Wed, 17 Jul 2024 13:14:16 -0700 (PDT)
Received: from gpd. ([179.61.150.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9c861sm8516650b3a.24.2024.07.17.13.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 13:14:16 -0700 (PDT)
Message-ID: <66982618.050a0220.e9611.19eb@mx.google.com>
X-Google-Original-Message-ID: <Zpgl7gWUJcOeFMPm@gpd.>
From: nifan.cxl@gmail.com
X-Google-Original-From: fan@gpd.
Date: Wed, 17 Jul 2024 13:13:34 -0700
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
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com, linuxarm@huawei.com
Subject: Re: [RFC PATCH v9 06/11] cxl/mbox: Add SET_FEATURE mailbox command
References: <20240716150336.2042-1-shiju.jose@huawei.com>
 <20240716150336.2042-7-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716150336.2042-7-shiju.jose@huawei.com>

On Tue, Jul 16, 2024 at 04:03:30PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for SET_FEATURE mailbox command.
> 
> CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
> CXL devices supports features with changeable attributes.
> The settings of a feature can be optionally modified using Set Feature
> command.

Add more specific spec reference to the command here: 8.2.9.6.3.
The same suggestions for get supported features and get feature commands.

> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/mbox.c | 71 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 33 +++++++++++++++++++
>  2 files changed, 104 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index b1eeed508459..50ecd2bd7372 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1388,6 +1388,77 @@ size_t cxl_get_feature(struct cxl_memdev_state *mds,
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
> +					kmalloc(mds->payload_size, GFP_KERNEL);
> +	pi->hdr.uuid = feat_uuid;
> +	pi->hdr.version = feat_version;
> +	feat_flag &= ~CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK;

Although we may not support it yet, should we set bit[3] (saved across reset) 
since we already defined CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET and
it is not used?

Fan
> +	hdr_size = sizeof(pi->hdr);
> +	/*
> +	 * Check minimum mbox payload size is available for
> +	 * the feature data transfer.
> +	 */
> +	if (hdr_size + FEAT_DATA_MIN_PAYLOAD_SIZE > mds->payload_size)
> +		return -ENOMEM;
> +
> +	if ((hdr_size + feat_data_size) <= mds->payload_size) {
> +		pi->hdr.flags = cpu_to_le32(feat_flag |
> +				       CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER);
> +		data_in_size = feat_data_size;
> +	} else {
> +		pi->hdr.flags = cpu_to_le32(feat_flag |
> +				       CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER);
> +		data_in_size = mds->payload_size - hdr_size;
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
> +		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +		if (rc < 0)
> +			return rc;
> +
> +		data_sent_size += data_in_size;
> +		if (data_sent_size >= feat_data_size)
> +			return 0;
> +
> +		if ((feat_data_size - data_sent_size) <= (mds->payload_size - hdr_size)) {
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
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr)
>  {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 25698a6fbe66..c3cb8e2736b5 100644
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
> @@ -780,6 +781,34 @@ struct cxl_mbox_get_feat_in {
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
>  /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
>  struct cxl_mbox_poison_in {
>  	__le64 offset;
> @@ -918,6 +947,10 @@ size_t cxl_get_feature(struct cxl_memdev_state *mds,
>  		       const uuid_t feat_uuid, void *feat_out,
>  		       size_t feat_out_size,
>  		       enum cxl_get_feat_selection selection);
> +int cxl_set_feature(struct cxl_memdev_state *mds,
> +		    const uuid_t feat_uuid, u8 feat_version,
> +		    void *feat_data, size_t feat_data_size,
> +		    u8 feat_flag);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr);
> -- 
> 2.34.1
> 

