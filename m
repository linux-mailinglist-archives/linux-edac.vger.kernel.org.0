Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DFC7430D6
	for <lists+linux-edac@lfdr.de>; Fri, 30 Jun 2023 01:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjF2XD1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 29 Jun 2023 19:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2XD0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 29 Jun 2023 19:03:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EBA2D7F;
        Thu, 29 Jun 2023 16:03:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688079803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O6IsdFQkGO4fQ1fpvYXehWTkF4b4HmYIG/7dgnWgBZw=;
        b=CuHXJE4SvGDkEv0Ux9OA5qSwGbAV6ZDonazEYk+atu/9rvoih8fSuN3KPAJ4xteO5IIhQo
        Sxj3STAd2Pqs+ZsNWvOCx+GGMEhpAmQNaRGlH3/QiVZDRHzpn1y9rfvErz2y3cgve9PqX/
        w3dqe0DgZ/Jksi9uLE69wgTU4Op/kBfcghiGJILFVBnf0ozrv6DxVVcrnpP3OJZ24gTnVh
        XtTmwdukYi4N4YE7XXrqQUxTO44TU/4/lttke9Vp9YyYhaZOMN5RsZFjpC9XCOXxjl9VeD
        ZmDuW6PX8TUsOfyFDmK4nh1VzbZuWFdpew9383c6IthwuJ9UKAX+2OhX/UvtdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688079803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O6IsdFQkGO4fQ1fpvYXehWTkF4b4HmYIG/7dgnWgBZw=;
        b=nKcM2l0fZyg5ZZk1W+AEFfYVQfjD1ccR8J0/3No5lQ/xIYZCUvF6EOIfK5oaSKu+ofljdB
        dc5E/APS0QJtJSBA==
To:     lizhe.67@bytedance.com, tony.luck@intel.com, bp@alien8.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lizefan.x@bytedance.com,
        yuanzhu@bytedance.com, lizhe.67@bytedance.com
Subject: Re: [RFC] msr: judge the return val of function rdmsrl_on_cpu() by
 WARN_ON
In-Reply-To: <20230629072754.39844-1-lizhe.67@bytedance.com>
References: <20230629072754.39844-1-lizhe.67@bytedance.com>
Date:   Fri, 30 Jun 2023 01:03:22 +0200
Message-ID: <87r0ptzxad.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Li!

On Thu, Jun 29 2023 at 15:27, lizhe.67@bytedance.com wrote:

> There are ten places call rdmsrl_on_cpu() in the current code without
> judging the return value. This may introduce a potential bug. For example,
> inj_bank_set() may return -EINVAL, show_base_frequency() may show an error
> freq value, intel_pstate_hwp_set() may write an error value to the related
> msr register and so on. But rdmsrl_on_cpu() do rarely returns an error, so
> it seems that add a WARN_ON is enough for debugging.

Can you please structure your changelogs as documented in:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

instead of providing a big lump of words?

> There are ten places call rdmsrl_on_cpu() in the current code without
> judging the return value.

Return values are not judged. They are either ignored or checked/evaluated.

> This may introduce a potential bug.

Sure. Anything which does not check a return value from a function might
be a bug, but you have to look at each instance whether its a bug or
not.

> For example, inj_bank_set() may return -EINVAL, show_base_frequency()
> may show an error freq value, intel_pstate_hwp_set() may write an
> error value to the related msr register and so on.  But
> rdmsrl_on_cpu() do rarely returns an error, so it seems that add a
> WARN_ON is enough for debugging.

This is hillarious at best.

  1) It does not matter at all whether that function returns an error rarely
     or not.

  2) Adding WARN_ON() without justification at each call site is not
     enough. Neither for debugging nor for real world usage.

You have to come up with individual patches for each callsite to add the
WARN_ON() and in each patch you have to explain why it is justified and
why there is no other solution, e.g. taking an error exit path.

Just slapping WARN_ON()'s into the code without any deeper analysis is
worse than the current state of the code.

If you have identified a real world problem at any of these call sites
then adding a WARN_ON() does not solve it at all.

I'm looking forward to your profound anlysis of each of these "problems".

Thanks,

        tglx


