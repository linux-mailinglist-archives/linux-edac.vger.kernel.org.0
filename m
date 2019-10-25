Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E73DE4C7D
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2019 15:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504836AbfJYNmE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 25 Oct 2019 09:42:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47344 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504824AbfJYNmE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 25 Oct 2019 09:42:04 -0400
Received: from zn.tnic (p200300EC2F0D3C00E44239D1C9BE3FA7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:3c00:e442:39d1:c9be:3fa7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A81211EC0CE5;
        Fri, 25 Oct 2019 15:41:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1572010918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sv5dF6qflHr5ZwIn8QIRu82I7QMFKoEE4TlrSi1RwOQ=;
        b=meVJ1grCo8aqtBibAed2PwgSaUG7POqonCWl4A+Rymf5qJjd0nRfGqbLEv3HixcqWwZRfL
        sJz16lZWDW3XrAWDR4vvIAYjOnGQYV5+KBfqAEaSB+mhabwM0Yy3txUIJkVmqzSBvrBrl/
        9L+2/qqafQz0TzdNWt5H8DJXVdUHVMA=
Date:   Fri, 25 Oct 2019 15:41:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] EDAC/amd64: Set grain per DIMM
Message-ID: <20191025134158.GB6483@zn.tnic>
References: <20191022203448.13962-1-Yazen.Ghannam@amd.com>
 <20191022203448.13962-7-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191022203448.13962-7-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Oct 22, 2019 at 08:35:14PM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> The following commit introduced a warning on error reports without a
> non-zero grain value.
> 
>   3724ace582d9 ("EDAC/mc: Fix grain_bits calculation")
> 
> The amd64_edac_mod module does not provide a value, so the warning will
> be given on the first reported memory error.
> 
> Set the grain per DIMM to cacheline size (64 bytes). This is the current
> recommendation.
> 
> Fixes: 3724ace582d9 ("EDAC/mc: Fix grain_bits calculation")
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20191018153114.39378-7-Yazen.Ghannam@amd.com
> 
> v1 -> v2:
> * No change.
> 
> rfc -> v1:
> * New patch.
> 
>  drivers/edac/amd64_edac.c | 2 ++
>  1 file changed, 2 insertions(+)

This one I can take now. Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
