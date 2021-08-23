Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815673F5270
	for <lists+linux-edac@lfdr.de>; Mon, 23 Aug 2021 22:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhHWUve (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Aug 2021 16:51:34 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44150 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232237AbhHWUvd (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Aug 2021 16:51:33 -0400
Received: from zn.tnic (p200300ec2f07d9005f98ffa3f2e7b729.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:d900:5f98:ffa3:f2e7:b729])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C2B91EC01A8;
        Mon, 23 Aug 2021 22:50:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629751845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AomjuaB9jMg2wcfJFA3L7I9BGK9tS3g1i0Fvch3Ea9s=;
        b=VE95vq8VMp/IV5hkFvitQWywylHcWkLyWk8bgqlLf7E9qfKgIsfffYcZHTSJSdmM5g92u4
        QcrctQiVL81mxQly6WbE3gp2N8BkKExIqu4hv060CZi8h0fjU+F/rEV6E17HNRucOQzLoF
        hbrFw2Ia7sKgotKAzbQRgnxgIuOizpQ=
Date:   Mon, 23 Aug 2021 22:51:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sumanth Kamatala <skamatala@juniper.net>
Subject: Re: [PATCH v2] x86/mce: Defer processing early errors until
 mcheck_late_init()
Message-ID: <YSQKT0NPrx6puVUQ@zn.tnic>
References: <20210819224452.1619400-1-tony.luck@intel.com>
 <YR+f/fdGIxWcLTP2@zn.tnic>
 <20210820144314.GA1622759@agluck-desk2.amr.corp.intel.com>
 <YR/Oxark0bhLlona@zn.tnic>
 <20210823184547.GA1638691@agluck-desk2.amr.corp.intel.com>
 <20210823204122.GA1640015@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210823204122.GA1640015@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Aug 23, 2021 at 01:41:22PM -0700, Luck, Tony wrote:
>  arch/x86/kernel/cpu/mce/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

I actually had a different idea in mind, considering the fact that some
machinery to only log the early MCEs is already there. And this fits
more naturally in the flow and doesn't need a bool switch.

Hmmm?

---
diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 0607ec4f5091..9b13cca74f65 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -265,6 +265,7 @@ enum mcp_flags {
 	MCP_TIMESTAMP	= BIT(0),	/* log time stamp */
 	MCP_UC		= BIT(1),	/* log uncorrected errors */
 	MCP_DONTLOG	= BIT(2),	/* only clear, don't log */
+	MCP_LOG_ONLY	= BIT(3),	/* log only */
 };
 bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 22791aadc085..bb691503c2e4 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -817,7 +817,10 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		if (mca_cfg.dont_log_ce && !mce_usable_address(&m))
 			goto clear_it;
 
-		mce_log(&m);
+		if (flags & MCP_LOG_ONLY)
+			mce_gen_pool_add(&m);
+		else
+			mce_log(&m);
 
 clear_it:
 		/*
@@ -1639,10 +1642,12 @@ static void __mcheck_cpu_init_generic(void)
 		m_fl = MCP_DONTLOG;
 
 	/*
-	 * Log the machine checks left over from the previous reset.
+	 * Log the machine checks left over from the previous reset. Log them
+	 * only, do not start processing them. That will happen in mcheck_late_init()
+	 * when all consumers have been registered on the notifier chain.
 	 */
 	bitmap_fill(all_banks, MAX_NR_BANKS);
-	machine_check_poll(MCP_UC | m_fl, &all_banks);
+	machine_check_poll(MCP_UC | MCP_LOG_ONLY | m_fl, &all_banks);
 
 	cr4_set_bits(X86_CR4_MCE);
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
