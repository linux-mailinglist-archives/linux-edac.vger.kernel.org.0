Return-Path: <linux-edac+bounces-3296-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A72C9A55D64
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 02:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2569170968
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 01:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3F81624F6;
	Fri,  7 Mar 2025 01:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HS3UycWY"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017AD85931;
	Fri,  7 Mar 2025 01:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741312740; cv=none; b=jOHncw6KNRv6O5JTjsA8mCUm2UCw/EyazvbjwcVBntpyHFwAN5nvd5KTCK4mO8bc8d+TixCL261MI86Nn26lfrwDP5BmQOjnS46T5K+6ABXxJhBmr5JK/nca+oTgUO5yHjHpXTcrVvh6EZhaOTz92ud6xpEbU8MhCQecjZZxfzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741312740; c=relaxed/simple;
	bh=SO5dJfUAzOaReuCv9zTayxuehk9CekNpUpgtIP8rz9I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7Kx2aaRBK1tJLaVFFdTM1/xqCoOchQCuphUZ7FvT2R0ZQEEr6tXWTjqJRiEc5bN8zambbGfnYa8eIjpJKv+kTFcaR/iG/+hPfte4AjyfvMckO1bGNVd3aCw6Fj4IdTlmLyUi9sln6tNn8q4zW4g4KVvu42RN3DAPuTCZMrgUMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HS3UycWY; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2239f8646f6so25421295ad.2;
        Thu, 06 Mar 2025 17:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741312738; x=1741917538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ECoNV4kHAT50hvGTY86CJfgCjEmWaFi+qU8bYOh0B0Q=;
        b=HS3UycWY8ZyS81S0HhRV1+gNt7WDtkZcak+omKAlW/7lDj133dsGMjj7ezDE6w+zhn
         XH1Gk5x5g2BUvf1ezH4nDBAQn6j1v6dRPu2U1ljbfORgl1q5HCVvQmhPNNQnZKGO7r+v
         C9jg6hwr9cgtK0pw7dC/5jJ92RP4j+KlWTuJAVnhwiqEDQIlnFbx/HQNs6OzDBhOutNq
         F2GMV2i4uJmin9Nn0g6sBJUPxFI4oryRbzATYXMyO1Sts4KH6A2xsCkIuCMy1E3atcbR
         2zaah0i8BZqOgpniM7+qLEAt8CbDs/ojYdOUOMAQsTBeoZmL66x4TFdquF3KoqEf7ngK
         99nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741312738; x=1741917538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECoNV4kHAT50hvGTY86CJfgCjEmWaFi+qU8bYOh0B0Q=;
        b=vwVwWk6qYwkFY6QOM9YjOr7WgrHmr/YCKRset6RpSS4euH+xVHx1/zHYDlzc9OP+wW
         zkwRJg6RAENP1KU6kwdE8PcyZZBsbqa0KJ3gTV35cJTy0jLVzJUjwJxo1/efIJ+m0nAF
         Urh66c0Tfv6mOopmODhV+Blwle4yXgzF8DS9s/CTKrH+QtV8OcqvpHKFd0cNtSuhExrs
         vZxiba6hgN52f6Btch3vF72Mc7nd6dphTl6lZpSC+TaLh7h9jl8SvZNBNfHEbHgjuOtN
         YD2eIb/TQsBGVK4xztRwzm8pChkvu7IU6ScqjR6RxELnEkrEkKgQ1SmHqUD2Yx2/wS+a
         rufw==
X-Forwarded-Encrypted: i=1; AJvYcCUmRk4c16H7wwrg0W/T2r56l7xPbTqCYQ41MMWTp+IbWChdcAJmQa50RPhkmgEtCZt2+0tIWEujidhgtw==@vger.kernel.org, AJvYcCVrAAkKLt4ISqGQyXuQ9KyuGo0S7QsBEGKRuQxllpcnNh1yhMijCvaUnK6yAfQFD8PFtiBVemNYEU1BDmk7@vger.kernel.org, AJvYcCX+L0ZCgkrWi4oCwGQ9nsKTxGqgm0EPSdaT/mSpDF8qggBeHuq6j2M38jlj7N8PUfkyWd18HpH3Eyqw@vger.kernel.org
X-Gm-Message-State: AOJu0YwH0kS2ZglMRCXZ0Y8CRrKJG8LNlTA7J6H2rZPBm2T6+RWFQm2K
	ZL6SpvhTmJZj1X47iNqTwhqS+0kWKpOQTyJmNQ9Qoi5v4CDPO8yG
X-Gm-Gg: ASbGnctftrot2wKq50itRjchsxyJdUKA0PPNVqxcI+E2FyG6BXgF/PGL38BMYhmKUqy
	cc2eb4E8jfcbOUG94DZuuhn2+N7EzId3hZ2iqhCkj8kHbLkA4be94Pi3HACnKa4ngMovosPfse1
	4yOGmE0L0OF5ETGMzb2/Z8UikVvTrqFgPuqzTjmQktGnsUw//cg60K98sdlb+uhIZIrAP9buiah
	nTzU+aHS9Ma5mgfeGx0HJNpeCjL65q+GtNqtBWukOA1BUXi/T3zJv1zqyDP+60sNV5LAfRbnVlQ
	e85yjdqlXluP09k7M4ZoFSzPOU4BsFhxhAAwsAo=
X-Google-Smtp-Source: AGHT+IEjw6rCh3qXzIOYCz6LrbC5tDDItMPSnIX6vQ3xn2TeukYDLpMq4pY2PvjifGCV+mnZTC2cGA==
X-Received: by 2002:a17:903:283:b0:216:2bd7:1c2f with SMTP id d9443c01a7336-2242888d06amr21833985ad.18.1741312738064;
        Thu, 06 Mar 2025 17:58:58 -0800 (PST)
Received: from debian ([2601:646:8f03:9fee:e44d:748a:50ed:471f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410ab9e39sm19138105ad.252.2025.03.06.17.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:58:57 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 6 Mar 2025 17:58:38 -0800
To: shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, david@redhat.com, Vilas.Sridharan@amd.com,
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, bp@alien8.de,
	tony.luck@intel.com, rafael@kernel.org, lenb@kernel.org,
	mchehab@kernel.org, leo.duran@amd.com, Yazen.Ghannam@amd.com,
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	gthelen@google.com, wschwartz@amperecomputing.com,
	dferguson@amperecomputing.com, wbs@os.amperecomputing.com,
	nifan.cxl@gmail.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com,
	linuxarm@huawei.com
Subject: Re: [PATCH 1/8] cxl: Add helper function to retrieve a feature entry
Message-ID: <Z8pSzpmzHfimDxEH@debian>
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

Reviewed-by: Fan Ni <fan.ni@samsung.com>

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
> -- 
> 2.43.0
> 

