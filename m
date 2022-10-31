Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B822613D67
	for <lists+linux-edac@lfdr.de>; Mon, 31 Oct 2022 19:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJaSgP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 31 Oct 2022 14:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiJaSgP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 31 Oct 2022 14:36:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FEB12626;
        Mon, 31 Oct 2022 11:36:14 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7cf329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7cf:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B0C791EC03B9;
        Mon, 31 Oct 2022 19:36:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667241372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5CbwOOBzTxh/YiPVt0dI7tUxoI7+CpLDu9XbPrwFOS0=;
        b=nnd0AUBga9fVAG1lG9koch23cykAuBAt72yf+hbHhWEgx0H4sJTEF8Lby8NmtW5AXqH5eQ
        /e7VJhQTZbdei6lVizcmvyTdflhYl1/5MAGI/DT+RQF+f8GwJHEOjUXIdd3rkUkIeC+hv8
        d57Jwk4k96+/vQVv5JbKt+o10R2rPBY=
Date:   Mon, 31 Oct 2022 19:36:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/mce: Dump the stack for recoverable machine
 checks in kernel context
Message-ID: <Y2AVmOdEtTl5e68l@zn.tnic>
References: <20220922195136.54575-1-tony.luck@intel.com>
 <20220922195136.54575-3-tony.luck@intel.com>
 <Y1/7ewEgVZ56KlJp@zn.tnic>
 <SJ1PR11MB6083593A0D18EEE0074E77ABFC379@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083593A0D18EEE0074E77ABFC379@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 31, 2022 at 05:13:10PM +0000, Luck, Tony wrote:
> > 1. If the error has raised a MCE, then we will dump stack anyway.
> 
> I don't see stack dumps for machine check panics. I don't have any non-standard
> settings (I think). Nor do I see them in the panic messages that other folks send
> to me.
> 
> Are you settting some CONFIG or command line option to get a stack dump?

Well, if one were sane, one would assume that one would expect to see a
stack dump when the machine panics, right? I mean, it is only fair...

And there's an attempt:

#ifdef CONFIG_DEBUG_BUGVERBOSE 
        /*
         * Avoid nested stack-dumping if a panic occurs during oops processing
         */
        if (!test_taint(TAINT_DIE) && oops_in_progress <= 1)
                dump_stack();
#endif

but that oops_in_progress thing is stopping us:

[   13.706764] mce: [Hardware Error]: CPU 2: Machine Check Exception: 6 Bank 4: fe000010000b0c0f
[   13.706781] mce: [Hardware Error]: RIP 10:<ffffffff8103bbcb> {trigger_mce+0xb/0x10}
[   13.706791] mce: [Hardware Error]: TSC c83826d14 ADDR e1101add1e550012 MISC cafebeef 
[   13.706795] mce: [Hardware Error]: PROCESSOR 2:a00f11 TIME 1667244167 SOCKET 0 APIC 2 microcode 1000065
[   13.706809] mce: [Hardware Error]: Machine check: Processor Context Corrupt
[   13.706810] panic: on entry: oops_in_progress: 1
[   13.706812] panic: before bust_spinlocks oops_in_progress: 1
[   13.706813] Kernel panic - not syncing: Fatal local machine check
[   13.706814] panic: taint: 0, oops_in_progress: 2
[   13.707133] Kernel Offset: disabled

as panic() is being entered with oops_in_progress already set to 1. That
oops_in_progress thing looks like is being used for console unblanking.

Looking at

  026ee1f66aaa ("panic: fix stack dump print on direct call to panic()")

it hints that panic() might've been called twice for oops_in_progress to
be already 1 on entry.

I guess we need to figure out why that is...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
