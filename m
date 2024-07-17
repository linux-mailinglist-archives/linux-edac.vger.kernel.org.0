Return-Path: <linux-edac+bounces-1543-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831D49341ED
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jul 2024 20:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2591B231C2
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jul 2024 18:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F211836C4;
	Wed, 17 Jul 2024 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4CP3JXR"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A72918308B;
	Wed, 17 Jul 2024 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721239700; cv=none; b=K8PvVmOntBTn2EngKOwlYxLe/vg/vKwjKsMC5NYsDCpPLkFW+6gI0hXNVtQRxrhXbO3e58MdRzAVzPnFFppVF44WmQh9nlenoRNhUxW4xRaBzXrieOXwWuYqr1DVZwYEdMLnbBkglBysoblWEBlQHZsGBOXESHPweBE2aU9WDwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721239700; c=relaxed/simple;
	bh=F4NzR5ll2wrSSp1uKEL0LqAYuV7yMz4JRnfuxf/+fac=;
	h=Message-ID:From:Date:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZg0GhgoIopHubBUJG90qIFx4ZJSRVSJdU1aEij3f383bBp5QQnlZ4EivtgCYwxva5kgkG2RH/tbpRPkca3WsqDafP+RhRoa3lG7Z+uAEuethUMtVfgu5tTsk9kqHwxv7x6R9vckKrpf/kJSqoT/vjz7P4cbqrrrpTnLnvnblqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4CP3JXR; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-65f880c56b1so643117b3.3;
        Wed, 17 Jul 2024 11:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721239697; x=1721844497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SM8B6LA4jj99Kbv5K8wStDsRnXQT55BhF1QFuulRqec=;
        b=C4CP3JXRSQTdrqi0paoBcB/FFPYICNdI1tDul8cnTtUMn1Z5PxNsdQ1q6QbE3IlfEw
         IVBRmUS5uvuNh30zx44OmJdIMlSroivJIf5VCOOn9AirkrkcKXU93ywwIoVLg0nTmujv
         aaD22OxEaUyviu8IuyvMIcIc54f46vT5ykzY7RvA0Czg7Vlz+ch2s89bW2L/YH3n25Oj
         OSUBk8eIYculYdSpIDKaUitmUyKCZcC2BVXTtj1ego6LuKXW9zUNYd/Z2wg8M7qkhokM
         GZE8VEqIXF3UNceiNgPF3iAJ+3pUUQ7f7queFicvKkPVt6i21/TYslCiy92xVyEmi92F
         EU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721239697; x=1721844497;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SM8B6LA4jj99Kbv5K8wStDsRnXQT55BhF1QFuulRqec=;
        b=jw1qbigsI4s/X8kZXg/LllV0AHz9cMUVubJ/mOuAGwhZfA4MNh+MtQ3UPVgojx9KJK
         5Bt0TU2mJMvdRoFC7N/ew2pbNJGeb+tbkjTC5VEJAbhZc3xPWIW++5XBpOKoPPb3njRT
         AFtEisfjuyQ2+QHxBxkTJzm5UOY5UqgvZeAgHuICnTf18f7gzfKAaFc4+RFsjaQzb3qZ
         VVRAOOyaemk+I0Bd9sn86ajHzknY2SHTPc/ap8p55B5sB8lQYxRirJK1y9r32wZB99WX
         as9NTWQ7D6N3/7wYRJhWlRfVJwYOI4xKQ5ntbRIoSAGqbY2SHWOnF0W9+HA463SwS3Px
         Hkhg==
X-Forwarded-Encrypted: i=1; AJvYcCWhDVkAHr+CJ2zufcIgavUixiAfskRpCryM+0jSQiUxwykQ1mWyi4QjKW3Q6q4ICI8JxsJh9xK7Y+3f6z9lmc+I/FPwID+iGXNGNmgMMzrm1UkydcqFMGBQEbKuzdXJiOTZFiZ8BfRoGyAXnJiVMBoELfUlaf50NIngRG2nSqobpFqmHw==
X-Gm-Message-State: AOJu0YwYG7SimtrbPQUsSuH82s3ZULNBF/WSm15WxVHDoyYUp1GymBLG
	IL5oBzkOvwm59nxsgYB1uOjxV8ixKmWMmktslQ/mclbuVqEXjmy8
X-Google-Smtp-Source: AGHT+IHQBEBVoCRtBjoPhAyhO3eQWipybCFEBSsjB0FYqh4mtyicuQyDqJ+jopQJCfhOPsbMPIA3aA==
X-Received: by 2002:a05:690c:23c1:b0:61a:e4ef:51d with SMTP id 00721157ae682-664fde8015fmr36193407b3.9.1721239697207;
        Wed, 17 Jul 2024 11:08:17 -0700 (PDT)
Received: from gpd. ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-66603ed22a1sm187567b3.120.2024.07.17.11.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 11:08:16 -0700 (PDT)
Message-ID: <66980890.050a0220.163b98.0210@mx.google.com>
X-Google-Original-Message-ID: <ZpgIjBfNPPPf4xZf@gpd.>
From: nifan.cxl@gmail.com
X-Google-Original-From: fan@gpd.
Date: Wed, 17 Jul 2024 11:08:12 -0700
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
Subject: Re: [RFC PATCH v9 05/11] cxl/mbox: Add GET_FEATURE mailbox command
References: <20240716150336.2042-1-shiju.jose@huawei.com>
 <20240716150336.2042-6-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716150336.2042-6-shiju.jose@huawei.com>

On Tue, Jul 16, 2024 at 04:03:29PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for GET_FEATURE mailbox command.
> 
> CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
> The settings of a feature can be retrieved using Get Feature command.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
Minor comments inline.

>  drivers/cxl/core/mbox.c | 37 +++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 27 +++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 9b9b1d26454e..b1eeed508459 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1351,6 +1351,43 @@ int cxl_get_supported_features(struct cxl_memdev_state *mds,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
>  
> +size_t cxl_get_feature(struct cxl_memdev_state *mds,
> +		       const uuid_t feat_uuid, void *feat_out,
> +		       size_t feat_out_size,
> +		       enum cxl_get_feat_selection selection)
feat_uuid and selection are both payload inputs, maybe more natural to put
them together before feat_out.
> +{
> +	size_t data_to_rd_size, size_out;
> +	struct cxl_mbox_get_feat_in pi;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	size_t data_rcvd_size = 0;
> +	int rc;
> +
> +	size_out = min(feat_out_size, mds->payload_size);
> +	pi.uuid = feat_uuid;
> +	pi.selection = selection;
> +	do {
> +		data_to_rd_size = min(feat_out_size - data_rcvd_size, mds->payload_size);
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
> +		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +		if (rc < 0 || mbox_cmd.size_out == 0)
Is there other case when size_out will be 0 other than the feat_out_size
is 0?

If feat_out_size is 0, maybe we return directly, or we use while () {},
instead of do {} while.
Anyway, if there is no other case that will return size_out as 0, we can
avoid the check.

Fan
> +			return 0;
> +		data_rcvd_size += mbox_cmd.size_out;
> +	} while (data_rcvd_size < feat_out_size);
> +
> +	return data_rcvd_size;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
> +
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr)
>  {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index b0e1565b9d2e..25698a6fbe66 100644
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
> @@ -757,6 +758,28 @@ struct cxl_mbox_get_supp_feats_out {
>  	struct cxl_mbox_supp_feat_entry feat_entries[];
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
>  /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
>  struct cxl_mbox_poison_in {
>  	__le64 offset;
> @@ -891,6 +914,10 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_get_supported_features(struct cxl_memdev_state *mds,
>  			       u32 count, u16 start_index,
>  			       struct cxl_mbox_get_supp_feats_out *feats_out);
> +size_t cxl_get_feature(struct cxl_memdev_state *mds,
> +		       const uuid_t feat_uuid, void *feat_out,
> +		       size_t feat_out_size,
> +		       enum cxl_get_feat_selection selection);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr);
> -- 
> 2.34.1
> 

