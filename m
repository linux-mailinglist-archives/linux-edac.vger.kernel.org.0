Return-Path: <linux-edac+bounces-1583-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E79A19412E9
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 15:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA991F24139
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 13:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADC519E83C;
	Tue, 30 Jul 2024 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SFbNY/iz"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47BB2CA7;
	Tue, 30 Jul 2024 13:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345433; cv=none; b=RSsmBq/ZHeH2hyBEMCoYgIdJA0axbVNqsdIKOZHm2lhRvtlKmzfI3o2qYGNOLN0N5eCGFdnRbKowoGtX9YFRwlS4eDUx78eUHnPrZlsowVSVA9usrHZ5xnAnfgDpCkdMPjY1E1BQJzTrIIG+59hcL6/e4Ickuq48vj0xi/Az7PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345433; c=relaxed/simple;
	bh=PpgPcz4mJgFasB7hcoUur2pfvf6LkgH1ozOGEkjpKPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZTJ8upowNsTNRH2SBL1Gzu2FIqTnzU1D64Fr6CdGQuie+nOYP/dyEzntXSnSXYObf2z5Y3TViuFeG/W25NgrXqcPm464dkE1KtHyK86mXFIfDgDGKHMZV02FXfEECzQ+kVjEPbv4+dakagKFb8IDseqPGeMMzeJzwdS50MOaR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SFbNY/iz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A4B1940E01CD;
	Tue, 30 Jul 2024 13:17:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id t4KCJeA0thJX; Tue, 30 Jul 2024 13:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1722345421; bh=3mmWlxNZdjshKUX8r4jOpJ3VKzvjNoDxxlHvf6e8xD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SFbNY/iz5BcDMeQbxp+X3vfPiEdb2t4PxqUSRoXozRWhAmaBtlRDGuE08MO8YNiHd
	 0kWk3d4kQ/jr9kIeS6dQJXMe5sWFb8iuXKz0+Wj0F9/iv63K5PmspTFI8gzv32bKeX
	 G4NZNegTN3fny0rb7f/4VXsAzxTCriaoLrIFj+97x0hkLjB/LYxiwju7zwiR6+Anp4
	 3TZYTkAeB1pArVh3DaSjjIK+pUuiAsHAvA+7Br2lJT1DCdMOAyjKZnwIhx6DzxcPDQ
	 rXUVdcyDcYBHJCuduN7ee6Q21ZTKrh+eODkc7zm60TqMNWa4ygLVjpLgCnxz+Cqo5o
	 mlNHN1sQ6B7IvLFGQ3vEdwIdWROgKr/ojk87Vf7/PW9a3ScLuYhU+D6BadXeJr1RNx
	 7//S/hoxIa9wg6ng3iAxCcdwF+Sep8dyJEEzietrnQgH1E8GlngfVhkbpwtkJYNpGO
	 yaxScn/BQtyomvosHryIu6U0RFg9TtoCMyfcRal5cUIk72/6Y6xpHKne7Bq+kH3Xxy
	 164Zd9i193avNZ1IsrsL1Vbo8QrNYKfktbGsQjg7ym1U193nMYcqeGo7U69xU3dLXC
	 Oatzf5Oq8aqMAzWOR0rnvLY6E63LmKMrPj7oSi0EdjRzJt3h+Kd2dIIdUAfH0IqvwJ
	 tXYi7emc/bZwNzvSN1hU2JXU=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BAD0840E01A8;
	Tue, 30 Jul 2024 13:16:16 +0000 (UTC)
Date: Tue, 30 Jul 2024 15:16:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
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
Subject: Re: [PATCH v10 01/11] EDAC: Add generic EDAC RAS control feature
 driver
Message-ID: <20240730131611.GAZqjnm9D4ZJoGBIuZ@fat_crate.local>
References: <20240726160556.2079-1-shiju.jose@huawei.com>
 <20240726160556.2079-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240726160556.2079-2-shiju.jose@huawei.com>

On Fri, Jul 26, 2024 at 05:05:45PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add generic EDAC driver supports registering RAS features supported
> in the system. The driver exposes feature's control attributes to the
> userspace in /sys/bus/edac/devices/<dev-name>/<ras-feature>/
> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/edac/Makefile            |   1 +
>  drivers/edac/edac_ras_feature.c  | 181 +++++++++++++++++++++++++++++++
>  include/linux/edac_ras_feature.h |  66 +++++++++++
>  3 files changed, 248 insertions(+)
>  create mode 100755 drivers/edac/edac_ras_feature.c
>  create mode 100755 include/linux/edac_ras_feature.h
> 
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 9c09893695b7..c532b57a6d8a 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_EDAC)			:= edac_core.o
>  
>  edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
>  edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o
> +edac_core-y	+= edac_ras_feature.o

EDAC and RAS and feature?!

Oh boy.

EDAC == RAS.

"feature" is silly.

Looking at the code below, you're registering an EDAC device.
- edac_ras_dev_register().

So why isn't this thing in edac_device.c?

> diff --git a/include/linux/edac_ras_feature.h b/include/linux/edac_ras_feature.h
> new file mode 100755
> index 000000000000..8f0e0c47a617
> --- /dev/null
> +++ b/include/linux/edac_ras_feature.h
> @@ -0,0 +1,66 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * EDAC RAS control features.
> + *
> + * Copyright (c) 2024 HiSilicon Limited.
> + */
> +
> +#ifndef __EDAC_RAS_FEAT_H
> +#define __EDAC_RAS_FEAT_H
> +
> +#include <linux/types.h>
> +#include <linux/edac.h>
> +
> +#define EDAC_RAS_NAME_LEN	128
> +
> +enum edac_ras_feat {
> +	RAS_FEAT_SCRUB,
> +	RAS_FEAT_ECS,
> +	RAS_FEAT_MAX
> +};
> +
> +struct edac_ecs_ex_info {
> +	u16 num_media_frus;
> +};
> +
> +/*
> + * EDAC RAS feature information structure
> + */
> +struct edac_scrub_data {
> +	const struct edac_scrub_ops *ops;
> +	void *private;
> +};
> +
> +struct edac_ecs_data {
> +	const struct edac_ecs_ops *ops;
> +	void *private;
> +};

So each "feature" would require a separate struct type?

Why don't you define a *single* struct which accomodates any RAS
functionality?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

