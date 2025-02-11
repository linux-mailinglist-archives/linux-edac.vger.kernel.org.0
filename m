Return-Path: <linux-edac+bounces-3010-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5E8A30198
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 03:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB84167BDD
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 02:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D731CAA60;
	Tue, 11 Feb 2025 02:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVDa9OLN"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1201B6CE9;
	Tue, 11 Feb 2025 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739241614; cv=none; b=XLwpPpVpDoWauTa95Gv8CVtC3AQtd48/NX1VrN9DE+DBaRujznKr9oLqboeLN+rVWcenHevkQtl6OBJTQItlwR5gQL5SaTmOAB7xMtzXrYB26/jY+VoYtubZ6diy0xTDr8L2ZdUMW5xvP8EpboPwpUVRROy/zLpcObsLUcFG43I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739241614; c=relaxed/simple;
	bh=n2oinbXtGGE6y9EV6Pn/imw8Ob/8ITCtlHNl/OvbJDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFULUEGCvyWbXaW6S9xwJDJN7hjAAG1xhWXjxuN48RkrFPeZOrL9Jk8JS/wkgaN9ir+qREq9uoPwOrDzwxc3saVAstfmbX2+5L2grLj3l1IyHyXXuuFFgq0ITLlJ1OdLPTEtDpYYpczJeKclHPWoxtICQTLXcmwUeiMk3I9DdbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVDa9OLN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739241612; x=1770777612;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n2oinbXtGGE6y9EV6Pn/imw8Ob/8ITCtlHNl/OvbJDc=;
  b=eVDa9OLNX8svr/8CEDFqaDruQ7HGVqQHlZPVIt2jY96fVcPgHPmK1m+2
   Q3o2WbDSdxZ2uS0t9O38hCYH6Rrkq8IqbRD9NIcMHd/EnqrU6T1iWOGXl
   e5l5SKULteLU0wuwE2mlCkvON7ddpHhUOTLkenx+JQwwrUYx0542i1nwZ
   /r+EF9bIaA8/ca/l5kCrHpM7SHF8xWvcSRSuACveXN7TqfRS/ThCZXcp8
   P8x2p2Y5u3u6j4mmn3sqL+fCtCKkqurXKYEQ6TTB9L82qGhkFo7TxzT2g
   5TA/UeN9HihS//QXY4ahEGNHxKen2DHMIZkuPs+MubhGXXIiekbHofJe2
   Q==;
X-CSE-ConnectionGUID: aA/TviufSaCV/CfUnhaR6g==
X-CSE-MsgGUID: e7PIi1/1QBGV7aGDdFiz6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="43775072"
X-IronPort-AV: E=Sophos;i="6.13,276,1732608000"; 
   d="scan'208";a="43775072"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 18:40:11 -0800
X-CSE-ConnectionGUID: QNak6SWmRKSj3idvZIkL7w==
X-CSE-MsgGUID: zv89mSVRRJq8wFJvqtbxwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,276,1732608000"; 
   d="scan'208";a="143229130"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.111.192]) ([10.125.111.192])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 18:39:52 -0800
Message-ID: <99a80c40-4c1d-4dc6-8b44-397f49460501@intel.com>
Date: Mon, 10 Feb 2025 19:39:51 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 07/15] cxl: Add helper function to retrieve a feature
 entry
To: shiju.jose@huawei.com, linux-edac@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, bp@alien8.de, tony.luck@intel.com,
 rafael@kernel.org, lenb@kernel.org, mchehab@kernel.org,
 dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 david@redhat.com, Vilas.Sridharan@amd.com, leo.duran@amd.com,
 Yazen.Ghannam@amd.com, rientjes@google.com, jiaqiyan@google.com,
 Jon.Grimm@amd.com, dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
 james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
 erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
 gthelen@google.com, wschwartz@amperecomputing.com,
 dferguson@amperecomputing.com, wbs@os.amperecomputing.com,
 nifan.cxl@gmail.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
 roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
 wanghuiqiang@huawei.com, linuxarm@huawei.com
References: <20250207144445.1879-1-shiju.jose@huawei.com>
 <20250207144445.1879-8-shiju.jose@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250207144445.1879-8-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/7/25 7:44 AM, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add helper function to retrieve a feature entry from the supported
> features list, if supported.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/features.c | 21 +++++++++++++++++++++
>  include/cxl/features.h      |  2 ++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 5f64185a5c7a..bf175e69cda1 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -43,6 +43,27 @@ bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry)
>  }
>  EXPORT_SYMBOL_NS_GPL(is_cxl_feature_exclusive, "CXL");
>  
> +struct cxl_feat_entry *cxl_get_feature_entry(struct cxl_memdev *cxlmd,
> +					     const uuid_t *feat_uuid)
> +{
> +	struct cxl_features_state *cxlfs = cxlmd->cxlfs;
> +	struct cxl_feat_entry *feat_entry;
> +	int count;
> +
> +	/*
> +	 * Retrieve the feature entry from the supported features list,
> +	 * if the feature is supported.
> +	 */
> +	feat_entry = cxlfs->entries;
> +	for (count = 0; count < cxlfs->num_features; count++, feat_entry++) {
> +		if (uuid_equal(&feat_entry->uuid, feat_uuid))
> +			return feat_entry;
> +	}
> +
> +	return ERR_PTR(-ENOENT);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_feature_entry, "CXL");

You probably don't need this if the memfeature code are in CXL core. 

DJ

> +
>  size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		       enum cxl_get_feat_selection selection,
>  		       void *feat_out, size_t feat_out_size, u16 offset,
> diff --git a/include/cxl/features.h b/include/cxl/features.h
> index e52d0573f504..563d966beee5 100644
> --- a/include/cxl/features.h
> +++ b/include/cxl/features.h
> @@ -68,6 +68,8 @@ struct cxl_features_state {
>  };
>  
>  struct cxl_mailbox;
> +struct cxl_feat_entry *cxl_get_feature_entry(struct cxl_memdev *cxlmd,
> +					     const uuid_t *feat_uuid);
>  size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		       enum cxl_get_feat_selection selection,
>  		       void *feat_out, size_t feat_out_size, u16 offset,


