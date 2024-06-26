Return-Path: <linux-edac+bounces-1377-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D949917EA4
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 12:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECBBD28A9F9
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 10:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E18117B50B;
	Wed, 26 Jun 2024 10:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PdlZ4x6+"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607B2176AAB;
	Wed, 26 Jun 2024 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398702; cv=none; b=eSMV6Iw8t1oF5TN/PDTyqheGaC0MhTzW3nm9QchOa2/uXZg/WNOSCil/Rd8z0f3ICIhIML9DWx3BGu776HKy2kctVhj9vyUxnHsXBD9e0zMwkTZa0G81lcE0x5MEs+ZejV8sV2gGlBtq+5thFBH2WxP7Tj2owe0bk/Ux2PJ+E7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398702; c=relaxed/simple;
	bh=N5HUNnSxF52LqTiTZ4MD/cgKDig5Sbo0lMVYyZgGD88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihsH59JUNRvr+UT65RmL5+qC3iBJJ0dfLO/63b1nKVaPhx+dZE1CQ3Z2/zc7PNaEJ6w4xiw6iLYBdSoR0wIqg7NaLIlm3h1+QhoN3wRUIdbfMC6s+XnXIxeZMFJMbN4S+msj9JqqIV4H+/pTFZxZKINqgdOSMYRIiujhJbI5PxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PdlZ4x6+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 959C240E021E;
	Wed, 26 Jun 2024 10:44:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WLfKgW4WQVYn; Wed, 26 Jun 2024 10:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719398691; bh=Y2MsjGLfE7g1SN+DJyJWLxEAOzeLgB4denA5+ilckE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PdlZ4x6+xF4IrjgXiJynmbDOih/0s7toOMtXLZexV6s3QxDY98m4u1/H2vKjvjtEv
	 tI5sWZO46M14fnZ+XHwS/52/LRKqnXyHF6aRFKoD/5ruHdG+NykZ9oK3yKxpI8MnQ3
	 2YtACds0AjJ5WyAIQZ06a4/vQFEombCbYoipqZE6b9dWlzS2v/KXBD67MZpBgp/hLS
	 fRbLZxqAr+KZMgfhVRMfuKl3eInAaYnimzGafclexXnBtzX/e93FXuXFK8jq2Txypd
	 NYq78OrHTmLia/vXFeC01Nw7FoHImiSkFqIrbAviM/n//OOzZB2uAhIhI/3lbACkm3
	 2RRl1AkELgqoZDTlj4sU/xnYD6Lxv/88Iuz6eeI/NaZfbAfxer4fEEexmPPA37KUyx
	 r0xbm2Ffj4ltVMcE282lMtQB2x1YirE7DJzqCasfumzNNgxL51+hOgPLjg+dbzSVco
	 uP/UVXU3Y+DljvRiz9sIVnKQ2wOW6xNxB5iY612TPgBBz0E12fZhUIHGnKqjBuRnR5
	 /4GgmObWcU2zXNrFQrZ0tLvggkp16vQpsI3k7TzQUrQ54iNLQDgO/LRnLY59Lx8aA7
	 5HMDGdyV6M8GBHusBC04GUmGLNXAtI1BiXpPexdISG/b4uhbOMB5Krhcaarh/Ds8bp
	 9hVabBrD9DHO04wnwhnhlLM4=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8562440E01D6;
	Wed, 26 Jun 2024 10:44:33 +0000 (UTC)
Date: Wed, 26 Jun 2024 12:44:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: tony.luck@intel.com
Cc: Avadhut Naik <avadhut.naik@amd.com>, x86@kernel.org,
	linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rafael@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	rostedt@goodmis.org, lenb@kernel.org, mchehab@kernel.org,
	james.morse@arm.com, airlied@gmail.com, yazen.ghannam@amd.com,
	john.allen@amd.com, avadnaik@amd.com
Subject: Re: [PATCH v2 1/4] x86/mce: Add wrapper for struct mce to export
 vendor specific info
Message-ID: <20240626104427.GNZnvxC1JHclKwwKQU@fat_crate.local>
References: <20240625195624.2565741-1-avadhut.naik@amd.com>
 <20240625195624.2565741-2-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240625195624.2565741-2-avadhut.naik@amd.com>

On Tue, Jun 25, 2024 at 02:56:21PM -0500, Avadhut Naik wrote:
> Currently, exporting new additional machine check error information
> involves adding new fields for the same at the end of the struct mce.
> This additional information can then be consumed through mcelog or
> tracepoint.
> 
> However, as new MSRs are being added (and will be added in the future)
> by CPU vendors on their newer CPUs with additional machine check error
> information to be exported, the size of struct mce will balloon on some
> CPUs, unnecessarily, since those fields are vendor-specific. Moreover,
> different CPU vendors may export the additional information in varying
> sizes.
> 
> The problem particularly intensifies since struct mce is exposed to
> userspace as part of UAPI. It's bloating through vendor-specific data
> should be avoided to limit the information being sent out to userspace.
> 
> Add a new structure mce_hw_err to wrap the existing struct mce. The same
> will prevent its ballooning since vendor-specifc data, if any, can now be
> exported through a union within the wrapper structure and through
> __dynamic_array in mce_record tracepoint.
> 
> Furthermore, new internal kernel fields can be added to the wrapper
> struct without impacting the user space API.
> 
> Note: Some Checkpatch checks have been ignored to maintain coding style.
> 
> [Yazen: Add last commit message paragraph.]
> 
> Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  arch/x86/include/asm/mce.h              |   6 +-
>  arch/x86/kernel/cpu/mce/amd.c           |  29 ++--
>  arch/x86/kernel/cpu/mce/apei.c          |  54 +++----
>  arch/x86/kernel/cpu/mce/core.c          | 178 +++++++++++++-----------
>  arch/x86/kernel/cpu/mce/dev-mcelog.c    |   2 +-
>  arch/x86/kernel/cpu/mce/genpool.c       |  20 +--
>  arch/x86/kernel/cpu/mce/inject.c        |   4 +-
>  arch/x86/kernel/cpu/mce/internal.h      |   4 +-
>  drivers/acpi/acpi_extlog.c              |   2 +-
>  drivers/acpi/nfit/mce.c                 |   2 +-
>  drivers/edac/i7core_edac.c              |   2 +-
>  drivers/edac/igen6_edac.c               |   2 +-
>  drivers/edac/mce_amd.c                  |   2 +-
>  drivers/edac/pnd2_edac.c                |   2 +-
>  drivers/edac/sb_edac.c                  |   2 +-
>  drivers/edac/skx_common.c               |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   2 +-
>  drivers/ras/amd/fmpm.c                  |   2 +-
>  drivers/ras/cec.c                       |   2 +-
>  include/trace/events/mce.h              |  42 +++---
>  20 files changed, 199 insertions(+), 162 deletions(-)

Ok, did some minor massaging but otherwise looks ok now.

Tony, any comments? You ok with this, would that fit any Intel-specific vendor
fields too or do you need some additional Intel-specific changes?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

