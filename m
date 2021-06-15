Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4553A8700
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jun 2021 19:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhFORCh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Jun 2021 13:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhFORCg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Jun 2021 13:02:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D233CC061574;
        Tue, 15 Jun 2021 10:00:31 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f270048ecafc2d258032c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2700:48ec:afc2:d258:32c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 677A71EC030E;
        Tue, 15 Jun 2021 19:00:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623776430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=onzUHvWAib5qjHU1iwKoE0eYbOwKpExBMeNv+Wbsql8=;
        b=CSzaLYB0elLRBCVES5hERQOT+7sq+r/IBg6Pd3T+WKGenvu5ox2CLqsttKJ9Frc5IuAdZ4
        02aFI5DKrQeb+6op5u4Ub5oDHj9NbQIUAoQPFVYq+9me15DeFWmDM3j2m11cq7MUS28cQn
        gRunOGu4JZ3e+F7zeVyJpiGH1DxOhmA=
Date:   Tue, 15 Jun 2021 19:00:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Subject: Re: [PATCH] EDAC/Intel: Do not load EDAC driver when running as a
 guest
Message-ID: <YMjcpCDF1ZIGYinq@zn.tnic>
References: <20210614212129.227698-1-Smita.KoralahalliChannabasappa@amd.com>
 <YMfRxX/M4rJ5gM/R@zn.tnic>
 <16a34b6834f94f139444c2ff172645e9@intel.com>
 <YMhwAZaFr4d1QOGG@zn.tnic>
 <20210615150846.GA409@aus-x-yghannam.amd.com>
 <YMjE2iwRFWVrfzLL@zn.tnic>
 <20210615160009.GA29258@aus-x-yghannam.amd.com>
 <YMjRGFiqp2HNWUrZ@zn.tnic>
 <20210615163221.GA2991@aus-x-yghannam.amd.com>
 <20210615164525.GA1087213@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210615164525.GA1087213@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 15, 2021 at 09:45:25AM -0700, Luck, Tony wrote:
> There's little to no point in loading an EDAC driver running in a guest:
> 1) The CPU model reported by CPUID may not represent actual h/w
> 2) The hypervisor likely does not pass in access to memory controller devices
> 3) Hypervisors generally do not pass corrected error details to guests
> 
> Add a check in each of the Intel EDAC drivers for X86_FEATURE_HYPERVISOR
> and simply return -ENODEV in the init routine.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/edac/i10nm_base.c | 3 +++
>  drivers/edac/pnd2_edac.c  | 3 +++
>  drivers/edac/sb_edac.c    | 3 +++
>  drivers/edac/skx_base.c   | 3 +++
>  4 files changed, 12 insertions(+)

If you insist... I mean, those drivers won't load for other reasons but
sure.

> diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
> index 238a4ad1e526..fa08622ff2a8 100644
> --- a/drivers/edac/i10nm_base.c
> +++ b/drivers/edac/i10nm_base.c
> @@ -278,6 +278,9 @@ static int __init i10nm_init(void)
>  	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
>  		return -EBUSY;
>  
> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))

Can you change that to cpu_feature_enabled() everywhere pls?

We're going to use that single API for checking CPU features from now on
and slowly move away from the others to simplify things.

With that changed you can add:

Acked-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
