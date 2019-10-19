Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B014DD75D
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2019 10:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbfJSI0C (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 19 Oct 2019 04:26:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46322 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfJSI0B (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 19 Oct 2019 04:26:01 -0400
Received: from zn.tnic (p200300EC2F1CBC0070FC0520D48C2E42.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:bc00:70fc:520:d48c:2e42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DB6D1EC06F3;
        Sat, 19 Oct 2019 10:26:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571473560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=REP+ybro2mEQzoV+aJ3UJhTZLtqzjflFsIQSHxUaDwI=;
        b=Y17qfHdYnwZm2OjsDJ5D1aigWGQcp+RXrP2KNJOvI5zWpVkPM5nGOICmIofY/Uxe2VbNaT
        3vs+LeLTi1CoIybx+/UdJ7Z3bCCO32ON8M5Lm+Vx+u8avp09prscoEBokvz0odkekwYqR/
        5wwKOAWWeVCtvjJNvz5d7tOWP9OAkcg=
Date:   Sat, 19 Oct 2019 10:25:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jean-Frederic <jfgaudreault@gmail.com>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [GIT PULL] EDAC pile for 5.4 -> AMD family 17h, model 70h support
Message-ID: <20191019082554.GB5571@zn.tnic>
References: <CAEVokG4SSkgWS2N8eqr+h7AJg9CF26OW7vtXwOurCGU-4dsLbw@mail.gmail.com>
 <20191009103041.GC10395@zn.tnic>
 <724d6f97-61f2-94bd-3f4b-793a55b6ac15@amd.com>
 <CAEVokG4T5q8PBmf4=vLjPWQjzL_Xwu6yF81=mLjkpoJSoCggkw@mail.gmail.com>
 <20191010095650.GC7658@zn.tnic>
 <9f3ce002-7380-0e93-7bd5-20bb944d0b77@gmail.com>
 <20191010134128.GF7658@zn.tnic>
 <60b68d6c-5aff-3e7c-9461-c26a5f28cd87@amd.com>
 <79bca0d0-42eb-c232-6bbe-a958734e096d@gmail.com>
 <f5820b41-c97a-b6be-df97-bbff85a7e5ee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5820b41-c97a-b6be-df97-bbff85a7e5ee@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Oct 18, 2019 at 07:08:32PM -0400, Jean-Frederic wrote:
> I don't know if there has been any new information related to these last
> points, I am really looking to understand if ECC error reporting will be
> working in this new Kernel 5.4 for AMD Ryzen 3900x (or are we saying maybe
> this issue could be related to the motherboard?)

Look here on page 6:

https://www.amd.com/system/files/2017-06/AMD-EPYC-Brings-New-RAS-Capability.pdf

It hints at what PFEH does. Roughly speaking, the firmware gets to see
the errors first and because it knows the platform much better, it
can take much more adequate recovery for those actions than the OS.
Sometimes.

 [ I believe if the error cannot be handled by the firmware, it gets
   reported to the OS but I'll let Yazen comment on that. ]

In any case, you have RAS protection on your platform - it is just done
by the firmware and not by EDAC. And that is perfectly fine - EDAC is
used when there's no firmware support.

I know, I know, we don't trust the firmware to do it right and so on,
but it is what it is. Like other stuff we have to rely on the firmware
to do right.

> In any case, I think EDAC needs to be able to tell us (like at boot time)
> if the ECC error reporting is working on the system or not, because right
> now (in 5.4) everything appear to load successfully (according to dmesg)
> with all the memory information identified, and edac-util tool appear
> to be working (and returning zeros).

EDAC loads fine but there are simply no errors to report.

> Also, since this was working on the previous generation as mentioned before

See above.

> (i.e. AMD RYZEN 2700X and ASUS PRIME 470 to be more specific), I thought
> it would be natural that it works on the newer gen, given the
> information/hype provided around launch time.Asus also confirmed to me
> through their support that this new motherboard supports ecc. It also has
> an ECC option in the bios, as I've mentioned, to enable or disable ecc.

Again, you have RAS protection if your DIMMs are ECC ones. It is just
not done by the kernel but by the firmware. And that can be a better way
to do it *if* the firmware is doing its job right.

Makes more sense now?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
