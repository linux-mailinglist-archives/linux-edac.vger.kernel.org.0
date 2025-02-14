Return-Path: <linux-edac+bounces-3088-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD74A35BC8
	for <lists+linux-edac@lfdr.de>; Fri, 14 Feb 2025 11:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F7E67A36A1
	for <lists+linux-edac@lfdr.de>; Fri, 14 Feb 2025 10:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07B3245002;
	Fri, 14 Feb 2025 10:49:57 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B5815198D;
	Fri, 14 Feb 2025 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739530197; cv=none; b=ElruiMxhMnvBOVZUUPAnP7CD61JqCV7wqYsf9ob4fCyZZKsSMUynPBfeXzZAaIi1TGDsMafnaJt4Dkd7MpZy2RdCHppUfwk9CqiPUm5vBYRiaIeDj0WLcsz5W1EqOAXRPgpVlNwcmOKvTPGknZds+N5m3E2100nngnI3PIj8TlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739530197; c=relaxed/simple;
	bh=nTLGQRv9+Dmv04TXYESDtBUvopxmV+9Gvf73k4K56rs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hJ44cjtWjEu+fgIV1Sko1tKXnldxz96ftCkt1m3twmVBG4/L+2hYeZUpCdWZ6HxV8k5SK5ZE7shGNP0vSZo3+1A1nmd0joyncpe0WOilxCb7bHGTMohX6LbnVVmJYFXCNv8t3VfDD6NMq0Ol8H7DLJlIJJkHD3f24xCyJl05v1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YvTHz4wLdz6L4t9;
	Fri, 14 Feb 2025 18:46:39 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id E1DB31400DA;
	Fri, 14 Feb 2025 18:49:45 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Feb 2025 11:49:45 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 14 Feb 2025 11:49:45 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Fan Ni <nifan.cxl@gmail.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
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
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v20 02/15] EDAC: Add scrub control feature
Thread-Topic: [PATCH v20 02/15] EDAC: Add scrub control feature
Thread-Index: AQHbfVudPqq/NHwN4UqlQ2GJSWClwrNFsryAgADmw2A=
Date: Fri, 14 Feb 2025 10:49:45 +0000
Message-ID: <4bf20362774e4a7cb9387f97f43fff9c@huawei.com>
References: <20250212143654.1893-1-shiju.jose@huawei.com>
 <20250212143654.1893-3-shiju.jose@huawei.com>
 <67ae6587.170a0220.2d3544.9687@mx.google.com>
In-Reply-To: <67ae6587.170a0220.2d3544.9687@mx.google.com>
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
>Sent: 13 February 2025 21:35
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org; linux-
>acpi@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org;
>linux-doc@vger.kernel.org; bp@alien8.de; tony.luck@intel.com;
>rafael@kernel.org; lenb@kernel.org; mchehab@kernel.org;
>dan.j.williams@intel.com; dave@stgolabs.net; Jonathan Cameron
><jonathan.cameron@huawei.com>; dave.jiang@intel.com;
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
>Subject: Re: [PATCH v20 02/15] EDAC: Add scrub control feature
>
>On Wed, Feb 12, 2025 at 02:36:40PM +0000, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add a generic EDAC scrub control to manage memory scrubbers in the syste=
m.
>> Devices with a scrub feature register with the EDAC device driver,
>> which retrieves the scrub descriptor from the EDAC scrub driver and
>> exposes the sysfs scrub control attributes for a scrub instance to
>> userspace at /sys/bus/edac/devices/<dev-name>/scrubX/.
>>
>> The common sysfs scrub control interface abstracts the control of
>> arbitrary scrubbing functionality into a common set of functions. The
>> sysfs scrub attribute nodes are only present if the client driver has
>> implemented the corresponding attribute callback function and passed
>> the
>> operations(ops) to the EDAC device driver during registration.
>>
>> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  Documentation/ABI/testing/sysfs-edac-scrub |  69 ++++++
>>  Documentation/edac/features.rst            |   6 +
>>  Documentation/edac/index.rst               |   1 +
>>  Documentation/edac/scrub.rst               | 259 +++++++++++++++++++++
>>  drivers/edac/Kconfig                       |   9 +
>>  drivers/edac/Makefile                      |   2 +
>>  drivers/edac/edac_device.c                 |  41 +++-
>>  drivers/edac/scrub.c                       | 209 +++++++++++++++++
>>  include/linux/edac.h                       |  43 ++++
>>  9 files changed, 635 insertions(+), 4 deletions(-)  create mode
>> 100644 Documentation/ABI/testing/sysfs-edac-scrub
>>  create mode 100644 Documentation/edac/scrub.rst  create mode 100755
>> drivers/edac/scrub.c
>
>LGTM.
>
>Just one question, for min/max/current_cycle_duration attributes, is there=
 a
>reason why seconds are used instead of hours directly as mentioned in the =
spec.
>That confused me a little bit when I tested to modify the current_cycle_du=
ration
>with some value not multiple of 3600 and found the value read back is not =
the
>same as that just written.
>
Hi Fan,

Thanks for reviewing and testing.
The unit for the scrub cycle attributes has been chosen as a small unit, se=
conds,=20
since the EDAC scrub interface is a common interface and the unit may vary =
across=20
various hardware scrub interfaces.
In the CXL scrub control feature, the scrub cycle is represented in hours. =
Therefore,=20
the scrub cycle is internally converted to hours, and the rounded value in =
hours,=20
which is set in the device, is returned when read back.

>With that in mind,=09
>
>Tested-by: Fan Ni <fan.ni@samsung.com>
>
>
>>
[...]
>> --
>> 2.43.0
>>

Thanks,
Shiju

