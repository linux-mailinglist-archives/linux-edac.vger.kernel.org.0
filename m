Return-Path: <linux-edac+bounces-2062-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA3499D60A
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 20:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0FF1C22201
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 18:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584341C2337;
	Mon, 14 Oct 2024 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SULXXxd4"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0364785260;
	Mon, 14 Oct 2024 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728928952; cv=none; b=fUFsHSIPLLg0wFoXa+rb9KYHo8JkX3GXAvpItRVJG8cBtBmEu1fvkbqvRbyWHyFAkPyry2lAjuIZsxScNHwp6g4oDrjz+XOhrWPfOzCPceo14dIU4/GgRQGQeok1U8M/rOXOQePsHKt0lSPR4DpNT7ohT7s15BQT/WDfU+IzdmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728928952; c=relaxed/simple;
	bh=Vkw8TThOSP6sXDLMoTAwMXKGKY3t3Z7nbHTLBM6rrqU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5GAjUwZtfZ9XJcJ+vuXL7kz8njS1Ze68xEsLDmMJnD87kJVGYBa4sUjD23P8VujG44JbexX6vjlt7HHgx4aVd0TD8YQ3+mQbWVropO1s/tQMGQ876pLoGreWhTfvNY5SH/kNN90FgeSVjmvN2NWymisR5Hn0jCcoIyMpWxPjEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SULXXxd4; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e290200a560so3990131276.1;
        Mon, 14 Oct 2024 11:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728928949; x=1729533749; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tg9CLZVzEeossgAKhSQf4ph9K5ftY98Grcx+JnEzmcI=;
        b=SULXXxd4WyccusC0W5D02+RANxl1+sBIZvXEr+n8bTV8DZ45HDt5AFfhaObE3b6F4J
         54nQxLb9fHYAb8lsMzwKWIQPQGBNa3iRKxbUWZjw1KppA+y2k94cBMFBfixwgt4K8vbH
         3XlWSdIroZF6ewCcDrrAtVr9+ZfU8xOmYDp6h9rWAxIWnUqUwG/+qrrvl9R2MRKX37l/
         RweTnZaSrpCYxHmpiS/++DKxy267ncCJtt0JF1Ragzm1wAu1PqO2T0CCNO6UCCpEb4ZD
         RqSUOQllKmpYxWX2Z0YuTYHs24hiRjOk02Uch+bjCLQjOETyeLY2Q4xiSCr7LW2vnfGy
         9QTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728928949; x=1729533749;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tg9CLZVzEeossgAKhSQf4ph9K5ftY98Grcx+JnEzmcI=;
        b=TL3JLtX/6AIpCcDWzugMIVeYPJLjDPkblc5RV10cRTKWPbLs0CBN/ZN5er+YWqKg/w
         R8xFWsGwVpJzlbcq3TWP/ss1bFkq6xkHSva8jLbNW0ZWZxdlpsCv6ep5CfIC/01Sko4o
         h/Lh12T13X0WFQHFfpOsfyaFeYQa3r9jdg+PkPtr7S6tcwgRBINnxS8yRirpJTYC2xG2
         FjOw820zqFEekUQhUxO5HteqTq+fpjYmR1ht+ZAkb2pmhZgkiMrQRMKipKny97P7ap2R
         ka6pi/xPgrmcYhMqoCfZPVfg42ZC/qf21vCAywKs4E3Yod15yrl6UjY0raaKiMnUPLHw
         7fxw==
X-Forwarded-Encrypted: i=1; AJvYcCVSXF3fylZNdwf+ZBEmGsTdXYl7cMSxwnbi6QEttOCf3aLsBbzMnz5LzRFntvwLN9suAfJ5ZO/fyvB4@vger.kernel.org, AJvYcCX0XmTatLnfMRM9o+Nk9t2qtappYpwc+0gWy+8Yo/ye6M3RZOU9l7+jLb7/i3wh4OTo6hciZ0kVPdbrLq9U@vger.kernel.org, AJvYcCXwTtlNZC5oggAr9sglF5aQm1C1gNA8RLtLPVvMA7uRGiVwDotrv1FupwoYYNISehR8rX19En24IqQT@vger.kernel.org
X-Gm-Message-State: AOJu0YwmxrojZhcdnElkPMJvNiw+QKvz4peUnbwOfOdEZdd7Oe4INe2g
	lYtDJv/YFas6XA5s1L5tRWE0yS4vG0Iw7P2bNsDO8pit+IEWjBsL
X-Google-Smtp-Source: AGHT+IF0MB3/mjKE3AQk98Cnw53UEXOUWF+R0PviksovdTYZ+/A0ukS1hd+JSlCOl7J6ddxJ1x2otw==
X-Received: by 2002:a05:690c:6f88:b0:6e2:18b8:c01d with SMTP id 00721157ae682-6e36434c936mr74101767b3.22.1728928948677;
        Mon, 14 Oct 2024 11:02:28 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332c71433sm16149807b3.121.2024.10.14.11.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 11:02:28 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 14 Oct 2024 11:02:13 -0700
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
	duenwen@google.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v13 10/18] cxl/memfeature: Add CXL memory device patrol
 scrub control feature
Message-ID: <Zw1cpc5uSyn4_4Jf@fan>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
 <20241009124120.1124-11-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241009124120.1124-11-shiju.jose@huawei.com>

On Wed, Oct 09, 2024 at 01:41:11PM +0100, shiju.jose@huawei.com wrote:
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
> Register with EDAC device driver , which gets the scrub attr descriptors
> from EDAC scrub and exposes sysfs scrub control attributes to the
> userspace. For example CXL device based scrub control for the CXL mem0
> device is exposed in /sys/bus/edac/devices/cxl_mem0/scrubX/
> 
> Also add support for region based CXL memory patrol scrub control.
> CXL memory region may be interleaved across one or more CXL memory devices.
> For example region based scrub control for CXL region1 is exposed in
> /sys/bus/edac/devices/cxl_region1/scrubX/
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
> ---
Hi Shiju,

I hit issue when trying to compile the code with "CONFIG_CXL_RAS_FEAT=m".

------
drivers/cxl/core/memfeature.c:1472:5: error: redefinition of ‘cxl_mem_ras_features_init’
 1472 | int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/cxl/core/memfeature.c:16:
./drivers/cxl/cxlmem.h:951:19: note: previous definition of ‘cxl_mem_ras_features_init’ with type ‘int(struct cxl_memdev *, struct cxl_region *)’
  951 | static inline int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
      |                   ^~~~~~~~~~~~~~~~~~~~~~~~~
make[5]: *** [scripts/Makefile.build:244: drivers/cxl/core/memfeature.o] Error 1
------

When compiled as module, it seems the definition in cxlmem.h and
memfeature.c will cause redefinition issue.

Fan

>  Documentation/edac/edac-scrub.rst |  74 ++++++
>  drivers/cxl/Kconfig               |  18 ++
>  drivers/cxl/core/Makefile         |   1 +
>  drivers/cxl/core/memfeature.c     | 383 ++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c         |   6 +
>  drivers/cxl/cxlmem.h              |   7 +
>  drivers/cxl/mem.c                 |   4 +
>  7 files changed, 493 insertions(+)
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
> index 99b5c25be079..b717a152d2a5 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -145,4 +145,22 @@ config CXL_REGION_INVALIDATION_TEST
>  	  If unsure, or if this kernel is meant for production environments,
>  	  say N.
>  
> +config CXL_RAS_FEAT
> +	tristate "CXL: Memory RAS features"
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
> index 000000000000..84d6e887a4fa
> --- /dev/null
> +++ b/drivers/cxl/core/memfeature.c
> @@ -0,0 +1,383 @@
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
> +static int cxl_mem_ps_get_attrs(struct cxl_memdev_state *mds,
> +				struct cxl_memdev_ps_params *params)
> +{
> +	size_t rd_data_size = sizeof(struct cxl_memdev_ps_rd_attrs);
> +	size_t data_size;
> +	struct cxl_memdev_ps_rd_attrs *rd_attrs __free(kfree) =
> +						kmalloc(rd_data_size, GFP_KERNEL);
> +	if (!rd_attrs)
> +		return -ENOMEM;
> +
> +	data_size = cxl_get_feature(mds, cxl_patrol_scrub_uuid,
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
> +	struct cxl_memdev_state *mds;
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
> +			mds = to_cxl_memdev_state(cxlds);
> +			ret = cxl_mem_ps_get_attrs(mds, params);
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
> +	mds = to_cxl_memdev_state(cxlds);
> +
> +	return cxl_mem_ps_get_attrs(mds, params);
> +}
> +
> +static int cxl_mem_ps_set_attrs(struct device *dev, void *drv_data,
> +				struct cxl_memdev_state *mds,
> +				struct cxl_memdev_ps_params *params,
> +				enum cxl_scrub_param param_type)
> +{
> +	struct cxl_patrol_scrub_context *cxl_ps_ctx = drv_data;
> +	struct cxl_memdev_ps_wr_attrs wr_attrs;
> +	struct cxl_memdev_ps_params rd_params;
> +	int ret;
> +
> +	ret = cxl_mem_ps_get_attrs(mds, &rd_params);
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
> +				rd_params.min_scrub_cycle_hrs);
> +			return -EINVAL;
> +		}
> +		wr_attrs.scrub_cycle_hrs = FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
> +						      params->scrub_cycle_hrs);
> +		wr_attrs.scrub_flags = FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
> +						  rd_params.enable);
> +		break;
> +	}
> +
> +	ret = cxl_set_feature(mds, cxl_patrol_scrub_uuid,
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
> +	struct cxl_memdev_state *mds;
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
> +			mds = to_cxl_memdev_state(cxlds);
> +			ret = cxl_mem_ps_set_attrs(dev, drv_data, mds,
> +						   params, param_type);
> +			if (ret)
> +				return ret;
> +		}
> +	} else {
> +		cxlmd = cxl_ps_ctx->cxlmd;
> +		cxlds = cxlmd->cxlds;
> +		mds = to_cxl_memdev_state(cxlds);
> +
> +		return cxl_mem_ps_set_attrs(dev, drv_data, mds, params, param_type);
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
> +	.get_min_cycle = cxl_patrol_scrub_read_min_scrub_cycle,
> +	.get_max_cycle = cxl_patrol_scrub_read_max_scrub_cycle,
> +	.get_cycle_duration = cxl_patrol_scrub_read_scrub_cycle,
> +	.set_cycle_duration = cxl_patrol_scrub_write_scrub_cycle,
> +};
> +
> +int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region *cxlr)
> +{
> +	struct edac_dev_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
> +	struct cxl_dev_state *cxlds;
> +	struct cxl_memdev_state *mds;
> +	struct cxl_patrol_scrub_context *cxl_ps_ctx;
> +	struct cxl_feat_entry feat_entry;
> +	char cxl_dev_name[CXL_SCRUB_NAME_LEN];
> +	int rc, i, num_ras_features = 0;
> +	u8 scrub_inst = 0;
> +
> +	if (cxlr) {
> +		struct cxl_region_params *p = &cxlr->params;
> +
> +		for (i = p->interleave_ways - 1; i >= 0; i--) {
> +			struct cxl_endpoint_decoder *cxled = p->targets[i];
> +
> +			cxlmd = cxled_to_memdev(cxled);
> +			cxlds = cxlmd->cxlds;
> +			mds = to_cxl_memdev_state(cxlds);
> +			memset(&feat_entry, 0, sizeof(feat_entry));
> +			rc = cxl_get_supported_feature_entry(mds, &cxl_patrol_scrub_uuid,
> +							     &feat_entry);
> +			if (rc < 0)
> +				return rc;
> +			if (!(feat_entry.attr_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
> +				return -EOPNOTSUPP;
> +		}
> +	} else {
> +		cxlds = cxlmd->cxlds;
> +		mds = to_cxl_memdev_state(cxlds);
> +		rc = cxl_get_supported_feature_entry(mds, &cxl_patrol_scrub_uuid,
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
> +		.get_feat_size = feat_entry.get_feat_size,
> +		.set_feat_size = feat_entry.set_feat_size,
> +		.get_version = feat_entry.get_feat_ver,
> +		.set_version = feat_entry.set_feat_ver,
> +		.set_effects = feat_entry.set_effects,
> +		.instance = scrub_inst++,
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
> +	ras_features[num_ras_features].instance = cxl_ps_ctx->instance;
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
> index b778eef99ce0..e1156ea93fe7 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -931,6 +931,13 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
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

