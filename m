Return-Path: <linux-edac+bounces-5691-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEM+GujBgGl3AgMAu9opvQ
	(envelope-from <linux-edac+bounces-5691-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 02 Feb 2026 16:25:28 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6670CE2D0
	for <lists+linux-edac@lfdr.de>; Mon, 02 Feb 2026 16:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F07BF3105AB7
	for <lists+linux-edac@lfdr.de>; Mon,  2 Feb 2026 15:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA45F37AA76;
	Mon,  2 Feb 2026 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fY0bDgKT"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BE13793AF;
	Mon,  2 Feb 2026 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770045538; cv=none; b=aTK+4tII/jGSXhFB6yA/DizW2slWa0G89I0iV1COyJRypFDA6+5F5Q2PgO650z1wgaEXL/7ueQmWbleG9NPvPC+zA21TPr0hfM7fq1gDnSjIIyvLdyAn0KjI3QQij5pACQWlIJllyImVVmP5IWgXtLymk4wQqaQLR7h4eLHzsww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770045538; c=relaxed/simple;
	bh=Jb4Gfbp8u97MzZ4CnwdotEszc6b74ilcqXJ3ZZjChjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPjbrD5efibKxq36owkcvrMhHQ1tHw0bjfLuo8xkf9jgvNKtnCV68dfcM2jzUKtPnXTbdXzmZeMsoHjQ0mxE+e6gjhPKI8bK+ulLKA+qPYxq4FCp7GAsdWpyb+R0GNAw3j+V+n288nPZQDuu48cMvLnvVIRvzPFVFxAQ/SCF4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fY0bDgKT; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A32D140E0359;
	Mon,  2 Feb 2026 15:18:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IewERQ24drqf; Mon,  2 Feb 2026 15:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1770045528; bh=ElRGLq/jy/DYs6Y17bW/6F009+3cdyGs9rlMIhEWYQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fY0bDgKTSjZ/wEj9tUnm9l17ZWlUcya5BrQWKJlE3+gdKjXN33gHGXGfWCg6WQ2yx
	 U5INK9gIIheDKoPjK5eNeVnKV80Ejr536WYVqSHe9shg9pyUV4qAaW+RbA5QMCVwAX
	 qJd78iWAMLMBDmSssbg7Hh6qQ4jUZagma2ojTU2V9ywhYqLzVtc36RmGxZor3IkHUV
	 3WDNIXZEt1gEJKoFcNyUfKnj4KWbdFfv212iS/5YpFLAz89JLy3rxPSmmngienZbaN
	 4C4S6SN3lZ9ZeZRDKiwpDHFuLbuQHOL1Nbu1hZuzy95IW3benID0rFVeeHep/KMAzo
	 JVzFi1mKVOgo0HMImzQ/gEFSuLrPk3VRWsffEFSqfyTr/DZyjk4KKc1BOyFBxPkqtz
	 dkYhxNQHKQXuOuSe5eeyVSdZMQzC5B1xgLdtMJfnX1X1uSyVI83MDIfYtXB31XDlpy
	 jALC9g7VpfQx0p11fsSIbBHQyXI8VSzPXDLfxPqcWHFzBTM61/d1XrHjlUSs/zcWA9
	 PN4qCP3D0OdPp7o4QRTX6G4Q0Ad2VCS5pxceZU8idmUIPDdCZzoFv9hWiLwT9cXjFc
	 4Qq4ojs8ra81pVkMZ6his8XYFzQBcu6am3g6EMvaoLBh1+9yQzsRLdl2BfdsBtLZ+8
	 vPx7e7YrfgnPovTCQ7tHTGZU=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 9934B40E01A2;
	Mon,  2 Feb 2026 15:18:35 +0000 (UTC)
Date: Mon, 2 Feb 2026 16:18:28 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Li, Rongqing" <lirongqing@baidu.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: Fix timer interval adjustment after logging a
 MCE event
Message-ID: <20260202151828.GAaYDARDsP21UVEPTb@fat_crate.local>
References: <39cfb093256f4da78fe0bc9e814ce5d0@baidu.com>
 <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
 <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113205654.GTaWaxllyfJLHsl0YX@fat_crate.local>
 <SJ1PR11MB6083A836550962AECED68500FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113213158.GUaWa5zunSfuAzra0n@fat_crate.local>
 <20260113224152.GVaWbKMMzManQ5WwlT@fat_crate.local>
 <aWbjkAPX9a9ZlJGN@agluck-desk3>
 <20260114135034.GAaWefKm97-CkbEp4P@fat_crate.local>
 <20260114144813.GCaWesrQ7zdEftdV87@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114144813.GCaWesrQ7zdEftdV87@fat_crate.local>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5691-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[alien8.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-edac];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6670CE2D0
X-Rspamd-Action: no action

On Wed, Jan 14, 2026 at 03:48:13PM +0100, Borislav Petkov wrote:
> Now on to find what causes this. Even if we can't find the proper commit,
> I guess testing 6.18 and 6.12 - the LTS kernels - should be good enough as to
> backport a fix there.

Ok, finally back to staring at this.

Looks like adding this:

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 34440021e8cf..b94efe5950c4 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -154,6 +154,8 @@ void mce_log(struct mce_hw_err *err)
 {
        if (mce_gen_pool_add(err))
                irq_work_queue(&mce_irq_work);
+
+       set_bit(0, &mce_need_notify);
 }
 EXPORT_SYMBOL_GPL(mce_log);
 
makes the interval halve again, see below for the timestamps.

I guess I'll do a proper patch from the hunk here:

https://lore.kernel.org/r/20260113224152.GVaWbKMMzManQ5WwlT@fat_crate.local

along with 6.12 and 6.18 backports and see whether that's a good enough as
a stable fix too.

Thx.

[  316.795248] mce: [Hardware Error]: Machine check events logged
[  316.795262] mce: [Hardware Error]: Machine check events logged
[  316.798331] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c2041000000011b
[  316.800104] mce: [Hardware Error]: TSC 0 ADDR 6d3d483b 
[  316.801442] mce: [Hardware Error]: PROCESSOR 2:800f82 TIME 1770040950 SOCKET 0 APIC 0 microcode 800820d
[  628.091492] mce: [Hardware Error]: Machine check events logged
[  628.091515] mce: [Hardware Error]: Machine check events logged
[  628.097216] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c2041000000011b
[  628.101393] mce: [Hardware Error]: TSC 0 ADDR 6d3d483b 
[  628.103992] mce: [Hardware Error]: PROCESSOR 2:800f82 TIME 1770041262 SOCKET 0 APIC 0 microcode 800820d

<--- it starts decreasing the interval here.

[  825.581354] hrtimer: interrupt took 18820 ns
[  939.387367] mce: [Hardware Error]: Machine check events logged
[  939.390185] mce: [Hardware Error]: Machine check events logged
[  939.392936] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c2041000000011b
[  939.396465] mce: [Hardware Error]: TSC 0 ADDR 6d3d483b 
[  939.399042] mce: [Hardware Error]: PROCESSOR 2:800f82 TIME 1770041573 SOCKET 0 APIC 0 microcode 800820d
[ 1103.227402] mce: [Hardware Error]: Machine check events logged
[ 1103.230267] mce: [Hardware Error]: Machine check events logged
[ 1103.233018] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c2041000000011b
[ 1103.236565] mce: [Hardware Error]: TSC 0 ADDR 6d3d483b 
[ 1103.239146] mce: [Hardware Error]: PROCESSOR 2:800f82 TIME 1770041737 SOCKET 0 APIC 0 microcode 800820d
[ 1179.003479] mce: [Hardware Error]: Machine check events logged
[ 1179.006452] mce: [Hardware Error]: Machine check events logged
[ 1179.009144] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c2041000000011b
[ 1179.012757] mce: [Hardware Error]: TSC 0 ADDR 6d3d483b 
[ 1179.015338] mce: [Hardware Error]: PROCESSOR 2:800f82 TIME 1770041813 SOCKET 0 APIC 0 microcode 800820d
[ 1217.915386] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c2041000000011b
[ 1217.919088] mce: [Hardware Error]: TSC 0 ADDR 6d3d483b 
[ 1217.921662] mce: [Hardware Error]: PROCESSOR 2:800f82 TIME 1770041852 SOCKET 0 APIC 0 microcode 800820d
[ 1238.395440] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c2041000000011b
[ 1238.399041] mce: [Hardware Error]: TSC 0 ADDR 6d3d483b 
[ 1238.401619] mce: [Hardware Error]: PROCESSOR 2:800f82 TIME 1770041872 SOCKET 0 APIC 0 microcode 800820d
[ 1269.115368] mce_notify_irq: 4 callbacks suppressed
[ 1269.117829] mce: [Hardware Error]: Machine check events logged
[ 1269.120586] mce: [Hardware Error]: Machine check events logged
[ 1269.123412] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c2041000000011b
[ 1269.126950] mce: [Hardware Error]: TSC 0 ADDR 6d3d483b 
[ 1269.129511] mce: [Hardware Error]: PROCESSOR 2:800f82 TIME 1770041903 SOCKET 0 APIC 0 microcode 800820d

and then it started enlarging it again when I changed the injection interval
to 300s.

[ 1578.363408] mce: [Hardware Error]: Machine check events logged
[ 1578.366346] mce: [Hardware Error]: Machine check events logged
[ 1578.369174] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c2041000000011b
[ 1578.372742] mce: [Hardware Error]: TSC 0 ADDR 6d3d483b 
[ 1578.375226] mce: [Hardware Error]: PROCESSOR 2:800f82 TIME 1770042212 SOCKET 0 APIC 0 microcode 800820d
[ 2119.035460] mce: [Hardware Error]: Machine check events logged
[ 2119.038432] mce: [Hardware Error]: Machine check events logged
[ 2119.041236] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c2041000000011b
[ 2119.044846] mce: [Hardware Error]: TSC 0 ADDR 6d3d483b 
[ 2119.047340] mce: [Hardware Error]: PROCESSOR 2:800f82 TIME 1770042753 SOCKET 0 APIC 0 microcode 800820d
[ 2282.875491] mce: [Hardware Error]: Machine check events logged
[ 2282.878409] mce: [Hardware Error]: Machine check events logged
[ 2282.881277] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c2041000000011b
[ 2282.884978] mce: [Hardware Error]: TSC 0 ADDR 6d3d483b 
[ 2282.887482] mce: [Hardware Error]: PROCESSOR 2:800f82 TIME 1770042917 SOCKET 0 APIC 0 microcode 800820d
[ 2512.251516] mce: [Hardware Error]: Machine check events logged
[ 2512.254371] mce: [Hardware Error]: Machine check events logged
[ 2512.257261] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: 9c2041000000011b
[ 2512.260841] mce: [Hardware Error]: TSC 0 ADDR 6d3d483b 
[ 2512.263406] mce: [Hardware Error]: PROCESSOR 2:800f82 TIME 1770043146 SOCKET 0 APIC 0 microcode 800820d

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

