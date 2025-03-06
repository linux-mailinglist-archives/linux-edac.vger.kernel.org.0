Return-Path: <linux-edac+bounces-3284-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C0DA54619
	for <lists+linux-edac@lfdr.de>; Thu,  6 Mar 2025 10:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB413B0814
	for <lists+linux-edac@lfdr.de>; Thu,  6 Mar 2025 09:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C9D209F35;
	Thu,  6 Mar 2025 09:19:46 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EDA209692;
	Thu,  6 Mar 2025 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741252786; cv=none; b=I3rQCs4ffSXr3Pv1+D+khVGFJQUd04GYvx8rT7z/DcL/u5at09jsQewTf9oWUXBYUeJ4a+3mEjPYVcNfBS30pSNgp1o5n+fj10yMeIU6Ase8uNDlO0I2u3YQPn2TVNKu4f4KekZE+0PU6Uv6ucZtJIp5ZlBTmc/ST4r7sb4J+qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741252786; c=relaxed/simple;
	bh=PQcQ4pkB0f4T3bhPQP6VeqH0uGP/yGUpWFtoLt2L+GQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvLU61+FyefgjaDEukgjRjmcrI9BLbnR3PBerBdEDA6mbt7GNGWn7a3BYaWmuEDS/vTIzhxXPreqgi5XPSPsAZyufOgvK5MCYSviZsBbxtN5DLurrxWmg8dWbM/Mv4iApPrG9ClXdaiWzr9OeC5xVaw7SpK7JeU/r9AKoIoUhn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z7kMk5qHMz6K9Q8;
	Thu,  6 Mar 2025 17:17:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 94C32140159;
	Thu,  6 Mar 2025 17:19:40 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Mar
 2025 10:19:29 +0100
Date: Thu, 6 Mar 2025 17:19:25 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<bp@alien8.de>, <tony.luck@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <mchehab@kernel.org>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 2/3] ACPI:RAS2: Add ACPI RAS2 driver
Message-ID: <20250306171925.00002721@huawei.com>
In-Reply-To: <20250305180225.1226-3-shiju.jose@huawei.com>
References: <20250305180225.1226-1-shiju.jose@huawei.com>
	<20250305180225.1226-3-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 5 Mar 2025 18:02:23 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for ACPI RAS2 feature table (RAS2) defined in the
> ACPI 6.5 Specification, section 5.2.21.
> Driver defines RAS2 Init, which extracts the RAS2 table and driver
> adds auxiliary device for each memory feature which binds to the
> RAS2 memory driver.
> 
> Driver uses PCC mailbox to communicate with the ACPI HW and the
> driver adds OSPM interfaces to send RAS2 commands.
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Co-developed-by: A Somasundaram <somasundaram.a@hpe.com>
> Signed-off-by: A Somasundaram <somasundaram.a@hpe.com>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Hi Shiju,

I took another look through as it's been a while and I've
pretty much forgotten this code :(

Anyhow, a few minor comments inline.

Thanks,

Jonathan

> diff --git a/drivers/acpi/ras2.c b/drivers/acpi/ras2.c
> new file mode 100755
> index 000000000000..8831a2bd5fab
> --- /dev/null
> +++ b/drivers/acpi/ras2.c




> +static int ras2_register_pcc_channel(struct ras2_mem_ctx *ras2_ctx, int pcc_id)
> +{
> +	struct ras2_pcc_subspace *pcc_subspace;
> +	struct pcc_mbox_chan *pcc_chan;
> +	struct mbox_client *mbox_cl;
> +
> +	if (pcc_id < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&ras2_pcc_lock);
> +	list_for_each_entry(pcc_subspace, &ras2_pcc_subspaces, elem) {
> +		if (pcc_subspace->pcc_id != pcc_id)
> +			continue;
> +		ras2_ctx->pcc_subspace = pcc_subspace;
> +		pcc_subspace->ref_count++;
> +		mutex_unlock(&ras2_pcc_lock);
> +		return 0;
> +	}
> +	mutex_unlock(&ras2_pcc_lock);
> +
> +	pcc_subspace = kcalloc(1, sizeof(*pcc_subspace), GFP_KERNEL);

if allocating a count of 1, why not kzalloc?

> +	if (!pcc_subspace)
> +		return -ENOMEM;




> +static int acpi_ras2_parse(void)
> +{
> +	struct acpi_ras2_pcc_desc *pcc_desc_list;
> +	int pcc_id;
> +	u8 count = 0;
> +	int rc, i;
> +
> +	if (ras2_tab->header.length  < sizeof(struct acpi_table_ras2)) {

extra space before <

Maybe sizeof(*ras2_tab) is cleaner.

> +		pr_warn(FW_WARN "ACPI RAS2 table present but broken (too short #1)\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!ras2_tab->num_pcc_descs) {
> +		pr_warn(FW_WARN "No PCC descs in ACPI RAS2 table\n");
> +		return -EINVAL;
> +	}
> +
> +	pcc_desc_list = (struct acpi_ras2_pcc_desc *)(ras2_tab + 1);
> +	/* Double scan for the case of only one actual controller */
> +	pcc_id = -1;
> +	count = 0;

Already set above, so no need to do it again.  I'd do it just here.  Can
put it in the loop init though.

> +	for (i = 0; i < ras2_tab->num_pcc_descs; i++, pcc_desc_list++) {
> +		if (pcc_desc_list->feature_type != RAS2_FEAT_TYPE_MEMORY)
> +			continue;
> +		if (pcc_id == -1) {
> +			pcc_id = pcc_desc_list->channel_id;
> +			count++;
> +		}
> +		if (pcc_desc_list->channel_id != pcc_id)
> +			count++;
> +	}
> +
> +	/*
> +	 * Workaround for the client platform with multiple scrub devices
> +	 * but uses single PCC subspace for communication.
> +	 */
> +	if (count == 1) {
> +		/* Add auxiliary device and bind ACPI RAS2 memory driver */
> +		rc = ras2_add_aux_device(RAS2_MEM_DEV_ID_NAME, pcc_id);
> +		if (rc)
> +			return rc;
> +
> +		return 0;
> +	}
> +
> +	pcc_desc_list = (struct acpi_ras2_pcc_desc *)(ras2_tab + 1);
> +	count = 0;

Maybe set in loop init.

> +	for (i = 0; i < ras2_tab->num_pcc_descs; i++, pcc_desc_list++) {
> +		if (pcc_desc_list->feature_type != RAS2_FEAT_TYPE_MEMORY)
> +			continue;
> +		pcc_id = pcc_desc_list->channel_id;
> +		/* Add auxiliary device and bind ACPI RAS2 memory driver */
obvious enough to drop the comment I think.

> +		rc = ras2_add_aux_device(RAS2_MEM_DEV_ID_NAME, pcc_id);
					 pcc_desc_list->channel_id);
and no local variable.

> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +void __init acpi_ras2_init(void)
> +{
> +	acpi_status status;
> +	int rc;
> +
> +	status = acpi_get_table(ACPI_SIG_RAS2, 0,
> +				(struct acpi_table_header **)&ras2_tab);
> +	if (ACPI_FAILURE(status) || !ras2_tab) {
> +		const char *msg = acpi_format_exception(status);
> +
> +		pr_err("Failed to get table, %s\n", msg);

If only going to use it here maybe
		pr_err("Failed to get table, %s\n",
		       acpi_format_exception(status));
and save on the local variable.

> +		return;
> +	}
> +
> +	rc = acpi_ras2_parse();
> +	if (rc) {
> +		acpi_put_table((struct acpi_table_header *)ras2_tab); 
> +		pr_err("Failed to parse RAS2 table\n");
> +	}
> +}
> diff --git a/include/acpi/ras2.h b/include/acpi/ras2.h
> new file mode 100644
> index 000000000000..5b27c1f30096
> --- /dev/null
> +++ b/include/acpi/ras2.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * ACPI RAS2 driver header file
> + *
> + * Copyright (c) 2024-2025 HiSilicon Limited
> + */
> +
> +#ifndef _ACPI_RAS2_H
> +#define _ACPI_RAS2_H
> +
> +#include <linux/acpi.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +
> +#define RAS2_PCC_CMD_COMPLETE	BIT(0)
> +#define RAS2_PCC_CMD_ERROR	BIT(2)
> +
I think these bits are from table 14.11 and
generic to all PCC status registers? Should these
have more generic names rather than ras2 specific ones?

> +/* RAS2 specific PCC commands */
> +#define RAS2_PCC_CMD_EXEC 0x01
Are we mixing commands and field definitions both
with prefix RAS2_PCC_CMD_ ?  That is somewhat
confusing. 

> +
> +#define RAS2_AUX_DEV_NAME "ras2"
> +#define RAS2_MEM_DEV_ID_NAME "acpi_ras2_mem"
> +
I would add a forwards def
struct device;  

whilst it is really unlikely that headers would ever be reorganized
such that auxiliary_bus.h would not include device.h given the embedded
device we shouldn't rely on that here.

> +/* Data structure RAS2 table */
> +struct ras2_mem_ctx {
> +	struct auxiliary_device adev;
> +	/* Lock to provide mutually exclusive access to PCC channel */
> +	struct mutex lock;
> +	struct device *dev;
> +	struct acpi_ras2_shmem __iomem *comm_addr;
> +	void *pcc_subspace;
> +	int id;
> +};
> +
> +#ifdef CONFIG_ACPI_RAS2
> +void __init acpi_ras2_init(void);
> +int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd);
> +#else
> +static inline void acpi_ras2_init(void) { }
> +
> +static inline int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd)

Is this stub ever needed?  To me it seems unlikely
we would have a user that is built without a dependency
on CONFIG_ACPI_RAS2.  This is different from acpi_ras2_init()
which makes much more sense to me.

> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
> +#endif /* _ACPI_RAS2_H */


