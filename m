Return-Path: <linux-edac+bounces-1867-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE63978289
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2024 16:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8A81C2207E
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2024 14:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C9ABE49;
	Fri, 13 Sep 2024 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EQTUgvNV"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BA7BA38;
	Fri, 13 Sep 2024 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726237752; cv=none; b=MofnsEYfbVlNgppxV4Z2LoOOm+/Omr6ByH5SiDWOUGyQOYrPG5N1tM0acnW0a3y4Z+xgdcjg1qMO5scMwfoJBQEa/cDQ9xyU6MtBLvR0pfTqVggssmdL+CLAaua9KFL9jiFfFsWeFCjZqMREQia35+YfqLEXY8Pk4aWpjNGjChc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726237752; c=relaxed/simple;
	bh=rxgx9nQOR0DD8m36VbgMe0sKAa1RlY0jEoFwGQUvUTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcN6mGas/7U62IkMINDsZf7CQZOWa0WJsxo/TFgYFmH/DSL7aXcnQdcGDe2GdquxENNqs9RvYxLDIgmjvZhTOhfy1FZ8dVAoiXc9M++S1OqZE5ZIyim/OQ/kTJJwRAtamO07VUBeLip2Pc/oHhwdpWfdQMS35AVKuJlN9LgH6x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EQTUgvNV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 76FF340E0198;
	Fri, 13 Sep 2024 14:29:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id e5oHKccHS6N9; Fri, 13 Sep 2024 14:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1726237743; bh=307R25ouSHGodWCw+YkqwDMVNM56xp10lWJmMr+6sPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQTUgvNVJkGKGHp6fsJceJcaecrPv4Mwf9D+pHP5uhUvWI+svBIp6TuIP1htUvpuH
	 TNNf8gq3bi7swoKOeFyXcQBbSnP11mKehZvmKJD6hh4y841xsYhtKqTSGNpfmEjLBD
	 jzuckAoYC4rGUsM5xhBqE82DuC8MymLjHjE+hAZOZEkYg0u33LJijOveG5QvQd9Kvf
	 EEoMwUy39rd10DNc/Dp/ifKVRTEMsFqwT9E3fxej6VLmyTmS9eSQNQpahcH1N7utnb
	 X/rNVds+nJCkj2/Iqj5DmCv1SKShjAP5S/SPLNKakm7HE9gxY6hbccGSA55rglOhqQ
	 VtfWiODynD7ZiBCc44N5FokfVP1XBj/sbL4ktwqaP6fI+YxPylfuIB85X2v3hbxC9n
	 sODqhfGruvCtFV/V7O69eqPO0NEN7AZ4QZtx0meznZFaq/vFkRwFFzLcW07dS/y8Dh
	 7l+yfvczAZ9oZBnp0oqk6qb8uguDB6dAve5Eluyk3EP4tuxxdggSwTHNmGyTBXS+D8
	 y/ZmswpnGij2FuDxqWaSy3CM2AYV7nMVuBDSYvqG01Y4Xhp7wy/z2DQHODgI752wTN
	 EJFa7Vppag0a8NbBiA5AFpUyyXeWMJeQn5AefUXINRt7CmhA0+OyS2jS5wWoSIURU6
	 2D634YaUTmwaES8BI8TURq/0=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4AA2540E0191;
	Fri, 13 Sep 2024 14:28:50 +0000 (UTC)
Date: Fri, 13 Sep 2024 16:28:49 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com,
	Lyle Li <LyleLi@zhaoxin.com>
Subject: Re: [PATCH v1 1/3] x86/mce: Add centaur vendor to support Zhaoxin MCA
Message-ID: <20240913142849.GJZuRMIY2BxEU0tSIv@fat_crate.local>
References: <20240909104349.3349-1-TonyWWang-oc@zhaoxin.com>
 <20240909104349.3349-2-TonyWWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240909104349.3349-2-TonyWWang-oc@zhaoxin.com>

On Mon, Sep 09, 2024 at 06:43:47PM +0800, Tony W Wang-oc wrote:
> From: Lyle Li <LyleLi@zhaoxin.com>
> 
> Zhaoxin consists of two vendors, X86_VENDOR_ZHAOXIN and
> X86_VENDOR_CENTAUR, so add the centaur vendor to support
> Zhaoxin MCA in mce/core.c and mce/intel.c.
> 
> Signed-off-by: Lyle Li <LyleLi@zhaoxin.com>
> Reviewed-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>

If you're sending someone else's patch, then you need to add your SOB too.

Please educate yourself on the process:

https://kernel.org/doc/html/latest/process/submitting-patches.html

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

