Return-Path: <linux-edac+bounces-3290-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE0DA55C4C
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 01:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30977188EE24
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 00:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D9B136352;
	Fri,  7 Mar 2025 00:55:31 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8667DA8C;
	Fri,  7 Mar 2025 00:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308931; cv=none; b=EWglIu1d5WSkqMwdOkJ5BBbnSnaDcej9uQrqPOeA+hUfZPmjyN5zg5kti2o0A7+BIrYzYLJvQhBathNPinjr3t39j3AXBTHsF/xw3LTSOtm5/LCepfk/2WV/SNBaB3somlIFKNYcJ9ypqxaTVE/PJNX+bQin2KV6dUzq2wMrmdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308931; c=relaxed/simple;
	bh=6pOZqV2b/3J7xu4+FN43a7eOKtiH1Q/axVqYxOckuUw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tu778N94HcyOzyw+GsKPt4GRLq0PR9j/DxeQlz4KRRn6otzl2PnMH3zfpu82+HzyRtculW6RTWmhmnhi1e7ZMV5pQZz8k1MvySxvFZH/D0BHqizbSOxSA7dbM7v5jmhr3QpfO7vhMBinBdAS2tb+27FA6w55N1CnD+dvquYorPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z875G5wYhz6L5DY;
	Fri,  7 Mar 2025 08:51:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E089F140A08;
	Fri,  7 Mar 2025 08:55:25 +0800 (CST)
Received: from localhost (10.48.43.65) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Mar
 2025 01:55:09 +0100
Date: Fri, 7 Mar 2025 08:55:07 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <david@redhat.com>,
	<Vilas.Sridharan@amd.com>, <linux-edac@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH 1/8] cxl: Add helper function to retrieve a feature
 entry
Message-ID: <20250307085445.00005f5d@huawei.com>
In-Reply-To: <20250227223816.2036-2-shiju.jose@huawei.com>
References: <20250227223816.2036-1-shiju.jose@huawei.com>
	<20250227223816.2036-2-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 27 Feb 2025 22:38:08 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add helper function to retrieve a feature entry from the supported
> features list, if supported.
> 

I think this came from within the core cxl features series
but got pulled out due to lack of users until this set?

> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Either way it's a trivial and useful helper.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/core.h     |  2 ++
>  drivers/cxl/core/features.c | 20 ++++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 3d3b00835446..6c83f6f18122 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -120,6 +120,8 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port);
>  
>  #ifdef CONFIG_CXL_FEATURES
> +struct cxl_feat_entry *cxl_get_feature_entry(struct cxl_dev_state *cxlds,
> +					     const uuid_t *feat_uuid);
>  size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		       enum cxl_get_feat_selection selection,
>  		       void *feat_out, size_t feat_out_size, u16 offset,
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 048ba4fc3538..c822fb4a8c33 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -203,6 +203,26 @@ int devm_cxl_setup_features(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_features, "CXL");
>  
> +struct cxl_feat_entry *cxl_get_feature_entry(struct cxl_dev_state *cxlds,
> +					     const uuid_t *feat_uuid)
> +{
> +	struct cxl_features_state *cxlfs = to_cxlfs(cxlds);
> +	struct cxl_feat_entry *feat_entry;
> +	int count;
> +
> +	/*
> +	 * Retrieve the feature entry from the supported features list,
> +	 * if the feature is supported.
> +	 */
> +	feat_entry = cxlfs->entries->ent;
> +	for (count = 0; count < cxlfs->entries->num_features; count++, feat_entry++) {
> +		if (uuid_equal(&feat_entry->uuid, feat_uuid))
> +			return feat_entry;
> +	}
> +
> +	return ERR_PTR(-ENOENT);
> +}
> +
>  size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		       enum cxl_get_feat_selection selection,
>  		       void *feat_out, size_t feat_out_size, u16 offset,


