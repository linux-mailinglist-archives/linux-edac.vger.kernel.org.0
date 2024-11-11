Return-Path: <linux-edac+bounces-2497-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE5D9C433A
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 18:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D4D9B24752
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 17:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D301A3A80;
	Mon, 11 Nov 2024 17:01:20 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79802AF1C;
	Mon, 11 Nov 2024 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731344480; cv=none; b=dq9cpQd15AZQ/gU6nMiG6ImAiGnOneas47cMC742DSmt+UtupN3EkiKCLNy91S10gzVTMOeZpPJFooapAZ9EuOc/zPqBNndAnqM2cTG/2Wqjfx6W/uiP2z0k3e4U2lbSCU5E3BUJ6gbzk0kSnGv6R0y4LQbe0P04MPwZqVJ7w3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731344480; c=relaxed/simple;
	bh=T3LxACEy2Zjds7035OyJciNR2kucRD7O/RPJ2VLWR/Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=crtQV7ezc5g6/0FzEXBy82LJ30GegkYddeYniRjiLrn923Hdj/x4GEa9ubsLEtK4YPk1wBPbcLAbiOYVg8thF+N4BRgLgii6zkYzUDQZD5TFTSNGF3uoYpl7M1Rg/pwGr80qWtYxPFSdjo8L3v0P4jtVYWSwmHH/Swe4iCUP+7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XnG5r6N5vz6L72m;
	Tue, 12 Nov 2024 01:01:04 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
	by mail.maildlp.com (Postfix) with ESMTPS id 12AB6140B3C;
	Tue, 12 Nov 2024 01:01:15 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 18:01:14 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 11 Nov 2024 18:01:14 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Fan Ni <nifan.cxl@gmail.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>, "leo.duran@amd.com"
	<leo.duran@amd.com>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>, "jiaqiyan@google.com"
	<jiaqiyan@google.com>, "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>, "erdemaktas@google.com"
	<erdemaktas@google.com>, "pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>, "gthelen@google.com"
	<gthelen@google.com>, "wschwartz@amperecomputing.com"
	<wschwartz@amperecomputing.com>, "dferguson@amperecomputing.com"
	<dferguson@amperecomputing.com>, "wbs@os.amperecomputing.com"
	<wbs@os.amperecomputing.com>, tanxiaofei <tanxiaofei@huawei.com>, "Zengtao
 (B)" <prime.zeng@hisilicon.com>, "Roberto Sassu" <roberto.sassu@huawei.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, wanghuiqiang
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v15 11/15] EDAC: Add memory repair control feature
Thread-Topic: [PATCH v15 11/15] EDAC: Add memory repair control feature
Thread-Index: AQHbLD8AfemaRx1ca0GejEwzrXB007Ktlc0AgATHjxA=
Date: Mon, 11 Nov 2024 17:01:14 +0000
Message-ID: <c849dc3f43b14d26acc9c920b2247c40@huawei.com>
References: <20241101091735.1465-1-shiju.jose@huawei.com>
 <20241101091735.1465-12-shiju.jose@huawei.com> <Zy5DXjsbsm4cQGaS@fan>
In-Reply-To: <Zy5DXjsbsm4cQGaS@fan>
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
>From: Fan Ni <nifan.cxl@gmail.com>
>Sent: 08 November 2024 16:59
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org; linux-
>acpi@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org;
>bp@alien8.de; tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
>mchehab@kernel.org; dan.j.williams@intel.com; dave@stgolabs.net; Jonathan
>Cameron <jonathan.cameron@huawei.com>; gregkh@linuxfoundation.org;
>sudeep.holla@arm.com; jassisinghbrar@gmail.com; dave.jiang@intel.com;
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
>Subject: Re: [PATCH v15 11/15] EDAC: Add memory repair control feature
>
>On Fri, Nov 01, 2024 at 09:17:29AM +0000, shiju.jose@huawei.com wrote:
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
>> The common memory repair control interface abstracts the control of
>> arbitrary memory repair functionality into a standardized set of functio=
ns.
>> The sysfs memory repair attribute nodes are only available if the
>> client driver has implemented the corresponding attribute callback
>> function and provided operations to the EDAC device driver during
>registration.
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  .../ABI/testing/sysfs-edac-memory-repair      | 168 ++++++++
>>  drivers/edac/Makefile                         |   2 +-
>>  drivers/edac/edac_device.c                    |  32 ++
>>  drivers/edac/mem_repair.c                     | 367 ++++++++++++++++++
>>  include/linux/edac.h                          |  87 +++++
>>  5 files changed, 655 insertions(+), 1 deletion(-)  create mode 100644
>> Documentation/ABI/testing/sysfs-edac-memory-repair
>>  create mode 100755 drivers/edac/mem_repair.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-edac-memory-repair
>> b/Documentation/ABI/testing/sysfs-edac-memory-repair
>> new file mode 100644
>> index 000000000000..393206b8d418
[...]
>>
>> +	if (mem_repair_cnt) {
>> +		ctx->mem_repair =3D kcalloc(mem_repair_cnt, sizeof(*ctx-
>>mem_repair), GFP_KERNEL);
>> +		if (!ctx->mem_repair) {
>> +			ret =3D -ENOMEM;
>> +			goto groups_free;
>
>If the function returns here, we will have a leak from memory pointed by c=
tx-
>>scrub.
Thanks Fan for reporting.=20
Fixed.
>
>Fan
>> +		}
>> +	}
>> +
[...]
>--
>Fan Ni

Thanks,
Shiju

