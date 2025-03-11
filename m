Return-Path: <linux-edac+bounces-3347-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F87A5BCBB
	for <lists+linux-edac@lfdr.de>; Tue, 11 Mar 2025 10:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2AA3A7DB0
	for <lists+linux-edac@lfdr.de>; Tue, 11 Mar 2025 09:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A903225776;
	Tue, 11 Mar 2025 09:51:40 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261B11DE4CC;
	Tue, 11 Mar 2025 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686700; cv=none; b=XuBGs+iz2UIvNrvmIKUZbAHH0ZZihTi6qg/dDhUgPf5LMnabSHgeu/rZQVCMVkIbOEVjm4Jt6CjpFo5OmPTp6HcrQx7IE5VzAYLST0LD+PBtDqmGRQLOP9MkdVhpwpAiCqgGeeJ8YvaVLOt+BtPpXQxt5kPkUseUL0cslvOXjaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686700; c=relaxed/simple;
	bh=A/ZMzq5lRkJdNzhIJNDhVGV+dXchg6pzREW1g6BrqKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BTCDP9/hgNkok7PLtpHLrvIF8RLeAi3mNZqMBGlnKudpQcpKvWEtqQi1Ic50BiLyra+h0nTkU6PhBochN+JGqxyTY6uBMeXewg+AlKTprmnlu349Z+hrG6k8L6/HOOV8CnwDQFhLi3WkMiWlNfJAzMCIbVq8TiR0JZd59hNRnvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZBpqJ0FnGz6H8Y6;
	Tue, 11 Mar 2025 17:48:28 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 985221404FC;
	Tue, 11 Mar 2025 17:51:34 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Mar 2025 10:51:34 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 11 Mar 2025 10:51:34 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
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
Subject: RE: [PATCH 1/8] cxl: Add helper function to retrieve a feature entry
Thread-Topic: [PATCH 1/8] cxl: Add helper function to retrieve a feature entry
Thread-Index: AQHbiWhwo9sEMJAQkEWXFE66V5STnbNoCC6AgASyHwCAABgagIAA7UaA
Date: Tue, 11 Mar 2025 09:51:34 +0000
Message-ID: <00c0910dab404d8ab72db1e8a6e1b190@huawei.com>
References: <20250227223816.2036-1-shiju.jose@huawei.com>
 <20250227223816.2036-2-shiju.jose@huawei.com>
 <Z8tGz33l9vDzuJLy@aschofie-mobl2.lan>
 <e8e33d46aa1b478db601de29e047cb5f@huawei.com>
 <Z89LcUIWO9m8Vtru@aschofie-mobl2.lan>
In-Reply-To: <Z89LcUIWO9m8Vtru@aschofie-mobl2.lan>
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
>From: Alison Schofield <alison.schofield@intel.com>
>Sent: 10 March 2025 20:29
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-cxl@vger.kernel.org; dan.j.williams@intel.com; dave@stgolabs.net=
;
>Jonathan Cameron <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>vishal.l.verma@intel.com; ira.weiny@intel.com; david@redhat.com;
>Vilas.Sridharan@amd.com; linux-edac@vger.kernel.org; linux-
>acpi@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org;
>bp@alien8.de; tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
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
>Linuxarm <linuxarm@huawei.com>
>Subject: Re: [PATCH 1/8] cxl: Add helper function to retrieve a feature en=
try
>
>On Mon, Mar 10, 2025 at 06:15:38PM +0000, Shiju Jose wrote:
>> >-----Original Message-----
>> >From: Alison Schofield <alison.schofield@intel.com>
>> >Sent: 07 March 2025 19:20
>> >To: Shiju Jose <shiju.jose@huawei.com>
>> [...]
>> >> +struct cxl_feat_entry *cxl_get_feature_entry(struct cxl_dev_state *c=
xlds,
>> >> +					     const uuid_t *feat_uuid) {
>> >> +	struct cxl_features_state *cxlfs =3D to_cxlfs(cxlds);
>> >> +	struct cxl_feat_entry *feat_entry;
>> >> +	int count;
>> >> +
>> >> +	/*
>> >> +	 * Retrieve the feature entry from the supported features list,
>> >> +	 * if the feature is supported.
>> >> +	 */
>> >> +	feat_entry =3D cxlfs->entries->ent;
>> >
>> >Do we need some NULL checking here on cxlfs, entries
>>
>> Hi Alison,
>>
>> Thanks for the feedbacks.
>> We had check on cxlfs before
>> https://lore.kernel.org/all/20250122235159.2716036-5-dave.jiang@intel.
>> com/ but removed because of the following comment.
>> https://lore.kernel.org/all/20250124150150.GZ5556@nvidia.com/
>
>Hi Shiju,

Hi Alison,
>
>I have not followed all along, so yeah my questions may be a bit pesky at =
this
>point. I did see the comment linked above about how the driver must be bou=
nd
>at this point. I think my question is a bit different.

The feedback was added to remove defensive checks present in this function.
>
>Are each of these guaranteed not to be NULL here:
>
>to_cxlfs(cxlds)

to_cxlfs(cxlds) cannot be NULL if cxl_get_feature_entry() is called after
devm_cxl_setup_features(),  otherwise will be NULL.
=20
>cxlfs->entries
>cxlfs->entries->ent
Both fields will be NULL if the firmware does not support any features.
>
>If these cannot be NULL, then all good.
>
>--Alison
>
[...]
>>

Thanks,
Shiju


