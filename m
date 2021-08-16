Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33A83EDD1A
	for <lists+linux-edac@lfdr.de>; Mon, 16 Aug 2021 20:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhHPSdC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Aug 2021 14:33:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42794 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhHPSdC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 16 Aug 2021 14:33:02 -0400
Received: from zn.tnic (p200300ec2f08b5001959acf655f190dc.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:b500:1959:acf6:55f1:90dc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E2281EC0532;
        Mon, 16 Aug 2021 20:32:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629138745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ARclN6i8lJWAR8it0q9cJ4KTgeJ1amJtAnp2oSSWv/k=;
        b=cWOKXdNYXNxJXgUO7tlnHCqaYtMjyBZ4Ig0JUOaA/koQkCQWPhXSjgkPYyMppaVXCJ3H7u
        N9Al/P/5jVZWLM8z3JyQFW6BDyTSqAjOTE9VWDLmP5tAkgjYjauIpxMOMuccqF/RWpvRRX
        57uZXFGUvdU2Vc+PtyAN5CdN+PvVsww=
Date:   Mon, 16 Aug 2021 20:33:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] EDAC, altera: skip defining unused structures for
 specific configs
Message-ID: <YRqvXy1/cs8A5lnv@zn.tnic>
References: <20210601092704.203555-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210601092704.203555-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 01, 2021 at 11:27:04AM +0200, Krzysztof Kozlowski wrote:
> The Altera EDAC driver has several features conditionally built
> depending on Kconfig options.  The edac_device_prv_data structures are
> conditionally used in of_device_id tables.  They reference other
> functions and structures which can be defined as __maybe_unused.  This
> silences build warnings like:
> 
>     drivers/edac/altera_edac.c:643:37: warning:
>         ‘altr_edac_device_inject_fops’ defined but not used [-Wunused-const-variable=]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/edac/altera_edac.c | 44 ++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 18 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
