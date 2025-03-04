Return-Path: <linux-edac+bounces-3264-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 006FAA4E8A6
	for <lists+linux-edac@lfdr.de>; Tue,  4 Mar 2025 18:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524B219C2C5D
	for <lists+linux-edac@lfdr.de>; Tue,  4 Mar 2025 17:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAF72C2CB6;
	Tue,  4 Mar 2025 16:59:26 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B297B283C9F;
	Tue,  4 Mar 2025 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107566; cv=none; b=Nmfiym3fPI09z/e5xJd6wEjr3TLJgvhCywkyBsD5jd2R2rchJfNJl09wqmU3fFO7+IEaJis4HegkPzRXuPIWooMRipzGnGQmm6YCNYM5pWIG7NvxrsH1Un2b6NTyoxTx5Rj3NM1ljUQx5AK8Jtamlh3ajWof5BVBVaxJpjJqxhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107566; c=relaxed/simple;
	bh=8NUXe2HDbeSU9Xd8YGsh/K7izWxSW5Et2gINogkYR+k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oQdPMCVW1fChU4TJ+ju5pJD4KiP0+2oGyFEgL8+yEkG9kx7OFbgt0zSsQ+U14vDPJyDiKrwsd3Lh3XwgEJYNgMsusgzxNmF/sFzpmxgHGhDSKZ+kRJs/Z+CB8dveUua1etrYsbv8RxIHdNsgHXfRl4FpqaZ/fkcw3ixlzLV+wVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z6hg705d3z6K8k4;
	Wed,  5 Mar 2025 00:57:07 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
	by mail.maildlp.com (Postfix) with ESMTPS id 04A9B140A30;
	Wed,  5 Mar 2025 00:59:20 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Mar 2025 17:59:19 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 4 Mar 2025 17:59:19 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "j.williams@intel.com" <j.williams@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>, "leo.duran@amd.com"
	<leo.duran@amd.com>, "rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>, "Jon.Grimm@amd.com"
	<Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
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
Subject: RE: [PATCH linux-next 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Thread-Topic: [PATCH linux-next 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Thread-Index: AQHbidw/A6f//MbimUaT238XCmdshrNh29AAgAD6T9A=
Date: Tue, 4 Mar 2025 16:59:19 +0000
Message-ID: <6ddc1f0392284befa5d04c48085a57b6@huawei.com>
References: <20250228122752.2062-1-shiju.jose@huawei.com>
 <20250228122752.2062-2-shiju.jose@huawei.com>
 <20250303210636.GA1617010@yaz-khff2.amd.com>
In-Reply-To: <20250303210636.GA1617010@yaz-khff2.amd.com>
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
>From: Yazen Ghannam <yazen.ghannam@amd.com>
>Sent: 03 March 2025 21:07
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-edac@vger.kernel.org; linux-acpi@vger.kernel.org; rafael@kernel.=
org;
>bp@alien8.de; tony.luck@intel.com; lenb@kernel.org; mchehab@kernel.org;
>linux-mm@kvack.org; linux-kernel@vger.kernel.org; linux-cxl@vger.kernel.or=
g;
>j.williams@intel.com; dave@stgolabs.net; Jonathan Cameron
><jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>david@redhat.com; Vilas.Sridharan@amd.com; leo.duran@amd.com;
>rientjes@google.com; jiaqiyan@google.com; Jon.Grimm@amd.com;
>dave.hansen@linux.intel.com; naoya.horiguchi@nec.com;
>james.morse@arm.com; jthoughton@google.com; somasundaram.a@hpe.com;
>erdemaktas@google.com; pgonda@google.com; duenwen@google.com;
>gthelen@google.com; wschwartz@amperecomputing.com;
>dferguson@amperecomputing.com; wbs@os.amperecomputing.com;
>nifan.cxl@gmail.com; tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
><prime.zeng@hisilicon.com>; Roberto Sassu <roberto.sassu@huawei.com>;
>kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
>Linuxarm <linuxarm@huawei.com>
>Subject: Re: [PATCH linux-next 1/2] ACPI:RAS2: Add ACPI RAS2 driver
>
>On Fri, Feb 28, 2025 at 12:27:49PM +0000, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add support for ACPI RAS2 feature table (RAS2) defined in the ACPI 6.5
>> Specification, section 5.2.21.
>> Driver contains RAS2 Init, which extracts the RAS2 table and driver
>> adds auxiliary device for each memory feature which binds to the
>> RAS2 memory driver.
>>
>> Driver uses PCC mailbox to communicate with the ACPI HW and the driver
>> adds OSPM interfaces to send RAS2 commands.
>>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Co-developed-by: A Somasundaram <somasundaram.a@hpe.com>
>> Signed-off-by: A Somasundaram <somasundaram.a@hpe.com>
>> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  drivers/acpi/Kconfig     |  11 ++
>>  drivers/acpi/Makefile    |   1 +
>>  drivers/acpi/ras2.c      | 417 +++++++++++++++++++++++++++++++++++++++
>>  include/acpi/ras2_acpi.h |  47 +++++
>>  4 files changed, 476 insertions(+)
>>  create mode 100755 drivers/acpi/ras2.c  create mode 100644
>> include/acpi/ras2_acpi.h
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig index
>> 7f10aa38269d..7b470cf2fd71 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -293,6 +293,17 @@ config ACPI_CPPC_LIB
[...]		},
>> +		.pcc_channel_acquired =3D true,
>> +	};
>
>There are quite a few places where I'd expect a newline after "}" and "ret=
urn"
>statements. This is just one example.

Hi Yazen,

Thanks for the feedbacks.

Will check and modify.
>
>> +	mutex_lock(&ras2_pcc_subspace_lock);
>> +	list_add(&pcc_subspace->elem, &ras2_pcc_subspaces);
>> +	pcc_subspace->ref_count++;
>> +	mutex_unlock(&ras2_pcc_subspace_lock);
>> +	ras2_ctx->pcc_subspace =3D pcc_subspace;
>> +	ras2_ctx->pcc_comm_addr =3D pcc_subspace->pcc_comm_addr;
>> +	ras2_ctx->dev =3D pcc_chan->mchan->mbox->dev;
>> +
>> +	return 0;
>> +}
>> +
>> +static DEFINE_IDA(ras2_ida);
>> +static void ras2_remove_pcc(struct ras2_mem_ctx *ras2_ctx) {
>> +	struct ras2_pcc_subspace *pcc_subspace =3D ras2_ctx->pcc_subspace;
>> +
>> +	guard(mutex)(&ras2_pcc_subspace_lock);
>> +	if (pcc_subspace->ref_count > 0)
>> +		pcc_subspace->ref_count--;
>> +	if (!pcc_subspace->ref_count) {
>> +		list_del(&pcc_subspace->elem);
>> +		pcc_mbox_free_channel(pcc_subspace->pcc_chan);
>> +		kfree(pcc_subspace);
>> +	}
>> +}
>> +
>> +static void ras2_release(struct device *device) {
>> +	struct auxiliary_device *auxdev =3D container_of(device, struct
>auxiliary_device, dev);
>> +	struct ras2_mem_ctx *ras2_ctx =3D container_of(auxdev, struct
>> +ras2_mem_ctx, adev);
>> +
>> +	ida_free(&ras2_ida, auxdev->id);
>> +	ras2_remove_pcc(ras2_ctx);
>> +	kfree(ras2_ctx);
>> +}
>> +
>> +static struct ras2_mem_ctx *ras2_add_aux_device(char *name, int
>> +channel)
>
>Why is the return type "struct ras2_mem_ctx *"? It is not used by the call=
ing
>function.
>
>Just use return type "int".

Modified.
>
>> +{
>> +	struct ras2_mem_ctx *ras2_ctx;
>> +	int id, ret;
>> +
>> +	ras2_ctx =3D kzalloc(sizeof(*ras2_ctx), GFP_KERNEL);
>> +	if (!ras2_ctx)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	mutex_init(&ras2_ctx->lock);
>> +
>> +	ret =3D ras2_register_pcc_channel(ras2_ctx, channel);
>> +	if (ret < 0) {
>> +		pr_debug("failed to register pcc channel ret=3D%d\n", ret);
>> +		goto ctx_free;
>> +	}
>> +
>> +	id =3D ida_alloc(&ras2_ida, GFP_KERNEL);
>> +	if (id < 0) {
>> +		ret =3D id;
>> +		goto pcc_free;
>> +	}
>> +	ras2_ctx->id =3D id;
>> +	ras2_ctx->adev.id =3D id;
>> +	ras2_ctx->adev.name =3D RAS2_MEM_DEV_ID_NAME;
>> +	ras2_ctx->adev.dev.release =3D ras2_release;
>> +	ras2_ctx->adev.dev.parent =3D ras2_ctx->dev;
>> +
>> +	ret =3D auxiliary_device_init(&ras2_ctx->adev);
>> +	if (ret)
>> +		goto ida_free;
>> +
>> +	ret =3D auxiliary_device_add(&ras2_ctx->adev);
>> +	if (ret) {
>> +		auxiliary_device_uninit(&ras2_ctx->adev);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	return ras2_ctx;
>> +
>> +ida_free:
>> +	ida_free(&ras2_ida, id);
>> +pcc_free:
>> +	ras2_remove_pcc(ras2_ctx);
>> +ctx_free:
>> +	kfree(ras2_ctx);
>> +	return ERR_PTR(ret);
>> +}
>> +
>> +static int ras2_acpi_parse_table(struct acpi_table_header
>> +*pAcpiTable) {
>> +	struct acpi_ras2_pcc_desc *pcc_desc_list;
>> +	struct acpi_table_ras2 *pRas2Table;
>> +	struct ras2_mem_ctx *ras2_ctx;
>> +	int pcc_subspace_id;
>> +	acpi_size ras2_size;
>> +	acpi_status status;
>> +	u8 count =3D 0, i;
>> +
>> +	status =3D acpi_get_table("RAS2", 0, &pAcpiTable);
>> +	if (ACPI_FAILURE(status) || !pAcpiTable) {
>> +		pr_err("ACPI RAS2 driver failed to initialize, get table failed\n");
>> +		return -EINVAL;
>> +	}
>
>You already got the table in the init function and passed its pointer.
>Why do you need to get it again?
Deleted. This was a duplication when parsing table separated into another f=
unction in v19.

>
>Also, you can just save a global pointer to the table if you need to acces=
s it
>multiple times. Please see my comments for the init function.
>You can do something similar to acpi_hest_init().
Ok.
>
>> +
>> +	ras2_size =3D pAcpiTable->length;
>> +	if (ras2_size < sizeof(struct acpi_table_ras2)) {
>> +		pr_err("ACPI RAS2 table present but broken (too short #1)\n");
>
>This should include a "FW_WARN" prefix since the firmware should have
>constructed a valid table.

Added.
>
>> +		return -EINVAL;
>> +	}
>> +
>> +	pRas2Table =3D (struct acpi_table_ras2 *)pAcpiTable;
>> +	if (pRas2Table->num_pcc_descs <=3D 0) {
>
>num_pcc_descs is a u16. It cannot be "< 0".
>
>> +		pr_err("ACPI RAS2 table does not contain PCC descriptors\n");
>
>Please include "FW_WARN" prefix.

Added.
>
>> +		return -EINVAL;
>> +	}
>> +
>> +	pcc_desc_list =3D (struct acpi_ras2_pcc_desc *)(pRas2Table + 1);
>> +	/* Double scan for the case of only one actual controller */
>> +	pcc_subspace_id =3D -1;
>> +	count =3D 0;
>> +	for (i =3D 0; i < pRas2Table->num_pcc_descs; i++, pcc_desc_list++) {
>> +		if (pcc_desc_list->feature_type !=3D
>RAS2_FEATURE_TYPE_MEMORY)
>> +			continue;
>> +		if (pcc_subspace_id =3D=3D -1) {
>> +			pcc_subspace_id =3D pcc_desc_list->channel_id;
>> +			count++;
>> +		}
>> +		if (pcc_desc_list->channel_id !=3D pcc_subspace_id)
>> +			count++;
>> +	}
>> +	/*
>> +	 * Workaround for the client platform with multiple scrub devices
>> +	 * but uses single PCC subspace for communication.
>> +	 */
>> +	if (count =3D=3D 1) {
>> +		/* Add auxiliary device and bind ACPI RAS2 memory driver */
>> +		ras2_ctx =3D ras2_add_aux_device(RAS2_MEM_DEV_ID_NAME,
>pcc_subspace_id);
>> +		if (IS_ERR(ras2_ctx))
>> +			return PTR_ERR(ras2_ctx);
>> +		return 0;
>> +	}
>> +
>> +	pcc_desc_list =3D (struct acpi_ras2_pcc_desc *)(pRas2Table + 1);
>> +	count =3D 0;
>> +	for (i =3D 0; i < pRas2Table->num_pcc_descs; i++, pcc_desc_list++) {
>> +		if (pcc_desc_list->feature_type !=3D
>RAS2_FEATURE_TYPE_MEMORY)
>> +			continue;
>> +		pcc_subspace_id =3D pcc_desc_list->channel_id;
>> +		/* Add auxiliary device and bind ACPI RAS2 memory driver */
>> +		ras2_ctx =3D ras2_add_aux_device(RAS2_MEM_DEV_ID_NAME,
>pcc_subspace_id);
>> +		if (IS_ERR(ras2_ctx))
>> +			return PTR_ERR(ras2_ctx);
>> +	}
>
>Why not just try to register *every* PCC identifier you find and have the =
register
>function ignore duplicates? Does it already do this?
Presently driver registers all PCC IDs for the memory RAS Feature Type only=
, as ACPI spec rev 6.5
RAS2 supports memory  features only. Also duplication of the PCC IDs are ta=
ken care during registration
in the ras2_register_pcc_channel().
>
>> +
>> +	return 0;
>> +}
>> +
>> +static int __init ras2_acpi_init(void) {
>> +	struct acpi_table_header *pAcpiTable =3D NULL;
>> +	acpi_status status;
>> +	int ret;
>> +
>> +	status =3D acpi_get_table("RAS2", 0, &pAcpiTable);
>> +	if (ACPI_FAILURE(status) || !pAcpiTable) {
>> +		pr_err("ACPI RAS2 driver failed to initialize, get table failed\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret =3D ras2_acpi_parse_table(pAcpiTable);
>> +	if (ret)
>> +		pr_err("ras2_acpi_parse_table failed\n");
>> +
>> +	acpi_put_table(pAcpiTable);
>> +
>> +	return ret;
>> +}
>> +late_initcall(ras2_acpi_init)
>
>Can this init function be called in acpi_init() along with other ACPI tabl=
es?
>
>I think the function can follow a similar structure to acpi_hest_init() an=
d
>acpi_ghes_init().
>
>For example, the name could be acpi_ras2_init() to follow the same format =
as
>other acpi_*_init() functions.
>
>Most of these functions are called after other plumbing, like PCC, is alre=
ady
>initialized.
Modified to call from acpi_init().

>
>> diff --git a/include/acpi/ras2_acpi.h b/include/acpi/ras2_acpi.h new
>> file mode 100644 index 000000000000..0d24c42eb34f
>> --- /dev/null
>> +++ b/include/acpi/ras2_acpi.h
>> @@ -0,0 +1,47 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * RAS2 ACPI driver header file
>> + *
>> + * (C) Copyright 2014, 2015 Hewlett-Packard Enterprises
>
>Are these years correct?
Yes. The RAS2  driver was started from the following ACPI RASF driver (whic=
h is the old version of RAS2)=20
https://patchwork.kernel.org/project/linux-arm-kernel/patch/CS1PR84MB003871=
8F49DBC0FF03919E1184390@CS1PR84MB0038.NAMPRD84.PROD.OUTLOOK.COM/=20
>
>> + *
>> + * Copyright (c) 2024-2025 HiSilicon Limited */
>> +
>> +#ifndef _RAS2_ACPI_H
>> +#define _RAS2_ACPI_H
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/auxiliary_bus.h>
>> +#include <linux/mailbox_client.h>
>> +#include <linux/mutex.h>
>> +#include <linux/types.h>
>> +
>> +#define RAS2_PCC_CMD_COMPLETE	BIT(0)
>> +#define RAS2_PCC_CMD_ERROR	BIT(2)
>> +
>> +/* RAS2 specific PCC commands */
>> +#define RAS2_PCC_CMD_EXEC 0x01
>> +
>> +#define RAS2_AUX_DEV_NAME "ras2"
>> +#define RAS2_MEM_DEV_ID_NAME "acpi_ras2_mem"
>> +
>> +/* Data structure RAS2 table */
>> +struct ras2_mem_ctx {
>> +	struct auxiliary_device adev;
>> +	/* Lock to provide mutually exclusive access to PCC channel */
>> +	struct mutex lock;
>> +	struct device *dev;
>> +	struct device *scrub_dev;
>> +	struct acpi_ras2_shared_memory __iomem *pcc_comm_addr;
>> +	void *pcc_subspace;
>> +	u64 base, size;
>> +	int id;
>> +	u8 instance;
>> +	u8 scrub_cycle_hrs;
>> +	u8 min_scrub_cycle;
>> +	u8 max_scrub_cycle;
>> +	bool bg;
>
>What is "bg"?
>
>It's not used in this patch. Maybe it can be added in the patch when it is=
 first
>used? Same for others.
bg for background (patrol) scrubbing, which is used in the next patch in th=
e series.
Sure. Will add in the next patch.  =20
>
>> +};
>> +
>> +int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd); #endif
>> +/* _RAS2_ACPI_H */
>> --
>
>Thanks,
>Yazen

Thanks,
Shiju

