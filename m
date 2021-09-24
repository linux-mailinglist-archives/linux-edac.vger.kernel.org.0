Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3AC8416DB9
	for <lists+linux-edac@lfdr.de>; Fri, 24 Sep 2021 10:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244722AbhIXI2U (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 24 Sep 2021 04:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244655AbhIXI2U (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 24 Sep 2021 04:28:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C708FC061574;
        Fri, 24 Sep 2021 01:26:47 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0dd600c2485b7778a62ff5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:d600:c248:5b77:78a6:2ff5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 66E4D1EC0419;
        Fri, 24 Sep 2021 10:26:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632472002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bRlGREeuAoK+lh4KtlKZ9ZDT4cemhOq8FBacRlioAUI=;
        b=GUDvEX9cS6n1r1QzFO8dhq/ojrTmnJTTPEoWo1eFkmMfp0ja9z0Bj5GxycjaO4ENxNlxFw
        AeIV1VQ5yJsoxb/saiyVv129jBVz6xxbsLc6twG56agsBXq8HXXmJTyO8SG1y5e0H9QUzm
        HT6o1s9H1Lv8o8GW0XOt3dG/+2+FelQ=
Date:   Fri, 24 Sep 2021 10:26:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, yazen.ghannam@amd.com
Subject: Re: [PATCH 3/5] x86/mce: Use msr_ops in prepare_msrs()
Message-ID: <YU2LwHEhv0bWj4lS@zn.tnic>
References: <20210915232739.6367-1-Smita.KoralahalliChannabasappa@amd.com>
 <20210915232739.6367-4-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210915232739.6367-4-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 15, 2021 at 06:27:37PM -0500, Smita Koralahalli wrote:
> Replace MCx_{STATUS, ADDR, MISC} macros with msr_ops.
> 
> Also, restructure the code to avoid multiple initializations for MCA
> registers. SMCA machines define a different set of MSRs for MCA registers
> and msr_ops initializes appropriate MSRs for SMCA and legacy processors.
> 
> Initialize MCA_MISC and MCA_SYND registers at the end after initializing
> MCx_{STATUS, DESTAT} which is further explained in the next patch.
> 
> Make msr_ops exportable in order to be accessible from mce-inject module.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c   |  1 +
>  arch/x86/kernel/cpu/mce/inject.c | 27 +++++++++++++--------------
>  2 files changed, 14 insertions(+), 14 deletions(-)

https://git.kernel.org/tip/8121b8f947be0033f567619be204639a50cad298

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
