Return-Path: <linux-edac+bounces-5552-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7645CADC07
	for <lists+linux-edac@lfdr.de>; Mon, 08 Dec 2025 17:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28B26300B98B
	for <lists+linux-edac@lfdr.de>; Mon,  8 Dec 2025 16:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCAC2E62D1;
	Mon,  8 Dec 2025 16:29:33 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC12F9C0;
	Mon,  8 Dec 2025 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765211372; cv=none; b=KaQNvtBKLMhk9gwqWt/uXsOAt8oWejVYm03z09jap2Ldog/bhg1k5uuBkEkwkuHbz9irlw+Tteh2umdzBHv1V2FT8Ij6q/lil90ZBVwJLBCIirgLhl1vjgrtKisoH21j0vv9j24fARyDr56rUe07Ij+5vpEUzB/5JLVl181njOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765211372; c=relaxed/simple;
	bh=+fFSSXxx2uY4ST/z9faoq6ULJhQzG6m2kPYgkKdUPhM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7RAJDhbACVxYFPYxbDtjyklIBAWjJwKC5psKm/qt5FHmofj0otKR9XZLBNBxELSAHSOYbT33pHGW2n0yz4uNFYErljDL3Uf0a+9Kbr3YLVZpqdwDkhuebNA/hEml6Aj3NJF1iuK3LwNINfbCWc/x4cAtoMTQYyWSn/372IVIcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dQ6rH30jGzHnGjc;
	Tue,  9 Dec 2025 00:29:19 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 37DA840565;
	Tue,  9 Dec 2025 00:29:27 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 8 Dec
 2025 16:29:25 +0000
Date: Mon, 8 Dec 2025 16:29:24 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: <shiju.jose@huawei.com>, <rafael@kernel.org>, <akpm@linux-foundation.org>,
	<rppt@kernel.org>, <dferguson@amperecomputing.com>,
	<linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-doc@vger.kernel.org>, <tony.luck@intel.com>,
	<lenb@kernel.org>, <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>, <linuxarm@huawei.com>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>
Subject: Re: [PATCH v13 1/2] ACPI:RAS2: Add driver for the ACPI RAS2 feature
 table
Message-ID: <20251208162924.00004a38@huawei.com>
In-Reply-To: <20251125073627.GLaSVce7hBqGH1a3ni@fat_crate.local>
References: <20251121182825.237-1-shiju.jose@huawei.com>
	<20251121182825.237-2-shiju.jose@huawei.com>
	<20251125073627.GLaSVce7hBqGH1a3ni@fat_crate.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 25 Nov 2025 08:36:27 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Nov 21, 2025 at 06:28:20PM +0000, shiju.jose@huawei.com wrote:
> > From: Shiju Jose <shiju.jose@huawei.com>
> > 
> > ACPI 6.5 Specification, section 5.2.21, defined RAS2 feature table (RAS2).
> > Driver adds support for RAS2 feature table, which provides interfaces for
> > platform RAS features, for eg. HW-based memory scrubbing, and logical to
> > PA translation service. RAS2 uses PCC channel subspace for communicating
> > with the ACPI compliant HW platform.
> > 
> > Co-developed-by: A Somasundaram <somasundaram.a@hpe.com>
> > Signed-off-by: A Somasundaram <somasundaram.a@hpe.com>
> > Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com>
> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Just picking out one point where I disagree.

> 
> > +
> > +	struct ras2_mem_ctx **pctx_list __free(kfree) = kzalloc(ras2_tab->num_pcc_descs * sizeof(*pctx_list), GFP_KERNEL);  
> 
> Function member declarations at the beginning of the function, pls, and then
> you can remove this ugly linebreak too.

No to this suggestion.  Doing so breaks the rules that Linus has laid
out for use of __free. Constructor and destructor must be next to each
other. See guidance in cleanup.h.  This stuff is new, so it's perfectly
fine for a subsystem maintainer to say they don't want it used, but
if it is used then it should be done according to the agreed style.

Various folk have already experienced a grumpy Linus when they put the
declarations separate from the constructor.

FWIW there is a long thread on the ksummit list that repeats and
extends the discussions that lead to the guidance notes in the header.

https://lore.kernel.org/ksummit/B92B21C0-093D-4F52-A7E3-1A7DDC83749B@zytor.com/T/#t

Jonathan



