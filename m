Return-Path: <linux-edac+bounces-2951-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AA5A1D645
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jan 2025 13:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96E0C7A2C82
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jan 2025 12:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852081FF1D9;
	Mon, 27 Jan 2025 12:53:24 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7921FF1B3;
	Mon, 27 Jan 2025 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737982404; cv=none; b=nIZ+Nu37WcVVeRFQmNjeIfUAlPCXjUZO3btw3EcXgE5j6XZM49u/WXa5+bDgE6jv88ftILtrUwTElUkpFdy2dFNly3KN1T5iSMJkT3db+4VhvVEqflNrDHmU2ERfi9NS2miLfQkqtGfhFySXku7dRW89GyeIpE5UiDNhDPQpwoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737982404; c=relaxed/simple;
	bh=R9+1TqlaxJbHcrIp5UR4X8Z4FXOptcuh/x1qwAitdWA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d9IwyinZXXeko4zzO4GTgOvQczawMW/m7UmIiEfX1/RjiQa8EzdiwfV4n1aleGvuhWexjY+UNeUBBLG73vdBMHxATh61czHetvZA1v2jjZz7NuIAgucQp6QsKLz/J0NsaG4oyAshPZf8m5afHIWfR05W+36cKVyIC9CdS0BnOzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YhSvw0Tndz6L51Q;
	Mon, 27 Jan 2025 20:51:08 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 533D31401F3;
	Mon, 27 Jan 2025 20:53:17 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 Jan 2025 13:53:17 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 27 Jan 2025 13:53:17 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "bp@alien8.de" <bp@alien8.de>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "dave@stgolabs.net" <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
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
Subject: RE: [PATCH v18 15/19] cxl/memfeature: Add CXL memory device patrol
 scrub control feature
Thread-Topic: [PATCH v18 15/19] cxl/memfeature: Add CXL memory device patrol
 scrub control feature
Thread-Index: AQHbYDQzwb2+msEnKkOZzkWMDvDlzLMmbr6AgAQZmTA=
Date: Mon, 27 Jan 2025 12:53:16 +0000
Message-ID: <637fa0190fe64594954ee4d9e012c39c@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
 <20250106121017.1620-16-shiju.jose@huawei.com>
 <6793fa5351fc7_20f3294d0@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <6793fa5351fc7_20f3294d0@dwillia2-xfh.jf.intel.com.notmuch>
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

Hi Dan,

Thanks for the comments.

Please find reply inline.

Thanks,
Shiju
>-----Original Message-----
>From: Dan Williams <dan.j.williams@intel.com>
>Sent: 24 January 2025 20:39
>To: Shiju Jose <shiju.jose@huawei.com>; linux-edac@vger.kernel.org; linux-
>cxl@vger.kernel.org; linux-acpi@vger.kernel.org; linux-mm@kvack.org; linux=
-
>kernel@vger.kernel.org
>Cc: bp@alien8.de; tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
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
><linuxarm@huawei.com>; Shiju Jose <shiju.jose@huawei.com>
>Subject: Re: [PATCH v18 15/19] cxl/memfeature: Add CXL memory device patro=
l
>scrub control feature
>
>shiju.jose@ wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub
>> control feature. The device patrol scrub proactively locates and makes
>> corrections to errors in regular cycle.
>>
>> Allow specifying the number of hours within which the patrol scrub
>> must be completed, subject to minimum and maximum limits reported by the
>device.
>> Also allow disabling scrub allowing trade-off error rates against
>> performance.
>>
>> Add support for patrol scrub control on CXL memory devices.
>> Register with the EDAC device driver, which retrieves the scrub
>> attribute descriptors from EDAC scrub and exposes the sysfs scrub
>> control attributes to userspace. For example, scrub control for the
>> CXL memory device "cxl_mem0" is exposed in
>/sys/bus/edac/devices/cxl_mem0/scrubX/.
>>
>> Additionally, add support for region-based CXL memory patrol scrub contr=
ol.
>> CXL memory regions may be interleaved across one or more CXL memory
>> devices. For example, region-based scrub control for "cxl_region1" is
>> exposed in /sys/bus/edac/devices/cxl_region1/scrubX/.
>>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  Documentation/edac/scrub.rst  |  66 ++++++
>>  drivers/cxl/Kconfig           |  17 ++
>>  drivers/cxl/core/Makefile     |   1 +
>>  drivers/cxl/core/memfeature.c | 392
>++++++++++++++++++++++++++++++++++
>>  drivers/cxl/core/region.c     |   6 +
>>  drivers/cxl/cxlmem.h          |   7 +
>>  drivers/cxl/mem.c             |   5 +
>>  include/cxl/features.h        |  16 ++
>>  8 files changed, 510 insertions(+)
>>  create mode 100644 drivers/cxl/core/memfeature.c diff --git
>> a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst index
>> f86645c7f0af..80e986c57885 100644
>> --- a/Documentation/edac/scrub.rst
>> +++ b/Documentation/edac/scrub.rst
>> @@ -325,3 +325,69 @@ root@localhost:~# cat
>> /sys/bus/edac/devices/acpi_ras_mem0/scrub0/current_cycle_d
>>  10800
>>
>>  root@localhost:~# echo 0 >
>> /sys/bus/edac/devices/acpi_ras_mem0/scrub0/enable_background
>> +
>> +2. CXL memory device patrol scrubber
>> +
>> +2.1 Device based scrubbing
>> +
>> +root@localhost:~# cat
>> +/sys/bus/edac/devices/cxl_mem0/scrub0/min_cycle_duration
>> +
>> +3600
>> +
>> +root@localhost:~# cat
>> +/sys/bus/edac/devices/cxl_mem0/scrub0/max_cycle_duration
>> +
>> +918000
>> +
>> +root@localhost:~# cat
>> +/sys/bus/edac/devices/cxl_mem0/scrub0/current_cycle_duration
>> +
>> +43200
>> +
>> +root@localhost:~# echo 54000 >
>> +/sys/bus/edac/devices/cxl_mem0/scrub0/current_cycle_duration
>> +
>> +root@localhost:~# cat
>> +/sys/bus/edac/devices/cxl_mem0/scrub0/current_cycle_duration
>> +
>> +54000
>> +
>> +root@localhost:~# echo 1 >
>> +/sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
>> +
>> +root@localhost:~# cat
>> +/sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
>> +
>> +1
>> +
>> +root@localhost:~# echo 0 >
>> +/sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
>> +
>> +root@localhost:~# cat
>> +/sys/bus/edac/devices/cxl_mem0/scrub0/enable_background
>> +
>> +0
>> +
>> +2.2. Region based scrubbing
>> +
>> +root@localhost:~# cat
>> +/sys/bus/edac/devices/cxl_region0/scrub0/min_cycle_duration
>> +
>> +3600
>> +
>> +root@localhost:~# cat
>> +/sys/bus/edac/devices/cxl_region0/scrub0/max_cycle_duration
>> +
>> +918000
>> +
>> +root@localhost:~# cat
>> +/sys/bus/edac/devices/cxl_region0/scrub0/current_cycle_duration
>> +
>> +43200
>> +
>> +root@localhost:~# echo 54000 >
>> +/sys/bus/edac/devices/cxl_region0/scrub0/current_cycle_duration
>> +
>> +root@localhost:~# cat
>> +/sys/bus/edac/devices/cxl_region0/scrub0/current_cycle_duration
>> +
>> +54000
>> +
>> +root@localhost:~# echo 1 >
>> +/sys/bus/edac/devices/cxl_region0/scrub0/enable_background
>> +
>> +root@localhost:~# cat
>> +/sys/bus/edac/devices/cxl_region0/scrub0/enable_background
>> +
>> +1
>> +
>> +root@localhost:~# echo 0 >
>> +/sys/bus/edac/devices/cxl_region0/scrub0/enable_background
>> +
>> +root@localhost:~# cat
>> +/sys/bus/edac/devices/cxl_region0/scrub0/enable_background
>
>What is this content-free blob of cat and echo statements? Please write ac=
tual
>documentation with theory of operation, clarification of assumptions, rati=
onale
>for defaults, guidance on changing defaults...

Jonathan already replied.

>
>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig index
>> 0bc6a2cb8474..6078f02e883b 100644
>> --- a/drivers/cxl/Kconfig
>> +++ b/drivers/cxl/Kconfig
>> @@ -154,4 +154,21 @@ config CXL_FEATURES
>>
>>  	  If unsure say 'y'.
>>
>> +config CXL_RAS_FEATURES
>> +	tristate "CXL: Memory RAS features"
>> +	depends on CXL_PCI
>
>What is the build dependency on CXL_PCI? This enabling does not call back =
into
>symbols provided by cxl_pci.ko does it?
Will remove, which is not required.  Initially cxl_mem_ras_features_init() =
was called from the pci.c

>
>> +	depends on CXL_MEM
>
>Similar comment, and this also goes away if all of this just moves into th=
e new
>cxl_features driver.

Agree with  Jonathan told in reply. These are RAS specific features for CXL=
 memory devices and
thus added in memfeature.c =20
>
>> +	depends on EDAC
>> +	help
>> +	  The CXL memory RAS feature control is optional and allows host to
>> +	  control the RAS features configurations of CXL Type 3 devices.
>> +
>> +	  It registers with the EDAC device subsystem to expose control
>> +	  attributes of CXL memory device's RAS features to the user.
>> +	  It provides interface functions to support configuring the CXL
>> +	  memory device's RAS features.
>> +	  Say 'y/m/n' to enable/disable control of the CXL.mem device's RAS
>features.
>> +	  See section 8.2.9.9.11 of CXL 3.1 specification for the detailed
>> +	  information of CXL memory device features.
>
>Usually the "say X" statement provides a rationale like.
>
>"Say y/m if you have an expert need to change default memory scrub rates
>established by the platform/device, otherwise say n"

Will change.

>
>> +
>>  endif
>> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
>> index 73b6348afd67..54baca513ecb 100644
>> --- a/drivers/cxl/core/Makefile
>> +++ b/drivers/cxl/core/Makefile
>> @@ -17,3 +17,4 @@ cxl_core-y +=3D cdat.o  cxl_core-y +=3D features.o
>>  cxl_core-$(CONFIG_TRACING) +=3D trace.o
>>  cxl_core-$(CONFIG_CXL_REGION) +=3D region.o
>> +cxl_core-$(CONFIG_CXL_RAS_FEATURES) +=3D memfeature.o
>> diff --git a/drivers/cxl/core/memfeature.c
>> b/drivers/cxl/core/memfeature.c new file mode 100644 index
>> 000000000000..77d1bf6ce45f
>> --- /dev/null
>> +++ b/drivers/cxl/core/memfeature.c
>> @@ -0,0 +1,392 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * CXL memory RAS feature driver.
>> + *
>> + * Copyright (c) 2024 HiSilicon Limited.
>> + *
>> + *  - Supports functions to configure RAS features of the
>> + *    CXL memory devices.
>> + *  - Registers with the EDAC device subsystem driver to expose
>> + *    the features sysfs attributes to the user for configuring
>> + *    CXL memory RAS feature.
>> + */
>> +
>> +#include <linux/cleanup.h>
>> +#include <linux/edac.h>
>> +#include <linux/limits.h>
>> +#include <cxl/features.h>
>> +#include <cxl.h>
>> +#include <cxlmem.h>
>> +
>> +#define CXL_DEV_NUM_RAS_FEATURES	1
>> +#define CXL_DEV_HOUR_IN_SECS	3600
>> +
>> +#define CXL_DEV_NAME_LEN	128
>> +
>> +/* CXL memory patrol scrub control functions */ struct
>> +cxl_patrol_scrub_context {
>> +	u8 instance;
>> +	u16 get_feat_size;
>> +	u16 set_feat_size;
>> +	u8 get_version;
>> +	u8 set_version;
>> +	u16 effects;
>> +	struct cxl_memdev *cxlmd;
>> +	struct cxl_region *cxlr;
>> +};
>> +
>> +/**
>> + * struct cxl_memdev_ps_params - CXL memory patrol scrub parameter data
>structure.
>> + * @enable:     [IN & OUT] enable(1)/disable(0) patrol scrub.
>> + * @scrub_cycle_changeable: [OUT] scrub cycle attribute of patrol scrub=
 is
>changeable.
>> + * @scrub_cycle_hrs:    [IN] Requested patrol scrub cycle in hours.
>> + *                      [OUT] Current patrol scrub cycle in hours.
>> + * @min_scrub_cycle_hrs:[OUT] minimum patrol scrub cycle in hours
>supported.
>> + */
>> +struct cxl_memdev_ps_params {
>> +	bool enable;
>> +	bool scrub_cycle_changeable;
>> +	u8 scrub_cycle_hrs;
>> +	u8 min_scrub_cycle_hrs;
>> +};
>> +
>> +enum cxl_scrub_param {
>> +	CXL_PS_PARAM_ENABLE,
>> +	CXL_PS_PARAM_SCRUB_CYCLE,
>> +};
>> +
>> +#define CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK	BIT(0)
>> +#define
>	CXL_MEMDEV_PS_SCRUB_CYCLE_REALTIME_REPORT_CAP_MASK
>	BIT(1)
>> +#define	CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK	GENMASK(7, 0)
>> +#define	CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK	GENMASK(15,
>8)
>> +#define	CXL_MEMDEV_PS_FLAG_ENABLED_MASK	BIT(0)
>> +
>> +struct cxl_memdev_ps_rd_attrs {
>> +	u8 scrub_cycle_cap;
>> +	__le16 scrub_cycle_hrs;
>> +	u8 scrub_flags;
>> +}  __packed;
>> +
>> +struct cxl_memdev_ps_wr_attrs {
>> +	u8 scrub_cycle_hrs;
>> +	u8 scrub_flags;
>> +}  __packed;
>
>If these are packed to match specification layout, include a specification
>reference comment.

Will add specification reference comment. Added same for memory repair feat=
ures,
but missed here.
>
>> +
>> +static int cxl_mem_ps_get_attrs(struct cxl_mailbox *cxl_mbox,
>> +				struct cxl_memdev_ps_params *params) {
>> +	size_t rd_data_size =3D sizeof(struct cxl_memdev_ps_rd_attrs);
>> +	u16 scrub_cycle_hrs;
>> +	size_t data_size;
>> +	u16 return_code;
>> +	struct cxl_memdev_ps_rd_attrs *rd_attrs __free(kfree) =3D
>> +						kmalloc(rd_data_size,
>GFP_KERNEL);
>
>I would feel better with kzalloc() if short reads are possible.

Will change to kzalloc().

>
>How big can rd_data_size get? I.e. should this be kvzalloc()?

rd_data_size is 4 bytes for the patrol scrub feature.=20

>
>> +	if (!rd_attrs)
>> +		return -ENOMEM;
>> +
>> +	data_size =3D cxl_get_feature(cxl_mbox->features,
>CXL_FEAT_PATROL_SCRUB_UUID,
>> +				    CXL_GET_FEAT_SEL_CURRENT_VALUE,
>> +				    rd_attrs, rd_data_size, 0, &return_code);
>> +	if (!data_size || return_code !=3D CXL_MBOX_CMD_RC_SUCCESS)
>> +		return -EIO;
>> +
>> +	params->scrub_cycle_changeable =3D
>FIELD_GET(CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK,
>> +						   rd_attrs->scrub_cycle_cap);
>> +	params->enable =3D
>FIELD_GET(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
>> +				   rd_attrs->scrub_flags);
>> +	scrub_cycle_hrs =3D le16_to_cpu(rd_attrs->scrub_cycle_hrs);
>> +	params->scrub_cycle_hrs =3D
>FIELD_GET(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
>> +					    scrub_cycle_hrs);
>> +	params->min_scrub_cycle_hrs =3D
>FIELD_GET(CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK,
>> +						scrub_cycle_hrs);
>> +
>> +	return 0;
>> +}
>> +
>> +static int cxl_ps_get_attrs(struct cxl_patrol_scrub_context *cxl_ps_ctx=
,
>> +			    struct cxl_memdev_ps_params *params) {
>> +	struct cxl_memdev *cxlmd;
>> +	u16 min_scrub_cycle =3D 0;
>> +	int i, ret;
>> +
>> +	if (cxl_ps_ctx->cxlr) {
>> +		struct cxl_region *cxlr =3D cxl_ps_ctx->cxlr;
>> +		struct cxl_region_params *p =3D &cxlr->params;
>> +
>> +		for (i =3D p->interleave_ways - 1; i >=3D 0; i--) {
>> +			struct cxl_endpoint_decoder *cxled =3D p->targets[i];
>
>It looks like this is called directly as a callback from EDAC. Where is th=
e locking
>that keeps cxl_ps_ctx->cxlr valid, or p->targets content stable?
Jonathan already replied.
>
>> +
>> +			cxlmd =3D cxled_to_memdev(cxled);
>> +			ret =3D cxl_mem_ps_get_attrs(&cxlmd->cxlds->cxl_mbox,
>params);
>> +			if (ret)
>> +				return ret;
>> +
>> +			if (params->min_scrub_cycle_hrs > min_scrub_cycle)
>> +				min_scrub_cycle =3D params-
>>min_scrub_cycle_hrs;
>> +		}
>> +		params->min_scrub_cycle_hrs =3D min_scrub_cycle;
>> +		return 0;
>> +	}
>> +	cxlmd =3D cxl_ps_ctx->cxlmd;
>> +
>> +	return cxl_mem_ps_get_attrs(&cxlmd->cxlds->cxl_mbox, params); }
>> +
>> +static int cxl_mem_ps_set_attrs(struct device *dev,
>> +				struct cxl_patrol_scrub_context *cxl_ps_ctx,
>> +				struct cxl_mailbox *cxl_mbox,
>> +				struct cxl_memdev_ps_params *params,
>> +				enum cxl_scrub_param param_type)
>> +{
>> +	struct cxl_memdev_ps_wr_attrs wr_attrs;
>> +	struct cxl_memdev_ps_params rd_params;
>> +	u16 return_code;
>> +	int ret;
>> +
>> +	ret =3D cxl_mem_ps_get_attrs(cxl_mbox, &rd_params);
>> +	if (ret) {
>> +		dev_err(dev, "Get cxlmemdev patrol scrub params failed
>ret=3D%d\n",
>> +			ret);
>> +		return ret;
>> +	}
>> +
>> +	switch (param_type) {
>> +	case CXL_PS_PARAM_ENABLE:
>> +		wr_attrs.scrub_flags =3D
>FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
>> +						  params->enable);
>> +		wr_attrs.scrub_cycle_hrs =3D
>FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
>> +
>rd_params.scrub_cycle_hrs);
>> +		break;
>> +	case CXL_PS_PARAM_SCRUB_CYCLE:
>> +		if (params->scrub_cycle_hrs < rd_params.min_scrub_cycle_hrs)
>{
>> +			dev_err(dev, "Invalid CXL patrol scrub cycle(%d) to
>set\n",
>> +				params->scrub_cycle_hrs);
>> +			dev_err(dev, "Minimum supported CXL patrol scrub
>cycle in hour %d\n",
>> +				rd_params.min_scrub_cycle_hrs);
>> +			return -EINVAL;
>> +		}
>> +		wr_attrs.scrub_cycle_hrs =3D
>FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
>> +						      params->scrub_cycle_hrs);
>> +		wr_attrs.scrub_flags =3D
>FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
>> +						  rd_params.enable);
>> +		break;
>> +	}
>> +
>> +	ret =3D cxl_set_feature(cxl_mbox->features,
>CXL_FEAT_PATROL_SCRUB_UUID,
>> +			      cxl_ps_ctx->set_version,
>> +			      &wr_attrs, sizeof(wr_attrs),
>> +			      CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET,
>> +			      0, &return_code);
>> +	if (ret || return_code !=3D CXL_MBOX_CMD_RC_SUCCESS) {
>> +		dev_err(dev, "CXL patrol scrub set feature failed ret=3D%d
>return_code=3D%u\n",
>> +			ret, return_code);
>
>What can the admin do with this log spam? I would reconsider making all of
>these dev_dbg() and improving the sysfs documentation on what error codes
>mean.
Sure will change.
>
>[..]
>> +
>> +int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct
>> +cxl_region *cxlr)
>
>Please separate this into a memdev helper and a region helper. It is silly=
 to have
>two arguments to a function where one is expected to be NULL at all times,=
 and
>then have an if else statement inside that to effectively turn it back int=
o 2 code
>paths.
>
>If there is code to be shared amongst those, make *that* the shared helper=
.
I added single function cxl_mem_ras_features_init() for both memdev and reg=
ion based
scrubbing to reduce code size as there were feedbacks try reduce code size.=
 =20
>
>> +{
>> +	struct edac_dev_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
>> +	char cxl_dev_name[CXL_DEV_NAME_LEN];
>> +	int num_ras_features =3D 0;
>> +	u8 scrub_inst =3D 0;
>> +	int rc;
>> +
>> +	rc =3D cxl_memdev_scrub_init(cxlmd, cxlr,
>&ras_features[num_ras_features],
>> +				   scrub_inst);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	scrub_inst++;
>> +	num_ras_features++;
>> +
>> +	if (cxlr)
>> +		snprintf(cxl_dev_name, sizeof(cxl_dev_name),
>> +			 "cxl_region%d", cxlr->id);
>
>Why not pass dev_name(&cxlr->dev) directly?
Jonathan already replied.=20
>
>> +	else
>> +		snprintf(cxl_dev_name, sizeof(cxl_dev_name),
>> +			 "%s_%s", "cxl", dev_name(&cxlmd->dev));
>
>Can a "cxl" directory be created so that the raw name can be used?
>
>> +
>> +	return edac_dev_register(&cxlmd->dev, cxl_dev_name, NULL,
>> +				 num_ras_features, ras_features);
>
>I'm so confused... a few lines down in this patch we have:
>
>    rc =3D cxl_mem_ras_features_init(NULL, cxlr);
>
>...so how can this call to edac_dev_register() unconditionally de-referenc=
e
>@cxlmd?
Thanks for spotting this. It is a bug, need to fix , cxlmd inited for regio=
n based scrubbing=20
was done inside cxl_mem_ras_features_init() previously, which now moved to
inside cxl_memdev_scrub_init().=20
Region based scrubbing required better testing because of some difficulty i=
n running
this use case in my test setup. Will check with Jonathan how to do.
>
>Are there any tests for this? cxl-test is purpose-built for this kind of b=
asic
>coverage tests.
Will check this.
>
>> +EXPORT_SYMBOL_NS_GPL(cxl_mem_ras_features_init, "CXL");
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index b98b1ccffd1c..c2be70cd87f8 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3449,6 +3449,12 @@ static int cxl_region_probe(struct device *dev)
>>  					p->res->start, p->res->end, cxlr,
>>  					is_system_ram) > 0)
>>  			return 0;
>> +
>> +		rc =3D cxl_mem_ras_features_init(NULL, cxlr);
>> +		if (rc)
>> +			dev_warn(&cxlr->dev, "CXL RAS features init for
>region_id=3D%d failed\n",
>> +				 cxlr->id);
>
>There is more to RAS than EDAC memory scrub so this message is misleading.=
 It
>is also unnecessary because the driver continues to load and the admin, if=
 they
>care, will notice that the EDAC attributes are missing.
This message was added for the debugging purpose in CXL driver. I will chan=
ge to  dev_dbg().
>
>> +
>>  		return devm_cxl_add_dax_region(cxlr);
>>  	default:
>>  		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n", diff --
>git
>> a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h index
>> 55c55685cb39..2b02e47cd7e7 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -800,6 +800,13 @@ int cxl_trigger_poison_list(struct cxl_memdev
>> *cxlmd);  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>> int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
>>
>> +#if IS_ENABLED(CONFIG_CXL_RAS_FEATURES)
>> +int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct
>> +cxl_region *cxlr); #else static inline int
>> +cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_region
>> +*cxlr) { return 0; } #endif
>> +
>>  #ifdef CONFIG_CXL_SUSPEND
>>  void cxl_mem_active_inc(void);
>>  void cxl_mem_active_dec(void);
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c index
>> 2f03a4d5606e..d236b4b8a93c 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -116,6 +116,10 @@ static int cxl_mem_probe(struct device *dev)
>>  	if (!cxlds->media_ready)
>>  		return -EBUSY;
>>
>> +	rc =3D cxl_mem_ras_features_init(cxlmd, NULL);
>> +	if (rc)
>> +		dev_warn(&cxlmd->dev, "CXL RAS features init failed\n");
>> +
>>  	/*
>>  	 * Someone is trying to reattach this device after it lost its port
>>  	 * connection (an endpoint port previously registered by this memdev
>> was @@ -259,3 +263,4 @@
>MODULE_ALIAS_CXL(CXL_DEVICE_MEMORY_EXPANDER);
>>   * endpoint registration.
>>   */
>>  MODULE_SOFTDEP("pre: cxl_port");
>> +MODULE_SOFTDEP("pre: cxl_features");
>
>Why?
This dependency is no more required. During integration testing, this was a=
dded when
cxl_features found was not getting initialized when CXL memdev RAS features=
 are getting
initialized, which calls features command  function, cxl_get_supported_feat=
ure_entry,=20
for the RAS features. The reason was different from this and got fixed.=20

Thanks,
Shiju


