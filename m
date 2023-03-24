Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441876C8556
	for <lists+linux-edac@lfdr.de>; Fri, 24 Mar 2023 19:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCXSt0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 24 Mar 2023 14:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCXStZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 24 Mar 2023 14:49:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC65E2711;
        Fri, 24 Mar 2023 11:49:22 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EEB631EC0716;
        Fri, 24 Mar 2023 19:49:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679683761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iHE7VW3ZBEXfcG3h4LmV2OzWObJqnQ/jtwe77JzyYPc=;
        b=L4iHJtWzRj/rL0b1QAZxNtL3R8diFUp6fZbAATjj+edUOydmgBfUHzhsvEiD2Ew1hX8YlG
        yTzs+zXfGlzCckhmNIEjRopge9pJklZDo8zaBIeR/q3wKEvjCISOvEhtd5WDcTL1/V8CuL
        ud5pbeLwTUKUQgHndIrF/vrZ8m0cYPI=
Date:   Fri, 24 Mar 2023 19:49:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Subject: Re: [PATCH v3 2/2] edac: xilinx: Added EDAC support for Xilinx DDR
 controller
Message-ID: <20230324184916.GGZB3wrKiQEpOtJI75@fat_crate.local>
References: <20230117054100.8377-1-shubhrajyoti.datta@amd.com>
 <20230117054100.8377-3-shubhrajyoti.datta@amd.com>
 <Y9bu8CpiVKvFS1d+@zn.tnic>
 <BY5PR12MB490209C639C9ADD9FB67F75D81B29@BY5PR12MB4902.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BY5PR12MB490209C639C9ADD9FB67F75D81B29@BY5PR12MB4902.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Mar 02, 2023 at 05:24:16AM +0000, Datta, Shubhrajyoti wrote:
> > > +
> > > +#define PCSR_UNLOCK_VAL                              0xF9E8D7C6
> > > +#define XDDR_ERR_TYPE_CE                     0
> > > +#define XDDR_ERR_TYPE_UE                     1
> > > +
> > > +#define XILINX_DRAM_SIZE_4G                  0
> > > +#define XILINX_DRAM_SIZE_6G                  1
> > > +#define XILINX_DRAM_SIZE_8G                  2
> > > +#define XILINX_DRAM_SIZE_12G                 3
> > > +#define XILINX_DRAM_SIZE_16G                 4
> > > +#define XILINX_DRAM_SIZE_32G                 5
> > 
> > Oh wow, that's a *lot* of defines!
> > 
> > How about unifying them?
> > 
> > All those rank masks look the same.
> I did not understand the comment. Could you please clarify.
> The size difference is not uniform so a offset jump strategy may not work.

$ grep -E "GENMASK\(5, 0\)" drivers/edac/xilinx_ddrmc_edac.c
#define RANK_0_MASK                             GENMASK(5, 0)
#define ROW_0_MASK                              GENMASK(5, 0)
#define ROW_5_MASK                              GENMASK(5, 0)
#define ROW_10_MASK                             GENMASK(5, 0)
#define ROW_15_MASK                             GENMASK(5, 0)
#define COL_1_MASK                              GENMASK(5, 0)
#define COL_6_MASK                              GENMASK(5, 0)
#define BANK_1_MASK                             GENMASK(5, 0)

Ditto for the other ones.

Can't you use a single

#define MASK_0					GENMASK(5, 0)

and then use MASK_0 everywhere?

And the same for the other ones?

Better yet, you can define a function which does that repeated block:

        priv->row_bit[0] = regval & ROW_0_MASK;
        priv->row_bit[1] = (regval & ROW_1_MASK) >> ROW_1_SHIFT;
        priv->row_bit[2] = (regval & ROW_2_MASK) >> ROW_2_SHIFT;
        priv->row_bit[3] = (regval & ROW_3_MASK) >> ROW_3_SHIFT;
        priv->row_bit[4] = (regval & ROW_4_MASK) >> ROW_4_SHIFT;

in one:

static inline void process_bit(priv, unsigned int start, ... regval)
{
	priv->row_bit[start]	 =  regval & MASK_0;
	priv->row_bit[start + 1] = (regval & MASK_1) >> ROW_1_SHIFT;
	...
}

and then you don't have to define the same masks for every 5 bits but
have the function do it for ya, for each group of 5 bits?


> 
> <snip>
> > > +     ulong err_addr = 0;
> > > +     u32 index;
> > > +
> > > +     for (index = 0; index < XDDR_MAX_ROW_CNT; index++) {
> > > +             err_addr |= (pinf.row & BIT(0)) << priv->row_bit[index];
> > > +             pinf.row >>= 1;
> > > +     }
> > > +
> > > +     for (index = 0; index < XDDR_MAX_COL_CNT; index++) {
> > > +             err_addr |= (pinf.col & BIT(0)) << priv->col_bit[index];
> > > +             pinf.col >>= 1;
> > > +     }
> > > +
> > > +     for (index = 0; index < XDDR_MAX_BANK_CNT; index++) {
> > > +             err_addr |= (pinf.bank & BIT(0)) << priv->bank_bit[index];
> > > +             pinf.bank >>= 1;
> > > +     }
> > > +
> > > +     for (index = 0; index < XDDR_MAX_GRP_CNT; index++) {
> > > +             err_addr |= (pinf.group & BIT(0)) << priv->grp_bit[index];
> > > +             pinf.group >>= 1;
> > > +     }
> > > +
> > > +     for (index = 0; index < XDDR_MAX_RANK_CNT; index++) {
> > > +             err_addr |= (pinf.rank & BIT(0)) << priv->rank_bit[index];
> > > +             pinf.rank >>= 1;
> > > +     }
> > > +
> > > +     for (index = 0; index < XDDR_MAX_LRANK_CNT; index++) {
> > > +             err_addr |= (pinf.lrank & BIT(0)) << priv->lrank_bit[index];
> > > +             pinf.lrank >>= 1;
> > > +     }
> > 
> > Oh wow, 6 loops!
> > 
> > I'm wondering if you could "unroll" those loops and work on each component
> > with a single mask and such...
> 
> I did not understand this one . The loop are running for different indixes.

Let's take the first one. Isn't what you're doing equivalent to simply:

	err_addr = pinf.row & GENMASK_ULL(0, XDDR_MAX_ROW_CNT);
	err_addr <<= XDDR_MAX_ROW_CNT;

?

You basically stick in the error address each segment one after the
other...

err_addr = [XDDR_MAX_ROW_CNT ... XDDR_MAX_COL_CNT ... XDDR_MAX_BANK_CNT .. ]

and so on?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
