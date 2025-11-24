Return-Path: <linux-edac+bounces-5521-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8BFC809B8
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 13:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 178154E631E
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 12:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAB2274B26;
	Mon, 24 Nov 2025 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="N7FZ0FBx"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66722FD69F;
	Mon, 24 Nov 2025 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763988792; cv=none; b=kJk3R9lYBk2tW3dv525lc0/eYHeNoK66CYhQZZz7ZgIInwgcIodjSl56QB7nX4bDhQFFjS+y4qqwOTyj+NBMJLdH4/wGXw33jBSXfpJBTHGIbjz0rijUykJ0MS+WtNOPIx3U7YIr4D2PgxXI+BndXUP4SU/E9iQnbbHNUrCWnb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763988792; c=relaxed/simple;
	bh=h1VmacC9qVP7N8zLMEXcvrKqGTiMT+kEEuIi4IZOiPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKD2Irf+ZmDJ3T6Fa7DDTQaC88cl2FCaEE5vgAFShMXkTgSFXQsHnfj1sRjDVkKIr1derPbNAKc0UHkOrg0AWKOg3AGFVLdLXh6Ez58i9jtjW4E3ViiC4A+aku3ch0Ub7BPG5AhviQsJy//O4vUGp/pFJkjozihV3MKtkn6bTk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=N7FZ0FBx; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8736640E016C;
	Mon, 24 Nov 2025 12:53:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EglKuKeBXaoW; Mon, 24 Nov 2025 12:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763988781; bh=pJnJRo3sJSGyejWVgb592nRKLqVXNsGz9QLRIa2CORA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N7FZ0FBxV1xvvbONoeMICCT2M/xne/XXa5CdHu/mmjd1iqOZGLV13eae44LFsLyW8
	 9AlZ+CY7usqbjpMcXI9PEfn7aawVtu7rjR3VrNgO9lWh/iSddnD3s2DEV0lDzdZBcX
	 3PLW4Zkf+EAVdkJuqdOcN8h/CLtms/jeBEdgYQIZ/Jhur8HZ5TAgLOBeEysHS7/Yrg
	 h6Kmi/vu73VLzlnHP09vsR8zBFv4DXGbqjLgq6saE0ZQVCpuDlgzBPcb/31BYUsv+k
	 /SOt8/DLPqkPaJKh0x1UblDPc6z3dPZGStOVhK04lrveXDUG0YrtOPGK+NlVzcZSCn
	 ssOBaB9nfc+vKf97NASU0Z75WFIrjFTfgiFLnesQMvyqG2gndpYMx55l0SRVfl6IMc
	 yWpw6GbLvpQ5GpTT7XrCb9u8jCSiW52I7vozKvrrgN51aVD7Vryjq3yT94RBas4UDV
	 HHJRFdicx2dIUO7N28czBvSY2EM/zaw2b5Ixh6vJyJ/sNdjUlqOp7FKNAyYnHPrm2e
	 E76N+oI6DXJHw0S3n8RScV9agl9L/H3nk+0OXOxdfuNobkUulMnETRDTZAD7OLPJxP
	 s/yoZmouJsg7p7REBqow16T/gej0BDEpYSRdO54N0V66xlsU37uuYzvfYYj2cVO6Pi
	 JsExs8K2eAYLnviejPO/+0Y4=
Received: from zn.tnic (p57969402.dip0.t-ipconnect.de [87.150.148.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id DC3F240E0258;
	Mon, 24 Nov 2025 12:52:55 +0000 (UTC)
Date: Mon, 24 Nov 2025 13:52:49 +0100
From: Borislav Petkov <bp@alien8.de>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yazen.Ghannam@amd.com
Subject: Re: [PATCH v2] RAS/AMD/ATL: Remove bitwise_xor_bits
Message-ID: <20251124125249.GDaSRVIapy2dmis28p@fat_crate.local>
References: <20251124084011.1575166-1-nik.borisov@suse.com>
 <aSQeD-RSZxeuPj_h@google.com>
 <20251124110526.GAaSQ79mo0yx1h1Xxm@fat_crate.local>
 <aSRJdskInHGmbjIo@google.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aSRJdskInHGmbjIo@google.com>

On Mon, Nov 24, 2025 at 08:03:02PM +0800, Kuan-Wei Chiu wrote:
> On Mon, Nov 24, 2025 at 12:05:26PM +0100, Borislav Petkov wrote:
> > On Mon, Nov 24, 2025 at 04:57:51PM +0800, Kuan-Wei Chiu wrote:
> > > > Both LLVM/GCC support a __builtin_parity function which is functionally
> > > > equivalent to the custom bitwise_xor_bits() one. Let's simplify the code by
> > > > relying on the built-in. No functional changes.
> > > 
> > > IIRC in some cases,
> > 
> > Which are those cases?
> > 
> > Do you have a trigger scenario?
> > 
> I did a quick search, and I believe it was this kernel test robot
> report [1] that reminded me of this compiler behavior.
> 
> [1]: https://lore.kernel.org/oe-kbuild-all/202501312159.l6jNRaYy-lkp@intel.com/

Interesting, thanks for the pointer.

@Nik, just use hweight16() but pls do check what asm the compiler generates
before and after so that at least there's some palpable improvement or gcc is
smart enough to replace the unrolled XORing with something slick.

Also put in the commit message why we're not using the builtin parity thing
and quote the link above.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

