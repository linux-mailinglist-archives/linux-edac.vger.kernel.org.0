Return-Path: <linux-edac+bounces-1605-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28012944CC5
	for <lists+linux-edac@lfdr.de>; Thu,  1 Aug 2024 15:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BF12850E2
	for <lists+linux-edac@lfdr.de>; Thu,  1 Aug 2024 13:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8448B1A4873;
	Thu,  1 Aug 2024 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="P4/eXkl7"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2510C1A4869;
	Thu,  1 Aug 2024 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517481; cv=none; b=SyrX/74WCT/f/8uKAMoXgycGDcxHYRxF5k0hYQ4yMOZo3n+c0P6g2X8HF/3JiQ8Ufj6VRmTs7bHa9HxgGaRhoT8AOgojiVJxtDZK/2JnX/fbQoEp577413O/+2F83cj0hTHNJay147kBZ7N2CGyheEFbUdUb5r+lZ8hF606A6ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517481; c=relaxed/simple;
	bh=QeOFvX8CPC/i7RwzKKq1qEgaatgDVZob9axKMNH+duI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfbi1z/dPBSHle9ngRN5RTG9fIZQvGya2Pd9CTLGnROV+GNGguwpjaKor+gWsr7LcGpZ2KNAZAMmDu6jS2ELNwB6MRbC/rzzUJNU5tm6QROfcv2veZhVV47Io3hX0JZDLXe9/7FotkE4v+7dlOSv58lInZXXonEy72UrPTqGobc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=P4/eXkl7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D0CF640E0263;
	Thu,  1 Aug 2024 13:04:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ykpKzS36DsdC; Thu,  1 Aug 2024 13:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1722517473; bh=YdKj/KfrUcrs6Q95/eE+Dw5B5vcfEOQHYH5a2C8/lME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4/eXkl7vnzZFxV9FeUd6s/i3sVtOfHJdToQ6ADBtbb1XubBt3MqNCSDsO/812ux9
	 zfEgRm9+THndZJX/KeFP8lCLiR87XbfSkDl7XKQptSgzQQG/kG9YJ2dBSiM2o/auJt
	 6a1aFaif+IsRIDmZ8eARdXtBg/LqtJq+BsxYGWWNWRv+YFU6S1TShtwJFTHU+A1DKe
	 QZxSspYwzeLNXOBil4Y8Tvh27UGb8cdiQ2Xuf9BNabwVgfbTC4yJqa/WhfHPg6cApK
	 Y/bJkUG41T95k66Q9dNyMvpY1CmFsl2wSbNsc4Kc47pkFfutrs8nFq0bonOrJ+aUOK
	 nDFnTiIc/svdzCQpkl+9t+054Vu2oqWZCbz3Xu/TXFwdXXBgPS7utjsFHHTYsG271/
	 oridqcZyB6NsyNELjj2C9q4JuqjMbhOenOPpX+M30OlekwxD/6eSW23q8a6WQ/lNu8
	 K+sGNn0XcQL0KLNhhZWnfAAlnxSu7Br5QM77Iw5S7VRU1Wjnpmh0gDhyB2YVR01+Lr
	 DmtBIE3VFmmiB/wGttzYHsmIQbaCj65eWnXTXgosp7VsqS7yram4sKhjYG8vO52sQU
	 Y9V+L3QxZ55DoiuLssSiAkmrUFJyHDFyFHdAUmcZHR6Xm7PGAxvM/AGba9/XYALWI7
	 wofVBuJxts3UKbYhFll/nSDE=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1134440E026B;
	Thu,  1 Aug 2024 13:04:26 +0000 (UTC)
Date: Thu, 1 Aug 2024 15:04:20 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH 4/9] x86/mce: Move machine_check_poll() status checks to
 helper functions
Message-ID: <20240801130420.GCZquH1J8GDDiGUH_X@fat_crate.local>
References: <20240523155641.2805411-1-yazen.ghannam@amd.com>
 <20240523155641.2805411-5-yazen.ghannam@amd.com>
 <20240603173727.GOZl3_V9eVbm0184Wi@fat_crate.local>
 <20240726140030.GA193170@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240726140030.GA193170@yaz-khff2.amd.com>

On Fri, Jul 26, 2024 at 10:00:30AM -0400, Yazen Ghannam wrote:
> @@ -797,9 +797,11 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
> 		if (!mca_cfg.cmci_disabled)
> 			mce_track_storm(&m);
> 
> -               if (!log_poll_error(flags, &m, &status_reg))
> +               /* Verify that the error should be logged based on hardware conditions. */
> +               if (!loggable_poll_error(flags, &m, &status_reg))

Right, or do

		if (!should_log_poll_error(...)

as it becomes maximally readable then - like a plain English sentence.

> 			continue;
> 
> +               /* Clear a loggable error, e.g., one leftover from boot time. */
> 		if (flags & MCP_DONTLOG)
> 			goto clear_it;

So yeah, I guess.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

