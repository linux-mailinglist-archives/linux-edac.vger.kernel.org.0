Return-Path: <linux-edac+bounces-4709-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF56B3EAC5
	for <lists+linux-edac@lfdr.de>; Mon,  1 Sep 2025 17:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635714828BE
	for <lists+linux-edac@lfdr.de>; Mon,  1 Sep 2025 15:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E583570B5;
	Mon,  1 Sep 2025 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HC7VTl55"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC38535691C;
	Mon,  1 Sep 2025 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739844; cv=none; b=dGcoXZyxEwPOXttp/biYSSQi9eBDrwgGS7pV2bdkomYphWSQiIbhQpwI71NTlzAkJrdT7v6KWx58tydWXSvAWY0DBzURo6NpqvANcSXFyED9uc1OUHpBweCap4FLdimuznDZ0XS3lORMY2YpEL1mU3XiND+mu19rkt1sZ+uX1Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739844; c=relaxed/simple;
	bh=psh/GqKE0N6XjPAZ1VB7WNWkBHTv5Vf+6OZtUUhfAxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaVz9NNcjrI2qzVBs3f8iXa4iJTP5jDSYnmXBobdSP/gynR96aPyJIKJnSohA3uhLl0V4J1Iok/dqnHxdIRBskd41zXZxSqgsW6sjTWD76cW4WiHSipWXXqVnhLwP7VmQqrIJNanVahuUvVOTXf/DIk32cSXkbrcJGxYXeYhG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HC7VTl55; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9476D40E01A3;
	Mon,  1 Sep 2025 15:17:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id j3KPCpgOQIVH; Mon,  1 Sep 2025 15:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756739836; bh=wSGzID+6LWylLYcdbGGGVwZ9BdwqN9FQf6znuIrCiN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HC7VTl55YcNa//Hxr84/xHArlziRMwy8euPzWuuZfDSbRR6y7MtfFTxTFoS+4dDfz
	 xUNwM2dRLFevzLQXzGfdKCGpM82SmXrwAo4odO7oNasO8LCuYGeJLxI3p6w0CdftJj
	 d8ryamzbOdq2RNJH5IYMIC1dZvxDHV0+wjI4Q98qskrt4CDpJBJ9QFlhwn4PbmcAmu
	 O3u0WsR3f7cxM5OGqgBNaGrpvoEyGCVtsTVATmKX4dDpqVwKmraHeBc/zJVmQ8rN0K
	 ZGT/fkWcJPVEUG440nv0ecbX4zN/Q/eQFr+QLWqUs6hX+pUrdZwgken1s1dHvn+BqK
	 AGG3fag1ry5KmOW3p0Hdg2fKv9wW3Klk++7sfbT/7nwh1NhpA6SsP0MRNsAVcXX6+s
	 I7FmBPh2S3iht0z7mPZyBSsFIap8DW+Ea46bBpE/BPLELg6y85kapiSd1tSSE60LSc
	 6LSgFjS6im56T/YGy9Tp5ZQ50YaLctZrQK1ZjFjgfJl/GFkr1ukEVkjNV0xa3l2+ZX
	 nK+GSTs0ELKfpUiaKPugx6oY6El4bnodY3Tt3AeE8HzHVVl6+RMtzKa/Qo09XWx7JP
	 XYDEaUh5J/7Vt7P5H9jN1k0a16/iSINS+r1icsJbHPXbA0pLvNSOvr/Nctzg4Cx2Au
	 YX6uDl8o95tEUbM7ZO8Sm7/U=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 469FB40E019F;
	Mon,  1 Sep 2025 15:16:59 +0000 (UTC)
Date: Mon, 1 Sep 2025 17:16:58 +0200
From: Borislav Petkov <bp@alien8.de>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, git@amd.com, ptsm@linux.microsoft.com,
	srivatsa@csail.mit.edu, shubhrajyoti.datta@gmail.com,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>
Subject: Re: [PATCH v8 3/5] ras: Export log_non_standard_event for External
 Usage
Message-ID: <20250901151658.GBaLW46ibJuf4kGgnl@fat_crate.local>
References: <20250826052914.2066884-1-shubhrajyoti.datta@amd.com>
 <20250826052914.2066884-4-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250826052914.2066884-4-shubhrajyoti.datta@amd.com>

On Tue, Aug 26, 2025 at 10:59:12AM +0530, Shubhrajyoti Datta wrote:
> The function log_non_standard_event is responsible for logging
> platform-specific or vendor-defined RAS (Reliability, Availability,
> and Serviceability) events. Currently, this function is only available
> within the RAS subsystem, preventing external modules from
> leveraging its capabilities.
> 
> log_non_standard_event is exported so that external drivers like VersalNet

"Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour."


> EDAC can log non-standard RAS events.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> 
> (no changes since v6)
> 
> Changes in v6:
> - Update the commit message.
> 
> Changes in v2:
> - New patch addition
> 
>  drivers/ras/ras.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
> index a6e4792a1b2e..ac0e132ccc3e 100644
> --- a/drivers/ras/ras.c
> +++ b/drivers/ras/ras.c
> @@ -51,6 +51,7 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
>  {
>  	trace_non_standard_event(sec_type, fru_id, fru_text, sev, err, len);
>  }
> +EXPORT_SYMBOL_GPL(log_non_standard_event);

In a pre-patch, pls delete this silly wrapper log_non_standard_event() and use
the tracepoint trace_non_standard_event() at the callsites instead.

Then you can use the same in your driver.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

