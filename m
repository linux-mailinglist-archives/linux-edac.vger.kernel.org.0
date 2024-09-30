Return-Path: <linux-edac+bounces-1937-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8F898A995
	for <lists+linux-edac@lfdr.de>; Mon, 30 Sep 2024 18:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D791F24150
	for <lists+linux-edac@lfdr.de>; Mon, 30 Sep 2024 16:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AA1192B89;
	Mon, 30 Sep 2024 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcOpPqcA"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7263BB24;
	Mon, 30 Sep 2024 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713109; cv=none; b=m7WL63aOEPLyiu8zk6pwU/tZGcDmf/xiZikm+wKR4e3+o3KdFzP8qAk+dsySAiO2NeNK3XP/imh0gZVrF3+lCpi/Tyk/z3/vGrM7oeBfLEItksJq0cAjlf44T+EcqYDdc0PDX6K98L5QUqF/M/K++wYRXwD7OrGtEPUBojlsDys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713109; c=relaxed/simple;
	bh=rmRrtaTPc18YV058qlVA4OVTYgYrgme9pPRozC80Cp8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/06Zhkggh2ryV5SyvswDvBhjUW8MSfTSQvgXUhKGMQ6cC4N1/0iVhmuNebO3ncaUde3CY/rD+jXRuEKnZ17OOZ2UlXst8/5y8DyezQAxQ1AlasFjKQ/vOKYGsUiiPgwDl+qT/wKr6bBBZsuOqsVanxcV6O3wdGLfAZaXa1S6vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcOpPqcA; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e1d4368ad91so4489241276.0;
        Mon, 30 Sep 2024 09:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727713107; x=1728317907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2l5r1LZwEKOpEY2ktEbhSxXVhypzkb5WeDgzsoyHkvo=;
        b=RcOpPqcANreT0pWFuLpYbFlHc2WhE+6sx/3wg0DpTHVr//hBmJFOSjhaySz81A66SZ
         nh0Fokg0HFUBVq22MD6rKsgsTjsMSXhN7RC9eU1A6JOVgWuvpLulqtVbOsO2a5wH9lEZ
         7/V0EkYcfNrf6uReMiSHzY2g/zcaJBR7wk1jH/UUXER5yumBsCzMhRlESdgZovsp1lmH
         7S6wt70/d7Np1FvXXyqvAON6yKi1ItteOKNqiDrCSkWz6Fk3YfyPzXoYlltVwhml7vIP
         ZHC0ZjF3dIOmIIF4x5PQHktUvpqaTwRDdsu1A1lbOI0Y/q8SZqXjJPGPRiZl7BxINmT3
         lF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727713107; x=1728317907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2l5r1LZwEKOpEY2ktEbhSxXVhypzkb5WeDgzsoyHkvo=;
        b=MPOY+NejYDphGIcDuRGUjTmojFNToRHSWRsIBcsm+El5hh74rRodKTwcrrO2SyVF6C
         vF10sFJsivx3nbqk0OmL+p2O7p99GvPPZ9KzJHywj7Nzo8eUxAjZ3zjj1AiDUWyxxbsB
         oB3Marfd61L68vFr0Lo6q6FsKSJL1U/9MsLpsRbj0dPmnQP3aQjzUOjnxrnDRtuK9toB
         SwL9J1iI8qfLn80Jm4tRBllQ4Sdkex0b1YH+9ETznFWsm0YcHUepBnB1/cHonKlSZoIH
         msv3D/dGXLqdPvI2I5ucOjKEEK7Z6h4cC0dH7Tq3/bzIkrnBG169cC1QUiuhQMsb2XTP
         qb4g==
X-Forwarded-Encrypted: i=1; AJvYcCUfWZ+kpvXF8icWf8U2VKjGk3RIxCCStXo3uL45pdXxjyqiD401KQ1C3SIudGxle+Dc9ZpZFsP5NWnZ@vger.kernel.org, AJvYcCW7PLWUrWrPYUz2U1fzi6Pw6H0Mm+k/hdBn/sfVLDd3x7Y561cr57OhvNhtcS7cg3cheY5QJs4FVGKlJzZ6@vger.kernel.org, AJvYcCWku46X2DKtpTyLZueHOF5bUayfh240Z8Aptf7dthqhOCrTQYduQp0BcIiMy+oZmwCM6WLLAjHgerg+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2RCsdke6ICcW8dbi84rdX+vUSfoFKMONrCkhzBPLPtwPXyP6s
	5gheOnn5V91YxmaqiG8w9IomcCDgs5UwKxHle0YI8pV66AwGsddu
X-Google-Smtp-Source: AGHT+IFl5Gjgwu84SmuI/bp1yeHjyf2HoU9EbS4VxR8UrDamisJDdtS97rTLsocKl2LAstlAiPJnCQ==
X-Received: by 2002:a05:6902:e89:b0:e1d:91d4:3ddb with SMTP id 3f1490d57ef6-e262c06c4f1mr167736276.20.1727713104683;
        Mon, 30 Sep 2024 09:18:24 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e42207b9sm2419546276.33.2024.09.30.09.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 09:18:24 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 30 Sep 2024 09:17:55 -0700
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
Subject: Re: [PATCH v12 08/17] cxl/mbox: Add GET_FEATURE mailbox command
Message-ID: <ZvrPM-NVQVwuNCHJ@fan>
References: <20240911090447.751-1-shiju.jose@huawei.com>
 <20240911090447.751-9-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911090447.751-9-shiju.jose@huawei.com>

On Wed, Sep 11, 2024 at 10:04:37AM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for GET_FEATURE mailbox command.
> 
> CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
> The settings of a feature can be retrieved using Get Feature command.
> CXL spec 3.1 section 8.2.9.6.2 describes Get Feature command.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/core/mbox.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 26 ++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index fe965ec5802f..3dfe411c6556 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -965,6 +965,47 @@ int cxl_get_supported_feature_entry(struct cxl_dev_state *cxlds, const uuid_t *f
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_get_supported_feature_entry, CXL);
>  
> +size_t cxl_get_feature(struct cxl_dev_state *cxlds, const uuid_t feat_uuid,
> +		       enum cxl_get_feat_selection selection,
> +		       void *feat_out, size_t feat_out_size)
> +{
> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
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
> index 5d149e64c247..57c9294bb7f3 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -487,6 +487,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
>  	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
>  	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
> +	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>  	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>  	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
> @@ -812,6 +813,28 @@ struct cxl_mbox_get_sup_feats_out {
>  	struct cxl_feat_entry ents[] __counted_by(le32_to_cpu(supported_feats));
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
> @@ -875,4 +898,7 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
>  int cxl_get_supported_features(struct cxl_dev_state *cxlds);
>  int cxl_get_supported_feature_entry(struct cxl_dev_state *cxlds, const uuid_t *feat_uuid,
>  				    struct cxl_feat_entry *feat_entry_out);
> +size_t cxl_get_feature(struct cxl_dev_state *cxlds, const uuid_t feat_uuid,
> +		       enum cxl_get_feat_selection selection,
> +		       void *feat_out, size_t feat_out_size);
>  #endif /* __CXL_MEM_H__ */
> -- 
> 2.34.1
> 

-- 
Fan Ni

