Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8B4DB271E
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2019 23:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbfIMVQa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 13 Sep 2019 17:16:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44520 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfIMVQ3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 13 Sep 2019 17:16:29 -0400
Received: from zn.tnic (p200300EC2F0DC5000404141DC4C18A6D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c500:404:141d:c4c1:8a6d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8B6A71EC085F;
        Fri, 13 Sep 2019 23:16:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1568409388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=D0Rj9fr4WuHRasK1bMNdML9YiLsUrLgI9Q4vQ2c910M=;
        b=Yq3seii6H+FqPB86PKKgrugKeezhOkH/bPl6Ud/NHRdd8WHNrqA/icXUH5fE5cSg7XQbBI
        GeAl1NG54LDvDQEWZ/v//+LeHAyzbjVAhTcuA4MDbKG2jVMb5iqd4UISovvip3sk+gRYIU
        4rKwQH0+8YZrocQCS4cbnhxlp9vDRQw=
Date:   Fri, 13 Sep 2019 23:16:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "qiuxu.zhuo@intel.com" <qiuxu.zhuo@intel.com>,
        David Wang <DavidWang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Subject: Re: [PATCH v3 1/4] x86/mce: Add Zhaoxin MCE support
Message-ID: <20190913211620.GE4190@zn.tnic>
References: <9d6769dca6394638a013ccad2c8f964c@zhaoxin.com>
 <20190913181031.GA9940@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190913181031.GA9940@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Sep 13, 2019 at 11:10:31AM -0700, Luck, Tony wrote:
> Is it time to have a big cleanup on how we handle similarities
> and oddities in the MCE subsystem?  We've been adding ad-hoc
> tests like this in random places ... and it all looks very
> messy.

Hohum, it has been bothering me for a while now too. ;-\

> Or should we make a big table of CPU vendors/families/models and use
> x86_match_cpu() to pick out what are running on and set some bits/flags
> (like X86_FEATURE/X86_BUG) which we can use in the code to do the
> right thing in each place?

Yes, that. And I have started doing something along those lines, see
struct mce_vendor_flags.

If we did the X86_FEATURE/BUG things, we would still end up using those
new definitions in the MCA code only so I think having our own bits in a
bitfield would be cleaner/nicer.

Anyway, detection can be all done in __mcheck_cpu_init_early() or
somewhere similar, all matching flags/bits set and then the rest of the
code would query only them.

We can also merge mce_vendor_flags into mca_cfg as that thing is used
everywhere.

Another advantage of having our own flags is that we can define them as
we like and stick them all in internal.h so no exposure to the outside.

And so on.

> E.g. default for Intel and Zhaoxin vendors would be to set MCE_INTEL_LIKE.
> 
> Thoughts?

Yah, I think that's a good idea and I think we should do it. Not
immediately but work towards it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
