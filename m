Return-Path: <linux-edac+bounces-5060-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F207FBE4743
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 18:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B16D0563D36
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 16:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073A532D0FB;
	Thu, 16 Oct 2025 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cIIwnNwJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268C032D0EB;
	Thu, 16 Oct 2025 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630535; cv=none; b=M7QFgZYzGjIWJaVCk/2syNxQU4L3lpU1fpoGFu49aLloqoGEwj3yJj5j2XN8PMIQcqU5Yc7tvPA1GfTZUa22wh4qbjkhmWaG7uUyFbQ4+zey6DQ9ILxbr3TW1UVatyJfPmgjEDvtRdSLtm/GOE/tBf+vqL2Yxg/Zs13vO9K+3Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630535; c=relaxed/simple;
	bh=YJpS08ZTigV7spJm90bYs1ALL5Lissji4wkxjBdhsXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHKgNWz2KQl1TC4YbXjWstNWdwjzU4NMbbmD7tsvHkgUTm2GH55P8IWoW04HpbnRqpBKOnpVRC5yGBDDRjlmZq4UA58AyUxHuFwlQilmgY0MiojmDFkaaZrCSSgI1QbsX6411Og0M/2eV2cAd4e4b/yF13O8WZPsIKS3p1235Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cIIwnNwJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3613A40E019F;
	Thu, 16 Oct 2025 16:02:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IIELQ42yW8jM; Thu, 16 Oct 2025 16:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760630526; bh=CQWXXSgBcCJIv5ldG1as4NyILExyce6PmwDXqrzOCPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cIIwnNwJTuya8PTRtTbduh4pGmiomMWfVBlyTKojfn98oscsPZEbZpD1esf2y2wEG
	 K4+xxdLbddaH2n6a30ENRA0mVpnJ2HAFEc/k/hBvlWWcZGupqcz5SuYa3C/YkNevRU
	 z6RirWpND7qPn+dC8zHRaD6sYWCSon7yvV1eqS+eVR1DxLSZVrB4E843AzE7b2X++V
	 Sg8WBx3IRjJTkn4pQRBrJZ0vlfWxnPVDvSa26Z4a8h+bgrGeQW9gXUpilx3JlQeDQj
	 07M4Bfjp6y9+bfrfEwKXnoBOBCsXpg4veODsbaYXNaDyd3xrkGqPlDTMVftX0yeiBZ
	 nyCruiqTVFgomTWFu1Bb+sHYX5AqMLOfEmMjrHQbCSikWxKY1RIaawqthC1SexL0VS
	 I9SiueDmp5YpnvthtDJHiizTk4gqn6VVlTp2ivXLwSIj0N1QrDfRBYMAqaRuNO7dh4
	 gq6pdYIZxaaL8o3QyJT7ejcY49Am9tOTLWuxeWtWnLDdFS8W1dWDoIw8v7rz00slTJ
	 gIIPd8WZlf9Ck6UXxYZXeaEZAiqpc6mB+ziqS5bUXW2neyiq4tH5fU4omGjmdPTkxP
	 urVXmr5s+Qdi5WdpxUCLkBUDJiSq4CDwdMetKj3yaPEkxvhEfIYwpvfaClYm3kUPGG
	 Qe0aEu2I3rN/31jAIJNjvxDY=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 58E5640E015B;
	Thu, 16 Oct 2025 16:01:56 +0000 (UTC)
Date: Thu, 16 Oct 2025 18:01:49 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Avadhut Naik <avadhut.naik@amd.com>,
	John Allen <john.allen@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 1/3] ACPI: PRM: Add acpi_prm_handler_available()
Message-ID: <20251016160149.GBaPEW7ej4qvOcVfYh@fat_crate.local>
References: <20251006-wip-atl-prm-v1-0-4a62967fb2b0@amd.com>
 <20251006-wip-atl-prm-v1-1-4a62967fb2b0@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251006-wip-atl-prm-v1-1-4a62967fb2b0@amd.com>

On Mon, Oct 06, 2025 at 03:10:25PM +0000, Yazen Ghannam wrote:
> Add a helper function to check if a PRM handler/module is present.
> 
> This can be used during init time by code that depends on a particular
> handler. If the handler is not present, then the code does not need to
> be loaded.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/acpi/prmt.c  | 6 ++++++
>  include/linux/prmt.h | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index 6792d4385eee..7b8b5d2015ec 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -244,6 +244,12 @@ static struct prm_handler_info *find_prm_handler(const guid_t *guid)
>  	return (struct prm_handler_info *) find_guid_info(guid, GET_HANDLER);
>  }
>  
> +bool acpi_prm_handler_available(const guid_t *guid)
> +{
> +	return find_prm_handler(guid) && find_prm_module(guid);
> +}
> +EXPORT_SYMBOL_GPL(acpi_prm_handler_available);
> +
>  /* In-coming PRM commands */
>  
>  #define PRM_CMD_RUN_SERVICE		0
> diff --git a/include/linux/prmt.h b/include/linux/prmt.h
> index c53ab287e932..8cdc987de963 100644
> --- a/include/linux/prmt.h
> +++ b/include/linux/prmt.h
> @@ -4,9 +4,11 @@
>  
>  #ifdef CONFIG_ACPI_PRMT
>  void init_prmt(void);
> +bool acpi_prm_handler_available(const guid_t *handler_guid);
>  int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer);
>  #else
>  static inline void init_prmt(void) { }
> +static inline bool acpi_prm_handler_available(const guid_t *handler_guid) { return false; }
>  static inline int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer)
>  {
>  	return -EOPNOTSUPP;
> 
> -- 

Rafael?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

