Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2451A3C350
	for <lists+linux-edac@lfdr.de>; Tue, 11 Jun 2019 07:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391144AbfFKFOB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 Jun 2019 01:14:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60420 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390539AbfFKFOA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 11 Jun 2019 01:14:00 -0400
Received: from zn.tnic (p200300EC2F0A6800B9C6921F36B00F7C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6800:b9c6:921f:36b0:f7c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5F38C1EC0982;
        Tue, 11 Jun 2019 07:13:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560230039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/4qpiIwUDNEVZoOIA+81jIxl/aQaH5UW2wmLcI0lJNI=;
        b=gCNOKqz+iDg5I9ne62GUb0I8Z9rBvZfwBX0dZ85/lH5d6XyuyBJYQeKxeM4UcopWn/aiNu
        rYlatEt03HGZ2EPUm9eHtzFw8oDVkrE+zozxje6MEUf8IBZvMG5UdiDfYD9qIeFjNGirDF
        YxjUWHUseHF5ysZVmxtukbjF2xb+yQA=
Date:   Tue, 11 Jun 2019 07:13:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Message-ID: <20190611051354.GA31772@zn.tnic>
References: <20190517172648.GA18164@agluck-desk>
 <20190517174817.GG13482@zn.tnic>
 <20190517180607.GA21710@agluck-desk>
 <20190517193431.GI13482@zn.tnic>
 <SN6PR12MB2639C5427366AC3004C35CC0F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190517200225.GK13482@zn.tnic>
 <SN6PR12MB26390759DB43763D3A482918F8010@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190527232849.GC8209@cz.tnic>
 <SN6PR12MB263998ECCDF1E345FEB0869AF8100@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190607163723.GG20269@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190607163723.GG20269@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jun 07, 2019 at 06:37:23PM +0200, Borislav Petkov wrote:
> On Fri, Jun 07, 2019 at 02:49:42PM +0000, Ghannam, Yazen wrote:
> > Would you mind if the function name stayed the same? The reason is
> > that MCA_CTL is written here, which is the "init" part, and MCA_STATUS
> > is cleared.
> >
> > I can use another name for the check, e.g. __mcheck_cpu_check_banks()
> > or __mcheck_cpu_banks_check_init().
> 
> Nevermind, leave it as is. I'll fix it up ontop. I don't like that
> "__mcheck_cpu_init" prefixing there which is a mouthful and should
> simply be "mce_cpu_<do_stuff>" to denote that it is a function which is
> run on a CPU to setup stuff.

So I'm staring at this and I can't say that I'm getting any good ideas:

I wanna get rid of that ugly "__mcheck_cpu_" prefix but the replacements
I can think of right now, are crap:

* I can call them all "cpu_<bla>" but then they look like generic
cpu-setup functions which come from kernel/cpu.c or so.

* I can prefix them with "mce_cpu" but when you do them all, it becomes
a block of "mce_cpu_" stuff which ain't more readable either. And
besides, those are static functions so they shouldn't need the prefix.
But I'd like the naming to denote that they're doing per-CPU setup
stuff. Which brings me to the previous point.

So no, don't have a good idea yet...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
