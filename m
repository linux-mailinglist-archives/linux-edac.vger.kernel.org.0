Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84B947BE8A
	for <lists+linux-edac@lfdr.de>; Tue, 21 Dec 2021 12:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbhLULHW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 21 Dec 2021 06:07:22 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44294 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236854AbhLULHW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 21 Dec 2021 06:07:22 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CC6E21EC0328;
        Tue, 21 Dec 2021 12:07:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640084836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xXqBzKOLuHsEcaumBBArdM0Likeo4E7ACPcERYiHJFc=;
        b=KBposX2+wjH1MTWWTHSdMaf1VyBgjY94aCZIT/K5EhNTpPWh9V69bRQbrF3DEwyfbIjP7j
        wBP/vzNE6sIp6+RAxc8/j9Hoox73cNGHGaTB6VGp72BMXQpv34Tv3FeqHnu38Q8MmC1v31
        RW4nvLwIIEpaTkmOoEI6XuPPaElgvho=
Date:   Tue, 21 Dec 2021 12:07:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Colin Ian King <colin.i.king@googlemail.com>
Cc:     Tony Luck <tony.luck@intel.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/sb_edac: Remove redundant initialization of
 variable rc
Message-ID: <YcG1Z7XlSHZJuA0j@zn.tnic>
References: <20211126221848.1125321-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211126221848.1125321-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Nov 26, 2021 at 10:18:48PM +0000, Colin Ian King wrote:
> The variable rc is being initialized with a value that is never
> read, it is being updated later on. The assignment is redundant and
> can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/edac/sb_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
> index 1522d4aa2ca6..9678ab97c7ac 100644
> --- a/drivers/edac/sb_edac.c
> +++ b/drivers/edac/sb_edac.c
> @@ -3439,7 +3439,7 @@ MODULE_DEVICE_TABLE(x86cpu, sbridge_cpuids);
>  
>  static int sbridge_probe(const struct x86_cpu_id *id)
>  {
> -	int rc = -ENODEV;
> +	int rc;
>  	u8 mc, num_mc = 0;
>  	struct sbridge_dev *sbridge_dev;
>  	struct pci_id_table *ptable = (struct pci_id_table *)id->driver_data;
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
