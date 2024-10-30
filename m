Return-Path: <linux-edac+bounces-2357-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B999B6981
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 17:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726271F21637
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 16:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331D52144A4;
	Wed, 30 Oct 2024 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kNVqVLon"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA7E768FC;
	Wed, 30 Oct 2024 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306923; cv=none; b=hs00SsLnAU89tEor8YuemOR7Vsz53p+nPkBc3zpdutqGVOUrrCN/YkPWaSWar6/2JxOfQ+/tvog+zkU3YUK0WbXWJPGTuHGFNIBP1aHeODrcphUeJ/ZVQUTq2agHtVZ+i90FrXCzCW8CjREdbdSFNOl9TgQZn83aIMdN1arpQvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306923; c=relaxed/simple;
	bh=OBZmHBudip3zXUknqoGitvdU6AC7b/2cAig9kwB1/2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxRe2mEJWxLvVy+fSbn8P2GxjXlcTH6LEWyHzauoq093Gm/quGImu54To7Si5dpBqEjQSeTLoDVxFXmQytEDch1k7VRbhHBis2U889etQm583AuZEIMKX8YquGM+G1XzZWj87H7kuveCQwmh6DblbCUzH41XrfsXZHm+levXmKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kNVqVLon; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F185240E019C;
	Wed, 30 Oct 2024 16:48:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6T5WaCF-JBm2; Wed, 30 Oct 2024 16:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730306913; bh=07+wM8crly0l/u2I08N35CPwLLjTiQBMrnF6VyHmhqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kNVqVLonBjJTb36uJ6ncx4lv6w0VtUxnKwsuGnJDGoRuTGLF+Flg1hoAX06Wb4VnP
	 j46WzzEk1fB8Aq2nZYvajx08dKFgC/+r4FZ8jgV4+qs3KJ6/tiJEhAofV9ySkMR/GD
	 iZtCfhhlFBE0qLLndnikAMEkEth6+tv9b12zP/DJOE2xVSXTTTTjGL7u9i/eKcQCFH
	 DJFxXB2+G/5feXtRXe8TyhdvOiaht9sdI0UTKJpzTemj2OXMAJPLw4MWSlPqJL0dd2
	 KcH/6IR/ZyPEEGujfElISY7LPo7fvatyZMXvPG4L8fA855fnTM1FfQvri84ZpRgKYn
	 htCNtT4uEKz2fG1g1uAoWZREY06CdmVa1OIyGQlKwq+qiMNdyR5qHfzYNPKAGUmLOJ
	 95LzqdFAf+SadwhG2z2gfUcU5aVWUX5q4AdUqpdCi4kZmPuDrxZ3Si6VX5/adhSy9H
	 KTKzyqQB9USu86nXhaPnyOxT7ZteV/hsSzl54+N4HLbq1idLZ+okXyG48tYbMEpYi+
	 Mw/aeIoXYeRvfwlaDttU0n/YPfZ8HUkO+dV7Dr1p1E4AaKMAMKnxzGM715H14AjfLv
	 IXFUw8PtbCs/2ntoG8iTHz3pVn7V5Hv0mCDwpAp23QerL0r0gf9ucHVm9qHIvClI+e
	 ONi9xabQmAOpju4WlJdcJk80=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C2C9740E0208;
	Wed, 30 Oct 2024 16:48:18 +0000 (UTC)
Date: Wed, 30 Oct 2024 17:48:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: Avadhut Naik <avadhut.naik@amd.com>, x86@kernel.org,
	linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	qiuxu.zhuo@intel.com, tglx@linutronix.de, mingo@redhat.com,
	rostedt@goodmis.org, mchehab@kernel.org, yazen.ghannam@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH v7 1/5] x86/mce: Add wrapper for struct mce to export
 vendor specific info
Message-ID: <20241030164811.GEZyJjS9KJDgMYRdib@fat_crate.local>
References: <20241022194158.110073-1-avadhut.naik@amd.com>
 <20241022194158.110073-2-avadhut.naik@amd.com>
 <20241030133227.GDZyI1a5rheucn86qc@fat_crate.local>
 <685c039c-06a5-4876-a918-bd1c810397a9@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <685c039c-06a5-4876-a918-bd1c810397a9@amd.com>

On Wed, Oct 30, 2024 at 11:35:17AM -0500, Naik, Avadhut wrote:
> Will fix this.

You don't have to - I'll fix up while applying.

This was just for your future info.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

