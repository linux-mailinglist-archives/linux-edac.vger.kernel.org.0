Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE85144AA2E
	for <lists+linux-edac@lfdr.de>; Tue,  9 Nov 2021 10:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244688AbhKIJMj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Nov 2021 04:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244712AbhKIJMi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Nov 2021 04:12:38 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E5AC061767;
        Tue,  9 Nov 2021 01:09:52 -0800 (PST)
Received: from zn.tnic (p2e584790.dip0.t-ipconnect.de [46.88.71.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D3E4A1EC04E4;
        Tue,  9 Nov 2021 10:09:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636448990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zfYYtoXdHEdFf5P9uwulPig2zqIQ1+SFMFErzFp806w=;
        b=ft1SgBWY9GStg3ExlOa+rDEF1dTyrsXU9D6YufTNatnc0R4z9ltlGcsYrdWazptt5oRUti
        RgcjV1xRzhC7MLXziTjKrdV3cPwrrnyzkyi4PxlVGqtfn+LxyDetsBhIfgHaCsuYh4Pwod
        MPGuLRrjVvX59aaNrERMMivCxizxg2E=
Date:   Tue, 9 Nov 2021 10:07:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Zhaolong Zhang <zhangzl2013@126.com>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] x86/mce: drop cpu_missing since we have more capable
 mce_missing_cpus
Message-ID: <YYo6VwPZLCWcP3Bl@zn.tnic>
References: <572d793c.f2e.17cede4cbf0.Coremail.zhangzl2013@126.com>
 <20211108082832.142436-1-zhangzl2013@126.com>
 <YYjuiHN1wKt82fjs@zn.tnic>
 <4d526023.3cde.17cff097bab.Coremail.zhangzl2013@126.com>
 <YYj8ir/UYnG/zVK4@zn.tnic>
 <4a77f582.4434.17cff975224.Coremail.zhangzl2013@126.com>
 <776fad3d.3369.17d03d2c2ba.Coremail.zhangzl2013@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <776fad3d.3369.17d03d2c2ba.Coremail.zhangzl2013@126.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Nov 09, 2021 at 04:31:23PM +0800, Zhaolong Zhang wrote:
> If there is a non-recoverable mce as well, just let it print that
> reason. No need to bring the timeout message indeed. Because since
> the tolerant was set to a high level to ignore the timeout, we can
> eventually ignore them.

Here's how I see it:

	/*
	 * Tolerant levels:
	 * 0: always panic on uncorrected errors, log corrected errors
	 * 1: panic or SIGBUS on uncorrected errors, log corrected errors
	 * 2: SIGBUS or log uncorrected errors (if possible), log corr. errors
	 * 3: never panic or SIGBUS, log all errors (for testing only)
	 */

So on normal deployments, no one should fiddle with tolerant levels - so
you'll be running at tolerance level 0 by default and all should print
out. Same for level 1.

Levels 2 and 3 are, to me at least, purely for testing *only*. And,
actually, that error message should be issued regardless of the
tolerance level - only the panicking should be controlled by that. IOW,
that code should do:

        if ((s64)*t < SPINUNIT) {
                if (cpumask_and(&mce_missing_cpus, cpu_online_mask, &mce_missing_cpus))
                        pr_emerg("CPUs not responding to MCE broadcast (may include false positives): %*pbl\n",
                                 cpumask_pr_args(&mce_missing_cpus));
                if (mca_cfg.tolerant <= 1)
                        mce_panic(msg, NULL, NULL);
                return 1;
        }

because, regardless of tolerance level, saying that some cores didn't
respond is important info.

You could do that as a separate patch, on top, if you feel like it.

> I am not sure whether it should be authored by you or suggested by
> you.

Suggested is fine.

> Anyway, I will post a new patch exactly as you suggested. Please pick
> it or ignore it as appropriate :)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
