Return-Path: <linux-edac+bounces-3252-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5C8A4BBE9
	for <lists+linux-edac@lfdr.de>; Mon,  3 Mar 2025 11:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A556F1890A7D
	for <lists+linux-edac@lfdr.de>; Mon,  3 Mar 2025 10:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176CE1F0E34;
	Mon,  3 Mar 2025 10:21:37 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB531EDA04;
	Mon,  3 Mar 2025 10:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997297; cv=none; b=tdR5lQNGrdVWS5SAWs5gQ4Z2b2aHEQL5QS/uLFmAdbQsRpPbJU+667KIzEz2mAEmA31HywegkJ1LfIMUKNi3SNnbFOnGEE1e/Q3xKCpPw+Rp8YFo+jCDY4NVBXP3p9dKF5IFNh5Fi8mX/u5YF2yvRq+OKlmx0mok/PnDt6Y4ruA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997297; c=relaxed/simple;
	bh=a2xSJ3T1g8IXcDpYxc901qp4tAn/pEbOH9ZKAL1qU7U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z447CwWm+yrqV3ZWc6vrIR8ru6Fb3td3ZKi0NGqXFJ+BIdXk4j8scitc9HTAZUhjU8UvSBMiCYKgLYyKTttgDxahUQoNz0PAh9z+IvwaNo2JgJGCx1VNb9OYMdj1mzbI/+H7e2Jha/R8+TiWx/nGZk7RSKZJkhKpUKrIdJGidH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z5vtd4j18z6K9SC;
	Mon,  3 Mar 2025 18:19:21 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
	by mail.maildlp.com (Postfix) with ESMTPS id 01139140A70;
	Mon,  3 Mar 2025 18:21:31 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Mar 2025 11:21:30 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 3 Mar 2025 11:21:30 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "j.williams@intel.com" <j.williams@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH linux-next 0/2] ACPI: Add support for ACPI RAS2 feature
 table
Thread-Topic: [PATCH linux-next 0/2] ACPI: Add support for ACPI RAS2 feature
 table
Thread-Index: AQHbidw989DsJKt5skazfuISb8i7/7NhGsIAgAAbu7A=
Date: Mon, 3 Mar 2025 10:21:30 +0000
Message-ID: <ed550760111d4061869949c90598ff5b@huawei.com>
References: <20250228122752.2062-1-shiju.jose@huawei.com>
 <20250303173538.000007cd@huawei.com>
In-Reply-To: <20250303173538.000007cd@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>-----Original Message-----
>From: Jonathan Cameron <jonathan.cameron@huawei.com>
>Sent: 03 March 2025 09:36
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-edac@vger.kernel.org; linux-acpi@vger.kernel.org; rafael@kernel.=
org;
>bp@alien8.de; tony.luck@intel.com; lenb@kernel.org; mchehab@kernel.org;
>linux-mm@kvack.org; linux-kernel@vger.kernel.org; linux-cxl@vger.kernel.or=
g;
>j.williams@intel.com; dave@stgolabs.net; dave.jiang@intel.com;
>alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>david@redhat.com; Vilas.Sridharan@amd.com; leo.duran@amd.com;
>Yazen.Ghannam@amd.com; rientjes@google.com; jiaqiyan@google.com;
>Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
>naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
>somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
>duenwen@google.com; gthelen@google.com;
>wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
>wbs@os.amperecomputing.com; nifan.cxl@gmail.com; tanxiaofei
><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Roberto
>Sassu <roberto.sassu@huawei.com>; kangkang.shen@futurewei.com;
>wanghuiqiang <wanghuiqiang@huawei.com>; Linuxarm
><linuxarm@huawei.com>
>Subject: Re: [PATCH linux-next 0/2] ACPI: Add support for ACPI RAS2 featur=
e
>table
>
>On Fri, 28 Feb 2025 12:27:48 +0000
><shiju.jose@huawei.com> wrote:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add support for ACPI RAS2 feature table (RAS2) defined in the ACPI 6.5
>> specification, section 5.2.21 and RAS2 HW based memory scrubbing feature=
.
>>
>> ACPI RAS2 patches were part of the EDAC series [1].
>
>Whilst linux-next now contains the EDAC patches, we shouldn't base a featu=
re
>submission on it.  This should be the same as you did for the CXL tree wit=
h a
>statement that it depends on
>
>https://web.git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/log/?h=3De=
dac-cxl
>
>which is the immutable tag / branch Borislav provided.

Hi Jonathan,

These RAS2 patches are applied cleanly, built and tested fine in the=20
immutable ras.git: 'edac-cxl' branch Borislav provided.=20
(https://web.git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/log/?h=3De=
dac-cxl).

Thanks,
Shiju
>
>I doubt there is anything else hitting this code so shouldn't be any need =
to rebase
>(I could be wrong though!)
>
>Assuming everyone is happy with this series, who is going to pick it up?
>
>Borislav via ras.git, or Rafael via acpi.git?  I don't really have any pre=
ference
>other than making sure it doesn't fall down the cracks!
>
>Jonathan
>
>>
>> 1.
>> https://lore.kernel.org/linux-cxl/20250212143654.1893-1-shiju.jose@hua
>> wei.com/
>>
>> Shiju Jose (2):
>>   ACPI:RAS2: Add ACPI RAS2 driver
>>   ras: mem: Add memory ACPI RAS2 driver
>>
>>  Documentation/edac/scrub.rst |  73 ++++++
>>  drivers/acpi/Kconfig         |  11 +
>>  drivers/acpi/Makefile        |   1 +
>>  drivers/acpi/ras2.c          | 417 +++++++++++++++++++++++++++++++++++
>>  drivers/ras/Kconfig          |  11 +
>>  drivers/ras/Makefile         |   1 +
>>  drivers/ras/acpi_ras2.c      | 383 ++++++++++++++++++++++++++++++++
>>  include/acpi/ras2_acpi.h     |  47 ++++
>>  8 files changed, 944 insertions(+)
>>  create mode 100755 drivers/acpi/ras2.c  create mode 100644
>> drivers/ras/acpi_ras2.c  create mode 100644 include/acpi/ras2_acpi.h
>>


