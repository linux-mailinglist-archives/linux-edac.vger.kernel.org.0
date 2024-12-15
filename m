Return-Path: <linux-edac+bounces-2715-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CB69F253C
	for <lists+linux-edac@lfdr.de>; Sun, 15 Dec 2024 19:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F00F1880A28
	for <lists+linux-edac@lfdr.de>; Sun, 15 Dec 2024 18:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01D91B393B;
	Sun, 15 Dec 2024 18:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YrojWXAj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A111C1487F6;
	Sun, 15 Dec 2024 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734286587; cv=none; b=jUolyh7vSEKdk5S6pXx2DYoYM6KAvRtZFqvWkSZ8MVlxWpkKEWBB304Ln0L2dwjVp/Y+zbTnyeGpiFxLTrdE0y4LBHwcfC6JYf2Wf7zMy1JB5SytOZ0Ws+MCP2hB1dYBZ3TxcoqtjUhrZ/OsQBAFPd5JLpq1fW5MTJ4RNhMSJDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734286587; c=relaxed/simple;
	bh=aqExUbAWLR1pqlx/QTeDwb7s80Gt5cJLqPeUP0gq070=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0R/aDxQ/9iDMnV6t5qZbWF2EL5Z4EjK2PP9ywVeuLx5kf0s6Q3JBw15qtdnS6uVxns4FyLd2giVL8mxaeQBVngmUDc0PDLx+idv2dY92qYHoJ43cBjJffh8AB4r/5dbuQKLnh16mR2R2oaetW93AUC7cqlAuRTuYemWXyWBIOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YrojWXAj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BF26C40E0169;
	Sun, 15 Dec 2024 18:16:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id h4y0rGSLfExq; Sun, 15 Dec 2024 18:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1734286570; bh=KAfJPZso7H1S8drdc8WnbHhjAmg9UTnKBBt6o5c81Zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YrojWXAje0VoVb1lEkx9UETWpYV/tp0SV+kvdvCnMC5MZd49yhbaD8/AAq92m8sFX
	 o5o8SPjFYNp5UrNIohTGDQCeyba1gxJDE7T6fpK/5r92kaEE2lXjBpUebE5Wo/8EZk
	 O5MJLR419BvabQUPOhTiP2Ep5wgtAvDhD+KuEmeLOazaXQHHA24FPi2sRePGXJURXA
	 f9iq+YEnFH46nSKticwU26MJYcLJm/zKGp6FAcfjvU+F+RnCHVkLwxZQSzW3Zhj6p+
	 HOgsYySepKQm86JtqU3p7604Pb57m7AlEf/AF5pJeIpQkOMt3zsX6+awoOFN3GUZi1
	 ynFgYbEpdKcjIzrqEbz9Ax9EO5GwR1zkQUkPh0GjoW60iP7jRr7r8qqS+ZHxPeStAW
	 kuL694TYhAccOpKJSQEIoSxCNMJgIFz9Fy9a8Ll+NPIIoFIqsn2+KD1m5UOegIiGyY
	 Y/D9QNw7KwZlra8OAhlj4C1HFRjUHsQIMZdae/4glUbcl5817Kx6m/igtl8oHd9udv
	 YzVpJYoSe8yQbZyVTL9Z1jBjtmIYuw/BvBcdULrCB7+b0058y5za/JVHMGTMjlbCj/
	 kpZ+GzwnCUolJPNLmTwugh5l8BKxjEcLrxkAI+hM9xJMYXyW4zPq2VNeaKmts2TM8x
	 LLRS40k2ABn3WWjODEuCqf8w=
Received: from zn.tnic (p200300ea971f9324329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9324:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CF1D940E0263;
	Sun, 15 Dec 2024 18:16:04 +0000 (UTC)
Date: Sun, 15 Dec 2024 19:15:57 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Karan Sanghavi <karansanghvi98@gmail.com>,
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3] RAS/AMD/ATL: Fix unintended sign extension issue from
 coverity
Message-ID: <20241215181557.GBZ18c3QJw8-7HWeSD@fat_crate.local>
References: <20241127-coverity1593397signextension-v3-1-60dd0c4287ff@gmail.com>
 <20241211160113.GB1923270@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211160113.GB1923270@yaz-khff2.amd.com>

On Wed, Dec 11, 2024 at 11:01:13AM -0500, Yazen Ghannam wrote:
> On Wed, Nov 27, 2024 at 06:23:48PM +0000, Karan Sanghavi wrote:
> > This error is reported by coverity scan stating as
> > 
> > CID 1593397: (#1 of 1): Unintended sign extension (SIGN_EXTENSION)
> > sign_extension: Suspicious implicit sign extension: pc
> > with type u16 (16 bits, unsigned) is promoted in
> > pc << bit_shifts.pc to type int (32 bits, signed),
> > then sign-extended to type unsigned long (64 bits, unsigned).
> > If pc << bit_shifts.pc is greater than 0x7FFFFFFF,
> > the upper bits of the result will all be 1.
> > 
> > Use u32 for bitwise operations to prevent unintentional
> > sign extension by assigning the u16 value to a u32
> > variable before performing the bitwise operation to
> > avoid unintended sign extension and maintain
> > consistency with the existing code style.
> > 
> > Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>

> Boris, can you please take this patch if no objections?

Lemme see:

bit_shifts.pc     = 5 + FIELD_GET(ADDR_SEL_2_CHAN, temp);

#define ADDR_SEL_2_CHAN         GENMASK(15, 12)

that register field is 4 bits, so 0xf is the highest value it can contain.

Thus, bit_shifts.pc can have 20 as its max value.

So all that coverity OMG OMG sign-extension overflow above cannot actually
really happen, can it?

Because pc is promoted to an int, as the text rightfully points out.

Or am I way off here?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

