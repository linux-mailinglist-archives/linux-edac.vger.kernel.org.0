Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F3D33EFAC
	for <lists+linux-edac@lfdr.de>; Wed, 17 Mar 2021 12:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhCQLdm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 Mar 2021 07:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhCQLdl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 17 Mar 2021 07:33:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620C7C06174A;
        Wed, 17 Mar 2021 04:33:41 -0700 (PDT)
Received: from zn.tnic (p200300ec2f094a001c9658046b27d853.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:4a00:1c96:5804:6b27:d853])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7B9A91EC032C;
        Wed, 17 Mar 2021 12:33:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615980819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SSsIh3B2cYa7hanuOBdoPO7qzqUOsSDVhxk2m9nUtdQ=;
        b=e2SkXGEsgADJZKro3WDeMerU4HBghf+AImuifQZfDsyyzoAnLw8TMCPY7XI4FLqAiFBAtO
        89sDk0kIi5g95/jPNjNru6+vYUvCPmYO1c6iE37MQTwkpa3/W/1le3HZ0iXGYHkh5lxY39
        EEe0cNEp49IAh+q5hOFiXOnUqsbSauY=
Date:   Wed, 17 Mar 2021 12:33:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     tony.luck@intel.com, qiuxu.zhuo@intel.com, mchehab@kernel.org,
        james.morse@arm.com, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC: use NULL instead of using plain integer as pointer
Message-ID: <20210317113337.GA25069@zn.tnic>
References: <1615967245-35819-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1615967245-35819-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Mar 17, 2021 at 03:47:25PM +0800, Yang Li wrote:
> This fixes the following sparse warnings:
> drivers/edac/sb_edac.c:433:10: warning: Using plain integer as NULL
> pointer
> drivers/edac/sb_edac.c:499:10: warning: Using plain integer as NULL
> pointer
> drivers/edac/sb_edac.c:570:10: warning: Using plain integer as NULL
> pointer
> drivers/edac/sb_edac.c:614:10: warning: Using plain integer as NULL
> pointer
> drivers/edac/sb_edac.c:680:10: warning: Using plain integer as NULL
> pointer
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/edac/sb_edac.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
> index 93daa42..a99df55 100644
> --- a/drivers/edac/sb_edac.c
> +++ b/drivers/edac/sb_edac.c
> @@ -433,7 +433,7 @@ struct sbridge_pvt {
>  
>  static const struct pci_id_table pci_dev_descr_sbridge_table[] = {
>  	PCI_ID_TABLE_ENTRY(pci_dev_descr_sbridge, ARRAY_SIZE(pci_dev_descr_sbridge), 1, SANDY_BRIDGE),
> -	{0,}			/* 0 terminated list. */
> +	{NULL,}			/* 0 terminated list. */

Why does this matter for list terminators?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
