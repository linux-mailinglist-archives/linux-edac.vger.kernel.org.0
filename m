Return-Path: <linux-edac+bounces-2351-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9649B68DA
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 17:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1543B22649
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 16:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DA82141B9;
	Wed, 30 Oct 2024 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UbPoSezr"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834212141A1;
	Wed, 30 Oct 2024 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304364; cv=none; b=bQfa8wn6zuhnHZ0MM+qfZ7At4/sKLM4o0BNKX2TU8D0/W/3vuKPxJSOjdtzyYT5THy2MsmObmxNOdQiAnnBZOPiPthWOnIoujBaXVNr1KM9pGXm+oexZAahcxGZ1jdwOvUeGFtpTszEticS6ePKTxIEnREHifplCJmR3tUiL6wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304364; c=relaxed/simple;
	bh=K5RfbokEe9SJslqHAgTzxGIKwLTk4MjbTLj0WPI4qmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMKaOhauoh5EuV7FhXiR2xsHsEafv/E/+CqUwL8Fmt3kSM12W6JkTYx2uLhKeIXoht1P5NQZdUOWvNgfPw9ZcwIiRgQgtd/qw2Tdb7oaoUGLbprS6UAXD6KhmNawCekEzylekqTuCUzWnyvZJEd+yCFcBHtGC6gxg9hl0dyHEyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UbPoSezr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0B8B440E019C;
	Wed, 30 Oct 2024 16:05:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rxmd0Gl-QDop; Wed, 30 Oct 2024 16:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730304338; bh=jnR65QrcFCF7T2SN80xCHIA06Ync0z3yyPLSbAqJc0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UbPoSezrnWSzk29OkIzZxt0ufSto8If09wJIBV8PWJSKlUBXEAT1HmdpVfaoEP0Ed
	 GxmEJcaDelvtKK0SE7Ro1mwEcCDMbrTNjIHmFJY7Gm7FlZB/J6l66m3bFT19QcITWH
	 EHTOLTEjC+w5zPlsRL80JfjYIylHmm8ALBEhK8jYb8zFXUU3jn/45rfA1WXCDR047v
	 DZbrQoLBUdWijQ7csuBZzNYSKoL4Qtbcc+631JlZYAIxihjwuOnUcq+mT8cfbwsXzI
	 lJNusLL0LMiPOuE+usMRiR7hUKwfaWKjvE2on9KKcd5JFctgNHhDIz9Cu8c7roifRq
	 4xw10/mQUqYLlHBp3tN02LAPJfcRu8EiBSUsd0e1t6deX0DjKOncml6/nScYjZnn0C
	 KSsg1TJmzavkwOxfUoJu8Tdq3ejM6Hryg8qOkk+38I0aSIo40ZofHoXVv9nA3FbTbw
	 0XF/DBhtJHu+neRrpNsLNxu+cqfmpH2HjJZiKkZ0ObpnT6dWgPG7qvYzHBgCOxvISp
	 b9rfP/ZBlDaFmlxECm8B8HdqbOb6qKV8/YxSO7x9x17Ivuv/El9Iu3gVpCGB1tyW7m
	 MiCj5vq3fUwAg0Hnum8ijKl+0N8mqNWK8A37mHCYU02YDax1r1uIiaIxUHR+2dvmK4
	 CGqTvrt1gUopgCTVMdB18kWM=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 530FB40E0219;
	Wed, 30 Oct 2024 16:05:25 +0000 (UTC)
Date: Wed, 30 Oct 2024 17:05:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: x86@kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, qiuxu.zhuo@intel.com, tglx@linutronix.de,
	mingo@redhat.com, rostedt@goodmis.org, mchehab@kernel.org,
	yazen.ghannam@amd.com, john.allen@amd.com
Subject: Re: [PATCH v7 5/5] EDAC/mce_amd: Add support for FRU Text in MCA
Message-ID: <20241030160518.GEZyJZPrEL7G0eYac4@fat_crate.local>
References: <20241022194158.110073-1-avadhut.naik@amd.com>
 <20241022194158.110073-6-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022194158.110073-6-avadhut.naik@amd.com>

On Tue, Oct 22, 2024 at 07:36:31PM +0000, Avadhut Naik wrote:
> @@ -853,8 +850,18 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
>  
>  		if (m->status & MCI_STATUS_SYNDV) {
>  			pr_cont(", Syndrome: 0x%016llx\n", m->synd);
> -			pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
> -				 err->vendor.amd.synd1, err->vendor.amd.synd2);
> +			if (mca_config & MCI_CONFIG_FRUTEXT) {
> +				char frutext[17];
> +
> +				frutext[16] = '\0';
> +				memcpy(&frutext[0], &err->vendor.amd.synd1, 8);
> +				memcpy(&frutext[8], &err->vendor.amd.synd2, 8);
> +
> +				pr_emerg(HW_ERR "FRU Text: %s", frutext);
> +			} else {
> +				pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
> +					 err->vendor.amd.synd1, err->vendor.amd.synd2);
> +			}
>  		}

Right, so let's turn this into:

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index bc5e67306f77..edc2c8033de8 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -208,8 +208,6 @@ static void __print_mce(struct mce_hw_err *err)
 			pr_cont("SYND2 %llx ", err->vendor.amd.synd2);
 		if (m->ipid)
 			pr_cont("IPID %llx ", m->ipid);
-		if (err->vendor.amd.config)
-			pr_cont("CONFIG %llx ", err->vendor.amd.config);
 	}
 
 	pr_cont("\n");
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index d69a1466f0bc..62fcd92bf9d2 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -858,9 +858,6 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 				memcpy(&frutext[8], &err->vendor.amd.synd2, 8);
 
 				pr_emerg(HW_ERR "FRU Text: %s", frutext);
-			} else {
-				pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
-					 err->vendor.amd.synd1, err->vendor.amd.synd2);
 			}
 		}
 
and simply treat synd1 and synd2 as FRU text. I don't want to expose
mca_config to userspace yet but use it in the RAS code only. If a case appears
that we want to really expose it to userspace, we can talk about a proper
design then.

This patch doesn't make it part of the tracepoint either so...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

