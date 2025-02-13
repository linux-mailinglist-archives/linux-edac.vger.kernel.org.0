Return-Path: <linux-edac+bounces-3077-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC434A35021
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 22:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677133AB828
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 21:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801662661A9;
	Thu, 13 Feb 2025 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVC41UkU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07F8250EC;
	Thu, 13 Feb 2025 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480780; cv=none; b=PQiVlFbW3exGkLSQVFt+iAlBvt5ZtSBohLWPu1yZH7r6J8UPWEVFpKZFa2aJvwGLjSwAAFz+zcD9ms9zT6ojyorjnHnWjIHEariGx066YH6CA9XVIGTXJB8vuTMQClrxqtbSWxp3pBDUS6wTlT0LDtGSl4K89uDEeOXSKTxBCIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480780; c=relaxed/simple;
	bh=MpmjcTrQDvEPm4rW4W/L5mzP4uBnKkBPc1FXep3gkLE=;
	h=Message-ID:From:Date:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0NxdI08JwAyV3vJQx0pOyfgyudQBon+6AwaVtXv/ko798hN7WU6wmbjvBlftfKlGy6elVI8s3d2vFGPIQDeP9abLzcDn/S1nmpE2B7XqnSZd740pd5+ukGVI19vR2spEh39l2IWCDQAfTZ8mG+0znGL67JmyZ6AbbtPX34Ibuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVC41UkU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f48ebaadfso27442505ad.2;
        Thu, 13 Feb 2025 13:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739480778; x=1740085578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zj6IyoMI7/+XesEjkVAnf4BmLCrNLF66imYiCl83NlM=;
        b=RVC41UkUranJJx7F1Rir0fUxvqtylY2g+/7aC3M7PYe544kuAHUEkOS69ujc2/XYY4
         E82KI3GXgymcJzOsGBvbneWa82tT7vAkkklXy4bElwgRgkXw4VOZJz466iQZX1CcrCIH
         bNKUkBOStzenzgwQzXEU7jqjRrhpaidPOyOyypMw3c7k/vGrYw/n+zt15jJAWv8Lb38L
         1gALAm63lzmN2RtMjDbzCgtHZz3ExD/125FZm7mo25EqqmyfyKl9gl1sxEbg0hkwk+S/
         QRMGY5mjla5cj3zGZrBFRk4Dx/2XKuS92MvDLrCKc1ErQIfQdFC69IGGiLp9a6gfKHCy
         oMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739480778; x=1740085578;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zj6IyoMI7/+XesEjkVAnf4BmLCrNLF66imYiCl83NlM=;
        b=B+Gh3AxqVkrwgZJd/PnFcQP+z8Wl7CB4IGEgnoac959iWQ5By1wxj0lulN/jN2p1oP
         TuxaclGIus3Fw3OP9d37E0G8nZf4fCZ6moGlo0onlgaiYoogZyKLvG/RBZqAzpB83MEF
         52aiaZJn18EF4Rw2kAoWgI3f+EVcLE7MBmMd1CEFEPJCnoZnpFyhkZKUEKAyrdi54Ifq
         8sm8UFJhUpOkfQ6tZKwDQbL8hTwNebKJcqXHgsE00AsGFm2WFEsju+NaFVPT0PF82gcf
         D3tV75TZN3A5Mb7CO/8yySHVt8XasNc1JD/Cl4LSJJ2+aagrDGXc77k5PLkDRq5tG+rw
         lX7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2t0ah6eU6jr0Wk53CU2y8siLNk6KJIajr4lztA60s2D4+hmC2duWNjTDA5eX0NIUOVk8+YWMS/DhR@vger.kernel.org, AJvYcCWgAWSIRitrEpVis1MMOBQ2KiDNfJ5l5GGMJ50LKk6S/OJn6lImgfYIeTy/yqy6NVs4b7W6BR0JkSyiNkbl@vger.kernel.org, AJvYcCXMIPOofav8TeROSW0g0S6ZaVpTxKcF9QzJe6Z78MCpj+rKHVZOTNWevJsuZjb5bPLzNdvaWA9+lQed@vger.kernel.org, AJvYcCXQymXRoqkXhkGVW10kq2Pc2Tv6Ko+5mH+cV5Bqy2KIpIlxBjOgLJ+Ff8z2Wo+caApk78RYVR5PKtSK@vger.kernel.org
X-Gm-Message-State: AOJu0YxFxwXqh7izWUdYrCmECu9b55P9kUwV3+BmEVMxsXxzzMeTVolJ
	OH1ha6plvqevg5I3ktd08VofWZb4wjaLG8QymEQtAcTVWreC4DLp
X-Gm-Gg: ASbGncvYjqReOJesuc0BHe/Sh741xZkLdCMp+8pI4Zu3QpZfvm4Mvuklc9zYc1bAhao
	6kXmj/d71a27fmP+c36F2teCafH0+66Du1z9zDRTvus0RlWA/dLADfvvkkzt2EYEfHK6BJ9vVf2
	3llH6tTrPVxhjLBR8mAZLnZNBg1OOJ4ZychApLWt5/4AU5jGSoUR55d4l0OOI3EsrPYGAmLC042
	/XkczOcsgKlHuo+CQO6hEyBkPQLp1BLtJFhPhpB+Jkk2bWRFVg9VBsTOKWAxqgZ/MPMKIf/EK8I
	vpiyKcvI3anHTIpgOppq7qCtPHpWeR/Z0nIbY0HAl5s=
X-Google-Smtp-Source: AGHT+IEZh5CGS1QOxvKwoON2sPBaz7fHaxqQbJ1CRIi7eBl37m2+GOBij6F/G7vXVQz7wwd2GS5O/w==
X-Received: by 2002:a05:6a00:178d:b0:725:cfa3:bc6b with SMTP id d2e1a72fcca58-7322c3754admr15708096b3a.3.1739480777593;
        Thu, 13 Feb 2025 13:06:17 -0800 (PST)
Received: from asus. (c-73-189-148-61.hsd1.ca.comcast.net. [73.189.148.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546177sm1730934b3a.5.2025.02.13.13.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 13:06:17 -0800 (PST)
Message-ID: <67ae5ec9.a70a0220.15bb91.94a5@mx.google.com>
X-Google-Original-Message-ID: <Z65evEPv8nVQWPLl@asus.>
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 13 Feb 2025 13:06:04 -0800
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
Subject: Re: [PATCH v20 01/15] EDAC: Add support for EDAC device features
 control
References: <20250212143654.1893-1-shiju.jose@huawei.com>
 <20250212143654.1893-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212143654.1893-2-shiju.jose@huawei.com>

On Wed, Feb 12, 2025 at 02:36:39PM +0000, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add generic EDAC device feature controls supporting the registration
> of RAS features available in the system. The driver exposes control
> attributes for these features to userspace in
> /sys/bus/edac/devices/<dev-name>/<ras-feature>/
> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Tested-by: Fan Ni <fan.ni@samsung.com>

> ---
>  Documentation/edac/features.rst |  94 +++++++++++++++++++++++++++++
>  Documentation/edac/index.rst    |  10 ++++
>  drivers/edac/edac_device.c      | 102 ++++++++++++++++++++++++++++++++
>  include/linux/edac.h            |  26 ++++++++
>  4 files changed, 232 insertions(+)
>  create mode 100644 Documentation/edac/features.rst
>  create mode 100644 Documentation/edac/index.rst
> 
> diff --git a/Documentation/edac/features.rst b/Documentation/edac/features.rst
> new file mode 100644
> index 000000000000..6b0fdc6f5d6e
> --- /dev/null
> +++ b/Documentation/edac/features.rst
> @@ -0,0 +1,94 @@
> +.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.2-no-invariants-or-later
> +
> +============================================
> +Augmenting EDAC for controlling RAS features
> +============================================
> +
> +Copyright (c) 2024-2025 HiSilicon Limited.
> +
> +:Author:   Shiju Jose <shiju.jose@huawei.com>
> +:License:  The GNU Free Documentation License, Version 1.2 without
> +           Invariant Sections, Front-Cover Texts nor Back-Cover Texts.
> +           (dual licensed under the GPL v2)
> +
> +- Written for: 6.15
> +
> +Introduction
> +------------
> +The expansion of EDAC for controlling RAS features and exposing features
> +control attributes to userspace via sysfs. Some Examples:
> +
> +1. Scrub control
> +
> +2. Error Check Scrub (ECS) control
> +
> +3. ACPI RAS2 features
> +
> +4. Post Package Repair (PPR) control
> +
> +5. Memory Sparing Repair control etc.
> +
> +High level design is illustrated in the following diagram::
> +
> +        +-----------------------------------------------+
> +        |   Userspace - Rasdaemon                       |
> +        | +-------------+                               |
> +        | | RAS CXL mem |     +---------------+         |
> +        | |error handler|---->|               |         |
> +        | +-------------+     | RAS dynamic   |         |
> +        | +-------------+     | scrub, memory |         |
> +        | | RAS memory  |---->| repair control|         |
> +        | |error handler|     +----|----------+         |
> +        | +-------------+          |                    |
> +        +--------------------------|--------------------+
> +                                   |
> +                                   |
> +   +-------------------------------|------------------------------+
> +   |     Kernel EDAC extension for | controlling RAS Features     |
> +   |+------------------------------|----------------------------+ |
> +   || EDAC Core          Sysfs EDAC| Bus                        | |
> +   ||   +--------------------------|---------------------------+| |
> +   ||   |/sys/bus/edac/devices/<dev>/scrubX/ |   | EDAC device || |
> +   ||   |/sys/bus/edac/devices/<dev>/ecsX/   |<->| EDAC MC     || |
> +   ||   |/sys/bus/edac/devices/<dev>/repairX |   | EDAC sysfs  || |
> +   ||   +---------------------------|--------------------------+| |
> +   ||                           EDAC|Bus                        | |
> +   ||                               |                           | |
> +   ||   +----------+ Get feature    |      Get feature          | |
> +   ||   |          | desc +---------|------+ desc +----------+  | |
> +   ||   |EDAC scrub|<-----| EDAC device    |      |          |  | |
> +   ||   +----------+      | driver- RAS    |----->| EDAC mem |  | |
> +   ||   +----------+      | feature control|      | repair   |  | |
> +   ||   |          |<-----|                |      +----------+  | |
> +   ||   |EDAC ECS  |      +---------|------+                    | |
> +   ||   +----------+    Register RAS|features                   | |
> +   ||         ______________________|_____________              | |
> +   |+---------|---------------|------------------|--------------+ |
> +   |  +-------|----+  +-------|-------+     +----|----------+     |
> +   |  |            |  | CXL mem driver|     | Client driver |     |
> +   |  | ACPI RAS2  |  | scrub, ECS,   |     | memory repair |     |
> +   |  | driver     |  | sparing, PPR  |     | features      |     |
> +   |  +-----|------+  +-------|-------+     +------|--------+     |
> +   |        |                 |                    |              |
> +   +--------|-----------------|--------------------|--------------+
> +            |                 |                    |
> +   +--------|-----------------|--------------------|--------------+
> +   |    +---|-----------------|--------------------|-------+      |
> +   |    |                                                  |      |
> +   |    |            Platform HW and Firmware              |      |
> +   |    +--------------------------------------------------+      |
> +   +--------------------------------------------------------------+
> +
> +
> +1. EDAC Features components - Create feature specific descriptors.
> +   For example, EDAC scrub, EDAC ECS, EDAC memory repair in the above
> +   diagram.
> +
> +2. EDAC device driver for controlling RAS Features - Get feature's attribute
> +   descriptors from EDAC RAS feature component and registers device's RAS
> +   features with EDAC bus and exposes the features control attributes via
> +   the sysfs EDAC bus. For example, /sys/bus/edac/devices/<dev-name>/<feature>X/
> +
> +3. RAS dynamic feature controller - Userspace sample modules in rasdaemon for
> +   dynamic scrub/repair control to issue scrubbing/repair when excess number
> +   of corrected memory errors are reported in a short span of time.
> diff --git a/Documentation/edac/index.rst b/Documentation/edac/index.rst
> new file mode 100644
> index 000000000000..de4a3aa452cb
> --- /dev/null
> +++ b/Documentation/edac/index.rst
> @@ -0,0 +1,10 @@
> +.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.2-no-invariants-or-later
> +
> +==============
> +EDAC Subsystem
> +==============
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   features
> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
> index 621dc2a5d034..142a661ff543 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -570,3 +570,105 @@ void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
>  		      block ? block->name : "N/A", count, msg);
>  }
>  EXPORT_SYMBOL_GPL(edac_device_handle_ue_count);
> +
> +static void edac_dev_release(struct device *dev)
> +{
> +	struct edac_dev_feat_ctx *ctx = container_of(dev, struct edac_dev_feat_ctx, dev);
> +
> +	kfree(ctx->dev.groups);
> +	kfree(ctx);
> +}
> +
> +const struct device_type edac_dev_type = {
> +	.name = "edac_dev",
> +	.release = edac_dev_release,
> +};
> +
> +static void edac_dev_unreg(void *data)
> +{
> +	device_unregister(data);
> +}
> +
> +/**
> + * edac_dev_register - register device for RAS features with EDAC
> + * @parent: parent device.
> + * @name: name for the folder in the /sys/bus/edac/devices/,
> + *	  which is derived from the parent device.
> + *	  For eg. /sys/bus/edac/devices/cxl_mem0/
> + * @private: parent driver's data to store in the context if any.
> + * @num_features: number of RAS features to register.
> + * @ras_features: list of RAS features to register.
> + *
> + * Return:
> + *  * %0       - Success.
> + *  * %-EINVAL - Invalid parameters passed.
> + *  * %-ENOMEM - Dynamic memory allocation failed.
> + *
> + */
> +int edac_dev_register(struct device *parent, char *name,
> +		      void *private, int num_features,
> +		      const struct edac_dev_feature *ras_features)
> +{
> +	const struct attribute_group **ras_attr_groups;
> +	struct edac_dev_feat_ctx *ctx;
> +	int attr_gcnt = 0;
> +	int ret, feat;
> +
> +	if (!parent || !name || !num_features || !ras_features)
> +		return -EINVAL;
> +
> +	/* Double parse to make space for attributes */
> +	for (feat = 0; feat < num_features; feat++) {
> +		switch (ras_features[feat].ft_type) {
> +		/* Add feature specific code */
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ras_attr_groups = kcalloc(attr_gcnt + 1, sizeof(*ras_attr_groups), GFP_KERNEL);
> +	if (!ras_attr_groups) {
> +		ret = -ENOMEM;
> +		goto ctx_free;
> +	}
> +
> +	attr_gcnt = 0;
> +	for (feat = 0; feat < num_features; feat++, ras_features++) {
> +		switch (ras_features->ft_type) {
> +		/* Add feature specific code */
> +		default:
> +			ret = -EINVAL;
> +			goto groups_free;
> +		}
> +	}
> +
> +	ctx->dev.parent = parent;
> +	ctx->dev.bus = edac_get_sysfs_subsys();
> +	ctx->dev.type = &edac_dev_type;
> +	ctx->dev.groups = ras_attr_groups;
> +	ctx->private = private;
> +	dev_set_drvdata(&ctx->dev, ctx);
> +
> +	ret = dev_set_name(&ctx->dev, name);
> +	if (ret)
> +		goto groups_free;
> +
> +	ret = device_register(&ctx->dev);
> +	if (ret) {
> +		put_device(&ctx->dev);
> +		return ret;
> +	}
> +
> +	return devm_add_action_or_reset(parent, edac_dev_unreg, &ctx->dev);
> +
> +groups_free:
> +	kfree(ras_attr_groups);
> +ctx_free:
> +	kfree(ctx);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(edac_dev_register);
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index b4ee8961e623..8c4b6ca2a994 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -661,4 +661,30 @@ static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
>  
>  	return mci->dimms[index];
>  }
> +
> +/* RAS feature type */
> +enum edac_dev_feat {
> +	RAS_FEAT_MAX
> +};
> +
> +/* EDAC device feature information structure */
> +struct edac_dev_data {
> +	u8 instance;
> +	void *private;
> +};
> +
> +struct edac_dev_feat_ctx {
> +	struct device dev;
> +	void *private;
> +};
> +
> +struct edac_dev_feature {
> +	enum edac_dev_feat ft_type;
> +	u8 instance;
> +	void *ctx;
> +};
> +
> +int edac_dev_register(struct device *parent, char *dev_name,
> +		      void *parent_pvt_data, int num_features,
> +		      const struct edac_dev_feature *ras_features);
>  #endif /* _LINUX_EDAC_H_ */
> -- 
> 2.43.0
> 

