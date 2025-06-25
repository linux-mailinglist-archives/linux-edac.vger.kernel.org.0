Return-Path: <linux-edac+bounces-4240-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C213DAE8162
	for <lists+linux-edac@lfdr.de>; Wed, 25 Jun 2025 13:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C58118854D8
	for <lists+linux-edac@lfdr.de>; Wed, 25 Jun 2025 11:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C822BF00A;
	Wed, 25 Jun 2025 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KusbOReh"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348192BF018;
	Wed, 25 Jun 2025 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850808; cv=none; b=Gq6xN2Vyyye5b886WRcLR38vdDFf+Cs1EGYZcOBGBzPyZLukdZnJi64ersEfrTUXeEHTXx/0zYRI5mr0an8mYWOJp7/lKKZ2ARyW+iNm62FtidV4oRaWEBVnWVypeBtNHQQjqvwvVEV4e7MRwQUAZm7xduRFR0yIptJ2yZBkja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850808; c=relaxed/simple;
	bh=fwe9BBLMlu4VzpIL1O4aUOFuc3nVdJxZWfgog8pSUwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4ua72O/3bVtBDKuFa6Mlnd4rvTaPnEyWj0cN04Mmwq/j4INPLpfLq7pIgiQFzEL3iqdjU1Q6W0c0DG1QplHW6/4kXDX7D8Cuw/uxbgsAktu894UJNQ91YIAWQS6JEUn0vcFtiE6dfK5NjNbNgMWupsJzTEJT5HOdQi+evYyrzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KusbOReh; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9379240E00CE;
	Wed, 25 Jun 2025 11:26:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QOZ3dyJqhmiV; Wed, 25 Jun 2025 11:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1750850799; bh=N4krg2nW69F/Z/Y1vJhF5JHhSPZNqedsWzEdZoS9FB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KusbORehXEpmuMQDnw08R59uZzhK5efmE6CsY5dC9f+4PUG7vh5I7jle+7rIQ8iU7
	 vjs3zp0mUG+ArPkBIYRrYCa/F6ZXyg8UkGZ+tZ1TBv9ojtGjBoJ9jLu8mMrvrvIU1x
	 5FbvS4/3JqUsrFSEjvRy95y5pQEbSTJsEFHlIZ1BgXVKbDlVCSBWBGLPy6qMB/6j+x
	 36VCM8DdU5WI1KYJU+aFqFio6FO1CTt3858FCwb+WM2ZF9WaXs2oFiNqB9F0AUZNiZ
	 yZesJbQiCqZ2VVNt+G+hGBiL/QkBXSTy2CAp7cV9pyiPiZgyocSeP3AAmMJ91cbveG
	 W0aiTla/yei2M5k9jyksKVDwK6ZjBcgdRMk2DOZyHnsl5kSOwS7JeNKanHc+pNeS4j
	 T+BDzFQ2INzZG1D2SayaSlBKXLsvwrdwkmQpPa1Wi3XI8ruRdaUF8TGEfRJGfXlcz0
	 hkqO74aE3JfwH1u40p9DypdqONGQTHnuHzXYmwSyzaldRHaIHPWJn522+wkGNUeVPX
	 0e4dUNul77GiJq/z6iOolS8+iCRj60wU4IMpTR6qFs3GHmQ1kE9U6l80IZAnvBATFv
	 n5JqKuV4T2NLBzkNSNFA+dEtIEF3UCbfJkHcD1UYnKLkw7CNtElhW+sviyEBukwNix
	 pxC2h/aOaH17XmPwCjbkI87w=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1701A40E0169;
	Wed, 25 Jun 2025 11:26:28 +0000 (UTC)
Date: Wed, 25 Jun 2025 13:26:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 11/22] x86/mce: Define BSP-only init
Message-ID: <20250625112617.GBaFvc2SdsGhEFPiYR@fat_crate.local>
References: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
 <20250624-wip-mca-updates-v4-11-236dd74f645f@amd.com>
 <fa56c7d9-cd93-47a5-bc48-0962b364d8be@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa56c7d9-cd93-47a5-bc48-0962b364d8be@suse.com>

On Wed, Jun 25, 2025 at 02:04:24PM +0300, Nikolay Borisov wrote:
> nit: Why use cpu_feature_enabled VS say boot_cpu_has since none of the 3
> features are defined in cpufeaturemasks.h, meaning that cpu_feature_enabled
> is essentially static_cpu_has, given that this is not a fast path?
> 
> It's not wrong per-se but I think the cpu_feature_enabled api is somewhat of
> a trainwreck i.e we ought to have a version that uses boot_cpu_has for
> "ordinary uses" and probably cpu_feature_enabled_fast for fastpaths.

Look at the resulting asm of *cpu_has().

And, we need exactly one interface that everyone should use and everyone
should not care about what it does underneath. Not 10 interfaces as it is now.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

