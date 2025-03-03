Return-Path: <linux-edac+bounces-3251-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AA2A4BAE5
	for <lists+linux-edac@lfdr.de>; Mon,  3 Mar 2025 10:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9314D168D22
	for <lists+linux-edac@lfdr.de>; Mon,  3 Mar 2025 09:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF741F0E2F;
	Mon,  3 Mar 2025 09:35:59 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1B21EF0B6;
	Mon,  3 Mar 2025 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740994559; cv=none; b=h2hum4o/EJEhGIElqamU0J33Z6uIKYqJnuDY+Nf5/eAWx+QvdvJrvdvqh9ktvM6p0BDGYmUbHlKgWsixr07+vqYgC8003IKEcXo3dJVodL12wOtF7IVchBG6OsvJIvIGqx9OD1ucqRxUynoOQERCfe06GGwZICL4ZoZYTmbd8aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740994559; c=relaxed/simple;
	bh=8nYoOodSaWim/vrOXXM0k0eQCZlZ0YuVrf/ni5EyRYg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqEU9ZGrBZRw3CDj0qmxy0kOELqnesP4ju0KEN3NHK6tqOlADumHbIbDBGXC+0dlNFqg5Y4n5kMKWrEoyU/6ZGP8CnhLEOgQDjTCe4MMdYBixlxzBJSMfED7M6IFSQABnBgGXv35isRIXVS1zcUrRrvfjElb7sZT7pbx6S/QNzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z5tqt0lX3z6L55S;
	Mon,  3 Mar 2025 17:31:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9579D1400DC;
	Mon,  3 Mar 2025 17:35:53 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Mar
 2025 10:35:43 +0100
Date: Mon, 3 Mar 2025 17:35:38 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<lenb@kernel.org>, <mchehab@kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<j.williams@intel.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
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
Subject: Re: [PATCH linux-next 0/2] ACPI: Add support for ACPI RAS2 feature
 table
Message-ID: <20250303173538.000007cd@huawei.com>
In-Reply-To: <20250228122752.2062-1-shiju.jose@huawei.com>
References: <20250228122752.2062-1-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 28 Feb 2025 12:27:48 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for ACPI RAS2 feature table (RAS2) defined in the ACPI 6.5
> specification, section 5.2.21 and RAS2 HW based memory scrubbing feature.
> 
> ACPI RAS2 patches were part of the EDAC series [1].

Whilst linux-next now contains the EDAC patches, we shouldn't base
a feature submission on it.  This should be the same as you
did for the CXL tree with a statement that it depends on 

https://web.git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/log/?h=edac-cxl

which is the immutable tag / branch Borislav provided.

I doubt there is anything else hitting this code so
shouldn't be any need to rebase (I could be wrong though!)

Assuming everyone is happy with this series, who is going to pick
it up?

Borislav via ras.git, or Rafael via acpi.git?  I don't really
have any preference other than making sure it doesn't fall down
the cracks!

Jonathan

> 
> 1. https://lore.kernel.org/linux-cxl/20250212143654.1893-1-shiju.jose@huawei.com/ 
> 
> Shiju Jose (2):
>   ACPI:RAS2: Add ACPI RAS2 driver
>   ras: mem: Add memory ACPI RAS2 driver
> 
>  Documentation/edac/scrub.rst |  73 ++++++
>  drivers/acpi/Kconfig         |  11 +
>  drivers/acpi/Makefile        |   1 +
>  drivers/acpi/ras2.c          | 417 +++++++++++++++++++++++++++++++++++
>  drivers/ras/Kconfig          |  11 +
>  drivers/ras/Makefile         |   1 +
>  drivers/ras/acpi_ras2.c      | 383 ++++++++++++++++++++++++++++++++
>  include/acpi/ras2_acpi.h     |  47 ++++
>  8 files changed, 944 insertions(+)
>  create mode 100755 drivers/acpi/ras2.c
>  create mode 100644 drivers/ras/acpi_ras2.c
>  create mode 100644 include/acpi/ras2_acpi.h
> 


