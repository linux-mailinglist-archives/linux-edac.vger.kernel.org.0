Return-Path: <linux-edac+bounces-3306-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 881D1A5717E
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 20:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD95188ED4B
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 19:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7A8253336;
	Fri,  7 Mar 2025 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXNuixpY"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB80824FC03;
	Fri,  7 Mar 2025 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741375189; cv=none; b=bBPu1Xk/8n44iJ1CwPfGerO+sd4ci46p0KFOAiQr2iALgHWXe9jjeG2GB2euWf7p1scjLs8x6cwLmjlp0+/lVzi/AZgkgRkTWbL+L14ln1FvZ2hhbDkSkHv5FpiwCQw9qP4Yn5DUAoGDLPyLpVhvczjLfwgy61/7ClQijLua8n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741375189; c=relaxed/simple;
	bh=lWohW1lK5/1oJ/E8ckkRCgfaedm9zAHAHPnzlFJse9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBNIAadjlyGdXorS7iye14a1xu4n0S2RRNLJ9XaNEbHJXccOb80/owrlfnDZFNm8eaoUPLpfzil7ORwNJ88JpSOauT/Bs7XrtLcWzPyRgn1ozasGzDaOIlxj2rVTzcKk8qjjQtjcIcpbrgLVBjXM0ZkBMaBENgUgzDqEVtbF4BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXNuixpY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741375187; x=1772911187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lWohW1lK5/1oJ/E8ckkRCgfaedm9zAHAHPnzlFJse9c=;
  b=YXNuixpYDKlmanDTBmjWP2bRVI3W7+suQ01y6CcBiN0eeggig9r8dxWg
   7RfXyjVLduEji/xArpC+BynyRCDDewvdwgptmK3MRGMw3pDFcbGeINLZF
   eCxBV0Lf99knCSOr3AAjTzZ9lh/hTQti8285sqshVKeAx90BhqusrMq4J
   WKz8Dmf69iC4fxpAhYJWiYIbvXX5MqVc8+0a2IdZYFOJG8961Xt7rfd4p
   DnTiOFAgiKu+P2WsHE4CXG9TvNNj5io+tvgeTwD+OhJHF9dW9MGNu66DQ
   wvj83BOo01dHtdlKrgIYzgaNB8aT2idVvBaJ0+yWxSETGTPzC0c9nCGUY
   Q==;
X-CSE-ConnectionGUID: ve7o6fAIQCaSUttKnRyKNg==
X-CSE-MsgGUID: XhRJyq1gQbWwlMNTUYBz3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42315416"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="42315416"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 11:19:46 -0800
X-CSE-ConnectionGUID: CfyhsuotQIeGhCi5YnLAaA==
X-CSE-MsgGUID: ze8qhkRFRD+Y3Nyxiz0cpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="156621322"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.159])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 11:19:44 -0800
Date: Fri, 7 Mar 2025 11:19:43 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, david@redhat.com,
	Vilas.Sridharan@amd.com, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bp@alien8.de, tony.luck@intel.com,
	rafael@kernel.org, lenb@kernel.org, mchehab@kernel.org,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, rientjes@google.com,
	jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH 1/8] cxl: Add helper function to retrieve a feature entry
Message-ID: <Z8tGz33l9vDzuJLy@aschofie-mobl2.lan>
References: <20250227223816.2036-1-shiju.jose@huawei.com>
 <20250227223816.2036-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227223816.2036-2-shiju.jose@huawei.com>

On Thu, Feb 27, 2025 at 10:38:08PM +0000, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add helper function to retrieve a feature entry from the supported
> features list, if supported.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
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

Do we need some NULL checking here on cxlfs, entries


> +	for (count = 0; count < cxlfs->entries->num_features; count++, feat_entry++) {

Was num_features previously validated? 

> +		if (uuid_equal(&feat_entry->uuid, feat_uuid))
> +			return feat_entry;
> +	}
> +
> +	return ERR_PTR(-ENOENT);

Why not just return NULL?


> +}
> +
>  size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		       enum cxl_get_feat_selection selection,
>  		       void *feat_out, size_t feat_out_size, u16 offset,
> -- 
> 2.43.0
> 

