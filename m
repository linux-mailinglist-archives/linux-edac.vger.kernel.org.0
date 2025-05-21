Return-Path: <linux-edac+bounces-3982-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64908ABFB4A
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 18:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7951F7B22F4
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 16:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E997F1E1DE8;
	Wed, 21 May 2025 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtDyU5nw"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C39716DC28;
	Wed, 21 May 2025 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747845088; cv=none; b=HhalzzZOQmREk0MTkmpQLsRorlDHuEXjMgUcKtquO6cLn2/DLzf5kol+3hArG778cBEz143tdCXk3Z1Knh9ZpvECVAVQ/gbatNR1VM78xrfb+9sjtVN44Uh041QcbPMaFdahzS9wB2/vEBdlIB+IUU06TKY24QJndNOS49FGVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747845088; c=relaxed/simple;
	bh=rVB01lYj9aSiT3vcqWaafdFMVB8ErPQivfkQKiIe7l0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HO7B8HJVta8CwnzievMg1bJJ8GYcoM4xZinPpirODJ+pfgnG6xKU8TbfFEbtY52RQa5OJwdzSKmA3inqQkcIbVxqAeIOooFl+oSQV8YS2ZmjorW2h0UrGQAxIt1IugXWWr2H/KiiMHzn9l39pD+HcQs6EJUJYVNuD+4ZZhXOmtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtDyU5nw; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742c9907967so3775288b3a.1;
        Wed, 21 May 2025 09:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747845086; x=1748449886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pn+w0D/TRnBKc0XGfluQ6lHdM8uAAWfVWv0XUbJbjwQ=;
        b=BtDyU5nwL9EiOLka25a7YpjM/MjOslV8jfFmdhPJUJgdafMdy+so3m29wNtO0wIU30
         q2WvvL0ZMB2UOhqLO5LeV1T/k6Rg8/yFxlC72EJxGGK/f70IXNv8FcFw3qrT/mdTpZlE
         t1At9NcrbLT9EYSn6VzCUY33lNbW3j6TgR/W5LE786JXrxYjVCt8rLYC+wCntM/4UM/2
         xt6tEAN9xAsgomZBGh4yfS7DUO+Vy56+mbzhhRBwcGw5xILjdZ0xFHpJi00odn9kx/Ud
         nI0lFW2DZksrfzyXmY+MPadps05cklbom5wL5L8qc2K1ur1or1DjM1MNXjmHtxCWZZf2
         auVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747845086; x=1748449886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pn+w0D/TRnBKc0XGfluQ6lHdM8uAAWfVWv0XUbJbjwQ=;
        b=oN1kUHuGTOsbFLrJGujPBPvzdflYjQiTlC8b+vlbQvKoWNVziLdsA3bvn3CxfATeZm
         UQpOJsar28+Ch19rMetvjYKw63rxKrH+u6+l1Q0UyP9ivZJvw5PJ1P0htOljUE+x1ZN7
         C29lSU1qK6I/CE66/rriQnLXuK0YDH1KEgPoqiRW18vIcL+rBkxgkCV0Fomfp24TvTAm
         DQNm6MBebJvEMoMQDcbzAm6LhgXKdmXh/F4/KZA10yVGKTBWPF1RlfXPg/479xx6ifhB
         +xOxf8HTSixp5a8fvLj7RFJjTyC8fkUvJNCzAcenUFYSPBniCxRgJzoSHkmZmSLvf/yj
         wBig==
X-Forwarded-Encrypted: i=1; AJvYcCVqORxl3t6dXeBUsFmP//okFvZcluOf1J4vknj7q9ktW6cP1PZV/rvSc1HNSQS5Cgys9NdDqMm2XPI=@vger.kernel.org, AJvYcCXjDfIPquu8Yhxw6qA0vc0kL/lG8lt7IXUSrFIQqQlulx6JfusMy/ARYMCV5Va7Ht+PDvenh33TNKXeOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj1D1L3xXS8K01+DG9F5mIghcnzAPVFVYSZcVBOn8mwClOMTxl
	A4Air7o6NtC11sTvjJ3/6v9CW80DG8QKazqfIuJPZDna4hE96f8yEnAF
X-Gm-Gg: ASbGnctH0lo9abV7B4xtCEIgyoecIzibyPSsVzrtPLB9eshIxw/m2T5emherbste613
	FSmhr4JnEnkKeOk66RZFSpmp07qAa6vwkXEKNS1c5KVjbab4/o2kqoXGlnszfjsweKIx/JXBxHs
	K7qDWue5q+TrdRQwBm+yNDSnAZc6n4WfmxiAMMw4Fb51HfSQJno7o+imi1wlalzE8Q/VzPW6f38
	6j0RDCTG/D9QeJajFRk5to8YeBWi/gEIcU91vrfqmAKeKkRjntwchxqu2QAmw1aWh0lw+seNuFm
	XyDfblGcEspZcC2PwW+pM/50GP/BAMmguBJ/ohw9cgUJMnl9PlRe0Fg=
X-Google-Smtp-Source: AGHT+IFp3n+dKx2GtdCyvAzDa8TfjiGZUSlOh+tuuS6LDqMXZsXk+ZYSPh7mhl+zVFsgztmW2lbtQQ==
X-Received: by 2002:a05:6a21:3511:b0:206:a9bd:a186 with SMTP id adf61e73a8af0-21621882718mr36715905637.3.1747845086441;
        Wed, 21 May 2025 09:31:26 -0700 (PDT)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970b7bcsm10073651b3a.52.2025.05.21.09.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 09:31:25 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 21 May 2025 16:31:23 +0000
To: shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	dave@stgolabs.net, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	linux-edac@vger.kernel.org, linux-doc@vger.kernel.org, bp@alien8.de,
	tony.luck@intel.com, lenb@kernel.org, Yazen.Ghannam@amd.com,
	mchehab@kernel.org, nifan.cxl@gmail.com, linuxarm@huawei.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com
Subject: Re: [PATCH v6 2/8] cxl: Update prototype of function
 get_support_feature_info()
Message-ID: <aC3_2xDB7kR2a-qA@smc-140338-bm01>
References: <20250521124749.817-1-shiju.jose@huawei.com>
 <20250521124749.817-3-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521124749.817-3-shiju.jose@huawei.com>

On Wed, May 21, 2025 at 01:47:40PM +0100, shiju.jose@huawei.com wrote:
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
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

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
> -- 
> 2.43.0
> 

-- 
Fan Ni (From gmail)

