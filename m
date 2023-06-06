Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A9E72454D
	for <lists+linux-edac@lfdr.de>; Tue,  6 Jun 2023 16:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbjFFOJF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 6 Jun 2023 10:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbjFFOIz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 6 Jun 2023 10:08:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5AB139
        for <linux-edac@vger.kernel.org>; Tue,  6 Jun 2023 07:08:54 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 36A8D1EC069A;
        Tue,  6 Jun 2023 16:08:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686060533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=n731ioWYT29UZwTsND5hVu0KWbqR3krWdUKHA4akFKk=;
        b=M2/ja+t2sbpXZ2Bg90LUhD8k6BkbTpC//si7FiKEVUqyi820dF6zdEpnqYnW6n+xIX0xOo
        XWGp5oavgvdLv57Aucqb8rr7voKeZJ2Jm2XMDK7/PnM3EoqBkDnitMJY3dVQMBxszQdoP1
        CA9Gb2YMklSW/ofl4Fntup1pU+MOtl0=
Date:   Tue, 6 Jun 2023 16:08:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Aristeu Rozanski <aris@ruivo.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: Re: [PATCH] mce: prevent concurrent polling of MCE events
Message-ID: <20230606140848.GCZH898MYjw6+b2yux@fat_crate.local>
References: <20230605174104.GBZH4eMLx1cp+nQJH2@fat_crate.local>
 <SJ1PR11MB6083726809001C8E29D65F15FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230605193000.GDZH43uFhBmQfSO+9D@fat_crate.local>
 <20230605203315.GR4090740@cathedrallabs.org>
 <20230605205658.GFZH5MGg2QizffZRte@fat_crate.local>
 <20230605210108.GS4090740@cathedrallabs.org>
 <20230605210610.GGZH5OQkeWMXGZzxhR@fat_crate.local>
 <20230605215839.GT4090740@cathedrallabs.org>
 <20230606082541.GAZH7thXcj7SatSNtO@fat_crate.local>
 <20230606140011.GU4090740@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606140011.GU4090740@cathedrallabs.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 06, 2023 at 10:00:11AM -0400, Aristeu Rozanski wrote:
> I started saying that we need to avoid, when possible, to waste kernel
> log. Duplicates are a waste. You mentioned not even logging MCEs at all
> and I said that I believe it's not right, as it might be useful to be
> aware of MCEs being delivered before a crash.

You don't have to summarize the whole thread - I know what we're talking
about.

And just to give you another example: if the MCE which caused that crash
gets overwritten in dmesg, your saved kernel log is useless as you want
the *first* one logged.

That's all I'm saying - the kernel log is best effort - nothing more.

Independent of that, yes, we will try not to pollute it with duplicates
once we know what the issue exactly is which makes people disable CMCI.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
