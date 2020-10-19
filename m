Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A04D29301C
	for <lists+linux-edac@lfdr.de>; Mon, 19 Oct 2020 22:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgJSU5J (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Oct 2020 16:57:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45614 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729102AbgJSU5J (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 19 Oct 2020 16:57:09 -0400
Received: from zn.tnic (p200300ec2f078400f40f8bdfb3e138f0.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:8400:f40f:8bdf:b3e1:38f0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 543901EC04A6;
        Mon, 19 Oct 2020 22:57:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603141028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=d8bXD+BEfEzDBRxynjIyczseYsQOXlXYbanXlnEkGbA=;
        b=FO8uYSQ44uV6Qk7qm1U1OTUC+v3Pb1kEMuVfRZ5Uhp8AuS1tRkvfzWJEjnatQEtBjtOOth
        9NPauF2orFLG79DSu8TcPwIE+Fk37W9oBlC3ZiTcwMel7WvG00WQeqLvAF5t+WRcC24gFI
        +r451Lgo91nEQLNnzr3wzLVDk+XuBTc=
Date:   Mon, 19 Oct 2020 22:56:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Raymond Bennett <raymond.bennett@gmail.com>
Cc:     linux-edac@vger.kernel.org, Jason Baron <jbaron@akamai.com>
Subject: Re: Constant output in syslog of EDAC message
Message-ID: <20201019205658.GI24325@zn.tnic>
References: <CAKpodDyWSY+Wt5Q04o5EyjZZU4PFST8U9UNcjwrJZ6C=Tc744g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKpodDyWSY+Wt5Q04o5EyjZZU4PFST8U9UNcjwrJZ6C=Tc744g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 19, 2020 at 01:37:16PM -0700, Raymond Bennett wrote:
> Hi,
> 
> I am seeing the constant output of the following messages in syslog,
> wondering what I can do to resolve this:
> 
> Oct 19 13:19:30 hostname kernel: EDAC DEBUG: ie31200_check: MC0

Looks like a debugging leftover. I'll remove it soon unless Jason (CCed)
screams. 

Leaving in the rest for him.
 
> It outputs about once every second.
> 
> uname -a
> Linux hostname 5.9.0-991.native #1 SMP Mon Oct 12 08:10:54 PDT 2020
> x86_64 GNU/Linux
> 
> /proc/cpuinfo
> processor : 7
> vendor_id : GenuineIntel
> cpu family : 6
> model : 158
> model name : Intel(R) Xeon(R) CPU E3-1505M v6 @ 3.00GHz
> stepping : 9
> microcode : 0xd6

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
