Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AFB6550F5
	for <lists+linux-edac@lfdr.de>; Fri, 23 Dec 2022 14:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiLWNX6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Dec 2022 08:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbiLWNXh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 23 Dec 2022 08:23:37 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5234AF22;
        Fri, 23 Dec 2022 05:23:12 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9A2571EC0716;
        Fri, 23 Dec 2022 14:23:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1671801790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SSvDsZpTjzmrUNmjyZT5I2QHEjJaFSOc5HqeqmJ/KDs=;
        b=Z0k+/b49p2pLiHOwTv71cT+c0uqCQo5Qig6N/jS+AbXYF3yqw/F56MXVprdE/JJyFb3/xP
        QQE7sZDI1P7mqZb79CE1Jod8RC+pjzdn39GppUAMjE40wGM+UsVmmbfHQPOttStWVHKB3z
        jjfsLhFKBvBBN9YK3l9XykKzbS4Evpw=
Date:   Fri, 23 Dec 2022 14:23:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v6 1/4] x86/mce: Cleanup bank processing on init
Message-ID: <Y6WrucZu4fE8Mt3k@zn.tnic>
References: <20221206173607.1185907-1-yazen.ghannam@amd.com>
 <20221206173607.1185907-2-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221206173607.1185907-2-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 06, 2022 at 11:36:04AM -0600, Yazen Ghannam wrote:
> -static void __mcheck_cpu_init_clear_banks(void)
> +static void __mcheck_cpu_init_prepare_banks(void)
>  {
>  	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
> +	mce_banks_t all_banks;
> +	u64 msrval;
>  	int i;
>  
> -	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
> -		struct mce_bank *b = &mce_banks[i];
> -
> -		if (!b->init)
> -			continue;
> -		wrmsrl(mca_msr_reg(i, MCA_CTL), b->ctl);
> -		wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
> +	/*
> +	 * Log the machine checks left over from the previous reset. Log them
> +	 * only, do not start processing them. That will happen in mcheck_late_init()
> +	 * when all consumers have been registered on the notifier chain.
> +	 */
> +	if (mca_cfg.bootlog) {
> +		bitmap_fill(all_banks, MAX_NR_BANKS);
> +		machine_check_poll(MCP_UC | MCP_QUEUE_LOG, &all_banks);
>  	}

Yeah, just a nit ontop - lemme move all_banks into the if branch so that
it is closer and obvious:

---
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5f406d135d32..a90d3eb6fcd8 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1755,7 +1755,6 @@ static void __mcheck_cpu_init_generic(void)
 static void __mcheck_cpu_init_prepare_banks(void)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
-	mce_banks_t all_banks;
 	u64 msrval;
 	int i;
 
@@ -1765,6 +1764,8 @@ static void __mcheck_cpu_init_prepare_banks(void)
 	 * when all consumers have been registered on the notifier chain.
 	 */
 	if (mca_cfg.bootlog) {
+		mce_banks_t all_banks;
+
 		bitmap_fill(all_banks, MAX_NR_BANKS);
 		machine_check_poll(MCP_UC | MCP_QUEUE_LOG, &all_banks);
 	}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
