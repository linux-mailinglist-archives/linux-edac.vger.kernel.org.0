Return-Path: <linux-edac+bounces-5774-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNpzHjvrqmmOYAEAu9opvQ
	(envelope-from <linux-edac+bounces-5774-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Fri, 06 Mar 2026 15:56:59 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCC82232C8
	for <lists+linux-edac@lfdr.de>; Fri, 06 Mar 2026 15:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B118302B46A
	for <lists+linux-edac@lfdr.de>; Fri,  6 Mar 2026 14:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D893A963D;
	Fri,  6 Mar 2026 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="R8fvK/Xk"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA8527FD4B
	for <linux-edac@vger.kernel.org>; Fri,  6 Mar 2026 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808618; cv=none; b=H8kvf2jRbfnNbdcTAzpfYAJBQbsejvyEtU9Jn3GHDVWqNgLKus16nf0rrckBM7XcJ2mDfLKnR5uowamqUoj42EUYNfkLa6+jznESY7RHTnZFbVBeYbQvIoQL5ugr/SCWprE1YSkKhfDWlF/B0AfFLd0CJHiJL6FAFnodUJ63pwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808618; c=relaxed/simple;
	bh=rXOeKmeecDCVrljbrn/74ik3xJC0iMY4pfPMS+9HRk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMvmvyqme8+HCL373vq/2uuTldO9vPbblBppX0DY1CV/+GQJ4tuMHkCvDZeu6Vn+6YOVfZWugiyBXVC4bvcHjUH4pLXIupnVQGYqtuDI472LyybMfIQxVI2Bgn4VY2rmVJIlF9PhSheGKfDpp6ky4P0cuNYspA35jPXqr73ONLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=R8fvK/Xk; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DEBC640E00DE;
	Fri,  6 Mar 2026 14:50:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7L_u6PYMfHoI; Fri,  6 Mar 2026 14:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1772808610; bh=dy5YqS9WPQkxmz+pPxKIapCCOOzyCE7khQMNUi2mjcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R8fvK/XkmMs5FAja+6naylpIP3W2BZ+SKEw6NYDhUEKfUQDgo4q0u0jhfyVeHK7oP
	 FYfzGVwVRGR0mPTF4PG/h1S9KJtmJIH2VSB6wFbCZAAYvKwk468MX4w9Fha4MTOeNU
	 0l23XsHQwNniKE+vFHAziv15QLD3KASVLjkmOao1jDAmKXHfou/nWKtMfaJNt1dgD0
	 ZAj+R43jVydE6VSgx9kMoNYCkEiOIfDlL3msM96vUCdJ3qaQiXrTI/qHinz6H8UB80
	 y2Igcl1bvJbo8gUpSABcg8wUekJG4Bl36QoAZTB736B2Vzh7SbpHP1OSkPejmABQuV
	 DSGpuQMoxI5o/Ra2fgCYjQMw5djuVQUd0YdPD74MC2btSslK+ZvObWU/YsLdH4TfQl
	 Kp0los4lNl8dRizGnWUfs6WXnXkhJrKdKCGvpnl1zExA1gN49ZxEZFOU6y5RzWlaVp
	 OiApSq7Z+4KmvOF8uA8KMBSXRVNrwzbZfx7smzOkKe9gdN5RtZ9nlpo4Fp541+Gfxq
	 tcNJuzFGmwhRzJ1A4eKT1xHwsd9/zflGqDEsf9/WWso2kF3khvktNKdzUE8LlDFy6o
	 ynZ7AoY61Jjqt6IpskgEPYUw4aPfNspiDyNUPCFmXbpCBNKGtMlI5oVzGc84l7QpsG
	 YcSCs27IPcaUu8TuvYTjmsAo=
Received: from zn.tnic (pd9530d5e.dip0.t-ipconnect.de [217.83.13.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id EFDAB40E00DA;
	Fri,  6 Mar 2026 14:50:04 +0000 (UTC)
Date: Fri, 6 Mar 2026 15:50:03 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Yazen.Ghannam@amd.com, Tony Luck <tony.luck@intel.com>,
	superm1@kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH] RAS/AMD/ATL: Decrease message about unknown DF revision
 to debug
Message-ID: <20260306145003.GDaarpm6p8A-pFBCCf@fat_crate.local>
References: <20260305154528.1171999-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260305154528.1171999-1-mario.limonciello@amd.com>
X-Rspamd-Queue-Id: 7CCC82232C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5774-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-edac];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alien8.de:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 09:45:27AM -0600, Mario Limonciello wrote:
> commit 187d1b27a1e43 ("RAS/AMD/ATL: Require PRM support for future
> systems") made PRM mandatory for future systems; but this is only a
> datacenter centric point of view.  PRM is implemented on a case by
> case basis on other products and thus it will be expected that the
> DF revision can't be detected on some systems.
> 
> Decrease the applicable messaging to debug.
> 
> Fixes: 187d1b27a1e43 ("RAS/AMD/ATL: Require PRM support for future systems")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/ras/amd/atl/system.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ras/amd/atl/system.c b/drivers/ras/amd/atl/system.c
> index 812a30e21d3ad..a9bf05be5c3fc 100644
> --- a/drivers/ras/amd/atl/system.c
> +++ b/drivers/ras/amd/atl/system.c
> @@ -300,7 +300,7 @@ int get_df_system_info(void)
>  
>  	ret = determine_df_rev();
>  	if (ret) {
> -		pr_warn("Failed to determine DF Revision");
> +		pr_debug("Failed to determine DF Revision");
>  		df_cfg.rev = UNKNOWN;
>  		return ret;
>  	}

Well, this doesn't look like the right fix to me.

If the platform has PRM, then it shouldn't warn about not being able to
determine a DF revision because it doesn't need to...

No?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

