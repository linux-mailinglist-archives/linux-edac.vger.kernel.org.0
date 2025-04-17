Return-Path: <linux-edac+bounces-3570-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B94A9185F
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 11:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E1319E10B0
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 09:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D293C22576A;
	Thu, 17 Apr 2025 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dD84BtS4"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3B322A1CD;
	Thu, 17 Apr 2025 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883567; cv=none; b=K+fXIhpP/iFrcODEY69+sZUCwQKldJg7BKT2VtD4EHDEDZiuJirnOorTVa6dn6qIIJnbBUNkPOTJNklIO0mIN9anJiCr/tHPH5cUd6xihpFCTIrbzXIZLT4jvvw+WHAT2xPaW8xWgYt0ThYpCtPyI5Eqc+aqks07LycSCQcSXKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883567; c=relaxed/simple;
	bh=3p0m4AMMqUbeF68vOUQ53Zy08bnbsFXiuR4HWI2d7Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUMGvIqoTbfzEC83hV4P9tFNA9k1v6DTth5ePfKgJJRHFVI2DA5UBX9quRQr5466YzdU2Go9zSL1RTop7KrgqbxWEn4yCJNVPBgmaNhHk47koNT/jPesczD53VCDY2kLyADlJOmg9aOv0o0RXDcOfWOa/3nYVdcwuYm4gr2WebI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dD84BtS4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8082340E0214;
	Thu, 17 Apr 2025 09:52:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hsNg5aU5HFyF; Thu, 17 Apr 2025 09:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744883558; bh=w2neWnxpT1hw6acaDPyFFGhOH3MNvFMlE+UJHwJuNT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dD84BtS4qZIP6uuprTQw3ZMDi8T66zGR37INonZWwA+p+cnb/558z8Rit0uBwZ/qm
	 z6X8gDJpjhSjUSfksfGAlwo77lxQuL7p04ayet5KjPSUo5igPEJBcIXKDF819vUIh/
	 EH4mDD10EF+q9ivwK49YY+KG1vzsNK9Yb6gdrOCsiQbcwIR4LUSiRyCPbtVqGiaplO
	 xRT+1kIy8Zn12f6vBgffY1uwSDaBExAK/tLcmTJzNEHwbSf1QEpnd/L2w3ilEbDyNo
	 cgM4BrWezbqtiAVjy2qfMp3Ir5sKONNXRefilCzlbGl59JxyPqQU6bYYa+ibv/UKBV
	 /PvieeBaaC2JMdufxgMtoTuLvfvszHlhzqrF3qS8KYiuJwREyWJF2bh2swz9fOqlrG
	 ho5LEuoWa9vB3rgXGIc+vVxtA/Y9w7biY+qehWrdz1+gm3BL98BZwJ+Hd1rSep6rA1
	 xRnsy6G4aUWeieJokk01wWCk3UEzcjFOrrXgN8/5JWBgRevIWzA3VUIigKHvKx2aSK
	 YomT4VbTLAXXp+gFfprn4l5cV8KGrbfvrW4Rw0tcS+Pbb9Eqhgg8oY/8s7K72YCEov
	 2FiUGexAIw7oRs2BJxhhdmOuspRtyoESwRfu0InjZRE8CxG2rL06Ec3ZHoDpTkiTok
	 E+LTBtRFFZSRd0bYaLLcjMek=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D8BE840E0196;
	Thu, 17 Apr 2025 09:52:30 +0000 (UTC)
Date: Thu, 17 Apr 2025 11:52:24 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v3 08/17] x86/mce: Define BSP-only SMCA init
Message-ID: <20250417095224.GOaADPWJkNPV3rChp4@fat_crate.local>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-8-8ffd9eb4aa56@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250415-wip-mca-updates-v3-8-8ffd9eb4aa56@amd.com>

On Tue, Apr 15, 2025 at 02:55:03PM +0000, Yazen Ghannam wrote:
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 206973d7dbcc..0d84b171b851 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -687,6 +687,12 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
>  		deferred_error_interrupt_enable(c);
>  }
>  
> +void mce_smca_cpu_init(void)

Same note as about the previous patch.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

