Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89475290DDE
	for <lists+linux-edac@lfdr.de>; Sat, 17 Oct 2020 00:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391504AbgJPWv2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 16 Oct 2020 18:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391694AbgJPWv1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 16 Oct 2020 18:51:27 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51650C0613D4
        for <linux-edac@vger.kernel.org>; Fri, 16 Oct 2020 15:51:27 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b19so2045816pld.0
        for <linux-edac@vger.kernel.org>; Fri, 16 Oct 2020 15:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+A3qb7wSddKoudeH8qefVLLKBMGX/mQTDOB4rUkAdCY=;
        b=CF4LqkGIH6KRSjEVRXkMwMTHn6F2e/bCzAoitFYNW9uJm8WKLqpR6NIZ7gFV3aCNBZ
         DnHu4YGPXjOHok3RikNWoHjwks9Jp7YV3Q7GQeWMLNl6w2qqUkU+xnGlTV41kuQanWlw
         5I3SXWgj8ziKK8QievcHzQEAYEVifzBDPBh1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+A3qb7wSddKoudeH8qefVLLKBMGX/mQTDOB4rUkAdCY=;
        b=R245bcuz2L17dyAS/ha9Ojr3jcwE5WDDGAx2F+KxxA0wa0eEalJStwb2edM9anveyv
         63osT8VKpQsgUMn9F818vcEfAFMLhYl2XJLAH9y6HJ2/4RVXAzwVoRJ1YSANLaXehevf
         aH/Sj+BOj/OlIpp7q+ULb+uTys3o2IVc7sX99cs9J2cdeVNvATgqhQhsMHme1BrKzaI8
         Y7LnLRGNFnkR9Z4TQiL1n6jEgZhBn1DGLMtCCO101oSSvv/r+dpw5Q35a3n6LfB+chOF
         PmOyUgc/0zdY+o/BOqR47kdx1RNJLxjaO9IOmvYSEVFWUIBqcvPULKci9T3OXFAq5vP+
         zIyg==
X-Gm-Message-State: AOAM530ssCcjzn+ojICW5YUg+tm84kwk+yL4T9XPIYqCHPQ56yB7Wcax
        ZnM9iU6LHYal7JB6BV1e4gR7eA==
X-Google-Smtp-Source: ABdhPJydepy1YplrdnyBgmFc/3tQ/e/3eMYUwqhlQUodPHed8wA582z7vboWjRhYh9ZEXf+nz1NAJw==
X-Received: by 2002:a17:90a:aa90:: with SMTP id l16mr6212058pjq.0.1602888686891;
        Fri, 16 Oct 2020 15:51:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c17sm4044276pfj.220.2020.10.16.15.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 15:51:25 -0700 (PDT)
Date:   Fri, 16 Oct 2020 15:51:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, corbet@lwn.net,
        gregkh@linuxfoundation.org, shuah@kernel.org, rafael@kernel.org,
        johannes@sipsolutions.net, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        christian@brauner.io, hridya@google.com, surenb@google.com,
        minyard@acm.org, arnd@arndb.de, mchehab@kernel.org,
        rric@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@driverdev.osuosl.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 00/11] Introduce Simple atomic counters
Message-ID: <202010161541.6DD2D1E@keescook>
References: <cover.1602209970.git.skhan@linuxfoundation.org>
 <20201009193746.GA1073957@hirez.programming.kicks-ass.net>
 <202010091255.246395A6@keescook>
 <20201010110920.GQ2628@hirez.programming.kicks-ass.net>
 <6e1dd408-653e-817e-b659-23649259a929@linuxfoundation.org>
 <20201014091720.GC2628@hirez.programming.kicks-ass.net>
 <202010141611.70B7A38@keescook>
 <20201016105313.GJ2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016105313.GJ2611@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Oct 16, 2020 at 12:53:13PM +0200, Peter Zijlstra wrote:
> That's like saying: "I'm too lazy to track what I've looked at already".
> You're basically proposing to graffiti "Kees was here -- 16/10/2020" all
> over the kernel. Just so you can see where you still need to go.
> 
> It says the code was (assuming your audit was correct) good at that
> date, but has no guarantees for any moment after that.

That kind of bit-rot marking is exactly what I would like to avoid: just
putting a comment in is pointless. Making the expectations of the usage
become _enforced_ is the goal. And having it enforced by the _compiler_
is key. Just adding a meaningless attribute that a static checker
will notice some time and hope people fix them doesn't scale either
(just look at how many sparse warnings there are). So with C's limits,
the API and type enforcement become the principle way to get this done.

So, if there are behavioral patterns we CAN carve away from atomic_t
cleanly (and I think there are), those are the ones I want to work
towards. The "corner case" uses of atomic_t are much less common than
the "big" code patterns like lifetime management (now delegated to and
enforced by refcount_t). My estimation was that _statistics_ (and not
"serial identifiers") was the next biggest code pattern using atomic_t
that could benefit from having its usage isolated. It is not itself a
dangerous code pattern, but it can mask finding them.

Then, at the end of the day, only the corner cases remain, and those can
be seen clearly as they change over time. Since we can never have a
one-time audit be anything other than advisory, we need to make it EASY
to do those kinds of audits so they can be done regularly.

-- 
Kees Cook
