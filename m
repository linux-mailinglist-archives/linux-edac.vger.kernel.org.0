Return-Path: <linux-edac+bounces-2647-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 440D39E5EA4
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2024 20:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED07118852D5
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2024 19:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20493224B1C;
	Thu,  5 Dec 2024 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hnhbvH61"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE682EB1F;
	Thu,  5 Dec 2024 19:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733426010; cv=none; b=NHV6Rr6oF8kZberdH6vrJX7fVmrpdi6oveOb6A3jnfUpytFNGqWAboPVUJzK7FS34rrCzOgqscmEl+de9FGE3wHr25DEpS6mlFOGN7hzCW5SHI/CfcxIkbeW1rBdemxNbXXJQrFEtoVREDul8juWTEvjg9z2pOAGAacQw5Micj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733426010; c=relaxed/simple;
	bh=uKVVYvUP+96QuhyieQ/63r/Bv0JsazmeD1B8dpIRun0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjrLbh/+cO1CZOgyie+irsr9TPPS3NjhgkUm34tXLcLMUCE6K9XRO025bT+zeq2plBQpxVeOOuAEBry1r/8vJRjHkEKYhbWgA82DaufoFlUlVoDJ7hEBfpWD/qmkxvgePdr1yH8Wlbz5F7Kprh+NVuEzujjFOKBjF36KRHP1BSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hnhbvH61; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733426008; x=1764962008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uKVVYvUP+96QuhyieQ/63r/Bv0JsazmeD1B8dpIRun0=;
  b=hnhbvH61TC9p8Cb+NkSKJ059IBzMWzxrxmw1WzHjIqNkFbUvwDDUiEbb
   O5xUljfdS+/jc35H6CI99ID1+3QYY2lgDgQD8y3qNcPQm+QpGSxD+Y9MN
   6aWpY9OwGU0S3Mk7sMZS7lw0I9hG8VsPI2A/cGSuUZSc9vNo6lk/tSaS/
   Az2dnh+NmLe3yimHoio51brFvSK/bZhLnFUHYVTzq06RoqSJWpPTRrrJI
   JQUk3jXSyfyKwEkJABpvV4eMy+4S6+PeOTttvSV6enS5Cgfu97NntpLY8
   IA4ruzY48bmhX+ALeMwjrXr5xcFhgfOnrMP4JWAcJuBb2/xxUhNLqFowy
   Q==;
X-CSE-ConnectionGUID: 1u48spzRQsyVkSght+qxWA==
X-CSE-MsgGUID: 3G7EeReHSReSSHxO6qRGww==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="44234145"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="44234145"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 11:13:25 -0800
X-CSE-ConnectionGUID: 6WYqKMH/QnGhsBBCCFwHlw==
X-CSE-MsgGUID: wkXwfyaPT62IzHXmkrwlTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="125017469"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 11:13:25 -0800
Date: Thu, 5 Dec 2024 11:13:23 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: bp@alien8.de, james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/{i10nm,skx,skx_common}: Support multiple clumps
Message-ID: <Z1H7U9-O2LdAoa5r@agluck-desk3>
References: <20241205165954.7957-1-kyle.meyer@hpe.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205165954.7957-1-kyle.meyer@hpe.com>

On Thu, Dec 05, 2024 at 10:59:54AM -0600, Kyle Meyer wrote:
> The 3-bit source IDs in PCI configuration space registers are limited to
> 8 unique IDs, and each ID is local to a clump (UPI/QPI domain).

Is there any better name than "clump"?
> 
> Source IDs can not be used to map devices to sockets on systems with
> multiple clumps because each clump has identical repeating source IDs.
> 
> Get package IDs instead of source IDs on systems with multiple clumps
> and use package/source IDs to name IMC information structures.

What would happen if you just assumed the system had clumps and you
always used package/source? Would that change EDAC naming for
existing systems? That would be less complexity for the driver.

> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> ---
>  drivers/edac/i10nm_base.c | 21 +++++++++-------
>  drivers/edac/skx_base.c   | 19 ++++++++------
>  drivers/edac/skx_common.c | 52 +++++++++++++++++++++++++++++++++------
>  drivers/edac/skx_common.h |  5 ++--
>  4 files changed, 71 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
> index 51556c72a967..59384677d025 100644
> --- a/drivers/edac/i10nm_base.c
> +++ b/drivers/edac/i10nm_base.c
> @@ -1010,7 +1010,7 @@ static struct notifier_block i10nm_mce_dec = {
>  
>  static int __init i10nm_init(void)
>  {
> -	u8 mc = 0, src_id = 0, node_id = 0;
> +	u8 mc = 0, src_id = 0;
>  	const struct x86_cpu_id *id;
>  	struct res_config *cfg;
>  	const char *owner;
> @@ -1018,6 +1018,7 @@ static int __init i10nm_init(void)
>  	int rc, i, off[3] = {0xd0, 0xc8, 0xcc};
>  	u64 tolm, tohm;
>  	int imc_num;
> +	int dup_src_ids = 0;
>  
>  	edac_dbg(2, "\n");
>  
> @@ -1065,24 +1066,26 @@ static int __init i10nm_init(void)
>  
>  	imc_num = res_cfg->ddr_imc_num + res_cfg->hbm_imc_num;
>  
> -	list_for_each_entry(d, i10nm_edac_list, list) {
> -		rc = skx_get_src_id(d, 0xf8, &src_id);
> -		if (rc < 0)
> -			goto fail;
> +	rc = dup_src_ids = skx_check_dup_src_ids(0xf8);

Checkpatch complains about this: "multiple assignments should be
avoided"

> +	if (rc < 0)
> +		goto fail;
>  
> -		rc = skx_get_node_id(d, &node_id);
> +	list_for_each_entry(d, i10nm_edac_list, list) {
> +		if (dup_src_ids)
> +			rc = skx_get_pkg_id(d, &src_id);
> +		else
> +			rc = skx_get_src_id(d, 0xf8, &src_id);
>  		if (rc < 0)
>  			goto fail;
>  
> -		edac_dbg(2, "src_id = %d node_id = %d\n", src_id, node_id);
> +		edac_dbg(2, "src_id = %d\n", src_id);
>  		for (i = 0; i < imc_num; i++) {
>  			if (!d->imc[i].mdev)
>  				continue;
>  
>  			d->imc[i].mc  = mc++;
>  			d->imc[i].lmc = i;
> -			d->imc[i].src_id  = src_id;
> -			d->imc[i].node_id = node_id;
> +			d->imc[i].src_id = src_id;
>  			if (d->imc[i].hbm_mc) {
>  				d->imc[i].chan_mmio_sz = cfg->hbm_chan_mmio_sz;
>  				d->imc[i].num_channels = cfg->hbm_chan_num;
> diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
> index 14cfd394b469..189b8c5a1bda 100644
> --- a/drivers/edac/skx_base.c
> +++ b/drivers/edac/skx_base.c
> @@ -600,8 +600,9 @@ static int __init skx_init(void)
>  	const struct munit *m;
>  	const char *owner;
>  	int rc = 0, i, off[3] = {0xd0, 0xd4, 0xd8};
> -	u8 mc = 0, src_id, node_id;
> +	u8 mc = 0, src_id;
>  	struct skx_dev *d;
> +	int dup_src_ids = 0;
>  
>  	edac_dbg(2, "\n");
>  
> @@ -646,19 +647,23 @@ static int __init skx_init(void)
>  		}
>  	}
>  
> +	rc = dup_src_ids = skx_check_dup_src_ids(0xf0);

Checkpatch complains about this: "multiple assignments should be
avoided"

-Tony

