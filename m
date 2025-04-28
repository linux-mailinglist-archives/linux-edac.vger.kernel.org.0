Return-Path: <linux-edac+bounces-3779-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2E5A9F865
	for <lists+linux-edac@lfdr.de>; Mon, 28 Apr 2025 20:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351044635BC
	for <lists+linux-edac@lfdr.de>; Mon, 28 Apr 2025 18:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220002957A8;
	Mon, 28 Apr 2025 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/RTADmT"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FEB1A072A;
	Mon, 28 Apr 2025 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745864549; cv=none; b=L6DwExbZN40fLUXpaYeVhkTyO0R5V+uo93Y6oqG1REPkv3znuXtEagHnwqH7bkFb7zOjZAod3SDi+eOEEcYl/PYqgRRK0J9g0tPljZhy8K6LeYa84C+UJMtLN2hYmCp9yc3zrs4bV5E4yonAMrxRRyU8ibCuAYI/FgNgl7mF99E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745864549; c=relaxed/simple;
	bh=HmYXJggRGYD1I4R26HOZ3P7wrMufPbzK3B6MhpkP79M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZA7apep774+pMRBIG5mFAgh70dG/6yKLxLS3tB3lHsf6khvQTMSCXslAiSZYjDFMD5gzqxJviXnzjNMTG2pQRMH8nXmUTGS91X/y6WLn1xyB9BhFGcdNZLlnYCYQmyqvdkMom7T3k1IHk0tV5z9LaPbTV+/DOwNFw7eUm/FkF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/RTADmT; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745864547; x=1777400547;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HmYXJggRGYD1I4R26HOZ3P7wrMufPbzK3B6MhpkP79M=;
  b=g/RTADmTF0erCy+zC63OI9wvsowOUGqHRuRxHLESClgD7DNTrDFGq3Ze
   V3GIQCgweUHzuxQS8zLtHYXhe+cWKKRSy0fL7AzFLQrFL2XApjeBUhm+2
   j+0lYyxUINGONHvQTTpsQP32K8PrNFb4XjnRgYdNPUK2/p2ni3pfU1M3e
   YC4vB4z3JjZAndvRMIqZ6VTnEE81fx+96hQdNGWMKnz82o7SBhZ4etiP9
   URPL7cazoFty8wR94RLw52AQJy23Uf+aEvdMpp+HnisNvNu5ladWHi9Pd
   gY7roZrhJCZWJkqY3IPFoSvfnDxm8EGtDW7b2Ljip+wA2P/1kt30Sik+h
   g==;
X-CSE-ConnectionGUID: LKm0iGccQrGWza32d/UWhg==
X-CSE-MsgGUID: ImQZFvTZQ7uZZLa8rpbiRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="65002037"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="65002037"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 11:22:26 -0700
X-CSE-ConnectionGUID: Ca+oLJAmR1yp4vj+TBlbwg==
X-CSE-MsgGUID: I1An/AcCT+K9563/9XOo8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="170817731"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.95]) ([10.125.109.95])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 11:22:24 -0700
Message-ID: <b1d2a538-d4e2-457e-aed4-3ff827e2393f@intel.com>
Date: Mon, 28 Apr 2025 11:22:23 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] cxl: Update prototype of function
 get_support_feature_info()
To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com, jonathan.cameron@huawei.com, dave@stgolabs.net,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com
Cc: linux-edac@vger.kernel.org, linux-doc@vger.kernel.org, bp@alien8.de,
 tony.luck@intel.com, lenb@kernel.org, leo.duran@amd.com,
 Yazen.Ghannam@amd.com, mchehab@kernel.org, nifan.cxl@gmail.com,
 linuxarm@huawei.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
 roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
 wanghuiqiang@huawei.com
References: <20250407174920.625-1-shiju.jose@huawei.com>
 <20250407174920.625-3-shiju.jose@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250407174920.625-3-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/7/25 10:49 AM, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add following changes to function get_support_feature_info()
> 1. Make generic to share between cxl-fwctl and cxl-edac paths.
> 2. Rename get_support_feature_info() to cxl_feature_info()
> 3. Change parameter const struct fwctl_rpc_cxl *rpc_in to
>    const uuid_t *uuid.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/core.h     |  2 ++
>  drivers/cxl/core/features.c | 17 +++++++----------
>  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 15699299dc11..1d96e7acf9cc 100644
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
> index f4daefe3180e..35c91f14c761 100644
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


