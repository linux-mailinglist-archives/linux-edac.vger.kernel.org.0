Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70FF4805A2
	for <lists+linux-edac@lfdr.de>; Sat,  3 Aug 2019 12:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388344AbfHCKIt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 3 Aug 2019 06:08:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40076 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388201AbfHCKIt (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 3 Aug 2019 06:08:49 -0400
Received: from zn.tnic (p200300EC2F2082007166E282E47B3C81.dip0.t-ipconnect.de [IPv6:2003:ec:2f20:8200:7166:e282:e47b:3c81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 56E051EC04CD;
        Sat,  3 Aug 2019 12:08:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1564826927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ddSwU1R0yyWs4XLmHgJ7K3+4ljBdUQ98umBmarQFLs4=;
        b=LCcVlSoBqaYKny0xghcwy9UF6y6M0s4KR8hU2qjqQkMh+K6LIsaGqJTV9ShwmhzAXI7Uf2
        46Lq+A7s/WS11dOR2++HqtP5DOByN18wVirV5065sGhWrw4QPXgMzVm1cMd8E26zl+IX62
        JuVVv/1qxufQ9k/oszkz6gGgcT2yfKA=
Date:   Sat, 3 Aug 2019 12:08:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/24] EDAC, mc: Fix grain_bits calculation
Message-ID: <20190803100837.GB2100@zn.tnic>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-2-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190624150758.6695-2-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 24, 2019 at 03:08:55PM +0000, Robert Richter wrote:
> The grain in edac is defined as "minimum granularity for an error
> report, in bytes". The following calculation of the grain_bits in
> edac_mc is wrong:
> 
> 	grain_bits = fls_long(e->grain) + 1;
> 
> Where grain_bits is defined as:
> 
> 	grain = 1 << grain_bits
> 
> Example:
> 
> 	grain = 8	# 64 bit (8 bytes)
> 	grain_bits = fls_long(8) + 1
> 	grain_bits = 4 + 1 = 5
> 
> 	grain = 1 << grain_bits
> 	grain = 1 << 5 = 32
> 
> Replacing it with the correct calculation:
> 
> 	grain_bits = fls_long(e->grain - 1);
> 
> The example gives now:
> 
> 	grain_bits = fls_long(8 - 1)
> 	grain_bits = fls_long(8 - 1)
> 	grain_bits = 3
> 
> 	grain = 1 << 3 = 8
> 
> Note: We need to check if the hardware reports a reasonable grain != 0
> and fallback with a warn_once and 1 byte granularity otherwise.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/edac_mc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Applied to the new EDAC repo:

https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/log/?h=edac-for-next

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
