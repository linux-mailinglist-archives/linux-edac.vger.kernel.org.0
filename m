Return-Path: <linux-edac+bounces-4013-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B02AAC651F
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 11:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BABFF3AC753
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 09:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472792741DF;
	Wed, 28 May 2025 09:01:55 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1623C244697;
	Wed, 28 May 2025 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748422915; cv=none; b=VN6mYsf+mDTFSZXfXai5oSNaVsSBkCgg4Pe5cIrRLELEL6bAK8jqTu1BWT5bR8VqkhYGcmY+eaJfy+J8uHjTQe6sFvi278JtqxD0IoYgXvOoRYkJKJI2kzFDZoDplRf6ELf99LTrfbSWiyhfvbzcbah3oSljRYhNWTwraeF/eHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748422915; c=relaxed/simple;
	bh=yIHKFd65EMK3B3TOZUx1mxqsgXd/2gqGnSBL7N8XwSk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PmX3a8CeC5n/K6fIrRkPxG3IgV+OQz4CQytEvPj2RrDp8LmfqOLKI/rRkwlaRG0H90p+mnIEi4/9rymYHniNOWxopQyear6u1z9GFcyBULPPnkRPn52xCI/yjkD1PF0y4+vcPHDQjUndJUTJGb1pcbgcKnOD72xNIJXrWrMWJpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b6k4514v9z6HJZN;
	Wed, 28 May 2025 17:00:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 64E7F1402EE;
	Wed, 28 May 2025 17:01:49 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 May
 2025 11:01:48 +0200
Date: Wed, 28 May 2025 10:01:47 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Vijay Balakrishna <vijayb@linux.microsoft.com>
CC: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, James Morse <james.morse@arm.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tyler Hicks
	<code@tyhicks.com>, Marc Zyngier <maz@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [v10 PATCH 1/2] EDAC: Add EDAC driver for ARM Cortex A72 cores
Message-ID: <20250528100147.0000741b@huawei.com>
In-Reply-To: <1748387790-20838-2-git-send-email-vijayb@linux.microsoft.com>
References: <1748387790-20838-1-git-send-email-vijayb@linux.microsoft.com>
	<1748387790-20838-2-git-send-email-vijayb@linux.microsoft.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 27 May 2025 16:16:29 -0700
Vijay Balakrishna <vijayb@linux.microsoft.com> wrote:

> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The driver is designed to support error detection and reporting for
> Cortex A72 cores, specifically within their L1 and L2 cache systems.
> The errors are detected by reading CPU/L2 memory error syndrome
> registers.
> 
> Unfortunately there is no robust way to inject errors into the caches,
> so this driver doesn't contain any code to actually test it. It has
> been tested though with code taken from an older version [1] of this
> driver. For reasons stated in thread [1], the error injection code is
> not suitable for mainline, so it is removed from the driver.
> 
> [1] https://lore.kernel.org/all/1521073067-24348-1-git-send-email-york.sun@nxp.com/#t
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Co-developed-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
I'm far from an expert on the EDAC side of things but generally this
looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Note one comment inline that maybe it's worth adding a line
to the copyright notice given changes you've made?

Jonathan

> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index a8f2d8f6c894..136416f43b44 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -88,3 +88,4 @@ obj-$(CONFIG_EDAC_NPCM)			+= npcm_edac.o
>  obj-$(CONFIG_EDAC_ZYNQMP)		+= zynqmp_edac.o
>  obj-$(CONFIG_EDAC_VERSAL)		+= versal_edac.o
>  obj-$(CONFIG_EDAC_LOONGSON)		+= loongson_edac.o
> +obj-$(CONFIG_EDAC_CORTEX_A72)		+= edac_a72.o
> diff --git a/drivers/edac/edac_a72.c b/drivers/edac/edac_a72.c
> new file mode 100644
> index 000000000000..f23c28fba354
> --- /dev/null
> +++ b/drivers/edac/edac_a72.c
> @@ -0,0 +1,229 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cortex A72 EDAC L1 and L2 cache error detection
> + *
> + * Copyright (c) 2020 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>

I'd argue that you've made enough changes to add an additional
copyright line.  Entirely up to you however!

> + *
> + * Based on Code from:
> + * Copyright (c) 2018, NXP Semiconductor
> + * Author: York Sun <york.sun@nxp.com>
> + */


