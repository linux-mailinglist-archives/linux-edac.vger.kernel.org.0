Return-Path: <linux-edac+bounces-2476-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACB19C2295
	for <lists+linux-edac@lfdr.de>; Fri,  8 Nov 2024 17:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC661F249A6
	for <lists+linux-edac@lfdr.de>; Fri,  8 Nov 2024 16:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2EF19924D;
	Fri,  8 Nov 2024 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGq8fPhF"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FBD1991BD;
	Fri,  8 Nov 2024 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731085157; cv=none; b=cZKrd27i9hBwF5Iy8aUUS1Rayrc6FBVfvwjPUzmDWDcPK4wbwUFm6VybGb/+G0ROAxEfNL9DTmarUoRiMfPhc2TRh9xAqC9oBN0ItPLEMVQpt5aiRalqHQerZKlA8tF35TQ+beGSIPmZ5VMRgGDAXT+HjAzBEv1UOLuZenbeZ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731085157; c=relaxed/simple;
	bh=2qB1921ES3d5nrERKUCxgmUiFU3TkRIyVhBBHQ8tV60=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQBtwSUCtdJuAPlx0GSACRh5CjjWGiFsGBCXRwp510GkRS/QAW/C6ARpsChWtV8720AL9SpmY4EWovFCCOfEGrVp10IjOkzDlGumsUmfnmlrfHrsNgks1Xis54NAP2ArSGVsh822XttdXnSJMRHPhdDt8kdM0c1eISeWH09KAA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGq8fPhF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cdb889222so26287115ad.3;
        Fri, 08 Nov 2024 08:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731085155; x=1731689955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IofYjQ/qG0kmEmRFikBuLLYs/9nTQ05zsuJrnNg5qcE=;
        b=jGq8fPhFzhzpqP5DhjU5K1CHPRGRc701qeHBPQk6ymXds44wxBZKL12bSxfhD5E5az
         k1InQWnXm7W2z/FCx7U5RHp5Z14i3ZXOAbfBiYvsbNT/BzsI+o8jwChHLxtKWeRx1b7e
         eeZOWCG9R4kFDuo7glCNOH96L8ClIrPpuMU1xLE+oZMCph72Xgz3fjaSrgp2BMVZcIju
         P9wosApCEjprD2TJmcNqCt7nUec2WYSFoBPaWDZywoxZjPJ7YAo3o6XDuVFz95Hbeji0
         AlOcymMJM5DMLWRsqbgm+tBxc++m/eduONCZe+sMR/+3HSbBCS9Ik8eDDB9tX0PqVH9t
         mX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731085155; x=1731689955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IofYjQ/qG0kmEmRFikBuLLYs/9nTQ05zsuJrnNg5qcE=;
        b=USrp1LWQ6/TtJpEMSkFsIQ4O9wy6u8Oc59vO90KToooXl697kWjQ8qfELeO17xuqk9
         3yC4Ui5js8or0uiqFqjR8jQvNstQ295zIqJWEuDjuKFjGohmNHapvPtU9SXySbb7revY
         C+Kz4Zp3EOAxkskCskFb8WS/qsbOoA1CyBJY63trveQr8cas17ov8C38/4idoBysLpf5
         95wwtvgwEeqX6g6TB8OAnr1vXe3OnD5jud+ERwWCujOX5ywf1yroOfZ/XvOkoAM9/yrX
         27hM8aNn1fBOq5Wep2eGIumJUMoBxfVU758wxMlKB4acWj9ajn4Yhrl4mO30ygDyi26y
         sIdw==
X-Forwarded-Encrypted: i=1; AJvYcCUhpZpGDPkcYz4yw0mOHiGXYPzkllRtuqJ1DcDlrjrdRg/QHSR2ocAfROPfUxn4B/6jstP9gaotpHjVPlW8@vger.kernel.org, AJvYcCUpCKt6ubCgRgPRsirhlKSI88AttU4CA7nmq3CL8tsklj7C5hbZXqYlcV88umYY4Byc2vp5WFaQXkZV@vger.kernel.org, AJvYcCVA2SzdL4hACQavVELQYrtczq/fcyUSe2Wrq+Dzgv+oTqBsmzMBb2Y/W4q5fdLfxm7qDyNETNrv+tNX@vger.kernel.org
X-Gm-Message-State: AOJu0YwrDmR0PVrpCwR80Ww7+G+Wt/ymw37CW67rLUOQUZZrExTEIQID
	cYlvKftwdTTlGBHLUUmzWWZiKygJ5wZm4KEwC8lYS/vcskjOClel
X-Google-Smtp-Source: AGHT+IGWhVnJ8w8dTGunU5iAlULOxossc9AZhrsRoesM9ToCvxdS3BRUFy4sHpX7pUR/XHkEvCP+iw==
X-Received: by 2002:a17:902:d50c:b0:20b:449c:8978 with SMTP id d9443c01a7336-21183559ba4mr46386325ad.31.1731085154634;
        Fri, 08 Nov 2024 08:59:14 -0800 (PST)
Received: from fan ([2601:646:8f03:9fee:dc4:4a61:fe94:d7ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e5aa01sm32435205ad.211.2024.11.08.08.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 08:59:14 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Fri, 8 Nov 2024 08:59:10 -0800
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bp@alien8.de, tony.luck@intel.com,
	rafael@kernel.org, lenb@kernel.org, mchehab@kernel.org,
	dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, gregkh@linuxfoundation.org,
	sudeep.holla@arm.com, jassisinghbrar@gmail.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, david@redhat.com,
	Vilas.Sridharan@amd.com, leo.duran@amd.com, Yazen.Ghannam@amd.com,
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	gthelen@google.com, wschwartz@amperecomputing.com,
	dferguson@amperecomputing.com, wbs@os.amperecomputing.com,
	nifan.cxl@gmail.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com,
	linuxarm@huawei.com
Subject: Re: [PATCH v15 11/15] EDAC: Add memory repair control feature
Message-ID: <Zy5DXjsbsm4cQGaS@fan>
References: <20241101091735.1465-1-shiju.jose@huawei.com>
 <20241101091735.1465-12-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101091735.1465-12-shiju.jose@huawei.com>

On Fri, Nov 01, 2024 at 09:17:29AM +0000, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add generic EDAC memory repair control, eg. PPR(Post Package Repair),
> memory sparing etc, control driver in order to control memory repairs
> in the system. Supports sPPR(soft PPR), hPPR(hard PPR), soft/hard memory
> sparing, memory sparing at cacheline/row/bank/rank granularity etc.
> Device with memory repair features registers with EDAC device driver,
> which retrieves memory repair descriptor from EDAC memory repair driver and
> exposes the sysfs repair control attributes to userspace in
> /sys/bus/edac/devices/<dev-name>/mem_repairX/.
> 
> The common memory repair control interface abstracts the control of
> arbitrary memory repair functionality into a standardized set of functions.
> The sysfs memory repair attribute nodes are only available if the client
> driver has implemented the corresponding attribute callback function and
> provided operations to the EDAC device driver during registration.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  .../ABI/testing/sysfs-edac-memory-repair      | 168 ++++++++
>  drivers/edac/Makefile                         |   2 +-
>  drivers/edac/edac_device.c                    |  32 ++
>  drivers/edac/mem_repair.c                     | 367 ++++++++++++++++++
>  include/linux/edac.h                          |  87 +++++
>  5 files changed, 655 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-edac-memory-repair
>  create mode 100755 drivers/edac/mem_repair.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-edac-memory-repair b/Documentation/ABI/testing/sysfs-edac-memory-repair
> new file mode 100644
> index 000000000000..393206b8d418
...
 @@ -610,6 +611,7 @@ int edac_dev_register(struct device *parent, char *name,
>  		      const struct edac_dev_feature *ras_features)
>  {
>  	const struct attribute_group **ras_attr_groups;
> +	int mem_repair_cnt = 0, mem_repair_inst = 0;
>  	int scrub_cnt = 0, scrub_inst = 0;
>  	struct edac_dev_data *dev_data;
>  	struct edac_dev_feat_ctx *ctx;
> @@ -626,6 +628,10 @@ int edac_dev_register(struct device *parent, char *name,
>  			attr_gcnt++;
>  			scrub_cnt++;
>  			break;
> +		case RAS_FEAT_MEM_REPAIR:
> +			attr_gcnt++;
> +			mem_repair_cnt++;
> +			break;
>  		case RAS_FEAT_ECS:
>  			attr_gcnt += ras_features[feat].ecs_info.num_media_frus;
>  			break;
> @@ -652,6 +658,14 @@ int edac_dev_register(struct device *parent, char *name,
>  		}
>  	}
>  
> +	if (mem_repair_cnt) {
> +		ctx->mem_repair = kcalloc(mem_repair_cnt, sizeof(*ctx->mem_repair), GFP_KERNEL);
> +		if (!ctx->mem_repair) {
> +			ret = -ENOMEM;
> +			goto groups_free;

If the function returns here, we will have a leak from memory pointed by ctx->scrub.

Fan
> +		}
> +	}
> +
>  	attr_gcnt = 0;
>  	for (feat = 0; feat < num_features; feat++, ras_features++) {
>  		switch (ras_features->ft_type) {
> @@ -686,6 +700,23 @@ int edac_dev_register(struct device *parent, char *name,
>  
>  			attr_gcnt += ras_features->ecs_info.num_media_frus;
>  			break;
> +		case RAS_FEAT_MEM_REPAIR:
> +			if (!ras_features->mem_repair_ops ||
> +			    mem_repair_inst != ras_features->instance)
> +				goto data_mem_free;
> +
> +			dev_data = &ctx->mem_repair[mem_repair_inst];
> +			dev_data->instance = mem_repair_inst;
> +			dev_data->mem_repair_ops = ras_features->mem_repair_ops;
> +			dev_data->private = ras_features->ctx;
> +			ret = edac_mem_repair_get_desc(parent, &ras_attr_groups[attr_gcnt],
> +						       ras_features->instance);
> +			if (ret)
> +				goto data_mem_free;
> +
> +			mem_repair_inst++;
> +			attr_gcnt++;
> +			break;
>  		default:
>  			ret = -EINVAL;
>  			goto data_mem_free;
> @@ -712,6 +743,7 @@ int edac_dev_register(struct device *parent, char *name,
>  	return devm_add_action_or_reset(parent, edac_dev_unreg, &ctx->dev);
>  
>  data_mem_free:
> +	kfree(ctx->mem_repair);
>  	kfree(ctx->scrub);
>  groups_free:
>  	kfree(ras_attr_groups);
> diff --git a/drivers/edac/mem_repair.c b/drivers/edac/mem_repair.c
> new file mode 100755
> index 000000000000..93246ad0c9eb
> --- /dev/null
> +++ b/drivers/edac/mem_repair.c
> @@ -0,0 +1,367 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * The generic EDAC memory repair driver is designed to control the memory
> + * devices with memory repair features, such as Post Package Repair (PPR),
> + * memory sparing etc. The common sysfs memory repair interface abstracts
> + * the control of various arbitrary memory repair functionalities into a
> + * unified set of functions.
> + *
> + * Copyright (c) 2024 HiSilicon Limited.
> + */
> +
> +#include <linux/edac.h>
> +
> +enum edac_mem_repair_attributes {
> +	MEM_REPAIR_TYPE,
> +	MEM_REPAIR_PERSIST_MODE_AVAIL,
> +	MEM_REPAIR_PERSIST_MODE,
> +	MEM_REPAIR_DPA_SUPPORT,
> +	MEM_REPAIR_SAFE_IN_USE,
> +	MEM_REPAIR_HPA,
> +	MEM_REPAIR_DPA,
> +	MEM_REPAIR_NIBBLE_MASK,
> +	MEM_REPAIR_BANK_GROUP,
> +	MEM_REPAIR_BANK,
> +	MEM_REPAIR_RANK,
> +	MEM_REPAIR_ROW,
> +	MEM_REPAIR_COLUMN,
> +	MEM_REPAIR_CHANNEL,
> +	MEM_REPAIR_SUB_CHANNEL,
> +	MEM_REPAIR_QUERY,
> +	MEM_DO_REPAIR,
> +	MEM_REPAIR_MAX_ATTRS
> +};
> +
> +struct edac_mem_repair_dev_attr {
> +	struct device_attribute dev_attr;
> +	u8 instance;
> +};
> +
> +struct edac_mem_repair_context {
> +	char name[EDAC_FEAT_NAME_LEN];
> +	struct edac_mem_repair_dev_attr mem_repair_dev_attr[MEM_REPAIR_MAX_ATTRS];
> +	struct attribute *mem_repair_attrs[MEM_REPAIR_MAX_ATTRS + 1];
> +	struct attribute_group group;
> +};
> +
> +#define TO_MEM_REPAIR_DEV_ATTR(_dev_attr)      \
> +		container_of(_dev_attr, struct edac_mem_repair_dev_attr, dev_attr)
> +
> +#define EDAC_MEM_REPAIR_ATTR_SHOW(attrib, cb, type, format)			\
> +static ssize_t attrib##_show(struct device *ras_feat_dev,			\
> +			     struct device_attribute *attr, char *buf)		\
> +{										\
> +	u8 inst = TO_MEM_REPAIR_DEV_ATTR(attr)->instance;			\
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);		\
> +	const struct edac_mem_repair_ops *ops =					\
> +				ctx->mem_repair[inst].mem_repair_ops;		\
> +	type data;								\
> +	int ret;								\
> +										\
> +	ret = ops->cb(ras_feat_dev->parent, ctx->mem_repair[inst].private,	\
> +		      &data);							\
> +	if (ret)								\
> +		return ret;							\
> +										\
> +	return sysfs_emit(buf, format, data);					\
> +}
> +
> +EDAC_MEM_REPAIR_ATTR_SHOW(repair_type, get_repair_type, u32, "%u\n")
> +EDAC_MEM_REPAIR_ATTR_SHOW(persist_mode, get_persist_mode, u32, "%u\n")
> +EDAC_MEM_REPAIR_ATTR_SHOW(dpa_support, get_dpa_support, u32, "%u\n")
> +EDAC_MEM_REPAIR_ATTR_SHOW(repair_safe_when_in_use, get_repair_safe_when_in_use, u32, "%u\n")
> +EDAC_MEM_REPAIR_ATTR_SHOW(hpa, get_hpa, u64, "0x%llx\n")
> +EDAC_MEM_REPAIR_ATTR_SHOW(dpa, get_dpa, u64, "0x%llx\n")
> +EDAC_MEM_REPAIR_ATTR_SHOW(nibble_mask, get_nibble_mask, u64, "0x%llx\n")
> +EDAC_MEM_REPAIR_ATTR_SHOW(bank_group, get_bank_group, u32, "%u\n")
> +EDAC_MEM_REPAIR_ATTR_SHOW(bank, get_bank, u32, "%u\n")
> +EDAC_MEM_REPAIR_ATTR_SHOW(rank, get_rank, u32, "%u\n")
> +EDAC_MEM_REPAIR_ATTR_SHOW(row, get_row, u64, "0x%llx\n")
> +EDAC_MEM_REPAIR_ATTR_SHOW(column, get_column, u32, "%u\n")
> +EDAC_MEM_REPAIR_ATTR_SHOW(channel, get_channel, u32, "%u\n")
> +EDAC_MEM_REPAIR_ATTR_SHOW(sub_channel, get_sub_channel, u32, "%u\n")
> +
> +#define EDAC_MEM_REPAIR_ATTR_STORE(attrib, cb, type, conv_func)			\
> +static ssize_t attrib##_store(struct device *ras_feat_dev,			\
> +			      struct device_attribute *attr,			\
> +			      const char *buf, size_t len)			\
> +{										\
> +	u8 inst = TO_MEM_REPAIR_DEV_ATTR(attr)->instance;			\
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);		\
> +	const struct edac_mem_repair_ops *ops =					\
> +				ctx->mem_repair[inst].mem_repair_ops;		\
> +	type data;								\
> +	int ret;								\
> +										\
> +	ret = conv_func(buf, 0, &data);						\
> +	if (ret < 0)								\
> +		return ret;							\
> +										\
> +	ret = ops->cb(ras_feat_dev->parent, ctx->mem_repair[inst].private,	\
> +		      data);							\
> +	if (ret)								\
> +		return ret;							\
> +										\
> +	return len;								\
> +}
> +
> +EDAC_MEM_REPAIR_ATTR_STORE(persist_mode, set_persist_mode, unsigned long, kstrtoul)
> +EDAC_MEM_REPAIR_ATTR_STORE(hpa, set_hpa, u64, kstrtou64)
> +EDAC_MEM_REPAIR_ATTR_STORE(dpa, set_dpa, u64, kstrtou64)
> +EDAC_MEM_REPAIR_ATTR_STORE(nibble_mask, set_nibble_mask, u64, kstrtou64)
> +EDAC_MEM_REPAIR_ATTR_STORE(bank_group, set_bank_group, unsigned long, kstrtoul)
> +EDAC_MEM_REPAIR_ATTR_STORE(bank, set_bank, unsigned long, kstrtoul)
> +EDAC_MEM_REPAIR_ATTR_STORE(rank, set_rank, unsigned long, kstrtoul)
> +EDAC_MEM_REPAIR_ATTR_STORE(row, set_row, u64, kstrtou64)
> +EDAC_MEM_REPAIR_ATTR_STORE(column, set_column, unsigned long, kstrtoul)
> +EDAC_MEM_REPAIR_ATTR_STORE(channel, set_channel, unsigned long, kstrtoul)
> +EDAC_MEM_REPAIR_ATTR_STORE(sub_channel, set_sub_channel, unsigned long, kstrtoul)
> +
> +#define EDAC_MEM_REPAIR_DO_OP(attrib, cb)						\
> +static ssize_t attrib##_store(struct device *ras_feat_dev,				\
> +			      struct device_attribute *attr,				\
> +			      const char *buf, size_t len)				\
> +{											\
> +	u8 inst = TO_MEM_REPAIR_DEV_ATTR(attr)->instance;				\
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);			\
> +	const struct edac_mem_repair_ops *ops = ctx->mem_repair[inst].mem_repair_ops;	\
> +	int ret;									\
> +											\
> +	ret = ops->cb(ras_feat_dev->parent, ctx->mem_repair[inst].private);		\
> +	if (ret)									\
> +		return ret;								\
> +											\
> +	return len;									\
> +}
> +
> +EDAC_MEM_REPAIR_DO_OP(query, do_query)
> +EDAC_MEM_REPAIR_DO_OP(repair, do_repair)
> +
> +static ssize_t persist_mode_avail_show(struct device *ras_feat_dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	u8 inst = TO_MEM_REPAIR_DEV_ATTR(attr)->instance;
> +	const struct edac_mem_repair_ops *ops = ctx->mem_repair[inst].mem_repair_ops;
> +
> +	return ops->get_persist_mode_avail(ras_feat_dev->parent,
> +					   ctx->mem_repair[inst].private, buf);
> +}
> +
> +static umode_t mem_repair_attr_visible(struct kobject *kobj, struct attribute *a, int attr_id)
> +{
> +	struct device *ras_feat_dev = kobj_to_dev(kobj);
> +	struct device_attribute *dev_attr = container_of(a, struct device_attribute, attr);
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	u8 inst = TO_MEM_REPAIR_DEV_ATTR(dev_attr)->instance;
> +	const struct edac_mem_repair_ops *ops = ctx->mem_repair[inst].mem_repair_ops;
> +
> +	switch (attr_id) {
> +	case MEM_REPAIR_TYPE:
> +		if (ops->get_repair_type)
> +			return a->mode;
> +		break;
> +	case MEM_REPAIR_PERSIST_MODE_AVAIL:
> +		if (ops->get_persist_mode_avail)
> +			return a->mode;
> +		break;
> +	case MEM_REPAIR_PERSIST_MODE:
> +		if (ops->get_persist_mode) {
> +			if (ops->set_persist_mode)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
> +		break;
> +	case MEM_REPAIR_DPA_SUPPORT:
> +		if (ops->get_dpa_support)
> +			return a->mode;
> +		break;
> +	case MEM_REPAIR_SAFE_IN_USE:
> +		if (ops->get_repair_safe_when_in_use)
> +			return a->mode;
> +		break;
> +	case MEM_REPAIR_HPA:
> +		if (ops->get_hpa) {
> +			if (ops->set_hpa)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
> +		break;
> +	case MEM_REPAIR_DPA:
> +		if (ops->get_dpa) {
> +			if (ops->set_dpa)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
> +		break;
> +	case MEM_REPAIR_NIBBLE_MASK:
> +		if (ops->get_nibble_mask) {
> +			if (ops->set_nibble_mask)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
> +		break;
> +	case MEM_REPAIR_BANK_GROUP:
> +		if (ops->get_bank_group) {
> +			if (ops->set_bank_group)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
> +		break;
> +	case MEM_REPAIR_BANK:
> +		if (ops->get_bank) {
> +			if (ops->set_bank)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
> +		break;
> +	case MEM_REPAIR_RANK:
> +		if (ops->get_rank) {
> +			if (ops->set_rank)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
> +		break;
> +	case MEM_REPAIR_ROW:
> +		if (ops->get_row) {
> +			if (ops->set_row)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
> +		break;
> +	case MEM_REPAIR_COLUMN:
> +		if (ops->get_column) {
> +			if (ops->set_column)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
> +		break;
> +	case MEM_REPAIR_CHANNEL:
> +		if (ops->get_channel) {
> +			if (ops->set_channel)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
> +		break;
> +	case MEM_REPAIR_SUB_CHANNEL:
> +		if (ops->get_sub_channel) {
> +			if (ops->set_sub_channel)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
> +		break;
> +	case MEM_REPAIR_QUERY:
> +		if (ops->do_query)
> +			return a->mode;
> +		break;
> +	case MEM_DO_REPAIR:
> +		if (ops->do_repair)
> +			return a->mode;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +#define EDAC_MEM_REPAIR_ATTR_RO(_name, _instance)       \
> +	((struct edac_mem_repair_dev_attr) { .dev_attr = __ATTR_RO(_name), \
> +					     .instance = _instance })
> +
> +#define EDAC_MEM_REPAIR_ATTR_WO(_name, _instance)       \
> +	((struct edac_mem_repair_dev_attr) { .dev_attr = __ATTR_WO(_name), \
> +					     .instance = _instance })
> +
> +#define EDAC_MEM_REPAIR_ATTR_RW(_name, _instance)       \
> +	((struct edac_mem_repair_dev_attr) { .dev_attr = __ATTR_RW(_name), \
> +					     .instance = _instance })
> +
> +static int mem_repair_create_desc(struct device *dev,
> +				  const struct attribute_group **attr_groups,
> +				  u8 instance)
> +{
> +	struct edac_mem_repair_context *ctx;
> +	struct attribute_group *group;
> +	int i;
> +	struct edac_mem_repair_dev_attr dev_attr[] = {
> +		[MEM_REPAIR_TYPE] = EDAC_MEM_REPAIR_ATTR_RO(repair_type,
> +							    instance),
> +		[MEM_REPAIR_PERSIST_MODE_AVAIL] =
> +				EDAC_MEM_REPAIR_ATTR_RO(persist_mode_avail,
> +							instance),
> +		[MEM_REPAIR_PERSIST_MODE] =
> +				EDAC_MEM_REPAIR_ATTR_RW(persist_mode, instance),
> +		[MEM_REPAIR_DPA_SUPPORT] =
> +				EDAC_MEM_REPAIR_ATTR_RO(dpa_support, instance),
> +		[MEM_REPAIR_SAFE_IN_USE] =
> +				EDAC_MEM_REPAIR_ATTR_RO(repair_safe_when_in_use,
> +							instance),
> +		[MEM_REPAIR_HPA] = EDAC_MEM_REPAIR_ATTR_RW(hpa, instance),
> +		[MEM_REPAIR_DPA] = EDAC_MEM_REPAIR_ATTR_RW(dpa, instance),
> +		[MEM_REPAIR_NIBBLE_MASK] =
> +				EDAC_MEM_REPAIR_ATTR_RW(nibble_mask, instance),
> +		[MEM_REPAIR_BANK_GROUP] =
> +				EDAC_MEM_REPAIR_ATTR_RW(bank_group, instance),
> +		[MEM_REPAIR_BANK] = EDAC_MEM_REPAIR_ATTR_RW(bank, instance),
> +		[MEM_REPAIR_RANK] = EDAC_MEM_REPAIR_ATTR_RW(rank, instance),
> +		[MEM_REPAIR_ROW] = EDAC_MEM_REPAIR_ATTR_RW(row, instance),
> +		[MEM_REPAIR_COLUMN] = EDAC_MEM_REPAIR_ATTR_RW(column, instance),
> +		[MEM_REPAIR_CHANNEL] = EDAC_MEM_REPAIR_ATTR_RW(channel, instance),
> +		[MEM_REPAIR_SUB_CHANNEL] =
> +				EDAC_MEM_REPAIR_ATTR_RW(sub_channel, instance),
> +		[MEM_REPAIR_QUERY] = EDAC_MEM_REPAIR_ATTR_WO(query, instance),
> +		[MEM_DO_REPAIR] = EDAC_MEM_REPAIR_ATTR_WO(repair, instance)
> +	};
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < MEM_REPAIR_MAX_ATTRS; i++) {
> +		memcpy(&ctx->mem_repair_dev_attr[i].dev_attr,
> +		       &dev_attr[i], sizeof(dev_attr[i]));
> +		ctx->mem_repair_attrs[i] =
> +				&ctx->mem_repair_dev_attr[i].dev_attr.attr;
> +	}
> +
> +	sprintf(ctx->name, "%s%d", "mem_repair", instance);
> +	group = &ctx->group;
> +	group->name = ctx->name;
> +	group->attrs = ctx->mem_repair_attrs;
> +	group->is_visible  = mem_repair_attr_visible;
> +	attr_groups[0] = group;
> +
> +	return 0;
> +}
> +
> +/**
> + * edac_mem_repair_get_desc - get EDAC memory repair descriptors
> + * @dev: client device with memory repair feature
> + * @attr_groups: pointer to attribute group container
> + * @instance: device's memory repair instance number.
> + *
> + * Return:
> + *  * %0	- Success.
> + *  * %-EINVAL	- Invalid parameters passed.
> + *  * %-ENOMEM	- Dynamic memory allocation failed.
> + */
> +int edac_mem_repair_get_desc(struct device *dev,
> +			     const struct attribute_group **attr_groups, u8 instance)
> +{
> +	if (!dev || !attr_groups)
> +		return -EINVAL;
> +
> +	return mem_repair_create_desc(dev, attr_groups, instance);
> +}
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index 04385b1a9283..b52730d63088 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -670,6 +670,7 @@ static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
>  enum edac_dev_feat {
>  	RAS_FEAT_SCRUB,
>  	RAS_FEAT_ECS,
> +	RAS_FEAT_MEM_REPAIR,
>  	RAS_FEAT_MAX
>  };
>  
> @@ -731,11 +732,95 @@ int edac_ecs_get_desc(struct device *ecs_dev,
>  		      const struct attribute_group **attr_groups,
>  		      u16 num_media_frus);
>  
> +enum edac_mem_repair_type {
> +	EDAC_TYPE_SPPR,
> +	EDAC_TYPE_HPPR,
> +	EDAC_TYPE_CACHELINE_MEM_SPARING,
> +	EDAC_TYPE_ROW_MEM_SPARING,
> +	EDAC_TYPE_BANK_MEM_SPARING,
> +	EDAC_TYPE_RANK_MEM_SPARING,
> +};
> +
> +enum edac_mem_repair_persist_mode {
> +	EDAC_MEM_REPAIR_SOFT, /* soft memory repair */
> +	EDAC_MEM_REPAIR_HARD, /* hard memory repair */
> +};
> +
> +/**
> + * struct edac_mem_repair_ops - memory repair device operations
> + * (all elements optional)
> + * @get_repair_type: get the memory repair type, listed in enum edac_mem_repair_type.
> + * @get_persist_mode_avail: get the persist modes supported in the device.
> + * @get_persist_mode: get the persist mode of the memory repair instance.
> + * @set_persist_mode: set the persist mode for the memory repair instance.
> + * @get_dpa_support: get dpa support flag.
> + * @get_repair_safe_when_in_use: get whether memory media is accessible and
> + *			       data is retained during repair operation.
> + * @get_hpa: get HPA for memory repair.
> + * @set_hpa: set HPA for memory repair.
> + * @get_dpa: get DPA for memory repair.
> + * @set_dpa: set DPA for memory repair.
> + * @get_nibble_mask: get nibble mask for memory repair.
> + * @set_nibble_mask: set nibble mask for memory repair.
> + * @get_bank_group: get bank group for memory repair.
> + * @set_bank_group: set bank group for memory repair.
> + * @get_bank: get bank for memory repair.
> + * @set_bank: set bank for memory repair.
> + * @get_rank: get rank for memory repair.
> + * @set_rank: set rank for memory repair.
> + * @get_row: get row for memory repair.
> + * @set_row: set row for memory repair.
> + * @get_column: get column for memory repair.
> + * @set_column: set column for memory repair.
> + * @get_channel: get channel for memory repair.
> + * @set_channel: set channel for memory repair.
> + * @get_sub_channel: get sub channel for memory repair.
> + * @set_sub_channel: set sub channel for memory repair.
> + * @do_query: Query memory repair operation for the HPA/DPA/other attrs set
> + *	      is supported or not.
> + * @do_repair: start memory repair operation for the HPA/DPA/other attrs set.
> + */
> +struct edac_mem_repair_ops {
> +	int (*get_repair_type)(struct device *dev, void *drv_data, u32 *val);
> +	int (*get_persist_mode_avail)(struct device *dev, void *drv_data, char *buf);
> +	int (*get_persist_mode)(struct device *dev, void *drv_data, u32 *mode);
> +	int (*set_persist_mode)(struct device *dev, void *drv_data, u32 mode);
> +	int (*get_dpa_support)(struct device *dev, void *drv_data, u32 *val);
> +	int (*get_repair_safe_when_in_use)(struct device *dev, void *drv_data, u32 *val);
> +	int (*get_hpa)(struct device *dev, void *drv_data, u64 *hpa);
> +	int (*set_hpa)(struct device *dev, void *drv_data, u64 hpa);
> +	int (*get_dpa)(struct device *dev, void *drv_data, u64 *dpa);
> +	int (*set_dpa)(struct device *dev, void *drv_data, u64 dpa);
> +	int (*get_nibble_mask)(struct device *dev, void *drv_data, u64 *val);
> +	int (*set_nibble_mask)(struct device *dev, void *drv_data, u64 val);
> +	int (*get_bank_group)(struct device *dev, void *drv_data, u32 *val);
> +	int (*set_bank_group)(struct device *dev, void *drv_data, u32 val);
> +	int (*get_bank)(struct device *dev, void *drv_data, u32 *val);
> +	int (*set_bank)(struct device *dev, void *drv_data, u32 val);
> +	int (*get_rank)(struct device *dev, void *drv_data, u32 *val);
> +	int (*set_rank)(struct device *dev, void *drv_data, u32 val);
> +	int (*get_row)(struct device *dev, void *drv_data, u64 *val);
> +	int (*set_row)(struct device *dev, void *drv_data, u64 val);
> +	int (*get_column)(struct device *dev, void *drv_data, u32 *val);
> +	int (*set_column)(struct device *dev, void *drv_data, u32 val);
> +	int (*get_channel)(struct device *dev, void *drv_data, u32 *val);
> +	int (*set_channel)(struct device *dev, void *drv_data, u32 val);
> +	int (*get_sub_channel)(struct device *dev, void *drv_data, u32 *val);
> +	int (*set_sub_channel)(struct device *dev, void *drv_data, u32 val);
> +	int (*do_query)(struct device *dev, void *drv_data);
> +	int (*do_repair)(struct device *dev, void *drv_data);
> +};
> +
> +int edac_mem_repair_get_desc(struct device *dev,
> +			     const struct attribute_group **attr_groups,
> +			     u8 instance);
> +
>  /* EDAC device feature information structure */
>  struct edac_dev_data {
>  	union {
>  		const struct edac_scrub_ops *scrub_ops;
>  		const struct edac_ecs_ops *ecs_ops;
> +		const struct edac_mem_repair_ops *mem_repair_ops;
>  	};
>  	u8 instance;
>  	void *private;
> @@ -746,6 +831,7 @@ struct edac_dev_feat_ctx {
>  	void *private;
>  	struct edac_dev_data *scrub;
>  	struct edac_dev_data ecs;
> +	struct edac_dev_data *mem_repair;
>  };
>  
>  struct edac_dev_feature {
> @@ -754,6 +840,7 @@ struct edac_dev_feature {
>  	union {
>  		const struct edac_scrub_ops *scrub_ops;
>  		const struct edac_ecs_ops *ecs_ops;
> +		const struct edac_mem_repair_ops *mem_repair_ops;
>  	};
>  	void *ctx;
>  	struct edac_ecs_ex_info ecs_info;
> -- 
> 2.34.1
> 

-- 
Fan Ni

