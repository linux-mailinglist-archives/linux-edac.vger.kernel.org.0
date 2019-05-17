Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10866216BC
	for <lists+linux-edac@lfdr.de>; Fri, 17 May 2019 12:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfEQKKK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 May 2019 06:10:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49482 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbfEQKKK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 17 May 2019 06:10:10 -0400
Received: from zn.tnic (p200300EC2F0C500058FF0EE6A54CD1FB.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:5000:58ff:ee6:a54c:d1fb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 76A611EC0283;
        Fri, 17 May 2019 12:10:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1558087808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tuDeMaO7OLd0hq29haI35+LnUBzOtHJxdEaRXdXIzYY=;
        b=klVdSO4Ff0pC+sz1HXFdIAyT5RdIjCIOqRWtifeeQqZhmAKjVu/L8xyGvsgyfghOMJa1L+
        71JblgD7tVrj6vJfry40JsuxrgviJGG+1cCEJp9IsL6FHFSmDl356p6LtIDWbvyvgYlCgR
        PTOmFtuvjfAiYU9+mpGJwSYEcEAp4ks=
Date:   Fri, 17 May 2019 12:10:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Message-ID: <20190517101006.GA32065@zn.tnic>
References: <20190430203206.104163-1-Yazen.Ghannam@amd.com>
 <20190430203206.104163-6-Yazen.Ghannam@amd.com>
 <20190516155202.GA11517@agluck-desk>
 <SN6PR12MB26397B30A120E3426184727FF80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516165648.GB21857@zn.tnic>
 <SN6PR12MB26392B440ED735C26AA2C678F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516172117.GC21857@zn.tnic>
 <SN6PR12MB26394CD4E1BAC068B0B1AEF6F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516203456.GD21857@zn.tnic>
 <20190516205943.GA3299@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190516205943.GA3299@agluck-desk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 16, 2019 at 01:59:43PM -0700, Luck, Tony wrote:
> I think the intent of the original patch was to find out
> which bits are "implemented in hardware". I.e. throw all
> 1's at the register and see if any of them stick.

And, in addition, check ->init before showing/setting a bank:

---
@@ -2095,6 +2098,9 @@ static ssize_t show_bank(struct device *s, struct device_attribute *attr,
 
        b = &per_cpu(mce_banks_array, s->id)[bank];
 
+       if (!b->init)
+               return -ENODEV;
+
        return sprintf(buf, "%llx\n", b->ctl);
 }
 
@@ -2113,6 +2119,9 @@ static ssize_t set_bank(struct device *s, struct device_attribute *attr,
 
        b = &per_cpu(mce_banks_array, s->id)[bank];
 
+       if (!b->init)
+               return -ENODEV;
+
        b->ctl = new;
        mce_restart();
---

so that you get a feedback whether the setting has even succeeded or
not. Right now we're doing "something" blindly and accepting any b->ctl
from userspace. Yeah, it is root-only but still...

> I don't object to the idea behind the patch. But if you want
> to do this you just should not modify b->ctl.
> 
> So something like:
> 	
> 
> static void __mcheck_cpu_init_clear_banks(void)
> {
>         struct mce_bank *mce_banks = this_cpu_read(mce_banks_array);
> 	u64 tmp;
>         int i;
> 
>         for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
>                 struct mce_bank *b = &mce_banks[i];
> 
>                 if (b->init) {
>                         wrmsrl(msr_ops.ctl(i), b->ctl);
>                         wrmsrl(msr_ops.status(i), 0);
> 			rdmsrl(msr_ops.ctl(i), tmp);
> 
> 			/* Check if any bits implemented in h/w */
> 			b->init = !!tmp;
>                 }

... except that we unconditionally set ->init to 1 in
__mcheck_cpu_mce_banks_init() and I think we should query it. Btw, that
name __mcheck_cpu_mce_banks_init() is hideous too. I'll fix those up. In
the meantime, how does the below look like? The change is to tickle out
from the hw whether some CTL bits stick and then use that to determine
b->init setting:

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

 [ bp: Massage a bit. Discover bank init state at boot. ]

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
 arch/x86/kernel/cpu/mce/core.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5bcecadcf4d9..d84b0c707d0e 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1492,9 +1492,16 @@ static int __mcheck_cpu_mce_banks_init(void)
 
 	for (i = 0; i < n_banks; i++) {
 		struct mce_bank *b = &mce_banks[i];
+		u64 val;
 
 		b->ctl = -1ULL;
-		b->init = 1;
+
+		/* Check if any bits are implemented in h/w */
+		wrmsrl(msr_ops.ctl(i), b->ctl);
+		rdmsrl(msr_ops.ctl(i), val);
+		b->init = !!val;
+
+		wrmsrl(msr_ops.status(i), 0);
 	}
 
 	per_cpu(mce_banks_array, smp_processor_id()) = mce_banks;
@@ -1567,10 +1574,10 @@ static void __mcheck_cpu_init_clear_banks(void)
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
 	}
 }
 
@@ -2095,6 +2102,9 @@ static ssize_t show_bank(struct device *s, struct device_attribute *attr,
 
 	b = &per_cpu(mce_banks_array, s->id)[bank];
 
+	if (!b->init)
+		return -ENODEV;
+
 	return sprintf(buf, "%llx\n", b->ctl);
 }
 
@@ -2113,6 +2123,9 @@ static ssize_t set_bank(struct device *s, struct device_attribute *attr,
 
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
