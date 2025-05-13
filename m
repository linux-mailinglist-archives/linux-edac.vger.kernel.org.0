Return-Path: <linux-edac+bounces-3889-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA735AB5954
	for <lists+linux-edac@lfdr.de>; Tue, 13 May 2025 18:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA1C860089
	for <lists+linux-edac@lfdr.de>; Tue, 13 May 2025 16:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D827245008;
	Tue, 13 May 2025 16:07:01 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912532BE114;
	Tue, 13 May 2025 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747152421; cv=none; b=JsWYu593VdG3vpGQ/drhiKtUMqnNnfF10dOgBpt9BDfzwouP5nWElaZS6yCCc2f76iXBpxoORxriLwhVTHhrzukxJkRHy6xQ2IMKX9ULZKQVEPciie30VzJNoddbFpKEwa9HeZVyxtk2v+HhbNjlUHXL0jILIe/Zui6xl/IVTYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747152421; c=relaxed/simple;
	bh=AtjmzhmTK2XEOwq1jRggREoKhGneutApb7VFOMLM7JU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqDomdkXM1jrsQXP+7bctKAdJhzDkzTIk7SYJBQw23d6d5uiQJYdBkMltWl88OSRWEav2drQ9RCrpt4VV9efuxw0T+XHdUhjue5K2tUU5jcck+ZNMFLynw5ppB1jTpovHm3snKVWYWQrWXYFLtF9cyOde0Wu6UepqBdcFaEjEUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zxh7T4f9Wz6K8xB;
	Wed, 14 May 2025 00:02:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 355F11402EA;
	Wed, 14 May 2025 00:06:54 +0800 (CST)
Received: from localhost (10.220.132.170) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 13 May
 2025 18:06:51 +0200
Date: Tue, 13 May 2025 17:06:48 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <lenb@kernel.org>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>, <nifan.cxl@gmail.com>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>
Subject: Re: [PATCH v4 2/8] cxl: Update prototype of function
 get_support_feature_info()
Message-ID: <20250513170648.0000517e@huawei.com>
In-Reply-To: <20250502084517.680-3-shiju.jose@huawei.com>
References: <20250502084517.680-1-shiju.jose@huawei.com>
	<20250502084517.680-3-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 2 May 2025 09:45:10 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add following changes to function get_support_feature_info()
> 1. Make generic to share between cxl-fwctl and cxl-edac paths.
> 2. Rename get_support_feature_info() to cxl_feature_info()
> 3. Change parameter const struct fwctl_rpc_cxl *rpc_in to
>    const uuid_t *uuid.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Oops. I missed giving a tag on this one.

Seems fine to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks for the poke. 

> ---
>  drivers/cxl/core/core.h     |  2 ++
>  drivers/cxl/core/features.c | 17 +++++++----------
>  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 17b692eb3257..613cce5c4f7b 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -124,6 +124,8 @@ int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
>  					    int nid, resource_size_t *size);
>  
>  #ifdef CONFIG_CXL_FEATURES
> +struct cxl_feat_entry *
> +cxl_feature_info(struct cxl_features_state *cxlfs, const uuid_t *uuid);
>  size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		       enum cxl_get_feat_selection selection,
>  		       void *feat_out, size_t feat_out_size, u16 offset,
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 1498e2369c37..a83a2214a136 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -355,17 +355,11 @@ static void cxlctl_close_uctx(struct fwctl_uctx *uctx)
>  {
>  }
>  
> -static struct cxl_feat_entry *
> -get_support_feature_info(struct cxl_features_state *cxlfs,
> -			 const struct fwctl_rpc_cxl *rpc_in)
> +struct cxl_feat_entry *
> +cxl_feature_info(struct cxl_features_state *cxlfs,
> +		 const uuid_t *uuid)
>  {
>  	struct cxl_feat_entry *feat;
> -	const uuid_t *uuid;
> -
> -	if (rpc_in->op_size < sizeof(uuid))
> -		return ERR_PTR(-EINVAL);
> -
> -	uuid = &rpc_in->set_feat_in.uuid;
>  
>  	for (int i = 0; i < cxlfs->entries->num_features; i++) {
>  		feat = &cxlfs->entries->ent[i];
> @@ -547,7 +541,10 @@ static bool cxlctl_validate_set_features(struct cxl_features_state *cxlfs,
>  	struct cxl_feat_entry *feat;
>  	u32 flags;
>  
> -	feat = get_support_feature_info(cxlfs, rpc_in);
> +	if (rpc_in->op_size < sizeof(uuid_t))
> +		return ERR_PTR(-EINVAL);
> +
> +	feat = cxl_feature_info(cxlfs, &rpc_in->set_feat_in.uuid);
>  	if (IS_ERR(feat))
>  		return false;
>  


