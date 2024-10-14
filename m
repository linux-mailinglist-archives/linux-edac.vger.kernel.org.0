Return-Path: <linux-edac+bounces-2044-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF9B99CE58
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 16:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A211F23CE6
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 14:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73191AB525;
	Mon, 14 Oct 2024 14:42:47 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378ED20EB;
	Mon, 14 Oct 2024 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916967; cv=none; b=oIq9ixxiJkW2ldnbxS66Idv6jNz1YhIceyp9aAcKLIYCczTnwHla7SquC3ssDHQhLL8YFwCZjN+NTln1joaMqnV3neFc6FwL6jqsTPBFtr/ZSY/OzpvNJnuzP67VRx0buvr6dW4f0rAMUIwG/ANUU73epCRz1n1mTe7kB44iXSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916967; c=relaxed/simple;
	bh=RSNRR2r08+yny9EY39TfsT1UKltcCVUbC34wSkBYbRk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8oLWiB6zAw/hQgdvigL0xGC7wPtNmWJDvT+IyF9K0o8X6MkaJr3RNDrhkMKagsqISwViesSG0Fd6sCCcuDTPLC5t9gZ9UWWMAgswP2d497/Pxz3lQP3DyAchGGOAERvHR34pGIw1k5z0UFjXA6w6k6iaBiIBDDSSKQakW0JeHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XS0KG6Nxwz6GC8c;
	Mon, 14 Oct 2024 22:41:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F831140A77;
	Mon, 14 Oct 2024 22:42:41 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 16:42:40 +0200
Date: Mon, 14 Oct 2024 15:42:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>,
	<leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v13 05/18] cxl: Move mailbox related bits to the same
 context
Message-ID: <20241014154238.000055a3@Huawei.com>
In-Reply-To: <20241009124120.1124-6-shiju.jose@huawei.com>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
	<20241009124120.1124-6-shiju.jose@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 9 Oct 2024 13:41:06 +0100
<shiju.jose@huawei.com> wrote:

> From: Dave Jiang <dave.jiang@intel.com>
> 
> Create a new 'struct cxl_mailbox' and move all mailbox related bits to
> it. This allows isolation of all CXL mailbox data in order to export
> some of the calls to external kernel callers and avoid exporting of CXL
> driver specific bits such has device states. The allocation of
> 'struct cxl_mailbox' is also split out with cxl_mailbox_create() so the
Ira called this out in the v4 posting from Dave.
Change text to say cxl_mailbox_init()

> mailbox can be created independently.
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Link: https://patch.msgid.link/20240724185649.2574627-2-dave.jiang@intel.com

That link is to an old version.
https://lore.kernel.org/linux-cxl/20240905223711.1990186-1-dave.jiang@intel.com/
Is what you have in the cover letter change log so needs to be that here
as well.

I'll review this on Dave's thread rather than here.   Dave, we'll need
a immutable branch for this one once you think it's ready for queuing up.

If we can do that soon that would be good as it's either gating this
series and is a precursor for the type2 stuff.
If we are sure only this stuff will make the coming merge window
(crosses fingers) then we an take it via Borislav's tree
- perhaps we should discuss this on the sync call tomorrow.

