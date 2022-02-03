Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0BE4A85D1
	for <lists+linux-edac@lfdr.de>; Thu,  3 Feb 2022 15:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350979AbiBCOJj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Feb 2022 09:09:39 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34426 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243066AbiBCOJi (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Feb 2022 09:09:38 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F0401EC04C1;
        Thu,  3 Feb 2022 15:09:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643897373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=coc9lO9lg0vxKzE3zJP7qZ/jv6rA7rh9wy96xSxsnSo=;
        b=IMG8vWmofGMy55CNhTdTc62MGhpLLTN3dcyEgt12j576BwiS25Ec+FuSmtHHy/Ngu8i0hD
        z332IQrtn+BvZvp42dC07F2/FdWT0u5G0MgnbRFP1Zi94PfmBIyZnhnAUqkzkKj5nwlfj/
        n0PKMdI24C1UOzHLCayT+6BM0hV9CWM=
Date:   Thu, 3 Feb 2022 15:09:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     William Roche <william.roche@oracle.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v4 1/2] EDAC/amd64: Set memory type per DIMM
Message-ID: <YfviHFrzzdapbwDt@zn.tnic>
References: <20220202144307.2678405-1-yazen.ghannam@amd.com>
 <20220202144307.2678405-2-yazen.ghannam@amd.com>
 <a42a7696-0150-6d63-953e-adec19e25d02@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a42a7696-0150-6d63-953e-adec19e25d02@oracle.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Feb 03, 2022 at 02:19:19PM +0100, William Roche wrote:
> As we are moving the dram_type cached date from pvt to umc for family >=
> 0x17, should we also add a small comment for the dram_type field in the
> amd64_pvt structure to indicate that ?

Who would be that comment for? People who are looking at the code, so
that they know which is which?

> Something like that for example:
> 
> @@ -385,7 +385,7 @@
>      /* place to store error injection parameters prior to issue */
>      struct error_injection injection;
> 
> -    /* cache the dram_type */
> +    /* cache the dram_type for family<0x17 */
>      enum mem_type dram_type;
> 
>      struct amd64_umc *umc;    /* UMC registers */
> 
> 
> Just a suggestion.
> The code looks good to me.
> 
> Reviewed-by: William Roche <william.roche@oracle.com>
> 
> W.

Btw, I'd appreciate it if you do not top-post.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
