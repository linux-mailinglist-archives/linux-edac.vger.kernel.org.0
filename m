Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D63310091
	for <lists+linux-edac@lfdr.de>; Fri,  5 Feb 2021 00:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBDXXd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 4 Feb 2021 18:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhBDXXc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 4 Feb 2021 18:23:32 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF2DC0613D6
        for <linux-edac@vger.kernel.org>; Thu,  4 Feb 2021 15:22:51 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id l12so6512013edt.3
        for <linux-edac@vger.kernel.org>; Thu, 04 Feb 2021 15:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pmarks-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fF/cBVN9sMvuy/5U25BO/hvEP1rybsV0ISj0med5yfA=;
        b=kV9R780dMa68FFW3ZGIoqSom0fm4/ljgLvd1ChUoUZnc//EGIShYtsyd2mnsb4/B5v
         5dTJjCct+z6YRok9Dj9MlhojekWUPKa8SvwnfNz06R+W3tZFv8d7wexsaXVOCWYSOA/O
         bP0DnLLVQGQT0DSS9fUAv49TOILNAk7tSa4lst00MrXuJZrDQ+tnsxFYGfRQhvBqGpkT
         4RUb6zwvd8hoNrYc6bN6yabvJZKzQtApNiJdPIcBZGCm1LNKVO8UfoHqworkaSJTEwn5
         rXaumX6nTiUQW7ebESJ+a1foyy4pngq+WlWV/7oYP60PmlbILS6KyNDU4Pqrr6vQcdpk
         y0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fF/cBVN9sMvuy/5U25BO/hvEP1rybsV0ISj0med5yfA=;
        b=Zq9yU857IS+4wYhMJqEB9ME8OLuQALB6UA23OyxjlqEDyLR/OXW9Z52l8UQNLhQTvX
         URa8p9OEZSKZ4qWN2a9LltEt0DGiv0WRnJMIG5YuEkPQgYi5nMOK8R4v77ZNiRHF3RF5
         3v7KLE7mk3gMhWHuDjBWUfkZEM1iMyuQXQ8bGHnZBt4ykLoFF4rLdW/b7lbMkaFO2cHh
         AOB6zk0gv+bD5/fPg3KL4NuVnIYueWvtFiCVq+wYaIb1h/blJqPAg4hXgozSZQ3DIjiL
         xYd+/8/wVKLKDwG52+6seNOiVM87wyrkghxWxv6moo+ckTVBiwLZT8piFeppmiXmsVh3
         zpUw==
X-Gm-Message-State: AOAM531dYlgKYJfd8UQtlN2HQu1zhs54hV0D99yN0dUiOOagmIDdzPni
        PIzTBvq/GXW7qF7iW11JLzyT94rAUsQh8E8vW3KiRZfV
X-Google-Smtp-Source: ABdhPJxdpXeKNOBvTYhpk9RNc8Moqrw8lfkorBjO53yLnZIYC28WFvZC1yrFqv8uyqFec95z7HceAiucMgK1VvUsecQ=
X-Received: by 2002:aa7:dd49:: with SMTP id o9mr915623edw.14.1612480970377;
 Thu, 04 Feb 2021 15:22:50 -0800 (PST)
MIME-Version: 1.0
References: <CAHq9+ShGiB_H6-E=L398zYR=ja16r2OuvJZfU4KLof=segyJbw@mail.gmail.com>
 <ecb895bf-f384-e5e6-d434-d3a8e06eaf47@akamai.com>
In-Reply-To: <ecb895bf-f384-e5e6-d434-d3a8e06eaf47@akamai.com>
From:   Paul Marks <paul@pmarks.net>
Date:   Thu, 4 Feb 2021 15:22:38 -0800
Message-ID: <CAHq9+Si+oyG=8j6xs-a=Jq+8vxU3eHzNOzbA9JXonsFvHd=O=A@mail.gmail.com>
Subject: Re: ie31200_edac missing PCI ID for i3-4370
To:     Jason Baron <jbaron@akamai.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, m.chehab@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Feb 4, 2021 at 2:59 PM Jason Baron <jbaron@akamai.com> wrote:
>
> On 1/31/21 7:07 PM, Paul Marks wrote:
> > I have an ASRock C226M WS with an i3-4370 CPU.
> >
> > # lspci -vnn
> > 00:00.0 Host bridge [0600]: Intel Corporation 4th Gen Core Processor
> >             DRAM Controller [8086:0c00] (rev 06)
> >         Subsystem: ASRock Incorporation 4th Gen Core Processor
> >             DRAM Controller [1849:0c00]
> >         Flags: bus master, fast devsel, latency 0
> >         Capabilities: [e0] Vendor Specific Information: Len=0c <?>
> >         Kernel driver in use: hsw_uncore
> >
> > But edac-util doesn't work:
> >
> > # edac-util -v
> > edac-util: Fatal: Unable to get EDAC data: Unable to find EDAC data in sysfs
> >
> > I tried this ham-fisted patch:
> >
> > # diff -u ./drivers/edac/ie31200_edac.c{.old,}
> > --- ./drivers/edac/ie31200_edac.c.old
> > +++ ./drivers/edac/ie31200_edac.c
> > @@ -58,7 +58,7 @@
> >  #define PCI_DEVICE_ID_INTEL_IE31200_HB_3 0x0150
> >  #define PCI_DEVICE_ID_INTEL_IE31200_HB_4 0x0158
> >  #define PCI_DEVICE_ID_INTEL_IE31200_HB_5 0x015c
> > -#define PCI_DEVICE_ID_INTEL_IE31200_HB_6 0x0c04
> > +#define PCI_DEVICE_ID_INTEL_IE31200_HB_6 0x0c00
> >  #define PCI_DEVICE_ID_INTEL_IE31200_HB_7 0x0c08
> >  #define PCI_DEVICE_ID_INTEL_IE31200_HB_8 0x1918
> >  #define PCI_DEVICE_ID_INTEL_IE31200_HB_9 0x5918
>
> just curious why you removed here and didn't just add?

This is not a serious patch, just a one-liner to demonstrate the problem.

>
> >
> > And it seems happy now:
> >
> > # lspci -vnn
> > 00:00.0 Host bridge [0600]: Intel Corporation 4th Gen Core Processor
> >             DRAM Controller [8086:0c00] (rev 06)
> >         Subsystem: ASRock Incorporation 4th Gen Core Processor
> >             DRAM Controller [1849:0c00]
> >         Flags: bus master, fast devsel, latency 0
> >         Capabilities: [e0] Vendor Specific Information: Len=0c <?>
> >         Kernel driver in use: hsw_uncore
> >         Kernel modules: ie31200_edac
> >
> > # edac-util -v
> > mc0: 0 Uncorrected Errors with no DIMM info
> > mc0: 0 Corrected Errors with no DIMM info
> > mc0: csrow0: 0 Uncorrected Errors
> > mc0: csrow0: mc#0csrow#0channel#0: 0 Corrected Errors
> > mc0: csrow1: 0 Uncorrected Errors
> > mc0: csrow1: mc#0csrow#1channel#0: 0 Corrected Errors
> > edac-util: No errors to report.
> >
> > I don't know if it's truly working because I can't overclock the RAM
> > to induce ECC errors, but still I think adding 8086:0c00 to this
> > driver could be useful.
> >
>
> Cool yeah - I think it makes sense to add if can confirm
> that the Intel datasheet says that this cpu uses the same
> registers to read errors from as the others. I can certainly
> confirm that the other pci ids do increment ce counts...
>
> Thanks,
>
> -Jason
