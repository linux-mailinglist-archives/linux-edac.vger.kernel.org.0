Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB63E4FFFE4
	for <lists+linux-edac@lfdr.de>; Wed, 13 Apr 2022 22:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbiDMUWk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Apr 2022 16:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238582AbiDMUW0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 13 Apr 2022 16:22:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DF540E7C;
        Wed, 13 Apr 2022 13:20:03 -0700 (PDT)
Received: from zn.tnic (p2e55d808.dip0.t-ipconnect.de [46.85.216.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 57C251EC0373;
        Wed, 13 Apr 2022 22:19:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649881198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ICNrImL3BPHaV9p9X4ItFKOFVwiO7Iw4dxLsgdv2I4k=;
        b=ROxUbYrJ+NJijs7vAKnog2D7vsTno17HTR9C9/66sCiW2LmVhkJeGPUe3BSeXKPCnAvCst
        1ttjSALKGrneAHtO/UlckkCrW1+YBEd1XE1d3hGDaof9YJQ2TcN1NMxtZCNOA8PAWimLXP
        jN0j778G+UODDLv6bm/yxz3qxBO2v2c=
Date:   Wed, 13 Apr 2022 22:19:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v4 1/2] x86/mce: Check for writes ignored in MCA_STATUS
 register
Message-ID: <YlcwbuOZ2qaPLPR5@zn.tnic>
References: <20220214233640.70510-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220214233640.70510-2-Smita.KoralahalliChannabasappa@amd.com>
 <Yk267A1MKOo2AlXQ@zn.tnic>
 <2c4c2359-f662-cd5d-e9ab-da5c71ca7dc9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c4c2359-f662-cd5d-e9ab-da5c71ca7dc9@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Apr 13, 2022 at 12:16:26PM -0700, Smita Koralahalli wrote:
> > diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
> > index 4ae0e603f7fa..7e03f5b7f6bd 100644
> > --- a/arch/x86/kernel/cpu/mce/internal.h
> > +++ b/arch/x86/kernel/cpu/mce/internal.h
> > @@ -211,7 +211,7 @@ noinstr u64 mce_rdmsrl(u32 msr);
> >   static __always_inline u32 mca_msr_reg(int bank, enum mca_msr reg)
> >   {
> > -	if (mce_flags.smca) {
> > +	if (cpu_feature_enabled(X86_FEATURE_SMCA)) {
> Should this change be part of this patch series? Also, why mce_flags.smca
> check won't work?

Because you'd need to export it to modules and mca_flags is not
something I'd want to export to anything.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
