Return-Path: <linux-edac+bounces-1548-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F05F3934AB2
	for <lists+linux-edac@lfdr.de>; Thu, 18 Jul 2024 11:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26BDFB20DF8
	for <lists+linux-edac@lfdr.de>; Thu, 18 Jul 2024 09:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E684180C02;
	Thu, 18 Jul 2024 09:12:00 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723383BB30;
	Thu, 18 Jul 2024 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721293920; cv=none; b=pFpRWJ3uOTshF3Ftm0AQU4YRIYPu3yyQG5MlnnAa6Ujs1p7AsOEqKeUd8bLUg7CeYXcOidb+9eU3i+gColCErDiNw34G/6+1mv7tm8vwNeRqxGnuojL8PgPBzBxQW1zEc7bqa00XTi0w+B1S26Xdm4TBssKY5DgZRarfUlK/xB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721293920; c=relaxed/simple;
	bh=vf30FpQALX2+GvASM3UCP8rE9XKN+SKOGQTB8/JhcKM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j2Fnw4gcZt7Rg/QzqNJhzJycrctfrnm0B7G2DsHUwCagwFID1ydsuHH9YK9sDfSPaL6nX91qdZqmtw7QfBgt20Szc2JjDnuD7DGTL6J+NfTSRWob7SG85fIrJr6ktTX3USsjvrSC68mLSDFOkGv/b0zA4a+luUxlSHr8HCOngxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WPn7w2MFKz6K6G8;
	Thu, 18 Jul 2024 17:10:04 +0800 (CST)
Received: from lhrpeml500002.china.huawei.com (unknown [7.191.160.78])
	by mail.maildlp.com (Postfix) with ESMTPS id BF51E140B2F;
	Thu, 18 Jul 2024 17:11:54 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 10:11:54 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.039;
 Thu, 18 Jul 2024 10:11:54 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "mike.malvestuto@intel.com"
	<mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [RFC PATCH v9 05/11] cxl/mbox: Add GET_FEATURE mailbox command
Thread-Topic: [RFC PATCH v9 05/11] cxl/mbox: Add GET_FEATURE mailbox command
Thread-Index: AQHa15F4Ou8ZYOXrVUerA137Puj/7LH7KKwAgAEKkDA=
Date: Thu, 18 Jul 2024 09:11:54 +0000
Message-ID: <e3f35823df1448e0935dabf0979ed4e8@huawei.com>
References: <20240716150336.2042-1-shiju.jose@huawei.com>
 <20240716150336.2042-6-shiju.jose@huawei.com>
 <66980890.050a0220.163b98.0210@mx.google.com>
In-Reply-To: <66980890.050a0220.163b98.0210@mx.google.com>
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
>From: nifan.cxl@gmail.com <nifan.cxl@gmail.com>
>Sent: 17 July 2024 19:08
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org; linux-
>acpi@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org;
>bp@alien8.de; tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
>mchehab@kernel.org; dan.j.williams@intel.com; dave@stgolabs.net; Jonathan
>Cameron <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>david@redhat.com; Vilas.Sridharan@amd.com; leo.duran@amd.com;
>Yazen.Ghannam@amd.com; rientjes@google.com; jiaqiyan@google.com;
>Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
>naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
>somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
>duenwen@google.com; mike.malvestuto@intel.com; gthelen@google.com;
>wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
>wbs@os.amperecomputing.com; nifan.cxl@gmail.com; tanxiaofei
><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Roberto
>Sassu <roberto.sassu@huawei.com>; kangkang.shen@futurewei.com;
>wanghuiqiang <wanghuiqiang@huawei.com>; Linuxarm
><linuxarm@huawei.com>
>Subject: Re: [RFC PATCH v9 05/11] cxl/mbox: Add GET_FEATURE mailbox
>command
>
>On Tue, Jul 16, 2024 at 04:03:29PM +0100, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add support for GET_FEATURE mailbox command.
>>
>> CXL spec 3.1 section 8.2.9.6 describes optional device specific features=
.
>> The settings of a feature can be retrieved using Get Feature command.
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>Minor comments inline.
>
>>  drivers/cxl/core/mbox.c | 37 +++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxlmem.h    | 27 +++++++++++++++++++++++++++
>>  2 files changed, 64 insertions(+)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c index
>> 9b9b1d26454e..b1eeed508459 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1351,6 +1351,43 @@ int cxl_get_supported_features(struct
>> cxl_memdev_state *mds,  }
>> EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
>>
>> +size_t cxl_get_feature(struct cxl_memdev_state *mds,
>> +		       const uuid_t feat_uuid, void *feat_out,
>> +		       size_t feat_out_size,
>> +		       enum cxl_get_feat_selection selection)
>feat_uuid and selection are both payload inputs, maybe more natural to put
>them together before feat_out.
Will do.
>> +{
>> +	size_t data_to_rd_size, size_out;
>> +	struct cxl_mbox_get_feat_in pi;
>> +	struct cxl_mbox_cmd mbox_cmd;
>> +	size_t data_rcvd_size =3D 0;
>> +	int rc;
>> +
>> +	size_out =3D min(feat_out_size, mds->payload_size);
>> +	pi.uuid =3D feat_uuid;
>> +	pi.selection =3D selection;
>> +	do {
>> +		data_to_rd_size =3D min(feat_out_size - data_rcvd_size, mds-
>>payload_size);
>> +		pi.offset =3D cpu_to_le16(data_rcvd_size);
>> +		pi.count =3D cpu_to_le16(data_to_rd_size);
>> +
>> +		mbox_cmd =3D (struct cxl_mbox_cmd) {
>> +			.opcode =3D CXL_MBOX_OP_GET_FEATURE,
>> +			.size_in =3D sizeof(pi),
>> +			.payload_in =3D &pi,
>> +			.size_out =3D size_out,
>> +			.payload_out =3D feat_out + data_rcvd_size,
>> +			.min_out =3D data_to_rd_size,
>> +		};
>> +		rc =3D cxl_internal_send_cmd(mds, &mbox_cmd);
>> +		if (rc < 0 || mbox_cmd.size_out =3D=3D 0)
>Is there other case when size_out will be 0 other than the feat_out_size i=
s 0?
I think size_out can be 0 depending on the implementation on the firmware o=
r some
error situation when the feat_out_size is non zero.

>
>If feat_out_size is 0, maybe we return directly, or we use while () {}, in=
stead of
>do {} while.
I had a check for feat_out_size against min feat out size in the previous v=
ersion.=20
Will add return directly if feat_out_size is 0. =20
>Anyway, if there is no other case that will return size_out as 0, we can a=
void the
>check.
>
>Fan
>> +			return 0;
>> +		data_rcvd_size +=3D mbox_cmd.size_out;
>> +	} while (data_rcvd_size < feat_out_size);
>> +
>> +	return data_rcvd_size;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
>> +
>>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>>  		       struct cxl_region *cxlr)
>>  {
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h index
>> b0e1565b9d2e..25698a6fbe66 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -531,6 +531,7 @@ enum cxl_opcode {
>>  	CXL_MBOX_OP_CLEAR_LOG           =3D 0x0403,
>>  	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST =3D 0x0405,
>>  	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	=3D 0x0500,
>> +	CXL_MBOX_OP_GET_FEATURE		=3D 0x0501,
>>  	CXL_MBOX_OP_IDENTIFY		=3D 0x4000,
>>  	CXL_MBOX_OP_GET_PARTITION_INFO	=3D 0x4100,
>>  	CXL_MBOX_OP_SET_PARTITION_INFO	=3D 0x4101,
>> @@ -757,6 +758,28 @@ struct cxl_mbox_get_supp_feats_out {
>>  	struct cxl_mbox_supp_feat_entry feat_entries[];  } __packed;
>>
>> +/*
>> + * Get Feature CXL 3.1 Spec 8.2.9.6.2  */
>> +
>> +/*
>> + * Get Feature input payload
>> + * CXL rev 3.1 section 8.2.9.6.2 Table 8-99  */ enum
>> +cxl_get_feat_selection {
>> +	CXL_GET_FEAT_SEL_CURRENT_VALUE,
>> +	CXL_GET_FEAT_SEL_DEFAULT_VALUE,
>> +	CXL_GET_FEAT_SEL_SAVED_VALUE,
>> +	CXL_GET_FEAT_SEL_MAX
>> +};
>> +
>> +struct cxl_mbox_get_feat_in {
>> +	uuid_t uuid;
>> +	__le16 offset;
>> +	__le16 count;
>> +	u8 selection;
>> +}  __packed;
>> +
>>  /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */  struct
>> cxl_mbox_poison_in {
>>  	__le64 offset;
>> @@ -891,6 +914,10 @@ int cxl_set_timestamp(struct cxl_memdev_state
>> *mds);  int cxl_get_supported_features(struct cxl_memdev_state *mds,
>>  			       u32 count, u16 start_index,
>>  			       struct cxl_mbox_get_supp_feats_out *feats_out);
>> +size_t cxl_get_feature(struct cxl_memdev_state *mds,
>> +		       const uuid_t feat_uuid, void *feat_out,
>> +		       size_t feat_out_size,
>> +		       enum cxl_get_feat_selection selection);
>>  int cxl_poison_state_init(struct cxl_memdev_state *mds);  int
>> cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>>  		       struct cxl_region *cxlr);
>> --
>> 2.34.1
>>

Thanks,
Shiju

