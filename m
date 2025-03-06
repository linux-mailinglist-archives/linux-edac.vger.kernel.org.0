Return-Path: <linux-edac+bounces-3286-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F381EA54925
	for <lists+linux-edac@lfdr.de>; Thu,  6 Mar 2025 12:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C5918951FA
	for <lists+linux-edac@lfdr.de>; Thu,  6 Mar 2025 11:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481A3209F22;
	Thu,  6 Mar 2025 11:21:58 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4BC2054E6;
	Thu,  6 Mar 2025 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260118; cv=none; b=oqCvZHr26U+Ths71r9iWZ6SQZSlMoaAMyx95nkcEyR5xUuAAVJGZrsKL8yMDUtIT4Ps92CbvS4DloB1DhcL5ObMkhENrtxNgRrGO5pOJmqis+rEQFQB+NLoLpuF2GL0nWgnkkf8h7exMvX51UxIheyVqVlHLPKKCuhWoJ4lRH2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260118; c=relaxed/simple;
	bh=F1gT/Y0PtPKhMaUsbc7IMab+4kGCUja253A9grKICHc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=huR0FCSHDaVmrNVDQWUW91UH3xYOmc0tIptnVLNPFLXgF6BZyZeHsJbI6vOcUnQQpmMejdg2rurNKigrXnkhssVTK0hauxF9AymzdErq3NXjyCh0iK1zP5bzFjojJphdI/fUhDaTLaSTBKItbJJPpV6i4rdS9jBwSP/WiraMNC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z7n2Z3c3mz6L5Qc;
	Thu,  6 Mar 2025 19:17:42 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
	by mail.maildlp.com (Postfix) with ESMTPS id C1C11140593;
	Thu,  6 Mar 2025 19:21:51 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Mar 2025 12:21:51 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 6 Mar 2025 12:21:51 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "leo.duran@amd.com"
	<leo.duran@amd.com>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rientjes@google.com" <rientjes@google.com>,
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
Subject: RE: [PATCH v2 2/3] ACPI:RAS2: Add ACPI RAS2 driver
Thread-Topic: [PATCH v2 2/3] ACPI:RAS2: Add ACPI RAS2 driver
Thread-Index: AQHbjfjU3SdB6rbarkWzBYMyJX3PgbNlxP+AgAAg7jA=
Date: Thu, 6 Mar 2025 11:21:51 +0000
Message-ID: <a0b319b4f42c4286a120fbb88a88adeb@huawei.com>
References: <20250305180225.1226-1-shiju.jose@huawei.com>
	<20250305180225.1226-3-shiju.jose@huawei.com>
 <20250306171925.00002721@huawei.com>
In-Reply-To: <20250306171925.00002721@huawei.com>
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
>Sent: 06 March 2025 09:19
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-edac@vger.kernel.org; linux-acpi@vger.kernel.org; bp@alien8.de;
>tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
>mchehab@kernel.org; leo.duran@amd.com; Yazen.Ghannam@amd.com; linux-
>cxl@vger.kernel.org; dan.j.williams@intel.com; dave@stgolabs.net;
>dave.jiang@intel.com; alison.schofield@intel.com; vishal.l.verma@intel.com=
;
>ira.weiny@intel.com; david@redhat.com; Vilas.Sridharan@amd.com; linux-
>mm@kvack.org; linux-kernel@vger.kernel.org; rientjes@google.com;
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
>Subject: Re: [PATCH v2 2/3] ACPI:RAS2: Add ACPI RAS2 driver
>
>On Wed, 5 Mar 2025 18:02:23 +0000
><shiju.jose@huawei.com> wrote:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add support for ACPI RAS2 feature table (RAS2) defined in the ACPI 6.5
>> Specification, section 5.2.21.
>> Driver defines RAS2 Init, which extracts the RAS2 table and driver
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
>
>Hi Shiju,
>
>I took another look through as it's been a while and I've pretty much forg=
otten
>this code :(
>
>Anyhow, a few minor comments inline.

Hi Jonathan,

Thanks for the feedbacks.

Please find reply inline.

Thanks,
Shiju
>
>Thanks,
>
>Jonathan
>
>> diff --git a/drivers/acpi/ras2.c b/drivers/acpi/ras2.c new file mode
>> 100755 index 000000000000..8831a2bd5fab
>> --- /dev/null
>> +++ b/drivers/acpi/ras2.c
>
>
>
>
>> +static int ras2_register_pcc_channel(struct ras2_mem_ctx *ras2_ctx, int
>pcc_id)
>> +{
>> +	struct ras2_pcc_subspace *pcc_subspace;
>> +	struct pcc_mbox_chan *pcc_chan;
>> +	struct mbox_client *mbox_cl;
>> +
>> +	if (pcc_id < 0)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&ras2_pcc_lock);
>> +	list_for_each_entry(pcc_subspace, &ras2_pcc_subspaces, elem) {
>> +		if (pcc_subspace->pcc_id !=3D pcc_id)
>> +			continue;
>> +		ras2_ctx->pcc_subspace =3D pcc_subspace;
>> +		pcc_subspace->ref_count++;
>> +		mutex_unlock(&ras2_pcc_lock);
>> +		return 0;
>> +	}
>> +	mutex_unlock(&ras2_pcc_lock);
>> +
>> +	pcc_subspace =3D kcalloc(1, sizeof(*pcc_subspace), GFP_KERNEL);
>
>if allocating a count of 1, why not kzalloc?

Will use kzalloc.
>
>> +	if (!pcc_subspace)
>> +		return -ENOMEM;
>
>
>
>
>> +static int acpi_ras2_parse(void)
>> +{
>> +	struct acpi_ras2_pcc_desc *pcc_desc_list;
>> +	int pcc_id;
>> +	u8 count =3D 0;
>> +	int rc, i;
>> +
>> +	if (ras2_tab->header.length  < sizeof(struct acpi_table_ras2)) {
>
>extra space before <

Will fix.=20
>
>Maybe sizeof(*ras2_tab) is cleaner.
Sure.
>
>> +		pr_warn(FW_WARN "ACPI RAS2 table present but broken (too
>short #1)\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!ras2_tab->num_pcc_descs) {
>> +		pr_warn(FW_WARN "No PCC descs in ACPI RAS2 table\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	pcc_desc_list =3D (struct acpi_ras2_pcc_desc *)(ras2_tab + 1);
>> +	/* Double scan for the case of only one actual controller */
>> +	pcc_id =3D -1;
>> +	count =3D 0;
>
>Already set above, so no need to do it again.  I'd do it just here.  Can
>put it in the loop init though.
Will change.
>
>> +	for (i =3D 0; i < ras2_tab->num_pcc_descs; i++, pcc_desc_list++) {
>> +		if (pcc_desc_list->feature_type !=3D RAS2_FEAT_TYPE_MEMORY)
>> +			continue;
>> +		if (pcc_id =3D=3D -1) {
>> +			pcc_id =3D pcc_desc_list->channel_id;
>> +			count++;
>> +		}
>> +		if (pcc_desc_list->channel_id !=3D pcc_id)
>> +			count++;
>> +	}
>> +
>> +	/*
>> +	 * Workaround for the client platform with multiple scrub devices
>> +	 * but uses single PCC subspace for communication.
>> +	 */
>> +	if (count =3D=3D 1) {
>> +		/* Add auxiliary device and bind ACPI RAS2 memory driver */
>> +		rc =3D ras2_add_aux_device(RAS2_MEM_DEV_ID_NAME, pcc_id);
>> +		if (rc)
>> +			return rc;
>> +
>> +		return 0;
>> +	}
>> +
>> +	pcc_desc_list =3D (struct acpi_ras2_pcc_desc *)(ras2_tab + 1);
>> +	count =3D 0;
>
>Maybe set in loop init.
Sure.
>
>> +	for (i =3D 0; i < ras2_tab->num_pcc_descs; i++, pcc_desc_list++) {
>> +		if (pcc_desc_list->feature_type !=3D RAS2_FEAT_TYPE_MEMORY)
>> +			continue;
>> +		pcc_id =3D pcc_desc_list->channel_id;
>> +		/* Add auxiliary device and bind ACPI RAS2 memory driver */
>obvious enough to drop the comment I think.
Will do.
>
>> +		rc =3D ras2_add_aux_device(RAS2_MEM_DEV_ID_NAME, pcc_id);
>					 pcc_desc_list->channel_id);
>and no local variable.
Ok.
>
>> +		if (rc)
>> +			return rc;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +void __init acpi_ras2_init(void)
>> +{
>> +	acpi_status status;
>> +	int rc;
>> +
>> +	status =3D acpi_get_table(ACPI_SIG_RAS2, 0,
>> +				(struct acpi_table_header **)&ras2_tab);
>> +	if (ACPI_FAILURE(status) || !ras2_tab) {
>> +		const char *msg =3D acpi_format_exception(status);
>> +
>> +		pr_err("Failed to get table, %s\n", msg);
>
>If only going to use it here maybe
>		pr_err("Failed to get table, %s\n",
>		       acpi_format_exception(status));
>and save on the local variable.
Will change.
>
>> +		return;
>> +	}
>> +
>> +	rc =3D acpi_ras2_parse();
>> +	if (rc) {
>> +		acpi_put_table((struct acpi_table_header *)ras2_tab);
>> +		pr_err("Failed to parse RAS2 table\n");
>> +	}
>> +}
>> diff --git a/include/acpi/ras2.h b/include/acpi/ras2.h
>> new file mode 100644
>> index 000000000000..5b27c1f30096
>> --- /dev/null
>> +++ b/include/acpi/ras2.h
>> @@ -0,0 +1,48 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * ACPI RAS2 driver header file
>> + *
>> + * Copyright (c) 2024-2025 HiSilicon Limited
>> + */
>> +
>> +#ifndef _ACPI_RAS2_H
>> +#define _ACPI_RAS2_H
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
>I think these bits are from table 14.11 and
>generic to all PCC status registers? Should these
>have more generic names rather than ras2 specific ones?
Yes.
Instead will use PCC_STATUS_CMD_ COMPLETE and  PCC_STATUS_ ERROR
from include/acpi/pcc.h.=20

>
>> +/* RAS2 specific PCC commands */
>> +#define RAS2_PCC_CMD_EXEC 0x01
>Are we mixing commands and field definitions both
>with prefix RAS2_PCC_CMD_ ?  That is somewhat
>confusing.
Will add Table 5.82: .. here in the comment and=20
Is rename to PCC_CMD_ EXEC_RAS2  better?
>
>> +
>> +#define RAS2_AUX_DEV_NAME "ras2"
>> +#define RAS2_MEM_DEV_ID_NAME "acpi_ras2_mem"
>> +
>I would add a forwards def
>struct device;
Sure.
>
>whilst it is really unlikely that headers would ever be reorganized
>such that auxiliary_bus.h would not include device.h given the embedded
>device we shouldn't rely on that here.
>
>> +/* Data structure RAS2 table */
>> +struct ras2_mem_ctx {
>> +	struct auxiliary_device adev;
>> +	/* Lock to provide mutually exclusive access to PCC channel */
>> +	struct mutex lock;
>> +	struct device *dev;
>> +	struct acpi_ras2_shmem __iomem *comm_addr;
>> +	void *pcc_subspace;
>> +	int id;
>> +};
>> +
>> +#ifdef CONFIG_ACPI_RAS2
>> +void __init acpi_ras2_init(void);
>> +int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd);
>> +#else
>> +static inline void acpi_ras2_init(void) { }
>> +
>> +static inline int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16
>cmd)
>
>Is this stub ever needed?  To me it seems unlikely
>we would have a user that is built without a dependency
>on CONFIG_ACPI_RAS2.  This is different from acpi_ras2_init()
>which makes much more sense to me.
Ok will remove.
>
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +#endif
>> +#endif /* _ACPI_RAS2_H */

Thanks,
Shiju


