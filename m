Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB7C447CD8
	for <lists+linux-edac@lfdr.de>; Mon,  8 Nov 2021 10:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238428AbhKHJeq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Nov 2021 04:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238427AbhKHJeq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Nov 2021 04:34:46 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41011C061570;
        Mon,  8 Nov 2021 01:32:02 -0800 (PST)
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 234ED1EC04CB;
        Mon,  8 Nov 2021 10:31:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636363919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=h2P/LNsljnY2z25eHjXfrbalNQAopI8XuC/MPUOiOeg=;
        b=bbedHRaR+iUfc85Q/LtqyY8fN7WM7vFvq8uyTEHnWtM4Bqg4bIgsenUX2TTXQULh2guDWM
        2zyYyeoqhlFmAGiWx4J7ogH6Aga+U/9nHipLllRNoBCtl3OjoNtlaQ8Ka0/7osFkTimIkW
        IXUkuIKtOozULHGi4wWcl0MVTqeOIgk=
Date:   Mon, 8 Nov 2021 10:31:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Zhaolong Zhang <zhangzl2013@126.com>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] x86/mce: drop cpu_missing since we have more capable
 mce_missing_cpus
Message-ID: <YYjuiHN1wKt82fjs@zn.tnic>
References: <572d793c.f2e.17cede4cbf0.Coremail.zhangzl2013@126.com>
 <20211108082832.142436-1-zhangzl2013@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211108082832.142436-1-zhangzl2013@126.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Nov 08, 2021 at 04:28:32PM +0800, Zhaolong Zhang wrote:
> move mce_missing_cpus checking into mce_panic() as well, because we don't want
> to lose the cpu missing information in case mca_cfg.tolerant > 1 and there is
> no_way_out.
> 
> Signed-off-by: Zhaolong Zhang <zhangzl2013@126.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 38 ++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 16 deletions(-)

I was actually expecting to see something like this:

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6ed365337a3b..30de00fe0d7a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -99,7 +99,6 @@ struct mca_config mca_cfg __read_mostly = {
 
 static DEFINE_PER_CPU(struct mce, mces_seen);
 static unsigned long mce_need_notify;
-static int cpu_missing;
 
 /*
  * MCA banks polled by the period polling timer for corrected events.
@@ -314,8 +313,6 @@ static void mce_panic(const char *msg, struct mce *final, char *exp)
 		if (!apei_err)
 			apei_err = apei_write_mce(final);
 	}
-	if (cpu_missing)
-		pr_emerg(HW_ERR "Some CPUs didn't answer in synchronization\n");
 	if (exp)
 		pr_emerg(HW_ERR "Machine check: %s\n", exp);
 	if (!fake_panic) {
@@ -891,7 +888,6 @@ static int mce_timed_out(u64 *t, const char *msg)
 					 cpumask_pr_args(&mce_missing_cpus));
 			mce_panic(msg, NULL, NULL);
 		}
-		cpu_missing = 1;
 		return 1;
 	}
 	*t -= SPINUNIT;
@@ -2702,7 +2698,6 @@ struct dentry *mce_get_debugfs_dir(void)
 
 static void mce_reset(void)
 {
-	cpu_missing = 0;
 	atomic_set(&mce_fake_panicked, 0);
 	atomic_set(&mce_executing, 0);
 	atomic_set(&mce_callin, 0);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
