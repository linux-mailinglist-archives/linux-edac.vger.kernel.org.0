Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6282804DB
	for <lists+linux-edac@lfdr.de>; Thu,  1 Oct 2020 19:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732805AbgJARMx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 1 Oct 2020 13:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732808AbgJARMU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 1 Oct 2020 13:12:20 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC2FC0613D0
        for <linux-edac@vger.kernel.org>; Thu,  1 Oct 2020 10:12:19 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id s66so6212362otb.2
        for <linux-edac@vger.kernel.org>; Thu, 01 Oct 2020 10:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/7NXXrjXj8dvlBu8u10badCJ3wqHRyH8Ya1Qhmj1R7w=;
        b=Bi5Rf+IyCzanLkVYVcnuRBQTCJgAyhtqyqmmhN+PwflWucC/fDLF2BBMdJgYdhjFxU
         NfxshNeJPPU/Rx1rAEEc394ukeofq1lkaVjxNLsSQvVeuSfIKzg4V4ZKmkMrJwqB3DHC
         mekl9rpOfurpNlML/WeVFDTAVcrJ1+qHrj//+LTRFE/eaYc7PDxE9UDU0d2yXBrrNpbh
         8NFvNB33XSSajw9EaRwHez/55svl0FY2e+0eaXShX0Hw3h76bnGo9bH1qSj4JrtXdLPj
         /9P+V/dDakIiiHxXiMtQTuGLbgYSSFam0x0jNRpLyjrUTvcxmY20lCelx63P9fxPmQGe
         gtlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/7NXXrjXj8dvlBu8u10badCJ3wqHRyH8Ya1Qhmj1R7w=;
        b=AmKRhLxdpX2td2kVyuLMmBDCtNbwNgUeSG6aZZya29pvddIUQ9ESj7uu6L+UI3qGLJ
         h22ANt5FDXrccKUBZafXDT8WlpF4/TK2KM/VoEZDqjIJc0L4jxaHteFr7HyeuGBnxwX4
         st7VsFRnVIaHT5v3BjVACckW0N69OakKAg8h6RGE0C5p2rdFwJN/8OlpJfCc5A3sZWwF
         jz9mZbZS26xYo8YcIoJnPtxTtLD9trwfW6E7TaaqN4ek49djWjMzHDmyFqoKEfi3sW9E
         /9HByesO0IeC2SAyiodcAzbjAmYLlEN18SLKX3IA8sEGkIJCl4TLRdCzX1Q1jkJ6OAVj
         uk/A==
X-Gm-Message-State: AOAM532d0VJSGHghRCtPsdd8NpbqXNTGDK+UInLJ08ik3pNuKLbdYu3E
        YY2CmpYYQQslp4Tk8MAJF9ZmVA==
X-Google-Smtp-Source: ABdhPJwtW9F8cfkV4bYuT1doxPf91zIYNcupz9lpvPbeAFuR507sRWYuX99lNIGCmvSyv6rAwcCXJw==
X-Received: by 2002:a9d:61d5:: with SMTP id h21mr5820968otk.187.1601572339273;
        Thu, 01 Oct 2020 10:12:19 -0700 (PDT)
Received: from minyard.net ([2001:470:b8f6:1b:119c:a18f:647:7f4c])
        by smtp.gmail.com with ESMTPSA id p8sm1457125oot.29.2020.10.01.10.12.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Oct 2020 10:12:18 -0700 (PDT)
Date:   Thu, 1 Oct 2020 12:12:16 -0500
From:   Corey Minyard <cminyard@mvista.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Corey Minyard <minyard@acm.org>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "hidehiro.kawai.ez@hitachi.com" <hidehiro.kawai.ez@hitachi.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>,
        "liuzhiqiang26@huawei.com" <liuzhiqiang26@huawei.com>
Subject: Re: [PATCH v2] x86: Fix MCE error handing when kdump is enabled
Message-ID: <20201001171216.GY3725@minyard.net>
Reply-To: cminyard@mvista.com
References: <20200929211644.31632-1-minyard@acm.org>
 <20200930175633.GM6810@zn.tnic>
 <20200930184906.GZ3674@minyard.net>
 <20201001113318.GC17683@zn.tnic>
 <20201001134449.GB3674@minyard.net>
 <20201001161645.GD17683@zn.tnic>
 <6c6238c0088747a994a2bdce38ad0242@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c6238c0088747a994a2bdce38ad0242@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 01, 2020 at 04:29:49PM +0000, Luck, Tony wrote:
> >> I was thinking about this some yesterday.  It seems to me that enabling
> >> IRQS in an MCE handler is just a bad idea, but it's really a bad idea
> >> for kdump.
> >
> > I don't think this code ever thought about kdump.
> 
> How useful is kdump after a machine check induced crash anyway?
> 
> kdump is useful for debugging software problems.  There are very
> few ways that a software bug can result in a machine check. There
> are many ways that a hardware problem can trigger a machine check
> and crash.
> 
> So it would seem (statistically) that the analysis of almost every kdump
> after a machine check just says "h/w issue".

I don't really know.  It seems like having an idea of what the software
was doing when the hardware died might be useful for the hardware
engineers.  I really don't know much about what triggers MCEs, though,
besides memory errors the hardware couldn't correct.

You could say that the regs don't matter, I suppose, and that's
probabaly fine.  But if it's easy enough to do, and the interfaces are
already there and work, and it speeds up the crash process a bit, why
not do it?

-corey
