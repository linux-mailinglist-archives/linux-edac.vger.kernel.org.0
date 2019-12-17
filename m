Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADF71225EF
	for <lists+linux-edac@lfdr.de>; Tue, 17 Dec 2019 08:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfLQHyE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Dec 2019 02:54:04 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40972 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbfLQHyE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 17 Dec 2019 02:54:04 -0500
Received: from zn.tnic (p200300EC2F0BBF00D423EC4793E13B2B.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:bf00:d423:ec47:93e1:3b2b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3C4441EC0C9C;
        Tue, 17 Dec 2019 08:54:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576569243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bRRPLwpHzOt2xZPhIDBu2caULRFpQfO1a3EOTMqwHkQ=;
        b=LQJUaOR99M4qnR1l+1odlkzq+fcdJ98rsUfalrcAaypsEVG2cHk0OHYs8LK/QA33NVFjgV
        Lt6ex9BOiRnb8jGtqCX0REh/rvwH2KDCspkdWuvq5zfMB1XiRf0fLWy0eb7RR6WdwXrDFW
        rzrIMmgY2VAEClX9ZrhCjh634wObLPo=
Date:   Tue, 17 Dec 2019 08:53:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/MCE/AMD: fix warning about sleep-in-atomic at early
 boot
Message-ID: <20191217075355.GA15129@zn.tnic>
References: <157252708836.3876.4604398213417262402.stgit@buzz>
 <20191031142955.GA23693@nazgul.tnic>
 <ad7a25d9-1ca5-0791-ae0a-63c524040bcb@yandex-team.ru>
 <20191107105310.GD19501@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191107105310.GD19501@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Nov 07, 2019 at 11:53:10AM +0100, Borislav Petkov wrote:
> On Fri, Nov 01, 2019 at 04:39:17PM +0300, Konstantin Khlebnikov wrote:
> > I tried 5.4 once but there was no warning.
> > Code in 4.19 and in mainline almost the same.
> 
> Yes, but early boot code has changed a lot since 4.19. If you can't
> trigger it on 5.4, then I'll drop the BUG splat from your commit message
> and change it to talk about replacing the IPI-sending function, which is
> a good cleanup in itself.

Ok, I was able to trigger it myself:

[    0.822602] BUG: sleeping function called from invalid context at kernel/sched/completion.c:99
[    0.822602] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
[    0.822602] no locks held by swapper/1/0.
[    0.822602] irq event stamp: 0
[    0.822602] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[    0.822602] hardirqs last disabled at (0): [<ffffffff8106dda9>] copy_process+0x8b9/0x1ca0
[    0.822602] softirqs last  enabled at (0): [<ffffffff8106dda9>] copy_process+0x8b9/0x1ca0
[    0.822602] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    0.822602] Preemption disabled at:
[    0.822602] [<ffffffff8104703b>] start_secondary+0x3b/0x190
[    0.822602] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.5.0-rc2+ #1
[    0.822602] Hardware name: GIGABYTE MZ01-CE1-00/MZ01-CE1-00, BIOS F02 08/29/2018
[    0.822602] Call Trace:
[    0.822602]  dump_stack+0x71/0xa0
[    0.822602]  ___might_sleep.cold.92+0xf7/0x11f
[    0.822602]  wait_for_completion+0x3c/0x180
[    0.822602]  ? generic_exec_single+0xca/0x100
[    0.822602]  rdmsr_safe_on_cpu+0xe8/0x100
[    0.822602]  ? wrmsr_on_cpus+0x20/0x20
[    0.822602]  mce_amd_feature_init+0x2ab/0x590
[    0.822602]  mcheck_cpu_init+0x17a/0x4d0
[    0.822602]  identify_cpu+0x3f0/0x750
[    0.822602]  identify_secondary_cpu+0x13/0x80
[    0.822602]  smp_store_cpu_info+0x45/0x50
[    0.822602]  start_secondary+0x50/0x190
[    0.822602]  secondary_startup_64+0xa4/0xb0

Rerouting patch...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
