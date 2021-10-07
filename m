Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275A5425195
	for <lists+linux-edac@lfdr.de>; Thu,  7 Oct 2021 12:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhJGK7m (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 Oct 2021 06:59:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43152 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232418AbhJGK7m (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 7 Oct 2021 06:59:42 -0400
Received: from zn.tnic (p200300ec2f0cc9001cdbae1e4e88a0d5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c900:1cdb:ae1e:4e88:a0d5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 84DE81EC04BF;
        Thu,  7 Oct 2021 12:57:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633604267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=n2EzrSXyJXy4xBzeKLs8hZc3s5Q+reOgF2SKerQIEfs=;
        b=eDgX7rfOeF2rdIHNGVX2rT9jQXah3wX+ZwEbCG3apyTI5BFxxIrNX5NvL7U61TxyfyHpaF
        eqiPf1eFTmfEtfKpOyR8hQSMUmxmbNiUbOJQzjk7Lerbvq9FoRSIsQuIOGaf2b6bbKqDPc
        Xsf3kUGFMI0RVLBJIYBSB6VYDiaOROU=
Date:   Thu, 7 Oct 2021 12:57:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH] EDAC/amd64: Handle three rank interleaving mode
Message-ID: <YV7SpRD3b0eRkXcQ@zn.tnic>
References: <20211005154419.2060504-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211005154419.2060504-1-yazen.ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Oct 05, 2021 at 03:44:19PM +0000, Yazen Ghannam wrote:
> AMD Rome systems and later support interleaving between three identical
> ranks within a channel.
> 
> Check for this mode by counting the number of enabled chip selects and
> comparing their masks. If there are exactly three enabled chip selects
> and their masks are identical, then three rank interleaving is enabled.
> 
> The size of a rank is determined from its mask value. However, three
> rank interleaving doesn't follow the method of swapping an interleave
> bit with the most significant bit. Rather, the interleave bit is flipped
> and the most significant bit remains the same. There is only a single
> interleave bit in this case.
> 
> Account for this when determining the chip select size by keeping the
> most significant bit at its original value and ignoring any zero bits.
> This will return a full bitmask in [MSB:1].
> 
> Fixes: e53a3b267fb0 ("EDAC/amd64: Find Chip Select memory size using Address Mask")
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/edac/amd64_edac.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
