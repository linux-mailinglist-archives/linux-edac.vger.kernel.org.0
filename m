Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CB637AD24
	for <lists+linux-edac@lfdr.de>; Tue, 11 May 2021 19:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhEKRf4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 May 2021 13:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKRf4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 11 May 2021 13:35:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721D0C061574;
        Tue, 11 May 2021 10:34:49 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ec70091f309bcd5e4258d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:c700:91f3:9bc:d5e4:258d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E18211EC0301;
        Tue, 11 May 2021 19:34:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620754488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3/bXis5NaA7RX5+1HMGPhmVKaplL2A5rrRK2DTP1lwk=;
        b=acI2tZYyZobSwgFD1A6t5aJoJZjOjElQRSIFuMg2eSFVnRHruARSwVF+2BoJG4/vCLPcnb
        mmCjt8Jf0uouuT0ycqg+uTyb6E4/CGSCh0ofKvGRtZmNi3fagNnbTrTE/VUpDJfEQJWlAh
        ksJCPJKrHLmuOYoWSNj3NmOC0u9ltHU=
Date:   Tue, 11 May 2021 19:34:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        Mukul Joshi <mukul.joshi@amd.com>
Subject: Re: [PATCH 2/3] x86/MCE/AMD: Helper function to check UMC v2
Message-ID: <YJrAOXEcyUvs/WvY@zn.tnic>
References: <20210511152538.148084-1-nchatrad@amd.com>
 <20210511152538.148084-2-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210511152538.148084-2-nchatrad@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 11, 2021 at 08:55:37PM +0530, Naveen Krishna Chatradhi wrote:

> Subject: Re: [PATCH 2/3] x86/MCE/AMD: Helper function to check UMC v2

The condensed patch description in the subject line should start with a
uppercase letter and should be written in imperative tone:

"x86/MCE/AMD: Add a helper function... "

> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> Reviewed-by: John Clements <John.Clements@amd.com>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

This is all fine and dandy but it needs your SOB too when you send the
patch.

Please read Documentation/process/submitting-patches.rst

sections

Sign your work - the Developer's Certificate of Origin
When to use Acked-by:, Cc:, and Co-developed-by:

> +bool is_smca_umc_v2(int bank)
> +{
> +	return (smca_get_bank_type(bank) == SMCA_UMC_V2);
> +}
> +EXPORT_SYMBOL_GPL(is_smca_umc_v2);

This addition looks useless when it doesn't have any users.

Also, I'm pretty sceptical this even makes sense to have it exported -
I'm guessing this is for mce_amd.c but I can't say without seeing it in
use.

The same remarks hold true for your patch 3.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
