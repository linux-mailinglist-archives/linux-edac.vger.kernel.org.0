Return-Path: <linux-edac+bounces-1567-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BA193D35E
	for <lists+linux-edac@lfdr.de>; Fri, 26 Jul 2024 14:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E081C1F22BAB
	for <lists+linux-edac@lfdr.de>; Fri, 26 Jul 2024 12:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463C117B4FC;
	Fri, 26 Jul 2024 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="birg0LmC"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C6717B4F6
	for <linux-edac@vger.kernel.org>; Fri, 26 Jul 2024 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997772; cv=none; b=s2L9qvbL/u2geHkHsFSrwMyQ1ZZ1+Kq8iBMKR/I+oysvNd7ResdmZeb0awB0GGTaPINb2k2jWgk9UQGXeX0SlqnsmFKdbh7jOHgLBwSlc9n89j8tYddfJjN3kjtdxL+c+Szyw3q403UYTqf8qPpU/ptRK6jDc/S6xxR4UeceICI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997772; c=relaxed/simple;
	bh=3FpAOI0XwVJqDeWoToMPlQk7UbYeMwbA4/9XXjuJOeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEEhAtfEmYbbRoMo+WYhUTiFXwe4ynSaNTg4t3KrXGP0UhojUUVGfPSlHAd0BT1ohIxn/+fQG+EZQenrPnDiN3p1MqHglL24y6b9RBnLW+sBOcDR2upYCN87XZBybvR/YvrL9sUyE7osoTtfZFi20MXx7+U6puHiCKjpqzOHetk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=birg0LmC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3EED640E0268;
	Fri, 26 Jul 2024 12:42:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SE279nqAYx7t; Fri, 26 Jul 2024 12:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1721997763; bh=qo4k6fHH32u0WfiwjvRGfPewtmWSz3wEffWL8pPI0us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=birg0LmCJxFOxgIqkf/gNCwhJeeK/SGOcQEBD86dPB7j6opuehYYW3HwKzXgw8W5c
	 YC0Sx8EOA/nHxuL8etoDoY8cumtGcmHbmIwbsImJT/AfngOCq4dFXvydlVOVOTncwY
	 u+zHKT/2pXcmmETnaxy++RopD6CXnCoLwV/mZJUzdWavwUqSLxGvT4OR/KG/vnU3Z0
	 pPMUvlLANXW4dQZZPqG4rwoYGW3JApDMQUCtfkD+VCYHnRkUpcidiKvcBLCG7YekE8
	 Qw/R0mvWpybUs+YEtWlW/PPRAAqLsW8GAF/KVetxcqT1RPXY3x+dZNauNfCb/KB6/G
	 XnXdAVqeAbSpjP6LHfMBY6Lu5uub8K6IQxjW5RnzyAxa8kMC1zTVwlQyAbJOONa0cd
	 4W651JC5vbn9it7vGpS+NwP1FXu/w3gtUE9T0b4UY7Zw1ZZuu30hBHzIMpHYZVgo9O
	 7foLgcB2gIB3D5v49bT5ybL0b/VLVvAFesYDw/Wk7U879hKbfxnjamE/AWn3p3ihlg
	 cpZWHRyzNtxl4rceh8JUYAi7FJLwW9ZnYKtmWfg3g875glJt9a/WvQvbldi3idY0AS
	 6XBYNCwTJTlUcTegXBrWAAUFYFOPnqCQk/KROHmFdsUMifOptD1mG7PNd5seKmpq4s
	 7dRY6PgD0SUYeDrxXruMQtUM=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0C71D40E01B3;
	Fri, 26 Jul 2024 12:42:37 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:42:32 +0200
From: Borislav Petkov <bp@alien8.de>
To: Andres Valloud <ten@smallinteger.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Tony Luck <tony.luck@intel.com>
Cc: x86@kernel.org, linux-edac <linux-edac@vger.kernel.org>
Subject: Re: Unrecognized MSR report
Message-ID: <20240726124232.GBZqOZuM0yue1Oak-A@fat_crate.local>
References: <f5fab0e1-a6f3-4e53-a605-0aaf6d26ee3e@smallinteger.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5fab0e1-a6f3-4e53-a605-0aaf6d26ee3e@smallinteger.com>

+ Mauro, Tony, linux-edac

On Thu, Jul 25, 2024 at 12:28:23AM -0700, Andres Valloud wrote:
> Hello, after installing rasdaemon the logs complain thus.
> 
> [604477.995036] msr: Write to unrecognized MSR 0x17f by rasdaemon (pid:
> 24480).
> 
> The hardware in question is a supermicro server with 2x E5-2630v2.  A newer
> server with 2x Xeon Gold 6128 is also running rasdaemon, but there is no
> complaint about MSR 0x17f there.
> 
> Both systems are running Ubuntu 22.04 LTS, fully up to date, with kernel
> version 6.5.0-44.
> 
> The text in the MSR document referenced from the logs only makes reference
> to AMD cpus.  There is also the different behavior depending on the Intel
> cpu model.  This circumstance does not appear to be covered by the document.
> Reporting as requested...

Thanks, appreciated.

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Fri, 26 Jul 2024 14:39:53 +0200
Subject: [PATCH] mce-intel: Do not enable optional MCE logging in rasdaemon

The kernel already does that, see kernel commit:

  68299a42f842 ("x86/mce: Enable additional error logging on certain Intel CPUs")

so rip out yet another case of poking into MSRs from userspace.

Reported-by: Andres Valloud <ten@smallinteger.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 mce-intel.c       | 26 --------------------------
 ras-mce-handler.c | 11 -----------
 ras-mce-handler.h |  3 ---
 3 files changed, 40 deletions(-)

diff --git a/mce-intel.c b/mce-intel.c
index 0ff3072dfd0e..285c067aec93 100644
--- a/mce-intel.c
+++ b/mce-intel.c
@@ -461,29 +461,3 @@ static int domsr(int cpu, int msr, int bit)
 	close(fd);
 	return 0;
 }
-
-int set_intel_imc_log(enum cputype cputype, unsigned int ncpus)
-{
-	int cpu, msr, bit, rc;
-
-	switch (cputype) {
-	case CPU_SANDY_BRIDGE_EP:
-	case CPU_IVY_BRIDGE_EPEX:
-	case CPU_HASWELL_EPEX:
-	case CPU_KNIGHTS_LANDING:
-	case CPU_KNIGHTS_MILL:
-		msr = 0x17f;	/* MSR_ERROR_CONTROL */
-		bit = 0x2;	/* MemError Log Enable */
-		break;
-	default:
-		return 0;
-	}
-
-	for (cpu = 0; cpu < ncpus; cpu++) {
-		rc = domsr(cpu, msr, bit);
-		if (rc)
-			return rc;
-	}
-
-	return 0;
-}
diff --git a/ras-mce-handler.c b/ras-mce-handler.c
index ea58ac091267..0480f41b259b 100644
--- a/ras-mce-handler.c
+++ b/ras-mce-handler.c
@@ -249,17 +249,6 @@ int register_mce_handler(struct ras_events *ras, unsigned int ncpus)
 		ras->mce_priv = NULL;
 		return rc;
 	}
-	switch (mce->cputype) {
-	case CPU_SANDY_BRIDGE_EP:
-	case CPU_IVY_BRIDGE_EPEX:
-	case CPU_HASWELL_EPEX:
-	case CPU_KNIGHTS_LANDING:
-	case CPU_KNIGHTS_MILL:
-		set_intel_imc_log(mce->cputype, ncpus);
-	default:
-		break;
-	}
-
 	return rc;
 }
 
diff --git a/ras-mce-handler.h b/ras-mce-handler.h
index 57984ecc4357..aa820d3458cc 100644
--- a/ras-mce-handler.h
+++ b/ras-mce-handler.h
@@ -109,9 +109,6 @@ int ras_mce_event_handler(struct trace_seq *s,
 			  struct tep_record *record,
 			  struct tep_event *event, void *context);
 
-/* enables intel iMC logs */
-int set_intel_imc_log(enum cputype cputype, unsigned int ncpus);
-
 /* Undertake AMD SMCA Error Decoding */
 void decode_smca_error(struct mce_event *e, struct mce_priv *m);
 void amd_decode_errcode(struct mce_event *e);
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

