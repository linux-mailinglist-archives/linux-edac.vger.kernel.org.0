Return-Path: <linux-edac+bounces-5225-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B115BC10F97
	for <lists+linux-edac@lfdr.de>; Mon, 27 Oct 2025 20:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 400125057DD
	for <lists+linux-edac@lfdr.de>; Mon, 27 Oct 2025 19:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8820432C92D;
	Mon, 27 Oct 2025 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PMQx/etA"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F21A17F4F6;
	Mon, 27 Oct 2025 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592850; cv=none; b=csQjYFbd5D+IwcLLQ9CJef2I+VVNjjURjG0T3A5gpYpJhVvVdCyqGRryxQjg40x7K1YTmARQsPmNsJJAs23RlFF+0ExhtPL17wW1pD+ZgVUEVtZGhCF8IjdAZGnh6ab0iaR67gp4uTEPNo5Q0Km4KNrmk+Vf3jK5/kNr/68n1R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592850; c=relaxed/simple;
	bh=Wa6ldUv/zgI4JDq1tbT5Y+zylHVbZFrpTUSzqV/aoa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFCoEn/BwUnXHcw5n1Ysx8QeNw4O6eAgvsEHFvRE64x6Ah0+F+0Ot5JH9ALAUsXdqIz4RJ0n2sNbAuKC7TLoRbLmfT6D38UOkXUnj9/CpGb/k6/3sWGgEdFW/jWgyupZSCpKnjNuyb9Dc9/2V4Ysph1rNRoYGsJ0GRxZY4SnF0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PMQx/etA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 42B5340E019D;
	Mon, 27 Oct 2025 19:20:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ggxpkL2yj3s6; Mon, 27 Oct 2025 19:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761592837; bh=1p4W+F+S0SLPkZVenYI4ZocIHZejOQOryBLd3i2s/hU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PMQx/etA73TOv2yFREJkLovtaztTvX/PMpHTTiyqJ9AcqP0fngLzrNoNOlF8oh/tZ
	 /pGcyYIvopZrVpK0JdbHOLea3u4z1lK5sequd1DQltPfueTatFl2PEZALoWDG25tHB
	 Y3TAS9yv9PQRNrIIEdnj3rsLYZmUZoxzjcX47TPZhQplzwFgVOl7Vs4tnnIpNMXiMq
	 YAkUow67hB+uLo+YB/2+/9IOxWskSF4SjlARats4zyvZJqUxqqvWzwfumxO2J26+QS
	 lRpsuDoBKTbUMjEhgyrrZxoKNBMCp1zxqHnwdRP1A3PMilKxFOnM0ngxPIVwWDLKry
	 gtIPrEHGpKZV1ZBNnFsEQ7kONYl2qjy0nnVqm51Gy1etpEv02h9qoFMNvXv9MtHMxn
	 hS+sMyE505DdoxCoQkw2Vj+e5d8K6nB/SW0aptL2zE6A/RFmiVHzc2KTeBQCelGV2E
	 1dy8BYY+JXq3DFoH3IJssknEQtsHgfr444+AxFTpT36KAu+R3QgRHq3qtbBB9JtoyV
	 4XWlzB5GCXlcEOk5v6B3uHBCmLPmo7v1YoXNlsgfMAgUXvOOWhF5NULiSgj97RNGgt
	 fxS+0U2XR4ZDzJLsZpwa7y9OYLvGNDqNX5LaLJWtnCE9TdMwsmUJ+yWCHlMPgeE/E5
	 fCY/lKHnThXybHSgOzrQnnio=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 72AD940E021A;
	Mon, 27 Oct 2025 19:20:26 +0000 (UTC)
Date: Mon, 27 Oct 2025 20:20:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Avadhut Naik <avadhut.naik@amd.com>,
	John Allen <john.allen@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: Re: [PATCH v2 2/2] RAS/AMD/ATL: Require PRM support for future
 systems
Message-ID: <20251027192019.GAaP_F8yifQ1TKlqtO@fat_crate.local>
References: <20251017-wip-atl-prm-v2-0-7ab1df4a5fbc@amd.com>
 <20251017-wip-atl-prm-v2-2-7ab1df4a5fbc@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251017-wip-atl-prm-v2-2-7ab1df4a5fbc@amd.com>

On Fri, Oct 17, 2025 at 01:26:29PM +0000, Yazen Ghannam wrote:
> +	/* All other systems should have PRM handlers. */
> +	if (!acpi_prm_handler_available(&norm_to_sys_guid)) {
> +		pr_debug("PRM not available\n");
> +		return -ENODEV;
> +	}
> +
> +	df_cfg.flags.prm_only = true;
> +	return 0;
>  }
>  
>  static int get_dram_hole_base(void)
> @@ -297,6 +305,9 @@ int get_df_system_info(void)
>  		return ret;
>  	}
>  
> +	if (df_cfg.flags.prm_only)
> +		return 0;
> +
>  	apply_node_id_shift();
>  
>  	get_num_maps();
> diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
> index 6e072b7667e9..18ce419236a5 100644
> --- a/drivers/ras/amd/atl/umc.c
> +++ b/drivers/ras/amd/atl/umc.c
> @@ -422,7 +422,7 @@ unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err)
>  		 socket_id, die_id, coh_st_inst_id, addr);
>  
>  	ret_addr = prm_umc_norm_to_sys_addr(socket_id, err->ipid, addr);
> -	if (!IS_ERR_VALUE(ret_addr))
> +	if (!IS_ERR_VALUE(ret_addr) || df_cfg.flags.prm_only)
>  		return ret_addr;
>

Much better, thanks!

Both applied.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

