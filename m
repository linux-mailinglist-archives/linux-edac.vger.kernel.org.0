Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7D247603A
	for <lists+linux-edac@lfdr.de>; Wed, 15 Dec 2021 19:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238548AbhLOSHQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Dec 2021 13:07:16 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39094 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238519AbhLOSHQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Dec 2021 13:07:16 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 084E21EC02B9;
        Wed, 15 Dec 2021 19:07:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639591631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ra3WnB05nSWdBwQOHaRFNb+Tj70Io8iaKmQH1Zlg0i4=;
        b=JEmny9mjtyhNvwXaiZ6pAfXEFdQAO+hlYr9oTcqpOG+/vFGHP9fGqr/ZiZ2vNl2K+USCjz
        NucjLJUu0uhYKcMZq+aniootNDs/tctosuF6RXh3dtPPPYcOE3UwxqFmgcerUOILdw99/0
        q2vxsqoevfmU5OpBS6/G0Sapysh/JBI=
Date:   Wed, 15 Dec 2021 19:07:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     William Roche <william.roche@oracle.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 2/2] EDAC/amd64: Add new register offset support and
 related changes
Message-ID: <Ybou1VTJ8oced4Ge@zn.tnic>
References: <20211215155309.2711917-1-yazen.ghannam@amd.com>
 <20211215155309.2711917-3-yazen.ghannam@amd.com>
 <d327bbfe-a3c0-9b26-569d-43e17dba126d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d327bbfe-a3c0-9b26-569d-43e17dba126d@oracle.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Dec 15, 2021 at 05:32:27PM +0100, William Roche wrote:
> > @@ -2174,8 +2215,13 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
> >   	 * There is one mask per DIMM, and two Chip Selects per DIMM.
> >   	 *	CS0 and CS1 -> DIMM0
> >   	 *	CS2 and CS3 -> DIMM1
> > +	 *
> > +	 *	Systems with newer register layout have one mask per Chip Select.
> 
> Just a question about this comment: Can it be translated into this ?
> 
> +	 * Except on systems with newer register layout where we have one Chip Select per DIMM.

Sure, but without the "we":

	...
	* On systems with the newer register layout there is one Chip Select per DIMM.
	*/

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
