Return-Path: <linux-edac+bounces-5787-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NBMJJZNrWn/1AEAu9opvQ
	(envelope-from <linux-edac+bounces-5787-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Sun, 08 Mar 2026 11:21:10 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF2422F4F5
	for <lists+linux-edac@lfdr.de>; Sun, 08 Mar 2026 11:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C449D300E5E8
	for <lists+linux-edac@lfdr.de>; Sun,  8 Mar 2026 10:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4316D30F812;
	Sun,  8 Mar 2026 10:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aym4UDup"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA9A946A;
	Sun,  8 Mar 2026 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772965265; cv=none; b=IItWqhz4JwMhcn6/6hjB1wWrAKcttfPLVsiXbndUfeUg1Xnj98FRmzXaEWYePC70awnnMojDv8dTugEXEPSfsi8jvMUi2ArZL9O4J3xZ55H5Md33ghGyLT5gQv0qIn6wJ+KVmxBZPBHWnmA4cy1dCvb2FoyJukVbmp1hqeItJjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772965265; c=relaxed/simple;
	bh=XzMkjnSYlEqItXvwclfx4RIV2UlWWlDV0VHyjYBzQ9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbtHm/+KD4t4XemAv0LiK4lOTWfHui7pO0JW8CkemIsCeywNUt38+Zm/3knMHTTJDxiJR6CQRnuppeeFZw6yVuDjSPKJeXpw0e3pZ/y2C1/4NXWvN/fR1gkkRVVBadt7WFzZXxCfxTsG47lj1svn6juD2IsPnRi1yEmItjCvuUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aym4UDup; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1AB5340E0163;
	Sun,  8 Mar 2026 10:21:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gqtYlXcGOaYL; Sun,  8 Mar 2026 10:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1772965257; bh=3L0qCp0Xye9aSiMNYAYOJpPKxq6poVcq2tx6ogNZDt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aym4UDup/FZ0oFgEmX8oVlek9xcMgm3Kui8jWNxanbrRV9NmjcXHSykdm0QiEPRu+
	 Edr0jydrfNlSiBK7aPhpBaEwUwXYJ6qWXekVqzmjwFnf6Gjxc1hM20VU7ONQh/Nbhv
	 vPD3kI5QPVBERU9HIDgH4vVBdx93CZJb/fZXLXrf6GxAr3WW/NgoloszSwVUBUghcA
	 5R5JndOGqIjWlEqLNdBTL0Kb/E5dVkoigAxQLoljKJNjEeS8Legtn7mwdiRbSg/q83
	 LqXMv4WjJPTEahstMdC2BoDXgNvqf8sFGbkowvos+0B7mcpccPcTIKoiueyzG3UaxC
	 4EmaNCyFl57FZXdsL+551UB+yyf6IN4IFI3pFLj0CdeQVkOP8mDpq7Tt4+7NpA5AQJ
	 XEUE8lM32O+5jaRLR8CgPyP5PU/3EIamPDowzBW6CfEAO/68Gnky/u2x1mMT27Ag4e
	 QyRLx9MeyoIfXKfUpXJjkePfff3/jrZDKwo2knv1EW0eKtQwJePgl4vJoM67GQf+J9
	 hqFy6us73VNi2ITudyx5O/zjWaAU1hPtxM/3bdYLSsT7gKYa8ZD8Ixp7f/QhOp8dhc
	 6I3vzJImah6vCNS84ZjWro78rwfPc7OCdYy/AojduFssYpayD2k2zZEblivvRBxqXF
	 SPXNS7I8022GoC6+Jf9mWFTE=
Received: from zn.tnic (pd9530d5e.dip0.t-ipconnect.de [217.83.13.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id A93B440E00DE;
	Sun,  8 Mar 2026 10:20:52 +0000 (UTC)
Date: Sun, 8 Mar 2026 11:20:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH v2 1/3] x86/mce, EDAC/mce_amd: Reorder SMCA bank type
 enums
Message-ID: <20260308102046.GNaa1NfuoXza1-cB8z@fat_crate.local>
References: <20260307163316.345923-1-yazen.ghannam@amd.com>
 <20260307163316.345923-2-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260307163316.345923-2-yazen.ghannam@amd.com>
X-Rspamd-Queue-Id: EDF2422F4F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5787-lists,linux-edac=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,alien8.de:dkim]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 11:33:14AM -0500, Yazen Ghannam wrote:
> +/* Order by HWID then McaType with newline between HWID groups. */

So I would argue that keeping them *all* sorted the same makes reading and
touching that code the simplest. Because you will have to modify the same
spots when you add new ones and the hwid number doesn't really matter for
humans.

IOW, this:

/*
 * Format:
 * { bank_type, hwid_mcatype }
 *
 * alphanumerically sorted by bank type.
 */
static const struct smca_hwid smca_hwid_mcatypes[] = {
        { SMCA_CS,       HWID_MCATYPE(0x2E, 0x0)        },
        { SMCA_CS_V2,    HWID_MCATYPE(0x2E, 0x2)        },
        { SMCA_DE,       HWID_MCATYPE(0xB0, 0x3)        },
        { SMCA_EX,       HWID_MCATYPE(0xB0, 0x5)        },
        { SMCA_FP,       HWID_MCATYPE(0xB0, 0x6)        },
        { SMCA_GMI_PCS,  HWID_MCATYPE(0x241, 0x0)       },
        { SMCA_GMI_PHY,  HWID_MCATYPE(0x269, 0x0)       },
        { SMCA_IF,       HWID_MCATYPE(0xB0, 0x1)        },
        { SMCA_L2_CACHE, HWID_MCATYPE(0xB0, 0x2)        },
        { SMCA_L3_CACHE, HWID_MCATYPE(0xB0, 0x7)        },
        { SMCA_LS,       HWID_MCATYPE(0xB0, 0x0)        },
        { SMCA_LS_V2,    HWID_MCATYPE(0xB0, 0x10)       },
        { SMCA_MA_LLC,   HWID_MCATYPE(0x2E, 0x4)        },
        { SMCA_MP5,      HWID_MCATYPE(0x01, 0x2)        },
        { SMCA_MPDMA,    HWID_MCATYPE(0x01, 0x3)        },
        { SMCA_NBIF,     HWID_MCATYPE(0x6C, 0x0)        },
        { SMCA_NBIO,     HWID_MCATYPE(0x18, 0x0)        },
        { SMCA_PB,       HWID_MCATYPE(0x05, 0x0)        },
        { SMCA_PCIE,     HWID_MCATYPE(0x46, 0x0)        },
        { SMCA_PCIE_V2,  HWID_MCATYPE(0x46, 0x1)        },
        { SMCA_PIE,      HWID_MCATYPE(0x2E, 0x1)        },
        { SMCA_PSP,      HWID_MCATYPE(0xFF, 0x0)        },
        { SMCA_PSP_V2,   HWID_MCATYPE(0xFF, 0x1)        },
        { SMCA_RESERVED, HWID_MCATYPE(0x00, 0x0)        },
        { SMCA_SATA,     HWID_MCATYPE(0xA8, 0x0)        },
        { SMCA_SHUB,     HWID_MCATYPE(0x80, 0x0)        },
        { SMCA_SMU,      HWID_MCATYPE(0x01, 0x0)        },
        { SMCA_SMU_V2,   HWID_MCATYPE(0x01, 0x1)        },
        { SMCA_UMC,      HWID_MCATYPE(0x96, 0x0)        },
        { SMCA_UMC_V2,   HWID_MCATYPE(0x96, 0x1)        },
        { SMCA_USB,      HWID_MCATYPE(0xAA, 0x0)        },
        { SMCA_USR_CP,   HWID_MCATYPE(0x180, 0x0)       },
        { SMCA_USR_DP,   HWID_MCATYPE(0x170, 0x0)       },
        { SMCA_WAFL_PHY, HWID_MCATYPE(0x267, 0x0)       },
        { SMCA_XGMI_PCS, HWID_MCATYPE(0x50, 0x0)        },
        { SMCA_XGMI_PHY, HWID_MCATYPE(0x259, 0x0)       },
};

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

