Return-Path: <linux-edac+bounces-5618-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3719CD1395E
	for <lists+linux-edac@lfdr.de>; Mon, 12 Jan 2026 16:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFB4D311EC50
	for <lists+linux-edac@lfdr.de>; Mon, 12 Jan 2026 15:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402172DEA8F;
	Mon, 12 Jan 2026 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NedIBfr5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C1620010C;
	Mon, 12 Jan 2026 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230405; cv=none; b=hp8oAlYUhjmunWXUfbGGiNwv9OPv8KQqP4iRI1K40RqLdVqt8FiQQ/qrSwkA7BXC+0fdjP9Q0eeLFs74+NIJX0ldSt2WlMgAr/KPVRgkTX50gTU07LFRFZ99H9FR+G/9jV1RsZVOKxaKYiYpVRSgW0WhyJcwGqbcZeCczJGdd+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230405; c=relaxed/simple;
	bh=6ikETmnXVhfDfBU5WDpUDeodKoDandB1zGwKZAPM5/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/nMCNqFqAmjiJaKTyYvKKJW++6FkNVqnOKvWuDQRuVUKqf9W/h3B7sKAeCgqKBJqPrjhk3KlFGSmdnIcDWP+p7+BHV6QtoSaLRAEOdCuTQihZHOS5FBeKprC9Q0nGowF+++teFXZnGjIhYug58eunM1knlPQHDIPl0qhxxd3eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NedIBfr5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4357840E01BB;
	Mon, 12 Jan 2026 15:06:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yTa45AN18amQ; Mon, 12 Jan 2026 15:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768230395; bh=YaxxTxdQgjkNPEauwlTyuzVixI2qIhO1JHV0bjc5j1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NedIBfr5xF/e/gTC09SP7G4e+R/fuASPskksbdhVSkWH9heL3VoDABQGgFyLfp19F
	 wuCmqy2pL8yzxhKATai16K/86vJ1+LwmWz7FDyDZ3bW9B/w27BMmNvmbMj0D6Vm7cD
	 ppKQLwTAX5aNROUqSxce9hwQPvlxbd8u+Z+IxkPOU4G3Xxg0pByMBR0j8eInXYl+aA
	 pkNs97VwDtV65e+V1dgXpP96oxGgy5fZXDr+MemLkg0vRaPPXKGmUu2JpR1DENCxsc
	 dSSoEenJuTqHVhJ608iZYsNqy24PxP2lpX1J55Z4AJOiN7SlLssPxYPVci36W8DscK
	 9dEgevp8r8cXA51vgWNs/x2gETRmiL0SSNZUXt9LtLpvt382doyWGD+dcR3QL8Tgtk
	 YVBBROcEyBWE+FkJH7rvz24B2MoQF6FcenuUClpwWLrAZ4GZnb94yUn5GGRMfH5CMr
	 MYOr7DKnsQbsHBEEhn1YbH1a/Q/TNVbYWzC9KLcAbYGoCsfUbCuJjIvwbJkKMos5Ct
	 xVighy+lOCy13YSoRERVOUBegzr7VXEQ3GEBcB3UKfjaz+dl7Qvr9Yaj/WkpO/xm8w
	 8w5D0qdBsGwlRGesnnamyrp3RFV8pWcA/KM0coj4yKaGxMlXgkxmuKT/og/AKVUhaC
	 bLERDi05T9nRIuVUc7zx7LEQ=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 16ED240E00DE;
	Mon, 12 Jan 2026 15:05:59 +0000 (UTC)
Date: Mon, 12 Jan 2026 16:05:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: rafael@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	dferguson@amperecomputing.com, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, mchehab@kernel.org,
	jonathan.cameron@huawei.com, linuxarm@huawei.com,
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	gthelen@google.com, wschwartz@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com
Subject: Re: [PATCH v14 1/2] ACPI:RAS2: Add driver for the ACPI RAS2 feature
 table
Message-ID: <20260112150552.GGaWUN0Ex8KgfqEEi5@fat_crate.local>
References: <20251209145742.297-1-shiju.jose@huawei.com>
 <20251209145742.297-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251209145742.297-2-shiju.jose@huawei.com>

On Tue, Dec 09, 2025 at 02:57:40PM +0000, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> ACPI 6.5 Specification, section 5.2.21, defined RAS2 feature table (RAS2).
> Driver adds support for RAS2 feature table, which provides interfaces for
> platform RAS features, e.g., for HW-based memory scrubbing, and logical to
> PA translation service. RAS2 uses PCC channel subspace for communicating
> with the ACPI compliant HW platform.
> 
> Co-developed-by: A Somasundaram <somasundaram.a@hpe.com>
> Signed-off-by: A Somasundaram <somasundaram.a@hpe.com>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/acpi/Kconfig  |  10 ++
>  drivers/acpi/Makefile |   1 +
>  drivers/acpi/bus.c    |   3 +
>  drivers/acpi/ras2.c   | 409 ++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/ras2.h   |  57 ++++++
>  5 files changed, 480 insertions(+)
>  create mode 100644 drivers/acpi/ras2.c
>  create mode 100644 include/acpi/ras2.h

Please go over all my review comments from here:

https://lore.kernel.org/r/20251125073627.GLaSVce7hBqGH1a3ni@fat_crate.local

and either incorporate them or say why you don't agree.

Ignoring them is NOT something you should do because this goes both ways.

Ignoring this submission now.

Thx.

-- 
Regards/Gruss,
    Boris.


https://people.kernel.org/tglx/notes-about-netiquette

