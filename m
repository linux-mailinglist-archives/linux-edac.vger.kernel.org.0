Return-Path: <linux-edac+bounces-3079-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED98A350BB
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 22:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071851890914
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 21:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B0326981E;
	Thu, 13 Feb 2025 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAiYsAHZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943B4241673;
	Thu, 13 Feb 2025 21:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739483700; cv=none; b=rr1MNL7+e9hprQSlNS53DPTTUD/ckZGB3ZHs9se5OykBtyO/KmTiTb8XNIS9WL76RX9KNr1nF89JIwdvd/7P36YrobExGl/n3awfw4u866H77mXBHPckC7JzCDenrVFgqO0ZnPsxUH4lhK2I/XGfFLz90hgg+ac6KXdu2+9/q6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739483700; c=relaxed/simple;
	bh=jcepQgAWzSBQlzDMXLyI0xl+fHGReOFitNX+zeqKUtk=;
	h=Message-ID:From:Date:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pViO7wVQE3oh3dvG8GB2v/2sq/8gwp6XljYmN8E4stPpxrVXIp5eSuQMY5Fw+io1TSgHL7udtmsLk6Ha6dKhbh55ZhWhnnep9I3cBa13mOQjMci2r7AXEieQ1NwWuSpADZ5b47WllGiQzMA+hn3Xm1qWO4w4Q8cTc0ZCNSJoeTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAiYsAHZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f7f1e1194so34918715ad.2;
        Thu, 13 Feb 2025 13:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739483698; x=1740088498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zXqjkMomEhU6qi7QsxovQC87Ti+8c6P77nOqA/9a79s=;
        b=EAiYsAHZUjmPzsqlarGg9qkIa3SVkp7CnwljozqACgqH/KWGVp9XbXmXq50eR8fu2G
         Se+sV5F1H7o2k3doXT2YuPxY9CPnP0oalmIYjBGWAuMcJY+kTHn/fnrtG5nBqcVgZ3TK
         D4w/Ds9wvOItdC37wG7d860hJGt8O3Q6rrl+uDmO08LDQEkNbgE9cl+eM3oRVrvburlX
         B7P5LbRIxaL6iZ48Y9P55CvXRm72/scG0W11BL1QwelrJd+35fL6GXk17cJOBAZ3s3oz
         f/Cz7KdPChFN/1JBB/K0qq8gS7KdeucbzSLPNn+tyE6SyOK9ERT9b9plMwvuu+bIHpIe
         ykuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739483698; x=1740088498;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXqjkMomEhU6qi7QsxovQC87Ti+8c6P77nOqA/9a79s=;
        b=PU9E3CZpO6JmGRRuuSea0ueF3FbqbcvDN1stQ9RXKeOcWvccZzjmIOxAuCaSrhpPYG
         MZaYnOUHUx6T7J8PEENyk/le1KqLcAGwRwgFpOPug1ZeA9zt3Xsdu2cbZETUpKwt7diw
         RZae8DhPSML0RV/ZZiA+TJNeOFJQH5EiEgXernKYdiQTk78/qLCUGv8AzUuMWfhCtfLu
         KsQzdaXzEg9+nHJQI9xtM4Gm7LNxtprOTFCgWNlWzBlP25T1eHBze0IlLyxs8rg1jzvg
         M0qYZgZW/OjuoW7uQRlauOLXoK1xwo8hZFv4O8LWXP8xTik2VvFPtrqvj7lMugklN4lW
         6ZPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHNchkf/RvQdiI8Qrgqg9PLLDZnnkvhMtTGLJyxkjcBVlmX6vekLqvOJh+Ic12ut7nOxShDi9OhgTO@vger.kernel.org, AJvYcCWc9qViw33Ze/wajI68MGWnjEIvvP6GZLe/3Mg9LQGXfgdlZmRyeYCUif8u4vPWuIVsRTREVfnctXpY@vger.kernel.org, AJvYcCXcQdQnYiM2dWVjnbyL9VBwPDZpyMfPsQ3qK6xyJLdN5Yv2rOL18QJw8Im13QIa7dvdz/IlBl/Trp1I@vger.kernel.org, AJvYcCXhL2+2rLPsYU/pNFFDtudH3LfL0VmNbtKEwu56ntIlNIl+ymjFCvxWr7WfiS8Bz0LbZMdgZrnNx+3AZcm2@vger.kernel.org
X-Gm-Message-State: AOJu0YxK9dpZWWYtX4LuIXo77wz8yhzsS/a5B89MFzinze8HIyM/fIMU
	rEEzKEej5Q+crZHr6DkU5etTd15zm1FQQKp6VrTELKuQUl+9KFS5
X-Gm-Gg: ASbGncukifdSk2xfKgcCiOQn3gEALHNZpwlKdU2bHy0DTVo6G4hmS19pE5MVuQNwKbS
	bamN1Gc4oNdA+9gps/8qBG9tGp4BM8m4bWtvANueAH31r5t97oro8+TxFKXTOW8KyQc3rvVMGqu
	a8Mi1CkPmSfjpIBX7RrFtmOsqHueTq72a5VeyKlfzxSQo95xMtgwgdd1BFTnuGhaABj+71AJcxb
	Pq/OW/vBFaRjLW4WAkUtJkhiQxrckqa52H3t7ucVDj0SDRh4PNzKDP7yj2NXF3ooPQP5oC2tVpt
	zJgWsDN7e0ySmAv06wMDRKteeeKcG8gJy+m1DH8P1u0=
X-Google-Smtp-Source: AGHT+IFI9jDm1VfuN6QWAb5rv5FuI+fD2JrzWIO0z4H1qMRqdbvVsXjHFdb/2o3V8cmCntm0azHixw==
X-Received: by 2002:a17:903:230b:b0:21f:49f2:e33f with SMTP id d9443c01a7336-220bbb243c2mr148341915ad.21.1739483697334;
        Thu, 13 Feb 2025 13:54:57 -0800 (PST)
Received: from asus. (c-73-189-148-61.hsd1.ca.comcast.net. [73.189.148.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53494afsm17096425ad.18.2025.02.13.13.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 13:54:56 -0800 (PST)
Message-ID: <67ae6a30.170a0220.3a1e25.9914@mx.google.com>
X-Google-Original-Message-ID: <Z65qI5VAj7tkYhmV@asus.>
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 13 Feb 2025 13:54:43 -0800
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	bp@alien8.de, tony.luck@intel.com, rafael@kernel.org,
	lenb@kernel.org, mchehab@kernel.org, dan.j.williams@intel.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
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
Subject: Re: [PATCH v20 03/15] EDAC: Add ECS control feature
References: <20250212143654.1893-1-shiju.jose@huawei.com>
 <20250212143654.1893-4-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212143654.1893-4-shiju.jose@huawei.com>

On Wed, Feb 12, 2025 at 02:36:41PM +0000, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add EDAC ECS (Error Check Scrub) control to manage a memory device's
> ECS feature.
> 
> The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
> Specification (JESD79-5) and allows the DRAM to internally read, correct
> single-bit errors, and write back corrected data bits to the DRAM array
> while providing transparency to error counts.
> 
> The DDR5 device contains number of memory media FRUs per device. The
> DDR5 ECS feature and thus the ECS control driver supports configuring
> the ECS parameters per FRU.
> 
> Memory devices support the ECS feature register with the EDAC device
> driver, which retrieves the ECS descriptor from the EDAC ECS driver.
> This driver exposes sysfs ECS control attributes to userspace via
> /sys/bus/edac/devices/<dev-name>/ecs_fruX/.
> 
> The common sysfs ECS control interface abstracts the control of an
> arbitrary ECS functionality to a common set of functions.
> 
> Support for the ECS feature is added separately because the control
> attributes of the DDR5 ECS feature differ from those of the scrub
> feature.
> 
> The sysfs ECS attribute nodes are only present if the client driver
> has implemented the corresponding attribute callback function and
> passed the necessary operations to the EDAC RAS feature driver during
> registration.
> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Tested-by: Fan Ni <fan.ni@samsung.com>


> ---
>  Documentation/ABI/testing/sysfs-edac-ecs |  74 ++++++++
>  Documentation/edac/scrub.rst             |   2 +
>  drivers/edac/Kconfig                     |   9 +
>  drivers/edac/Makefile                    |   1 +
>  drivers/edac/ecs.c                       | 207 +++++++++++++++++++++++
>  drivers/edac/edac_device.c               |  17 ++
>  include/linux/edac.h                     |  48 +++++-
>  7 files changed, 356 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-edac-ecs
>  create mode 100755 drivers/edac/ecs.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-edac-ecs b/Documentation/ABI/testing/sysfs-edac-ecs
> new file mode 100644
> index 000000000000..87c885c4eb1a
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-edac-ecs
> @@ -0,0 +1,74 @@
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fruX
> +Date:		March 2025
> +KernelVersion:	6.15
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		The sysfs EDAC bus devices /<dev-name>/ecs_fruX subdirectory
> +		pertains to the memory media ECS (Error Check Scrub) control
> +		feature, where <dev-name> directory corresponds to a device
> +		registered with the EDAC device driver for the ECS feature.
> +		/ecs_fruX belongs to the media FRUs (Field Replaceable Unit)
> +		under the memory device.
> +
> +		The sysfs ECS attr nodes are only present if the parent
> +		driver has implemented the corresponding attr callback
> +		function and provided the necessary operations to the EDAC
> +		device driver during registration.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fruX/log_entry_type
> +Date:		March 2025
> +KernelVersion:	6.15
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) The log entry type of how the DDR5 ECS log is reported.
> +
> +		- 0 - per DRAM.
> +
> +		- 1 - per memory media FRU.
> +
> +		- All other values are reserved.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fruX/mode
> +Date:		March 2025
> +KernelVersion:	6.15
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) The mode of how the DDR5 ECS counts the errors.
> +		Error count is tracked based on two different modes
> +		selected by DDR5 ECS Control Feature - Codeword mode and
> +		Row Count mode. If the ECS is under Codeword mode, then
> +		the error count increments each time a codeword with check
> +		bit errors is detected. If the ECS is under Row Count mode,
> +		then the error counter increments each time a row with
> +		check bit errors is detected.
> +
> +		- 0 - ECS counts rows in the memory media that have ECC errors.
> +
> +		- 1 - ECS counts codewords with errors, specifically, it counts
> +		      the number of ECC-detected errors in the memory media.
> +
> +		- All other values are reserved.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fruX/reset
> +Date:		March 2025
> +KernelVersion:	6.15
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(WO) ECS reset ECC counter.
> +
> +		- 1 - reset ECC counter to the default value.
> +
> +		- All other values are reserved.
> +
> +What:		/sys/bus/edac/devices/<dev-name>/ecs_fruX/threshold
> +Date:		March 2025
> +KernelVersion:	6.15
> +Contact:	linux-edac@vger.kernel.org
> +Description:
> +		(RW) DDR5 ECS threshold count per gigabits of memory cells.
> +		The ECS error count is subject to the ECS Threshold count
> +		per Gbit, which masks error counts less than the Threshold.
> +
> +		Supported values are 256, 1024 and 4096.
> +
> +		All other values are reserved.
> diff --git a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst
> index 50bb44b126fa..5f1ff2bf54b0 100644
> --- a/Documentation/edac/scrub.rst
> +++ b/Documentation/edac/scrub.rst
> @@ -257,3 +257,5 @@ sysfs
>  
>  Sysfs files are documented in
>  `Documentation/ABI/testing/sysfs-edac-scrub`
> +
> +`Documentation/ABI/testing/sysfs-edac-ecs`
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 175d706168ab..9dfc2ea02df1 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -84,6 +84,15 @@ config EDAC_SCRUB
>  	  into a unified set of functions.
>  	  Say 'y/n' to enable/disable EDAC scrub feature.
>  
> +config EDAC_ECS
> +	bool "EDAC ECS (Error Check Scrub) feature"
> +	help
> +	  The EDAC ECS feature is optional and is designed to control on-die
> +	  error check scrub (e.g., DDR5 ECS) in the system. The common sysfs
> +	  ECS interface abstracts the control of various ECS functionalities
> +	  into a unified set of functions.
> +	  Say 'y/n' to enable/disable EDAC ECS feature.
> +
>  config EDAC_AMD64
>  	tristate "AMD64 (Opteron, Athlon64)"
>  	depends on AMD_NB && EDAC_DECODE_MCE
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index f2a86ed997b7..21334b909ec4 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -14,6 +14,7 @@ edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o
>  edac_core-$(CONFIG_EDAC_DEBUG)		+= debugfs.o
>  
>  edac_core-$(CONFIG_EDAC_SCRUB)		+= scrub.o
> +edac_core-$(CONFIG_EDAC_ECS)		+= ecs.o
>  
>  ifdef CONFIG_PCI
>  edac_core-y	+= edac_pci.o edac_pci_sysfs.o
> diff --git a/drivers/edac/ecs.c b/drivers/edac/ecs.c
> new file mode 100755
> index 000000000000..7fd97984e039
> --- /dev/null
> +++ b/drivers/edac/ecs.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * The generic ECS driver is designed to support control of on-die error
> + * check scrub (e.g., DDR5 ECS). The common sysfs ECS interface abstracts
> + * the control of various ECS functionalities into a unified set of functions.
> + *
> + * Copyright (c) 2024-2025 HiSilicon Limited.
> + */
> +
> +#include <linux/edac.h>
> +
> +#define EDAC_ECS_FRU_NAME "ecs_fru"
> +
> +enum edac_ecs_attributes {
> +	ECS_LOG_ENTRY_TYPE,
> +	ECS_MODE,
> +	ECS_RESET,
> +	ECS_THRESHOLD,
> +	ECS_MAX_ATTRS
> +};
> +
> +struct edac_ecs_dev_attr {
> +	struct device_attribute dev_attr;
> +	int fru_id;
> +};
> +
> +struct edac_ecs_fru_context {
> +	char name[EDAC_FEAT_NAME_LEN];
> +	struct edac_ecs_dev_attr dev_attr[ECS_MAX_ATTRS];
> +	struct attribute *ecs_attrs[ECS_MAX_ATTRS + 1];
> +	struct attribute_group group;
> +};
> +
> +struct edac_ecs_context {
> +	u16 num_media_frus;
> +	struct edac_ecs_fru_context *fru_ctxs;
> +};
> +
> +#define TO_ECS_DEV_ATTR(_dev_attr)	\
> +	container_of(_dev_attr, struct edac_ecs_dev_attr, dev_attr)
> +
> +#define EDAC_ECS_ATTR_SHOW(attrib, cb, type, format)				\
> +static ssize_t attrib##_show(struct device *ras_feat_dev,			\
> +			     struct device_attribute *attr, char *buf)		\
> +{										\
> +	struct edac_ecs_dev_attr *dev_attr = TO_ECS_DEV_ATTR(attr);		\
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);		\
> +	const struct edac_ecs_ops *ops = ctx->ecs.ecs_ops;			\
> +	type data;								\
> +	int ret;								\
> +										\
> +	ret = ops->cb(ras_feat_dev->parent, ctx->ecs.private,			\
> +		      dev_attr->fru_id, &data);					\
> +	if (ret)								\
> +		return ret;							\
> +										\
> +	return sysfs_emit(buf, format, data);					\
> +}
> +
> +EDAC_ECS_ATTR_SHOW(log_entry_type, get_log_entry_type, u32, "%u\n")
> +EDAC_ECS_ATTR_SHOW(mode, get_mode, u32, "%u\n")
> +EDAC_ECS_ATTR_SHOW(threshold, get_threshold, u32, "%u\n")
> +
> +#define EDAC_ECS_ATTR_STORE(attrib, cb, type, conv_func)			\
> +static ssize_t attrib##_store(struct device *ras_feat_dev,			\
> +			      struct device_attribute *attr,			\
> +			      const char *buf, size_t len)			\
> +{										\
> +	struct edac_ecs_dev_attr *dev_attr = TO_ECS_DEV_ATTR(attr);		\
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);		\
> +	const struct edac_ecs_ops *ops = ctx->ecs.ecs_ops;			\
> +	type data;								\
> +	int ret;								\
> +										\
> +	ret = conv_func(buf, 0, &data);						\
> +	if (ret < 0)								\
> +		return ret;							\
> +										\
> +	ret = ops->cb(ras_feat_dev->parent, ctx->ecs.private,			\
> +		      dev_attr->fru_id, data);					\
> +	if (ret)								\
> +		return ret;							\
> +										\
> +	return len;								\
> +}
> +
> +EDAC_ECS_ATTR_STORE(log_entry_type, set_log_entry_type, unsigned long, kstrtoul)
> +EDAC_ECS_ATTR_STORE(mode, set_mode, unsigned long, kstrtoul)
> +EDAC_ECS_ATTR_STORE(reset, reset, unsigned long, kstrtoul)
> +EDAC_ECS_ATTR_STORE(threshold, set_threshold, unsigned long, kstrtoul)
> +
> +static umode_t ecs_attr_visible(struct kobject *kobj, struct attribute *a, int attr_id)
> +{
> +	struct device *ras_feat_dev = kobj_to_dev(kobj);
> +	struct edac_dev_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ecs_ops;
> +
> +	switch (attr_id) {
> +	case ECS_LOG_ENTRY_TYPE:
> +		if (ops->get_log_entry_type)  {
> +			if (ops->set_log_entry_type)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
> +		break;
> +	case ECS_MODE:
> +		if (ops->get_mode) {
> +			if (ops->set_mode)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
> +		break;
> +	case ECS_RESET:
> +		if (ops->reset)
> +			return a->mode;
> +		break;
> +	case ECS_THRESHOLD:
> +		if (ops->get_threshold) {
> +			if (ops->set_threshold)
> +				return a->mode;
> +			else
> +				return 0444;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +#define EDAC_ECS_ATTR_RO(_name, _fru_id)       \
> +	((struct edac_ecs_dev_attr) { .dev_attr = __ATTR_RO(_name), \
> +				     .fru_id = _fru_id })
> +
> +#define EDAC_ECS_ATTR_WO(_name, _fru_id)       \
> +	((struct edac_ecs_dev_attr) { .dev_attr = __ATTR_WO(_name), \
> +				     .fru_id = _fru_id })
> +
> +#define EDAC_ECS_ATTR_RW(_name, _fru_id)       \
> +	((struct edac_ecs_dev_attr) { .dev_attr = __ATTR_RW(_name), \
> +				     .fru_id = _fru_id })
> +
> +static int ecs_create_desc(struct device *ecs_dev,
> +			   const struct attribute_group **attr_groups, u16 num_media_frus)
> +{
> +	struct edac_ecs_context *ecs_ctx;
> +	u32 fru;
> +
> +	ecs_ctx = devm_kzalloc(ecs_dev, sizeof(*ecs_ctx), GFP_KERNEL);
> +	if (!ecs_ctx)
> +		return -ENOMEM;
> +
> +	ecs_ctx->num_media_frus = num_media_frus;
> +	ecs_ctx->fru_ctxs = devm_kcalloc(ecs_dev, num_media_frus,
> +					 sizeof(*ecs_ctx->fru_ctxs),
> +					 GFP_KERNEL);
> +	if (!ecs_ctx->fru_ctxs)
> +		return -ENOMEM;
> +
> +	for (fru = 0; fru < num_media_frus; fru++) {
> +		struct edac_ecs_fru_context *fru_ctx = &ecs_ctx->fru_ctxs[fru];
> +		struct attribute_group *group = &fru_ctx->group;
> +		int i;
> +
> +		fru_ctx->dev_attr[ECS_LOG_ENTRY_TYPE] =
> +					EDAC_ECS_ATTR_RW(log_entry_type, fru);
> +		fru_ctx->dev_attr[ECS_MODE] = EDAC_ECS_ATTR_RW(mode, fru);
> +		fru_ctx->dev_attr[ECS_RESET] = EDAC_ECS_ATTR_WO(reset, fru);
> +		fru_ctx->dev_attr[ECS_THRESHOLD] =
> +					EDAC_ECS_ATTR_RW(threshold, fru);
> +
> +		for (i = 0; i < ECS_MAX_ATTRS; i++)
> +			fru_ctx->ecs_attrs[i] = &fru_ctx->dev_attr[i].dev_attr.attr;
> +
> +		sprintf(fru_ctx->name, "%s%d", EDAC_ECS_FRU_NAME, fru);
> +		group->name = fru_ctx->name;
> +		group->attrs = fru_ctx->ecs_attrs;
> +		group->is_visible  = ecs_attr_visible;
> +
> +		attr_groups[fru] = group;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * edac_ecs_get_desc - get EDAC ECS descriptors
> + * @ecs_dev: client device, supports ECS feature
> + * @attr_groups: pointer to attribute group container
> + * @num_media_frus: number of media FRUs in the device
> + *
> + * Return:
> + *  * %0	- Success.
> + *  * %-EINVAL	- Invalid parameters passed.
> + *  * %-ENOMEM	- Dynamic memory allocation failed.
> + */
> +int edac_ecs_get_desc(struct device *ecs_dev,
> +		      const struct attribute_group **attr_groups, u16 num_media_frus)
> +{
> +	if (!ecs_dev || !attr_groups || !num_media_frus)
> +		return -EINVAL;
> +
> +	return ecs_create_desc(ecs_dev, attr_groups, num_media_frus);
> +}
> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
> index 40407f0ee600..a8421dc9ab3c 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -627,6 +627,9 @@ int edac_dev_register(struct device *parent, char *name,
>  			attr_gcnt++;
>  			scrub_cnt++;
>  			break;
> +		case RAS_FEAT_ECS:
> +			attr_gcnt += ras_features[feat].ecs_info.num_media_frus;
> +			break;
>  		default:
>  			return -EINVAL;
>  		}
> @@ -671,6 +674,20 @@ int edac_dev_register(struct device *parent, char *name,
>  			scrub_cnt++;
>  			attr_gcnt++;
>  			break;
> +		case RAS_FEAT_ECS:
> +			if (!ras_features->ecs_ops)
> +				goto data_mem_free;
> +
> +			dev_data = &ctx->ecs;
> +			dev_data->ecs_ops = ras_features->ecs_ops;
> +			dev_data->private = ras_features->ctx;
> +			ret = edac_ecs_get_desc(parent, &ras_attr_groups[attr_gcnt],
> +						ras_features->ecs_info.num_media_frus);
> +			if (ret)
> +				goto data_mem_free;
> +
> +			attr_gcnt += ras_features->ecs_info.num_media_frus;
> +			break;
>  		default:
>  			ret = -EINVAL;
>  			goto data_mem_free;
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index 1cbab08720df..f8346014c14e 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -667,6 +667,7 @@ static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
>  /* RAS feature type */
>  enum edac_dev_feat {
>  	RAS_FEAT_SCRUB,
> +	RAS_FEAT_ECS,
>  	RAS_FEAT_MAX
>  };
>  
> @@ -707,9 +708,47 @@ static inline int edac_scrub_get_desc(struct device *scrub_dev,
>  { return -EOPNOTSUPP; }
>  #endif /* CONFIG_EDAC_SCRUB */
>  
> +/**
> + * struct edac_ecs_ops - ECS device operations (all elements optional)
> + * @get_log_entry_type: read the log entry type value.
> + * @set_log_entry_type: set the log entry type value.
> + * @get_mode: read the mode value.
> + * @set_mode: set the mode value.
> + * @reset: reset the ECS counter.
> + * @get_threshold: read the threshold count per gigabits of memory cells.
> + * @set_threshold: set the threshold count per gigabits of memory cells.
> + */
> +struct edac_ecs_ops {
> +	int (*get_log_entry_type)(struct device *dev, void *drv_data, int fru_id, u32 *val);
> +	int (*set_log_entry_type)(struct device *dev, void *drv_data, int fru_id, u32 val);
> +	int (*get_mode)(struct device *dev, void *drv_data, int fru_id, u32 *val);
> +	int (*set_mode)(struct device *dev, void *drv_data, int fru_id, u32 val);
> +	int (*reset)(struct device *dev, void *drv_data, int fru_id, u32 val);
> +	int (*get_threshold)(struct device *dev, void *drv_data, int fru_id, u32 *threshold);
> +	int (*set_threshold)(struct device *dev, void *drv_data, int fru_id, u32 threshold);
> +};
> +
> +struct edac_ecs_ex_info {
> +	u16 num_media_frus;
> +};
> +
> +#if IS_ENABLED(CONFIG_EDAC_ECS)
> +int edac_ecs_get_desc(struct device *ecs_dev,
> +		      const struct attribute_group **attr_groups,
> +		      u16 num_media_frus);
> +#else
> +static inline int edac_ecs_get_desc(struct device *ecs_dev,
> +				    const struct attribute_group **attr_groups,
> +				    u16 num_media_frus)
> +{ return -EOPNOTSUPP; }
> +#endif /* CONFIG_EDAC_ECS */
> +
>  /* EDAC device feature information structure */
>  struct edac_dev_data {
> -	const struct edac_scrub_ops *scrub_ops;
> +	union {
> +		const struct edac_scrub_ops *scrub_ops;
> +		const struct edac_ecs_ops *ecs_ops;
> +	};
>  	u8 instance;
>  	void *private;
>  };
> @@ -718,13 +757,18 @@ struct edac_dev_feat_ctx {
>  	struct device dev;
>  	void *private;
>  	struct edac_dev_data *scrub;
> +	struct edac_dev_data ecs;
>  };
>  
>  struct edac_dev_feature {
>  	enum edac_dev_feat ft_type;
>  	u8 instance;
> -	const struct edac_scrub_ops *scrub_ops;
> +	union {
> +		const struct edac_scrub_ops *scrub_ops;
> +		const struct edac_ecs_ops *ecs_ops;
> +	};
>  	void *ctx;
> +	struct edac_ecs_ex_info ecs_info;
>  };
>  
>  int edac_dev_register(struct device *parent, char *dev_name,
> -- 
> 2.43.0
> 

