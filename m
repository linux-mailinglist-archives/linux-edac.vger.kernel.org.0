Return-Path: <linux-edac+bounces-1563-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6C293AE5B
	for <lists+linux-edac@lfdr.de>; Wed, 24 Jul 2024 11:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58AD2B207EB
	for <lists+linux-edac@lfdr.de>; Wed, 24 Jul 2024 09:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76267150984;
	Wed, 24 Jul 2024 09:10:46 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC9A2C1A5;
	Wed, 24 Jul 2024 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721812246; cv=none; b=cip/kd8+RnMQsv0Ajstnf4phwz+lu7IMZfABdFhWQYZMfOOkkDyCqNy6RQy8lnrM8LPusgGWeBT4e0CXULujE19ah1FvLmG3qUXsXCXyRDuz1r6Wc49K1kez8KyNWyyQ/u+r/3XHHwldUFV0ucAZ59Yg2P3DJ/zcDtLqz3wXJ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721812246; c=relaxed/simple;
	bh=QwhbyJdkohqp1Bc9PBQve8ej348OHnUuptgBlZ22oyM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j8pEGQqZH9GEIz1wpU3WnIJdT6spP2Nb/G+bdq++zBLTkOciWABS5/UUs0MF+e3Ay8UNunpTqAm68XVv6PMqD+0LCJ8ucrAyTMsYniUu2y3t1LZ5wKWTAZSEGgsSff76VzqkkIVJJpCZFJi0Fw1JbG4ddixQoI4wf1WHw59uRus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WTSq31kJgz6K91h;
	Wed, 24 Jul 2024 17:08:15 +0800 (CST)
Received: from lhrpeml100004.china.huawei.com (unknown [7.191.162.219])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B282140257;
	Wed, 24 Jul 2024 17:10:39 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml100004.china.huawei.com (7.191.162.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 10:10:39 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.039;
 Wed, 24 Jul 2024 10:10:39 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: fan <nifan.cxl@gmail.com>
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
Subject: RE: [RFC PATCH v9 08/11] cxl/memscrub: Add CXL memory device ECS
 control feature
Thread-Topic: [RFC PATCH v9 08/11] cxl/memscrub: Add CXL memory device ECS
 control feature
Thread-Index: AQHa15F8cRMbgzFJWUOG7wcOX/vnVrH+VxEAgAdFNsA=
Date: Wed, 24 Jul 2024 09:10:38 +0000
Message-ID: <ef1f281d36924c6ebaedc61238269656@huawei.com>
References: <20240716150336.2042-1-shiju.jose@huawei.com>
 <20240716150336.2042-9-shiju.jose@huawei.com> <ZpqztkrEPw3lrku5@gpd>
In-Reply-To: <ZpqztkrEPw3lrku5@gpd>
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

Hi Fan,

Thanks for the comments.
Sorry for the delay.

>-----Original Message-----
>From: fan <nifan.cxl@gmail.com>
>Sent: 19 July 2024 19:43
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
>Subject: Re: [RFC PATCH v9 08/11] cxl/memscrub: Add CXL memory device ECS
>control feature
>
>On Tue, Jul 16, 2024 at 04:03:32PM +0100, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub
>> (ECS) control feature.
>> The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
>> Specification (JESD79-5) and allows the DRAM to internally read,
>> correct single-bit errors, and write back corrected data bits to the
>> DRAM array while providing transparency to error counts.
>>
>> The ECS control allows the requester to change the log entry type, the
>> ECS threshold count provided that the request is within the definition
>> specified in DDR5 mode registers, change mode between codeword mode
>> and row count mode, and reset the ECS counter.
>>
>> Register with EDAC RAS control feature driver, which gets the ECS attr
>> descriptors from the EDAC ECS and expose sysfs ECS control attributes
>> to the userspace.
>> For example ECS control for the memory media FRU 0 in CXL mem0 device
>> is in /sys/bus/edac/devices/cxl_mem0/ecs_fru0/
>>
>> Note: The documentation can be added if necessary.
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>
>Some lines are too long. And some other comments inline.
Wil fix.
>
>>  drivers/cxl/core/memscrub.c | 429
>> ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 429 insertions(+)
>>
>> diff --git a/drivers/cxl/core/memscrub.c b/drivers/cxl/core/memscrub.c
>> index 430f85b01f6c..9be230ea989a 100644
>> --- a/drivers/cxl/core/memscrub.c
>> +++ b/drivers/cxl/core/memscrub.c
>> @@ -351,13 +351,411 @@ static const struct edac_scrub_ops
>cxl_ps_scrub_ops =3D {
>>  	.cycle_in_hours_range =3D cxl_patrol_scrub_read_scrub_cycle_hrs_range,
>>  };
>>
>> +/* CXL DDR5 ECS control definitions */
>> +#define CXL_MEMDEV_ECS_GET_FEAT_VERSION	0x01
>> +#define CXL_MEMDEV_ECS_SET_FEAT_VERSION	0x01
>> +
>> +static const uuid_t cxl_ecs_uuid =3D
>> +	UUID_INIT(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba, 0xb9, 0x69, 0x1e,
>\
>> +		  0x89, 0x33, 0x86);
>> +
>> +struct cxl_ecs_context {
>> +	u16 num_media_frus;
>> +	u16 get_feat_size;
>> +	u16 set_feat_size;
>> +	struct cxl_memdev *cxlmd;
>> +};
>> +
>> +/**
>> + * struct cxl_ecs_params - CXL memory DDR5 ECS parameter data structure=
.
>> + * @log_entry_type: ECS log entry type, per DRAM or per memory media
>FRU.
>> + * @threshold: ECS threshold count per GB of memory cells.
>> + * @mode:	codeword/row count mode
>> + *		0 : ECS counts rows with errors
>> + *		1 : ECS counts codeword with errors
>> + * @reset_counter: [IN] reset ECC counter to default value.
>> + */
>> +struct cxl_ecs_params {
>> +	u8 log_entry_type;
>> +	u16 threshold;
>> +	u8 mode;
>
>An enum is defined below, why not directly use enum type here?
Will do.
>
>> +	bool reset_counter;
>> +};
>> +
>> +enum {
>> +	CXL_ECS_PARAM_LOG_ENTRY_TYPE,
>> +	CXL_ECS_PARAM_THRESHOLD,
>> +	CXL_ECS_PARAM_MODE,
>> +	CXL_ECS_PARAM_RESET_COUNTER,
>> +};
>> +
>> +#define	CXL_ECS_LOG_ENTRY_TYPE_MASK	GENMASK(1, 0)
>> +#define	CXL_ECS_REALTIME_REPORT_CAP_MASK	BIT(0)
>> +#define	CXL_ECS_THRESHOLD_COUNT_MASK	GENMASK(2, 0)
>> +#define	CXL_ECS_MODE_MASK	BIT(3)
>> +#define	CXL_ECS_RESET_COUNTER_MASK	BIT(4)
>> +
>> +static const u16 ecs_supp_threshold[] =3D { 0, 0, 0, 256, 1024, 4096 };
>> +
>> +enum {
>> +	ECS_LOG_ENTRY_TYPE_DRAM =3D 0x0,
>> +	ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU =3D 0x1, };
>> +
>> +enum {
>> +	ECS_THRESHOLD_256 =3D 3,
>> +	ECS_THRESHOLD_1024 =3D 4,
>> +	ECS_THRESHOLD_4096 =3D 5,
>> +};
>> +
>> +enum {
>> +	ECS_MODE_COUNTS_ROWS =3D 0,
>> +	ECS_MODE_COUNTS_CODEWORDS =3D 1,
>> +};
>> +
>> +struct cxl_ecs_rd_attrs {
>> +	u8 ecs_log_cap;
>> +	u8 ecs_cap;
>> +	__le16 ecs_config;
>> +	u8 ecs_flags;
>> +}  __packed;
>> +
>> +struct cxl_ecs_wr_attrs {
>> +	u8 ecs_log_cap;
>> +	__le16 ecs_config;
>> +}  __packed;
>> +
>> +/* CXL DDR5 ECS control functions */
>> +static int cxl_mem_ecs_get_attrs(struct device *dev, void *drv_data, in=
t
>fru_id,
>> +				 struct cxl_ecs_params *params)
>> +{
>> +	struct cxl_ecs_context *cxl_ecs_ctx =3D drv_data;
>> +	struct cxl_memdev *cxlmd =3D cxl_ecs_ctx->cxlmd;
>> +	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
>> +	struct cxl_memdev_state *mds =3D to_cxl_memdev_state(cxlds);
>> +	size_t rd_data_size;
>> +	u8 threshold_index;
>> +	size_t data_size;
>> +
>> +	rd_data_size =3D cxl_ecs_ctx->get_feat_size;
>> +
>> +	struct cxl_ecs_rd_attrs *rd_attrs __free(kfree) =3D
>> +					kmalloc(rd_data_size, GFP_KERNEL);
>> +	if (!rd_attrs)
>> +		return -ENOMEM;
>> +
>> +	params->log_entry_type =3D 0;
>> +	params->threshold =3D 0;
>> +	params->mode =3D 0;
>> +	data_size =3D cxl_get_feature(mds, cxl_ecs_uuid, rd_attrs,
>> +				    rd_data_size,
>CXL_GET_FEAT_SEL_CURRENT_VALUE);
>> +	if (!data_size)
>> +		return -EIO;
>> +
>> +	params->log_entry_type =3D
>FIELD_GET(CXL_ECS_LOG_ENTRY_TYPE_MASK,
>> +					   rd_attrs[fru_id].ecs_log_cap);
>> +	threshold_index =3D FIELD_GET(CXL_ECS_THRESHOLD_COUNT_MASK,
>> +				    rd_attrs[fru_id].ecs_config);
>> +	params->threshold =3D ecs_supp_threshold[threshold_index];
>> +	params->mode =3D FIELD_GET(CXL_ECS_MODE_MASK,
>> +				 rd_attrs[fru_id].ecs_config);
>> +	return 0;
>> +}
>> +
>> +static int cxl_mem_ecs_set_attrs(struct device *dev, void *drv_data, in=
t
>fru_id,
>> +				 struct cxl_ecs_params *params, u8
>param_type) {
>> +	struct cxl_ecs_context *cxl_ecs_ctx =3D drv_data;
>> +	struct cxl_memdev *cxlmd =3D cxl_ecs_ctx->cxlmd;
>> +	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
>> +	struct cxl_memdev_state *mds =3D to_cxl_memdev_state(cxlds);
>> +	size_t rd_data_size, wr_data_size;
>> +	u16 num_media_frus, count;
>> +	size_t data_size;
>> +	int ret;
>> +
>> +	num_media_frus =3D cxl_ecs_ctx->num_media_frus;
>> +	rd_data_size =3D cxl_ecs_ctx->get_feat_size;
>> +	wr_data_size =3D cxl_ecs_ctx->set_feat_size;
>> +	struct cxl_ecs_rd_attrs *rd_attrs __free(kfree) =3D
>> +				kmalloc(rd_data_size, GFP_KERNEL);
>> +	if (!rd_attrs)
>> +		return -ENOMEM;
>> +
>> +	data_size =3D cxl_get_feature(mds, cxl_ecs_uuid, rd_attrs,
>> +				    rd_data_size,
>CXL_GET_FEAT_SEL_CURRENT_VALUE);
>> +	if (!data_size)
>> +		return -EIO;
>> +	struct cxl_ecs_wr_attrs *wr_attrs __free(kfree) =3D
>> +					kmalloc(wr_data_size, GFP_KERNEL);
>> +	if (!wr_attrs)
>> +		return -ENOMEM;
>> +
>> +	/* Fill writable attributes from the current attributes read for all t=
he
>media FRUs */
>> +	for (count =3D 0; count < num_media_frus; count++) {
>> +		wr_attrs[count].ecs_log_cap =3D rd_attrs[count].ecs_log_cap;
>> +		wr_attrs[count].ecs_config =3D rd_attrs[count].ecs_config;
>> +	}
>> +
>> +	/* Fill attribute to be set for the media FRU */
>> +	switch (param_type) {
>> +	case CXL_ECS_PARAM_LOG_ENTRY_TYPE:
>> +		if (params->log_entry_type !=3D ECS_LOG_ENTRY_TYPE_DRAM
>&&
>> +		    params->log_entry_type !=3D
>ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU) {
>> +			dev_err(dev,
>> +				"Invalid CXL ECS scrub log entry type(%d) to
>set\n",
>> +			       params->log_entry_type);
>> +			dev_err(dev,
>> +				"Log Entry Type 0: per DRAM  1: per Memory
>Media FRU\n");
>> +			return -EINVAL;
>> +		}
>> +		wr_attrs[fru_id].ecs_log_cap =3D
>FIELD_PREP(CXL_ECS_LOG_ENTRY_TYPE_MASK,
>> +							  params-
>>log_entry_type);
>> +		break;
>> +	case CXL_ECS_PARAM_THRESHOLD:
>> +		wr_attrs[fru_id].ecs_config &=3D
>~CXL_ECS_THRESHOLD_COUNT_MASK;
>> +		switch (params->threshold) {
>> +		case 256:
>> +			wr_attrs[fru_id].ecs_config |=3D FIELD_PREP(
>> +					CXL_ECS_THRESHOLD_COUNT_MASK,
>> +						ECS_THRESHOLD_256);
>> +			break;
>> +		case 1024:
>> +			wr_attrs[fru_id].ecs_config |=3D FIELD_PREP(
>> +
>	CXL_ECS_THRESHOLD_COUNT_MASK,
>> +						ECS_THRESHOLD_1024);
>> +			break;
>> +		case 4096:
>> +			wr_attrs[fru_id].ecs_config |=3D FIELD_PREP(
>> +
>	CXL_ECS_THRESHOLD_COUNT_MASK,
>> +						ECS_THRESHOLD_4096);
>> +			break;
>> +		default:
>> +			dev_err(dev,
>> +				"Invalid CXL ECS scrub threshold count(%d) to
>set\n",
>> +				params->threshold);
>> +			dev_err(dev,
>> +				"Supported scrub threshold count:
>256,1024,4096\n");
>> +			return -EINVAL;
>> +		}
>> +		break;
>> +	case CXL_ECS_PARAM_MODE:
>> +		if (params->mode !=3D ECS_MODE_COUNTS_ROWS &&
>> +		    params->mode !=3D ECS_MODE_COUNTS_CODEWORDS) {
>> +			dev_err(dev,
>> +				"Invalid CXL ECS scrub mode(%d) to set\n",
>> +				params->mode);
>> +			dev_err(dev,
>> +				"Mode 0: ECS counts rows with errors"
>> +				" 1: ECS counts codewords with errors\n");
>> +			return -EINVAL;
>> +		}
>> +		wr_attrs[fru_id].ecs_config &=3D ~CXL_ECS_MODE_MASK;
>> +		wr_attrs[fru_id].ecs_config |=3D
>FIELD_PREP(CXL_ECS_MODE_MASK,
>> +							  params->mode);
>> +		break;
>> +	case CXL_ECS_PARAM_RESET_COUNTER:
>> +		wr_attrs[fru_id].ecs_config &=3D
>~CXL_ECS_RESET_COUNTER_MASK;
>> +		wr_attrs[fru_id].ecs_config |=3D
>FIELD_PREP(CXL_ECS_RESET_COUNTER_MASK,
>> +							  params-
>>reset_counter);
>> +		break;
>> +	default:
>> +		dev_err(dev, "Invalid CXL ECS parameter to set\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret =3D cxl_set_feature(mds, cxl_ecs_uuid,
>CXL_MEMDEV_ECS_SET_FEAT_VERSION,
>> +			      wr_attrs, wr_data_size,
>> +
>CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET);
>> +	if (ret) {
>> +		dev_err(dev, "CXL ECS set feature failed ret=3D%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int cxl_ecs_get_log_entry_type(struct device *dev, void
>> +*drv_data, int fru_id, u64 *val) {
>> +	struct cxl_ecs_params params;
>> +	int ret;
>> +
>> +	ret =3D cxl_mem_ecs_get_attrs(dev, drv_data, fru_id, &params);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*val =3D params.log_entry_type;
>> +
>> +	return 0;
>> +}
>> +
>> +static int cxl_ecs_set_log_entry_type(struct device *dev, void
>> +*drv_data, int fru_id, u64 val) {
>> +	struct cxl_ecs_params params =3D {
>> +		.log_entry_type =3D val,
>> +	};
>> +
>> +	return cxl_mem_ecs_set_attrs(dev, drv_data, fru_id, &params,
>> +CXL_ECS_PARAM_LOG_ENTRY_TYPE); }
>> +
>> +static int cxl_ecs_get_log_entry_type_per_dram(struct device *dev, void
>*drv_data,
>> +					       int fru_id, u64 *val)
>
>I may have missed something. We have cxl_ecs_get_log_entry_type, and what =
is
>cxl_ecs_get_log_entry_type_per_memory_media and
>cxl_ecs_get_log_entry_type_per_dram for?
Reason for adding these readonly attributes to avoid user need to check the=
 spec to
interpret the value set or the supported options for ECS log type.
From spec,
Common DDR5 ECS Log Capabilities
* Bits[1:0]: Log Entry Type: The log entry type of how the ECS log is
reported. The entry type is defined commonly for all memory media FRUs
within the device.
- 00b =3D Per DRAM
- 01b =3D Per Memory Media FRU
- All other encodings are reserved=20
>
>> +{
>> +	struct cxl_ecs_params params;
>> +	int ret;
>> +
>> +	ret =3D cxl_mem_ecs_get_attrs(dev, drv_data, fru_id, &params);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (params.log_entry_type =3D=3D ECS_LOG_ENTRY_TYPE_DRAM)
>> +		*val =3D 1;
>> +	else
>> +		*val =3D 0;
>> +
>> +	return 0;
>> +}
>> +
>> +static int cxl_ecs_get_log_entry_type_per_memory_media(struct device
>*dev, void *drv_data,
>> +						       int fru_id, u64 *val)
>> +{
>> +	struct cxl_ecs_params params;
>> +	int ret;
>> +
>> +	ret =3D cxl_mem_ecs_get_attrs(dev, drv_data, fru_id, &params);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (params.log_entry_type =3D=3D
>ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU)
>> +		*val =3D 1;
>> +	else
>> +		*val =3D 0;
>> +
>> +	return 0;
>> +}
>> +
>> +static int cxl_ecs_get_mode(struct device *dev, void *drv_data, int
>> +fru_id, u64 *val) {
>> +	struct cxl_ecs_params params;
>> +	int ret;
>> +
>> +	ret =3D cxl_mem_ecs_get_attrs(dev, drv_data, fru_id, &params);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*val =3D params.mode;
>> +
>> +	return 0;
>> +}
>> +
>> +static int cxl_ecs_set_mode(struct device *dev, void *drv_data, int
>> +fru_id, u64 val) {
>> +	struct cxl_ecs_params params =3D {
>> +		.mode =3D val,
>> +	};
>> +
>> +	return cxl_mem_ecs_set_attrs(dev, drv_data, fru_id, &params,
>> +CXL_ECS_PARAM_MODE); }
>> +
>> +static int cxl_ecs_get_mode_counts_rows(struct device *dev, void
>> +*drv_data, int fru_id, u64 *val)
>As above, what is cxl_ecs_get_mode_counts_codewords and
>cxl_ecs_get_mode_counts_rows for?
Reason for adding these readonly attributes to avoid user need to check the=
 spec to
interpret the value set or the supported options for mode.
From spec,
Bit[3]: Codeword/Row Count Mode:
- 0 =3D ECS counts rows with errors
- 1 =3D ECS counts codewords with errors
>
>Fan
>> +{
>> +	struct cxl_ecs_params params;
>> +	int ret;
>> +
>> +	ret =3D cxl_mem_ecs_get_attrs(dev, drv_data, fru_id, &params);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (params.mode =3D=3D ECS_MODE_COUNTS_ROWS)
>> +		*val =3D 1;
>> +	else
>> +		*val =3D 0;
>> +
>> +	return 0;
>> +}
>> +
>> +static int cxl_ecs_get_mode_counts_codewords(struct device *dev, void
>*drv_data,
>> +					     int fru_id, u64 *val)
>> +{
>> +	struct cxl_ecs_params params;
>> +	int ret;
>> +
>> +	ret =3D cxl_mem_ecs_get_attrs(dev, drv_data, fru_id, &params);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (params.mode =3D=3D ECS_MODE_COUNTS_CODEWORDS)
>> +		*val =3D 1;
>> +	else
>> +		*val =3D 0;
>> +
>> +	return 0;
>> +}
>> +
>> +static int cxl_ecs_reset(struct device *dev, void *drv_data, int
>> +fru_id, u64 val) {
>> +	struct cxl_ecs_params params =3D {
>> +		.reset_counter =3D val,
>> +	};
>> +
>> +	return cxl_mem_ecs_set_attrs(dev, drv_data, fru_id, &params,
>> +CXL_ECS_PARAM_RESET_COUNTER); }
>> +
>> +static int cxl_ecs_get_threshold(struct device *dev, void *drv_data,
>> +int fru_id, u64 *val) {
>> +	struct cxl_ecs_params params;
>> +	int ret;
>> +
>> +	ret =3D cxl_mem_ecs_get_attrs(dev, drv_data, fru_id, &params);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*val =3D params.threshold;
>> +
>> +	return 0;
>> +}
>> +
>> +static int cxl_ecs_set_threshold(struct device *dev, void *drv_data,
>> +int fru_id, u64 val) {
>> +	struct cxl_ecs_params params =3D {
>> +		.threshold =3D val,
>> +	};
>> +
>> +	return cxl_mem_ecs_set_attrs(dev, drv_data, fru_id, &params,
>> +CXL_ECS_PARAM_THRESHOLD); }
>> +
>> +static int cxl_ecs_get_name(struct device *dev, void *drv_data, int
>> +fru_id, char *name) {
>> +	struct cxl_ecs_context *cxl_ecs_ctx =3D drv_data;
>> +	struct cxl_memdev *cxlmd =3D cxl_ecs_ctx->cxlmd;
>> +
>> +	return sysfs_emit(name, "cxl_%s_ecs_fru%d\n", dev_name(&cxlmd-
>>dev),
>> +fru_id); }
>> +
>> +static const struct edac_ecs_ops cxl_ecs_ops =3D {
>> +	.get_log_entry_type =3D cxl_ecs_get_log_entry_type,
>> +	.set_log_entry_type =3D cxl_ecs_set_log_entry_type,
>> +	.get_log_entry_type_per_dram =3D
>cxl_ecs_get_log_entry_type_per_dram,
>> +	.get_log_entry_type_per_memory_media =3D
>cxl_ecs_get_log_entry_type_per_memory_media,
>> +	.get_mode =3D cxl_ecs_get_mode,
>> +	.set_mode =3D cxl_ecs_set_mode,
>> +	.get_mode_counts_codewords =3D cxl_ecs_get_mode_counts_codewords,
>> +	.get_mode_counts_rows =3D cxl_ecs_get_mode_counts_rows,
>> +	.reset =3D cxl_ecs_reset,
>> +	.get_threshold =3D cxl_ecs_get_threshold,
>> +	.set_threshold =3D cxl_ecs_set_threshold,
>> +	.get_name =3D cxl_ecs_get_name,
>> +};
>> +
>>  int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct
>> cxl_region *cxlr)  {
>>  	struct edac_ras_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
>>  	struct cxl_patrol_scrub_context *cxl_ps_ctx;
>>  	struct cxl_mbox_supp_feat_entry feat_entry;
>>  	char cxl_dev_name[CXL_SCRUB_NAME_LEN];
>> +	struct cxl_ecs_context *cxl_ecs_ctx;
>>  	int rc, i, num_ras_features =3D 0;
>> +	int num_media_frus;
>>
>>  	if (cxlr) {
>>  		struct cxl_region_params *p =3D &cxlr->params; @@ -407,6
>+805,37 @@
>> int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_regio=
n
>*cxlr)
>>  	ras_features[num_ras_features].scrub_ctx =3D cxl_ps_ctx;
>>  	num_ras_features++;
>>
>> +	if (!cxlr) {
>> +		rc =3D cxl_mem_get_supported_feature_entry(cxlmd,
>&cxl_ecs_uuid, &feat_entry);
>> +		if (rc < 0)
>> +			goto feat_register;
>> +
>> +		if (!(feat_entry.attr_flags &
>CXL_FEAT_ENTRY_FLAG_CHANGABLE))
>> +			goto feat_register;
>> +		num_media_frus =3D feat_entry.get_size/
>> +					sizeof(struct cxl_ecs_rd_attrs);
>> +		if (!num_media_frus)
>> +			goto feat_register;
>> +
>> +		cxl_ecs_ctx =3D devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ecs_ctx),
>GFP_KERNEL);
>> +		if (!cxl_ecs_ctx)
>> +			goto feat_register;
>> +		*cxl_ecs_ctx =3D (struct cxl_ecs_context) {
>> +			.get_feat_size =3D feat_entry.get_size,
>> +			.set_feat_size =3D feat_entry.set_size,
>> +			.num_media_frus =3D num_media_frus,
>> +			.cxlmd =3D cxlmd,
>> +		};
>> +
>> +		ras_features[num_ras_features].feat =3D ras_feat_ecs;
>> +		ras_features[num_ras_features].ecs_ops =3D &cxl_ecs_ops;
>> +		ras_features[num_ras_features].ecs_ctx =3D cxl_ecs_ctx;
>> +		ras_features[num_ras_features].ecs_info.num_media_frus =3D
>num_media_frus;
>> +		num_ras_features++;
>> +	}
>> +
>> +feat_register:
>> +
>>  	return edac_ras_dev_register(&cxlmd->dev, cxl_dev_name, NULL,
>>  				     num_ras_features, ras_features);  }
>> --
>> 2.34.1
>>
Thanks,
Shiju

