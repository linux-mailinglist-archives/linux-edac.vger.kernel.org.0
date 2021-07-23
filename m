Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECF03D3381
	for <lists+linux-edac@lfdr.de>; Fri, 23 Jul 2021 06:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhGWDgU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Jul 2021 23:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbhGWDgT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Jul 2021 23:36:19 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCA5C061575
        for <linux-edac@vger.kernel.org>; Thu, 22 Jul 2021 21:16:53 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id c20so131529vko.7
        for <linux-edac@vger.kernel.org>; Thu, 22 Jul 2021 21:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6NnYz1iNIJhzHIpHY3i7AC/PL1h4WWIN/9Zu2pseyMM=;
        b=AZJdFW+r1qJWaIOq18g5RGslCbMDM6EDd2J24goRI0W5EwPTWWDQMFpDWIpLbGDQlE
         t7W45Vl8JvT7haAvXnmOJ3TFJVBZ+MkNDdRgej0HPb5BMaZth8X3TpUEH6CQI0isBYnU
         4RoYAsgVDjzpK/aRqTgkea65g9lGsbDdq4gQ/IyAR98RQ74Zjv/dsVZ9AWgf3IKwQA5J
         TMFgQYFd3O9i85QsokNRL6dHUQaXwwbbsPu3N23LXOAUcjzHKoxB8qr2pTfahfvPbuwW
         bQD2Q71jeGPlhPgyvn2J/SMnMcoJOMTuQTDQOiLh6HAriI4AVRKhWte7N1uULoqTf8vZ
         hdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6NnYz1iNIJhzHIpHY3i7AC/PL1h4WWIN/9Zu2pseyMM=;
        b=HXGkbUABie9luVuVX43RU5GlY6Zv8pXXLY7BQShahMVjB9423Ell/0bJnyTfrnpWVU
         5H/4z3FgqyrVMBzKYL7PEN6TYtzW95WqyM3enzrujeEyI24TzHCTCo0XWiVcGYNliwNr
         C4x1thF+OsT4046kGRgb/GGedbfZ07hG1POG2bzLF6wLAv0NctZPYGU5yyrJ7D/E3gCI
         lqF5p0tuNoP5nvTJaMSNCvqfli6S60nIjje5YMRqj9mA/0ej9TN9/UNc4OBbfa0fYEKD
         ZZP39MrRZkhbRmfvzRZsk6YWScUHXjt6Dm2HRmooIPkIFxF96f/fEfeXMJ4naFi2dkDb
         tCHw==
X-Gm-Message-State: AOAM532MzjFhNxNfJjafGgcO1Bl7JlXcLTXaPLyD56TkgTJBg8opMhog
        20lTjmfEsmWwpc2c1Ye7tEsxA82CImzjjgdSy15Vmg==
X-Google-Smtp-Source: ABdhPJwZNrd//Qm6E0WasD+fHTkPxy6ahCgH393B/+gnefLb0a3vT8t4ESyooIGyde+hTp9vUvp/oVq8kMcTfQhewAM=
X-Received: by 2002:a1f:7309:: with SMTP id o9mr2625176vkc.19.1627013811893;
 Thu, 22 Jul 2021 21:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcxDJ7YsnYtyzSmgfBj-rmALkjigKx2ODB=SCYCzY8FJYg4iA@mail.gmail.com>
 <20210722151930.GA1453521@agluck-desk2.amr.corp.intel.com>
 <CAPcxDJ6bB7GEhTq9fkHuT4chRTUk_s-crci=nh+COCwAzMP8Yw@mail.gmail.com>
 <20210723001436.GA1460637@agluck-desk2.amr.corp.intel.com>
 <CAPcxDJ4Liv1_zASzRxdGKu7MmjRQ9inXPfhPMQdEZrEjL0U=zw@mail.gmail.com> <0e39ef0e1b6d4532a09ad2d6e0b28310@intel.com>
In-Reply-To: <0e39ef0e1b6d4532a09ad2d6e0b28310@intel.com>
From:   Jue Wang <juew@google.com>
Date:   Thu, 22 Jul 2021 21:16:40 -0700
Message-ID: <CAPcxDJ7=UsAkDwVuoQcTt2B2UA4RWjs_o_=Fnk4Hfuqj+V8hAA@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/mce: Avoid infinite loop for copy from user recovery
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "dinghui@sangfor.com.cn" <dinghui@sangfor.com.cn>,
        "huangcun@sangfor.com.cn" <huangcun@sangfor.com.cn>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        x86 <x86@kernel.org>, "Song, Youquan" <youquan.song@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jul 22, 2021 at 9:01 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> >> I'm not aware of, nor expecting to find, places where the kernel
> >> tries to access user address A and hits poison, and then tries to
> >> access user address B (without returrning to user between access
> >> A and access B).
> >This seems a reasonablely easy scenario.
> >
> > A user space app allocates a buffer of xyz KB/MB/GB.
> >
> > Unfortunately the dimms are bad and multiple cache lines have
> > uncorrectable errors in them on different pages.
> >
> > Then the user space app tries to write the content of the buffer into some
> > file via write(2) from the entire buffer in one go.
>
> Before this patch Linux gets into an infinite loop taking machine
> checks on the first of the poison addresses in the buffer.
>
> With this patch (and also patch 3/3 in this series). There are
> a few machine checks on the first poison address (I think the number
> depends on the alignment of the poison within a page ... but I'm
> not sure). My test code shows 4 machine checks at the same
> address. Then Linux returns a short byte count to the user
> showing how many bytes were actually written to the file.
>
> The fast that there are many more poison lines in the buffer
> beyond the place where the write stopped on the first one is
> irrelevant.
In our test, the application memory was anon.
With 1 UC error injected, the test always passes with the error
recovered and a SIGBUS delivered to user space.

When there are >1 UC errors in buffer, then indefinite mce loop.
>
> [Well, if the second poisoned line is immediately after the first
> you may hit h/w prefetch issues and h/w may signal a fatal
> machine check ... but that's a different problem that s/w could
> only solve with painful LFENCE operations between each 64-bytes
> of the copy]
>
> -Tony
