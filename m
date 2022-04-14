Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C01500966
	for <lists+linux-edac@lfdr.de>; Thu, 14 Apr 2022 11:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241563AbiDNJNy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Apr 2022 05:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241773AbiDNJNf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 14 Apr 2022 05:13:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F054664B;
        Thu, 14 Apr 2022 02:11:07 -0700 (PDT)
Received: from zn.tnic (p2e55d808.dip0.t-ipconnect.de [46.85.216.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 612781EC05DE;
        Thu, 14 Apr 2022 11:11:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649927461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MTWF2aCmdBq52GRNGDvzlxxUlrpYNeatGNZz2SMPX80=;
        b=DNT12Fxsa+u2m0hR6MGCN+S65o16yu8pNWTXfFy/CSOFTjntgmvV9FmXEvC8ein49u2XCQ
        xDQSfyoNtj/TXcAzBDM1qaFHvMTr3tX9rtOFx/TFonxyQlpSlaj5bFXW/aW4IUlLJQBqEF
        ZBlr4OE/98v9sWV/JSdK0wgJoWBfa9k=
Date:   Thu, 14 Apr 2022 11:11:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v5 2/2] x86/mce: Add support for Extended Physical
 Address MCA changes
Message-ID: <YlflJfyQR/j/eRkn@zn.tnic>
References: <20220412154038.261750-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220412154038.261750-3-Smita.KoralahalliChannabasappa@amd.com>
 <YlakNe012hhErszh@zn.tnic>
 <YlbZ1k1cT1FVJj4W@yaz-ubuntu>
 <YlbkCK9LU2KdXZUG@zn.tnic>
 <YlbzbZO6AvxOqQb/@agluck-desk3.sc.intel.com>
 <Ylb3/4oi6KAjdsJW@zn.tnic>
 <YlcnN2q9ducdvsUZ@yaz-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YlcnN2q9ducdvsUZ@yaz-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Apr 13, 2022 at 07:40:39PM +0000, Yazen Ghannam wrote:
> I think the init logic breaks here. MCE now gets enabled before clearing old
> errors. So it's possible that the old errors get overwritten by new ones.

Err, I don't understand. CR4.MCE bit description has:

"Regardless of whether machine-check exceptions are enabled, the
processor records enabled-errors when they occur."

I'm guessing enabled errors are those for which the respective bits in
the MCi_CTL banks are set. And I think the CPU comes out of reset with
those bits set.

So the overwriting will happen regardless.

The only difference here is that "[s]etting MCE to 1 enables the
machine-check exception mechanism." So you'll get a #MC raised vs
shutdown on a fatal error.

Or am I missing an angle?

> > @@ -1791,6 +1761,9 @@ static void __mcheck_cpu_check_banks(void)
> >  		if (!b->init)
> >  			continue;
> >  
> > +		wrmsrl(mca_msr_reg(i, MCA_CTL), b->ctl);
> > +		wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
> 
> Same idea here. STATUS should be cleared before turning on reporting in a bank
> using MCA_CTL.

Look at the current code. Called in this order:

__mcheck_cpu_init_clear_banks:
        wrmsrl(mca_msr_reg(i, MCA_CTL), b->ctl);
        wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
__mcheck_cpu_check_banks
	rdmsrl(mca_msr_reg(i, MCA_CTL), msrval);
        b->init = !!msrval;

STATUS *is* cleared after MCA_CTL now too.

If this ordering is wrong - and it sounds like it is - then this needs
to be a separate patch and Cc: <stable@vger.kernel.org> and needs to go
in now.

> One downside though is that the system goes longer with CR4.MCE cleared. So
> there's greater risk of encountering a shutdown due to a machine check error.

Yeah, I don't think the couple of msecs matter.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
