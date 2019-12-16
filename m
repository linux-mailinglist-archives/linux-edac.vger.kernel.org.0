Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 692E5121187
	for <lists+linux-edac@lfdr.de>; Mon, 16 Dec 2019 18:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfLPRQD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Dec 2019 12:16:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38836 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfLPRQD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 16 Dec 2019 12:16:03 -0500
Received: from zn.tnic (p200300EC2F07BC00D0F2C92C76B3ABC9.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:bc00:d0f2:c92c:76b3:abc9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C9DF1EC09A0;
        Mon, 16 Dec 2019 18:16:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576516562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Ddx9oMcQxXXgNVBRFItrRrDvoYW8pLDAP4socAnXY8=;
        b=bGs29lT8bGXzQDe+00Wt3s9tDXeewaESWGj7nP02Ycu02KKDlYOzWr2FvV6+FFZ4cCia4b
        UwncojO2y/l17YmclNMNZsNBispxuIsdjgnmb5DyjwE09iWmzVUB16Lk8TC0TUkdL24DUW
        5oE+ql3L1G7AQdYUuWppBzKlf0/SE4I=
Date:   Mon, 16 Dec 2019 18:15:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jan =?utf-8?Q?H=2E_Sch=C3=B6nherr?= <jschoenh@amazon.de>
Cc:     Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH 2/6] x86/mce: Make mce=nobootlog work again
Message-ID: <20191216171553.GD17380@zn.tnic>
References: <20191210000733.17979-1-jschoenh@amazon.de>
 <20191210000733.17979-3-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191210000733.17979-3-jschoenh@amazon.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 10, 2019 at 01:07:29AM +0100, Jan H. Schönherr wrote:
> Since Linux 4.5 commit 8b38937b7ab5 ("x86/mce: Do not enter deferred

You don't have to go figure out the kernel version each time you quote
a commit - most people should be able to do git describe or git tag
--contains :)

> errors into the generic pool twice") the mce=nobootlog option has become
> mostly ineffective (after being only slightly ineffective before), as
> the code is taking actions on MCEs left over from boot when they have a
> usable address.
> 
> Move the check for MCP_DONTLOG a bit outward to make it effective again.
> 
> Also, since Linux 4.12 commit 011d82611172 ("RAS: Add a Corrected Errors
> Collector") the two branches of the remaining "if" the bottom of
> machine_check_poll() do the same. Unify them.
> 
> Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index d5a8b99f7ba3..81ab25d5357a 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -760,24 +760,17 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
>  log_it:
>  		error_seen = true;
>  
> -		mce_read_aux(&m, i);
> -
> -		m.severity = mce_severity(&m, mca_cfg.tolerant, NULL, false);
> -
> -		/*
> -		 * Don't get the IP here because it's unlikely to
> -		 * have anything to do with the actual error location.
> -		 */
> -		if (!(flags & MCP_DONTLOG) && !mca_cfg.dont_log_ce)
> -			mce_log(&m);
> -		else if (mce_usable_address(&m)) {
> +		if (!(flags & MCP_DONTLOG)) {

I hate that double-negation logic we have in the code. :-\

	if (! ... DONT...

Can you pls flip the logic here?

	if (flags & MCP_DONTLOG)
		goto clear_bank;

	/* logging code */

clear_bank:
	mce_wrmsrl(msr_ops.status(i), 0);

This way you'll save an indentation level too. Something like this (I
took your patch and mangled it):

---
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5f42f25bac8f..2b43caaba70d 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -763,29 +763,20 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 log_it:
 		error_seen = true;
 
-		mce_read_aux(&m, i);
+		if (flags & MCP_DONTLOG)
+			goto clear_bank;
 
+		mce_read_aux(&m, i);
 		m.severity = mce_severity(&m, mca_cfg.tolerant, NULL, false);
 
 		/*
-		 * Don't get the IP here because it's unlikely to
-		 * have anything to do with the actual error location.
+		 * Don't get the IP here because it's unlikely to have anything
+		 * to do with the actual error location.
 		 */
-		if (!(flags & MCP_DONTLOG) && !mca_cfg.dont_log_ce)
+		if (!mca_cfg.dont_log_ce || mce_usable_address(&m))
 			mce_log(&m);
-		else if (mce_usable_address(&m)) {
-			/*
-			 * Although we skipped logging this, we still want
-			 * to take action. Add to the pool so the registered
-			 * notifiers will see it.
-			 */
-			if (!mce_gen_pool_add(&m))
-				mce_schedule_work();
-		}
 
-		/*
-		 * Clear state for this bank.
-		 */
+clear_bank:
 		mce_wrmsrl(msr_ops.status(i), 0);
 	}
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
