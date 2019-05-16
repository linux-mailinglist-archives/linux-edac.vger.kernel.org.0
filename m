Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA0F520DCC
	for <lists+linux-edac@lfdr.de>; Thu, 16 May 2019 19:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfEPRV0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 May 2019 13:21:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51634 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbfEPRVZ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 May 2019 13:21:25 -0400
Received: from zn.tnic (p200300EC2F0D4A003151DF689BFB5B9C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:4a00:3151:df68:9bfb:5b9c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B33C1EC0283;
        Thu, 16 May 2019 19:21:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1558027284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JCIZxYrE9KDZAt3pwKYx4Xvd9dz8k7cJKOtbl1+sdow=;
        b=DkbFR1ODHCCbk0k06Ynorgo9cN44FBJnpqnyz2EZG1pv9/xf5yLogHkHUXB+blWyCQQc3d
        qY64wkynyQYCvJt49l9u4q6scD4ujoTVb5W7DPO+Xi/Lqg49YmVT5fLGVDr2ZW8uaIqJy+
        a3H+3E2ZwVIUOLhiNC3n747WnBkyBwI=
Date:   Thu, 16 May 2019 19:21:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Message-ID: <20190516172117.GC21857@zn.tnic>
References: <20190430203206.104163-1-Yazen.Ghannam@amd.com>
 <20190430203206.104163-6-Yazen.Ghannam@amd.com>
 <20190516155202.GA11517@agluck-desk>
 <SN6PR12MB26397B30A120E3426184727FF80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516165648.GB21857@zn.tnic>
 <SN6PR12MB26392B440ED735C26AA2C678F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB26392B440ED735C26AA2C678F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 16, 2019 at 05:09:11PM +0000, Ghannam, Yazen wrote:
> So that the sysfs files show the control values that are set in the
> hardware. It seemed like this would be more helpful than showing all
> 0xF's.

Yeah, but it has been like that since forever and it hasn't bugged
anybody. Probably because anybody doesn't even look at those files. As
Tony says:

"RAS is a lonely subsystem ... even EDAC gets more love."

:-)))

And adding yet another vendor check for this seemed just not worth it.

> Should I send out another version of this set?

I simply zapped 5/6. I still think your 6/6 makes sense though.

---
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 30 Apr 2019 20:32:21 +0000
Subject: [PATCH] x86/MCE: Determine MCA banks' init state properly

The OS is expected to write all bits to MCA_CTL for each bank,
thus enabling error reporting in all banks. However, some banks
may be unused in which case the registers for such banks are
Read-as-Zero/Writes-Ignored. Also, the OS may avoid setting some control
bits because of quirks, etc.

A bank can be considered uninitialized if the MCA_CTL register returns
zero. This is because either the OS did not write anything or because
the hardware is enforcing RAZ/WI for the bank.

Set a bank's init value based on if the control bits are set or not in
hardware. Return an error code in the sysfs interface for uninitialized
banks.

 [ bp: Massage a bit. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190430203206.104163-7-Yazen.Ghannam@amd.com
---
 arch/x86/kernel/cpu/mce/core.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5bcecadcf4d9..c049689f3d73 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1567,10 +1567,13 @@ static void __mcheck_cpu_init_clear_banks(void)
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		struct mce_bank *b = &mce_banks[i];
 
-		if (!b->init)
-			continue;
-		wrmsrl(msr_ops.ctl(i), b->ctl);
-		wrmsrl(msr_ops.status(i), 0);
+		if (b->init) {
+			wrmsrl(msr_ops.ctl(i), b->ctl);
+			wrmsrl(msr_ops.status(i), 0);
+		}
+
+		/* Bank is initialized if bits are set in hardware. */
+		b->init = !!b->ctl;
 	}
 }
 
@@ -2095,6 +2098,9 @@ static ssize_t show_bank(struct device *s, struct device_attribute *attr,
 
 	b = &per_cpu(mce_banks_array, s->id)[bank];
 
+	if (!b->init)
+		return -ENODEV;
+
 	return sprintf(buf, "%llx\n", b->ctl);
 }
 
@@ -2113,6 +2119,9 @@ static ssize_t set_bank(struct device *s, struct device_attribute *attr,
 
 	b = &per_cpu(mce_banks_array, s->id)[bank];
 
+	if (!b->init)
+		return -ENODEV;
+
 	b->ctl = new;
 	mce_restart();
 
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
