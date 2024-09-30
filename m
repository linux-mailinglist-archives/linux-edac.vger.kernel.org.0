Return-Path: <linux-edac+bounces-1940-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3B998ABB8
	for <lists+linux-edac@lfdr.de>; Mon, 30 Sep 2024 20:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409C31F21835
	for <lists+linux-edac@lfdr.de>; Mon, 30 Sep 2024 18:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD471990BB;
	Mon, 30 Sep 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4TAmgkw"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BB8192D7F;
	Mon, 30 Sep 2024 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719964; cv=none; b=OuPorLspczNiVxTTCGRHTdYT2kswIllKBJqEVptSdLE96C1fLybp7SgRoX182DWNHN+4fskYdiT9Qz9dkgeRN92xvBVcsKBGwDiQZ4ecg6FdblepGsQdULjYXKO7zYVWdkUvKlAFcVIDeMJZdniUiCZ4c4sy7mIeqI1yKjwyV/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719964; c=relaxed/simple;
	bh=20EVv87MX0+qJDTkTgZb1BgQLdiuABaXeh4YFLWCDVQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gc7jHE3/hBc85Jiv62d6VcMqQriYKewm1BFaJ5SXeA1pVo9XDqkAXZI0RvjBHJmB3ippD366sPCQpAukz3Vi0oy/yDUfR7YTMf7lXpThUAEMdY+rLuHI4eZYPtLG+dsnYH99f9yvqui9jmzPzKMG7uBr5AJFL8UZne3kxI3eDUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4TAmgkw; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6dde476d3dfso37450767b3.3;
        Mon, 30 Sep 2024 11:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727719962; x=1728324762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yOQRubuT/DdhrnZg0J46Z8IjsbDjiXizvk3mSMiIiPk=;
        b=B4TAmgkwdsMlqdv4nKrML+oQbNBySNvhrBGfn1HnvqWjnifoEKPpQEOwnUdITL/2v4
         jxlbCdJ6C5XSG0wZwdwnf+akj2LM/x9crnc7Q8pBSU0gQ4RvZpUYJms6Zq8EDW77+pAz
         MmpIbrWzT21TbOaGGmGvccLjiEN+HinlitHHv+Sfawf1CTKXNtpDSa2MO2iTghycJXz0
         YOLhTT3AeTzDNrNx6Vvi+IGk64obwO0RgR8XTpBCs2+tcwa4h2PywaEhZCEMjknRtLy5
         8QAKG4Pg42cTJV3ofHLYJtnELfUfAq5nTtGpav+QfiNgX+er1xc4wbFjsBWoo7L5lHEm
         qwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719962; x=1728324762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOQRubuT/DdhrnZg0J46Z8IjsbDjiXizvk3mSMiIiPk=;
        b=pcGBPDV+BmMD/bqeNs1vVMY0Wdjq/skP9ftuDlsiVwsWtriuAYQpGyYlR+73uKA5Em
         GqpOheyjInnoX3cNuVZiZSL3x13nCJSXeGZ8CQ0f8wWS1iNxJmKs8AqOSA5rzfd/wKil
         Exyx9acXV8IQOUPYqS+kDiZ2jXafb4Ye2wmMfWgsvFcY3FI/tBwigNjT2oODm3jLEl8D
         +q1R+Uckk/qdhVpR13r/3VyoMTFWwVmQo7bka7RovEyQMnwbbqdjhygFeShD7ewg/Dua
         jbemUTZaz3MDDSlD+RD4GYLRN3/exk7A31LHw/ocl7/1KoMb+SOc1GekFRbg6ulq3JHf
         7LPg==
X-Forwarded-Encrypted: i=1; AJvYcCUDknyh8JrJUHs1VcmMtKwJLbR5Luni6nCsHQdOLyDE/C72UCbUBP7oyQ2hzymCBEu39ithP1Mw485T@vger.kernel.org, AJvYcCVvPrFl4D4PvNEk0Iozr81Fi6LHba8Q7G9p6Q8xuFawfr8SPgZ4clvVZ7HGRQcUdrRwzCvQWJb3mYnI@vger.kernel.org, AJvYcCW5lst0Lpf5Qz3QUxGX+z+gX5+fT7p8NzKitoG1+z2ReAQ8YeYzpQa2XNhJRE3P7UFf0E1zKjvPLGR7buKh@vger.kernel.org
X-Gm-Message-State: AOJu0YyHKi6X+K+Gv19r3rVvCtenHPYlMULhUm9fwZ549IyysG/ZXrSg
	LHbX3N0bRUxrv5REqaLCFK/jduz2pogYtj4/xYHDrLexJeNld6vS
X-Google-Smtp-Source: AGHT+IFGDtb1okPx8ASJ/FqC3q3kJ3m8KDX+uOf7nXaeJotGB3ywKi4Rawv85c/1vPtm8bldSFByTQ==
X-Received: by 2002:a05:690c:389:b0:6e2:71b:150 with SMTP id 00721157ae682-6e2475d07c4mr79893047b3.29.1727719961869;
        Mon, 30 Sep 2024 11:12:41 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e24536999esm15107697b3.95.2024.09.30.11.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:12:41 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 30 Sep 2024 11:12:36 -0700
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
Subject: Re: [PATCH v12 11/17] cxl/memfeature: Add CXL memory device ECS
 control feature
Message-ID: <ZvrqFHQ8TPv_c3vC@fan>
References: <20240911090447.751-1-shiju.jose@huawei.com>
 <20240911090447.751-12-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911090447.751-12-shiju.jose@huawei.com>

On Wed, Sep 11, 2024 at 10:04:40AM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 ECS (Error Check
> Scrub) control feature.
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
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/memfeature.c | 439 +++++++++++++++++++++++++++++++++-
>  1 file changed, 438 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memfeature.c b/drivers/cxl/core/memfeature.c
> index 90c68d20b02b..5d4057fa304c 100644
> --- a/drivers/cxl/core/memfeature.c
> +++ b/drivers/cxl/core/memfeature.c
> @@ -19,7 +19,7 @@
>  #include <cxl.h>
>  #include <linux/edac.h>
>  
> -#define CXL_DEV_NUM_RAS_FEATURES	1
> +#define CXL_DEV_NUM_RAS_FEATURES	2
>  #define CXL_DEV_HOUR_IN_SECS	3600
>  
>  #define CXL_SCRUB_NAME_LEN	128
> @@ -303,6 +303,405 @@ static const struct edac_scrub_ops cxl_ps_scrub_ops = {
>  	.cycle_duration_write = cxl_patrol_scrub_write_scrub_cycle,
>  };
>  
...
> +	case CXL_ECS_PARAM_THRESHOLD:
> +		wr_attrs[fru_id].ecs_config &= ~CXL_ECS_THRESHOLD_COUNT_MASK;
> +		switch (params->threshold) {
> +		case 256:
> +			wr_attrs[fru_id].ecs_config |= FIELD_PREP(CXL_ECS_THRESHOLD_COUNT_MASK,
> +								  ECS_THRESHOLD_256);
> +			break;
> +		case 1024:
> +			wr_attrs[fru_id].ecs_config |= FIELD_PREP(CXL_ECS_THRESHOLD_COUNT_MASK,
> +								  ECS_THRESHOLD_1024);
> +			break;
> +		case 4096:
> +			wr_attrs[fru_id].ecs_config |= FIELD_PREP(CXL_ECS_THRESHOLD_COUNT_MASK,
> +								  ECS_THRESHOLD_4096);
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
The messaging here can be improved. When printed out in dmesg, it looks
like

root@localhost:~# echo 2 > /sys/bus/edac/devices/cxl_mem0/ecs_fru0/mode
----
[ 6099.073006] cxl_mem mem0: Invalid CXL ECS scrub mode(2) to set
[ 6099.074407] cxl_mem mem0: Mode 0: ECS counts rows with errors 1: ECS counts codewords with errors
----
Maybe use similar message format as threshold above, like
+			dev_err(dev,
+				"Supported ECS mode: 0: ECS counts rows with errors; 1: ECS counts codewords with errors\n");

Fan
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
> +	ret = cxl_set_feature(cxlds, cxl_ecs_uuid, cxl_ecs_ctx->set_version,
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
> +static int cxl_ecs_get_log_entry_type(struct device *dev, void *drv_data,
> +				      int fru_id, u32 *val)
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
> +static int cxl_ecs_set_log_entry_type(struct device *dev, void *drv_data,
> +				      int fru_id, u32 val)
> +{
> +	struct cxl_ecs_params params = {
> +		.log_entry_type = val,
> +	};
> +
> +	return cxl_mem_ecs_set_attrs(dev, drv_data, fru_id,
> +				     &params, CXL_ECS_PARAM_LOG_ENTRY_TYPE);
> +}
> +
> +static int cxl_ecs_get_log_entry_type_per_dram(struct device *dev, void *drv_data,
> +					       int fru_id, u32 *val)
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
> +static int cxl_ecs_get_log_entry_type_per_memory_media(struct device *dev,
> +						       void *drv_data,
> +						       int fru_id, u32 *val)
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
> +static int cxl_ecs_get_mode(struct device *dev, void *drv_data,
> +			    int fru_id, u32 *val)
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
> +static int cxl_ecs_set_mode(struct device *dev, void *drv_data,
> +			    int fru_id, u32 val)
> +{
> +	struct cxl_ecs_params params = {
> +		.mode = val,
> +	};
> +
> +	return cxl_mem_ecs_set_attrs(dev, drv_data, fru_id,
> +				     &params, CXL_ECS_PARAM_MODE);
> +}
> +
> +static int cxl_ecs_get_mode_counts_rows(struct device *dev, void *drv_data,
> +					int fru_id, u32 *val)
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
> +					     int fru_id, u32 *val)
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
> +static int cxl_ecs_reset(struct device *dev, void *drv_data, int fru_id, u32 val)
> +{
> +	struct cxl_ecs_params params = {
> +		.reset_counter = val,
> +	};
> +
> +	return cxl_mem_ecs_set_attrs(dev, drv_data, fru_id,
> +				     &params, CXL_ECS_PARAM_RESET_COUNTER);
> +}
> +
> +static int cxl_ecs_get_threshold(struct device *dev, void *drv_data,
> +				 int fru_id, u32 *val)
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
> +static int cxl_ecs_set_threshold(struct device *dev, void *drv_data,
> +				 int fru_id, u32 val)
> +{
> +	struct cxl_ecs_params params = {
> +		.threshold = val,
> +	};
> +
> +	return cxl_mem_ecs_set_attrs(dev, drv_data, fru_id,
> +				     &params, CXL_ECS_PARAM_THRESHOLD);
> +}
> +
> +static const struct edac_ecs_ops cxl_ecs_ops = {
> +	.get_log_entry_type = cxl_ecs_get_log_entry_type,
> +	.set_log_entry_type = cxl_ecs_set_log_entry_type,
> +	.get_log_entry_type_per_dram = cxl_ecs_get_log_entry_type_per_dram,
> +	.get_log_entry_type_per_memory_media =
> +				cxl_ecs_get_log_entry_type_per_memory_media,
> +	.get_mode = cxl_ecs_get_mode,
> +	.set_mode = cxl_ecs_set_mode,
> +	.get_mode_counts_codewords = cxl_ecs_get_mode_counts_codewords,
> +	.get_mode_counts_rows = cxl_ecs_get_mode_counts_rows,
> +	.reset = cxl_ecs_reset,
> +	.get_threshold = cxl_ecs_get_threshold,
> +	.set_threshold = cxl_ecs_set_threshold,
> +};
> +
>  int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
>  {
>  	struct edac_dev_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
> @@ -310,7 +709,9 @@ int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
>  	struct cxl_patrol_scrub_context *cxl_ps_ctx;
>  	struct cxl_feat_entry feat_entry;
>  	char cxl_dev_name[CXL_SCRUB_NAME_LEN];
> +	struct cxl_ecs_context *cxl_ecs_ctx;
>  	int rc, i, num_ras_features = 0;
> +	int num_media_frus;
>  
>  	if (cxlr) {
>  		struct cxl_region_params *p = &cxlr->params;
> @@ -366,6 +767,42 @@ int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
>  	ras_features[num_ras_features].ctx = cxl_ps_ctx;
>  	num_ras_features++;
>  
> +	if (!cxlr) {
> +		rc = cxl_get_supported_feature_entry(cxlds, &cxl_ecs_uuid,
> +						     &feat_entry);
> +		if (rc < 0)
> +			goto feat_register;
> +
> +		if (!(feat_entry.attr_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
> +			goto feat_register;
> +		num_media_frus = feat_entry.get_feat_size /
> +					sizeof(struct cxl_ecs_rd_attrs);
> +		if (!num_media_frus)
> +			goto feat_register;
> +
> +		cxl_ecs_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ecs_ctx),
> +					   GFP_KERNEL);
> +		if (!cxl_ecs_ctx)
> +			goto feat_register;
> +		*cxl_ecs_ctx = (struct cxl_ecs_context) {
> +			.get_feat_size = feat_entry.get_feat_size,
> +			.set_feat_size = feat_entry.set_feat_size,
> +			.get_version = feat_entry.get_feat_ver,
> +			.set_version = feat_entry.set_feat_ver,
> +			.set_effects = feat_entry.set_effects,
> +			.num_media_frus = num_media_frus,
> +			.cxlmd = cxlmd,
> +		};
> +
> +		ras_features[num_ras_features].ft_type = RAS_FEAT_ECS;
> +		ras_features[num_ras_features].ecs_ops = &cxl_ecs_ops;
> +		ras_features[num_ras_features].ctx = cxl_ecs_ctx;
> +		ras_features[num_ras_features].ecs_info.num_media_frus =
> +								num_media_frus;
> +		num_ras_features++;
> +	}
> +
> +feat_register:
>  	return edac_dev_register(&cxlmd->dev, cxl_dev_name, NULL,
>  				 num_ras_features, ras_features);
>  }
> -- 
> 2.34.1
> 

-- 
Fan Ni

