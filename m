Return-Path: <linux-edac+bounces-1557-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBA5937CAB
	for <lists+linux-edac@lfdr.de>; Fri, 19 Jul 2024 20:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C96CB2168E
	for <lists+linux-edac@lfdr.de>; Fri, 19 Jul 2024 18:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DA61482ED;
	Fri, 19 Jul 2024 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn5jNWfz"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37B9146A99;
	Fri, 19 Jul 2024 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721414607; cv=none; b=ZKSNmMeOir7q6/WyCcRsdYgH3YE141qbHJ96Mj5wNBALFINmxd1zAuGb03o87BoEBsTWG7ayrjjvPaSINnHyVVt1QQM6CCCfCw7DQEwyIr5kZtm/9WFs6qWO0uQ3cbQ7z80Wkt+fDScrIM9vDqGHhhdGbwPpmV6oGQBbg9yUCzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721414607; c=relaxed/simple;
	bh=980I7JE8pwMbWxdyvIMeDofdQkvaYQiknQYCZc+7jVQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmnPuyeFfHlSoEyMhlAsXwJpv4W7o+1XNs95W/wMROMFGS10csxLQuzlGImfdntB+Lx2j/eTMbcj8Du3ktHd4HqHmeay1htXABNFs691Lo5XaTfVdd08lEZwemS0n7heeS+FWrL2/4u6o51SqOeg8cU4lmK4oD5npwTa7lEDZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nn5jNWfz; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70aec66c936so898000b3a.0;
        Fri, 19 Jul 2024 11:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721414605; x=1722019405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ksl0r9CZ72zWVwuRHRRlhsOPiNmz7I0PeyEzWPG0ok=;
        b=nn5jNWfzOTcWwjzHHsyGqmMgL8wweWylUzgRqZDq2IRa84vVDSSQPffZRO0TpKN/JX
         HdIuA/8gb+gszcUv7lwNZ1dRo3zXH3xTDatTdLHGHuObT8SoWwnemejly1oVRfA8GZ7B
         o4ZvhTDccYg+RSwyMA4/hvh/d26XnlkY0yX4SRUIX0yoErTc+g3wH50S0BCrN7ukgAag
         dQTeLOba2/NQK0yE4Zf3OAHVZWRsYURVu8O71e70R8gfe+eVnBi2z/RsbDlPRwWTvirX
         3Ohxbr6m6DW23wyHJOP+xT93OSg8F/Zrb2uKJyqWP+ov4cy5SIfM5u6gaSvgr99lSYxA
         qV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721414605; x=1722019405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ksl0r9CZ72zWVwuRHRRlhsOPiNmz7I0PeyEzWPG0ok=;
        b=AHI0r8WrASW/oxSAVoRRCpfx6Vp+As7/L9zj4nnB/E6uUUYjFiaVJVxJZAHwX5x6KL
         xJ/u1a3pX6xgdLWbdpxSgqO/o4tFcaUMm808w7dQwEgrUFrwnXH0kyheJMIhwkDjdTTB
         K5iB7rbY+4+vGw8IBElR+YTZSqoASLtjgQVP2i66yWl8Etss/59fwYbsgKOSrYHkWO7p
         8C89XSCKL8qcWF/OwMiGcT7qu5hCUSuW92YiXHorBDpgNlrWEapBMrhRAOLQN5AEZxz/
         8aBXvyk//NQyBKFpSrK1rfOntFKWnc3b+RBVDwtKAAJpChyqnqVsxydk1mhA8JnCJO0q
         8cww==
X-Forwarded-Encrypted: i=1; AJvYcCWa8F6kiH63Cs0Cp9kUVhM530G6ePj5ElQbtHpSZbHM4VyMmG/afvrdL6n1RNHlp9e3sLT89ubABpm35v0G5bKAi/surocDAJmoSQyXLaEqzq+qaq+J72Xtlf/vB8TQII4NrjS02A0EyGMshdUoC1QpNjYU4gkisnDNt0Gm9Gkq3WYLaw==
X-Gm-Message-State: AOJu0Yz2wT31XoRaqQOIRevlC1TF+Y9yq7txDzhxufaKdJTWIcv3RWEE
	1ocAIbEuO7YizcWBLLUiGboVIw4ess1g+X/Ys0l7sVfWK0HuDZJ5
X-Google-Smtp-Source: AGHT+IF4jBurPQ43jlcuXJ1lkHKfqgHilWGPcN1XXaq1uTTlU2xKFSddeNcpR+3dxoUPoTYOQnTopw==
X-Received: by 2002:a05:6a20:a11e:b0:1bd:253e:28e with SMTP id adf61e73a8af0-1c3fdc962c8mr11541516637.16.1721414605167;
        Fri, 19 Jul 2024 11:43:25 -0700 (PDT)
Received: from gpd ([2601:646:8f03:9fee:d888:5d2b:51bf:885e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31bd9bsm7932015ad.157.2024.07.19.11.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 11:43:24 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@gpd>
Date: Fri, 19 Jul 2024 11:43:02 -0700
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
Subject: Re: [RFC PATCH v9 08/11] cxl/memscrub: Add CXL memory device ECS
 control feature
Message-ID: <ZpqztkrEPw3lrku5@gpd>
References: <20240716150336.2042-1-shiju.jose@huawei.com>
 <20240716150336.2042-9-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716150336.2042-9-shiju.jose@huawei.com>

On Tue, Jul 16, 2024 at 04:03:32PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check
> Scrub (ECS) control feature.
> The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
> Specification (JESD79-5) and allows the DRAM to internally read, correct
> single-bit errors, and write back corrected data bits to the DRAM array
> while providing transparency to error counts.
> 
> The ECS control allows the requester to change the log entry type, the ECS
> threshold count provided that the request is within the definition
> specified in DDR5 mode registers, change mode between codeword mode and
> row count mode, and reset the ECS counter.
> 
> Register with EDAC RAS control feature driver, which gets the ECS attr
> descriptors from the EDAC ECS and expose sysfs ECS control attributes
> to the userspace.
> For example ECS control for the memory media FRU 0 in CXL mem0 device is
> in /sys/bus/edac/devices/cxl_mem0/ecs_fru0/
> 
> Note: The documentation can be added if necessary.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---

Some lines are too long. And some other comments inline.

>  drivers/cxl/core/memscrub.c | 429 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 429 insertions(+)
> 
> diff --git a/drivers/cxl/core/memscrub.c b/drivers/cxl/core/memscrub.c
> index 430f85b01f6c..9be230ea989a 100644
> --- a/drivers/cxl/core/memscrub.c
> +++ b/drivers/cxl/core/memscrub.c
> @@ -351,13 +351,411 @@ static const struct edac_scrub_ops cxl_ps_scrub_ops = {
>  	.cycle_in_hours_range = cxl_patrol_scrub_read_scrub_cycle_hrs_range,
>  };
>  
> +/* CXL DDR5 ECS control definitions */
> +#define CXL_MEMDEV_ECS_GET_FEAT_VERSION	0x01
> +#define CXL_MEMDEV_ECS_SET_FEAT_VERSION	0x01
> +
> +static const uuid_t cxl_ecs_uuid =
> +	UUID_INIT(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba, 0xb9, 0x69, 0x1e,     \
> +		  0x89, 0x33, 0x86);
> +
> +struct cxl_ecs_context {
> +	u16 num_media_frus;
> +	u16 get_feat_size;
> +	u16 set_feat_size;
> +	struct cxl_memdev *cxlmd;
> +};
> +
> +/**
> + * struct cxl_ecs_params - CXL memory DDR5 ECS parameter data structure.
> + * @log_entry_type: ECS log entry type, per DRAM or per memory media FRU.
> + * @threshold: ECS threshold count per GB of memory cells.
> + * @mode:	codeword/row count mode
> + *		0 : ECS counts rows with errors
> + *		1 : ECS counts codeword with errors
> + * @reset_counter: [IN] reset ECC counter to default value.
> + */
> +struct cxl_ecs_params {
> +	u8 log_entry_type;
> +	u16 threshold;
> +	u8 mode;

An enum is defined below, why not directly use enum type here?

> +	bool reset_counter;
> +};
> +
> +enum {
> +	CXL_ECS_PARAM_LOG_ENTRY_TYPE,
> +	CXL_ECS_PARAM_THRESHOLD,
> +	CXL_ECS_PARAM_MODE,
> +	CXL_ECS_PARAM_RESET_COUNTER,
> +};
> +
> +#define	CXL_ECS_LOG_ENTRY_TYPE_MASK	GENMASK(1, 0)
> +#define	CXL_ECS_REALTIME_REPORT_CAP_MASK	BIT(0)
> +#define	CXL_ECS_THRESHOLD_COUNT_MASK	GENMASK(2, 0)
> +#define	CXL_ECS_MODE_MASK	BIT(3)
> +#define	CXL_ECS_RESET_COUNTER_MASK	BIT(4)
> +
> +static const u16 ecs_supp_threshold[] = { 0, 0, 0, 256, 1024, 4096 };
> +
> +enum {
> +	ECS_LOG_ENTRY_TYPE_DRAM = 0x0,
> +	ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU = 0x1,
> +};
> +
> +enum {
> +	ECS_THRESHOLD_256 = 3,
> +	ECS_THRESHOLD_1024 = 4,
> +	ECS_THRESHOLD_4096 = 5,
> +};
> +
> +enum {
> +	ECS_MODE_COUNTS_ROWS = 0,
> +	ECS_MODE_COUNTS_CODEWORDS = 1,
> +};
> +
> +struct cxl_ecs_rd_attrs {
> +	u8 ecs_log_cap;
> +	u8 ecs_cap;
> +	__le16 ecs_config;
> +	u8 ecs_flags;
> +}  __packed;
> +
> +struct cxl_ecs_wr_attrs {
> +	u8 ecs_log_cap;
> +	__le16 ecs_config;
> +}  __packed;
> +
> +/* CXL DDR5 ECS control functions */
> +static int cxl_mem_ecs_get_attrs(struct device *dev, void *drv_data, int fru_id,
> +				 struct cxl_ecs_params *params)
> +{
> +	struct cxl_ecs_context *cxl_ecs_ctx = drv_data;
> +	struct cxl_memdev *cxlmd = cxl_ecs_ctx->cxlmd;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	size_t rd_data_size;
> +	u8 threshold_index;
> +	size_t data_size;
> +
> +	rd_data_size = cxl_ecs_ctx->get_feat_size;
> +
> +	struct cxl_ecs_rd_attrs *rd_attrs __free(kfree) =
> +					kmalloc(rd_data_size, GFP_KERNEL);
> +	if (!rd_attrs)
> +		return -ENOMEM;
> +
> +	params->log_entry_type = 0;
> +	params->threshold = 0;
> +	params->mode = 0;
> +	data_size = cxl_get_feature(mds, cxl_ecs_uuid, rd_attrs,
> +				    rd_data_size, CXL_GET_FEAT_SEL_CURRENT_VALUE);
> +	if (!data_size)
> +		return -EIO;
> +
> +	params->log_entry_type = FIELD_GET(CXL_ECS_LOG_ENTRY_TYPE_MASK,
> +					   rd_attrs[fru_id].ecs_log_cap);
> +	threshold_index = FIELD_GET(CXL_ECS_THRESHOLD_COUNT_MASK,
> +				    rd_attrs[fru_id].ecs_config);
> +	params->threshold = ecs_supp_threshold[threshold_index];
> +	params->mode = FIELD_GET(CXL_ECS_MODE_MASK,
> +				 rd_attrs[fru_id].ecs_config);
> +	return 0;
> +}
> +
> +static int cxl_mem_ecs_set_attrs(struct device *dev, void *drv_data, int fru_id,
> +				 struct cxl_ecs_params *params, u8 param_type)
> +{
> +	struct cxl_ecs_context *cxl_ecs_ctx = drv_data;
> +	struct cxl_memdev *cxlmd = cxl_ecs_ctx->cxlmd;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	size_t rd_data_size, wr_data_size;
> +	u16 num_media_frus, count;
> +	size_t data_size;
> +	int ret;
> +
> +	num_media_frus = cxl_ecs_ctx->num_media_frus;
> +	rd_data_size = cxl_ecs_ctx->get_feat_size;
> +	wr_data_size = cxl_ecs_ctx->set_feat_size;
> +	struct cxl_ecs_rd_attrs *rd_attrs __free(kfree) =
> +				kmalloc(rd_data_size, GFP_KERNEL);
> +	if (!rd_attrs)
> +		return -ENOMEM;
> +
> +	data_size = cxl_get_feature(mds, cxl_ecs_uuid, rd_attrs,
> +				    rd_data_size, CXL_GET_FEAT_SEL_CURRENT_VALUE);
> +	if (!data_size)
> +		return -EIO;
> +	struct cxl_ecs_wr_attrs *wr_attrs __free(kfree) =
> +					kmalloc(wr_data_size, GFP_KERNEL);
> +	if (!wr_attrs)
> +		return -ENOMEM;
> +
> +	/* Fill writable attributes from the current attributes read for all the media FRUs */
> +	for (count = 0; count < num_media_frus; count++) {
> +		wr_attrs[count].ecs_log_cap = rd_attrs[count].ecs_log_cap;
> +		wr_attrs[count].ecs_config = rd_attrs[count].ecs_config;
> +	}
> +
> +	/* Fill attribute to be set for the media FRU */
> +	switch (param_type) {
> +	case CXL_ECS_PARAM_LOG_ENTRY_TYPE:
> +		if (params->log_entry_type != ECS_LOG_ENTRY_TYPE_DRAM &&
> +		    params->log_entry_type != ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU) {
> +			dev_err(dev,
> +				"Invalid CXL ECS scrub log entry type(%d) to set\n",
> +			       params->log_entry_type);
> +			dev_err(dev,
> +				"Log Entry Type 0: per DRAM  1: per Memory Media FRU\n");
> +			return -EINVAL;
> +		}
> +		wr_attrs[fru_id].ecs_log_cap = FIELD_PREP(CXL_ECS_LOG_ENTRY_TYPE_MASK,
> +							  params->log_entry_type);
> +		break;
> +	case CXL_ECS_PARAM_THRESHOLD:
> +		wr_attrs[fru_id].ecs_config &= ~CXL_ECS_THRESHOLD_COUNT_MASK;
> +		switch (params->threshold) {
> +		case 256:
> +			wr_attrs[fru_id].ecs_config |= FIELD_PREP(
> +					CXL_ECS_THRESHOLD_COUNT_MASK,
> +						ECS_THRESHOLD_256);
> +			break;
> +		case 1024:
> +			wr_attrs[fru_id].ecs_config |= FIELD_PREP(
> +						CXL_ECS_THRESHOLD_COUNT_MASK,
> +						ECS_THRESHOLD_1024);
> +			break;
> +		case 4096:
> +			wr_attrs[fru_id].ecs_config |= FIELD_PREP(
> +						CXL_ECS_THRESHOLD_COUNT_MASK,
> +						ECS_THRESHOLD_4096);
> +			break;
> +		default:
> +			dev_err(dev,
> +				"Invalid CXL ECS scrub threshold count(%d) to set\n",
> +				params->threshold);
> +			dev_err(dev,
> +				"Supported scrub threshold count: 256,1024,4096\n");
> +			return -EINVAL;
> +		}
> +		break;
> +	case CXL_ECS_PARAM_MODE:
> +		if (params->mode != ECS_MODE_COUNTS_ROWS &&
> +		    params->mode != ECS_MODE_COUNTS_CODEWORDS) {
> +			dev_err(dev,
> +				"Invalid CXL ECS scrub mode(%d) to set\n",
> +				params->mode);
> +			dev_err(dev,
> +				"Mode 0: ECS counts rows with errors"
> +				" 1: ECS counts codewords with errors\n");
> +			return -EINVAL;
> +		}
> +		wr_attrs[fru_id].ecs_config &= ~CXL_ECS_MODE_MASK;
> +		wr_attrs[fru_id].ecs_config |= FIELD_PREP(CXL_ECS_MODE_MASK,
> +							  params->mode);
> +		break;
> +	case CXL_ECS_PARAM_RESET_COUNTER:
> +		wr_attrs[fru_id].ecs_config &= ~CXL_ECS_RESET_COUNTER_MASK;
> +		wr_attrs[fru_id].ecs_config |= FIELD_PREP(CXL_ECS_RESET_COUNTER_MASK,
> +							  params->reset_counter);
> +		break;
> +	default:
> +		dev_err(dev, "Invalid CXL ECS parameter to set\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = cxl_set_feature(mds, cxl_ecs_uuid, CXL_MEMDEV_ECS_SET_FEAT_VERSION,
> +			      wr_attrs, wr_data_size,
> +			      CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET);
> +	if (ret) {
> +		dev_err(dev, "CXL ECS set feature failed ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_ecs_get_log_entry_type(struct device *dev, void *drv_data, int fru_id, u64 *val)
> +{
> +	struct cxl_ecs_params params;
> +	int ret;
> +
> +	ret = cxl_mem_ecs_get_attrs(dev, drv_data, fru_id, &params);
> +	if (ret)
> +		return ret;
> +
> +	*val = params.log_entry_type;
> +
> +	return 0;
> +}
> +
> +static int cxl_ecs_set_log_entry_type(struct device *dev, void *drv_data, int fru_id, u64 val)
> +{
> +	struct cxl_ecs_params params = {
> +		.log_entry_type = val,
> +	};
> +
> +	return cxl_mem_ecs_set_attrs(dev, drv_data, fru_id, &params, CXL_ECS_PARAM_LOG_ENTRY_TYPE);
> +}
> +
> +static int cxl_ecs_get_log_entry_type_per_dram(struct device *dev, void *drv_data,
> +					       int fru_id, u64 *val)

I may have missed something. We have cxl_ecs_get_log_entry_type, and what is
cxl_ecs_get_log_entry_type_per_memory_media and cxl_ecs_get_log_entry_type_per_dram for? 

> +{
> +	struct cxl_ecs_params params;
> +	int ret;
> +
> +	ret = cxl_mem_ecs_get_attrs(dev, drv_data, fru_id, &params);
> +	if (ret)
> +		return ret;
> +
> +	if (params.log_entry_type == ECS_LOG_ENTRY_TYPE_DRAM)
> +		*val = 1;
> +	else
> +		*val = 0;
> +
> +	return 0;
> +}
> +
> +static int cxl_ecs_get_log_entry_type_per_memory_media(struct device *dev, void *drv_data,
> +						       int fru_id, u64 *val)
> +{
> +	struct cxl_ecs_params params;
> +	int ret;
> +
> +	ret = cxl_mem_ecs_get_attrs(dev, drv_data, fru_id, &params);
> +	if (ret)
> +		return ret;
> +
> +	if (params.log_entry_type == ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU)
> +		*val = 1;
> +	else
> +		*val = 0;
> +
> +	return 0;
> +}
> +
> +static int cxl_ecs_get_mode(struct device *dev, void *drv_data, int fru_id, u64 *val)
> +{
> +	struct cxl_ecs_params params;
> +	int ret;
> +
> +	ret = cxl_mem_ecs_get_attrs(dev, drv_data, fru_id, &params);
> +	if (ret)
> +		return ret;
> +
> +	*val = params.mode;
> +
> +	return 0;
> +}
> +
> +static int cxl_ecs_set_mode(struct device *dev, void *drv_data, int fru_id, u64 val)
> +{
> +	struct cxl_ecs_params params = {
> +		.mode = val,
> +	};
> +
> +	return cxl_mem_ecs_set_attrs(dev, drv_data, fru_id, &params, CXL_ECS_PARAM_MODE);
> +}
> +
> +static int cxl_ecs_get_mode_counts_rows(struct device *dev, void *drv_data, int fru_id, u64 *val)
As above, what is cxl_ecs_get_mode_counts_codewords and
cxl_ecs_get_mode_counts_rows for?

Fan
> +{
> +	struct cxl_ecs_params params;
> +	int ret;
> +
> +	ret = cxl_mem_ecs_get_attrs(dev, drv_data, fru_id, &params);
> +	if (ret)
> +		return ret;
> +
> +	if (params.mode == ECS_MODE_COUNTS_ROWS)
> +		*val = 1;
> +	else
> +		*val = 0;
> +
> +	return 0;
> +}
> +
> +static int cxl_ecs_get_mode_counts_codewords(struct device *dev, void *drv_data,
> +					     int fru_id, u64 *val)
> +{
> +	struct cxl_ecs_params params;
> +	int ret;
> +
> +	ret = cxl_mem_ecs_get_attrs(dev, drv_data, fru_id, &params);
> +	if (ret)
> +		return ret;
> +
> +	if (params.mode == ECS_MODE_COUNTS_CODEWORDS)
> +		*val = 1;
> +	else
> +		*val = 0;
> +
> +	return 0;
> +}
> +
> +static int cxl_ecs_reset(struct device *dev, void *drv_data, int fru_id, u64 val)
> +{
> +	struct cxl_ecs_params params = {
> +		.reset_counter = val,
> +	};
> +
> +	return cxl_mem_ecs_set_attrs(dev, drv_data, fru_id, &params, CXL_ECS_PARAM_RESET_COUNTER);
> +}
> +
> +static int cxl_ecs_get_threshold(struct device *dev, void *drv_data, int fru_id, u64 *val)
> +{
> +	struct cxl_ecs_params params;
> +	int ret;
> +
> +	ret = cxl_mem_ecs_get_attrs(dev, drv_data, fru_id, &params);
> +	if (ret)
> +		return ret;
> +
> +	*val = params.threshold;
> +
> +	return 0;
> +}
> +
> +static int cxl_ecs_set_threshold(struct device *dev, void *drv_data, int fru_id, u64 val)
> +{
> +	struct cxl_ecs_params params = {
> +		.threshold = val,
> +	};
> +
> +	return cxl_mem_ecs_set_attrs(dev, drv_data, fru_id, &params, CXL_ECS_PARAM_THRESHOLD);
> +}
> +
> +static int cxl_ecs_get_name(struct device *dev, void *drv_data, int fru_id, char *name)
> +{
> +	struct cxl_ecs_context *cxl_ecs_ctx = drv_data;
> +	struct cxl_memdev *cxlmd = cxl_ecs_ctx->cxlmd;
> +
> +	return sysfs_emit(name, "cxl_%s_ecs_fru%d\n", dev_name(&cxlmd->dev), fru_id);
> +}
> +
> +static const struct edac_ecs_ops cxl_ecs_ops = {
> +	.get_log_entry_type = cxl_ecs_get_log_entry_type,
> +	.set_log_entry_type = cxl_ecs_set_log_entry_type,
> +	.get_log_entry_type_per_dram = cxl_ecs_get_log_entry_type_per_dram,
> +	.get_log_entry_type_per_memory_media = cxl_ecs_get_log_entry_type_per_memory_media,
> +	.get_mode = cxl_ecs_get_mode,
> +	.set_mode = cxl_ecs_set_mode,
> +	.get_mode_counts_codewords = cxl_ecs_get_mode_counts_codewords,
> +	.get_mode_counts_rows = cxl_ecs_get_mode_counts_rows,
> +	.reset = cxl_ecs_reset,
> +	.get_threshold = cxl_ecs_get_threshold,
> +	.set_threshold = cxl_ecs_set_threshold,
> +	.get_name = cxl_ecs_get_name,
> +};
> +
>  int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
>  {
>  	struct edac_ras_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
>  	struct cxl_patrol_scrub_context *cxl_ps_ctx;
>  	struct cxl_mbox_supp_feat_entry feat_entry;
>  	char cxl_dev_name[CXL_SCRUB_NAME_LEN];
> +	struct cxl_ecs_context *cxl_ecs_ctx;
>  	int rc, i, num_ras_features = 0;
> +	int num_media_frus;
>  
>  	if (cxlr) {
>  		struct cxl_region_params *p = &cxlr->params;
> @@ -407,6 +805,37 @@ int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
>  	ras_features[num_ras_features].scrub_ctx = cxl_ps_ctx;
>  	num_ras_features++;
>  
> +	if (!cxlr) {
> +		rc = cxl_mem_get_supported_feature_entry(cxlmd, &cxl_ecs_uuid, &feat_entry);
> +		if (rc < 0)
> +			goto feat_register;
> +
> +		if (!(feat_entry.attr_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
> +			goto feat_register;
> +		num_media_frus = feat_entry.get_size/
> +					sizeof(struct cxl_ecs_rd_attrs);
> +		if (!num_media_frus)
> +			goto feat_register;
> +
> +		cxl_ecs_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ecs_ctx), GFP_KERNEL);
> +		if (!cxl_ecs_ctx)
> +			goto feat_register;
> +		*cxl_ecs_ctx = (struct cxl_ecs_context) {
> +			.get_feat_size = feat_entry.get_size,
> +			.set_feat_size = feat_entry.set_size,
> +			.num_media_frus = num_media_frus,
> +			.cxlmd = cxlmd,
> +		};
> +
> +		ras_features[num_ras_features].feat = ras_feat_ecs;
> +		ras_features[num_ras_features].ecs_ops = &cxl_ecs_ops;
> +		ras_features[num_ras_features].ecs_ctx = cxl_ecs_ctx;
> +		ras_features[num_ras_features].ecs_info.num_media_frus = num_media_frus;
> +		num_ras_features++;
> +	}
> +
> +feat_register:
> +
>  	return edac_ras_dev_register(&cxlmd->dev, cxl_dev_name, NULL,
>  				     num_ras_features, ras_features);
>  }
> -- 
> 2.34.1
> 

