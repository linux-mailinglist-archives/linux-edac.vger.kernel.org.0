Return-Path: <linux-edac+bounces-2557-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A5F9D0EC7
	for <lists+linux-edac@lfdr.de>; Mon, 18 Nov 2024 11:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2789C2829C5
	for <lists+linux-edac@lfdr.de>; Mon, 18 Nov 2024 10:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E30D19413C;
	Mon, 18 Nov 2024 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JvWhmqmR"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59E31DFFB;
	Mon, 18 Nov 2024 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926525; cv=none; b=SJWeID9IcqCnxH9FNlG46pTPj2fJw64X+NVKQM0n4KGZQg3fwWZMDEVmTJbPB31299AsGIlH9kNg1yR7JTfWjZSgMNmBrr6UVazLaFiAIc+HlT5gIpuCoef1klyLhGcGSx32+o45vGhpLU4FKnScnPE7DfDdyixSMa7vX9mtOhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926525; c=relaxed/simple;
	bh=/pmGenI2wO3JTNxmubF24thm679YUhSXwuotCg6tHFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re9rdPujXdL2/PdrYjO7r8jQdT0bRyH5u7K8nc/U99eIjLiWHFbx2YwPfibln78joil2lrsg/JcgHloTM0MUmYM5rR/EHtrU1mmvqvwBiNuT0eYPrhp152Oq8Zi7p5POpyUC3Y4ODh39iupZpep/7skiUJjCkHdXYXqFY8QohVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JvWhmqmR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2708040E019C;
	Mon, 18 Nov 2024 10:41:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OvAE2aXAax_E; Mon, 18 Nov 2024 10:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731926513; bh=DmWtgi2Qz0m6ZoT7qjh0PUC9+yoNEpuOT/5+gLqTlk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JvWhmqmRUL7hkytSCadEsftyQZKStLgnKxQ7agUehRPUm1ZpVWnixa4PPWp1SIqoe
	 B0enESfQMM4tBv8OGr3oljiDEJy53Cput7Tbtpo5l/yTEOABbGS7lsX40nOSy78mGK
	 uN0kaY126B8moeEx1Kd74aXQBfWrqZULBxXSJmSBS1T4XQwhnX17MBMiHfLy+w1ynD
	 tk7kA0N+oLs6kJpgaVSP1Af169qh2I7ULbzp9bu6xvTzh+h/48BIdqnxwWT8k+6sET
	 xpqjcnpnUrKE5vtHnoDTSbyVZONtyWW7D8zJpnZmmTHWbh/KiNv+MMvRGTCVQ9Zx/Z
	 J5daFgDpW47r1bpgQQPSyduzz085tzUxHbLWXX7NAKwUbY0hrUnvd0zFLUK1AiRg8X
	 rTm1iGsHtQsMyBztWeLmr2FSQgr1FZUZTmGDJfunx4IgtvVcJjwH12+05OAy3T+Srr
	 cX7AGw5UVQPhXz2KTTn6TWzFHlIRIXbRVkc5wbh7/TvrKxJ+aND6IwipLlv25LlrnH
	 jHHOMYePIE22wYsbcwEXa3F7LylXwFh8Tt07LFZBesr5abbc0KxkiLCwudeTg9XjAQ
	 eGqnrrFfxj4NMxqUcqEiRoUAoel5a0PUXnFILzlBIairHJVl1TPu2mKq4K99nFb8GG
	 Hej1E+d6sW5YH7KdeqVs6lQg=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 165CA40E0163;
	Mon, 18 Nov 2024 10:41:48 +0000 (UTC)
Date: Mon, 18 Nov 2024 11:41:42 +0100
From: Borislav Petkov <bp@alien8.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com
Subject: Re: [PATCH] EDAC/powerpc: Remove PPC_MAPLE drivers
Message-ID: <20241118104142.GAZzsZ5vcY_Vv3GvY-@fat_crate.local>
References: <20241112084134.411964-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241112084134.411964-1-mpe@ellerman.id.au>

On Tue, Nov 12, 2024 at 07:41:34PM +1100, Michael Ellerman wrote:
> These two drivers are only buildable for the powerpc "maple" platform
> (CONFIG_PPC_MAPLE), which has now been removed, see
> commit 62f8f307c80e ("powerpc/64: Remove maple platform").
> 
> Remove the drivers.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  drivers/edac/Kconfig        |  18 --
>  drivers/edac/Makefile       |   2 -
>  drivers/edac/amd8111_edac.c | 596 ------------------------------------
>  drivers/edac/amd8111_edac.h | 118 -------
>  drivers/edac/amd8131_edac.c | 358 ----------------------
>  drivers/edac/amd8131_edac.h | 107 -------
>  6 files changed, 1199 deletions(-)
>  delete mode 100644 drivers/edac/amd8111_edac.c
>  delete mode 100644 drivers/edac/amd8111_edac.h
>  delete mode 100644 drivers/edac/amd8131_edac.c
>  delete mode 100644 drivers/edac/amd8131_edac.h
> 
> The removal commit is in the powerpc/next branch:
>   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/log/?h=next
> 
> I can take this via the powerpc tree if that's easiest, let me know.

Yes, please do. 

I've been meaning to reply to you but then gazillion things interrupted me and
... you know how it is. Sorry.

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

