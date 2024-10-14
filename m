Return-Path: <linux-edac+bounces-2055-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BE199D498
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 18:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF48B1F233FD
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CAE1B4F1F;
	Mon, 14 Oct 2024 16:26:14 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB28228FC;
	Mon, 14 Oct 2024 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923174; cv=none; b=bJAhiOzZ6G3mm0qUl8Is/oFFMxxReRR76LQMl2O7AgNIIgHqvttcnlEDKF1PpE9191swNmgLurss1bzDjhlZ9DYkcuaqjp7Jz9uy/Ivs1+AIQMB1T+nwPrzVYR/wSW6H6dgan2aJjnQXnjIi5kxt3m5U5tQ5nBjPScbRhrlVk2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923174; c=relaxed/simple;
	bh=W9kNSItfPSUE+SfBw6OF4HZ2NJ0QQb8sReb6G7N/Glo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JG9G8XCzGaTIPZEWQo6Zu7tnK99+vsw6DMlgqycPwRfbcFboQKXwiskv0IvQlEJ2IRWckyK66VH2lQ+sGZPZ52lP9VAYOyMD0Y0X/iN6l/FjU8/AFOgWagsIuh781fuSuRXr4urO1c/A6fvhTT3dzRCma3/jwPjTQ7/eu5LQrD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XS2cg3dG7z6K5Xl;
	Tue, 15 Oct 2024 00:24:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 76EBE140B55;
	Tue, 15 Oct 2024 00:26:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 18:26:09 +0200
Date: Mon, 14 Oct 2024 17:26:07 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>,
	<leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v13 16/18] cxl/mbox: Add support for PERFORM_MAINTENANCE
 mailbox command
Message-ID: <20241014172607.000066bb@Huawei.com>
In-Reply-To: <20241009124120.1124-17-shiju.jose@huawei.com>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
	<20241009124120.1124-17-shiju.jose@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 9 Oct 2024 13:41:17 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for PERFORM_MAINTENANCE mailbox command.
> 
> CXL spec 3.1 section 8.2.9.7.1 describes the Perform Maintenance command.
> This command requests the device to execute the maintenance operation
> specified by the maintenance operation class and the maintenance operation
> subclass.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
One trivial comment. With that tidied up
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/mbox.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 17 +++++++++++++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 30c44ab11347..a6f69864c504 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1084,6 +1084,46 @@ int cxl_set_feature(struct cxl_memdev_state *mds,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_set_feature, CXL);
>  
> +int cxl_do_maintenance(struct cxl_memdev_state *mds,
> +		       u8 class, u8 subclass,
> +		       void *data_in, size_t data_in_size)
> +{
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +	struct cxl_memdev_maintenance_pi {
> +		struct cxl_mbox_do_maintenance_hdr hdr;
> +		u8 data[];
> +	}  __packed;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	size_t hdr_size;
> +	int rc = 0;
Always set, so no need to init.

> +
> +	struct cxl_memdev_maintenance_pi *pi __free(kfree) =
> +					kmalloc(cxl_mbox->payload_size, GFP_KERNEL);
> +	pi->hdr.op_class = class;
> +	pi->hdr.op_subclass = subclass;
> +	hdr_size = sizeof(pi->hdr);
> +	/*
> +	 * Check minimum mbox payload size is available for
> +	 * the maintenance data transfer.
> +	 */
> +	if (hdr_size + data_in_size > cxl_mbox->payload_size)
> +		return -ENOMEM;
> +
> +	memcpy(pi->data, data_in, data_in_size);
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_DO_MAINTENANCE,
> +		.size_in = hdr_size + data_in_size,
> +		.payload_in = pi,
> +	};
> +
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +	if (rc < 0)
> +		return rc;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_do_maintenance, CXL);


