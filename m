Return-Path: <linux-edac+bounces-1178-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AE98FB0B7
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jun 2024 13:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF272823CC
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jun 2024 11:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB9A1459F6;
	Tue,  4 Jun 2024 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TS9EyaBP"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB5A4A07;
	Tue,  4 Jun 2024 11:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499150; cv=none; b=uxrkOA1svpo9fdNjn5GEhEvHJBYZOzyOxpR3YzE+oBCoTSSvCuiyjW4G/O9uJZ8G0dHL00kXrW0MWPLeorUNXYxbb29ml69ATn1V7EB5bY9d86aamkVt0g3621grYdEq/pyxPlv+f6lP9NFpG48n3o/tW+t26+zGgDX4rknsLuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499150; c=relaxed/simple;
	bh=FD+umT/nkmEtU1quUGT39hfACl2LbDDL01+n5KdBb1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHbBwyLoRmLr4VLTLj0E9Xa7rNOtkS3QN9opvewshEem/Dzo8EMGtIccI2L38dF/cnee2r7EmCKaKwFo8Jv/wVmZancX6Vljs5PhLKc9RGBbantS4vrjS2V/aXa+a2zhJlaaaUV7zAaaiHLxVAUa5aKWsEjcqM/uqIcOXoFMyBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TS9EyaBP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4BD0A40E016E;
	Tue,  4 Jun 2024 11:05:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PiQqpMuj9QBX; Tue,  4 Jun 2024 11:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717499142; bh=6dDFTHhj/f5+7yxLUr3fDZt4RZlOlJ9nxFX0/vuWp5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TS9EyaBP23Y2qQjBPCxFnFbdKnNNLZsd3+SoOIwlKT7j3ArZJnZtY53gm3PxkaRAI
	 qV7KH0PY+ZitB6T2WYmznfKmGjwArobkUpb2QnyCxfEPw2fgcmTfScMb9PBhVgJwuq
	 v6VRO1XvlOk7Wla7UiPPvjdLeg2vXcU079zCtUZzHTyVElgZJ2kNDQ8K0ob7bL4wHl
	 J26OEoeXNPzcv6OUPGyEXRmZD2/k0te4bqywuSRwKFMl4mfrUE2TYZoDcwcK4d0rNU
	 4lPuAa5X1CLzAe/X4mSHm1nD9m6jnH33djVCun8ZG528zX2p0OJJzG1pGetMItlX1A
	 egQW+uBV94VUk2WmG5y4yH18kVfWBuO9Dzi1W2LGbBmmHBOA/xBQbNnfymWkEvHb7G
	 9LxoY/kukAwraLRSnVL2gsna4KQGWM7J4y+Qm0CUgI5PRjxu27W9xvGynm9BrC5SBD
	 Tm1CbL2Vbt7ZjE30oxpf3l740DOPC5XHHBRsfAwz5UWDjcQsJQRy/gNRCF2Fuu9VtG
	 wENHRsXgHngddm+u4R2VLKSBTUtV4oH/WKWryMZipDq5I0ym6VOV7pK0NTuEIN5fEw
	 PU2/9dJTzGgXLRHzeB6R2gLEnqqHJUh58kpr26vdZ7hZoaojvb2w6d8wgHs8U/S4vi
	 J+Dz5Sdc9BP6D4Bu6Ud68GCs=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2021C40E016A;
	Tue,  4 Jun 2024 11:05:35 +0000 (UTC)
Date: Tue, 4 Jun 2024 13:05:28 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH 7/9] x86/mce: Unify AMD DFR handler with MCA Polling
Message-ID: <20240604110528.GRZl70-MFo-EikWRHs@fat_crate.local>
References: <20240523155641.2805411-1-yazen.ghannam@amd.com>
 <20240523155641.2805411-8-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523155641.2805411-8-yazen.ghannam@amd.com>

On Thu, May 23, 2024 at 10:56:39AM -0500, Yazen Ghannam wrote:
> +static bool smca_log_poll_error(struct mce *m, u32 *status_reg)

That handing of *status_reg back'n'forth just to clear it in the end is
not nice. Let's get rid of it:

---
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 0a9cff329487..a0ba82fe6de3 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -669,7 +669,7 @@ static void reset_thr_limit(unsigned int bank)
 
 DEFINE_PER_CPU(unsigned, mce_poll_count);
 
-static bool smca_log_poll_error(struct mce *m, u32 *status_reg)
+static bool smca_log_poll_error(struct mce *m, u32 status_reg)
 {
 	/*
 	 * If this is a deferred error found in MCA_STATUS, then clear
@@ -686,8 +686,8 @@ static bool smca_log_poll_error(struct mce *m, u32 *status_reg)
 	 * If the MCA_DESTAT register has valid data, then use
 	 * it as the status register.
 	 */
-	*status_reg = MSR_AMD64_SMCA_MCx_DESTAT(m->bank);
-	m->status = mce_rdmsrl(*status_reg);
+	status_reg = MSR_AMD64_SMCA_MCx_DESTAT(m->bank);
+	m->status = mce_rdmsrl(status_reg);
 
 	if (!(m->status & MCI_STATUS_VAL))
 		return false;
@@ -695,6 +695,8 @@ static bool smca_log_poll_error(struct mce *m, u32 *status_reg)
 	if (m->status & MCI_STATUS_ADDRV)
 		m->addr = mce_rdmsrl(MSR_AMD64_SMCA_MCx_DEADDR(m->bank));
 
+	mce_wrmsrl(status_reg, 0);
+
 	return true;
 }
 
@@ -714,7 +716,7 @@ static bool ser_log_poll_error(struct mce *m)
 	return false;
 }
 
-static bool log_poll_error(enum mcp_flags flags, struct mce *m, u32 *status_reg)
+static bool log_poll_error(enum mcp_flags flags, struct mce *m, u32 status_reg)
 {
 	if (mce_flags.smca)
 		return smca_log_poll_error(m, status_reg);
@@ -789,7 +791,7 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		if (!mca_cfg.cmci_disabled)
 			mce_track_storm(&m);
 
-		if (!log_poll_error(flags, &m, &status_reg))
+		if (!log_poll_error(flags, &m, status_reg))
 			continue;
 
 		if (flags & MCP_DONTLOG)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

