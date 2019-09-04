Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6287AA9597
	for <lists+linux-edac@lfdr.de>; Wed,  4 Sep 2019 23:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfIDVxT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Sep 2019 17:53:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45040 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbfIDVxS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 4 Sep 2019 17:53:18 -0400
Received: from zn.tnic (p200300EC2F0A230094A48B587AEA6833.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2300:94a4:8b58:7aea:6833])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8E4DF1EC064F;
        Wed,  4 Sep 2019 23:53:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567633995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qiLDpvHe2s8vsI140Lj91CgR8sCbIvs2AuYLnn6o8BQ=;
        b=psF0mZRpKQwDIE7O124YvVcAh+bQERf6pbtz4hmk1fTVkfNhd38ffr+GmMXYRkuYlUs75Q
        hyEnRzcz3sJafkv9smYytmLxlxRR/fuaC+iA0XWEmoBfvj8DDAJRK+Scl/jvldn5MtySlY
        +dS7Kp6RONNbAbINdPKR6LBZV0IuZYU=
Date:   Wed, 4 Sep 2019 23:53:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     "trivial@kernel.org" <trivial@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] amd64_edac - Add Family 17h Model 70h PCI IDs
Message-ID: <20190904215308.GA12374@zn.tnic>
References: <BN7PR07MB5186DD5732B95B784A9D46BFCEB80@BN7PR07MB5186.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN7PR07MB5186DD5732B95B784A9D46BFCEB80@BN7PR07MB5186.namprd07.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Isaac,

On Wed, Sep 04, 2019 at 09:13:47PM +0000, Isaac Vaughn wrote:
> I noticed the current EDAC driver doesn't support the new Zen 2 (model
> 70h) processors, so I patched the new device ids in. The changes are
> minimal, I merely extended the existing enums with information from
> the new models.

Makes sense to me.

@Yazen, ACK?

> This is my first kernel patch and I'm not sure I followed the guide
> (kernel.org/doc/html/v5.2/process/submitting-patches.html) correctly,
> so please let me know if I need to resubmit this email with updated
> formatting prior to review.

Sure, you're almost there but it needs to have a title and a commit
message. If you need an example, look at how a similar patch to yours is
formatted:

6e846239e548 ("EDAC/amd64: Add Family 17h Model 30h PCI IDs")

Here's a web URL too in case you don't know how to work the git thing :)

https://git.kernel.org/linus/6e846239e5487cbb89ac8192d5f11437d010130e

That is, if you want to learn how to do patches at all. Otherwise, I can
fix it up for ya.

Leaving in the rest for Yazen.

> Signed-off-by: Isaac Vaughn <isaac.vaughn@knights.ucf.edu>
> ---
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 873437be86d9..a35c97f9100a 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -2253,6 +2253,15 @@ static struct amd64_family_type family_types[] = {
>                         .dbam_to_cs             = f17_base_addr_to_cs_size,
>                 }
>         },
> + [F17_M70H_CPUS] = {
> +         .ctl_name = F17h_M70h,
> +         .f0_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F0,
> +         .f6_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F6,
> +         .ops = {
> +                 .early_channel_count        = f17_early_channel_count,
> +                 .dbam_to_cs         = f17_base_addr_to_cs_size,
> +         }
> + },

You need to fix the tabbing here to look like the other struct
assignments above.

>  };
>  
>  /*
> @@ -3241,6 +3250,10 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
>                         fam_type = &family_types[F17_M30H_CPUS];
>                         pvt->ops = &family_types[F17_M30H_CPUS].ops;
>                         break;
> +         } else if (pvt->model >= 0x70 && pvt->model <= 0x7f) {
> +                 fam_type = &family_types[F17_M70H_CPUS];
> +                 pvt->ops = &family_types[F17_M70H_CPUS].ops;
> +                 break;
>                 }

Here too. Your "else if" needs to have the same indentation as the one above.

>                 /* fall through */
>         case 0x18:
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index 8f66472f7adc..1adf7ddbf744 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -119,6 +119,8 @@
>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F6 0x15ee
>  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F0 0x1490
>  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F6 0x1496
> +#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F0 0x1440
> +#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F6 0x1446
>  
>  /*
>   * Function 1 - Address Map
> @@ -285,6 +287,7 @@ enum amd_families {
>         F17_CPUS,
>         F17_M10H_CPUS,
>         F17_M30H_CPUS,
> + F17_M70H_CPUS,

And that too.

Depending on the text editor, you can show the whitespace characters on each
line and then make sure they're the same as on the lines above it. For example
with vim you do

":set list"

and that would show you:

^I^I} else if (pvt->model >= 0x30 && pvt->model <= 0x3f) {$ 
^I^I^Ifam_type = &family_types[F17_M30H_CPUS];$
^I^I^Ipvt->ops = &family_types[F17_M30H_CPUS].ops;$
^I^I^Ibreak;$
         } else if (pvt->model >= 0x70 && pvt->model <= 0x7f) {$
                 fam_type = &family_types[F17_M70H_CPUS];$
                 pvt->ops = &family_types[F17_M70H_CPUS].ops;$
                 break;$
^I^I}$


and you can immediately see the difference. We use tabs in the kernel,
which appear here as ^I and you have spaces, thus the difference in
indentation.

There's a checker script in the kernel source directory you can use:

$ ./scripts/checkpatch.pl /tmp/isaac.01
WARNING: please, no spaces at the start of a line
#34: FILE: drivers/edac/amd64_edac.c:2256:
+ [F17_M70H_CPUS] = {$

ERROR: code indent should use tabs where possible
#35: FILE: drivers/edac/amd64_edac.c:2257:
+         .ctl_name = F17h_M70h,$

WARNING: please, no spaces at the start of a line
#35: FILE: drivers/edac/amd64_edac.c:2257:
+         .ctl_name = F17h_M70h,$

ERROR: code indent should use tabs where possible
#36: FILE: drivers/edac/amd64_edac.c:2258:
+         .f0_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F0,$

...

which would show you what is wrong with the patch.

And finally, here some more links which you might find useful:

https://www.kernel.org/doc/html/v5.2/process/coding-style.html
https://kernelnewbies.org/

That is, if you want to get involved in doing the patches thing :-)

Thx and have fun!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
