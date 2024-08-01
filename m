Return-Path: <linux-edac+bounces-1606-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43C5944E16
	for <lists+linux-edac@lfdr.de>; Thu,  1 Aug 2024 16:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80DF0282BBE
	for <lists+linux-edac@lfdr.de>; Thu,  1 Aug 2024 14:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEB81A3BC7;
	Thu,  1 Aug 2024 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SCKi0nuJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C1A1A3BDD
	for <linux-edac@vger.kernel.org>; Thu,  1 Aug 2024 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522725; cv=none; b=M55ZnRxpHtyXKwxslPHg19JrWL4h+nniAifjetWKt/yde0OGjuSBxdkVk0tW5sJiHSWu1fEDl8pj74J4+eF6I0nktNBW8XBN1lpTNh1ySEBCLAHl4DW7iq8jVQcpt34uKMHefMQjjjpXQKFHyfz614RW4PEW6JaWBN78vuILERw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522725; c=relaxed/simple;
	bh=ua91oLOwWrFTRQCJARebw5vM6CkmhatJoZc15M9O8KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpnLpAkV3GhdI4XyBv+CIi/Sy4YK2PyWgM+iYl8QAdhSa2qfX8dUjMoRJ7Cc4i85L8+g/7C98rjfvrFzOn4hqMRZXp7Oz4ngo6Nj/xls00ZPYt1wKFqeH/79H1jTPQ+1oDCtuoK17EOh2ixGJfSlCWiwAIVpKvRvWZKV7A3X0yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SCKi0nuJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EDB3F40E026C;
	Thu,  1 Aug 2024 14:31:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lNOO0_zAIC0j; Thu,  1 Aug 2024 14:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1722522716; bh=lHmWEBt9+LnIufU70Wz5lMg0wPmx+YkJpfdk/oSXaQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCKi0nuJjRWXqgoOxl2XsWkNnuFOCGS3dAtbAMnO4KG0n/+t6s43XfCNIaAE039e7
	 AS4CwcfoCjawFx3ox0bKqx+LvO4km8jyX3ncYYQg7IEaOlRyUg9kFX5mrYo1LQjCwd
	 7ZhMc5cokU8IuVfKyq6aZqqI5AU/9d937KZi0pSWmptmkraqdTwroRi1N2NMyGebQ1
	 dZBLQw6RwTtMfZuLnESWCvNrVbHJnrQBB+NKDSr4FRbMSk0S3CgcFJCrfmEwVPvh/A
	 jFkGI8ZOmsSYpN+q/hv/gizJckhMYdFC5IjxJzjVCDMZmuwQuSgBxzEZE88aOiKOKc
	 iwIbZOi3j8q+BBB1wLYZYk0RAItooTxV0crw4Rf5t0JwN0QG+he70YNTvmoobRwAkp
	 Gnm17lueNSoJpKpLBktGltfb7tRuqHzwSXG4S9oUX48Nzhqs68+Uh3tIZKPBhpeYzT
	 +soMeY7hpNuCq/XeeOejiGDphO0gcRkhpDCcygtojZDb/bcpyp5ICs0bzsLeRCvhSf
	 an+gCN2vEj+F4cI2TFwnGXma5kcvWTFO3MGDhsS6xG+aRPmvglO2HS3KWYQyzHDsB3
	 Bh81am0RXfJ5ktSdgTJM11BEFZgPZqxZ4L7+8K3N5j6RaNotLeAwmXn/0HNK/pGkmX
	 PxToZd3R0OvTEVdA8DREv9VQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 30DBA40E026B;
	Thu,  1 Aug 2024 14:31:49 +0000 (UTC)
Date: Thu, 1 Aug 2024 16:31:41 +0200
From: Borislav Petkov <bp@alien8.de>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: linux-edac@vger.kernel.org, git@amd.com, tony.luck@intel.com,
	james.morse@arm.com, mchehab@kernel.org, rric@kernel.org
Subject: Re: [PATCH v3] EDAC/synopsys: Fix the injection of the errors
Message-ID: <20240801143141.GDZqucTcmQYiwsVNWA@fat_crate.local>
References: <20240711100656.31376-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240711100656.31376-1-shubhrajyoti.datta@amd.com>

On Thu, Jul 11, 2024 at 03:36:56PM +0530, Shubhrajyoti Datta wrote:
> The Zynq UltraScale+ MPSoC DDR has a disjoint memory from 2GB to 32GB.
> The DDR host interface has a contiguous memory so while injecting the
> errors the driver should remove the hole else the injection fails as
> the address translation is incorrect.
> 
> Introduce get_mem_info function pointer and set it for Zynq UltraScale+
> platform to return host address.
> 
> Fixes: 1a81361f75d8 ("EDAC, synopsys: Add Error Injection support for ZynqMP DDR controller")
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> 
> Changes in v3:
> - make the address u64
> - declare the variables in same line
> 
> Changes in v2:
> - get_mem_info under debug flag
> 
>  drivers/edac/synopsys_edac.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

