Return-Path: <linux-edac+bounces-3412-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A093FA74812
	for <lists+linux-edac@lfdr.de>; Fri, 28 Mar 2025 11:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426583BD6D5
	for <lists+linux-edac@lfdr.de>; Fri, 28 Mar 2025 10:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8481E21ABCC;
	Fri, 28 Mar 2025 10:18:27 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6487213E66;
	Fri, 28 Mar 2025 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743157107; cv=none; b=OPjKBMU/xWyq91BTF0u9B0L0JvRLMgm6y3dplFcM8Lm1lkwqo+u0wjJqDtXnOx7HVGZ/ejQJP5UgbldjQMdMNSDLOPDkTSwTPXGQ4pRkaBKQpcK2E4VSBhQidQJ5UPnV1f0lQFYEEeAnonIJ7QobTmGK9g3sNdFnoif2gJdK67Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743157107; c=relaxed/simple;
	bh=gcgr7z5Ippm2KnaPGtAze5iGXSlisr88DVXAquZgt80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZMZ0qUt6R9nM+Qw4DdymQVzIh+rGkNy/KEWV47dUBy+uBUvKEBYIRVq3qDLI2dOKHUaToFmkjN5VE+DeFePL1kgIVxFjo7KUFWg6z502rXNuzUmyh8FE4tilEJMOW2J+WeUNLzdnmUNFOciBxwhA+Aix4RNsYi+cbXwCyQpTLA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZPGgY5P0Gz6L53b;
	Fri, 28 Mar 2025 18:18:01 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
	by mail.maildlp.com (Postfix) with ESMTPS id 70380140119;
	Fri, 28 Mar 2025 18:18:21 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Mar 2025 11:18:21 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 28 Mar 2025 11:18:21 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "dave@stgolabs.net" <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "leo.duran@amd.com"
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
	<wbs@os.amperecomputing.com>, "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v2 3/8] cxl/edac: Add CXL memory device patrol scrub
 control feature
Thread-Topic: [PATCH v2 3/8] cxl/edac: Add CXL memory device patrol scrub
 control feature
Thread-Index: AQHbmcKuLCBs/xi+XkeVn732q30wUbOGMAMAgAESV/A=
Date: Fri, 28 Mar 2025 10:18:20 +0000
Message-ID: <d75c574e26d94aa9b398acfca0ecac9d@huawei.com>
References: <20250320180450.539-1-shiju.jose@huawei.com>
	<20250320180450.539-4-shiju.jose@huawei.com>
 <67e4ae1cb0cdd_152c29462@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <67e4ae1cb0cdd_152c29462@dwillia2-mobl3.amr.corp.intel.com.notmuch>
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
>From: Dan Williams <dan.j.williams@intel.com>
>Sent: 27 March 2025 01:47
>To: Shiju Jose <shiju.jose@huawei.com>; linux-cxl@vger.kernel.org;
>dan.j.williams@intel.com; dave@stgolabs.net; Jonathan Cameron
><jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>david@redhat.com; Vilas.Sridharan@amd.com
>Cc: linux-edac@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
>mm@kvack.org; linux-kernel@vger.kernel.org; bp@alien8.de;
>tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
>mchehab@kernel.org; leo.duran@amd.com; Yazen.Ghannam@amd.com;
>rientjes@google.com; jiaqiyan@google.com; Jon.Grimm@amd.com;
>dave.hansen@linux.intel.com; naoya.horiguchi@nec.com;
>james.morse@arm.com; jthoughton@google.com; somasundaram.a@hpe.com;
>erdemaktas@google.com; pgonda@google.com; duenwen@google.com;
>gthelen@google.com; wschwartz@amperecomputing.com;
>dferguson@amperecomputing.com; wbs@os.amperecomputing.com;
>nifan.cxl@gmail.com; tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
><prime.zeng@hisilicon.com>; Roberto Sassu <roberto.sassu@huawei.com>;
>kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
>Linuxarm <linuxarm@huawei.com>; Shiju Jose <shiju.jose@huawei.com>
>Subject: Re: [PATCH v2 3/8] cxl/edac: Add CXL memory device patrol scrub
>control feature
>
>shiju.jose@ wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL spec 3.2 section 8.2.10.9.11.1 describes the device patrol scrub
[...]
>> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c new
>> file mode 100644 index 000000000000..5ec3535785e1
>> --- /dev/null
>> +++ b/drivers/cxl/core/edac.c
>> @@ -0,0 +1,474 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * CXL EDAC memory feature driver.
>> + *
>> + * Copyright (c) 2024-2025 HiSilicon Limited.
>> + *
>> + *  - Supports functions to configure EDAC features of the
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
>> +#include "core.h"
>> +
>> +#define CXL_NR_EDAC_DEV_FEATURES 1
>> +
>> +static struct rw_semaphore *cxl_acquire(struct rw_semaphore *rwsem) {
>> +	if (down_read_interruptible(rwsem))
>> +		return NULL;
>> +
>> +	return rwsem;
>> +}
>> +
>> +DEFINE_FREE(cxl_unlock, struct rw_semaphore *, if (_T) up_read(_T))
>
>I know I suggested cxl_acquire() and cxl_unlock(), but this really is a ge=
neric
>facility.
>
>Let's call it rwsem_read_intr_acquire() and rwsem_read_release(), and I'll
>follow up later with Peter to see if he wants this to graduate from CXL.
>
>Also, go ahead and define it in cxl.h for now as I think other places in t=
he
>subsystem could benefit from this approach.

Hi Dan,

Thanks for the comments.
Sure. should these definitions in cxl.h  require in a separate patch?

>
>> +
>> +/*
>> + * CXL memory patrol scrub control
>> + */
>> +struct cxl_patrol_scrub_context {
>
>I like "patrol_scrub" spelled out here compared to "ps" used everywhere el=
se.
Will change.

>
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
>
>This is set but unused. Even if it were to be used I would expect it to be=
 set in the
>cxl_patrol_scrub_context.
I will add  to cxl_patrol_scrub_context and will add an extra check against=
 this when
user request to change the scrub rate.
>
>> +	u8 scrub_cycle_hrs;
>> +	u8 min_scrub_cycle_hrs;
>> +};
>
>I do not understand the point of this extra object and would prefer to kee=
p
>intermediate data structures to a minimum.
>
>It looks like all this does is provide for short lived parsed caching of t=
he raw
>hardware patrol scrube attributes. Just pass those raw objects around and
>provide helpers to do the conversion.

Sure. Will do. Was added to avoid more number of function parameters.=20
>
>The less data structures the less confusion for the next person that has t=
o read
>this code a few years down the road.
>
>> +
>> +enum cxl_scrub_param {
>> +	CXL_PS_PARAM_ENABLE,
>> +	CXL_PS_PARAM_SCRUB_CYCLE,
>> +};
>
>This seems unforuntate, why not make non-zero scrub rate an implied enable
>and zero to disable? A non-zero sentinel value like U32_MAX can indicate "=
keep
>scrub rate unchanged".

These  enums can be removed with remove using cxl_memdev_ps_params.

>
>> +#define CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK BIT(0)
>
>This CXL_MEMDEV_PS prefix is awkward due to overload with 'struct
>cxl_memdev'. Minimize it to something like:
>
>CXL_SCRUB_CONTROL_CHANGEABLE
>CXL_SCRUB_CONTROL_REALTIME
>CXL_SCRUB_CONTROL_CYCLE_MASK
>CXL_SCRUB_CONTROL_MIN_CYCLE_MASK

Will change.
>
>> +#define CXL_MEMDEV_PS_SCRUB_CYCLE_REALTIME_REPORT_CAP_MASK
>BIT(1)
>> +#define CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK GENMASK(7, 0)
>#define
>> +CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK GENMASK(15, 8) #define
>> +CXL_MEMDEV_PS_FLAG_ENABLED_MASK BIT(0)
>
>CXL_SCRUB_CONTROL_ENABLE
>
>...no need to call it a mask when it is just a single-bit, and when it is =
both the
>status and the control just call it "enable".

Sure. Will change.
>
>> +
>> +/*
>> + * See CXL spec rev 3.2 @8.2.10.9.11.1 Table 8-222 Device Patrol
>> +Scrub Control
>> + * Feature Readable Attributes.
>> + */
>> +struct cxl_memdev_ps_rd_attrs {
>> +	u8 scrub_cycle_cap;
>> +	__le16 scrub_cycle_hrs;
>
>"hours" is just 2 more characters than "hrs", I think we can afford the ex=
tra
>bytes.

Will change.
>
>[..]
>> +int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd) {
>> +	struct edac_dev_feature ras_features[CXL_NR_EDAC_DEV_FEATURES];
>> +	int num_ras_features =3D 0;
>> +	u8 scrub_inst =3D 0;
>> +	int rc;
>> +
>> +	rc =3D cxl_memdev_scrub_init(cxlmd, &ras_features[num_ras_features],
>> +				   scrub_inst);
>> +	if (rc < 0 && rc !=3D -EOPNOTSUPP)
>> +		return rc;
>> +
>> +	if (rc !=3D -EOPNOTSUPP)
>> +		num_ras_features++;
>> +
>> +	char *cxl_dev_name __free(kfree) =3D
>> +		kasprintf(GFP_KERNEL, "cxl_%s", dev_name(&cxlmd->dev));
>
>if (!cxl_dev_name)
>	return -ENOMEM;

Will add.
>
>> +
>> +	return edac_dev_register(&cxlmd->dev, cxl_dev_name, NULL,
>> +				 num_ras_features, ras_features); }
>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_edac_register, "CXL");
>> +
>> +int devm_cxl_region_edac_register(struct cxl_region *cxlr) {
>> +	struct edac_dev_feature ras_features[CXL_NR_EDAC_DEV_FEATURES];
>> +	int num_ras_features =3D 0;
>> +	u8 scrub_inst =3D 0;
>> +	int rc;
>> +
>> +	rc =3D cxl_region_scrub_init(cxlr, &ras_features[num_ras_features],
>> +				   scrub_inst);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	num_ras_features++;
>> +
>> +	char *cxl_dev_name __free(kfree) =3D
>> +		kasprintf(GFP_KERNEL, "cxl_%s", dev_name(&cxlr->dev));
>> +
>> +	return edac_dev_register(&cxlr->dev, cxl_dev_name, NULL,
>> +				 num_ras_features, ras_features); }
>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_region_edac_register, "CXL");
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index b3260d433ec7..2aa6eb675fdf 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3542,6 +3542,11 @@ static int cxl_region_probe(struct device *dev)
>>  	case CXL_PARTMODE_PMEM:
>>  		return devm_cxl_add_pmem_region(cxlr);
>>  	case CXL_PARTMODE_RAM:
>> +		rc =3D devm_cxl_region_edac_register(cxlr);
>
>Why do only volatile regions get EDAC support? PMEM patrol scrub seems
>equally valid.

Will add devm_cxl_region_edac_register () for PMEM as well.

Thanks,
Shiju

