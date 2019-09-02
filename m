Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1480A571A
	for <lists+linux-edac@lfdr.de>; Mon,  2 Sep 2019 15:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfIBNEr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Sep 2019 09:04:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35824 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729772AbfIBNEq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 2 Sep 2019 09:04:46 -0400
Received: from zn.tnic (p200300EC2F06430009E289DB508BD3C2.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:4300:9e2:89db:508b:d3c2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D2AE1EC058B;
        Mon,  2 Sep 2019 15:04:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567429485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=77PtjuIekR7htR984GNpRJBYDjP64meXwcBGbveULQM=;
        b=cTqyCKUHHRB7OiiNP7ZHUfXAtpP8dZN9xD93thOCckviqTmv5EJUEwuw9mlvkWrIMx7loL
        I8sfxO0QTGA4xwyKrFcyQKH6PvV/KYcU7IOzW9cQFmp+zrRpKpbi91w0jgkfx0MRgG0ufK
        WIgxd9MvagP1kcowC3thQUc8Btuz8hU=
Date:   Mon, 2 Sep 2019 15:04:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] EDAC, mc_sysfs: Change dev_ch_attribute->channel to
 unsigned int
Message-ID: <20190902130439.GE9605@zn.tnic>
References: <20190902123216.9809-1-rrichter@marvell.com>
 <20190902123216.9809-3-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190902123216.9809-3-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 02, 2019 at 12:33:43PM +0000, Robert Richter wrote:
> Struct member dev_ch_attribute->channel is always used as unsigned
> int. Change type to unsigned int to avoid type casts.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/edac_mc_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
> index 640b9419623e..4eb8c5ceb973 100644
> --- a/drivers/edac/edac_mc_sysfs.c
> +++ b/drivers/edac/edac_mc_sysfs.c
> @@ -131,7 +131,7 @@ static const char * const edac_caps[] = {
>  
>  struct dev_ch_attribute {
>  	struct device_attribute attr;
> -	int channel;
> +	unsigned int channel;
>  };
>  
>  #define DEVICE_CHANNEL(_name, _mode, _show, _store, _var) \
> -- 

Merged this one into 1/5.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
