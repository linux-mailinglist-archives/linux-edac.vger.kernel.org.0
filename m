Return-Path: <linux-edac+bounces-2819-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C64A038D1
	for <lists+linux-edac@lfdr.de>; Tue,  7 Jan 2025 08:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670A21886583
	for <lists+linux-edac@lfdr.de>; Tue,  7 Jan 2025 07:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD94156F3F;
	Tue,  7 Jan 2025 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="a1iy5UTi"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B4C1862A;
	Tue,  7 Jan 2025 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736235185; cv=none; b=X8fLdDXPICIkm7cRHnz19aJ0Lc39FbJR3kNOY6TJtkhAhZxu6C0ONAZCLhB6dlX0+1FI9dAPHjYBGMKnaXhGsdBN2HKOzFLVq5kLFfAp6hfbvpEkC4ZQ/1QlHB8kvtHniTr5OWzhcNon9wExpO26knM3Z4rOs6JFihD1vZ64Qzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736235185; c=relaxed/simple;
	bh=RRoVh0E2t0bccH/iELMMi9eHYgKC1deGS4Mbe0wK4xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WS7DfwMJBcotL8069xEJ2e12s/e3AAiClMVXHBP9PT/v86qqkrHf5+jSWe3S0arFq0l0ZHI5J1CJlNLbddoroPNZwSoaki+fFgSJgX5izAzsgQj4QMYq4eM5kOQRf4jXjLh8gzH/6tPOuP1aCWX6Dn7gD3s+WBO+hjkKRcE4ohE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=a1iy5UTi; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1F57440E0163;
	Tue,  7 Jan 2025 07:32:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gp_XynEJRAhn; Tue,  7 Jan 2025 07:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1736235169; bh=oWOPrGULgEDzUljnOv0D7y9Z2oqc2AFjwXl92zvjRa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a1iy5UTiowwHwLV1fi/sYuVddu5lpqsuRs/YEyqpHiHv3k0ON4Sv3yMWFf3DJF3TP
	 jtki+oxuBKIc/AA4s1FM2bNta348heviDtsXARKRf9xDxlXPeviIeejrNzd4TFYiYm
	 VDtuQrnDfo+zDzpC918ygGN1JwaH3zMYRPEjGOK9CHD8wAsf3Do03hDEWV8ks/fUI0
	 AkTWL3KWbtd2NZHP0I7Gnyf0WXuyiP1ZD2lSEanNT491YwVgD8Cb8anESLm0f6Ml/E
	 cNvfdVSlVaw/FxbkAUT/HgWjuYLGxvRqMx2avEPCF8fggJnsVkrS7FtbgwqobTEEkm
	 5xOCFv9oSlCT5vfyvNlHSKnohAeDl6OtvMPyJlQ+hp+Ykk7Q1zJe3G9kTJkLSzOhXJ
	 bdcgamveUkpHh8mNTgZUzbVs7+W+S9dJBxnZ6vAtdQ76yIm4DAdt3oX/HKMbZtBrJY
	 MVDdlP7PsHBZqS1Wb3E1mUbsCQbPM8dSpOcVUssj1ZAfqm20IYdwCiya7SkEfRqtPX
	 yt+JYoTPBDpPFmVr2C0umut7sWa+7LoCP4xekvYGI4IQ7W+oVi31i06dexzY3TmNn6
	 In4tZ0M6Yj02Aeb8dwQqZAnDtEcASRTiCP4uU4BLiC5RmkxKZC2FsPp53k4mJFEgCT
	 MrPoyx76Fucd0FtQx2Y3UDiw=
Received: from zn.tnic (p200300ea971F93e8329c23ffFea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93e8:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 80BE340E0266;
	Tue,  7 Jan 2025 07:32:05 +0000 (UTC)
Date: Tue, 7 Jan 2025 08:32:04 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
	"leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
	"erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>,
	"gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
	wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v18 02/19] EDAC: Add scrub control feature
Message-ID: <20250107073204.GBZ3zYdOtWEbieKXiU@fat_crate.local>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
 <20250106121017.1620-3-shiju.jose@huawei.com>
 <20250106155733.GAZ3v9bQspKvdi3lZE@fat_crate.local>
 <36665b7bf4974020a34d08a7ddf6d554@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36665b7bf4974020a34d08a7ddf6d554@huawei.com>

On Mon, Jan 06, 2025 at 07:34:41PM +0000, Shiju Jose wrote:
> My understanding is that you meant the following changes (diff to this
> patch), for scrub?  (and similar for other features).  Please let me know if
> you need any corrections.

Yes, something like that except "select" is evil and should be used only when
the items it selects do not pull in more stuff. And since scrub is all
optional, it should all be depends.

> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 06f7b43a6f78..709bd7ad8015 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -9,6 +9,14 @@ config EDAC_ATOMIC_SCRUB
>  config EDAC_SUPPORT
>  	bool
>  
> +config EDAC_FEAT_SCRUB

EDAC_SCRUB is perfectly fine.

> +	bool
> +	help
> +	  The EDAC scrub feature is optional and is designed to control the
> +	  memory scrubbers in the system. The common sysfs scrub interface
> +	  abstracts the control of various arbitrary scrubbing functionalities
> +	  into a unified set of functions.

This should come...

> +
>  menuconfig EDAC
>  	tristate "EDAC (Error Detection And Correction) reporting"
>  	depends on HAS_IOMEM && EDAC_SUPPORT && RAS

... in here as it is part of EDAC.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

