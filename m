Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FFD500896
	for <lists+linux-edac@lfdr.de>; Thu, 14 Apr 2022 10:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiDNIpG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Apr 2022 04:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241076AbiDNIpC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 14 Apr 2022 04:45:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5862865815;
        Thu, 14 Apr 2022 01:42:38 -0700 (PDT)
Received: from zn.tnic (p2e55d808.dip0.t-ipconnect.de [46.85.216.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A24041EC059E;
        Thu, 14 Apr 2022 10:42:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649925752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iMtDxFcYv+APnoa3Wtnursj/Bjt7HnoJKgSy8sOg09k=;
        b=iWEpQoD6e+RGn4KnAod0Tzo8cY5o3l2637By3+nm3vVOVZ5BY9D5nnZrUh6hPapCXhvcXr
        eUTHY8CzY7ADMIUU+nsOTU8lOLLFc6byoo/xHbcvJ4S0fK++JJnJ9tRkK0E0P05qfvHxCW
        oOHbjiGznE0bwTVRnnjat96iG1WyQpY=
Date:   Thu, 14 Apr 2022 10:42:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Medad Young <medadyoung@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     rric@kernel.org, James Morse <james.morse@arm.com>,
        tony.luck@intel.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING <KFTING@nuvoton.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>, ctcchien@nuvoton.com,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] EDAC: nuvoton: Add NPCM memory controller driver
Message-ID: <YlfeXVSkUC2B4xH2@zn.tnic>
References: <20220322030152.19018-1-ctcchien@nuvoton.com>
 <20220322030152.19018-4-ctcchien@nuvoton.com>
 <a06441fc-85cf-9386-e362-4a90e855aa19@molgen.mpg.de>
 <CAHpyw9fQVbS1Cpv0ULQc2=vK8LsG6n7tgP+J9AboUupDAPT27Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHpyw9fQVbS1Cpv0ULQc2=vK8LsG6n7tgP+J9AboUupDAPT27Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Apr 14, 2022 at 09:55:05AM +0800, Medad Young wrote:
> > > +                             if (mtype == MEM_TYPE_DDR4)
> > > +                                     dimm->mtype = MEM_DDR4;
> > > +                             else
> > > +                                     dimm->mtype = MEM_EMPTY;
> >
> > Use ternary operator?
> >
> >      dimm-mtype = (mtype == MEM_TYPE_DDR4) ? MEM_DDR4 : MEM_EMPTY;

Ternary operator is less readable than a plain and simple if-else.

> > > +{
> > > +     struct priv_data *priv = mci->pvt_info;
> > > +     const struct npcm_edac_platform_data *npcm_chip = priv->npcm_chip;
> > > +     u64 err_c_addr = 0x0;
> >
> > size_t
> 
> OK

Why is size_t? error address doesn't have anything to do with a
sizeof(), array indexing or loop counting.

It is an error address and having it in an u64 tells you exactly what
its quantity is.

So can we stop the silliness pls?

> > > +static irqreturn_t edac_ecc_isr(int irq, void *dev_id)
> > > +{
> > > +     struct mem_ctl_info *mci = dev_id;
> > > +     struct priv_data *priv = mci->pvt_info;
> > > +     const struct npcm_edac_platform_data *npcm_chip = priv->npcm_chip;
> > > +     u32 intr_status;
> > > +     u32 val;
> > > +
> > > +     /* Check the intr status and confirm ECC error intr */
> > > +     intr_status = readl(priv->reg + npcm_chip->ecc_ctl_int_status);
> > > +
> > > +     edac_dbg(3, "InterruptStatus : 0x%x\n", intr_status);
> >
> > Remove the space before the colon? Maybe use:
> >
> > "Interrupt status (intr_status): 0x%x\n"

And repeat "interrupt status"? Also silly. The question to ask
yourselves should always be: is this error message helpful enough to its
intended recipients.

When I see

  "Interrupt status (intr_status): 0x%x\n"

in my code, I go: "hm, where does this message come from?" because it
ain't helpful enough. So I have to go stare at the code too.

I hope you're catching my drift.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
