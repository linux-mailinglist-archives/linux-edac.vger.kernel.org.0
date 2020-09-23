Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D982276489
	for <lists+linux-edac@lfdr.de>; Thu, 24 Sep 2020 01:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIWXcX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Sep 2020 19:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgIWXcQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 23 Sep 2020 19:32:16 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365DEC0613CE
        for <linux-edac@vger.kernel.org>; Wed, 23 Sep 2020 16:32:15 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n61so1397260ota.10
        for <linux-edac@vger.kernel.org>; Wed, 23 Sep 2020 16:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mtOCOSEGbeQ+MvNORqSMFOyw/dyU6B837tbsWfgmJ+g=;
        b=p+kOhuIujemYrxr7OJzU4Eh17GtXXNLJHY1E/TvtVK8qFwYaA9n45OouiaMfKBcX+c
         E09OK1psRSSLB3d++7JSaB8LEnNnNlaqfLx21X/4toCBcdTNJzgI+w9xgKtoloIt6ZXZ
         V/P/weg9P9Uu6lerCLOFF6FvBCYHzJL15etxGW7X49mHvG7/zuurjxcwJYBCoHCR6oro
         PE6tmW0xsC6D7psaSHNphE1Ai2taLutCrEsCg7/OvqGpxSdYhWi1Dtl+sXa6wZIP3i0y
         TShhLSpOXEtmWSSIT8GzaWasS3ST3PvrhBodJpg38eHq4t6rt2w4i/YbE0R7SSqMyr2p
         nkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=mtOCOSEGbeQ+MvNORqSMFOyw/dyU6B837tbsWfgmJ+g=;
        b=Px2zLUgL2ooliOs3IzIxUkxQkQREy30km2Q04wQZum7NgKgwUdYUvI9YLCt2sUkIWp
         nIOMIj913mBjll+yJRrVDGxOUUFYo0TPNJoQM8MWzS3wJgLygDz6+NL99EMCwWGzAiv+
         LivpzlxOAgpUS9/tVxBRmK2gqJD80FklyxWyvtIFd7xHLcNvBZXnLfCRLNclSoOxxG5l
         WOy9h4wAfcxH8FaIN8LWBJsIY1GIXwk6pxwaFDh+hVbfg3ka1x+8bM6lzZNConA8tY8V
         7B1KgLzTMPOMOIxDnwSnoz3WlZaqd9hZzT3zOexCCz8qVCoJRLFvjO+YHHC3KnsUkDvN
         HdhA==
X-Gm-Message-State: AOAM532XrCiQstfvDjUOt+kdSYjZ8jNl+M/uwT2R6JT6imgzdfIumH2H
        QQUycMKAfkpoJj3ZY9+2NQnY8dIxVoh4
X-Google-Smtp-Source: ABdhPJxNhwUcwe0MH7WtnyCAb9tiuNDuQBRqOXKl3P7XSmqMFOYMdBCwgRG92Vam8OpYjibtzkBzOQ==
X-Received: by 2002:a9d:7854:: with SMTP id c20mr1314338otm.123.1600903935076;
        Wed, 23 Sep 2020 16:32:15 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id m11sm342506ooe.43.2020.09.23.16.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 16:32:14 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:bda8:cea9:424f:cdc4])
        by serve.minyard.net (Postfix) with ESMTPSA id D1F7B180056;
        Wed, 23 Sep 2020 23:32:12 +0000 (UTC)
Date:   Wed, 23 Sep 2020 18:32:11 -0500
From:   Corey Minyard <minyard@acm.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>,
        hidehiro.kawai.ez@hitachi.com, linfeilong@huawei.com,
        liuzhiqiang26@huawei.com, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86: Fix MCE error handing when kdump is enabled
Message-ID: <20200923233211.GZ3674@minyard.net>
Reply-To: minyard@acm.org
References: <20200923115742.4634-1-minyard@acm.org>
 <20200923220257.GA20839@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923220257.GA20839@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 23, 2020 at 03:02:57PM -0700, Luck, Tony wrote:
> On Wed, Sep 23, 2020 at 06:57:42AM -0500, minyard@acm.org wrote:
> > From: Corey Minyard <cminyard@mvista.com>
> > 
> > If kdump is enabled, the handling of shooting down CPUs does not use the
> > RESET_VECTOR irq before trying to use NMIs to shoot down the CPUs.
> > 
> > For normal errors that is fine.  MCEs, however, interrupt all CPUs at
> > the same time so they are already running in an NMI, so sending them an
> > NMI won't do anything.  The MCE code in wait_for_panic() is set up to
> > receive the RESET_VECTOR because it enables irqs, but it won't work on
> > the NMI-only case.
> 
> MCE and NMI are separate exception types ... so not accurate to say
> "already running in an NMI". Better to say somehting like: MCE has higher
> priority than NMI so the NMI is blocked until the MCE is over.

Ok, fixed the comment here.

> 
> > There is already code in place to scan for the NMI callback being ready,
> > simply call that from the MCE's wait_for_panic() code so it will pick up
> > and handle it if an NMI shootdown is requested.  This required
> > propagating the registers down to wait_for_panic().
> 
> The code might look a little prettier if you put "regs" at the start
> of the argument list instead of at the end. Especially for the functions
> that have string message arguments.

Yeah, I was being lazy.  Better to be consistent.

> 
> > Reported-by: Wu Bo <wubo40@huawei.com>
> > Cc: hidehiro.kawai.ez@hitachi.com
> > Cc: linfeilong@huawei.com
> > Cc: liuzhiqiang26@huawei.com
> > Signed-off-by: Corey Minyard <cminyard@mvista.com>
> > Tested-by: Wu Bo <wubo40@huawei.com>
> > ---
> > Wu Bo found this doing kdumps because the IPMI driver saves panic
> > information to the IPMI event log during a panic.  But it was getting
> > interrupts at the same time because the other cores had interrupts
> > enabled, causing the process to take a long time.
> > 
> > Having interrupt enabled during a kdump shutdown and while the new kdump
> > kernel is running is obviously a bad thing and can cause other problems,
> > too.  I think this is the right fix, but I'm not an expert in this code.
> 
> I'm also uncertain if this is the best/right approach. Interaction between
> NMI, MCE, etc. is something of a rats nest. Perhaps Andy Lutomirksi may
> have ideas.

I have a patch ready with the above changes, pending Andy (or someone
else) commenting on this.

Thanks Tony,

-corey

> 
> -Tony
