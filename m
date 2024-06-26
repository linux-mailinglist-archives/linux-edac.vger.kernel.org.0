Return-Path: <linux-edac+bounces-1380-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE74891807F
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 14:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE791C217CF
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 12:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C4C180A7B;
	Wed, 26 Jun 2024 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UV8Pr+Gd"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA5F180A6A;
	Wed, 26 Jun 2024 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719403496; cv=none; b=dxnaBJDu4qvZVofKPDGCU4r9YumNDARpZN1fbRGtc0lgGnll4ZDN3JXdOL01IxH+cTn/vVygjn8LFJdjMYfYpwRINH7jiGaLC+gMIj9E2HzSEjfkNPE5cYxte7anfL3pvw3sL0ui3fWPVf14UogzPwoZMDOshpBPdM/N2OfoYCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719403496; c=relaxed/simple;
	bh=RPSKzma0tITGWNvrqVFU2s7s33ANWD+5HmsV/+rnbU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brv+K+J01rL1TtysXJKAqdpHVXsNI6miEGmy4OoNmWp4ktBwd0kSQ5h6FJrN9TRe7sX727fTKY2D/hWvfqxD1C4kORw6hNOlubNmaJC/wj44w/vsmfpGck7Jpa83TSLqgi/BmiP9U/Awyp0E4TxjtAdK7p0Wkf3TaPCVgHHGUWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UV8Pr+Gd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DFE9540E021D;
	Wed, 26 Jun 2024 12:04:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZqpO0mb8Hsle; Wed, 26 Jun 2024 12:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719403488; bh=RtsuJxlpaR/vRpQMDpl+Q6w8HUwk8Oh67+w5Au7b/og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UV8Pr+GdPP/ZCDA6G9OkFPmx/xqeMXJ8nXBfShukrhWiNJerlwzUndKWYysSAcauU
	 6DguyyxF7mJw8sk0VxW64oTL3GUvB+Nh9ym/QK77xxdwhUVvtYNXwSWhEEZNhoDP1r
	 6Ic9FyuuEGZIetqhSm1Z6glPWXt5sMCFXGZ+1glJcbyVCtf4P7ousy6uo/v4tRDkNu
	 ZkChOMpOnbjIk7LKA9Vj7veh5C12ZYFxucNNrip1HED/pMyRPY0aH781zo/096O7IL
	 Z37mJ2O8Nt4v9u8VWVGahty+fZ11dWXHo3vemwhiDNTf78zQOV0691mZrIZzo+9YCg
	 RaD8Ff1ZI6ZBo75q/GPPdgJUHMW7Zw9Q2jGCw7jks74Wms/a8ejOgwIeON/0kkkorH
	 6+KIJpqtI1ZSQMXKyQJzE7JWs5dWPZcJoGw1XREhZ/xr72ISEVrSShcfDOm3FBZC8q
	 y1xPvRSzLoJB+fKyfYRJTaAfW18xo8qdv9iPLGwPd9GgnN4gfLajaVGuAZ+4HWLp1p
	 Y06MKLVPD3dl0b+0NMPqTDPXpri5u/AjIqguG1+oR6AiibgIwoC6JbxeK3yKKF0wGc
	 dZ8uxcfvfxtC4TFrlvzyQIc9PNF9ivQ0R/14Ar17z51ur8tBisOzLbLSdSHH8XMIVQ
	 ak63VomfFV+y+H7tsOqyh27A=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 981D140E0185;
	Wed, 26 Jun 2024 12:04:30 +0000 (UTC)
Date: Wed, 26 Jun 2024 14:04:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: x86@kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	rafael@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	rostedt@goodmis.org, lenb@kernel.org, mchehab@kernel.org,
	james.morse@arm.com, airlied@gmail.com, yazen.ghannam@amd.com,
	john.allen@amd.com, avadnaik@amd.com
Subject: Re: [PATCH v2 4/4] EDAC/mce_amd: Add support for FRU Text in MCA
Message-ID: <20240626120429.GQZnwDzQ47y1fOlFTp@fat_crate.local>
References: <20240625195624.2565741-1-avadhut.naik@amd.com>
 <20240625195624.2565741-5-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240625195624.2565741-5-avadhut.naik@amd.com>

On Tue, Jun 25, 2024 at 02:56:24PM -0500, Avadhut Naik wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> A new "FRU Text in MCA" feature is defined where the Field Replaceable
> Unit (FRU) Text for a device is represented by a string in the new
> MCA_SYND1 and MCA_SYND2 registers. This feature is supported per MCA
> bank, and it is advertised by the McaFruTextInMca bit (MCA_CONFIG[9]).
> 
> The FRU Text is populated dynamically for each individual error state
> (MCA_STATUS, MCA_ADDR, et al.). This handles the case where an MCA bank
> covers multiple devices, for example, a Unified Memory Controller (UMC)
> bank that manages two DIMMs.
> 

From here...

> Print the FRU Text string, if available, when decoding an MCA error.
> 
> Also, add field for MCA_CONFIG MSR in struct mce_hw_err as vendor specific
> error information and save the value of the MSR. The very value can then be
> exported through tracepoint for userspace tools like rasdaemon to print FRU
> Text, if available.
> 
>  Note: Checkpatch checks/warnings are ignored to maintain coding style.

... to here goes into the trash can except what MCA_CONFIG is for being logged
as part of the error.

> [Yazen: Add Avadhut as co-developer for wrapper changes. ]
> 
> Co-developed-by: Avadhut Naik <avadhut.naik@amd.com>
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

Ditto as for patch 3.

> ---

> @@ -853,8 +850,18 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
>  
>  		if (m->status & MCI_STATUS_SYNDV) {
>  			pr_cont(", Syndrome: 0x%016llx\n", m->synd);
> -			pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
> -				 err->vi.amd.synd1, err->vi.amd.synd2);
> +			if (mca_config & MCI_CONFIG_FRUTEXT) {
> +				char frutext[17];
> +
> +				memset(frutext, 0, sizeof(frutext));

Why are you clearing it if you're overwriting it immediately?

> +				memcpy(&frutext[0], &err->vi.amd.synd1, 8);
> +				memcpy(&frutext[8], &err->vi.amd.synd2, 8);
> +
> +				pr_emerg(HW_ERR "FRU Text: %s", frutext);
> +			} else {
> +				pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
> +					 err->vi.amd.synd1, err->vi.amd.synd2);
> +			}
>  		}
>  
>  		pr_cont("\n");
> -- 
> 2.34.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

