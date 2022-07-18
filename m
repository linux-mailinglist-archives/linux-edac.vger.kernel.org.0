Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76562577E17
	for <lists+linux-edac@lfdr.de>; Mon, 18 Jul 2022 10:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiGRI5c (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 Jul 2022 04:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiGRI5b (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 18 Jul 2022 04:57:31 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFA0AE4F;
        Mon, 18 Jul 2022 01:57:29 -0700 (PDT)
Received: from zn.tnic (p200300ea972976d7329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9729:76d7:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C55491EC01D2;
        Mon, 18 Jul 2022 10:57:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658134643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KnToulisbJA6BpVd9UBUY+fooxnB/K4KAMMR14zTr8c=;
        b=ez+POwu7ywIsv2NpZRT3rLLxydMbE1I/v9wWcVM0P7oSBIQTugDihNQSPYWbfMJkFVJu/V
        m/KeeZ3ctzrg7ysM+szbiNyi3x1P9K2M09BCCcudFiVHf9LuzAqnOKgCvW9WUHKLd4xOEV
        R8cykr4/OXCTu2pMxdUuHjrUUlKKnQ8=
Date:   Mon, 18 Jul 2022 10:57:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH 1/3] x86/MCE, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Message-ID: <YtUgb2Y/H/Wq9yIn@zn.tnic>
References: <20220418174440.334336-1-yazen.ghannam@amd.com>
 <20220418174440.334336-2-yazen.ghannam@amd.com>
 <Yr2CpuL+JHWblJMD@zn.tnic>
 <YsxefXQDCiJ1zxLG@yaz-fattaah>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YsxefXQDCiJ1zxLG@yaz-fattaah>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jul 11, 2022 at 05:31:41PM +0000, Yazen Ghannam wrote:
> Is your concern specifically on growing/changing struct mce, or is it more
> about limiting info sent to userspace?

Well, both, kinda.

> If it's the former, then I've been thinking it would be good to introduce a
> new internal "struct mce_ext" that includes struct mce plus other things. This
> way struct mce can still be uapi, and things like mcelog can use it. And at
> the same time we can new data used in the kernel or shared through
> tracepoints.
> 
> /* Extended MCE structure */
> struct mce_ext {
> 	struct mce *m;
> 	/* new stuff here */
> };
> 
> What do you think?

The moment you make it part of a trace record, it practically becomes
ABI.

So we could have some opaque blob which is called vendor-specific data
and which is dumped raw to userspace, without any specification to its
format so that luserspace doesn't get any ideas...

Lemme talk to rostedt.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
