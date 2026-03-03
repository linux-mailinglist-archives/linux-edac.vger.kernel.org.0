Return-Path: <linux-edac+bounces-5765-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NVONdoCp2k7bgAAu9opvQ
	(envelope-from <linux-edac+bounces-5765-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Tue, 03 Mar 2026 16:48:42 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB561F2E99
	for <lists+linux-edac@lfdr.de>; Tue, 03 Mar 2026 16:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C548730028D5
	for <lists+linux-edac@lfdr.de>; Tue,  3 Mar 2026 15:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DD53BFE47;
	Tue,  3 Mar 2026 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kIBrm/uX"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A583914E5;
	Tue,  3 Mar 2026 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772552323; cv=none; b=VdQe1uATE7VaNctniBPLFMkqyRY8Y9X9nIg6DFxwMnVacsbKktEflE+GVDD+eqWRHqTp75b9eixqfHegap39Gpo24M5O2XtD6Dx9zCTn7kPrX1uwACndrFwAnDyDBCpvqqSLCY2iB++pW1V0VRI3S8nje4xfyx+9wIAd1aXwxfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772552323; c=relaxed/simple;
	bh=GcxZSFGNLdF+0CRVXbCL5SZ/4G6nwkefoPwWcNtzClk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXwh+JdGtWW3GGbZ/MgDexYatA1//LBvXANVVcSG4DTWiw+aStYzCxEE+sgGOUU8EQW79kmSm0PmEjyhsPAp1drm0qt40RRp4X+L34VIJ5jBAv9C6gfbuCZY1EQWjG0QofcIszu2l9TKgZFdd2xeW+DAqoMPb201K+HwWWne5xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kIBrm/uX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 238FE40E019F;
	Tue,  3 Mar 2026 15:38:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UVfjET6vmk0Z; Tue,  3 Mar 2026 15:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1772552306; bh=3lxRGU+L1R2KKchGLdN0hjcm2xDK4ESzK7J41AMY67E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kIBrm/uXJjjpL3N3DtiJi1fLyugpDL1WdmonmvEFh7L+rBNbIbf1zyKvWAY6dnYxF
	 0sAZUrVm7wOXfjAikAxMkgHVbr7kG63/5Ebyxh9JDJp06L1jYRjW2xDDeunEQPhjO+
	 /Y13pw60iVT77hCsnShd1sskeo/1MJQqrrIhzfJ3movfxfbWx2+Unva9LRTB5P5bxJ
	 3jUi7SeP40+iLo/hqP5SGfza9KH1BuPgoWv/C0m+O56U4QFCypC4t7Ya4uvtplLh9r
	 HbCZpyZrifUN5FDAA7pFY8mg20EzT7ZGsjqwMqf59uWGI9V7JhxRsgOJLe3a3PYP9T
	 cjB2OZNxqShFmgJdgh93xk1fHg5Ra3rP2Pa7HF8LwGk2a4+NJaBHTYj3ffwEUAHanj
	 1wVwjOy61BOKk+geHOKWYiTEYzXs78h4IcE5JDLtJ4HBIdH9rhjUyGNEZipOnWqNxl
	 TxDO9qjY0MVMe4i5bnYHNCNvnpHK/zVAoCKpSNUnXMz7FQXPByOaOuY8oOf1Mas5Z6
	 Dychhx+E/rjSJEQbqn4TG5OO7LbDwtBeMpC3fbdPPWcFR6hwJtt1zQB+AmsT/iEZYX
	 5ulGELM+Msf7bkgRH7qOh8N+pQZapVPny+IHHAdR74hw5YcHFngPGdKrBQWJIScQ9R
	 nOZQIhTfj+QZmTuhhbMHtfPo=
Received: from zn.tnic (pd9530d5e.dip0.t-ipconnect.de [217.83.13.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id AE20040E019B;
	Tue,  3 Mar 2026 15:38:21 +0000 (UTC)
Date: Tue, 3 Mar 2026 16:38:14 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH] x86/mce/amd, EDAC/mce_amd: Add new SMCA bank types
Message-ID: <20260303153814.GAaacAZrUnFNBhPq1K@fat_crate.local>
References: <20260202172158.2455749-1-yazen.ghannam@amd.com>
 <20260228150447.GCaaMED_7sbC3OvDsL@fat_crate.local>
 <20260302142255.GA145106@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260302142255.GA145106@yaz-khff2.amd.com>
X-Rspamd-Queue-Id: DAB561F2E99
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5765-lists,linux-edac=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,fat_crate.local:mid]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 09:22:55AM -0500, Yazen Ghannam wrote:
> The ordering is based on the HWID_MCATYPE() tuple. The intent is to keep
> those in numerical order for easy reference with documentation.
> 
> See: smca_hwid_mcatypes[]

Ok, what is determining *this* particular order?

First LS, then LS_V2, then IF, then L2_CACHE, then EX... all those start with
0xb0.

Then CS, PIE, etc start with 0x2e...

I guess I don't see yet what the sorting criterion here is...

Thx.

static const struct smca_hwid smca_hwid_mcatypes[] = {



 { SMCA_RESERVED, (((0x00) << 16) | (0x0)) },


 { SMCA_LS, (((0xB0) << 16) | (0x0)) },
 { SMCA_LS_V2, (((0xB0) << 16) | (0x10)) },
 { SMCA_IF, (((0xB0) << 16) | (0x1)) },
 { SMCA_L2_CACHE, (((0xB0) << 16) | (0x2)) },
 { SMCA_DE, (((0xB0) << 16) | (0x3)) },

 { SMCA_EX, (((0xB0) << 16) | (0x5)) },
 { SMCA_FP, (((0xB0) << 16) | (0x6)) },
 { SMCA_L3_CACHE, (((0xB0) << 16) | (0x7)) },


 { SMCA_CS, (((0x2E) << 16) | (0x0)) },
 { SMCA_PIE, (((0x2E) << 16) | (0x1)) },
 { SMCA_CS_V2, (((0x2E) << 16) | (0x2)) },
 { SMCA_MA_LLC, (((0x2E) << 16) | (0x4)) },


 { SMCA_UMC, (((0x96) << 16) | (0x0)) },
 { SMCA_UMC_V2, (((0x96) << 16) | (0x1)) },


 { SMCA_PB, (((0x05) << 16) | (0x0)) },


 { SMCA_PSP, (((0xFF) << 16) | (0x0)) },
 { SMCA_PSP_V2, (((0xFF) << 16) | (0x1)) },


 { SMCA_SMU, (((0x01) << 16) | (0x0)) },
 { SMCA_SMU_V2, (((0x01) << 16) | (0x1)) },


 { SMCA_MP5, (((0x01) << 16) | (0x2)) },


 { SMCA_MPDMA, (((0x01) << 16) | (0x3)) },


 { SMCA_NBIO, (((0x18) << 16) | (0x0)) },


 { SMCA_PCIE, (((0x46) << 16) | (0x0)) },
 { SMCA_PCIE_V2, (((0x46) << 16) | (0x1)) },

 { SMCA_XGMI_PCS, (((0x50) << 16) | (0x0)) },
 { SMCA_NBIF, (((0x6C) << 16) | (0x0)) },
 { SMCA_SHUB, (((0x80) << 16) | (0x0)) },
 { SMCA_SATA, (((0xA8) << 16) | (0x0)) },
 { SMCA_USB, (((0xAA) << 16) | (0x0)) },
 { SMCA_USR_DP, (((0x170) << 16) | (0x0)) },
 { SMCA_USR_CP, (((0x180) << 16) | (0x0)) },
 { SMCA_GMI_PCS, (((0x241) << 16) | (0x0)) },
 { SMCA_XGMI_PHY, (((0x259) << 16) | (0x0)) },
 { SMCA_WAFL_PHY, (((0x267) << 16) | (0x0)) },
 { SMCA_GMI_PHY, (((0x269) << 16) | (0x0)) },
};

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

