Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C17C3A2ADC
	for <lists+linux-edac@lfdr.de>; Thu, 10 Jun 2021 13:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhFJL5v (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Jun 2021 07:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFJL5u (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Jun 2021 07:57:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D3CC061574;
        Thu, 10 Jun 2021 04:55:54 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0cf600e70433578266b34c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:f600:e704:3357:8266:b34c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B0BF01EC0493;
        Thu, 10 Jun 2021 13:55:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623326152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/OkYzBblS5E80gbut5AjIVLNBezP0yfMo4EhaUphYzk=;
        b=Fr1L5iVb1Zf1mpwfXQeto2+0vBXCdpABE6OxACL9kMxpiBXNWZGBcDJoS7fFN4vPyZOHV0
        raJJFa1vp+t0o5K2+Y3b/d5kQ3zLz7FrEZnGw7KNTPooGxB08UvPGvNYcwP5stowzTlM+1
        evUtk64+j+1mZxVwknoj5QNuJHw20lw=
Date:   Thu, 10 Jun 2021 13:55:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Akshay Gupta <Akshay.Gupta@amd.com>,
        Youquan Song <youquan.song@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/2] x86/mce: Add support for Extended Physical Address
 MCA changes
Message-ID: <YMH9wqUnjudiAVlr@zn.tnic>
References: <20210608221012.223696-1-Smita.KoralahalliChannabasappa@amd.com>
 <20210608221012.223696-3-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210608221012.223696-3-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 08, 2021 at 05:10:12PM -0500, Smita Koralahalli wrote:
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index f71435e53cdb..480a497877e2 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -204,6 +204,12 @@ EXPORT_SYMBOL_GPL(smca_banks);
>  #define MAX_MCATYPE_NAME_LEN	30
>  static char buf_mcatype[MAX_MCATYPE_NAME_LEN];
>  
> +struct smca_config {
> +	__u64 lsb_in_status     :  1,
> +	__reserved_0            : 63;
> +};
> +static DEFINE_PER_CPU_READ_MOSTLY(struct smca_config[MAX_NR_BANKS], smca_cfg);

Per CPU and per bank, huh? For a single bit?

Even if we have

static DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);

already?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
