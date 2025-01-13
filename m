Return-Path: <linux-edac+bounces-2886-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8E2A0BFA0
	for <lists+linux-edac@lfdr.de>; Mon, 13 Jan 2025 19:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 262027A26C9
	for <lists+linux-edac@lfdr.de>; Mon, 13 Jan 2025 18:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EBB1C3BEE;
	Mon, 13 Jan 2025 18:15:08 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87BE1C3034;
	Mon, 13 Jan 2025 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736792108; cv=none; b=BFcEc1m8zirRv4xGWk5KtWc31XZCgPM3yDMsiRwglnve14Co4wqPMHcJXOwaFEcFvnWPpK1XthZPLR0ppw8bScMmiMo3E5Ubg8GgPpfBSrKWacU3GIPBNfDArze18kN1WEmBgm3x3pPaFXU3w2bmUePE8Uv9DE4CwFYi32C9FCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736792108; c=relaxed/simple;
	bh=3a7aQCNgxJLyNn4xxJhJmMGMNQ/RacK21AbaEj6SLv4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G/hmZH+iQ0zAta11kyCaRWRepRpUGjy5ORuzkMFXEcB8ZVKMV6NTLMJVddGxU42LQ14DxI/DNBTgmm6HprICRBNi3N9xSRD9rN7lD1wwWoYdN3OKN/8ZK6novtzHT5rgulrpQee6ehv1XAw/cqV91KHIDV95Fr4SkYAzpCcCtMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YX0fW4f0bz6K5lh;
	Tue, 14 Jan 2025 02:10:11 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
	by mail.maildlp.com (Postfix) with ESMTPS id BB13C140B38;
	Tue, 14 Jan 2025 02:15:01 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 13 Jan 2025 19:15:01 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 13 Jan 2025 19:15:01 +0100
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
Subject: RE: [PATCH v18 00/19] EDAC: Scrub: introduce generic EDAC RAS control
 feature driver + CXL/ACPI-RAS2 drivers
Thread-Topic: [PATCH v18 00/19] EDAC: Scrub: introduce generic EDAC RAS
 control feature driver + CXL/ACPI-RAS2 drivers
Thread-Index: AQHbYDQZq6uipUr1qkCeE+MAaYkJNbMUwrUAgAAtBCA=
Date: Mon, 13 Jan 2025 18:15:01 +0000
Message-ID: <1bf421f9d1924d68860d08c70829a705@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
 <20250113154634.4e831d66@foz.lan>
In-Reply-To: <20250113154634.4e831d66@foz.lan>
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
>Sent: 13 January 2025 14:47
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
>Subject: Re: [PATCH v18 00/19] EDAC: Scrub: introduce generic EDAC RAS
>control feature driver + CXL/ACPI-RAS2 drivers
>
>Em Mon, 6 Jan 2025 12:09:56 +0000
><shiju.jose@huawei.com> escreveu:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Previously known as "ras: scrub: introduce subsystem + CXL/ACPI-RAS2
>drivers".
>>
>> Augmenting EDAC for controlling RAS features
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> The proposed expansion of EDAC for controlling RAS features and
>> exposing features control attributes to userspace in sysfs.
>> Some Examples:
>>  - Scrub control
>>  - Error Check Scrub (ECS) control
>>  - ACPI RAS2 features
>>  - Post Package Repair (PPR) control
>>  - Memory Sparing Repair control etc.
>>
>> High level design is illustrated in the following diagram.
>>
>>          _______________________________________________
>>         |   Userspace - Rasdaemon                       |
>>         |  ____________                                 |
>>         | | RAS CXL    |       _______________          |
>>         | | Err Handler|----->|               |         |
>>         | |____________|      | RAS Dynamic   |         |
>>         |  ____________       | Scrub, Memory |         |
>>         | | RAS Memory |----->| Repair Control|         |
>>         | | Err Handler|      |_______________|         |
>>         | |____________|           |                    |
>>         |__________________________|____________________|
>>                                    |
>>                                    |
>>     _______________________________|______________________________
>>    |   Kernel EDAC based SubSystem | for RAS Features Control     |
>>    | ______________________________|____________________________  |
>>    || EDAC Core          Sysfs EDAC| Bus                        | |
>>    ||    __________________________|________ _    _____________ | |
>>    ||   |/sys/bus/edac/devices/<dev>/scrubX/ |   | EDAC Device || |
>>    ||   |/sys/bus/edac/devices/<dev>/ecsX/   |<->| EDAC MC     || |
>>    ||   |/sys/bus/edac/devices/<dev>/repairX |   | EDAC Sysfs  || |
>>    ||   |____________________________________|   |_____________|| |
>>    ||                               | EDAC Bus                  | |
>>    ||               Get             |       Get                 | |
>>    ||    __________ Features       |   Features __________    | |
>
>NIT: there is a misalignment here.
Hi Mauro,

Thanks for the comments.
Will fix.

>
>>    ||   |          |Descs  _________|______ Descs|          |   | |
>>    ||   |EDAC Scrub|<-----| EDAC Device    |     | EDAC Mem |   | |
>>    ||   |__________|      | Driver- RAS    |---->| Repair   |   | |
>>    ||    __________       | Feature Control|     |__________|   | |
>>    ||   |          |<-----|________________|                    | |
>>    ||   |EDAC ECS  |   Register RAS | Features                  | |
>>    ||   |__________|                |                           | |
>>    ||         ______________________|_________                  | |
>>    ||_________|_____________|________________|__________________| |
>>    |   _______|____    _____|_________   ____|_________           |
>>    |  |            |  | CXL Mem Driver| | Client Driver|          |
>>    |  | ACPI RAS2  |  | Sparing, PPR, | | Mem Repair   |          |
>>    |  | Driver     |  | Scrub, ECS    | | Features     |          |
>>    |  |____________|  |_______________| |______________|          |
>>    |        |              |              |                       |
>>
>|________|______________|______________|_______________________|
>>             |              |              |
>>      _______|______________|______________|_______________________
>>     |     __|______________|_ ____________|____________ ____      |
>>     |    |                                                  |     |
>>     |    |            Platform HW and Firmware              |     |
>>     |    |__________________________________________________|     |
>>
>|_____________________________________________________________|
>>
>> 1. EDAC RAS Features components - Create feature specific descriptors.
>>    for example, EDAC scrub, EDAC ECS, EDAC memory repair in the above
>>    diagram.
>> 2. EDAC device driver for controlling RAS Features - Get feature's attr
>>    descriptors from EDAC RAS feature component and registers device's
>>    RAS features with EDAC bus and expose the feature's sysfs attributes
>>    under the sysfs EDAC bus.
>> 3. RAS dynamic scrub controller - Userspace sample module added for scru=
b
>>    control in rasdaemon to issue scrubbing when excess number of memory
>>    errors are reported in a short span of time.
>>
>> The added EDAC feature specific components (e.g. EDAC scrub, EDAC ECS,
>> EDAC memory repair etc) do callbacks to  the parent driver (e.g. CXL
>> driver, ACPI RAS driver etc) for the controls rather than just letting
>> the caller deal with it because of the following reasons.
>> 1. Enforces a common API across multiple implementations can do that
>>    via review, but that's not generally gone well in the long run for
>>    subsystems that have done it (several have later moved to callback
>>    and feature list based approaches).
>> 2. Gives a path for 'intercepting' in the EDAC feature driver.
>>    An example for this is that we could intercept PPR repair calls
>>    and sanity check that the memory in question is offline before
>>    passing back to the underlying code.  Sure we could rely on doing
>>    that via some additional calls from the parent driver, but the
>>    ABI will get messier.
>> 3. (Speculative) we may get in kernel users of some features in the
>>    long run.
>>
>> More details of the common RAS features are described in the following
>> sections.
>>
>> Memory Scrubbing
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Increasing DRAM size and cost has made memory subsystem reliability an
>> important concern. These modules are used where potentially corrupted
>> data could cause expensive or fatal issues. Memory errors are one of
>> the top hardware failures that cause server and workload crashes.
>>
>> Memory scrub is a feature where an ECC engine reads data from each
>> memory media location, corrects with an ECC if necessary and writes
>> the corrected data back to the same memory media location.
>>
>> The memory DIMMs could be scrubbed at a configurable rate to detect
>> uncorrected memory errors and attempts to recover from detected memory
>> errors providing the following benefits.
>> - Proactively scrubbing memory DIMMs reduces the chance of a correctable
>>   error becoming uncorrectable.
>> - Once detected, uncorrected errors caught in unallocated memory pages a=
re
>>   isolated and prevented from being allocated to an application or the O=
S.
>> - The probability of software/hardware products encountering memory
>>   errors is reduced.
>> Some details of background can be found in Reference [5].
>>
>> There are 2 types of memory scrubbing, 1. Background (patrol)
>> scrubbing of the RAM whilst the RAM is otherwise
>>    idle.
>> 2. On-demand scrubbing for a specific address range/region of memory.
>>
>> There are several types of interfaces to HW memory scrubbers
>> identified such as ACPI NVDIMM ARS(Address Range Scrub), CXL memory
>> device patrol scrub, CXL DDR5 ECS, ACPI RAS2 memory scrubbing.
>>
>> The scrub control varies between different memory scrubbers. To allow
>> for standard userspace tooling there is a need to present these
>> controls with a standard ABI.
>>
>> Introduce generic memory EDAC scrub control which allows user to
>> control underlying scrubbers in the system via generic sysfs scrub
>> control interface. The common sysfs scrub control interface abstracts
>> the control of an arbitrary scrubbing functionality to a common set of
>functions.
>>
>> Use case of common scrub control feature
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> 1. There are several types of interfaces to HW memory scrubbers identifi=
ed
>>    such as ACPI NVDIMM ARS(Address Range Scrub), CXL memory device patro=
l
>>    scrub, CXL DDR5 ECS, ACPI RAS2 memory scrubbing features and software
>>    based memory scrubber(discussed in the community Reference [5]).
>>    Also some scrubbers support controlling (background) patrol scrubbing
>>    (ACPI RAS2, CXL) and/or on-demand scrubbing(ACPI RAS2, ACPI ARS).
>>    However the scrub controls varies between memory scrubbers. Thus ther=
e
>>    is a requirement for a standard generic sysfs scrub controls exposed
>>    to userspace for the seamless control of the HW/SW scrubbers in
>>    the system by admin/scripts/tools etc.
>> 2. Scrub controls in user space allow the user to disable the scrubbing
>>    in case disabling of the background patrol scrubbing or changing the
>>    scrub rate are needed for other purposes such as performance-aware
>>    operations which requires the background operations to be turned off
>>    or reduced.
>> 3. Allows to perform on-demand scrubbing for specific address range if
>>    supported by the scrubber.
>> 4. User space tools controls scrub the memory DIMMs regularly at a
>>    configurable scrub rate using the sysfs scrub controls discussed help=
,
>>    - to detect uncorrectable memory errors early before user accessing
>memory,
>>      which helps to recover the detected memory errors.
>>    - reduces the chance of a correctable error becoming uncorrectable.
>> 5. Policy control for hotplugged memory. There is not necessarily a syst=
em
>>    wide bios or similar in the loop to control the scrub settings on a C=
XL
>>    device that wasn't there at boot. What that setting should be is a po=
licy
>>    decision as we are trading of reliability vs performance - hence it s=
hould
>>    be in control of userspace. As such, 'an' interface is needed. Seems =
more
>>    sensible to try and unify it with other similar interfaces than spin
>>    yet another one.
>>
>> The draft version of userspace code added in rasdaemon for dynamic
>> scrub control, based on frequency of memory errors reported to
>> userspace, tested for CXL device based patrol scrubbing feature and
>> ACPI RAS2 based scrubbing feature.
>>
>> https://github.com/shijujose4/rasdaemon/tree/ras_feature_control
>>
>> ToDO: For memory repair features, such as PPR, memory sparing,
>> rasdaemon collates records and decides to replace a row if there are
>> lots of corrected errors, or a single uncorrected error or error
>> record received with maintenance request flag set as in some CXL event
>records.
>>
>> Comparison of scrubbing features
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>  ................................................................
>>  .              .   ACPI    . CXL patrol.  CXL ECS  .  ARS      .
>>  .  Name        .   RAS2    . scrub     .           .           .
>>  ................................................................
>>  .              .           .           .           .           .
>>  . On-demand    . Supported . No        . No        . Supported .
>>  . Scrubbing    .           .           .           .           .
>>  .              .           .           .           .           .
>>  ................................................................
>>  .              .           .           .           .           .
>>  . Background   . Supported . Supported . Supported . No        .
>>  . scrubbing    .           .           .           .           .
>>  .              .           .           .           .           .
>>  ................................................................
>>  .              .           .           .           .           .
>>  . Mode of      . Scrub ctrl. per device. per memory.  Unknown  .
>>  . scrubbing    . per NUMA  .           . media     .           .
>>  .              . domain.   .           .           .           .
>>  ................................................................
>>  .              .           .           .           .           .
>>  . Query scrub  . Supported . Supported . Supported . Supported .
>>  . capabilities .           .           .           .           .
>>  .              .           .           .           .           .
>>  ................................................................
>>  .              .           .           .           .           .
>>  . Setting      . Supported . No        . No        . Supported .
>>  . address range.           .           .           .           .
>>  .              .           .           .           .           .
>>  ................................................................
>>  .              .           .           .           .           .
>>  . Setting      . Supported . Supported . No        . No        .
>>  . scrub rate   .           .           .           .           .
>>  .              .           .           .           .           .
>>  ................................................................
>>  .              .           .           .           .           .
>>  . Unit for     . Not       . in hours  . No        . No        .
>>  . scrub rate   . Defined   .           .           .           .
>>  .              .           .           .           .           .
>>  ................................................................
>>  .              . Supported .           .           .           .
>>  . Scrub        . on-demand . No        . No        . Supported .
>>  . status/      . scrubbing .           .           .           .
>>  . Completion   . only      .           .           .           .
>>  ................................................................
>>  . UC error     .           .CXL general.CXL general. ACPI UCE  .
>>  . reporting    . Exception .media/DRAM .media/DRAM . notify and.
>>  .              .           .event/media.event/media. query     .
>>  .              .           .scan?      .scan?      . ARS status.
>>  ................................................................
>>  .              .           .           .           .           .
>>  . Clear UC     .  No       . No        .  No       . Supported .
>>  . error        .           .           .           .           .
>>  .              .           .           .           .           .
>>  ................................................................
>>  .              .           .           .           .           .
>>  . Translate    . No        . No        . No        . Supported .
>>  . *(1)SPA to   .           .           .           .           .
>>  . *(2)DPA      .           .           .           .           .
>>  ................................................................
>>
>> *(1) - SPA - System Physical Address. See section 9.19.7.8
>>        Function Index 5 - Translate SPA of ACPI spec r6.5.
>> *(2) - DPA - Device Physical Address. See section 9.19.7.8
>>        Function Index 5 - Translate SPA of ACPI spec r6.5.
>
>NIT: this table contains terms that are defined only at the text below. Th=
e text
>describing, for instance, ARS, needs to come before the table.=20
Sure. Can be done.

>IMO, it needs to
>contain ReST links to the texts defining what each line/row contains (see =
below
>about ReST).
Not sure about ReST links.
>
>>
>> CXL Memory Scrubbing features
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> CXL spec r3.1 section 8.2.9.9.11.1 describes the memory device patrol
>> scrub control feature. The device patrol scrub proactively locates and
>> makes corrections to errors in regular cycle. The patrol scrub control
>> allows the request to configure patrol scrubber's input configurations.
>>
>> The patrol scrub control allows the requester to specify the number of
>> hours in which the patrol scrub cycles must be completed, provided
>> that the requested number is not less than the minimum number of hours
>> for the patrol scrub cycle that the device is capable of. In addition,
>> the patrol scrub controls allow the host to disable and enable the
>> feature in case disabling of the feature is needed for other purposes
>> such as performance-aware operations which require the background
>> operations to be turned off.
>>
>> The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
>> Specification (JESD79-5) and allows the DRAM to internally read,
>> correct single-bit errors, and write back corrected data bits to the
>> DRAM array while providing transparency to error counts.
>>
>> The DDR5 device contains number of memory media FRUs per device. The
>> DDR5 ECS feature and thus the ECS control driver supports configuring
>> the ECS parameters per FRU.
>>
>> ACPI RAS2 Hardware-based Memory Scrubbing
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> ACPI spec 6.5 section 5.2.21 ACPI RAS2 describes ACPI RAS2 table
>> provides interfaces for platform RAS features and supports independent
>> RAS controls and capabilities for a given RAS feature for multiple
>> instances of the same component in a given system.
>> Memory RAS features apply to RAS capabilities, controls and operations
>> that are specific to memory. RAS2 PCC sub-spaces for memory-specific
>> RAS features have a Feature Type of 0x00 (Memory).
>>
>> The platform can use the hardware-based memory scrubbing feature to
>> expose controls and capabilities associated with hardware-based memory
>> scrub engines. The RAS2 memory scrubbing feature supports following as
>> per spec,
>>  - Independent memory scrubbing controls for each NUMA domain, identifie=
d
>>    using its proximity domain.
>>    Note: However AmpereComputing has single entry repeated as they have
>>          centralized controls.
>>  - Provision for background (patrol) scrubbing of the entire memory syst=
em,
>>    as well as on-demand scrubbing for a specific region of memory.
>>
>> ACPI Address Range Scrubbing(ARS)
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> ARS allows the platform to communicate memory errors to system software.
>> This capability allows system software to prevent accesses to
>> addresses with uncorrectable errors in memory. ARS functions manage
>> all NVDIMMs present in the system. Only one scrub can be in progress
>> system wide at any given time.
>> Following functions are supported as per the specification.
>> 1. Query ARS Capabilities for a given address range, indicates platform
>>    supports the ACPI NVDIMM Root Device Unconsumed Error Notification.
>> 2. Start ARS triggers an Address Range Scrub for the given memory range.
>>    Address scrubbing can be done for volatile memory, persistent memory,
>>    or both.
>> 3. Query ARS Status command allows software to get the status of ARS,
>>    including the progress of ARS and ARS error record.
>> 4. Clear Uncorrectable Error.
>> 5. Translate SPA
>> 6. ARS Error Inject etc.
>> Note: Support for ARS is not added in this series because to reduce
>> the line of code for review and could be added after initial code is mer=
ged.
>> We'd like feedback on whether this is of interest to ARS community?
>>
>> Post Package Repair(PPR)
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> PPR (Post Package Repair) maintenance operation requests the memory
>> device to perform a repair operation on its media if supported. A
>> memory device may support two types of PPR: Hard PPR (hPPR), for a
>> permanent row repair, and Soft PPR (sPPR), for a temporary row repair.
>> sPPR is much faster than hPPR, but the repair is lost with a power
>> cycle. During the execution of a PPR maintenance operation, a memory
>> device, may or may not retain data and may or may not be able to
>> process memory requests correctly. sPPR maintenance operation may be
>> executed at runtime, if data is retained and memory requests are
>> correctly processed. hPPR maintenance operation may be executed only at
>boot because data would not be retained.
>>
>> Use cases of common PPR control feature
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> 1. The Soft PPR (sPPR) and Hard PPR (hPPR) share similar control
>> interfaces, thus there is a requirement for a standard generic sysfs
>> PPR controls exposed to userspace for the seamless control of the PPR
>> features in the system by the admin/scripts/tools etc.
>> 2. When a CXL device identifies a failure on a memory component, the
>> device may inform the host about the need for a PPR maintenance
>> operation by using an event record, where the maintenance needed flag
>> is set. The event record specifies the DPA that should be repaired.
>> Kernel reports the corresponding cxl general media or DRAM trace event
>> to userspace. The userspace tool, for reg. rasdaemon initiate a PPR
>> maintenance operation in response to a device request using the sysfs PP=
R
>control.
>> 3. User space tools, for eg. rasdaemon, do request PPR on a memory
>> region when uncorrected memory error or excess corrected memory errors
>> reported on that memory.
>> 4. Likely multiple instances of PPR present per memory device.
>>
>> Memory Sparing
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Memory sparing is defined as a repair function that replaces a portion
>> of memory with a portion of functional memory at that same DPA. User
>> space tool, e.g. rasdaemon, may request the sparing operation for a
>> given address for which the uncorrectable error is reported. In CXL,
>> (CXL spec 3.1 section 8.2.9.7.1.4) subclasses for sparing operation
>> vary in terms of the scope of the sparing being performed. The
>> cacheline sparing subclass refers to a sparing action that can replace a=
 full
>cacheline.
>> Row sparing is provided as an alternative to PPR sparing functions and
>> its scope is that of a single DDR row. Bank sparing allows an entire
>> bank to be replaced. Rank sparing is defined as an operation in which
>> an entire DDR rank is replaced.
>>
>> Series adds,
>> 1. EDAC device driver extended for controlling RAS features, EDAC scrub
>>    driver, EDAC ECS driver, EDAC memory repair driver supports memory
>>    scrub control, ECS control, memory repair(PPR, sparing) control
>>    respectively.
>> 2. Several common patches from Dave's cxl/fwctl series.
>> 3. Support for CXL feature mailbox commands, which is used by CXL device
>>    scrubbing and memory repair features.
>> 4. CXL features driver supporting patrol scrub control (device and
>>    region based).
>>
>> 5. CXL features driver supporting ECS control feature.
>> 6. ACPI RAS2 driver adds OS interface for RAS2 communication through
>>    PCC mailbox and extracts ACPI RAS2 feature table (RAS2) and
>>    create platform device for the RAS memory features, which binds
>>    to the memory ACPI RAS2 driver.
>> 7. Memory ACPI RAS2 driver gets the PCC subspace for communicating
>>    with the ACPI compliant platform supports ACPI RAS2. Add callback
>>    functions and registers with EDAC device to support user to
>>    control the HW patrol scrubbers exposed to the kernel via the
>>    ACPI RAS2 table.
>> 8. Support for CXL maintenance mailbox command, which is used by
>>    CXL device memory repair feature.
>> 9. CXL features driver supporting PPR control feature.
>> 10. CXL features driver supporting memory sparing control feature.
>>     Note: There are other PPR, memory sparing drivers to come.
>
>The text above should be inside Documentation, and not on patch 0.
The description for  EDAC device features control and for each features
were added in the Documentation under corresponding patches.
=20
>
>A big description like that makes hard to review this series. It is also e=
asier to
>review the text after having it parsed by kernel doc build specially for s=
ummary
>tables like the "Comparison of scrubbing features", which deserves ReST li=
nks
>processed by Sphinx to the corresponding definitions of the terms that are=
 be
>compared there.
Same as above.
>
>> Open Questions based on feedbacks from the community:
>> 1. Leo: Standardize unit for scrub rate, for example ACPI RAS2 does not =
define
>>    unit for the scrub rate. RAS2 clarification needed.
>
>I noticed the same when reviewing a patch series for rasdaemon. Ideally, A=
CPI
>requires an errata defining what units are expected for scrub rate.
>
>While ACPI doesn't define it, better to not add support for it - or be con=
servative
>using a low granularity for it (like using minutes instead of hours).
>
Jonathan already replied.
>> 2. Jonathan:
 [...]
>
>Thanks,
>Mauro

Thanks,
Shiju

