Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E881B9A6E
	for <lists+linux-edac@lfdr.de>; Mon, 27 Apr 2020 10:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgD0Ik0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Apr 2020 04:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgD0Ik0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Apr 2020 04:40:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F1CC061A0F
        for <linux-edac@vger.kernel.org>; Mon, 27 Apr 2020 01:40:26 -0700 (PDT)
Received: from zn.tnic (p200300EC2F05F0006DE2BE28B1B44CEA.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:f000:6de2:be28:b1b4:4cea])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 86C471EC0CE4;
        Mon, 27 Apr 2020 10:40:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587976824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=66efl9yGA8XtPqDJO2F+a3izSW8JNNXA5G5BmNxgQBw=;
        b=RNz1ZNapvcwsAPt3SDRTPfX/o8vTdxRxm6oLf5nhx5n/FMYZ8pB9sNwLkaHZjvnOMZqu8N
        K6vGFk4PaJYnOk05LCOmcSwWKzqqY5yTRmeidfbTrEPgJ5wx+MBqMEPOM43Wpsd5mCakeV
        uOiBnIKPWQCe3gi37aMhedCo3llm8EE=
Date:   Mon, 27 Apr 2020 10:40:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Jerry Chen <jerry.t.chen@intel.com>,
        Jin Wen <wen.jin@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 2/2] EDAC, i10nm: Fix i10nm_edac loading failure on some
 servers
Message-ID: <20200427084022.GC11036@zn.tnic>
References: <20200424185738.7985-1-tony.luck@intel.com>
 <20200424185738.7985-3-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200424185738.7985-3-tony.luck@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Apr 24, 2020 at 11:57:38AM -0700, Tony Luck wrote:

> Subject: Re: [PATCH 2/2] EDAC, i10nm: Fix i10nm_edac loading failure on some

Please use "EDAC/<driver>:" prefix.

And I guess that patch name should be something like:

EDAC/i10nm: Update driver to support different bus number config register offsets

or so.

> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> It failed to load the i10nm_edac driver on Ice Lake and

"The i10nm_edac driver failed to load ... "

> Tremont/Jacobsville servers if their CPU stepping >= 4 and failed
> on Ice Lake-D servers from stepping 0. The root cause was that for
> Ice Lake and Tremont/Jacobsville servers with CPU stepping >=4, the
> offset for bus number configuration register was updated from 0xcc
> to 0xd0. For Ice Lake-D servers, all the steppings use the updated
> 0xd0 offset.
> 
> Fix the issue by using the appropriate offset for bus number
> configuration register according to the CPU model number and stepping.
> 
> Reported-by: Jerry Chen <jerry.t.chen@intel.com>
> Reported-and-tested-by: Jin Wen <wen.jin@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/edac/i10nm_base.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
> index ba4578c6ef2b..ebb45738c11b 100644
> --- a/drivers/edac/i10nm_base.c
> +++ b/drivers/edac/i10nm_base.c
> @@ -122,16 +122,24 @@ static int i10nm_get_all_munits(void)
>  	return 0;
>  }
>  
> -static struct res_config i10nm_cfg = {
> +/* ATOM_TREMONT_D, ICELAKE_X */

That comment...

> +static struct res_config i10nm_cfg0 = {
>  	.type			= I10NM,
>  	.decs_did		= 0x3452,
>  	.busno_cfg_offset	= 0xcc,
>  };
>  
> +/* ICELAKE_D */

... and that one are kinda redundant...

> +static struct res_config i10nm_cfg1 = {
> +	.type			= I10NM,
> +	.decs_did		= 0x3452,
> +	.busno_cfg_offset	= 0xd0,
> +};
> +
>  static const struct x86_cpu_id i10nm_cpuids[] = {
> -	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&i10nm_cfg),
> -	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&i10nm_cfg),
> -	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&i10nm_cfg),
> +	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&i10nm_cfg0),
> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&i10nm_cfg0),
> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&i10nm_cfg1),

... since it is written here what what is.

Anyway, just nitpicks. Other than that:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
