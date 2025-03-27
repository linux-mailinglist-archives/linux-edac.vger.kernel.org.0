Return-Path: <linux-edac+bounces-3405-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8E4A7379E
	for <lists+linux-edac@lfdr.de>; Thu, 27 Mar 2025 18:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136953A878D
	for <lists+linux-edac@lfdr.de>; Thu, 27 Mar 2025 16:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2125C2192E0;
	Thu, 27 Mar 2025 16:59:22 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C6C218EB1;
	Thu, 27 Mar 2025 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743094762; cv=none; b=p4tS7+SHak4EzsbfbzbgrYLXHI+8fjhZeEy8EXw6Cw2U+Npn1MabG8oODqSwTobwiupc3seXjxKHJvlIChDxgAuu02+xQPaIt0uaROgChbIT4baDzE0scc6/E9e+3CmrNyJJqzggh8tk9oPopZwniQ22oGXqOZi/x+Vfi/5zUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743094762; c=relaxed/simple;
	bh=ZBWtgGydzDpTfxzGWzX9C6AwYBx8VOMDnHl+miUOL4E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g4PKwTLZLjPM0aFl23JVATrVf8dBDSZtPKkKA3ZMtLbP9DQV/xUYkPQwnUxfiNNRvlHcx9tSsk7hSefGk2Z+yYoMFidQCttYPvW6VRL0J2FPyYwQBvkpJ65XUiQnS/6BO5qIUviTiQr/2txuGkcige/tK8/irYVkAvag3+iyqt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZNqXr6JTqz6M4Ql;
	Fri, 28 Mar 2025 00:55:40 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
	by mail.maildlp.com (Postfix) with ESMTPS id 26E2A14051A;
	Fri, 28 Mar 2025 00:59:11 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Mar 2025 17:59:10 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 27 Mar 2025 17:59:10 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "dave@stgolabs.net" <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "leo.duran@amd.com"
	<leo.duran@amd.com>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>, "jiaqiyan@google.com"
	<jiaqiyan@google.com>, "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>, "erdemaktas@google.com"
	<erdemaktas@google.com>, "pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>, "gthelen@google.com"
	<gthelen@google.com>, "wschwartz@amperecomputing.com"
	<wschwartz@amperecomputing.com>, "dferguson@amperecomputing.com"
	<dferguson@amperecomputing.com>, "wbs@os.amperecomputing.com"
	<wbs@os.amperecomputing.com>, "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v2 1/8] cxl: Add helper function to retrieve a feature
 entry
Thread-Topic: [PATCH v2 1/8] cxl: Add helper function to retrieve a feature
 entry
Thread-Index: AQHbmcKr5anTvL2xzU6u4SEaFigSYLOF6PqAgAFGedA=
Date: Thu, 27 Mar 2025 16:59:10 +0000
Message-ID: <610691bb7c6949b5a2137c568bc66fe2@huawei.com>
References: <20250320180450.539-1-shiju.jose@huawei.com>
	<20250320180450.539-2-shiju.jose@huawei.com>
 <67e47285c1974_152c29442@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <67e47285c1974_152c29442@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>-----Original Message-----
>From: Dan Williams <dan.j.williams@intel.com>
>Sent: 26 March 2025 21:33
>To: Shiju Jose <shiju.jose@huawei.com>; linux-cxl@vger.kernel.org;
>dan.j.williams@intel.com; dave@stgolabs.net; Jonathan Cameron
><jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>david@redhat.com; Vilas.Sridharan@amd.com
>Cc: linux-edac@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
>mm@kvack.org; linux-kernel@vger.kernel.org; bp@alien8.de;
>tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
>mchehab@kernel.org; leo.duran@amd.com; Yazen.Ghannam@amd.com;
>rientjes@google.com; jiaqiyan@google.com; Jon.Grimm@amd.com;
>dave.hansen@linux.intel.com; naoya.horiguchi@nec.com;
>james.morse@arm.com; jthoughton@google.com; somasundaram.a@hpe.com;
>erdemaktas@google.com; pgonda@google.com; duenwen@google.com;
>gthelen@google.com; wschwartz@amperecomputing.com;
>dferguson@amperecomputing.com; wbs@os.amperecomputing.com;
>nifan.cxl@gmail.com; tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
><prime.zeng@hisilicon.com>; Roberto Sassu <roberto.sassu@huawei.com>;
>kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
>Linuxarm <linuxarm@huawei.com>; Shiju Jose <shiju.jose@huawei.com>
>Subject: Re: [PATCH v2 1/8] cxl: Add helper function to retrieve a feature=
 entry
>
>shiju.jose@ wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add helper function to retrieve a feature entry from the supported
>> features list, if supported.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  drivers/cxl/core/core.h     |  2 ++
>>  drivers/cxl/core/features.c | 23 +++++++++++++++++++++++
>>  2 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h index
>> 1803aedb25ca..16bc717376fc 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -123,6 +123,8 @@ int cxl_ras_init(void);  void cxl_ras_exit(void);
>>
>>  #ifdef CONFIG_CXL_FEATURES
>> +struct cxl_feat_entry *cxl_get_feature_entry(struct cxl_dev_state *cxld=
s,
>> +					     const uuid_t *feat_uuid);
>
>It is unfortunate that this naming choice is too similar to cxl_get_featur=
e().
>However, as I go to suggest a new name I find that this is a duplicate of
>get_support_feature_info() in Dave's fwctl series. Just drop this patch in=
 favor of
>that.

Hi Dan,

I am fine to use get_support_feature_info() for the EDAC features.=20
However this function is defined as static in the fwctl series and=20
takes struct fwctl_rpc_cxl * as input for RPC instead of  uuid_t *
as in cxl_get_feature_entry().

static struct cxl_feat_entry *
get_support_feature_info(struct cxl_features_state *cxlfs,
			 const struct fwctl_rpc_cxl *rpc_in)

Can you suggest how to use get_support_feature_info() from within the CXL d=
river=20
to retrieve a supported feature entry (for e.g an EDAC feature)?

>

Thanks,
Shiju

