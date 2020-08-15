Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355D724529F
	for <lists+linux-edac@lfdr.de>; Sat, 15 Aug 2020 23:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgHOVxk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 15 Aug 2020 17:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgHOVwl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 15 Aug 2020 17:52:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ED9C061236;
        Fri, 14 Aug 2020 22:51:41 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1c7a000c615dc96c916289.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:7a00:c61:5dc9:6c91:6289])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3913C1EC03EA;
        Sat, 15 Aug 2020 07:51:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597470696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UaHC+XYpOhT7alhor59jrB5xm8LzwHIuR+784j8TeOo=;
        b=jYVoD/vXSYH5s+EEyEAMfZb6pLrBYCJgMbqCrB0uJ65Qhfoz03nttKbJ7T9Gzfz8CnU0GK
        NFnKRYyadWH2wJv80ai0YnrNPPcJcRsHFR5N5KNbyLLDIgti6eydnCzykC9iJNm9fHcVTp
        VeKJKSP2XhHU+bhSlNEy6oeJFealQT4=
Date:   Sat, 15 Aug 2020 07:52:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     tony.luck@intel.com, qiuxu.zhuo@intel.com, mchehab@kernel.org,
        james.morse@arm.com, rrichter@marvell.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: EDAC-SBRIDGE
Message-ID: <20200815055227.GA25814@zn.tnic>
References: <20200708113546.14135-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200708113546.14135-1-grandmaster@al2klimov.de>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jul 08, 2020 at 01:35:46PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
> 
>  drivers/edac/sb_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
> index d414698ca324..a6704e73fcce 100644
> --- a/drivers/edac/sb_edac.c
> +++ b/drivers/edac/sb_edac.c
> @@ -3552,6 +3552,6 @@ MODULE_PARM_DESC(edac_op_state, "EDAC Error Reporting state: 0=Poll,1=NMI");
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Mauro Carvalho Chehab");
> -MODULE_AUTHOR("Red Hat Inc. (http://www.redhat.com)");
> +MODULE_AUTHOR("Red Hat Inc. (https://www.redhat.com)");
>  MODULE_DESCRIPTION("MC Driver for Intel Sandy Bridge and Ivy Bridge memory controllers - "
>  		   SBRIDGE_REVISION);
> -- 

Merged all your EDAC patches into one and applied. Will push out once
-rc1 releases.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
