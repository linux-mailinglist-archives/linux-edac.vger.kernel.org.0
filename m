Return-Path: <linux-edac+bounces-5757-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCGQHSoEo2kJ8wQAu9opvQ
	(envelope-from <linux-edac+bounces-5757-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Sat, 28 Feb 2026 16:05:14 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E90F01C3CB9
	for <lists+linux-edac@lfdr.de>; Sat, 28 Feb 2026 16:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EBDF30254E8
	for <lists+linux-edac@lfdr.de>; Sat, 28 Feb 2026 15:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3EE44D008;
	Sat, 28 Feb 2026 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JhQJF4lO"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7E244CF50;
	Sat, 28 Feb 2026 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772291104; cv=none; b=DGf/guukWXkmAma4wg8QCIXvrpL3tvXmlhaYSS04GbLFCEO29frzuQcAylVVpcDjt6gnIR3apgdznCu4Bb5yGU8DMnSZHX1CI59P7gwhMgIQxRGBGI0M2ucV5uRt3q+Gz2Q0KMf0fbG+/3oqKWOPElQAWt99T9u/+KJ9PHvNDWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772291104; c=relaxed/simple;
	bh=W8rUpDmqDEcnY9QmbSbRQ3QPOzfT3B0mS7eKDbgugA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsrRA3AhydtizSrNN1wZiZqNUQJFQgDoiD5Ru07u8CMF+0MVF7jzHmMv47vmmv9fCnrNaZpntIvuKq3mr3tVfD9X1qHoAU1dp/HMSFj1LGkVURKCHCVA4Ot3e0kD+sZ3MMBLLYiDvjGlXAPn16J3kjcINL5GM/bKgJI5Ve/H5ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JhQJF4lO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4670140E0140;
	Sat, 28 Feb 2026 15:05:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id l9meYIPiMT0d; Sat, 28 Feb 2026 15:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1772291093; bh=eKKHBml3yMG3ljc/r1yNEGuvGjVwPKOqj6vEstRURq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JhQJF4lOTPwlxQgQ6YeodhFnR1iak9+mlHlRHeQffZEFEZciQCSd6tIzMS8ODE9+J
	 wmLC9H/gHCmg2Py1U3WNozRQe9ExZ1Zn4mSN2cWziJryz14dES8435fd2EKk9QBMkW
	 gWHmbgu3x/ZQU7hy/jCc6IWIzagabjldP3FByGb3HzEZWSDmhhs2HOKzdkh/1ZdERn
	 q/ZUbAIDQsRZMY1f0OaVNWsd8DXtyjrcl1xvJ76uo2BFV4rE9Qn20H7l6X0uxFgzgZ
	 u9y25xRb3CWe30r9/3dS1ZiGllNjzvWs7oJtxDu0L8F1EH+eLe7KvP/1sKpe9ylc4n
	 JHs3cqVBIHPDsvFHt/BZLZ1TxEgzgtVyh2Lrb53RWWvnxqrMSrbgYIWprIOksVERUN
	 LeG43/07cYFrXgkNH/MEnxlELKzQTTB219Tk5lKzSj38Ue2NU+Wd0F6HNnR73SqkWY
	 kVhPrRUUdUSW/Vg7tf20O9rcXoTr/iQcxmN3mXdx0MKSDWqAgeOdBiqfA03kAssTh1
	 AUnc6TP/LjfwU9S3nczUkbjX4w6u16tYs1mLfSRgLGoRLNaetDIdAcVCZkFqNs0gns
	 rq8EScbwd8dUalh/CQMLnzw6tlSeWk0GRt/Gl7bVTeKzUA0Pg4QQ1m8tvWdwXS/kBW
	 ULz6h/2V2yBJ3YdhUOARG4Ws=
Received: from zn.tnic (pd9530d5e.dip0.t-ipconnect.de [217.83.13.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 0B6E640E00DA;
	Sat, 28 Feb 2026 15:04:47 +0000 (UTC)
Date: Sat, 28 Feb 2026 16:04:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH] x86/mce/amd, EDAC/mce_amd: Add new SMCA bank types
Message-ID: <20260228150447.GCaaMED_7sbC3OvDsL@fat_crate.local>
References: <20260202172158.2455749-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260202172158.2455749-1-yazen.ghannam@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5757-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-edac];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fat_crate.local:mid,alien8.de:dkim,amd.com:email]
X-Rspamd-Queue-Id: E90F01C3CB9
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 05:21:58PM +0000, Yazen Ghannam wrote:
> Recognize new SMCA bank types and include their short names for sysfs
> and long names for decoding.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  arch/x86/include/asm/mce.h    | 11 +++++++++++
>  arch/x86/kernel/cpu/mce/amd.c | 21 +++++++++++++++++++++
>  drivers/edac/mce_amd.c        | 10 ++++++++++
>  3 files changed, 42 insertions(+)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index 2d98886de09a..6e1f10ca053f 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -370,13 +370,24 @@ enum smca_bank_types {
>  	SMCA_NBIO,	/* Northbridge IO Unit */
>  	SMCA_PCIE,	/* PCI Express Unit */
>  	SMCA_PCIE_V2,
> +	SMCA_MPRAS,	/* MP for RAS */
>  	SMCA_XGMI_PCS,	/* xGMI PCS Unit */
> +	SMCA_SSBDCI,	/* Die to Die Interconnect */
>  	SMCA_NBIF,	/* NBIF Unit */
>  	SMCA_SHUB,	/* System HUB Unit */
>  	SMCA_SATA,	/* SATA Unit */
>  	SMCA_USB,	/* USB Unit */
> +	SMCA_MPDACC,	/* MP for Data Acceleration */
> +	SMCA_MPM,	/* Microprocessor Manageability Core */
> +	SMCA_MPASP,	/* AMD Secure Processor */
> +	SMCA_MPASP_V2,
> +	SMCA_MPART,	/* AMD Root of Trust Microprocessor */
> +	SMCA_DACC_FE,	/* Data Acceleration Front-end */
> +	SMCA_DACC_BE,	/* Data Acceleration Back-end */
>  	SMCA_USR_DP,	/* Ultra Short Reach Data Plane Controller */
>  	SMCA_USR_CP,	/* Ultra Short Reach Control Plane Controller */
> +	SMCA_EDDR5CMN,	/* eDDR5 CMN */
> +	SMCA_PCIE_PL,	/* PCIe Link */
>  	SMCA_GMI_PCS,	/* GMI PCS Unit */
>  	SMCA_XGMI_PHY,	/* xGMI PHY Unit */
>  	SMCA_WAFL_PHY,	/* WAFL PHY Unit */

That ordering looks rather random. Does it matter which enum number a bank
type is? If not, let's sort them alphabetically for easier reading...

In the remaining places too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

