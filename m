Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 506CB46208
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2019 17:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfFNPGU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Jun 2019 11:06:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53376 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfFNPGU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 14 Jun 2019 11:06:20 -0400
Received: from zn.tnic (p200300EC2F097F0010F3CEDA9C41B474.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:7f00:10f3:ceda:9c41:b474])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DEEDD1EC0ABC;
        Fri, 14 Jun 2019 17:06:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560524779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=s3JxxK1hTnx3MIWvd9+Zz2HzZPMAKlAH0erCHkhw4H0=;
        b=DZP8kgHuksAzz5OdaaJlljSgDWu+adeLb/X2PQEBVHa2wTOH/OhWWgBw59i6Nod1yzmG0a
        co08TWz7/vWq4pCSpzkcaTdyhC4RAZIJbOlCbMkfAifhxF7JS2iuRQ8ffAXZaY3aTBgKJq
        lGEAFuYbYmb5sGCprfbkzhuQA1KoJoc=
Date:   Fri, 14 Jun 2019 17:06:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH] EDAC, ghes: Fix grain calculation
Message-ID: <20190614150615.GL2586@zn.tnic>
References: <20190529152232.187580-1-james.morse@arm.com>
 <20190612043410.GE32652@zn.tnic>
 <9bda9613-09b3-aa6d-183f-3668ef9a99c6@arm.com>
 <20190613191843.GG11598@zn.tnic>
 <20190613210731.mehosgbqn2yak4ut@rric.localdomain>
 <20190613224130.GI11598@zn.tnic>
 <20190614072139.vzet6t5erl6uz6st@rric.localdomain>
 <20190614100918.GA2586@zn.tnic>
 <20190614143932.cacobehkuw62frzx@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190614143932.cacobehkuw62frzx@rric.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jun 14, 2019 at 02:40:01PM +0000, Robert Richter wrote:
> No, as you grepped below, the granularity is the number of bytes, and
> mostly power of 2. Also note that fls(0xfff) is 12 and fls(0x1000) is
> 13 ...

Yeah, so?!

You want it to be 12 to have a 4K grain.

So this takes too long over mail - find me on IRC and we can figure it
out.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
