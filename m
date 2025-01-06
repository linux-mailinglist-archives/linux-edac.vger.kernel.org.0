Return-Path: <linux-edac+bounces-2812-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E079EA026C5
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 14:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33A81620FE
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 13:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C811DDC2C;
	Mon,  6 Jan 2025 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="a6r/e+yp"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D2C1DA100;
	Mon,  6 Jan 2025 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736170716; cv=none; b=D0XO/MN61rL4L3jTTu27Yv7/nZtQ12CZeePnfO3FKeD0g4Ww8OnerEAYCejjEp7HDXUuVgo14tBBM+mPP/XpcSSd+cqLOnpGlVcImu5lmRFGdFFuKhZXrBc4jSZ82AFh8pYPZM5ZJr2p22ZqnzViFuI2AgyqyvtdPN9WpDmZtEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736170716; c=relaxed/simple;
	bh=+jOH/os/OH2wiXEF/8CVroc8Vk6VDiIIXXaceeAFkhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umVzGu7IVkX/EAaNU7NVVxv4Pya4GL0zx675ziox/loaWF+uuAxc5sIuLi5I1AMXeW2B7ZFtUOTkIbiRuMoTx7aYqEi5e0lpcLIL+EAMSadvtKsp570Dqkqygz9k3naJ1cPVFBwlPQLPGHHR4ii84pquScCaeN2O+SJfyc0R95o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=a6r/e+yp; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B576540E0264;
	Mon,  6 Jan 2025 13:38:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id H0HQOCO2LQHj; Mon,  6 Jan 2025 13:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1736170706; bh=vapTAC/GEEGTnYZ53xdjNO/fhQQizrf5LOYcJ/SbwYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a6r/e+ypRHhvgbzh/mgij/5mJlINJJ6teS9ui0CKYuuhEQQzvPk88j8Qo1uF6HgVY
	 y7uHlTsz+z4b28mjXefVpUxSVF3629CxLIPUPGob5zJpBPPTNxrZZlpIUA4spHVKgq
	 8wv9JBYWNgKDxkBrxCUcHpkHed/D6r4VU8kvxaUMonfXUGpZCuQIBbkGKA0gLohUpj
	 shXxeLOLWZrxRJEDJ7T0/I6MRqnuaLOvHEENc44GIdVSQrGmia1E5m0gFMKnEQQ+Cu
	 HgN73nLNk2nX7sOgdye+iab+ZPug9yNYae2YqU2dyQ4n1xtRKsqyqW/xqxA7EJZdaM
	 j2Pttwql9X5yJMtiFZzz3h9IQ+QAnezz/Yeu0DW6rnC7iKrMuk/P8tnaVxqu972FoF
	 +bf5Wuwps1Zjis54u7LFzxu0zCmab48GtFzFhdSnhird8p/ekllkn3H4NialDr8mLC
	 tC2JSsDD+tKqjO/IUSo0ZFRcXo+GhCL6qjdIX1/hehTzPJrh8zy/KKSy7LpTgqho8R
	 qIxJqc5tGD1xvrPMSi0kY84DY7SZXv/mAxFbJooMcdJTbbrnBzI3sfiQpqMk1l6WAV
	 rCyp1rTorZ9PAFQFqkTHydNY4/Ie+/fAfonKg/1wHK/yaED+HaUJwzSfbDnB8Wm9pg
	 hrky52M2BnDnUbve+dlUu4yg=
Received: from zn.tnic (p200300EA971f93E8329C23fFFeA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93e8:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C9A140E0163;
	Mon,  6 Jan 2025 13:37:43 +0000 (UTC)
Date: Mon, 6 Jan 2025 14:37:36 +0100
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	rafael@kernel.org, lenb@kernel.org, mchehab@kernel.org,
	dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, david@redhat.com, Vilas.Sridharan@amd.com,
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
Subject: Re: [PATCH v18 01/19] EDAC: Add support for EDAC device features
 control
Message-ID: <20250106133736.GDZ3vcoEBa-lJwqAxL@fat_crate.local>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
 <20250106121017.1620-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250106121017.1620-2-shiju.jose@huawei.com>

On Mon, Jan 06, 2025 at 12:09:57PM +0000, shiju.jose@huawei.com wrote:
> +int edac_dev_register(struct device *parent, char *name,
> +		      void *private, int num_features,
> +		      const struct edac_dev_feature *ras_features)
> +{
> +	const struct attribute_group **ras_attr_groups;
> +	struct edac_dev_feat_ctx *ctx;
> +	int attr_gcnt = 0;
> +	int ret, feat;
> +
> +	if (!parent || !name || !num_features || !ras_features)
> +		return -EINVAL;
> +
> +	/* Double parse to make space for attributes */
> +	for (feat = 0; feat < num_features; feat++) {
> +		switch (ras_features[feat].ft_type) {
> +		/* Add feature specific code */
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ras_attr_groups = kcalloc(attr_gcnt + 1, sizeof(*ras_attr_groups), GFP_KERNEL);
> +	if (!ras_attr_groups) {
> +		ret = -ENOMEM;
> +		goto ctx_free;
> +	}
> +
> +	attr_gcnt = 0;
> +	for (feat = 0; feat < num_features; feat++, ras_features++) {
> +		switch (ras_features->ft_type) {
> +		/* Add feature specific code */
> +		default:
> +			ret = -EINVAL;
> +			goto groups_free;
> +		}
> +	}
> +
> +	ctx->dev.parent = parent;
> +	ctx->dev.bus = edac_get_sysfs_subsys();
> +	ctx->dev.type = &edac_dev_type;
> +	ctx->dev.groups = ras_attr_groups;
> +	ctx->private = private;
> +	dev_set_drvdata(&ctx->dev, ctx);
> +
> +	ret = dev_set_name(&ctx->dev, name);
> +	if (ret)
> +		goto groups_free;
> +
> +	ret = device_register(&ctx->dev);
> +	if (ret) {
> +		put_device(&ctx->dev);
> +		return ret;

Who is freeing ctx and ras_attr_groups when you return here?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

