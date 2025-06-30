Return-Path: <linux-edac+bounces-4291-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AECAEE4BE
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jun 2025 18:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13AE53A1923
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jun 2025 16:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E950529827C;
	Mon, 30 Jun 2025 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BMZUCUzV"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5A628FAA5;
	Mon, 30 Jun 2025 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301275; cv=none; b=IRzizjVJKj+sWSlax4pOCxZzwn9EyjPF4RTnL4mt6sHabdPPjEysj6sxNs69slFNUrvlGQh6YFMlpaoZD63DSuMg4IpBxh6Xbfn4M1x3dBPk1WtEXwtp99+wm3DLBHTTTa4N1ZeVt39A58WdLZScpmrRJmEK+5WtiMoPpg7rO4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301275; c=relaxed/simple;
	bh=mEHgqV03o6VTz0DapeBgcIdYMe2Zhh2E6lJ6zYMRoDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRTqNap/QUvixKvhvfvq2KUA7/nFNSnj2EdDAxyAQUSWCs96luOpwIUJSzQzBZGYYe0dOvDo9yqm9cFzMfm4oLay2U2vr/t2dRir0A9JD3/GL2nrPxNY61e83a231j77i4iBslNjrDpEH6XbUNwvkzphjIFCbEmUqolGLQ16mZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BMZUCUzV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D075740E0198;
	Mon, 30 Jun 2025 16:34:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wScW8kbuQCJS; Mon, 30 Jun 2025 16:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1751301259; bh=EnhzZidqHbMAwNFsHGf6+uqGMdAMCcl5F1jBVz6QWgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BMZUCUzVVCYUN+c75XBck4//dLcc6OVn8555COXfzRHQN2jufiCIy47cd4CfOGk7+
	 ymghOobXcEjp8GqUiwbPrImcJTX2MXN/GULqM0cgHpPqO+ELRjaWmY/F79fcDHZVsB
	 d9dDNy+6I00tN3J+ZUbz6WWY7F35eMRd3QgNVTGanFTuIXfE1OjJ7+hDfatmeWCQ14
	 x+97/wisPlpc6U2lVsIvjXGVweLd8bumwzVebVAKiG62we3YVGiWwjuWKZdHiNFmaB
	 SZn5L30tUkgPDir4fv8KgEZBc/h+e8HCCjhpSAUIWoX5i/albOH0cR2D+Jj35UKhL8
	 JZakHzgWoK3NhLd/Ofr5dObcCqkKtrhWokWRGWQP5+uZ1sU2M/gQnaHjQ5sKVoc6n5
	 zjgfx5kw585maa7oHuoig3YnxkGn9h/c8WbExP8tqav6P9jgBdaKvtomzXRHJfs+mK
	 c8A0CWiXZ+eV+wdUydjOZKBGEpj1mcCGmqITaYjVfEQoM+coCqOh/QmygdSRu9TBct
	 U43jaqMRc3ZC+cLk763DM09RudZidK9jMp4RU1p5ZE0hDIrClArLsmgFxdOCbOBxse
	 rMu+gkoqxnTs4Z7KSp9zfFCmxOOqfl9lSoFgeE/StRhz95n94La0pdh3XHsVw/IUJF
	 oTm8SUbvrG6IYuCuEo5MZ7Bs=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7244C40E00DD;
	Mon, 30 Jun 2025 16:34:04 +0000 (UTC)
Date: Mon, 30 Jun 2025 18:33:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc: Tony Luck <tony.luck@intel.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
	Marc Zyngier <maz@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [v11 PATCH 1/2] EDAC: Add EDAC driver for ARM Cortex A72 cores
Message-ID: <20250630163357.GGaGK8dbT4fp68PplM@fat_crate.local>
References: <1748487628-30123-1-git-send-email-vijayb@linux.microsoft.com>
 <1748487628-30123-2-git-send-email-vijayb@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1748487628-30123-2-git-send-email-vijayb@linux.microsoft.com>

On Wed, May 28, 2025 at 08:00:27PM -0700, Vijay Balakrishna wrote:
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index a8f2d8f6c894..136416f43b44 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -88,3 +88,4 @@ obj-$(CONFIG_EDAC_NPCM)			+= npcm_edac.o
>  obj-$(CONFIG_EDAC_ZYNQMP)		+= zynqmp_edac.o
>  obj-$(CONFIG_EDAC_VERSAL)		+= versal_edac.o
>  obj-$(CONFIG_EDAC_LOONGSON)		+= loongson_edac.o
> +obj-$(CONFIG_EDAC_CORTEX_A72)		+= edac_a72.o

The drivers filename format is

	edac_<something>.c

So a72_edac.c

> diff --git a/drivers/edac/edac_a72.c b/drivers/edac/edac_a72.c
> new file mode 100644
> index 000000000000..4f40616d40a0
> --- /dev/null
> +++ b/drivers/edac/edac_a72.c
> @@ -0,0 +1,230 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cortex A72 EDAC L1 and L2 cache error detection
> + *
> + * Copyright (c) 2020 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
> + * Copyright (c) 2025 Microsoft Corporation, <vijayb@linux.microsoft.com>
> + *
> + * Based on Code from:
> + * Copyright (c) 2018, NXP Semiconductor
> + * Author: York Sun <york.sun@nxp.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/bitfield.h>
> +#include <asm/smp_plat.h>
> +
> +#include "edac_module.h"
> +
> +#define DRVNAME		"edac-a72"
> +
> +#define SYS_CPUMERRSR_EL1	sys_reg(3, 1, 15, 2, 2)
> +#define SYS_L2MERRSR_EL1	sys_reg(3, 1, 15, 2, 3)
> +
> +#define CPUMERRSR_EL1_RAMID		GENMASK(30, 24)
> +#define L2MERRSR_EL1_CPUID_WAY	GENMASK(21, 18)
> +
> +#define CPUMERRSR_EL1_VALID		BIT(31)
> +#define CPUMERRSR_EL1_FATAL		BIT(63)
> +#define L2MERRSR_EL1_VALID		BIT(31)
> +#define L2MERRSR_EL1_FATAL		BIT(63)
> +
> +#define L1_I_TAG_RAM	0x00
> +#define L1_I_DATA_RAM	0x01
> +#define L1_D_TAG_RAM	0x08
> +#define L1_D_DATA_RAM	0x09
> +#define TLB_RAM			0x18
> +
> +#define MESSAGE_SIZE	64

I had written

"Please group all defines together, align them vertically and then put other
definitions below. Look at other drivers for inspiration."

in my previous review

Message-ID: <20250519085130.GFaCrxEnZvaoETKrao@fat_crate.local>

but seems like this got ignored.

Oh well, I'll ignore your submission too until you address *all* my review
feedback.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

