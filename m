Return-Path: <linux-edac+bounces-2883-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DFAA0BC28
	for <lists+linux-edac@lfdr.de>; Mon, 13 Jan 2025 16:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC65D163AF8
	for <lists+linux-edac@lfdr.de>; Mon, 13 Jan 2025 15:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B8D29D19;
	Mon, 13 Jan 2025 15:36:48 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AFD24022D;
	Mon, 13 Jan 2025 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782608; cv=none; b=Dvwlv0Yjuhua7I3rLO7dOKGQ9MJwFlSwXoP/YMt7UHTRd/XIjcboOFCh6i52vnbbZ4U93eENiD18Q1Rx3lPvFEgRauLgoXafp7VmFltcqSpGJW+VZ+1PcDO+ll+rUTSIxoT3kv9S7ShmQot6tMJIm5JQHY0jZs+L4lIpXl8ExPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782608; c=relaxed/simple;
	bh=eEwMLBEJDiouZFR7egtIpWRy+6Clfe3WU4BlzjyK91c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Isnd3DfWEeZAtfdnpqxrSqDqB8LTPXBf2I5TXiWMINMKdfXQYPPxXEQBu8AhegQVUOVFMeQfcPoDFVMgHP8uZTePXUUkC3g/l7tOp/AFqoMbxZaXI7tQZCHI52qGktHB8Zy9c2mZTkKwz3BmwhdlnPNkG+ph/bwPX3VFaXqXLgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YWxCp5KpJz6K6ZF;
	Mon, 13 Jan 2025 23:35:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D0DC2140A70;
	Mon, 13 Jan 2025 23:36:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 13 Jan
 2025 16:36:41 +0100
Date: Mon, 13 Jan 2025 15:36:39 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<vishal.l.verma@intel.com>
CC: <shiju.jose@huawei.com>, <linux-edac@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<mchehab@kernel.org>, <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v18 00/19] EDAC: Scrub: introduce generic EDAC RAS
 control feature driver + CXL/ACPI-RAS2 drivers
Message-ID: <20250113153639.00003dfa@huawei.com>
In-Reply-To: <20250113154634.4e831d66@foz.lan>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
	<20250113154634.4e831d66@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)


> >    
> > 5. CXL features driver supporting ECS control feature.
> > 6. ACPI RAS2 driver adds OS interface for RAS2 communication through
> >    PCC mailbox and extracts ACPI RAS2 feature table (RAS2) and
> >    create platform device for the RAS memory features, which binds
> >    to the memory ACPI RAS2 driver.
> > 7. Memory ACPI RAS2 driver gets the PCC subspace for communicating
> >    with the ACPI compliant platform supports ACPI RAS2. Add callback
> >    functions and registers with EDAC device to support user to
> >    control the HW patrol scrubbers exposed to the kernel via the
> >    ACPI RAS2 table.
> > 8. Support for CXL maintenance mailbox command, which is used by
> >    CXL device memory repair feature.   
> > 9. CXL features driver supporting PPR control feature.
> > 10. CXL features driver supporting memory sparing control feature.
> >     Note: There are other PPR, memory sparing drivers to come.  
> 
> The text above should be inside Documentation, and not on patch 0.
> 
> A big description like that makes hard to review this series. It is
> also easier to review the text after having it parsed by kernel doc
> build specially for summary tables like the "Comparison of scrubbing 
> features", which deserves ReST links processed by Sphinx to the 
> corresponding definitions of the terms that are be compared there.

Whilst I fully agree that having a huge cover letter makes for a burden
for any reviewer coming to the series, this is here at specific request
of reviewers.  We can look at keeping more of it in documentation though
it's a bit white paper like in comparison with what I'd normally expect
to see in kernel documentation.

> 
> > Open Questions based on feedbacks from the community:
> > 1. Leo: Standardize unit for scrub rate, for example ACPI RAS2 does not define
> >    unit for the scrub rate. RAS2 clarification needed.   
> 
> I noticed the same when reviewing a patch series for rasdaemon. Ideally,
> ACPI requires an errata defining what units are expected for scrub rate.

There is a code first ACPI ECN that indeed adds units.  That is accepted
for next ACPI specification release.

Seems the tianocore bugzilla is unhelpfully down for a migration
but it should be id 1013 at bugzilla.tianocore.com

That adds a detailed description of what the scrub rate settings mean but
we may well still have older platforms where the scaling is arbitrary.
The units defined are sufficient to map to whatever presentation we like.

> 
> While ACPI doesn't define it, better to not add support for it - or be
> conservative using a low granularity for it (like using minutes instead 
> of hours).

I don't mind changing this, though for systems we are aware of default scrub
is typically once or twice in 24 hours.

Jonathan


