Return-Path: <linux-edac+bounces-1865-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E06A9977CFE
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2024 12:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A83C1F293ED
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2024 10:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DCE1D7E4B;
	Fri, 13 Sep 2024 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JJY1XJ8L"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38A51BD00C;
	Fri, 13 Sep 2024 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726222335; cv=none; b=Qy7TS8PB8TTzRFyoVp/ehoRhwAjq18wubrW4wH0H8uETsr2fbt6ZU7IhGiI3VC5iJeDc9nFhJDb1qU2yZJb8418npuGGlu/ZL8QRTqvM5HkFcZpbIxQPI1HQGXEP1kp23IO+vAO9hPNOIKFry2C93gOB3ODY7VfqZKOmF9/qgCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726222335; c=relaxed/simple;
	bh=662V56QWViFIlp4gb+aLqLrTxGX17BcMSp70REF+ZWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr70UdTcqIsrABE2H4JbOGGBcploq0cXyBAsqwBye1CgzGragWu2q81Jjxeee4zSB8QJiZ6lNxIibPTmroUG1DNXQkUuuWSjOeygijC/mIAvP+a6sbnFJsEkTpMp22W/gPs+UW8nnD/764b+ZnhvPzUUOUMqasT5ZLBPZfcNY1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JJY1XJ8L; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D1FC840E0289;
	Fri, 13 Sep 2024 10:12:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WrLjSCCCXrfh; Fri, 13 Sep 2024 10:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1726222318; bh=yWZvK7qK3CvlJ6DKacE32zmSE6s7LldG87vSA0J6Ufs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JJY1XJ8LrTQfzftmybO3y10RT0bdb6reSxeOmziCztzicO5RpTW9BWBEo9DiRMXim
	 9h3i/9CMB+VtKeNKJ5fywSSYFxM2IE7Kq91+w3Fd6KTdT+AikkKB/h/bsgL8ff9owh
	 mP/BLVegzf3taqokqrxIFtXElf8zjI8I2054zRT/sLITDcNvi0gQEPY1YCY4HitKJs
	 Ni44wdch9Alyr548bVNHcym8BV+BsYrd0/2RIMkK2dD1Zn+/VW1e/qgo9gMf03gdra
	 orehy+ZcK3IL/ZRYhjOEkizZP/r1phDPrmlTk+zfT3PhC5DBO1c5T0NmwEMSgJuL1i
	 H/ZgmVkAVG42luPxmfcC1daDbCmS+cDJiLs7dWyA6FuLGpXYljV8nWvYU//1MkME4E
	 Is/9Tzk+yMSDagg1mjsuveYa1HPVAuTQIEkf4wHlF02GWFGAnW924U8koCL9OC0xaW
	 MFdwmnsB8MHlOaBrylwC4MkX07IoD9bo1mjeA9TBfLkL5vHJbKMM4n/SPv9d16exsP
	 zERL9t0p+J3sFW+u5w1Gb/aih8pYpFq1nmWnvhiB2UJBCnOePrcypB71LCYR7xa2U8
	 o8d/nGds08I/vD9rIvpWqS+s9rlYMk7QpY3j6i0OaT7OBt8zH7FTqSlD9ROl2xk2Vm
	 9VqfBQk1S1m1CYslfmIWPz9c=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 56E6E40E0288;
	Fri, 13 Sep 2024 10:11:44 +0000 (UTC)
Date: Fri, 13 Sep 2024 12:11:37 +0200
From: Borislav Petkov <bp@alien8.de>
To: Zhao Qunqin <zhaoqunqin@loongson.cn>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	chenhuacai@kernel.org, linux-edac@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@xen0n.name, tony.luck@intel.com, james.morse@arm.com,
	mchehab@kernel.org, rric@kernel.org, loongarch@lists.linux.dev
Subject: Re: [PATCH v4 2/2] Loongarch: EDAC driver for loongson memory
 controller
Message-ID: <20240913101137.GHZuQP2WzlkvJ5gG2F@fat_crate.local>
References: <20240909032124.18819-1-zhaoqunqin@loongson.cn>
 <20240909032124.18819-3-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240909032124.18819-3-zhaoqunqin@loongson.cn>

On Mon, Sep 09, 2024 at 11:21:24AM +0800, Zhao Qunqin wrote:
> Subject: Re: [PATCH v4 2/2] Loongarch: EDAC driver for loongson memory controller

			EDAC/loongson: Add EDAC driver ...

> Reports single bit errors (CE) only.
> 
> Signed-off-by: Zhao Qunqin <zhaoqunqin@loongson.cn>
> ---

...

> diff --git a/drivers/edac/loongson_edac.c b/drivers/edac/loongson_edac.c
> new file mode 100644
> index 000000000..b89d6e0e7
> --- /dev/null
> +++ b/drivers/edac/loongson_edac.c
> @@ -0,0 +1,182 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Loongson Technology Corporation Limited.
> + */
> +
> +#include <linux/edac.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +
> +#include "edac_module.h"
> +
> +enum ecc_index {
> +	ECC_SET = 0,
> +	ECC_RESERVED,
> +	ECC_COUNT,
> +	ECC_CS_COUNT,
> +	ECC_CODE,
> +	ECC_ADDR,
> +	ECC_DATA0,
> +	ECC_DATA1,
> +	ECC_DATA2,
> +	ECC_DATA3,
> +};
> +
> +struct loongson_edac_pvt {
> +	u64 *ecc_base;
> +	int last_ce_count;
> +};
> +
> +static void loongson_update_ce_count(struct mem_ctl_info *mci,

Drop the loongson_ prefix from all static functions.

Also, align function arguments on the opening brace.

> +					int chan,
> +					int new)
> +{
> +	int add;
> +	struct loongson_edac_pvt *pvt = mci->pvt_info;

The EDAC tree preferred ordering of variable declarations at the
beginning of a function is reverse fir tree order::

	struct long_struct_name *descriptive_name;
	unsigned long foo, bar;
	unsigned int tmp;
	int ret;

The above is faster to parse than the reverse ordering::

	int ret;
	unsigned int tmp;
	unsigned long foo, bar;
	struct long_struct_name *descriptive_name;

And even more so than random ordering::

	unsigned long foo, bar;
	int ret;
	struct long_struct_name *descriptive_name;
	unsigned int tmp;

> +
> +	add = new - pvt->last_ce_count;
> +
> +	/* Store the new value */

Drop all those obvious comments.

> +	pvt->last_ce_count = new;
> +
> +	/* device resume or any other exceptions*/

No clue what that means.

Also,  the check goes right under the assignment.

> +	if (add < 0)
> +		return;
> +
> +	/*updated the edac core */

Useless comment.

> +	if (add != 0) {

	if (!add)
		return;

and now you can save yourself an indentation level:

	edac_mc_...(

> +		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, add,
> +					0, 0, 0,
> +					chan, 0, -1, "error", "");
> +		edac_mc_printk(mci, KERN_INFO, "add: %d", add);
> +	}
> +}
> +
> +static int loongson_read_ecc(struct mem_ctl_info *mci)
> +{
> +	u64 ecc;
> +	int cs = 0;
> +	struct loongson_edac_pvt *pvt = mci->pvt_info;
> +
> +	if (!pvt->ecc_base)
> +		return pvt->last_ce_count;
> +
> +	ecc = pvt->ecc_base[ECC_CS_COUNT];
> +	cs += ecc & 0xff;		// cs0
> +	cs += (ecc >> 8) & 0xff;	// cs1
> +	cs += (ecc >> 16) & 0xff;	// cs2
> +	cs += (ecc >> 24) & 0xff;	// cs3

No side comments pls - put them over the line.

> +
> +	return cs;
> +}
> +
> +static void loongson_edac_check(struct mem_ctl_info *mci)
> +{
> +	loongson_update_ce_count(mci, 0, loongson_read_ecc(mci));

Drop this silly wrapper.

> +}
> +
> +static int get_dimm_config(struct mem_ctl_info *mci)
> +{
> +	u32 size, npages;
> +	struct dimm_info *dimm;
> +
> +	/* size not used */
> +	size = -1;
> +	npages = MiB_TO_PAGES(size);
> +
> +	dimm = edac_get_dimm(mci, 0, 0, 0);
> +	dimm->nr_pages = npages;
> +	snprintf(dimm->label, sizeof(dimm->label),
> +			"MC#%uChannel#%u_DIMM#%u",
> +			mci->mc_idx, 0, 0);

Align arguments on the opening brace.

> +	dimm->grain = 8;
> +
> +	return 0;
> +}

...


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

