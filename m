Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6B3921CCB
	for <lists+linux-edac@lfdr.de>; Fri, 17 May 2019 19:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfEQRsZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 May 2019 13:48:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59880 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728057AbfEQRsZ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 17 May 2019 13:48:25 -0400
Received: from zn.tnic (p200300EC2F0C50007C4D1753FB652448.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:5000:7c4d:1753:fb65:2448])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5D29E1EC027A;
        Fri, 17 May 2019 19:48:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1558115303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2TvWTvagBsn2HvpkCcnxsPOiGMJZC0FXldUCG/8+Rn8=;
        b=lNjDu2B6zOqQ/WMhARwWi/xXdLA10vRAhfEqIt6tp4kYnE6vkQRjiKfUdXrer7oK9vBieg
        A8xlddY46uLKlRbnXKAo4MvRPav6gCzJK9b0dMshUmL+B5cbLye8tN+nmKMQ+vhYucR8n4
        +rT4YTpOQoDXKclarDkMxVI0pxivFqU=
Date:   Fri, 17 May 2019 19:48:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Message-ID: <20190517174817.GG13482@zn.tnic>
References: <20190516165648.GB21857@zn.tnic>
 <SN6PR12MB26392B440ED735C26AA2C678F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516172117.GC21857@zn.tnic>
 <SN6PR12MB26394CD4E1BAC068B0B1AEF6F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516203456.GD21857@zn.tnic>
 <20190516205943.GA3299@agluck-desk>
 <20190517101006.GA32065@zn.tnic>
 <SN6PR12MB26391A0C3979030082EE38F8F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190517163729.GE13482@zn.tnic>
 <20190517172648.GA18164@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190517172648.GA18164@agluck-desk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, May 17, 2019 at 10:26:49AM -0700, Luck, Tony wrote:
> Which is a quirk for some models where we don't want to do
> the "write all 1s and see what sticks"

Ok, then we have to do what you suggested yesterday. I've added a short
comment so that I don't get lost again next time.

---
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5bcecadcf4d9..9056f0a2a90d 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1493,6 +1493,11 @@ static int __mcheck_cpu_mce_banks_init(void)
 	for (i = 0; i < n_banks; i++) {
 		struct mce_bank *b = &mce_banks[i];
 
+		/*
+		 * Init them all, __mcheck_cpu_apply_quirks() is going to apply
+		 * the required vendor quirks before
+		 * __mcheck_cpu_init_clear_banks() does the final bank setup.
+		 */
 		b->ctl = -1ULL;
 		b->init = 1;
 	}
@@ -1562,15 +1567,21 @@ static void __mcheck_cpu_init_generic(void)
 static void __mcheck_cpu_init_clear_banks(void)
 {
 	struct mce_bank *mce_banks = this_cpu_read(mce_banks_array);
+	u64 msrval;
 	int i;
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		struct mce_bank *b = &mce_banks[i];
 
-		if (!b->init)
-			continue;
-		wrmsrl(msr_ops.ctl(i), b->ctl);
-		wrmsrl(msr_ops.status(i), 0);
+		if (b->init) {
+			/* Check if any bits are implemented in h/w */
+			wrmsrl(msr_ops.ctl(i), b->ctl);
+			rdmsrl(msr_ops.ctl(i), msrval);
+
+			b->init = !!msrval;
+
+			wrmsrl(msr_ops.status(i), 0);
+		}
 	}
 }
 
@@ -2095,6 +2106,9 @@ static ssize_t show_bank(struct device *s, struct device_attribute *attr,
 
 	b = &per_cpu(mce_banks_array, s->id)[bank];
 
+	if (!b->init)
+		return -ENODEV;
+
 	return sprintf(buf, "%llx\n", b->ctl);
 }
 
@@ -2113,6 +2127,9 @@ static ssize_t set_bank(struct device *s, struct device_attribute *attr,
 
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
