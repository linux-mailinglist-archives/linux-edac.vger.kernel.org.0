Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA07F188D8C
	for <lists+linux-edac@lfdr.de>; Tue, 17 Mar 2020 20:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgCQTAC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Mar 2020 15:00:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48480 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbgCQTAC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 17 Mar 2020 15:00:02 -0400
Received: from zn.tnic (p200300EC2F0C9600CC3F43717CD69565.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9600:cc3f:4371:7cd6:9565])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C7C851EC0CB7;
        Tue, 17 Mar 2020 20:00:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584471600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rFjWP0jl0xFey1uld0x2PAnKPSj/hKrbOPXfWXU/V74=;
        b=gTsMhcq5KKLkSkrc+45z3w1yW7fnyBgViytUcqGVFyCyBVecCQFcmYz37QetYGJ3S3CRVs
        gVZA3WS0DnDzA0SuCm9/oLq0QliaUIG3z3IFAa3I/T44QKlCu2nsDxpohZKRFoAR1xAigp
        DNP9G5n0mz8ncFsBINX+cn52WHCz1q8=
Date:   Tue, 17 Mar 2020 20:00:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jan Luebbe <jlu@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH] EDAC: armada_xp: Use scnprintf() for avoiding potential
 buffer overflow
Message-ID: <20200317190003.GF15609@zn.tnic>
References: <20200311071728.4541-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200311071728.4541-1-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Mar 11, 2020 at 08:17:28AM +0100, Takashi Iwai wrote:
> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/edac/armada_xp_edac.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
