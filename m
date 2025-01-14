Return-Path: <linux-edac+bounces-2901-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846CBA10963
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 15:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E8D3A1140
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 14:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498F0126F1E;
	Tue, 14 Jan 2025 14:30:59 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A7461FCE;
	Tue, 14 Jan 2025 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865059; cv=none; b=ZGohqcvuNEakV86LFMqfZL5K9QynWgsmhBbqosGqoGzmY6vuBsINhwFQ4IsiymsLe0h0Lsd5IiRS9k72QUbIXsik6y+n9gC7A5ADOZ0Z/+mavwwHm+OCqNtJ4H257SjgmDP4G6LwYtWjUJJld+ESqwxe9tB0P4JWqcNzQjM63+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865059; c=relaxed/simple;
	bh=uYAZYn/4uacT3j9hJKDaqhUHhNG/o0erniEotF+++n0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XezIXIqMPA2K6V/pW7DE7vzoQCPUxq1P0yk8Sbe8MfSlOUje0ECsw3e44hRcSMCmMoEij17Csa5nVqCf44MQMni1Ecbk62wUW2hOYAd+0SZlmwHPgZ4D7jhZTnp5lNZ2cYXehOCwojsfP/MNei5IvGoyO+3rI/2DOMcNshYVjfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YXWjL4tSZz6FHCC;
	Tue, 14 Jan 2025 22:29:26 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
	by mail.maildlp.com (Postfix) with ESMTPS id CBA3014038F;
	Tue, 14 Jan 2025 22:30:53 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 14 Jan 2025 15:30:53 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 14 Jan 2025 15:30:53 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
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
Subject: RE: [PATCH v18 04/19] EDAC: Add memory repair control feature
Thread-Topic: [PATCH v18 04/19] EDAC: Add memory repair control feature
Thread-Index: AQHbYDQgB18e2Mzm30SSjInW5UV51bMWRHQAgAAVmdA=
Date: Tue, 14 Jan 2025 14:30:53 +0000
Message-ID: <7a758dde8f044a0d955413b379179b93@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
	<20250106121017.1620-5-shiju.jose@huawei.com>
 <20250114144712.49cd98f2@foz.lan>
In-Reply-To: <20250114144712.49cd98f2@foz.lan>
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
>From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>Sent: 14 January 2025 13:47
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org; linux-
>acpi@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org;
>bp@alien8.de; tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
>mchehab@kernel.org; dan.j.williams@intel.com; dave@stgolabs.net; Jonathan
>Cameron <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
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
>Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
>
>Em Mon, 6 Jan 2025 12:10:00 +0000
><shiju.jose@huawei.com> escreveu:
>
>> +What:		/sys/bus/edac/devices/<dev-
>name>/mem_repairX/repair_function
>> +Date:		Jan 2025
>> +KernelVersion:	6.14
>> +Contact:	linux-edac@vger.kernel.org
>> +Description:
>> +		(RO) Memory repair function type. For eg. post package repair,
>> +		memory sparing etc.
>> +		EDAC_SOFT_PPR - Soft post package repair
>> +		EDAC_HARD_PPR - Hard post package repair
>> +		EDAC_CACHELINE_MEM_SPARING - Cacheline memory sparing
>> +		EDAC_ROW_MEM_SPARING - Row memory sparing
>> +		EDAC_BANK_MEM_SPARING - Bank memory sparing
>> +		EDAC_RANK_MEM_SPARING - Rank memory sparing
>> +		All other values are reserved.
>> +
>> +What:		/sys/bus/edac/devices/<dev-
>name>/mem_repairX/persist_mode
>> +Date:		Jan 2025
>> +KernelVersion:	6.14
>> +Contact:	linux-edac@vger.kernel.org
>> +Description:
>> +		(RW) Read/Write the current persist repair mode set for a
>> +		repair function. Persist repair modes supported in the
>> +		device, based on the memory repair function is temporary
>> +		or permanent and is lost with a power cycle.
>> +		EDAC_MEM_REPAIR_SOFT - Soft repair function (temporary
>repair).
>> +		EDAC_MEM_REPAIR_HARD - Hard memory repair function
>(permanent repair).
>> +		All other values are reserved.
>> +
>
>After re-reading some things, I suspect that the above can be simplified a=
 little
>bit by folding soft/hard PPR into a single element at /repair_function, an=
d letting
>it clearer that persist_mode is valid only for PPR (I think this is the ca=
se, right?),
>e.g. something like:
persist_mode is valid for memory sparing features(atleast in CXL) as well.
In the case of CXL memory sparing, host has option to request either soft o=
r hard sparing
in a flag when issue a memory sparing operation.

>
>	What:		/sys/bus/edac/devices/<dev-
>name>/mem_repairX/repair_function
>	...
>	Description:
>			(RO) Memory repair function type. For e.g. post
>package repair,
>			memory sparing etc. Valid values are:
>
>			- ppr - post package repair.
>			  Please define its mode via
>			  /sys/bus/edac/devices/<dev-
>name>/mem_repairX/persist_mode
>			- cacheline-sparing - Cacheline memory sparing
>			- row-sparing - Row memory sparing
>			- bank-sparing - Bank memory sparing
>			- rank-sparing - Rank memory sparing
>			- All other values are reserved.
>
>and define persist_mode in a different way:
Note: For return as decoded strings instead of raw value,  I need to add so=
me extra callback function/s
in the edac/memory_repair.c  for these attributes  and which will reduce th=
e current level of optimization done to
minimize the code size.
>
>	What:		/sys/bus/edac/devices/<dev-
>name>/mem_repairX/ppr_persist_mode
Same as above.  persist_mode is needed for memory sparing feature too.
>	...
>	Description:
>		(RW) Read/Write the current persist repair (PPR) mode set for a
>		post package repair function. Persist repair modes supported
>		in the device, based on the memory repair function is
>temporary
>		or permanent and is lost with a power cycle. Valid values are:
>
>		- repair-soft - Soft PPR function (temporary repair).
>		- repair-hard - Hard memory repair function (permanent
>repair).
>		- All other values are reserved.
>
>Thanks,
>Mauro

Thanks,
Shiju


