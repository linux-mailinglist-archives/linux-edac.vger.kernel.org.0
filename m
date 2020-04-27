Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AEA1B9A4B
	for <lists+linux-edac@lfdr.de>; Mon, 27 Apr 2020 10:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgD0Icu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Apr 2020 04:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgD0Ict (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Apr 2020 04:32:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05B7C061A0F
        for <linux-edac@vger.kernel.org>; Mon, 27 Apr 2020 01:32:49 -0700 (PDT)
Received: from zn.tnic (p200300EC2F05F0006DE2BE28B1B44CEA.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:f000:6de2:be28:b1b4:4cea])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 472821EC0C6D;
        Mon, 27 Apr 2020 10:32:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587976368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZRiIDRdrlzJfF3mmDWacCLhbuC8FlrH6Y/1CRjt0SB4=;
        b=PYROaSbxAfxuWEPr2apxlOzZ5oEfZf3q2gvqDQRUdveHYqHOaX+VDqCm0Ru8nivprRFZFM
        c20PQrHB2tq9tnN6ZK9unfdYtn0NBJ36qlxvQZ152X4ppP91U+XozFMr5d17y1fs5i611S
        mC3hTXClUVsGH2Qkc1nVOagQbkxVWoM=
Date:   Mon, 27 Apr 2020 10:32:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 1/2] EDAC, {skx,i10nm}: Make some configurations CPU
 model specific
Message-ID: <20200427083246.GB11036@zn.tnic>
References: <20200424185738.7985-1-tony.luck@intel.com>
 <20200424185738.7985-2-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200424185738.7985-2-tony.luck@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Apr 24, 2020 at 11:57:37AM -0700, Tony Luck wrote:
> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> The device ID for configuration agent PCI device and the offset for
> bus number configuration register can be CPU model specific. So add
> a new structure res_config to make them configurable and pass res_config
> to {skx,i10nm}_init() and skx_get_all_bus_mappings() for use.
> 
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/edac/i10nm_base.c | 16 ++++++++++++----
>  drivers/edac/skx_base.c   | 12 ++++++++++--
>  drivers/edac/skx_common.c | 11 +++++------
>  drivers/edac/skx_common.h | 11 +++++++++--
>  4 files changed, 36 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
> index df08de963d10..ba4578c6ef2b 100644
> --- a/drivers/edac/i10nm_base.c
> +++ b/drivers/edac/i10nm_base.c
> @@ -122,10 +122,16 @@ static int i10nm_get_all_munits(void)
>  	return 0;
>  }
>  
> +static struct res_config i10nm_cfg = {
> +	.type			= I10NM,
> +	.decs_did		= 0x3452,
> +	.busno_cfg_offset	= 0xcc,
> +};
> +
>  static const struct x86_cpu_id i10nm_cpuids[] = {
> -	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	NULL),
> -	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		NULL),
> -	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&i10nm_cfg),
> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&i10nm_cfg),
> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&i10nm_cfg),
>  	{}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, i10nm_cpuids);
> @@ -234,6 +240,7 @@ static int __init i10nm_init(void)
>  {
>  	u8 mc = 0, src_id = 0, node_id = 0;
>  	const struct x86_cpu_id *id;
> +	struct res_config *cfg;
>  	const char *owner;
>  	struct skx_dev *d;
>  	int rc, i, off[3] = {0xd0, 0xc8, 0xcc};
> @@ -248,12 +255,13 @@ static int __init i10nm_init(void)
>  	id = x86_match_cpu(i10nm_cpuids);
>  	if (!id)
>  		return -ENODEV;

<---- newline here.

> +	cfg = (struct res_config *)id->driver_data;
>  
>  	rc = skx_get_hi_lo(0x09a2, off, &tolm, &tohm);
>  	if (rc)
>  		return rc;
>  
> -	rc = skx_get_all_bus_mappings(0x3452, 0xcc, I10NM, &i10nm_edac_list);
> +	rc = skx_get_all_bus_mappings(cfg, &i10nm_edac_list);
>  	if (rc < 0)
>  		goto fail;
>  	if (rc == 0) {
> diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
> index 46a3a3440f5e..ae2c2b516adc 100644
> --- a/drivers/edac/skx_base.c
> +++ b/drivers/edac/skx_base.c
> @@ -157,8 +157,14 @@ static int get_all_munits(const struct munit *m)
>  	return -ENODEV;
>  }
>  
> +static struct res_config skx_cfg = {
> +	.type			= SKX,
> +	.decs_did		= 0x2016,
> +	.busno_cfg_offset	= 0xcc,
> +};
> +
>  static const struct x86_cpu_id skx_cpuids[] = {
> -	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,	NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,	&skx_cfg),
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(x86cpu, skx_cpuids);
> @@ -641,6 +647,7 @@ static inline void teardown_skx_debug(void) {}
>  static int __init skx_init(void)
>  {
>  	const struct x86_cpu_id *id;
> +	struct res_config *cfg;
>  	const struct munit *m;
>  	const char *owner;
>  	int rc = 0, i, off[3] = {0xd0, 0xd4, 0xd8};
> @@ -656,12 +663,13 @@ static int __init skx_init(void)
>  	id = x86_match_cpu(skx_cpuids);
>  	if (!id)
>  		return -ENODEV;

<---- newline here.

other than that:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
