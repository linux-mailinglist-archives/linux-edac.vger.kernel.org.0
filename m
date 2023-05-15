Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA26703CA7
	for <lists+linux-edac@lfdr.de>; Mon, 15 May 2023 20:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbjEOSa7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 May 2023 14:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbjEOSa6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 May 2023 14:30:58 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A274225
        for <linux-edac@vger.kernel.org>; Mon, 15 May 2023 11:30:56 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD9181EC0159;
        Mon, 15 May 2023 20:30:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1684175454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1uSQmu3f4nyck5/hWt3nD5/Bkvn+BU6LDmuVkjjQCpU=;
        b=RHFBktOynEK5AeLJkDWuVZgUqr2wgLD9oTARJSQjCVcZrECfiuW0bOqxgZ4OijCEgh07eT
        jQU5reShSkRx7+aObW5AWa7kHBrWRZfxvs3LpCd37aSuHYSyZ4wvAWipt5O6GFha41h5Yr
        au8zgcpymPfGcV/bC4BtGFQlTaZiEnw=
Date:   Mon, 15 May 2023 20:30:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Aristeu Rozanski <aris@ruivo.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: Re: [PATCH] mce: prevent concurrent polling of MCE events
Message-ID: <20230515183050.GJZGJ6Wsmr4Yf/H5Ps@fat_crate.local>
References: <20230515143225.GC4090740@cathedrallabs.org>
 <20230515145227.GGZGJHKyH9sAfToD03@fat_crate.local>
 <SJ1PR11MB6083576B4BE589D6F04559A5FC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083576B4BE589D6F04559A5FC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 15, 2023 at 05:18:06PM +0000, Luck, Tony wrote:
> The MCE code only knows sharing scope if CMCI is enabled. The algorithm to
> determine ownership of a shared bank is "first to find the bank is the owner"
> as determined by successful setting of bit 30 in IA32_MCi_CTL2. There
> isn't any other practical way to determine scope of bank sharing.

I'm not talking about this ownership - I'm talking about how many
logical cores get to see the same error info because the bank is
replicated across all of them in *hardware*.

> In Aristeu's case with the HP systems CMCI is disabled. I saw the same
> on a system here when booted with "mce=no_cmci". Twelve CPUs (out
> of 144) were polling on the same jiffy and reported the same error.

Is CMCI disabled a valid use case or is this someone doing testing?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
