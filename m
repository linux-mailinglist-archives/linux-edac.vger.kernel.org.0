Return-Path: <linux-edac+bounces-3980-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFA4ABF8CE
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 17:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2E6188FDD8
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 15:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ECA1E1A16;
	Wed, 21 May 2025 14:59:15 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3BB1E2848;
	Wed, 21 May 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839555; cv=none; b=M6gRYRyZRCwFTs9WvWa6eosqjpeDvGWRQUrnCyg72Lzephy4gqqBVuNQuTsrZvVz+CiwFz/O8NfQO/EfJyG2C8UJak8P3gRgu2M8oFjQ2GeUKCm6BIhj4C+nAyQbYGFCmrN4VZAVJ8qXpPthOrhPEL3ClSLAiU4gluGlO9n+pYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839555; c=relaxed/simple;
	bh=VhoYv1um9lBplgW5VKV6r1deHZvelLp1koLve9wVlLQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SN1zmJKdPbatWJWBxw24TlEfBmhwCs+Ih2BXy0ywnYTV/Qhi37AbRFanIibZwBtnq0zLODfjyPpV84XpjBSsilfyI1a8iFO9bJTf93MxPSkWT5rnEe6saKS6HcL5HYKaQiwg1n/T1kTsZsda/5WKrPb4LlOrrACT5RWRLrkSlhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2ZL06TPzz6GD9h;
	Wed, 21 May 2025 22:58:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E82D140391;
	Wed, 21 May 2025 22:59:10 +0800 (CST)
Received: from localhost (10.195.34.206) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 May
 2025 16:59:08 +0200
Date: Wed, 21 May 2025 15:59:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <lenb@kernel.org>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>, <nifan.cxl@gmail.com>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>
Subject: Re: [PATCH v6 0/8] cxl: support CXL memory RAS features
Message-ID: <20250521155906.000018cb@huawei.com>
In-Reply-To: <20250521124749.817-1-shiju.jose@huawei.com>
References: <20250521124749.817-1-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 21 May 2025 13:47:38 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Support for CXL memory EDAC features: patrol scrub, ECS, soft-PPR and
> memory sparing.

Thanks for the quick turn around!  I took a (hopefully) final look through
and all I found was a couple of places where white space was slightly off
after the refactors for v6. Maybe Dave is fine tweaking those whilst
applying if there is no other reason to do another spin?

Thanks,

Jonathan

