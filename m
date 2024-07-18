Return-Path: <linux-edac+bounces-1549-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0112934AB9
	for <lists+linux-edac@lfdr.de>; Thu, 18 Jul 2024 11:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1DE41C21888
	for <lists+linux-edac@lfdr.de>; Thu, 18 Jul 2024 09:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C418175E;
	Thu, 18 Jul 2024 09:15:09 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14A87BAF4;
	Thu, 18 Jul 2024 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721294109; cv=none; b=Wpx59z8px4ySof9kNo8WXDYgZvTjt+987MQoDLmGGOZW6nYvqoj6RofKvZYNZGtjoGa+j9dpLxi4K8KzwKZRLh3ypJRqDfFYsXQtdm18Q4RRv05Dz2hOm/sALz3BMJh6EERuYVpnScJo7PdrCatmX6VFYYjvPu6EEXSg2o3Juro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721294109; c=relaxed/simple;
	bh=48CPB0jUF5ybZ00xcv/K4li70JPO8+L6En89ZZEHYdQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QsRmNCY1OEDae+q+6n1Ci44GMLIGhqQHeUKSuIcjhx1YJEj6ZKeOB0f5UB4Ck3ZacxxouCKw8hmwtGGrSMtjlmvQZHfLb/ULZz5Druh0/I3hUpXyre8oWta/X6DIcAovQhF60tiQ3GgdMDBNFU7vcjc+N5gnh/aDLGD2MWUTHx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WPnC50ZDwz6K93k;
	Thu, 18 Jul 2024 17:12:49 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id 88A7A140594;
	Thu, 18 Jul 2024 17:15:04 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 10:15:04 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.039;
 Thu, 18 Jul 2024 10:15:04 +0100
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
Subject: RE: [RFC PATCH v9 06/11] cxl/mbox: Add SET_FEATURE mailbox command
Thread-Topic: [RFC PATCH v9 06/11] cxl/mbox: Add SET_FEATURE mailbox command
Thread-Index: AQHa15F5gzHvz4/u302D5kaH2VCdSrH7S7MAgADqw7A=
Date: Thu, 18 Jul 2024 09:15:04 +0000
Message-ID: <6b2235ab7d35400c88f1d0110222c56c@huawei.com>
References: <20240716150336.2042-1-shiju.jose@huawei.com>
 <20240716150336.2042-7-shiju.jose@huawei.com>
 <66982618.050a0220.e9611.19eb@mx.google.com>
In-Reply-To: <66982618.050a0220.e9611.19eb@mx.google.com>
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
>Sent: 17 July 2024 21:14
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
>Subject: Re: [RFC PATCH v9 06/11] cxl/mbox: Add SET_FEATURE mailbox
>command
>
>On Tue, Jul 16, 2024 at 04:03:30PM +0100, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add support for SET_FEATURE mailbox command.
>>
>> CXL spec 3.1 section 8.2.9.6 describes optional device specific features=
.
>> CXL devices supports features with changeable attributes.
>> The settings of a feature can be optionally modified using Set Feature
>> command.
>
>Add more specific spec reference to the command here: 8.2.9.6.3.
>The same suggestions for get supported features and get feature commands.
Will do.

>
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  drivers/cxl/core/mbox.c | 71
>+++++++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxlmem.h    | 33 +++++++++++++++++++
>>  2 files changed, 104 insertions(+)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c index
>> b1eeed508459..50ecd2bd7372 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1388,6 +1388,77 @@ size_t cxl_get_feature(struct cxl_memdev_state
>> *mds,  }  EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
>>
>> +/*
>> + * FEAT_DATA_MIN_PAYLOAD_SIZE - min extra number of bytes should be
>> + * available in the mailbox for storing the actual feature data so
>> +that
>> + * the feature data transfer would work as expected.
>> + */
>> +#define FEAT_DATA_MIN_PAYLOAD_SIZE 10 int cxl_set_feature(struct
>> +cxl_memdev_state *mds,
>> +		    const uuid_t feat_uuid, u8 feat_version,
>> +		    void *feat_data, size_t feat_data_size,
>> +		    u8 feat_flag)
>> +{
>> +	struct cxl_memdev_set_feat_pi {
>> +		struct cxl_mbox_set_feat_hdr hdr;
>> +		u8 feat_data[];
>> +	}  __packed;
>> +	size_t data_in_size, data_sent_size =3D 0;
>> +	struct cxl_mbox_cmd mbox_cmd;
>> +	size_t hdr_size;
>> +	int rc =3D 0;
>> +
>> +	struct cxl_memdev_set_feat_pi *pi __free(kfree) =3D
>> +					kmalloc(mds->payload_size,
>GFP_KERNEL);
>> +	pi->hdr.uuid =3D feat_uuid;
>> +	pi->hdr.version =3D feat_version;
>> +	feat_flag &=3D ~CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK;
>
>Although we may not support it yet, should we set bit[3] (saved across res=
et)
>since we already defined CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET
>and it is not used?
Will do.
>
>Fan
>> +	hdr_size =3D sizeof(pi->hdr);
>> +	/*
>> +	 * Check minimum mbox payload size is available for
>> +	 * the feature data transfer.
>> +	 */
>> +	if (hdr_size + FEAT_DATA_MIN_PAYLOAD_SIZE > mds->payload_size)
>> +		return -ENOMEM;
>> +
>> +	if ((hdr_size + feat_data_size) <=3D mds->payload_size) {
>> +		pi->hdr.flags =3D cpu_to_le32(feat_flag |
>> +
>CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER);
>> +		data_in_size =3D feat_data_size;
>> +	} else {
>> +		pi->hdr.flags =3D cpu_to_le32(feat_flag |
>> +
>CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER);
>> +		data_in_size =3D mds->payload_size - hdr_size;
>> +	}
>> +
>> +	do {
>> +		pi->hdr.offset =3D cpu_to_le16(data_sent_size);
>> +		memcpy(pi->feat_data, feat_data + data_sent_size,
>data_in_size);
>> +		mbox_cmd =3D (struct cxl_mbox_cmd) {
>> +			.opcode =3D CXL_MBOX_OP_SET_FEATURE,
>> +			.size_in =3D hdr_size + data_in_size,
>> +			.payload_in =3D pi,
>> +		};
>> +		rc =3D cxl_internal_send_cmd(mds, &mbox_cmd);
>> +		if (rc < 0)
>> +			return rc;
>> +
>> +		data_sent_size +=3D data_in_size;
>> +		if (data_sent_size >=3D feat_data_size)
>> +			return 0;
>> +
>> +		if ((feat_data_size - data_sent_size) <=3D (mds->payload_size -
>hdr_size)) {
>> +			data_in_size =3D feat_data_size - data_sent_size;
>> +			pi->hdr.flags =3D cpu_to_le32(feat_flag |
>> +
>CXL_SET_FEAT_FLAG_FINISH_DATA_TRANSFER);
>> +		} else {
>> +			pi->hdr.flags =3D cpu_to_le32(feat_flag |
>> +
>CXL_SET_FEAT_FLAG_CONTINUE_DATA_TRANSFER);
>> +		}
>> +	} while (true);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_set_feature, CXL);
>> +
>>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>>  		       struct cxl_region *cxlr)
>>  {
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h index
>> 25698a6fbe66..c3cb8e2736b5 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -532,6 +532,7 @@ enum cxl_opcode {
>>  	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST =3D 0x0405,
>>  	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	=3D 0x0500,
>>  	CXL_MBOX_OP_GET_FEATURE		=3D 0x0501,
>> +	CXL_MBOX_OP_SET_FEATURE		=3D 0x0502,
>>  	CXL_MBOX_OP_IDENTIFY		=3D 0x4000,
>>  	CXL_MBOX_OP_GET_PARTITION_INFO	=3D 0x4100,
>>  	CXL_MBOX_OP_SET_PARTITION_INFO	=3D 0x4101,
>> @@ -780,6 +781,34 @@ struct cxl_mbox_get_feat_in {
>>  	u8 selection;
>>  }  __packed;
>>
>> +/*
>> + * Set Feature CXL 3.1 Spec 8.2.9.6.3  */
>> +
>> +/*
>> + * Set Feature input payload
>> + * CXL rev 3.1 section 8.2.9.6.3 Table 8-101  */
>> +/* Set Feature : Payload in flags */
>> +#define CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK	GENMASK(2, 0)
>> +enum cxl_set_feat_flag_data_transfer {
>> +	CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER,
>> +	CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER,
>> +	CXL_SET_FEAT_FLAG_CONTINUE_DATA_TRANSFER,
>> +	CXL_SET_FEAT_FLAG_FINISH_DATA_TRANSFER,
>> +	CXL_SET_FEAT_FLAG_ABORT_DATA_TRANSFER,
>> +	CXL_SET_FEAT_FLAG_DATA_TRANSFER_MAX
>> +};
>> +#define CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET	BIT(3)
>> +
>> +struct cxl_mbox_set_feat_hdr {
>> +	uuid_t uuid;
>> +	__le32 flags;
>> +	__le16 offset;
>> +	u8 version;
>> +	u8 rsvd[9];
>> +}  __packed;
>> +
>>  /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */  struct
>> cxl_mbox_poison_in {
>>  	__le64 offset;
>> @@ -918,6 +947,10 @@ size_t cxl_get_feature(struct cxl_memdev_state
>*mds,
>>  		       const uuid_t feat_uuid, void *feat_out,
>>  		       size_t feat_out_size,
>>  		       enum cxl_get_feat_selection selection);
>> +int cxl_set_feature(struct cxl_memdev_state *mds,
>> +		    const uuid_t feat_uuid, u8 feat_version,
>> +		    void *feat_data, size_t feat_data_size,
>> +		    u8 feat_flag);
>>  int cxl_poison_state_init(struct cxl_memdev_state *mds);  int
>> cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>>  		       struct cxl_region *cxlr);
>> --
>> 2.34.1
>>

Thanks,
Shiju


