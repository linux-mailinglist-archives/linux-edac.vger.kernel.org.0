Return-Path: <linux-edac+bounces-5186-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CBBC06DCA
	for <lists+linux-edac@lfdr.de>; Fri, 24 Oct 2025 17:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B6364F35D6
	for <lists+linux-edac@lfdr.de>; Fri, 24 Oct 2025 15:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752692DECB0;
	Fri, 24 Oct 2025 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bvP0TH9q"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBB21A08CA;
	Fri, 24 Oct 2025 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318242; cv=none; b=gPtOxW65OtiFgCI+a28EQtrgoPUpliO/XQmI9olFsHCM1NhVHRXC3hS/WH04kCB+I1OTlYdnO+CwwA8plMOQWM8qKgBkuyN3t2oWKZSGEixHl6+GplgPW9H/yywDYQlKOY+dnKfQA+EKAC3zrO/2ihKDJHJlQA8VQFS82kuO85Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318242; c=relaxed/simple;
	bh=UuN5SbJXjd99GdekiS7uxvzlxNMYSESYEHexIDrV578=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9axegf8ANarXDoumBBA1MSxRQZqpx3oCB1OzRSVM74QdabwmkPWev/xf/ZeqYvebutyDPE3/uFBLHXLqQE0DK5HrO4JmPsI3WLOddhMaBKrqqGV1+NrvZMIq6TKFxUK6WxI9WCdhM5HDVe10eWv1vekUmYP2th7HAbPkak655s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bvP0TH9q; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CB32A40E0200;
	Fri, 24 Oct 2025 15:03:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id f4EPLWfamKoN; Fri, 24 Oct 2025 15:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761318226; bh=4xYnJj8Mu9WshoEU5OoanXUEJ9sqgN+CtEZkr8Kk4BM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bvP0TH9qRf6JCK00wir6yrL8EDqfI6NC5eTt8PE642670aRdyME9ZZUaL+ey+BOAE
	 t/UQTjxAB9ejJ7uo9vGDn6uSz1xuBiJAZPruRFJmqNoe4lwAJxseDX5nBglOjUFT8h
	 CWEF9ZpQCVo9CqDI/G7SeayIyqBYGow7hbboDUtK8W3mY4+W9UYVd+x2cUbNNkI1nN
	 QG2oQHdi0Miebihw9lzdhgQl5if4FAwfz3Yk2V9i5OCZZgsgw6s12BK4rN1uo7Yxx6
	 016bt/tcx+2OecpArX5/wU4KgQg/W7ZneXXJ1IdZfIliKVcw3cK54Bbtcn6bZ2RbzL
	 rhEWfVZVaMz/77WLYkSCfaPJwXgVed/Fe7FLq4Wf8KbgjxDDjEtFfA2C8UO0TSrTWC
	 gd6KfXRNoM1T5sUDWv0CsntNpXHx0/iPZhjZH1w26jekJSrO0COp8mwhwmPKMwyHBZ
	 AvZRbosI5VpInehw5kOxlWH2RKcfEpIwIdpt1BstrZ5C/fMaeU2lEKYUOvTf9xpQwo
	 D0JqyuJlyjs31SongYQ/+n/ATcnkkohl0IDifxKRr2X1igk8UZ5b0cxyp3Qyo0izFE
	 IOvRbV8jtL/MJZtd0gxTKdGG9NleBtvrppc0FG0RRRClNpGcMvJPFfsso5q9SKHhFL
	 Jwi+oDNjSOy5JBixLDpFGiLY=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 3A21A40E019B;
	Fri, 24 Oct 2025 15:03:34 +0000 (UTC)
Date: Fri, 24 Oct 2025 17:03:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Bert Karwatzki <spasswolf@web.de>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 2/8] x86/mce: Unify AMD DFR handler with MCA Polling
Message-ID: <20251024150333.GSaPuVRQYxH92zyrmO@fat_crate.local>
References: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
 <20251016-wip-mca-updates-v7-2-5c139a4062cb@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251016-wip-mca-updates-v7-2-5c139a4062cb@amd.com>

On Thu, Oct 16, 2025 at 04:37:47PM +0000, Yazen Ghannam wrote:
> @@ -1878,6 +1924,9 @@ static void __mcheck_cpu_init_prepare_banks(void)
>  
>  		bitmap_fill(all_banks, MAX_NR_BANKS);
>  		machine_check_poll(MCP_UC | MCP_QUEUE_LOG, &all_banks);
> +
> +		if (mce_flags.smca)
> +			machine_check_poll(MCP_DFR | MCP_QUEUE_LOG, &all_banks);

So you're going to run the poll again just for DFR errors?!

What for?

I think this is enough:

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 1482648c8508..7d6588195d56 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -299,7 +299,6 @@ enum mcp_flags {
 	MCP_TIMESTAMP	= BIT(0),	/* log time stamp */
 	MCP_UC		= BIT(1),	/* log uncorrected errors */
 	MCP_QUEUE_LOG	= BIT(2),	/* only queue to genpool */
-	MCP_DFR		= BIT(3),	/* log deferred errors */
 };
 
 void machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 64aa7ecfd332..d9f9ee7db5c8 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -807,7 +807,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
 /* APIC interrupt handler for deferred errors */
 static void amd_deferred_error_interrupt(void)
 {
-	machine_check_poll(MCP_TIMESTAMP | MCP_DFR, &this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
+	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
 }
 
 static void reset_block(struct threshold_block *block)
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 39725df7d35c..7be062429ce3 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -779,17 +779,13 @@ static bool should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
 {
 	struct mce *m = &err->m;
 
-	if (flags & MCP_DFR)
+	if (mce_flags.smca)
 		return smca_should_log_poll_error(flags, err);
 
 	/* If this entry is not valid, ignore it. */
 	if (!(m->status & MCI_STATUS_VAL))
 		return false;
 
-	/* Ignore deferred errors if not looking for them (MCP_DFR not set). */
-	if (m->status & MCI_STATUS_DEFERRED)
-		return false;
-
 	/*
 	 * If we are logging everything (at CPU online) or this
 	 * is a corrected error, then we must log it.
@@ -1924,9 +1920,6 @@ static void __mcheck_cpu_init_prepare_banks(void)
 
 		bitmap_fill(all_banks, MAX_NR_BANKS);
 		machine_check_poll(MCP_UC | MCP_QUEUE_LOG, &all_banks);
-
-		if (mce_flags.smca)
-			machine_check_poll(MCP_DFR | MCP_QUEUE_LOG, &all_banks);
 	}
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {



-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

