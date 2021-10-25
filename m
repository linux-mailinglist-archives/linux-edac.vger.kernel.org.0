Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353D84397EE
	for <lists+linux-edac@lfdr.de>; Mon, 25 Oct 2021 15:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhJYN7I (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Oct 2021 09:59:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39238 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhJYN7I (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 25 Oct 2021 09:59:08 -0400
Received: from zn.tnic (p200300ec2f0f4e00a9aecab73d80ddb1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4e00:a9ae:cab7:3d80:ddb1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C85941EC04F2;
        Mon, 25 Oct 2021 15:56:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635170204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9vcw/G3G8TQiJIk2OJLutgGZViY71B8IEbfeewsQb/U=;
        b=rgfokybylLH9QkNR9EtK6heI0+s1mfTbk62b6DqtZyIjWUNyejE/sj31AiYx7rE1t6KP1K
        e1m5ymVhAe6pF+23oSydWnReCRtIVQXrMGKGa8h53Yf2FtX1Rgfh7g1r5YnVj/xOHOIk6W
        OIA8uJY3zO4jhBFCZMTrEs11Db5vV5Y=
Date:   Mon, 25 Oct 2021 15:56:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, yazen.ghannam@amd.com
Subject: Re: [PATCH v2 1/5] x86/mce/inject: Check if a bank is unpopulated
 before error injection
Message-ID: <YXa3m7SWAhRcFi35@zn.tnic>
References: <20211019233641.140275-1-Smita.KoralahalliChannabasappa@amd.com>
 <20211019233641.140275-2-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211019233641.140275-2-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Oct 19, 2021 at 06:36:37PM -0500, Smita Koralahalli wrote:
> The MCA_IPID register uniquely identifies a bank's type on Scalable MCA
> (SMCA) systems. When an MCA bank is not populated, the MCA_IPID register
> will read as zero and writes to it will be ignored.
> 
> On a "hw" error injection check the value of this register before trying
> to inject the error.
> 
> Do not impose any limitation on a "sw" injection and allow the user to
> test out all the decoding paths without relying on the available hardware,
> as its purpose is to just test the code.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
> v2:
> 	simulate -> inject.
> 	Corrected according to kernel commenting style.
> 	boot_cpu_has() -> cpu_feature_enabled().
> 	Error simulation not possible: Bank %llu unpopulated ->
> 	Cannot set IPID - bank %llu unpopulated.
> 	Used user provided IPID value on sw injection without checking
> 	underlying hardware and defined it under inj_ipid_set().
> ---
>  arch/x86/kernel/cpu/mce/inject.c | 39 +++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)

So I gave it a critical look and did some modifications, see below.
Looking at those IPID MSRs - they're all read-only, which means for !sw
injection, all the module can do is check whether they're 0 - and fail
injection in that case - and do the injection otherwise.

Ok?

---
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Date: Tue, 19 Oct 2021 18:36:37 -0500
Subject: [PATCH] x86/mce/inject: Check if a bank is populated before error
 injection

The MCA_IPID register uniquely identifies a bank's type on Scalable MCA
(SMCA) systems. When an MCA bank is not populated, the MCA_IPID register
will read as zero and writes to it will be ignored.

On a hw-type error injection (injection which writes the actual MCA
registers in an attempt to cause a real MCE) check the value of this
register before trying to inject the error.

Do not impose any limitation on a sw-type injection (software-only
injection) and allow the user to test out all the decoding paths without
relying on the available hardware, as its purpose is to just test the
code.

 [ bp: Heavily massage. ]

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211019233641.140275-2-Smita.KoralahalliChannabasappa@amd.com
---
 arch/x86/kernel/cpu/mce/inject.c | 42 +++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 0bfc14041bbb..3333ae7886bd 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -74,7 +74,6 @@ MCE_INJECT_SET(status);
 MCE_INJECT_SET(misc);
 MCE_INJECT_SET(addr);
 MCE_INJECT_SET(synd);
-MCE_INJECT_SET(ipid);
 
 #define MCE_INJECT_GET(reg)						\
 static int inj_##reg##_get(void *data, u64 *val)			\
@@ -95,6 +94,20 @@ DEFINE_SIMPLE_ATTRIBUTE(status_fops, inj_status_get, inj_status_set, "%llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(misc_fops, inj_misc_get, inj_misc_set, "%llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(addr_fops, inj_addr_get, inj_addr_set, "%llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(synd_fops, inj_synd_get, inj_synd_set, "%llx\n");
+
+/* Use the user provided IPID value on a sw injection. */
+static int inj_ipid_set(void *data, u64 val)
+{
+	struct mce *m = (struct mce *)data;
+
+	if (cpu_feature_enabled(X86_FEATURE_SMCA)) {
+		if (inj_type == SW_INJ)
+			m->ipid = val;
+	}
+
+	return 0;
+}
+
 DEFINE_SIMPLE_ATTRIBUTE(ipid_fops, inj_ipid_get, inj_ipid_set, "%llx\n");
 
 static void setup_inj_struct(struct mce *m)
@@ -577,6 +590,33 @@ static int inj_bank_set(void *data, u64 val)
 	}
 
 	m->bank = val;
+
+	/*
+	 * sw-only injection allows to write arbitrary values into the MCA registers
+	 * because it tests only the decoding paths.
+	 */
+	if (inj_type == SW_INJ)
+		goto inject;
+
+	/*
+	 * Read IPID value to determine if a bank is populated on the target
+	 * CPU.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_SMCA)) {
+		u64 ipid;
+
+		if (rdmsrl_on_cpu(m->extcpu, MSR_AMD64_SMCA_MCx_IPID(val), &ipid)) {
+			pr_err("Error reading IPID on CPU%d\n", m->extcpu);
+			return -EINVAL;
+		}
+
+		if (!ipid) {
+			pr_err("Cannot inject into bank %llu - it is unpopulated\n", val);
+			return -ENODEV;
+		}
+	}
+
+inject:
 	do_inject();
 
 	/* Reset injection struct */
-- 
2.29.2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
