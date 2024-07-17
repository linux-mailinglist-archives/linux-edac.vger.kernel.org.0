Return-Path: <linux-edac+bounces-1540-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF21C93417B
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jul 2024 19:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8511C21365
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jul 2024 17:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B701822F7;
	Wed, 17 Jul 2024 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUvVoIpX"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5C317FAC1;
	Wed, 17 Jul 2024 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721237294; cv=none; b=fLigBdqDgBxpPnjmy6x2P7B6DIT31a8j9rP1SMY8CoSMVN3pkFmdnQxb8ww2+9GFAZlmG3ua1oVpvMjf1tUqZMkgoHBwJZ/N2UVsidlmuBTPV+H5dhvMm01+l3Mj+jG7tDwvuJPtVBMqSN82IOA5GF2XXlWzoHJGzpwJeIuBQ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721237294; c=relaxed/simple;
	bh=9kqvTxpwpe4fBImcb6MbCXfc10WXl+zWj4MkNARMj9k=;
	h=Message-ID:From:Date:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8odVwJ7DNEgZauhtGAl/5UpomU2cZwqSFW0nMTS2s9JrYogjXxEoeIN7UtqqqF6tf5kZdi3iRhqSQ5aCv/rvXjSdL1mLEXTeaIvk2cLff9d5UaWPOSMiOavMbJKz/HAhXrKfbTi43yKHbHskW84XAxcteI6h0C0hFpVKjp6/ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUvVoIpX; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-65f880c56b1so222957b3.3;
        Wed, 17 Jul 2024 10:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721237291; x=1721842091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b4LfVWMiLU1Ai4rM/MAGdsvR9RjnBD07teo6F43vM9c=;
        b=bUvVoIpXlRu/ZWqTmjSmjearRCVZJ/bDztGPPwCrvDe4ZF+iAH8N0sYnZyuru52N3I
         J9VPYSjwSdzUgyIdWOgs6X29ml0jvoTeJ64QxHM2iczU9US+c1jGF2Ox25uYAKcj+mM0
         JlfKSxeVv/rJ4BgW4+CYXxDy2PgJqCB8HotXWvIYDPAn/rr+QJB1+lnotJsMuTHbewR0
         DBkl6SN8DTbUkecRB30wMCmypwKFOdwsMeurn6P/qJd/zjof9b0Ng86Cl6lBNQVQMPBu
         Ye/3ql8/pK5jEmhcbZU4mSgnaIe6/g1MVaeALDLztEP9Ut7RJl2OhPGFCjQ5cyma0LYA
         TlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721237291; x=1721842091;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4LfVWMiLU1Ai4rM/MAGdsvR9RjnBD07teo6F43vM9c=;
        b=sxkogOnV/AeZu3QlanplRqhQ3jVIAdplocegdcIWWVnK66wN99vj6ei0swDVDpFflr
         RFDLnq7ROs4ux6i2/hHdHSu3lB3wnSOv9HI/sE6PSsMXuhmd+g3JYc4jOY04p3CV7/+D
         LaGGAYv3VH/+oUlIj8UDPXp5oG0OVznxij0Ew04yFY2pVIw+9ePn6VSyc0/r3mGj2zkA
         eTXQF6pFprVMRvSH2mekAxelzce/1TeoRRBLSiQ/S7Acua2UbsvbZfQCEkZdbqt6iTFk
         DtqBToHBq1ekVK9TCBvLw0ncvqNHGZfymgWO4bjoMgJg3hJP1bQgEeuRfAqFQW7cL0W4
         qQVg==
X-Forwarded-Encrypted: i=1; AJvYcCUV6ELi4kmTB666OOHuRf544M0+ea/p+lSqYSU4ol2+WIt9Q+kd3qZka7crkAMeQZ4OxS/CFhS/K4MFH3sRHkwxHkf4Ps/LHUeTnEooh1Sp4VimfYgh3N41AP4uMZL3yD8BsediiVhfwQ0qtZHjLoYzD8P1GrEjFKUsQelfSX2bDPBxXA==
X-Gm-Message-State: AOJu0Yyqsw6E/BiKL+nrjWyCDIysqbyARcgsgPJljog5CI1J1Upz23De
	2AV/igHxf8BulQCkcR3MggcUaUAhjfGrBAS4boxmGg9pLTHugh3s
X-Google-Smtp-Source: AGHT+IF9LsvokS3eKYMuP4MogL69AZXjuMawpefSDoGGOn7fBRjbwOK8dFR1TEF4RXpvNJ2suRcGCA==
X-Received: by 2002:a81:7c02:0:b0:61a:ccb0:7cdd with SMTP id 00721157ae682-66500573b1emr27793817b3.46.1721237291553;
        Wed, 17 Jul 2024 10:28:11 -0700 (PDT)
Received: from gpd. ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6660249145dsm90517b3.60.2024.07.17.10.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 10:28:11 -0700 (PDT)
Message-ID: <6697ff2b.050a0220.19cb8.00e1@mx.google.com>
X-Google-Original-Message-ID: <Zpf_JzDy_ijdNd_c@gpd.>
From: nifan.cxl@gmail.com
X-Google-Original-From: fan@gpd.
Date: Wed, 17 Jul 2024 10:28:07 -0700
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
Subject: Re: [RFC PATCH v9 04/11] cxl/mbox: Add GET_SUPPORTED_FEATURES
 mailbox command
References: <20240716150336.2042-1-shiju.jose@huawei.com>
 <20240716150336.2042-5-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716150336.2042-5-shiju.jose@huawei.com>

On Tue, Jul 16, 2024 at 04:03:28PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for GET_SUPPORTED_FEATURES mailbox command.
> 
> CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
> CXL devices supports features with changeable attributes.
s/supports/support/

Fan
> Get Supported Features retrieves the list of supported device specific
> features. The settings of a feature can be retrieved using Get Feature
> and optionally modified using Set Feature.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/mbox.c | 27 ++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 61 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2626f3fff201..9b9b1d26454e 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1324,6 +1324,33 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
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
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr)
>  {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 19aba81cdf13..b0e1565b9d2e 100644
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
> @@ -699,6 +700,63 @@ struct cxl_mbox_set_timestamp_in {
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
> @@ -830,6 +888,9 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			    enum cxl_event_type event_type,
>  			    const uuid_t *uuid, union cxl_event *evt);
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
> +int cxl_get_supported_features(struct cxl_memdev_state *mds,
> +			       u32 count, u16 start_index,
> +			       struct cxl_mbox_get_supp_feats_out *feats_out);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr);
> -- 
> 2.34.1
> 

