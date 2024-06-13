Return-Path: <linux-edac+bounces-1275-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A9D9065AF
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2024 09:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D07C1B21893
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2024 07:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B268C13C8F3;
	Thu, 13 Jun 2024 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="T2BJLcLs"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6877A839FE;
	Thu, 13 Jun 2024 07:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265114; cv=none; b=tZ9RxsddiK6iMWyiS7pvWAZU7wkSs7nNv8S+qtNJBJpD14EnsnwmYb1iv1qyqYUjpQygaGDrKVTP5dNG3QqzaGxZnvrnovEhap09x7Y1JPHbFeBWY3r9hUvZ8sYH7vpYQNG75e8+i+j3cJj7bpTrtiiqW62Jij2yv6+8MnQmgNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265114; c=relaxed/simple;
	bh=Uc68A/Z2dnp+EPn2Mn20HutZm21ns1m6JBGXU8YI58I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjnRXRdQKRqsJTA9SX0ps/eeAuoXKlwrXzfUbpv3+/8fTtcHvdST41V8e+z+VqzF86k+mspULZN4pIZRNAhlA0zl61uS4XZaOFcdAbG46lOLOj+d+8rqNHQAtaow+nsaSiY4MMMJUFK5lPtY0wwnXXuGOa8/rgL2CU8XdHcgNLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=T2BJLcLs; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ECD2740E0031;
	Thu, 13 Jun 2024 07:51:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uk38oFMJqAX4; Thu, 13 Jun 2024 07:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718265105; bh=RGqprgHi+fesE3B7syrHHqC5R6WRwSpH4rvL8n9j8Yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T2BJLcLsd2XdTqNAQxq25acuFVgw+yEat0NXg4eMTUeAdVuCn71A/LmHRfos1YhCZ
	 9sDEtt9Q+B0we8SdpcCdtVd9rbYy849Hi2z/B+m0xBPfoxBUMaU02958TZpv8cnwsE
	 Jm1UDH5HVTMtoPpHJYD8H4I/Xda7n0wGL3p2CQpT7ilu3ItjbuJ5XO6TdZRV3ol6uZ
	 bXmybrGxOBSkjY+Si+Dsb722j0Diifx22bbAgJQkMUcV1bwhISYQqYrZpIPw5XRyyC
	 9drHVgifPPLneb7nQQf7mtUNtFTva5e9q2y7EvSHHDeMbaVg7rUy1WT4u8NLyZkOli
	 XK0AHIeq7eI48QlTccG3BckW3dt5Yrgqq2C3nhAJpciQTXucK9Y04BJtXSx+QOjFrr
	 +HdZNCGpG2KEi/0wA5PAmo3CYzOtI9pAkGUPKAeAKFGgCw52+eC8OztDRO2lcdK2nA
	 GfIxGFEa7VkVb6WYH98haLotNegiazkaXWrm54OAmXboKQtvFk8OAPSPSRqsATgs/H
	 PjSUGOhcum9l/mmw5mfOxwfT5f1+UWaMh0wjBtnhfyE3L9GLJ6wsH6nYK5wbZU9kSb
	 wg21zJ72qbW9WKrNR12ttVjLVg71QiQ/kGzT1CPdklWgTtYTC6upfeWSD1di1VeNi7
	 vzwT3zvtOFyITojKkFHLmOCQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0E65940E0081;
	Thu, 13 Jun 2024 07:51:37 +0000 (UTC)
Date: Thu, 13 Jun 2024 09:51:30 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Thompson <davthompson@nvidia.com>
Cc: tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
	rric@kernel.org, shravankr@nvidia.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] EDAC/bluefield: fix white space in
 bluefield_edac_mc_probe
Message-ID: <20240613075130.GAZmqlAi0SBaudjqgz@fat_crate.local>
References: <20240613045902.12029-1-davthompson@nvidia.com>
 <20240613045902.12029-2-davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240613045902.12029-2-davthompson@nvidia.com>

On Thu, Jun 13, 2024 at 12:59:01AM -0400, David Thompson wrote:
> The routine bluefield_edac_mc_probe() has an extra empty line,
> so it must be removed.  This extra line is flagged when running
> "scripts/checkpatch --strict":
>   CHECK: Blank lines aren't necessary before a close brace '}'
>   #324: FILE: drivers/edac/bluefield_edac.c:324:
>   +
>   +}
> 
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> ---
> v2
> - Updated commit message per review comments
> ---
>  drivers/edac/bluefield_edac.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
> index 5b3164560648..1f6f39a7dbf3 100644
> --- a/drivers/edac/bluefield_edac.c
> +++ b/drivers/edac/bluefield_edac.c
> @@ -320,7 +320,6 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
>  	edac_mc_free(mci);
>  
>  	return ret;
> -
>  }
>  
>  static void bluefield_edac_mc_remove(struct platform_device *pdev)
> -- 

Did you get my reply to this and did you read it?

https://lore.kernel.org/r/20240612200056.GGZmn-eO15ePolbAPo@fat_crate.local

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

