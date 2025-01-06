Return-Path: <linux-edac+bounces-2815-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60448A02D09
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 17:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AAA43A57C1
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 15:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA721D9595;
	Mon,  6 Jan 2025 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aSFAR86e"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF64145A03;
	Mon,  6 Jan 2025 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736179114; cv=none; b=ReMFr3S/4D8wwOKN0OwHiP9HBtV0JZGQpLuSOHAr1OIb006LKkneRLmNVtS5ZPwvCRkqLOad9GxOP87+QYg3P9+6yajhtUUmztGsi61UljOns2s0wzEmWjQspqFdztapSI2nkJjDYP/7/rmLM8Yc4aNlYzIR9Mwcwyd55PyAgv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736179114; c=relaxed/simple;
	bh=Gl7EeJt7VbNFM70n/jb4hDDT8NvUwCrZiNQyxRJ9gPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkI7yc1KSXhbB2SGwD6iVhmVd+fRDp9OXd9XizaywbKRGreQOWKC+CAYo6QHZ/sGxVS0z/DTBtxhKTCSCvfAFNmfUSt+vvHz60YmiuKgqKUDAKt9ZjwMqJmurTQoXZb34E+f0/E4j+EFxHB89igVuOyjjUsSwpBX6FsQXtzFFxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aSFAR86e; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0C9A740E021E;
	Mon,  6 Jan 2025 15:58:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ays1ynDfBLxs; Mon,  6 Jan 2025 15:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1736179103; bh=8FrVdzdC933WpWJbSAkxpf/1Y9ZiykmTnNKJwfdveoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aSFAR86e8ssloIm1iXi7KtTbARiywe+7BSqSRtda1pArvVPG3Td27EVFLWYHMj6IL
	 UjqKRqJP0SdMEdRGAKunTiM3o424aiCV5t4AJjyaE9yjjBnQ3ztMTS7WXpaN7lQR7X
	 NDdV/JZ9eDK6jweZfrXLvCI9N8a1YhHYemi7ytuORvEvJWrm3SnE1IaYoEsSHH/wbg
	 06i5Y7MQDKbsWmm9aHOSjXuVdxN65XI0VcpODpuZeZBzUdYSAWN0l/KcXdi1RzbL5o
	 BgcKY7z6gW251R2q1hPlAdsej8SD3yU/4sZ4M6EaV67zZn40byU+QNbmejzzhE/05b
	 r6C8cWyEYL6c8ZqsuEFoUJQs9Nyt10QEKTR/tIv0d9sHmlMw5FAhJg3QEMKn+DwYA5
	 0aA+ic7VYwYeEOJS1YuZQG0hztPPsl6mxtL5Ehml+K343h/T2y31d1GTCbbFdwLYue
	 3WuodtQtkwlY9CZ1vLKeVy0FpKTRgtwgMxTvl17R5+Np0Fy8Be/j9/7A+Ohtc4JHXn
	 4LB8UPDpY3CPmQHeU44fvjdhlmuFN91XTfJwQ6n+Ca1/9xVTyS3LxU2j7ej06sW/10
	 KbvGnBo4R4wgx08WOfs7WAj/trosJgEm35qzxUPjD/8kdgPn6L4uJzVY4Vwa8tpO43
	 bae+pjYD4KXbOuNpiOLqQIkI=
Received: from zn.tnic (p200300Ea971F93E8329c23Fffea6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93e8:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1420140E0163;
	Mon,  6 Jan 2025 15:57:40 +0000 (UTC)
Date: Mon, 6 Jan 2025 16:57:33 +0100
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	rafael@kernel.org, lenb@kernel.org, mchehab@kernel.org,
	dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, david@redhat.com, Vilas.Sridharan@amd.com,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, rientjes@google.com,
	jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v18 02/19] EDAC: Add scrub control feature
Message-ID: <20250106155733.GAZ3v9bQspKvdi3lZE@fat_crate.local>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
 <20250106121017.1620-3-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250106121017.1620-3-shiju.jose@huawei.com>

On Mon, Jan 06, 2025 at 12:09:58PM +0000, shiju.jose@huawei.com wrote:
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index f9cf19d8d13d..a162726cc6b9 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_EDAC)			:= edac_core.o
>  
>  edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
>  edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o
> +edac_core-y	+= scrub.o

You're not being serious here - this scrub gunk is enabled by default on
*everything*?

So the main user of this is going to be CXL, AFAICT, so the scrubbing gunk
should depend at least on it or so. Definitely not unconditionally enabled on
every build.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

