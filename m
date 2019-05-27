Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C78B62BC55
	for <lists+linux-edac@lfdr.de>; Tue, 28 May 2019 01:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfE0X24 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 May 2019 19:28:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48212 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbfE0X24 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 May 2019 19:28:56 -0400
Received: from cz.tnic (ip65-44-65-130.z65-44-65.customer.algx.net [65.44.65.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0FB4F1EC014A;
        Tue, 28 May 2019 01:28:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1558999734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4boZRYbDewKcWSBP8hW7Mh603R2vEYr8FGHA70RdWpM=;
        b=B9Jl0kyItn6ITDRm37alHV7lzQzKkoUMJxw//AVu8ZBRTag8eo10IKCexB/JGcL71NutXU
        Sh/9lGg813kZ78dsc1xwQwBWxmTvsn5zxMB8phDxFF0mRYHcso3JN08elS7JAYuUk9WTt9
        06FiYBPQ5W6PnVTWxU2Ko+WosaMyEDU=
Date:   Tue, 28 May 2019 01:28:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Message-ID: <20190527232849.GC8209@cz.tnic>
References: <20190517101006.GA32065@zn.tnic>
 <SN6PR12MB26391A0C3979030082EE38F8F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190517163729.GE13482@zn.tnic>
 <20190517172648.GA18164@agluck-desk>
 <20190517174817.GG13482@zn.tnic>
 <20190517180607.GA21710@agluck-desk>
 <20190517193431.GI13482@zn.tnic>
 <SN6PR12MB2639C5427366AC3004C35CC0F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190517200225.GK13482@zn.tnic>
 <SN6PR12MB26390759DB43763D3A482918F8010@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB26390759DB43763D3A482918F8010@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 23, 2019 at 08:00:33PM +0000, Ghannam, Yazen wrote:
> I did a bit more testing and I noticed that writing "0" disables a bank with no way to reenable it.
> 
> For example:
> 1) Read bank10.
> 	a) Succeeds; returns "fffffffffffffff".
> 2) Write "0" to bank10.
> 	a) Succeeds; hardware register is set to "0".
> 	b) Hardware register is checked, and b->init=0.
> 3) Read bank10.
> 	a) Fails, because b->init=0.
> 4) Write non-zero value to bank10 to reenable it.
> 	a) Fails, because b->init=0.
> 5) Reboot needed to reset bank.
> 
> Is that okay?

Nope, that doesn't sound correct to me.

I guess the cleanest way to handle his properly would be to have a
function called something like __mcheck_cpu_init_banks() which gets
called in mcheck_cpu_init() after the quirks have run and then does the
final poking of the banks and sets b->init properly.

__mcheck_cpu_init_clear_banks() should then be renamed to
__mcheck_cpu_clear_banks() to denote that it only clears the banks and
would only do:

                if (!b->init)
                        continue;

                wrmsrl(msr_ops.ctl(i), b->ctl);
                wrmsrl(msr_ops.status(i), 0);

And then sprinkle some commenting to not forget the scheme again.

Yeah, this sounds clean to me but you guys might have a better idea...

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply. Srsly.
