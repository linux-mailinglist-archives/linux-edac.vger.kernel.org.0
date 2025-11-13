Return-Path: <linux-edac+bounces-5437-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D90CC590A9
	for <lists+linux-edac@lfdr.de>; Thu, 13 Nov 2025 18:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68CEA3A2EE1
	for <lists+linux-edac@lfdr.de>; Thu, 13 Nov 2025 17:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B21295D90;
	Thu, 13 Nov 2025 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fGKZTJAo"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BCABE49;
	Thu, 13 Nov 2025 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052799; cv=none; b=iuw3uIHATy05HYZNyvJf3SQrTzOqXSWP07yCiMXLRXlg4Hvek7HzCGp6sAuZt6Fu1XF4pUCPgi8prW7MCFq0j1yZS1+nYvp5nzuaKXXbz8mcwUwCBjUodaqWz56TkuaIgG9Yik5GZQWs0v6cfFC7fw3aKTg95MhNiergoZcGRDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052799; c=relaxed/simple;
	bh=Kf0T0hTri+FalX0Z6pU+ijiWz7DGvSzyvsgqOrtjJJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1vKLn0LOiubEM3TrgyQ/Gi8EzYsrmlrNCF2/2jRgERBBpzd14cx/b/dHugySvYeHEfrcSK7Nem3pmDPp87IDkp+EeRWE84F3E/hhDLL2tmKO1wMjDlf0xoOdl2UQupf92fZtJnIrylkCQu6JCEY8GghKLS7sdrYkr3pPvm7PQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fGKZTJAo; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 798E440E00DA;
	Thu, 13 Nov 2025 16:53:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cNX6_bmfjiAJ; Thu, 13 Nov 2025 16:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763052789; bh=Ks3GkBzBFEnci7AxmqknAKbD5Omaz3sbaeM0Fyp50p4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fGKZTJAoajHL1EoqGxKqi9Qc4pV9L8I2yDTssovKrL6OV54giu0i8z4GP429Eri3q
	 GKD60F6glf6xlzZT5fSdLiCdhf+S73MWsm60Aiuh02zwo+kwkPzzyBPcaOX70duC0Y
	 Mx/3QM8pO+pjpOwHtuLnAvwg913fv+lIJxRKJ2Msp8KFzpLDQ2U70NM2XCbqZPOxgJ
	 1VDI2mvh/g1yK0bhUuU4rVfYU78M2xdZuqTRaPXpfGXtPJUhd1ibVz9C4pkF5N+6bZ
	 LcbdZWTsQvAenAJbfVCENfhRCgFvohu8G+VP7z6wKsdiaQYUoiPWAIqzPJxXDBjAzQ
	 SdQRqfxi/hHGk5RCbE+cdpwWfJAwMFM4gbbDjhc6qbh4jvAGUuR0rIlZLpqc95VEta
	 1003c9QZTODT/GG+LeeXVzpE4PHqRy5WZtSGs0I/ssWZHHnY8AqeMnQF7TxKwBd+Vz
	 65VP0N60k7QHMwa4Zrzi++1CxwSpof7qABUnG0f5uHnXTHPJw4GDqqzXGTU5ao+3MY
	 3blEhMQS+J/13ae2RkC5PGxOR2V9S3gX1KIKmktssj+vmUBe1qf8mVfgWq7gAC4Vzb
	 4HAg/RxJazxlSRf/CFq9mNWFq/GOatBRXurtSuZ5vVyxGrOQOkZ5k7YP6atRK0qpAo
	 UYdALhjOjsKshNGXlvoUvat0=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id EC20E40E022E;
	Thu, 13 Nov 2025 16:53:02 +0000 (UTC)
Date: Thu, 13 Nov 2025 17:52:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: x86@kernel.org, linux-edac@vger.kernel.org, tony.luck@intel.com,
	yazen.ghannam@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/mce: Add support for PHYSADDRV and
 PHYSADDRVALIDSUPPORTED bits
Message-ID: <20251113165256.GEaRYM6KyP299yO2Pi@fat_crate.local>
References: <20251015172452.3649720-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251015172452.3649720-1-avadhut.naik@amd.com>

On Wed, Oct 15, 2025 at 05:22:25PM +0000, Avadhut Naik wrote:
> @@ -777,6 +781,11 @@ bool amd_mce_usable_address(struct mce *m)
>  			return false;
>  	}
>  
> +	rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(m->bank), smca_config);

We have struct smca_bank and per-CPU smca_banks array.

MCI_CONFIG_PADDRV looks like a property of the bank which is static and
doesn't change willy-nilly. So instead of doing the silly MSR read on every
error, you can cache the fact that the bank supports MCI_STATUS_PADDRV and
query that and save us 100+ unnecessary cycles every time...

No?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

