Return-Path: <linux-edac+bounces-3406-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B221A737A5
	for <lists+linux-edac@lfdr.de>; Thu, 27 Mar 2025 18:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61230188C00E
	for <lists+linux-edac@lfdr.de>; Thu, 27 Mar 2025 17:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCB3183CA6;
	Thu, 27 Mar 2025 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="U4cVd5wO"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17ABF9FE;
	Thu, 27 Mar 2025 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743094978; cv=none; b=tF6XW4qqRwp8C2A8BxX98qF+QWPSlUzp8/Zt1enBoGsB1cogkuHIuCiekp1VdwPH6nhFAUv8P5dzSxR1nSyLsYKACN+i/DVPOw/BkbDhCJI6VXSwXbaULZ9C5l69wk+6oCc55vsmGVnXjS8I9dJF77Ir4H+VzuYV0Gu3BObw5G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743094978; c=relaxed/simple;
	bh=+UJ3ZfnrEWAe92blxZH9heLkwYRbmnDsgPjcauBk7AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3+KSwR6EKngtScZRc6njsTQBhjixo8ZID9OCWMiLbnyEmZiz14m4B5Mc6wlUFMvymEpkh3vqqZpibzWlPdAhSmxw/zrVvM0zWxnEkazYRu6H2dbEryTa2peFiF0TMNPl2aDtSM0pjtV/102F4QCl/61RyutO0BZAxkMNCbVOMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=U4cVd5wO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 16E0140E020E;
	Thu, 27 Mar 2025 17:02:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XYkpMZ1b9u1p; Thu, 27 Mar 2025 17:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1743094965; bh=IRroS5Aq4fm3j99yiL8SYLl/wPiF4M3AoqI3PR/tB7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4cVd5wOPnxt4yWyBLfmqQ+WUieDZ99QsIYy/WEAR+7FhmXt3ZsIaUuHmqeG5Byxc
	 WnDS9D2PXn6v9coYLoqKa47clsCYYTISfxbBgT1/VPR2mWzAAXaYGEd2DI49k6Y6Zp
	 2JBSU56Vt7UIlGD3znx8NyX56QNIFfbGyRnhNEtJL+NOd3VnvxxwOkuYGOTG3oUhvb
	 9hCol2/o+qPy+mE6mP8TFg8fEZ3VQbYgB3XmDi+6yZIk/zFTD0cUib8aduoGUXC4XM
	 TOfLxk3k8gA6Pm3fxDcr7lpZ+dji+dO/qVPOG2cbyhkZnTQDwGObUAkxeQAKro/V6/
	 GWK7tg9r8fkx5U11UjE6Vr5YW97tBdtzHJ3IxeO73ys7vo/bmelVhbfM7hGCPQgOAI
	 AibW/XCexM2Jy0RoPw0BGyv0irML1HCy5U2npjM4kLZlsRbDx01SaiaqCC5GWRQyw9
	 qhepP8UbRKuUqfbZSDlX/MOnjonNIjrNgrYBOqNHIW6U9M8PSzes5FQAJE1vwcyiqO
	 IUtrjfnmwY65WU+k+nI1xM1CYg6gDFoD0D13ZHDEEYACyGoPzT5tHcmXeYqPoNgChO
	 +CHAuuMz8QFNI22EpYTrs6eDKL/k+pOCiEAjCfU4wJwV6pQ32JQbjuaQN18unQy3na
	 4/dhhv1pkI56QyswR0Pc5QXU=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 579A840E0196;
	Thu, 27 Mar 2025 17:02:02 +0000 (UTC)
Date: Thu, 27 Mar 2025 18:01:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, david@redhat.com, Vilas.Sridharan@amd.com,
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, rafael@kernel.org, lenb@kernel.org,
	mchehab@kernel.org, leo.duran@amd.com, Yazen.Ghannam@amd.com,
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	gthelen@google.com, wschwartz@amperecomputing.com,
	dferguson@amperecomputing.com, wbs@os.amperecomputing.com,
	nifan.cxl@gmail.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com,
	linuxarm@huawei.com
Subject: Re: [PATCH v2 7/8] cxl/memfeature: Add CXL memory device soft PPR
 control feature
Message-ID: <20250327170156.GCZ-WEhNREaxQaH_ya@fat_crate.local>
References: <20250320180450.539-1-shiju.jose@huawei.com>
 <20250320180450.539-8-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320180450.539-8-shiju.jose@huawei.com>

On Thu, Mar 20, 2025 at 06:04:44PM +0000, shiju.jose@huawei.com wrote:
> diff --git a/drivers/edac/mem_repair.c b/drivers/edac/mem_repair.c
> index 3b1a845457b0..bf7e01a8b4dd 100755
> --- a/drivers/edac/mem_repair.c
> +++ b/drivers/edac/mem_repair.c
> @@ -45,6 +45,11 @@ struct edac_mem_repair_context {
>  	struct attribute_group group;
>  };
>  
> +const char * const edac_repair_type[] = {
> +	[EDAC_PPR] = "ppr",
> +};
> +EXPORT_SYMBOL_GPL(edac_repair_type);

Why is this thing exported instead of adding a getter function and having all
its users pass in proper defines as arguments?

And "EDAC_PPR" is not a proper define - it doesn't tell me what it is.

It should be more likely a

EDAC_REPAIR_PPR,
EDAC_REPAIR_ROW_SPARING,
EDAC_REPAIR_BANK_SPARING,

and so on.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

