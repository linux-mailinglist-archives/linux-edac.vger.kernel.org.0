Return-Path: <linux-edac+bounces-2882-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72E9A0BB56
	for <lists+linux-edac@lfdr.de>; Mon, 13 Jan 2025 16:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61A3B7A00E0
	for <lists+linux-edac@lfdr.de>; Mon, 13 Jan 2025 15:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A47120AF9F;
	Mon, 13 Jan 2025 15:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKwmiEQF"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655781FBBCE;
	Mon, 13 Jan 2025 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780783; cv=none; b=L3zlugTDsh4zb3UzdYEDcxCpC84lX0K+2IR8nR37taiSQ/BGahoyzfi/xgLBYdV9cTkhAmz1dLl6jtR+oNf/EgL8ZdXUqQlSSFQjLi/xPQKfPT+7WUNv8mKf+gupZxnQOnVgtzDDzIWw5qdGBSq/hRrSOtQUMHwN64lHPfgASlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780783; c=relaxed/simple;
	bh=Q6YNGAd5oAgIkJE8XOKMMjMWOnnhVSZc7mV1uRa9eU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lqhaz6A7pQ4kxlLRAezwwuk1p3N9pi2vAHenDu3kQLboXfDO4l1fVTEvS9Aw8/jhfLF+TF/A531hE5ffg54q4XIYvsL/IXLondw7z7g20lKQFa/wyv38KxzyBgNG+WndcHRM0bKZpYRJj+f1kzLiwAO1rxny1ywUBI+bsZVDsCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKwmiEQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F84C4CED6;
	Mon, 13 Jan 2025 15:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736780782;
	bh=Q6YNGAd5oAgIkJE8XOKMMjMWOnnhVSZc7mV1uRa9eU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mKwmiEQFH+u83kqAX+1ajwy6vYukC3GWU4c9TYhA38TUl4fjyLblNawhzrsFMotVa
	 yuumUJl8YcD3zMOH+yNcUgSt/HQ1cbYFGLCrsfTmjgRHOyVOH0UW3dozciHjaMHdxW
	 ekYLrku36WRipmcBZSeasWJxBj2v9hR795cH3/m7QjLiFSjBwVMGWhA7Z6bsjw0DFa
	 Gk1Si5Zm/DgYNdUD9X/xZ+Uf/staSKmHdXVuBRYXut0l8m7QpJkrmPBUKfajjnN5KO
	 l1QkplfKyzsorCL10m/B0kxsgqgkr0AfgjNIjjyvMV4R3LGgb6SyL5326kpsKHgdyK
	 or8fp0Tzaa7MA==
Date: Mon, 13 Jan 2025 16:06:11 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: <shiju.jose@huawei.com>
Cc: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
 <rafael@kernel.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
 <dan.j.williams@intel.com>, <dave@stgolabs.net>,
 <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
 <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
 <ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>,
 <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
 <jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
 <naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
 <somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
 <duenwen@google.com>, <gthelen@google.com>,
 <wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
 <wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>,
 <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
 <roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
 <wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v18 01/19] EDAC: Add support for EDAC device features
 control
Message-ID: <20250113160611.39bdf3b3@foz.lan>
In-Reply-To: <20250106121017.1620-2-shiju.jose@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
	<20250106121017.1620-2-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 6 Jan 2025 12:09:57 +0000
<shiju.jose@huawei.com> escreveu:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add generic EDAC device feature controls supporting the registration
> of RAS features available in the system. The driver exposes control
> attributes for these features to userspace in
> /sys/bus/edac/devices/<dev-name>/<ras-feature>/
> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  Documentation/edac/features.rst |  94 ++++++++++++++++++++++++++++++
>  Documentation/edac/index.rst    |  10 ++++
>  drivers/edac/edac_device.c      | 100 ++++++++++++++++++++++++++++++++
>  include/linux/edac.h            |  28 +++++++++
>  4 files changed, 232 insertions(+)
>  create mode 100644 Documentation/edac/features.rst
>  create mode 100644 Documentation/edac/index.rst
> 
> diff --git a/Documentation/edac/features.rst b/Documentation/edac/features.rst
> new file mode 100644
> index 000000000000..f32f259ce04d
> --- /dev/null
> +++ b/Documentation/edac/features.rst
> @@ -0,0 +1,94 @@
> +.. SPDX-License-Identifier: GPL-2.0

SPDX should match what's written there, e. g.

	.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.2-no-invariants-or-later

Please notice that GNU FDL family contains both open source and non-open
source licenses. The open-source one is this:

	https://spdx.org/licenses/GFDL-1.2-no-invariants-or-later.html

E.g. it is a the license permits changing the entire document in
the future, as there's no invariant parts on it.

> +
> +============================================
> +Augmenting EDAC for controlling RAS features
> +============================================
> +
> +Copyright (c) 2024 HiSilicon Limited.

2024-2025?

> +
> +:Author:   Shiju Jose <shiju.jose@huawei.com>
> +:License:  The GNU Free Documentation License, Version 1.2
> +          (dual licensed under the GPL v2)

You need to define if invariant parts are allowed or not, e. g.:

	:License: The GNU Free Documentation License, Version 1.2 without Invariant Sections, Front-Cover Texts nor Back-Cover Texts.
		  (dual licensed under the GPL v2)


> +:Original Reviewers:
> +
> +- Written for: 6.14
> +
> +Introduction
> +------------
> +The expansion of EDAC for controlling RAS features and exposing features
> +control attributes to userspace via sysfs. Some Examples:
> +
> +* Scrub control
> +
> +* Error Check Scrub (ECS) control
> +
> +* ACPI RAS2 features
> +
> +* Post Package Repair (PPR) control
> +
> +* Memory Sparing Repair control etc.
> +
> +High level design is illustrated in the following diagram::
> +
> +         _______________________________________________
> +        |   Userspace - Rasdaemon                       |
> +        |  _____________                                |
> +        | | RAS CXL mem |      _______________          |
> +        | |error handler|---->|               |         |
> +        | |_____________|     | RAS dynamic   |         |
> +        |  _____________      | scrub, memory |         |
> +        | | RAS memory  |---->| repair control|         |
> +        | |error handler|     |_______________|         |
> +        | |_____________|          |                    |
> +        |__________________________|____________________|
> +                                   |
> +                                   |
> +    _______________________________|______________________________
> +   |     Kernel EDAC extension for | controlling RAS Features     |
> +   | ______________________________|____________________________  |
> +   || EDAC Core          Sysfs EDAC| Bus                        | |
> +   ||    __________________________|_________     _____________ | |
> +   ||   |/sys/bus/edac/devices/<dev>/scrubX/ |   | EDAC device || |
> +   ||   |/sys/bus/edac/devices/<dev>/ecsX/   |<->| EDAC MC     || |
> +   ||   |/sys/bus/edac/devices/<dev>/repairX |   | EDAC sysfs  || |
> +   ||   |____________________________________|   |_____________|| |
> +   ||                           EDAC|Bus                        | |
> +   ||                               |                           | |
> +   ||    __________ Get feature     |      Get feature          | |
> +   ||   |          |desc   _________|______ desc  __________    | |
> +   ||   |EDAC scrub|<-----| EDAC device    |     |          |   | |
> +   ||   |__________|      | driver- RAS    |---->| EDAC mem |   | |
> +   ||    __________       | feature control|     | repair   |   | |
> +   ||   |          |<-----|________________|     |__________|   | |
> +   ||   |EDAC ECS  |    Register RAS|features                   | |
> +   ||   |__________|                |                           | |
> +   ||         ______________________|_____________              | |
> +   ||_________|_______________|__________________|______________| |
> +   |   _______|____    _______|_______       ____|__________      |
> +   |  |            |  | CXL mem driver|     | Client driver |     |
> +   |  | ACPI RAS2  |  | scrub, ECS,   |     | memory repair |     |
> +   |  | driver     |  | sparing, PPR  |     | features      |     |
> +   |  |____________|  |_______________|     |_______________|     |
> +   |        |                 |                    |              |
> +   |________|_________________|____________________|______________|
> +            |                 |                    |
> +    ________|_________________|____________________|______________
> +   |     ___|_________________|____________________|_______       |
> +   |    |                                                  |      |
> +   |    |            Platform HW and Firmware              |      |
> +   |    |__________________________________________________|      |
> +   |______________________________________________________________|
> +
> +
> +1. EDAC Features components - Create feature specific descriptors.
> +For example, EDAC scrub, EDAC ECS, EDAC memory repair in the above
> +diagram.
> +
> +2. EDAC device driver for controlling RAS Features - Get feature's attribute
> +descriptors from EDAC RAS feature component and registers device's RAS
> +features with EDAC bus and exposes the features control attributes via
> +the sysfs EDAC bus. For example, /sys/bus/edac/devices/<dev-name>/<feature>X/
> +
> +3. RAS dynamic feature controller - Userspace sample modules in rasdaemon for
> +dynamic scrub/repair control to issue scrubbing/repair when excess number
> +of corrected memory errors are reported in a short span of time.
> diff --git a/Documentation/edac/index.rst b/Documentation/edac/index.rst
> new file mode 100644
> index 000000000000..b6c265a4cffb
> --- /dev/null
> +++ b/Documentation/edac/index.rst
> @@ -0,0 +1,10 @@
> +.. SPDX-License-Identifier: GPL-2.0
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
> index 621dc2a5d034..9fce46dd7405 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -570,3 +570,103 @@ void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
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
> + * @name: parent device's name.
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

As register failed, you need to change it to a goto groups_free,
as edac_dev_release() won't be called.

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
> index b4ee8961e623..521b17113d4d 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -661,4 +661,32 @@ static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
>  
>  	return mci->dimms[index];
>  }
> +
> +#define EDAC_FEAT_NAME_LEN	128

This macro was not used on this patch.

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

Thanks,
Mauro

