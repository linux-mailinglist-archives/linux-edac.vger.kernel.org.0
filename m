Return-Path: <linux-edac+bounces-1939-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8018698AB3C
	for <lists+linux-edac@lfdr.de>; Mon, 30 Sep 2024 19:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7D3282569
	for <lists+linux-edac@lfdr.de>; Mon, 30 Sep 2024 17:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF74198E75;
	Mon, 30 Sep 2024 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="holeYOi5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAD418EAB;
	Mon, 30 Sep 2024 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727717921; cv=none; b=sOHfVSNncAcAH89JD9BULb4VVxvSj1l01pol4KgutalBvgDL/XldvfwmsXz94uAVHRzbSSuWBLHUBqXFJwW9cJJZf73RciOfouIH96EBoEdkNfhH+6vdBtu322Lcytamoco65nPIoNbBfx5ClCgk4erffYuhAywqrzrHAj7NLJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727717921; c=relaxed/simple;
	bh=5q8y6iUPYBGU/+6bjinRNEhVyTVk5wuC1M4xbDoXjRs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKtKgxRt4Dwt1snhDir5F4y3zdtKiHPmUFlXhP8NkKqESlVe2i3JIn9ZyBJM25qHe/9oE6Z/rj9MDlYu+W1sfHC7SzCMsxS2YAvYFk0RswGJzm9eCBDBOmJthLXdchE1pp1IcSffHtvrqH25eGyopkA6oBhzcunTUePXjUEjhFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=holeYOi5; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-710dead5d2aso2899778a34.0;
        Mon, 30 Sep 2024 10:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727717919; x=1728322719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c04ywpCTgF4KW+dmh2nwna0qx47f8hiBcydff2rjxM0=;
        b=holeYOi5vfmccPOpi1ZI6aOSWH/gd04+QVIqExc2ULQ55BLmbRGP3FufS2cvllRE3U
         jFofkyN90ezAjvyJ+KewHnCFRTHPdFbwYIvbaSAYn0VEPeF5VTBeZhuUWrQq5wimILhY
         b2w1NVOI5nnoeK6S4g/tifDS37Fhaw1lfC+af66xHTU1MHrhSXqQVChbSdz6N0H2Lg/1
         ZLETEgryuzfkE0ZgmWplJzR8tJxRwzIpkwafm0wntUFYCP5En4Qz/z7i7RfNIoPvO/GT
         G6XdB+O4LmPpeEwFoGh7C8JDfMpRFO8o2oMmVhwxGzowWNGvbrOlPFRsvxKCoP8MdRq2
         JU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727717919; x=1728322719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c04ywpCTgF4KW+dmh2nwna0qx47f8hiBcydff2rjxM0=;
        b=sUVMNPU85l6UAtj714Ec0tG/FHXqjchqmW65AP78gFYJQjsXRF3wDr7Ne1BCBNPDXa
         DbxUabeXrQtfN8mwXT+wRmUGasj7+eHHQ6zA1ptZiQoM5A2V7OjZjOnjTVTZe6UuKdlS
         hcnUkWuaHXVblaS7SqnYOL9LCABWvD0MrqbEIUXHqDCYxrTfcZwV2TS/WH/7ioalCnoH
         Jz0luXI/wUawSrrmvtSJrMSNaT7ItQdKqoB3U8QB+jReLKs0YViVdaCKOafcEDsWKoZS
         JpilQ/raDSAFyJSq3MfbhfU7DwwfJll7v91/iOEbvtZHCdKYv32rn1pzcIxJyhhxCjIh
         2iJw==
X-Forwarded-Encrypted: i=1; AJvYcCUXHALgJHBnJD97e+iqeRX8y2Mc7avJ7V4KB175eEBiLnCEvPF+Tt5DlBv98+Q6SW6cbUpzc6qDD0iE@vger.kernel.org, AJvYcCVPE2vI8QdP0CTgdD5Qab8Y38bj/DtswS3M8qbsppTNNoTUcoVkQ1MnSOBQjRkawfoBjP4aHU8B4Iyj@vger.kernel.org, AJvYcCXj9TbkEcTS0ixJq2G+motKNSgIohCaoGPMrrTZg/wlluYcOKnGsfQkJSdIlp+p+MaMchOBVAKfxaC4S6UV@vger.kernel.org
X-Gm-Message-State: AOJu0YzPcXzcQmb47Wj8NQDL7pRNOJRL/IXAYhCWAPVpRcFJXI281CkA
	XS6znxmB2R47faUTUi9qaxlJeaRD6GMtkUlkREMdggHxhs2Jjllo
X-Google-Smtp-Source: AGHT+IFVNvqPiGunQ2EFT6tSTlwA6eGgxbFa17yU7FvNB0Omw8fpqzQKh9fIVhiBjoswdUZsqKwfag==
X-Received: by 2002:a05:6830:a91:b0:709:4266:988f with SMTP id 46e09a7af769-714fbeff9eemr9423661a34.25.1727717918645;
        Mon, 30 Sep 2024 10:38:38 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e24538af4fsm14849007b3.122.2024.09.30.10.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:38:38 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 30 Sep 2024 10:38:33 -0700
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
Subject: Re: [PATCH v12 10/17] cxl/memfeature: Add CXL memory device patrol
 scrub control feature
Message-ID: <ZvriGULQdwlm9r5P@fan>
References: <20240911090447.751-1-shiju.jose@huawei.com>
 <20240911090447.751-11-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911090447.751-11-shiju.jose@huawei.com>

On Wed, Sep 11, 2024 at 10:04:39AM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
> feature. The device patrol scrub proactively locates and makes corrections
> to errors in regular cycle.
> 
> Allow specifying the number of hours within which the patrol scrub must be
> completed, subject to minimum and maximum limits reported by the device.
> Also allow disabling scrub allowing trade-off error rates against
> performance.
> 
> Add support for CXL memory device based patrol scrub control.
> Register with EDAC RAS control feature driver, which gets the scrub attr
> descriptors from the EDAC scrub and expose sysfs scrub control attributes
> to the userspace.
> For example CXL device based scrub control for the CXL mem0 device is
> exposed in /sys/bus/edac/devices/cxl_mem0/scrub*/
> 
> Also add support for region based CXL memory patrol scrub control.
> CXL memory region may be interleaved across one or more CXL memory devices.
> For example region based scrub control for CXL region1 is exposed in
> /sys/bus/edac/devices/cxl_region1/scrub*/
> 
> Open Questions:
> Q1: CXL 3.1 spec defined patrol scrub control feature at CXL memory devices
> with supporting set scrub cycle and enable/disable scrub. but not based on
> HPA range. Thus presently scrub control for a region is implemented based
> on all associated CXL memory devices.
> What is the exact use case for the CXL region based scrub control?
> How the HPA range, which Dan asked for region based scrubbing is used?
> Does spec change is required for patrol scrub control feature with support
> for setting the HPA range?
> 
> Q2: Both CXL device based and CXL region based scrub control would be
> enabled at the same time in a system?
> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Hi Shiju,

When trying the following ops with this patchset, I acctually noticed
something unexpected.

---------------------------------
root@localhost:~# dmesg -C
root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/min_cycle_duration
3600
root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/max_cycle_duration
918000
root@localhost:~# echo 3200 > /sys/bus/edac/devices/cxl_mem0/scrub0/current_cycle_duration
-bash: echo: write error: Invalid argument
root@localhost:~# dmesg
[ 4950.038767] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0501
[ 4950.038952] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
[ 4972.487087] cxl_pci:__cxl_pci_mbox_send_cmd:263: cxl_pci 0000:0d:00.0: Sending command: 0x0501
[ 4972.487339] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
[ 4972.487509] cxl_mem mem0: Invalid CXL patrol scrub cycle(0) to set
[ 4972.488287] cxl_mem mem0: Minimum supported CXL patrol scrub cycle in hour 0
-----------------------

If you check the last line of the dmesg output, it seems we did not
print out the minimum scrub cycle duration correctly.

Fan


> ---
>  Documentation/edac/edac-scrub.rst |  74 ++++++
>  drivers/cxl/Kconfig               |  18 ++
>  drivers/cxl/core/Makefile         |   1 +
>  drivers/cxl/core/memfeature.c     | 372 ++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c         |   6 +
>  drivers/cxl/cxlmem.h              |   7 +
>  drivers/cxl/mem.c                 |   4 +
>  7 files changed, 482 insertions(+)
>  create mode 100644 Documentation/edac/edac-scrub.rst
>  create mode 100644 drivers/cxl/core/memfeature.c
> 
> diff --git a/Documentation/edac/edac-scrub.rst b/Documentation/edac/edac-scrub.rst
> new file mode 100644
> index 000000000000..243035957e99
> --- /dev/null
> +++ b/Documentation/edac/edac-scrub.rst
> @@ -0,0 +1,74 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===================
> +EDAC Scrub control
> +===================
> +
> +Copyright (c) 2024 HiSilicon Limited.
> +
> +:Author:   Shiju Jose <shiju.jose@huawei.com>
> +:License:  The GNU Free Documentation License, Version 1.2
> +          (dual licensed under the GPL v2)
> +:Original Reviewers:
> +
> +- Written for: 6.12
> +- Updated for:
> +
> +Introduction
> +------------
> +The EDAC enhancement for RAS featurues exposes interfaces for controlling
> +the memory scrubbers in the system. The scrub device drivers in the
> +system register with the EDAC scrub. The driver exposes the
> +scrub controls to user in the sysfs.
> +
> +The File System
> +---------------
> +
> +The control attributes of the registered scrubber instance could be
> +accessed in the /sys/bus/edac/devices/<dev-name>/scrub*/
> +
> +sysfs
> +-----
> +
> +Sysfs files are documented in
> +`Documentation/ABI/testing/sysfs-edac-scrub-control`.
> +
> +Example
> +-------
> +
> +The usage takes the form shown in this example::
> +
> +1. CXL memory device patrol scrubber
> +1.1 device based
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/min_cycle_duration
> +3600
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/max_cycle_duration
> +918000
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/current_cycle_duration
> +43200
> +root@localhost:~# echo 54000 > /sys/bus/edac/devices/cxl_mem0/scrub0/current_cycle_duration
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/current_cycle_duration
> +54000
> +root@localhost:~# echo 1 > /sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
> +1
> +root@localhost:~# echo 0 > /sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
> +0
> +
> +1.2. region based
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/min_cycle_duration
> +3600
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/max_cycle_duration
> +918000
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/current_cycle_duration
> +43200
> +root@localhost:~# echo 54000 > /sys/bus/edac/devices/cxl_region0/scrub0/current_cycle_duration
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/current_cycle_duration
> +54000
> +root@localhost:~# echo 1 > /sys/bus/edac/devices/cxl_region0/scrub0/enable_background
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/enable_background
> +1
> +root@localhost:~# echo 0 > /sys/bus/edac/devices/cxl_region0/scrub0/enable_background
> +root@localhost:~# cat /sys/bus/edac/devices/cxl_region0/scrub0/enable_background
> +0
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 99b5c25be079..394bdbc4de87 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -145,4 +145,22 @@ config CXL_REGION_INVALIDATION_TEST
>  	  If unsure, or if this kernel is meant for production environments,
>  	  say N.
>  
> +config CXL_RAS_FEAT
> +	bool "CXL: Memory RAS features"
> +	depends on CXL_PCI
> +	depends on CXL_MEM
> +	depends on EDAC
> +	help
> +	  The CXL memory RAS feature control is optional allows host to control
> +	  the RAS features configurations of CXL Type 3 devices.
> +
> +	  Registers with the EDAC device subsystem to expose control attributes
> +	  of CXL memory device's RAS features to the user.
> +	  Provides interface functions to support configuring the CXL memory
> +	  device's RAS features.
> +
> +	  Say 'y/n' to enable/disable CXL.mem device'ss RAS features control.
> +	  See section 8.2.9.9.11 of CXL 3.1 specification for the detailed
> +	  information of CXL memory device features.
> +
>  endif
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 9259bcc6773c..2a3c7197bc23 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -16,3 +16,4 @@ cxl_core-y += pmu.o
>  cxl_core-y += cdat.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> +cxl_core-$(CONFIG_CXL_RAS_FEAT) += memfeature.o
> diff --git a/drivers/cxl/core/memfeature.c b/drivers/cxl/core/memfeature.c
> new file mode 100644
> index 000000000000..90c68d20b02b
> --- /dev/null
> +++ b/drivers/cxl/core/memfeature.c
> @@ -0,0 +1,372 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * CXL memory RAS feature driver.
> + *
> + * Copyright (c) 2024 HiSilicon Limited.
> + *
> + *  - Supports functions to configure RAS features of the
> + *    CXL memory devices.
> + *  - Registers with the EDAC device subsystem driver to expose
> + *    the features sysfs attributes to the user for configuring
> + *    CXL memory RAS feature.
> + */
> +
> +#define pr_fmt(fmt)	"CXL MEM FEAT: " fmt
> +
> +#include <cxlmem.h>
> +#include <linux/cleanup.h>
> +#include <linux/limits.h>
> +#include <cxl.h>
> +#include <linux/edac.h>
> +
> +#define CXL_DEV_NUM_RAS_FEATURES	1
> +#define CXL_DEV_HOUR_IN_SECS	3600
> +
> +#define CXL_SCRUB_NAME_LEN	128
> +
> +/* CXL memory patrol scrub control definitions */
> +static const uuid_t cxl_patrol_scrub_uuid =
> +	UUID_INIT(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33, 0x75, 0x77, 0x4e,     \
> +		  0x06, 0xdb, 0x8a);
> +
> +/* CXL memory patrol scrub control functions */
> +struct cxl_patrol_scrub_context {
> +	u8 instance;
> +	u16 get_feat_size;
> +	u16 set_feat_size;
> +	u8 get_version;
> +	u8 set_version;
> +	u16 set_effects;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_region *cxlr;
> +};
> +
> +/**
> + * struct cxl_memdev_ps_params - CXL memory patrol scrub parameter data structure.
> + * @enable:     [IN & OUT] enable(1)/disable(0) patrol scrub.
> + * @scrub_cycle_changeable: [OUT] scrub cycle attribute of patrol scrub is changeable.
> + * @scrub_cycle_hrs:    [IN] Requested patrol scrub cycle in hours.
> + *                      [OUT] Current patrol scrub cycle in hours.
> + * @min_scrub_cycle_hrs:[OUT] minimum patrol scrub cycle in hours supported.
> + */
> +struct cxl_memdev_ps_params {
> +	bool enable;
> +	bool scrub_cycle_changeable;
> +	u16 scrub_cycle_hrs;
> +	u16 min_scrub_cycle_hrs;
> +};
> +
> +enum cxl_scrub_param {
> +	CXL_PS_PARAM_ENABLE,
> +	CXL_PS_PARAM_SCRUB_CYCLE,
> +};
> +
> +#define	CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK	BIT(0)
> +#define	CXL_MEMDEV_PS_SCRUB_CYCLE_REALTIME_REPORT_CAP_MASK	BIT(1)
> +#define	CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK	GENMASK(7, 0)
> +#define	CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK	GENMASK(15, 8)
> +#define	CXL_MEMDEV_PS_FLAG_ENABLED_MASK	BIT(0)
> +
> +struct cxl_memdev_ps_rd_attrs {
> +	u8 scrub_cycle_cap;
> +	__le16 scrub_cycle_hrs;
> +	u8 scrub_flags;
> +}  __packed;
> +
> +struct cxl_memdev_ps_wr_attrs {
> +	u8 scrub_cycle_hrs;
> +	u8 scrub_flags;
> +}  __packed;
> +
> +static int cxl_mem_ps_get_attrs(struct cxl_dev_state *cxlds,
> +				struct cxl_memdev_ps_params *params)
> +{
> +	size_t rd_data_size = sizeof(struct cxl_memdev_ps_rd_attrs);
> +	size_t data_size;
> +	struct cxl_memdev_ps_rd_attrs *rd_attrs __free(kfree) =
> +						kmalloc(rd_data_size, GFP_KERNEL);
> +	if (!rd_attrs)
> +		return -ENOMEM;
> +
> +	data_size = cxl_get_feature(cxlds, cxl_patrol_scrub_uuid,
> +				    CXL_GET_FEAT_SEL_CURRENT_VALUE,
> +				    rd_attrs, rd_data_size);
> +	if (!data_size)
> +		return -EIO;
> +
> +	params->scrub_cycle_changeable = FIELD_GET(CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK,
> +						   rd_attrs->scrub_cycle_cap);
> +	params->enable = FIELD_GET(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
> +				   rd_attrs->scrub_flags);
> +	params->scrub_cycle_hrs = FIELD_GET(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
> +					    rd_attrs->scrub_cycle_hrs);
> +	params->min_scrub_cycle_hrs = FIELD_GET(CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK,
> +						rd_attrs->scrub_cycle_hrs);
> +
> +	return 0;
> +}
> +
> +static int cxl_ps_get_attrs(struct device *dev, void *drv_data,
> +			    struct cxl_memdev_ps_params *params)
> +{
> +	struct cxl_patrol_scrub_context *cxl_ps_ctx = drv_data;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_dev_state *cxlds;
> +	u16 min_scrub_cycle = 0;
> +	int i, ret;
> +
> +	if (cxl_ps_ctx->cxlr) {
> +		struct cxl_region *cxlr = cxl_ps_ctx->cxlr;
> +		struct cxl_region_params *p = &cxlr->params;
> +
> +		for (i = p->interleave_ways - 1; i >= 0; i--) {
> +			struct cxl_endpoint_decoder *cxled = p->targets[i];
> +
> +			cxlmd = cxled_to_memdev(cxled);
> +			cxlds = cxlmd->cxlds;
> +			ret = cxl_mem_ps_get_attrs(cxlds, params);
> +			if (ret)
> +				return ret;
> +
> +			if (params->min_scrub_cycle_hrs > min_scrub_cycle)
> +				min_scrub_cycle = params->min_scrub_cycle_hrs;
> +		}
> +		params->min_scrub_cycle_hrs = min_scrub_cycle;
> +		return 0;
> +	}
> +	cxlmd = cxl_ps_ctx->cxlmd;
> +	cxlds = cxlmd->cxlds;
> +
> +	return cxl_mem_ps_get_attrs(cxlds, params);
> +}
> +
> +static int cxl_mem_ps_set_attrs(struct device *dev, void *drv_data,
> +				struct cxl_dev_state *cxlds,
> +				struct cxl_memdev_ps_params *params,
> +				enum cxl_scrub_param param_type)
> +{
> +	struct cxl_patrol_scrub_context *cxl_ps_ctx = drv_data;
> +	struct cxl_memdev_ps_wr_attrs wr_attrs;
> +	struct cxl_memdev_ps_params rd_params;
> +	int ret;
> +
> +	ret = cxl_mem_ps_get_attrs(cxlds, &rd_params);
> +	if (ret) {
> +		dev_err(dev, "Get cxlmemdev patrol scrub params failed ret=%d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	switch (param_type) {
> +	case CXL_PS_PARAM_ENABLE:
> +		wr_attrs.scrub_flags = FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
> +						  params->enable);
> +		wr_attrs.scrub_cycle_hrs = FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
> +						      rd_params.scrub_cycle_hrs);
> +		break;
> +	case CXL_PS_PARAM_SCRUB_CYCLE:
> +		if (params->scrub_cycle_hrs < rd_params.min_scrub_cycle_hrs) {
> +			dev_err(dev, "Invalid CXL patrol scrub cycle(%d) to set\n",
> +				params->scrub_cycle_hrs);
> +			dev_err(dev, "Minimum supported CXL patrol scrub cycle in hour %d\n",
> +				params->min_scrub_cycle_hrs);
> +			return -EINVAL;
> +		}
> +		wr_attrs.scrub_cycle_hrs = FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
> +						      params->scrub_cycle_hrs);
> +		wr_attrs.scrub_flags = FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
> +						  rd_params.enable);
> +		break;
> +	}
> +
> +	ret = cxl_set_feature(cxlds, cxl_patrol_scrub_uuid,
> +			      cxl_ps_ctx->set_version,
> +			      &wr_attrs, sizeof(wr_attrs),
> +			      CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET);
> +	if (ret) {
> +		dev_err(dev, "CXL patrol scrub set feature failed ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_ps_set_attrs(struct device *dev, void *drv_data,
> +			    struct cxl_memdev_ps_params *params,
> +			    enum cxl_scrub_param param_type)
> +{
> +	struct cxl_patrol_scrub_context *cxl_ps_ctx = drv_data;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_dev_state *cxlds;
> +	int ret, i;
> +
> +	if (cxl_ps_ctx->cxlr) {
> +		struct cxl_region *cxlr = cxl_ps_ctx->cxlr;
> +		struct cxl_region_params *p = &cxlr->params;
> +
> +		for (i = p->interleave_ways - 1; i >= 0; i--) {
> +			struct cxl_endpoint_decoder *cxled = p->targets[i];
> +
> +			cxlmd = cxled_to_memdev(cxled);
> +			cxlds = cxlmd->cxlds;
> +			ret = cxl_mem_ps_set_attrs(dev, drv_data, cxlds,
> +						   params, param_type);
> +			if (ret)
> +				return ret;
> +		}
> +	} else {
> +		cxlmd = cxl_ps_ctx->cxlmd;
> +		cxlds = cxlmd->cxlds;
> +
> +		return cxl_mem_ps_set_attrs(dev, drv_data, cxlds, params, param_type);
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_patrol_scrub_get_enabled_bg(struct device *dev, void *drv_data, bool *enabled)
> +{
> +	struct cxl_memdev_ps_params params;
> +	int ret;
> +
> +	ret = cxl_ps_get_attrs(dev, drv_data, &params);
> +	if (ret)
> +		return ret;
> +
> +	*enabled = params.enable;
> +
> +	return 0;
> +}
> +
> +static int cxl_patrol_scrub_set_enabled_bg(struct device *dev, void *drv_data, bool enable)
> +{
> +	struct cxl_memdev_ps_params params = {
> +		.enable = enable,
> +	};
> +
> +	return cxl_ps_set_attrs(dev, drv_data, &params, CXL_PS_PARAM_ENABLE);
> +}
> +
> +static int cxl_patrol_scrub_read_min_scrub_cycle(struct device *dev, void *drv_data,
> +						 u32 *min)
> +{
> +	struct cxl_memdev_ps_params params;
> +	int ret;
> +
> +	ret = cxl_ps_get_attrs(dev, drv_data, &params);
> +	if (ret)
> +		return ret;
> +	*min = params.min_scrub_cycle_hrs * CXL_DEV_HOUR_IN_SECS;
> +
> +	return 0;
> +}
> +
> +static int cxl_patrol_scrub_read_max_scrub_cycle(struct device *dev, void *drv_data,
> +						 u32 *max)
> +{
> +	*max = U8_MAX * CXL_DEV_HOUR_IN_SECS; /* Max set by register size */
> +
> +	return 0;
> +}
> +
> +static int cxl_patrol_scrub_read_scrub_cycle(struct device *dev, void *drv_data,
> +					     u32 *scrub_cycle_secs)
> +{
> +	struct cxl_memdev_ps_params params;
> +	int ret;
> +
> +	ret = cxl_ps_get_attrs(dev, drv_data, &params);
> +	if (ret)
> +		return ret;
> +
> +	*scrub_cycle_secs = params.scrub_cycle_hrs * CXL_DEV_HOUR_IN_SECS;
> +
> +	return 0;
> +}
> +
> +static int cxl_patrol_scrub_write_scrub_cycle(struct device *dev, void *drv_data,
> +					      u32 scrub_cycle_secs)
> +{
> +	struct cxl_memdev_ps_params params = {
> +		.scrub_cycle_hrs = scrub_cycle_secs / CXL_DEV_HOUR_IN_SECS,
> +	};
> +
> +	return cxl_ps_set_attrs(dev, drv_data, &params, CXL_PS_PARAM_SCRUB_CYCLE);
> +}
> +
> +static const struct edac_scrub_ops cxl_ps_scrub_ops = {
> +	.get_enabled_bg = cxl_patrol_scrub_get_enabled_bg,
> +	.set_enabled_bg = cxl_patrol_scrub_set_enabled_bg,
> +	.min_cycle_read = cxl_patrol_scrub_read_min_scrub_cycle,
> +	.max_cycle_read = cxl_patrol_scrub_read_max_scrub_cycle,
> +	.cycle_duration_read = cxl_patrol_scrub_read_scrub_cycle,
> +	.cycle_duration_write = cxl_patrol_scrub_write_scrub_cycle,
> +};
> +
> +int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
> +{
> +	struct edac_dev_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
> +	struct cxl_dev_state *cxlds;
> +	struct cxl_patrol_scrub_context *cxl_ps_ctx;
> +	struct cxl_feat_entry feat_entry;
> +	char cxl_dev_name[CXL_SCRUB_NAME_LEN];
> +	int rc, i, num_ras_features = 0;
> +
> +	if (cxlr) {
> +		struct cxl_region_params *p = &cxlr->params;
> +
> +		for (i = p->interleave_ways - 1; i >= 0; i--) {
> +			struct cxl_endpoint_decoder *cxled = p->targets[i];
> +
> +			cxlmd = cxled_to_memdev(cxled);
> +			cxlds = cxlmd->cxlds;
> +			memset(&feat_entry, 0, sizeof(feat_entry));
> +			rc = cxl_get_supported_feature_entry(cxlds, &cxl_patrol_scrub_uuid,
> +							     &feat_entry);
> +			if (rc < 0)
> +				return rc;
> +			if (!(feat_entry.attr_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
> +				return -EOPNOTSUPP;
> +		}
> +	} else {
> +		cxlds = cxlmd->cxlds;
> +		rc = cxl_get_supported_feature_entry(cxlds, &cxl_patrol_scrub_uuid,
> +						     &feat_entry);
> +		if (rc < 0)
> +			return rc;
> +
> +		if (!(feat_entry.attr_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
> +			return -EOPNOTSUPP;
> +	}
> +
> +	cxl_ps_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ps_ctx), GFP_KERNEL);
> +	if (!cxl_ps_ctx)
> +		return -ENOMEM;
> +
> +	*cxl_ps_ctx = (struct cxl_patrol_scrub_context) {
> +		.instance = cxl_ps_ctx->instance,
> +		.get_feat_size = feat_entry.get_feat_size,
> +		.set_feat_size = feat_entry.set_feat_size,
> +		.get_version = feat_entry.get_feat_ver,
> +		.set_version = feat_entry.set_feat_ver,
> +		.set_effects = feat_entry.set_effects,
> +	};
> +	if (cxlr) {
> +		snprintf(cxl_dev_name, sizeof(cxl_dev_name),
> +			 "cxl_region%d", cxlr->id);
> +		cxl_ps_ctx->cxlr = cxlr;
> +	} else {
> +		snprintf(cxl_dev_name, sizeof(cxl_dev_name),
> +			 "%s_%s", "cxl", dev_name(&cxlmd->dev));
> +		cxl_ps_ctx->cxlmd = cxlmd;
> +	}
> +
> +	ras_features[num_ras_features].ft_type = RAS_FEAT_SCRUB;
> +	ras_features[num_ras_features].scrub_ops = &cxl_ps_scrub_ops;
> +	ras_features[num_ras_features].ctx = cxl_ps_ctx;
> +	num_ras_features++;
> +
> +	return edac_dev_register(&cxlmd->dev, cxl_dev_name, NULL,
> +				 num_ras_features, ras_features);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_ras_features_init, CXL);
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 21ad5f242875..1cc29ec9ffac 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3434,6 +3434,12 @@ static int cxl_region_probe(struct device *dev)
>  					p->res->start, p->res->end, cxlr,
>  					is_system_ram) > 0)
>  			return 0;
> +
> +		rc = cxl_mem_ras_features_init(NULL, cxlr);
> +		if (rc)
> +			dev_warn(&cxlr->dev, "CXL RAS features init for region_id=%d failed\n",
> +				 cxlr->id);
> +
>  		return devm_cxl_add_dax_region(cxlr);
>  	default:
>  		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index b565a061a4e3..2187c3378eaa 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -889,6 +889,13 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
>  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  
> +#ifdef CONFIG_CXL_RAS_FEAT
> +int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr);
> +#else
> +static inline int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
> +{ return 0; }
> +#endif
> +
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 7de232eaeb17..be2e69548909 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -117,6 +117,10 @@ static int cxl_mem_probe(struct device *dev)
>  	if (!cxlds->media_ready)
>  		return -EBUSY;
>  
> +	rc = cxl_mem_ras_features_init(cxlmd, NULL);
> +	if (rc)
> +		dev_warn(&cxlmd->dev, "CXL RAS features init failed\n");
> +
>  	/*
>  	 * Someone is trying to reattach this device after it lost its port
>  	 * connection (an endpoint port previously registered by this memdev was
> -- 
> 2.34.1
> 

-- 
Fan Ni

