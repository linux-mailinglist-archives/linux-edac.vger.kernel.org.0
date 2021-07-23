Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B155A3D3250
	for <lists+linux-edac@lfdr.de>; Fri, 23 Jul 2021 05:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhGWDHZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Jul 2021 23:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbhGWDHY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Jul 2021 23:07:24 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F24C061757
        for <linux-edac@vger.kernel.org>; Thu, 22 Jul 2021 20:47:59 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id g2so355967vsb.8
        for <linux-edac@vger.kernel.org>; Thu, 22 Jul 2021 20:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ov3sTIdDgkhinUkLdbYA6eaZmI5paJMcon2JwN7yw+A=;
        b=cTqH7tH3pMk/WR/OEYVl3fGSR9Z/1xl8SYqYxSgunubwJKp31znNoY95TijGcwzmZy
         6bPmKnq+BCCM/zDfe8moixzui4Yyb7cjP4gOBXAG/rm7Ucy7FXCpOXwcneQf8sRsB/GH
         fpN6tqbnidEkcpQtfd+ecTCENIHqObKAoe5nlfqPUR6coLLs+Jzj5PtP1mV+hGn+bM/B
         tKlguWVhg+MG/vHMDMslnuKATorQZe89sUF0JpIY/iueQ9rbD7+xzD1CajYK1wJbQ/M7
         lQ7ws5mAZH/KVSIhJW9S6NkiY9ClvIf7/Qfsn/v6nZ3dy4pPQisnKX6AyjK8CtSwFQzf
         SYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ov3sTIdDgkhinUkLdbYA6eaZmI5paJMcon2JwN7yw+A=;
        b=jpqG2wBFLSFZ2SWc9P/JNH6AacfFZgLPXTc6fPsVPK3K0rEokqvlrE60o3XRt+gF30
         ymilOqlMt0O53A3dGf42IfEcnb+OP3f0aDtm8EYWgTLT78OCAnDsUXk0O7eB1G5sxi0h
         5jBMTNi2Iq+1rKv9U0iiwqv8FVaTRYgfUVzB3sLd3r1Rf/O5k7Tz19fKpfliKfrelg5B
         nQzbmEk9KwvIUqD2CX4EoSmYcQrOIrsrMI7ijKVA6pC+IQVq+MwPlkO8Fkmk4Lm7CQ8c
         zukB46301jFdmGAdhcOee2BHSQrc9HsLFfG0rdP2CYiZ7/AnrmQWgXGQfyiK7MNOfnLA
         KNQw==
X-Gm-Message-State: AOAM532YmJQdEoKmRW6/jkKr4+/KHLqi9A9/naEhs+ZlaYjZGVXKHK7Q
        fH7E3QxGx77/dfO/ZDv7vz37OmrmPgl3yYfDMZaZsg==
X-Google-Smtp-Source: ABdhPJxil7w/dnxpj6cyp8RC/mEq1xSXXqriheWzbE0Hd/5357y/A4K0r+Yk8Nv9FLRliSWo+b12mq1bKXz0jIGDBoI=
X-Received: by 2002:a67:fe01:: with SMTP id l1mr2937274vsr.50.1627012078016;
 Thu, 22 Jul 2021 20:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcxDJ7YsnYtyzSmgfBj-rmALkjigKx2ODB=SCYCzY8FJYg4iA@mail.gmail.com>
 <20210722151930.GA1453521@agluck-desk2.amr.corp.intel.com>
 <CAPcxDJ6bB7GEhTq9fkHuT4chRTUk_s-crci=nh+COCwAzMP8Yw@mail.gmail.com> <20210723001436.GA1460637@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20210723001436.GA1460637@agluck-desk2.amr.corp.intel.com>
From:   Jue Wang <juew@google.com>
Date:   Thu, 22 Jul 2021 20:47:46 -0700
Message-ID: <CAPcxDJ4Liv1_zASzRxdGKu7MmjRQ9inXPfhPMQdEZrEjL0U=zw@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/mce: Avoid infinite loop for copy from user recovery
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        x86 <x86@kernel.org>, "Song, Youquan" <youquan.song@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jul 22, 2021 at 5:14 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> I'm not aware of, nor expecting to find, places where the kernel
> tries to access user address A and hits poison, and then tries to
> access user address B (without returrning to user between access
> A and access B).
This seems a reasonablely easy scenario.

A user space app allocates a buffer of xyz KB/MB/GB.

Unfortunately the dimms are bad and multiple cache lines have
uncorrectable errors in them on different pages.

Then the user space app tries to write the content of the buffer into some
file via write(2) from the entire buffer in one go.

We have some test cases like this repros reliably with infinite MCE loop.

I believe the key here is that in the real world this will happen,
in particular the bit flips tend to be clustered physically -
same dimm row, dimm column, or same rank, same device etc.
>
> -Tony
