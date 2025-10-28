Return-Path: <linux-edac+bounces-5237-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D89C156B1
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 16:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F083BE0E5
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 15:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF0233F8A9;
	Tue, 28 Oct 2025 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VtBk5SXF"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056EA33DED3;
	Tue, 28 Oct 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664979; cv=none; b=tzQXMVqAHxVYGekzTD8xsy5brBSerGc19aKDLTgMguthTpAi1FfHvmENaS8wJ4mf7/1UG0v/p5j7FXivDRuCNLtTQzuCw1RX/RmGsgzb3qnHwt6fJATk2RtztN2huYHSqt21FdpNrtHdywDR101PeTQ85aIR8o/prEOhyIQ1K14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664979; c=relaxed/simple;
	bh=8W+3pymnjwWg8hPK7EzAlCgJ25qwJHlcqKZbfxwBV6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRlSXJGaB1PCMyHVsZP9gbn3DU1LUkGPhJyXPr/UYIszWbjJHI0QoCeQInCM/xNVLlxCHsxfcegj0FYDr1aT44Djy8YzSPyc/k2AeOQec6HZoDmlEHgdpEDjwCqtooQzLwaBrgNw7FF23i4TOiWa1IPZ26ylOPf42Q+iNv2Zfgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VtBk5SXF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 52D1B40E01A5;
	Tue, 28 Oct 2025 15:22:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KsvK5jyG85n9; Tue, 28 Oct 2025 15:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761664970; bh=NijmTXjaMa7y3kt11i6btAtnQwKmrr9GKTkIJ0HNSJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VtBk5SXFtTKX9raer6fDTj+Sxi5z3ETj314R4X+cLVAFKcjU/Os4T6e20T+OXiOjZ
	 0JQp7nVc0qQb0VfXltgyCoBA1/GLeWp5QEkwTwYsCkpfPt6k0zdzyMkHmv9yxitFeA
	 o4KFeColx84aQwJCZTQ7bRrulewOkZGSeV4k6Ns00WuzaLPzm0kWYRI5s2+moD51pm
	 jEiPnvVJJtJq2BENGS9rLnwqZu6kCwT/jQZGteaUgesZO+NQVphwfGxZ7sXAmdp/4m
	 NMGtoGEbv6mo696IUvG15uQU2JNPozgwjuZZuZ4KK8YEqe2c4D3A2VdtPYoB+wDFUP
	 JPjpFXBwF1hw8tntHyOeJoNok/YZjcQ8jjJ+GLyguLdzzQq8lSXJ29lJTngDILKU3g
	 cIqjT1or8ddi5a8kcTFv1iMF29rObAJbXucMIHD4cTcr4hrU9EcjXFSqeG8AqgYbkh
	 IPXkeYdx1zFHsLd9RNu0tTIfkfqR6oyX8Jnavb80CAuLceWjzp/+LmlHC2i/4HpOgk
	 WDm1qBJN8dTKn0RWUxXv1zipIcXvH2DSozb8Fly3LVECbjcrO7PcS10k/7Lcy40P1I
	 t4gjGzUCcaKzC6rdMSYDd7/T/fOh6DfClDxrJ6GRrtpbUsJ/HzMUAhH/LDU1PqheBZ
	 d+fykHnNv67iDUCavZ7TMguQ=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 65C2540E0200;
	Tue, 28 Oct 2025 15:22:38 +0000 (UTC)
Date: Tue, 28 Oct 2025 16:22:31 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Bert Karwatzki <spasswolf@web.de>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 2/8] x86/mce: Unify AMD DFR handler with MCA Polling
Message-ID: <20251028152231.GAaQDft32eXtTZBBzg@fat_crate.local>
References: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
 <20251016-wip-mca-updates-v7-2-5c139a4062cb@amd.com>
 <20251024150333.GSaPuVRQYxH92zyrmO@fat_crate.local>
 <20251024203012.GA251815@yaz-khff2.amd.com>
 <20251024212723.GGaPvvO3l2OlUEG7Xn@fat_crate.local>
 <20251025150304.GXaPzmqFawI0NrCC-0@fat_crate.local>
 <20251027133542.GA8279@yaz-khff2.amd.com>
 <20251027141139.GA51741@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251027141139.GA51741@yaz-khff2.amd.com>

On Mon, Oct 27, 2025 at 10:11:39AM -0400, Yazen Ghannam wrote:
>  	/*
> -	 * If the MCA_STATUS register has a deferred error, then continue using it as
> -	 * the status register.
> -	 *
> -	 * MCA_DESTAT will be cleared at the end of the handler.
> +	 * If MCA_STATUS happens to have a deferred error, then MCA_DESTAT will
> +	 * be cleared at the end of the handler.
>  	 */
> -	if ((m->status & MCI_STATUS_VAL) && (m->status & MCI_STATUS_DEFERRED))
> +	if (m->status & MCI_STATUS_VAL)
>  		return true;

I'm still confused by those comments - we check VAL but we talk about
deferred...

>  
>  	/*
> -	 * If the MCA_DESTAT register has a deferred error, then use it instead.
> +	 * Use the MCA_DESTAT register if it has a deferred error.

This one...

> The redundant
> +	 * status bit check is to filter out any bogus errors.

... probably only confuses. No need to mention it.

>  	 *
>  	 * MCA_STATUS will not be cleared at the end of the handler.
>  	 */
> @@ -780,7 +777,7 @@ static bool should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
>  	struct mce *m = &err->m;
>  
>  	if (mce_flags.smca)
> -		return smca_should_log_poll_error(flags, err);
> +		return smca_should_log_poll_error(m);
>  
>  	/* If this entry is not valid, ignore it. */
>  	if (!(m->status & MCI_STATUS_VAL))

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

