Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58AFF1278B2
	for <lists+linux-edac@lfdr.de>; Fri, 20 Dec 2019 11:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfLTKBS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Dec 2019 05:01:18 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42598 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbfLTKBR (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 20 Dec 2019 05:01:17 -0500
Received: from zn.tnic (p200300EC2F0ED600DC469E28B29B59E9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d600:dc46:9e28:b29b:59e9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8EBC71EC0BED;
        Fri, 20 Dec 2019 11:01:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576836072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J9ZbXx7RpnpGdgXShhHuSdTfqcI201yCQjR96TrdpMw=;
        b=bj1zdVv6FHWicQElw4VdiT+haffgKB5M5KZUhRYbFllPOzdbC3KQwWc2dhBA2z5X81w4WL
        oQNrPPokyvAS3Q3+5rqj2n3mjuXJSoPB5EAfdiWTj6bJVt6Av0V/n/FLD/XvbGmBNoTOdY
        68tfxihXyAIhbtpx5d5KXMjsg/+MoiQ=
Date:   Fri, 20 Dec 2019 11:01:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jan =?utf-8?Q?H=2E_Sch=C3=B6nherr?= <jschoenh@amazon.de>
Cc:     Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH 4/6] x86/mce: Fix handling of optional message string
Message-ID: <20191220100106.GB1397@zn.tnic>
References: <20191210000733.17979-1-jschoenh@amazon.de>
 <20191210000733.17979-5-jschoenh@amazon.de>
 <20191216173737.GF17380@zn.tnic>
 <47be6ccd-0387-47c0-6f01-1304ce26780f@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47be6ccd-0387-47c0-6f01-1304ce26780f@amazon.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Dec 19, 2019 at 06:49:32PM +0100, Jan H. Schönherr wrote:
> Not quite. mce_panic() already handles NULL as a value for "exp" (not "msg").
> 
> We still need to pass NULL or a proper pointer. Not some uninitialized, potentially
> random data.
> 
> So, at the very least we need to initialize "tmp" in mce_no_way_out(), if you're looking
> for a minimal patch.

Yes, sure, this is what I'm thinking of.

And yes, I'm not going to cry if we don't print the immensely helpful
"Unknown" anymore.</sarcasm>

---
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 68dd4b358740..fd23f9f53379 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -798,7 +798,7 @@ EXPORT_SYMBOL_GPL(machine_check_poll);
 static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
 			  struct pt_regs *regs)
 {
-	char *tmp;
+	char *tmp = NULL;
 	int i;
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
@@ -1223,8 +1223,8 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
 	struct mca_config *cfg = &mca_cfg;
 	int cpu = smp_processor_id();
-	char *msg = "Unknown";
 	struct mce m, *final;
+	char *msg = NULL;
 	int worst = 0;
 
 	/*

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
