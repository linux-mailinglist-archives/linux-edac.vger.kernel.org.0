Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D5E1C460F
	for <lists+linux-edac@lfdr.de>; Mon,  4 May 2020 20:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgEDShX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 4 May 2020 14:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726111AbgEDShX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 4 May 2020 14:37:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CDEC061A0F;
        Mon,  4 May 2020 11:37:23 -0700 (PDT)
Received: from zn.tnic (p200300EC2F08AF0065FB624DCF4BA4D3.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:af00:65fb:624d:cf4b:a4d3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EC3E21EC02CA;
        Mon,  4 May 2020 20:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588617440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YuW8tb+waz9pfSvMfWhFe9y4ge3JyCySIqtRfEA1Ev8=;
        b=Loxg7qHfyNd5NlctbHdWyRlUKhl4uMV33Gqbnl6jLD+pV37pY/Z3s97vOjSG0DrJZcSrWC
        NZZZdI5FefhNTVMEdziALRtWLraKpwHiXKxQSxNrujV9olY0U5AxQM58uFSr0koaRfmiyx
        xXfDo1hym6MHekNpykIm/9pXyWJlkps=
Date:   Mon, 4 May 2020 20:37:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Shenhar, Talel" <talel@amazon.com>
Cc:     mchehab@kernel.org, james.morse@arm.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will@kernel.org, linux-edac@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, hhhawa@amazon.com, ronenk@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, eitan@amazon.com
Subject: Re: [PATCH v6 2/2] EDAC: al-mc-edac: Introduce Amazon's Annapurna
 Labs Memory Controller EDAC
Message-ID: <20200504183716.GJ15046@zn.tnic>
References: <20200224134132.23924-1-talel@amazon.com>
 <20200224134132.23924-3-talel@amazon.com>
 <20200428113950.GB11272@zn.tnic>
 <46ccdb47-f28d-63f7-e759-1ba34e98add8@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46ccdb47-f28d-63f7-e759-1ba34e98add8@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 04, 2020 at 01:16:10PM +0300, Shenhar, Talel wrote:
> > > +     mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
> > > +                         sizeof(struct al_mc_edac));
> > You can let that line stick out.
> 
> I rather avoid having this as a checkpatch warnning... (automation and
> stuff...)

checkpatch.pl - while useful - should not be taken to the letter and
human brain should be applied to sanity check it what it warns about.

> This line break does seems to my eye as too hard to read.
> 
> Let me know if you feel strongly about it.

I'm just sayin' - in the end of the day you'll be staring at that code -
not me - so whatever *you* prefer. :-)

Just don't follow tools blindly.

> > > +     if (al_mc->irq_ue <= 0 || al_mc->irq_ce <= 0)
> > Shouldn't this be && here?
> > 
> > I mean, you want to poll when neither of the IRQs can be found. But then
> > if you find one of them and not the other, what do you do? Poll and
> > interrupt? Is that case even possible?
> 
> Correct.
> 
> In case dt defined interrupt line only for one type and not for the other,
> than the interrupt mode shall be used for one of them while polling mode for
> the other.

That warrants a comment above it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
