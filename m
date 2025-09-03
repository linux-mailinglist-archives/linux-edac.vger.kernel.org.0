Return-Path: <linux-edac+bounces-4725-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE719B41AFB
	for <lists+linux-edac@lfdr.de>; Wed,  3 Sep 2025 12:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C19954418C
	for <lists+linux-edac@lfdr.de>; Wed,  3 Sep 2025 10:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AE12DA774;
	Wed,  3 Sep 2025 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FRF2St+1"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271D82E8886;
	Wed,  3 Sep 2025 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893822; cv=none; b=QJIi41cSlPE2RbcTDszDkpRTop+pN4GU0ynIAtYtTAT4uvN+MrH0uqagjHqhj5yzPl6hQkwEFSPCdiUPDfWx0NqHFxlaU4YvrHVyldcQF5YCYu90ofgUnR91qCKV7qyQ8FsDYtf4TimX6j96LFWFT1w0F0QlUyzre7kC/OB+AZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893822; c=relaxed/simple;
	bh=0uWuXTsNAYjzbqYoQzNVvj7RBiv6ohyxenQTCDwv/kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oqvwq1gQ6mGaY0iwJ4HmS4ypKYYdOE5gFMnuEgRfW34g0Lvi8JQtL4HxStoKyeUAIu4RNgUVsKRBPuGIQDnRVGqqws3fhGcxC7fN6l2/yVuKkAvd05hyYu+9hoWWTMPbdH1RJvrrDJs/07m11kbZ7+PH1PitjiJYh0MqIU8ELck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FRF2St+1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B99A840E01B0;
	Wed,  3 Sep 2025 10:03:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mbvvz1Ld2akV; Wed,  3 Sep 2025 10:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756893812; bh=RhD68Pvtck0QIldCXY3sNMzubu+4+wpcGgj7x1SSY6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FRF2St+1Zqs0y6yDHoEZU3szMqOaQ7fXb0VttHKT/GovMV2HK9XWUTZ3Zzvf5vm+2
	 /wDdLcstHvYlZlzZhCwoNXKFGHXS9knz2ue//fF12RUDhJQVcdQFiXy70CWV/8W8vQ
	 UTIjnMcoXRwfs0HoLMzZBcJEYbkhdsZadVXls9rmmQ0it91J44SpuFRuokSqUUEFW4
	 cvqg7TKZmOnietsqQy7xD2EZLzWeHqFIUo9IuXoODxDETLjhTUyame29Uv8Ghv+QJn
	 ckgzyzJHJJqymgj2XPOiDdBTqOzonvXXvZcPxXSnXOmSPI1ZPf4xLrxLa2MXFwYbgC
	 /33pcDa8QMZfuoEUAK5NxoKrUqMbxrDQvLvjsrjLM4yvkeXBbfPQ3ssn5ydzO4tFWQ
	 UvvR/zORIbANdnManoB4WmFTIR01GUdm86J1T2SLGgLPp6RtZn2gLDiUdHfkPYMEHt
	 bbJofFjN+X+0lqxFLL6zou3TDGr38sMexNGQOkveoHbRu8zdqT/vr5vJdRzv9xY2XR
	 8idP7++/TGx2pM8ENjO9AvlwoxTw6chTHoBNPdbdn5pzF2L7s8CM2tNMmyFZ6ugbNI
	 tPewkDibdSJ/Glaz0y3a0BMGbFKz8N9vHMo0W9x9xhrhiQOeOGrwB03LdXBNvKSfUk
	 7PXrbXVOvsJlLDNRt9I4NCUM=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8667C40E01AC;
	Wed,  3 Sep 2025 10:03:22 +0000 (UTC)
Date: Wed, 3 Sep 2025 12:03:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 15/20] x86/mce/amd: Enable interrupt vectors once
 per-CPU on SMCA systems
Message-ID: <20250903100317.GHaLgSZTPMDHrKbO7Q@fat_crate.local>
References: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
 <20250825-wip-mca-updates-v5-15-865768a2eef8@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825-wip-mca-updates-v5-15-865768a2eef8@amd.com>

On Mon, Aug 25, 2025 at 05:33:12PM +0000, Yazen Ghannam wrote:
> Scalable MCA systems have a per-CPU register that gives the APIC LVT
> offset for the thresholding and deferred error interrupts.
> 
> Currently, this register is read once to set up the deferred error
> interrupt and then read again for each thresholding block. Furthermore,
> the APIC LVT registers are configured each time, but they only need to
> be configured once per-CPU.
> 
> Move the APIC LVT setup to the early part of CPU init, so that the
> registers are set up once. Also, this ensures that the kernel is ready
> to service the interrupts before the individual error sources (each MCA
> bank) are enabled.
> 
> Apply this change only to SMCA systems to avoid breaking any legacy
> behavior. The deferred error interrupt is technically advertised by the
> SUCCOR feature. However, this was first made available on SMCA systems.
> Therefore, only set up the deferred error interrupt on SMCA systems and
> simplify the code.
> 
> Guidance from hardware designers is that the LVT offsets provided from
> the platform should be used. The kernel should not try to enforce
> specific values. However, the kernel should check that an LVT offset is
> not reused for multiple sources.
> 
> Therefore, remove the extra checking and value enforcement from the MCE
> code. The "reuse/conflict" case is already handled in
> setup_APIC_eilvt().
> 
> Tested-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

Some touchups ontop:

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index c05d9c6f07d1..5722806ccaa5 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -54,8 +54,10 @@ static bool thresholding_irq_en;
 struct mce_amd_cpu_data {
 	mce_banks_t     thr_intr_banks;
 	mce_banks_t     dfr_intr_banks;
-	bool		thr_intr_en;
-	bool		dfr_intr_en;
+
+	u32		thr_intr_en: 1,
+			dfr_intr_en: 1,
+			__resv: 30;
 };
 
 static DEFINE_PER_CPU_READ_MOSTLY(struct mce_amd_cpu_data, mce_amd_data);
@@ -508,9 +510,8 @@ static u32 get_block_address(u32 current_addr, u32 low, u32 high,
 	return addr;
 }
 
-static int
-prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
-			int offset, u32 misc_high)
+static int prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
+				   int offset, u32 misc_high)
 {
 	unsigned int cpu = smp_processor_id();
 	struct threshold_block b;
@@ -652,11 +653,11 @@ static void smca_enable_interrupt_vectors(void)
 
 	offset = (mca_intr_cfg & SMCA_THR_LVT_OFF) >> 12;
 	if (!setup_APIC_eilvt(offset, THRESHOLD_APIC_VECTOR, APIC_EILVT_MSG_FIX, 0))
-		data->thr_intr_en = true;
+		data->thr_intr_en = 1;
 
 	offset = (mca_intr_cfg & MASK_DEF_LVTOFF) >> 4;
 	if (!setup_APIC_eilvt(offset, DEFERRED_ERROR_VECTOR, APIC_EILVT_MSG_FIX, 0))
-		data->dfr_intr_en = true;
+		data->dfr_intr_en = 1;
 }
 
 /* cpu init entry point, called from mce.c with preempt off */
@@ -669,6 +670,7 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	amd_apply_cpu_quirks(c);
 
 	mce_flags.amd_threshold	 = 1;
+
 	smca_enable_interrupt_vectors();
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

