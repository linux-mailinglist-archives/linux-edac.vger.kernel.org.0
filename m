Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56C9E1C640
	for <lists+linux-edac@lfdr.de>; Tue, 14 May 2019 11:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfENJnY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 May 2019 05:43:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57444 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfENJnY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 14 May 2019 05:43:24 -0400
Received: from zn.tnic (p200300EC2F29E5000DF69AC748EB6F4C.dip0.t-ipconnect.de [IPv6:2003:ec:2f29:e500:df6:9ac7:48eb:6f4c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A7A3A1EC0A6C;
        Tue, 14 May 2019 11:43:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557827002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+E5lh96Wa9iAgQ7eR2jPUVYeIwVyby6z2wH0NC4hJag=;
        b=Loj+YPx+Ulf7wwk9slTNr9YVy0suTLXN3qw8ea0NQYVS2tnVSgSy0KVLwZRsn40AnYsi46
        Ksjcn6R/bGJ3Wc6FjskIG0Dd20zv6wWDnPZ9SugRvLM8CSUn/wFAU48mxxR9PLv82LnSpS
        pOiE1QMCuPBlVYHo1F2hoHhgL0Vas3U=
Date:   Tue, 14 May 2019 11:43:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC, mc: Fix edac_mc_find() in case no device is found
Message-ID: <20190514094317.GB31140@zn.tnic>
References: <20190514072514.312-1-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190514072514.312-1-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 14, 2019 at 07:25:58AM +0000, Robert Richter wrote:
> The function should return NULL in case no device is found, but it
> always returns the last checked mc device from the list even if the
> index did not match. This patch fixes this.
> 
> I did some analysis why this did not raise any issues for about 3
> years and the reason is that edac_mc_find() is mostly used to search
> for existing devices. Thus, the bug is not triggered.
> 
> Fixes: c73e8833bec5 ("EDAC, mc: Fix locking around mc_devices list")
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/edac_mc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 13594ffadcb3..aeeaaf30b38a 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -688,10 +688,9 @@ struct mem_ctl_info *edac_mc_find(int idx)
>  		mci = list_entry(item, struct mem_ctl_info, link);
>  
>  		if (mci->mc_idx >= idx) {
> -			if (mci->mc_idx == idx) {
> -				goto unlock;
> -			}
> -			break;
> +			if (mci->mc_idx != idx)
> +				mci = NULL;
> +			goto unlock;
>  		}
>  	}

Can we simplify this silly code even more pls? I'm pasting the whole
function instead of a diff for clarity:

---
struct mem_ctl_info *edac_mc_find(int idx)
{
        struct mem_ctl_info *mci = NULL;
        struct list_head *item;

        mutex_lock(&mem_ctls_mutex);

        list_for_each(item, &mc_devices) {
                mci = list_entry(item, struct mem_ctl_info, link);
                if (mci->mc_idx == idx)
                        goto unlock;
        }

        mci = NULL;

unlock:
        mutex_unlock(&mem_ctls_mutex);
        return mci;
---

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
