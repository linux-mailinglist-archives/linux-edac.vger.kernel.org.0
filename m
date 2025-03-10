Return-Path: <linux-edac+bounces-3342-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF92FA5A20A
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 19:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C92174822
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 18:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD33235BF9;
	Mon, 10 Mar 2025 18:15:46 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A752356D7;
	Mon, 10 Mar 2025 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630546; cv=none; b=nJESQSJXeKjCTYegYKyMMqSigsZEfGFQpSgxpFd3to/3mvAbedcMOlRsfEHycPpR2uAH9Rs8jzDa2euO3fA/8UXkTMe0Cd7Brjoy0buAXkoqCKpFzfqUYEaFpppT5D2K62L2AoVX/dKHngFETy86DRqhnipwht19FAFN228ag6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630546; c=relaxed/simple;
	bh=59rUqAulkS2g+6oKWOZ5aw7kxcsBl9xKhZXPMH5FCaQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jY15WEEBwm6zH86hhWuoukJ4gLrnPrPMtnDnFo6O7rexBnRslEorFvKSaWOSmppFxnHt986d0dl9vYDEBNzTwkXEFRtK5pwL68L9BS3LtkKqj7TZrDRsz9rzt0F+OZyy2v8U4h4zlY+mbTk9jU+SWMIokPDXK65eRwkEqG+hOo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZBQ4532s9z6K94c;
	Tue, 11 Mar 2025 02:13:09 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id A0AF914011F;
	Tue, 11 Mar 2025 02:15:39 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Mar 2025 19:15:39 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 10 Mar 2025 19:15:39 +0100
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
Thread-Index: AQHbiWhwo9sEMJAQkEWXFE66V5STnbNoCC6AgASyHwA=
Date: Mon, 10 Mar 2025 18:15:38 +0000
Message-ID: <e8e33d46aa1b478db601de29e047cb5f@huawei.com>
References: <20250227223816.2036-1-shiju.jose@huawei.com>
	<20250227223816.2036-2-shiju.jose@huawei.com>
 <Z8tGz33l9vDzuJLy@aschofie-mobl2.lan>
In-Reply-To: <Z8tGz33l9vDzuJLy@aschofie-mobl2.lan>
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
>Sent: 07 March 2025 19:20
>To: Shiju Jose <shiju.jose@huawei.com>
[...]
>> +struct cxl_feat_entry *cxl_get_feature_entry(struct cxl_dev_state *cxld=
s,
>> +					     const uuid_t *feat_uuid)
>> +{
>> +	struct cxl_features_state *cxlfs =3D to_cxlfs(cxlds);
>> +	struct cxl_feat_entry *feat_entry;
>> +	int count;
>> +
>> +	/*
>> +	 * Retrieve the feature entry from the supported features list,
>> +	 * if the feature is supported.
>> +	 */
>> +	feat_entry =3D cxlfs->entries->ent;
>
>Do we need some NULL checking here on cxlfs, entries

Hi Alison,

Thanks for the feedbacks.
We had check on cxlfs before
https://lore.kernel.org/all/20250122235159.2716036-5-dave.jiang@intel.com/
but removed because of the following comment.
https://lore.kernel.org/all/20250124150150.GZ5556@nvidia.com/
>
>
>> +	for (count =3D 0; count < cxlfs->entries->num_features; count++,
>> +feat_entry++) {
>
>Was num_features previously validated?
Not in the caller. Had check for num_features here before in cxl_get_featur=
e_entry()
as seen in the above link.
>
>> +		if (uuid_equal(&feat_entry->uuid, feat_uuid))
>> +			return feat_entry;
>> +	}
>> +
>> +	return ERR_PTR(-ENOENT);
>
>Why not just return NULL?
Will do.
>
>
>> +}
>> +
>>  size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat=
_uuid,
>>  		       enum cxl_get_feat_selection selection,
>>  		       void *feat_out, size_t feat_out_size, u16 offset,
>> --
>> 2.43.0
>>

Thanks,
Shiju

