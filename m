Return-Path: <linux-edac+bounces-3262-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 598D1A4E31C
	for <lists+linux-edac@lfdr.de>; Tue,  4 Mar 2025 16:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FC1888283
	for <lists+linux-edac@lfdr.de>; Tue,  4 Mar 2025 15:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B20124C098;
	Tue,  4 Mar 2025 15:05:06 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3370B24C07F
	for <linux-edac@vger.kernel.org>; Tue,  4 Mar 2025 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100706; cv=pass; b=hWSucDs9+8Q0afpfmiyNae7mJxu0ZWiYSE9eBF0tDqSiBBruBzaHjc450r90Bc4VXkpPt/hZPC8JyJ+yD8YYVgXD/snAM4XfAON7G4ZZcVc9qcPgouFlwN4w+k8MOmI71GHhD91+uNzsm3CAKLGsYq/sobpXAmp2SOZ5ja0jnBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100706; c=relaxed/simple;
	bh=8nYoOodSaWim/vrOXXM0k0eQCZlZ0YuVrf/ni5EyRYg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTIDijrfAxV0X3rN51SLZJYchhlpQgVjQ6F71CZ99nzcaqj7gn9h2wrvyr6Kpz2Byymu1TmQDvcrHChjAQSTp0tav58bK/Ee+ZlxKr8xy5dJ/oOEo49KFMMW+ifr7geZWjsiY1WRPGsThUsnoV4Ue3ikOiHQ3xekJmVGmkCPZV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=185.176.79.56; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 9A74240CECE5
	for <linux-edac@vger.kernel.org>; Tue,  4 Mar 2025 18:05:02 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6f833TqWzFyLN
	for <linux-edac@vger.kernel.org>; Tue,  4 Mar 2025 18:03:31 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 7F10042720; Tue,  4 Mar 2025 18:03:15 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541281-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 4C67D4254C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:36:14 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id D7FE42DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:36:13 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27723ACABF
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF1C1F1500;
	Mon,  3 Mar 2025 09:36:00 +0000 (UTC)
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
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6f833TqWzFyLN
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741705417.96652@f12/6+XPpzjz57b8DLy+AQ
X-ITU-MailScanner-SpamCheck: not spam

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



