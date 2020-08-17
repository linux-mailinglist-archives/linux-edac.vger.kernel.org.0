Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75B324611F
	for <lists+linux-edac@lfdr.de>; Mon, 17 Aug 2020 10:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgHQIsi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Aug 2020 04:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgHQIsh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 17 Aug 2020 04:48:37 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB4CC061388
        for <linux-edac@vger.kernel.org>; Mon, 17 Aug 2020 01:48:37 -0700 (PDT)
Received: from zn.tnic (p200300ec2f26be0058d52f19a716912e.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:be00:58d5:2f19:a716:912e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9099A1EC026E;
        Mon, 17 Aug 2020 10:48:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597654115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RmN6hMBqgqYAnCBRMzsFYNMI+bfJZPlFhY7iNr9vyYc=;
        b=qcikqVQNm4NUS0Z8TKWpwaGr8E9WgeZnkht5UC9k/Zi069lMXtriJjDCJTR90oqGWTM2WQ
        e51IMugdmBLXnXmlWuJt9j0pFRvvzbBp1tzERrw0s902gJ5q1rLajREw/1WYJ5U8TgBTer
        Omat5FMDqBE1Cj2OJThYOCQVSXa62Uo=
Date:   Mon, 17 Aug 2020 10:49:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        Robert Richter <rrichter@marvell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org
Subject: Re: [PATCH -next] EDAC, thunderx: Make symbol 'lmc_dfs_ents' static
Message-ID: <20200817084935.GB549@zn.tnic>
References: <20200714142308.46612-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200714142308.46612-1-weiyongjun1@huawei.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jul 14, 2020 at 10:23:08PM +0800, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> drivers/edac/thunderx_edac.c:457:22: warning:
>  symbol 'lmc_dfs_ents' was not declared. Should it be static?
> 
> Symbol 'lmc_dfs_ents' is not used outside of thunderx_edac.c, so
> marks it static.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/edac/thunderx_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
> index 4af9744cc6d0..0eb5eb97fd74 100644
> --- a/drivers/edac/thunderx_edac.c
> +++ b/drivers/edac/thunderx_edac.c
> @@ -454,7 +454,7 @@ DEBUGFS_STRUCT(inject_int, 0200, thunderx_lmc_inject_int_write, NULL);
>  DEBUGFS_STRUCT(inject_ecc, 0200, thunderx_lmc_inject_ecc_write, NULL);
>  DEBUGFS_STRUCT(int_w1c, 0400, NULL, thunderx_lmc_int_read);
>  
> -struct debugfs_entry *lmc_dfs_ents[] = {
> +static struct debugfs_entry *lmc_dfs_ents[] = {
>  	&debugfs_mask0,
>  	&debugfs_mask2,
>  	&debugfs_parity_test,

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
