Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98984797A8
	for <lists+linux-edac@lfdr.de>; Sat, 18 Dec 2021 00:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhLQXuz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Dec 2021 18:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhLQXuv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 17 Dec 2021 18:50:51 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426FCC061574;
        Fri, 17 Dec 2021 15:50:51 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C05E11EC0554;
        Sat, 18 Dec 2021 00:50:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639785045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YPKeZYlefOhxteGkcbA54NxsqWdhrSSYYoWIVlRd0ng=;
        b=VAXNqiqTkK0dF48MdOSar6dv1qPP3flE7IRjIX6689gq9/ICLDI+4LWGxnR5fzBUn/GzbW
        eGEb2yQe9F06bznfSKF0aTWsr8P+m9ioi3PMSXUfG1V6dKbjMg0rL5Wny5HWHbSLjxmoKn
        If/zlKLrPDq2BtB8wcowTU3sJhym0jc=
Date:   Sat, 18 Dec 2021 00:50:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-edac@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/mce: Check regs before accessing it
Message-ID: <Yb0iWLMtGxRvVuQ2@zn.tnic>
References: <20211217102029.GA29708@kili>
 <Ybx0qV3S61Hjj+jw@zn.tnic>
 <YbzFQ40JUftkpeKi@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbzFQ40JUftkpeKi@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Commit in Fixes accesses pt_regs before checking whether it is NULL or
not. Change the flow so that the NULL pointer check happens first.

Fixes: 0a5b288e85bb ("x86/mce: Prevent severity computation from being instrumented")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20211217102029.GA29708@kili
---
 arch/x86/kernel/cpu/mce/severity.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index a32646769705..7aa2bda93cbb 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -222,6 +222,9 @@ static bool is_copy_from_user(struct pt_regs *regs)
 	struct insn insn;
 	int ret;
 
+	if (!regs)
+		return false;
+
 	if (copy_from_kernel_nofault(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
 		return false;
 
@@ -283,7 +286,7 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 	switch (fixup_type) {
 	case EX_TYPE_UACCESS:
 	case EX_TYPE_COPY:
-		if (!regs || !copy_user)
+		if (!copy_user)
 			return IN_KERNEL;
 		m->kflags |= MCE_IN_KERNEL_COPYIN;
 		fallthrough;
-- 
2.29.2


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
