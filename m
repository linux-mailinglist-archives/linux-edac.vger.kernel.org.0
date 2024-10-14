Return-Path: <linux-edac+bounces-2057-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C97899D4DB
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 18:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03EE8B2478C
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 16:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CAB1B85C0;
	Mon, 14 Oct 2024 16:39:18 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B031ABEC9;
	Mon, 14 Oct 2024 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923958; cv=none; b=fu/dL3LI0Cs7+yaTsMq2/SyZHOvjFGSE+rTafBcECY8L3c/NOGlwr+Ot3m9xmJzrfk/pKMOwVQi8ydUlq3MzNYQ32sXUPdAzGPdfDdMDhyw3f0S2Zb1f1IUzTRELoNVent01BHzS2Rmd9neciVIb5cXBnmQfktP9VteMik2NEfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923958; c=relaxed/simple;
	bh=zknD2+ntSi7O1HCn4Izvz6qi8t6Vchg1Lkf1yHgIRIs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cOuf90e6SVeMKyUyF8FMaiS5RM7FsyyDW6Uau9kQu3Tzo4RcRaxQVMJc2qvt2PFY/pPv9QuYNxMPYxzw7ESIojsXrhJvGnf7oviaY0eB80P0YJXoTnq0npDhecxWXPEI4FEX3QyO6Y3MB72uC4PpfW2nftxgnqMp/jJROz9bf9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XS2rP6cbKz6H7Nq;
	Tue, 15 Oct 2024 00:34:45 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B781140A34;
	Tue, 15 Oct 2024 00:39:13 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 18:39:12 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 14 Oct 2024 18:39:12 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
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
Subject: RE: [PATCH v13 15/18] EDAC: Add memory repair control feature
Thread-Topic: [PATCH v13 15/18] EDAC: Add memory repair control feature
Thread-Index: AQHbGkjfMMgmWsWuUEKGOWnMNVqj8LKGVKEAgAAkG7A=
Date: Mon, 14 Oct 2024 16:39:12 +0000
Message-ID: <162f5e44507b46029eebb007dedef0d5@huawei.com>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
	<20241009124120.1124-16-shiju.jose@huawei.com>
 <20241014172312.00007034@Huawei.com>
In-Reply-To: <20241014172312.00007034@Huawei.com>
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
>Sent: 14 October 2024 17:23
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org; linux-
>acpi@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org;
>bp@alien8.de; tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
>mchehab@kernel.org; dan.j.williams@intel.com; dave@stgolabs.net;
>dave.jiang@intel.com; alison.schofield@intel.com; vishal.l.verma@intel.com=
;
>ira.weiny@intel.com; david@redhat.com; Vilas.Sridharan@amd.com;
>leo.duran@amd.com; Yazen.Ghannam@amd.com; rientjes@google.com;
>jiaqiyan@google.com; Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
>naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
>somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
>duenwen@google.com; gthelen@google.com;
>wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
>wbs@os.amperecomputing.com; nifan.cxl@gmail.com; tanxiaofei
><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Roberto
>Sassu <roberto.sassu@huawei.com>; kangkang.shen@futurewei.com;
>wanghuiqiang <wanghuiqiang@huawei.com>; Linuxarm
><linuxarm@huawei.com>
>Subject: Re: [PATCH v13 15/18] EDAC: Add memory repair control feature
>
>On Wed, 9 Oct 2024 13:41:16 +0100
><shiju.jose@huawei.com> wrote:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add generic EDAC memory repair control, eg. PPR(Post Package Repair),
>> memory sparing etc, control driver in order to control memory repairs
>> in the system. Supports sPPR(soft PPR), hPPR(hard PPR), soft/hard
>> memory sparing, memory sparing at cacheline/row/bank/rank granularity et=
c.
>> Device with memory repair features registers with EDAC device driver,
>> which retrieves memory repair descriptor from EDAC memory repair
>> driver and exposes the sysfs repair control attributes to userspace in
>> /sys/bus/edac/devices/<dev-name>/mem_repairX/.
>>
>> The common memory repair control interface abstracts the control of an
>> arbitrary memory repair functionality to a common set of functions.
>> The sysfs memory repair attribute nodes would be present only if the
>> client driver has implemented the corresponding attribute callback
>> function and passed in ops to the EDAC device driver during registration=
.
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
[...]
>
>> +
>> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/hpa
>> +Date:		Oct 2024
>> +KernelVersion:	6.12
>> +Contact:	linux-edac@vger.kernel.org
>> +Description:
>> +		(WO) Set HPA (Host Physical Address) for memory repair.
>
>Can we not just read back what was written?  Seems like userspace might ex=
pect
>that?
I am fine to add read back.
I did not add read back  for controls because there was no such requirement=
 from the client driver and
also tried to reduce the number of callbacks in the initial version.=20

Thanks,
Shiju

