Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B14E703DD2
	for <lists+linux-edac@lfdr.de>; Mon, 15 May 2023 21:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjEOToi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 May 2023 15:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243499AbjEOToh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 May 2023 15:44:37 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF0FDC58
        for <linux-edac@vger.kernel.org>; Mon, 15 May 2023 12:44:29 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 19CF71EC04DA;
        Mon, 15 May 2023 21:44:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1684179868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0KRVvUbJ3zGeev2rQD5XsVVzsKHPE2mslnF5F9wqLqs=;
        b=fuPg3p0c/xX2+/lqteyh/j+sRDLHjBEUz+BoMZcVKeQKruBDf4/ngddjWrUEfEy7TJlaFc
        pvGZz1OSRlZE0Un/VgwnvAv3N5bKeMEoD+jMDKsmqvmzQCwYimf/Uda89vjFd/quweG/fi
        SGP0yJxHqhHRXMhZp7BqqZRrtgxQEYA=
Date:   Mon, 15 May 2023 21:44:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Aristeu Rozanski <aris@ruivo.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: Re: [PATCH] mce: prevent concurrent polling of MCE events
Message-ID: <20230515194423.GKZGKLl+8mJiLoJAp1@fat_crate.local>
References: <20230515143225.GC4090740@cathedrallabs.org>
 <20230515145227.GGZGJHKyH9sAfToD03@fat_crate.local>
 <SJ1PR11MB6083576B4BE589D6F04559A5FC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515183050.GJZGJ6Wsmr4Yf/H5Ps@fat_crate.local>
 <SJ1PR11MB6083DC9538CDB6E7FA8B803BFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083DC9538CDB6E7FA8B803BFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 15, 2023 at 07:08:01PM +0000, Luck, Tony wrote:
> > I'm not talking about this ownership - I'm talking about how many
> > logical cores get to see the same error info because the bank is
> > replicated across all of them in *hardware*.
> 
> The hardware doesn't enumerate that banks are shared, or which
> logical CPUs share each bank. The sharing scope can, and has,
> changed from one generation to another. E.g. Banks 0 and 1 were
> core scoped from Nehalem until Cascade Lake. But Icelake and
> subsequent (so far) CPUs made them thread scoped.

So this unconditional serialization is just gross.  This is a per-cpu
timer grabbing a global lock. It is going to make unrelated threads all
wait on a single lock while polling, for nothing.

On a huge box with gazillion cores and when the timers fire just at the
right time, they're all going to hit that lock real hard.

There has to be a better way...

Also, from my previous mail: Is CMCI disabled a valid use case or is
this someone doing testing?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
