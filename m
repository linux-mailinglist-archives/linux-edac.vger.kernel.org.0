Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E51127952C
	for <lists+linux-edac@lfdr.de>; Sat, 26 Sep 2020 01:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgIYXwm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 25 Sep 2020 19:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgIYXwm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 25 Sep 2020 19:52:42 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B75DC0613D4
        for <linux-edac@vger.kernel.org>; Fri, 25 Sep 2020 16:52:42 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u3so280873pjr.3
        for <linux-edac@vger.kernel.org>; Fri, 25 Sep 2020 16:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iFWj9rVZ5vm/4L3J5z1Tcx/sVqL/m9WSz6V0j4oHet4=;
        b=ZwESCWVlTO74iymvTUF8tSSMe7Du8J1LymeFeyKgcF5Q1zBF53EVpQ5hr4PUMZrcLn
         2MTLa2gMszA1aZyegsggpOof20L3i0ywKgrCqCg//Qd3p1zH0JzhVYh2t633VyopI2VY
         u5Cmsfyzhhm/KZCqxkc+pm0llJHjFWXiH8tjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iFWj9rVZ5vm/4L3J5z1Tcx/sVqL/m9WSz6V0j4oHet4=;
        b=qYLM52lL4quADKcBNz9/9WLjuGsKK0yvDmvUvYWH1FsugbhANL2/JWPNYJvVREI4AC
         +1vkS1BKZ3lvPcKcXnktFa1OtNIVASuIouYxkoiSqqvAWVRVLearo1tlp1g1MvieM48G
         +l/kadcwN1iYIPaKnLgxZNb3s3BGmYh/EOX5MSecfbtAK1A/sa6zg1mMbj8Mxq5L9EYq
         jH6p7LZ2QRCmKxxmy90e6DvTFnd8b4MFnXjFtFJK4cT6Bdhbjyh/QLj3OlQM52NLuwjf
         jofIfmNOe9P951r5cBXFX42GPtKckADMdrFn6WxYVWXIob1Amd013QkGmCseYLvV0aCD
         YvKw==
X-Gm-Message-State: AOAM533Wz9TFO3qSvZG7OmcNRlWJ3l11Tz18ZBz6OYpfBnGD6Fnmv0y4
        zEZjdCYzSoSQN6UZZchk9K4XWQ==
X-Google-Smtp-Source: ABdhPJw0lmuwQ6bMq1NtGi1jhsCls+JQb9RaDs1Q7b5BS6raVGknvlA16kdtk/o2XDocG2Uwm2fbpg==
X-Received: by 2002:a17:90b:889:: with SMTP id bj9mr22833pjb.101.1601077961848;
        Fri, 25 Sep 2020 16:52:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n28sm3164670pgb.51.2020.09.25.16.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 16:52:41 -0700 (PDT)
Date:   Fri, 25 Sep 2020 16:52:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org, shuah@kernel.org,
        rafael@kernel.org, johannes@sipsolutions.net, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, minyard@acm.org, arnd@arndb.de,
        mchehab@kernel.org, rric@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@driverdev.osuosl.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 00/11] Introduce Simple atomic and non-atomic counters
Message-ID: <202009251650.193E2AD@keescook>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1601073127.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Sep 25, 2020 at 05:47:14PM -0600, Shuah Khan wrote:
> -- Addressed Kees's comments:
>    1. Non-atomic counters renamed to counter_simple32 and counter_simple64
>       to clearly indicate size.
>    2. Added warning for counter_simple* usage and it should be used only
>       when there is no need for atomicity.
>    3. Renamed counter_atomic to counter_atomic32 to clearly indicate size.
>    4. Renamed counter_atomic_long to counter_atomic64 and it now uses
>       atomic64_t ops and indicates size.
>    5. Test updated for the API renames.
>    6. Added helper functions for test results printing
>    7. Verified that the test module compiles in kunit env. and test
>       module can be loaded to run the test.

Thanks for all of this!

>    8. Updated Documentation to reflect the intent to make the API
>       restricted so it can never be used to guard object lifetimes
>       and state management. I left _return ops for now, inc_return
>       is necessary for now as per the discussion we had on this topic.

I still *really* do not want dec_return() to exist. That is asking for
trouble. I'd prefer inc_return() not exist either, but I can live with
it. ;)

-- 
Kees Cook
