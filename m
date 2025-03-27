Return-Path: <linux-edac+bounces-3407-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EFFA73A28
	for <lists+linux-edac@lfdr.de>; Thu, 27 Mar 2025 18:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4590D189CFEF
	for <lists+linux-edac@lfdr.de>; Thu, 27 Mar 2025 17:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0F21A8418;
	Thu, 27 Mar 2025 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Y/0agaZd"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65B9161302;
	Thu, 27 Mar 2025 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743095382; cv=none; b=WrLyf8J3Us3MSKVEc7tBYhT3c2bGFG/XS9f37Zg1qyU/JqUcLy5bnt4i65ZpXj0+Wua73OwCA+gy3RyDlnyKUuO17Li9KJFp9vIwOLVaCZ91wU8xSWZlVhFf+73+tJV0D0EM/frywF+wchUzKBtBOfcIq/OXJ4LpRouDDTxvwK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743095382; c=relaxed/simple;
	bh=yqwzn4P04RSmmtSIjqDgwq4V3jkgrE6TNUdhfEVwdNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eK5o8BhHABB4Td4gDJt+RxxH2IRP14xq7UOnUSLsFjAnFXA+qfHHy+Oas6aDxh6bcWjOP2WNuPEG4StzpU1Idfg89fH7cclu4Pv1LhIQ8s/cobaverjwCwI+EGzERB4SIsvxbu/pJyCr854CMwgRRhz2rS6bSbLibBEaViIzgdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Y/0agaZd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A59E640E020E;
	Thu, 27 Mar 2025 17:09:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mxc8vZqOWA5V; Thu, 27 Mar 2025 17:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1743095372; bh=qZUNinMbG6xFv949XeNqIHvfDyV9uAyDOlNCvnC1syY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y/0agaZdSd33YCrsI69LFRQ9SzszRvmYA/kLx9tDenLQfOHbJuvabiEiVKNY0Whgn
	 UiNR65iAva3VgnMtqRiOnLc9B5Hk7Env7HjwfIQOm1UOtC7XLHG325Cf2DBfntWMt/
	 AI5HhE9RRmlnApfC2JLuz70KoDKYKr5I4qOpbRjM48OOjSkwXeE/nbIgLJUDbI1Nsb
	 6jUORe5i8CCYeXe74Pd6hY615uiIHKXYZ9sE958ImtBiYlN+siCe5X4r91EgkGVdiz
	 8zYgegaG9S91Nw3bUAKUx3APdL5wiykJLlqih+JdDDuGUEtgufhC0MPjaqERD/mJP9
	 1gbCxgllugKSbCcDXbrF/DD7zC8acyhTX6gegvKjJv5iVb6Pqq1tctlvuZt7P22DVj
	 xP9BNMOyqF/CDoe7NNBIplM2eqQuK1x6EZQH0DS/+V+qX7SM4gPpFMMYZQNt/oueCu
	 id6Fq8IPffI+eeu3rVys240GOIXoeY4PlaRD63mNAuS1d79EM8AH86+AQlh+ig/zDu
	 8h+AqfJY+SHOVbVSZ8OGRrA8YUDQLfa3yBET2Whvnd5r9pUcx1fk2xzzvq16Hx7TCu
	 cuRCfAmyHBoZigThlyUYH6MRagX+2Lc+Pi1QLVFLmB0Xr2EwixoLGbSp9kBDtGlAMQ
	 kX+3am8K14cpRr25XSwsW9i8=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1DC9A40E0169;
	Thu, 27 Mar 2025 17:08:49 +0000 (UTC)
Date: Thu, 27 Mar 2025 18:08:48 +0100
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
Message-ID: <20250327170848.GDZ-WGIM553HJ61xj6@fat_crate.local>
References: <20250320180450.539-1-shiju.jose@huawei.com>
 <20250320180450.539-8-shiju.jose@huawei.com>
 <20250327170156.GCZ-WEhNREaxQaH_ya@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250327170156.GCZ-WEhNREaxQaH_ya@fat_crate.local>

On Thu, Mar 27, 2025 at 06:01:56PM +0100, Borislav Petkov wrote:
> On Thu, Mar 20, 2025 at 06:04:44PM +0000, shiju.jose@huawei.com wrote:
> > diff --git a/drivers/edac/mem_repair.c b/drivers/edac/mem_repair.c
> > index 3b1a845457b0..bf7e01a8b4dd 100755
> > --- a/drivers/edac/mem_repair.c
> > +++ b/drivers/edac/mem_repair.c
> > @@ -45,6 +45,11 @@ struct edac_mem_repair_context {
> >  	struct attribute_group group;
> >  };
> >  
> > +const char * const edac_repair_type[] = {
> > +	[EDAC_PPR] = "ppr",
> > +};
> > +EXPORT_SYMBOL_GPL(edac_repair_type);
> 
> Why is this thing exported instead of adding a getter function and having all
> its users pass in proper defines as arguments?
> 
> And "EDAC_PPR" is not a proper define - it doesn't tell me what it is.
> 
> It should be more likely a
> 
> EDAC_REPAIR_PPR,
> EDAC_REPAIR_ROW_SPARING,
> EDAC_REPAIR_BANK_SPARING,
> 
> and so on.

Looking at this more:

+static int cxl_ppr_get_repair_type(struct device *dev, void *drv_data,
+				   const char **repair_type)
+{
+	*repair_type = edac_repair_type[EDAC_PPR];
+
+	return 0;
+}

Can this be any more silly?

An ops member which copies a string pointer into some argument. What for?

If those strings are for userspace, why don't you simply return *numbers* and
let userspace convert them into strings?

Oh boy.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

