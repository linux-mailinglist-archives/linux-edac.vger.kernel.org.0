Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9203852B480
	for <lists+linux-edac@lfdr.de>; Wed, 18 May 2022 10:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbiERIKR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 May 2022 04:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbiERIKQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 May 2022 04:10:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077BA25EBC;
        Wed, 18 May 2022 01:10:15 -0700 (PDT)
Received: from zn.tnic (p200300ea974657d0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:57d0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 385BC1EC054C;
        Wed, 18 May 2022 10:10:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652861410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OU2r3ndLVLZSWGk/2sjKDH+rpFBxg12x0Rgx+8y4HgM=;
        b=e2FTJ+QaJQ8Ao+EsjaQTEozFWCOYTpSdLqG6Ll38gR7gX0/1ndoQiVGhQkF14aDsSTuSSe
        8DijoeDr+Z3gw9rGRzvDrVuCk5cNfiThrHsOcwq//5JhUp0O/HMfetcRdWrfVIQPWQ4JUC
        8ZiY3AmOMzTa+W4+KlV3XqqFgGaTBGY=
Date:   Wed, 18 May 2022 10:10:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, muralidhara.mk@amd.com,
        naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH 06/18] EDAC/amd64: Add prep_chip_selects() into pvt->ops
Message-ID: <YoSp3cSoAo4SkkfQ@zn.tnic>
References: <20220509145534.44912-1-yazen.ghannam@amd.com>
 <20220509145534.44912-7-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220509145534.44912-7-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 09, 2022 at 02:55:22PM +0000, Yazen Ghannam wrote:
> From: Muralidhara M K <muralidhara.mk@amd.com>
> 
> GPU Nodes will need to set the number of available Chip Selects, i.e.
> Base and Mask values, differently than existing systems. A function
> pointer should be used rather than introduce another branching condition.

Yeah, it looks to me like all that detection logic should be split
eventually. Looking at read_mc_regs(), it has

        if (pvt->umc) {
                __read_mc_regs_df(pvt);

                goto skip;
        }

at the top, then a whole bunch of legacy stuff and then at the skip
label some common stuff...

Another thing you could consider is to have common functionality carved
out into helpers with "common" in the name and then call those from both
UMC and DCT paths. Perhaps that'll help keep the init paths sane. That
is, short of splitting this driver.

We did the splitting for Intel and there we have a common, librarized
code which gets linked into a couple of drivers. You don't have to do
this too - just putting it out there as an alternative.

The per-family function pointers design could be good too, if done
right. The advantage being, you have a single driver for all, yadda
yadda...

> Prepare for this by adding prep_chip_selects() to pvt->ops and set it
> as needed based on currently supported systems.
> 
> Use a "umc" prefix for modern systems, since these use Unified Memory
> Controllers (UMCs).
> 
> Use a "dct" prefix for newly-defined legacy functions, since these
> systems use DRAM Controllers (DCTs).
> 
> Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>

What does Naveen's SOB mean here? Co-developed-by perhaps?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
