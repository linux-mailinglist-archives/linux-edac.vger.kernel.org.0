Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E489344AA6A
	for <lists+linux-edac@lfdr.de>; Tue,  9 Nov 2021 10:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243610AbhKIJUL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Nov 2021 04:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237882AbhKIJUK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Nov 2021 04:20:10 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D42C061764;
        Tue,  9 Nov 2021 01:17:24 -0800 (PST)
Received: from zn.tnic (p2e584790.dip0.t-ipconnect.de [46.88.71.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6E8651EC0502;
        Tue,  9 Nov 2021 10:17:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636449443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dw5TMSektJ+6kyWjTPtQRBAjqW4uRrQU4qlKiqn1zq0=;
        b=rpcr7uRQLofcxSsIAkwWzs+hUY8/K51Bw65j7OkScJJF7xQ3+QvBPGino+QVuiJ8wrupe3
        qmmiqiovJoCVZ3oVFlAf1ooB8kaduZ2bb3BdKcqY6uGqZyqgDVUJMFfsl+HHy0PbBCnFrk
        dm2UaGSL9XOtUvkbAeXChcdhYMOvhew=
Date:   Tue, 9 Nov 2021 10:15:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Zhaolong Zhang <zhangzl2013@126.com>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] x86/mce: Get rid of cpu_missing
Message-ID: <YYo8H34W8xPafdnH@zn.tnic>
References: <776fad3d.3369.17d03d2c2ba.Coremail.zhangzl2013@126.com>
 <20211109083547.3546963-1-zhangzl2013@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211109083547.3546963-1-zhangzl2013@126.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Nov 09, 2021 at 04:35:47PM +0800, Zhaolong Zhang wrote:
> Drop cpu_missing since we have more capable mce_missing_cpus.

Who is "we"?

Also, you need to try harder with that commit message - mce_missing_cpus
is a cpumask and I don't see how a cpumask can be "more capable"...

Some more hints on a possible way to structure a commit message - those
are just hints - not necessarily rules - but it should help you get an
idea:

Problem is A.

It happens because of B.

Fix it by doing C.

(Potentially do D).

For more detailed info, see
Documentation/process/submitting-patches.rst, Section "2) Describe your
changes".

Also, to the tone, from Documentation/process/submitting-patches.rst:

 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour."

Also, do not talk about what your patch does - that should hopefully be
visible in the diff itself. Rather, talk about *why* you're doing what
you're doing.

Also, please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

Bottom line is: personal pronouns are ambiguous in text, especially with
so many parties/companies/etc developing the kernel so let's avoid them
please.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
