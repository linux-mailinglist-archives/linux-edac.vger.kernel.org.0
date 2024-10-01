Return-Path: <linux-edac+bounces-1943-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4572A98B73C
	for <lists+linux-edac@lfdr.de>; Tue,  1 Oct 2024 10:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7962EB22825
	for <lists+linux-edac@lfdr.de>; Tue,  1 Oct 2024 08:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D190019C568;
	Tue,  1 Oct 2024 08:40:04 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB8419AD89;
	Tue,  1 Oct 2024 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772004; cv=none; b=W09eHw3u6678wEDyxnOiuj6XflL5SgIewlCc10Lpe63shhjxJ3X/IoErnco6cwKQDh2P9tkojhYLpi9M5q9FKIbXrAsRgg7IeZg5cqkgbLyXxOHv0dbXM19p9C+DVmWFCv1rnGTzieMmSErEAouR0qyIX0X0JESm6cPvCvkKiV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772004; c=relaxed/simple;
	bh=qoK1k2+Un2d8sZjwTlFRPG/nPl3TZCbJD/otNyvE1Vc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dOZJKRwoDgwhtZRQ3ohVTakGXN8NCX3d8G8c9kdhfq8xPODtR+XLrledPpVKxGTYGM6XEUwaL+QgctVI48hkvbj0yZrS2vJgF1pkRZqSq58/HxKSL1Mo0wqwBxJbYmtsq6RI5XzzcNMzvFnXriKpzC8FAkemnH6C31dn6rY1UjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XHrpx56Wpz6D8cG;
	Tue,  1 Oct 2024 16:35:05 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E9DA140123;
	Tue,  1 Oct 2024 16:39:59 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 10:39:59 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 1 Oct 2024 10:39:59 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Fan Ni <nifan.cxl@gmail.com>
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
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"jgroves@micron.com" <jgroves@micron.com>, "vsalve@micron.com"
	<vsalve@micron.com>, tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)"
	<prime.zeng@hisilicon.com>, Roberto Sassu <roberto.sassu@huawei.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, wanghuiqiang
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v12 11/17] cxl/memfeature: Add CXL memory device ECS
 control feature
Thread-Topic: [PATCH v12 11/17] cxl/memfeature: Add CXL memory device ECS
 control feature
Thread-Index: AQHbBCoKitzsuIEzWkCci9OErLsEpLJwnswAgAETZzA=
Date: Tue, 1 Oct 2024 08:39:59 +0000
Message-ID: <344736b375b74e1c8246bdb8d7d4fee6@huawei.com>
References: <20240911090447.751-1-shiju.jose@huawei.com>
 <20240911090447.751-12-shiju.jose@huawei.com> <ZvrqFHQ8TPv_c3vC@fan>
In-Reply-To: <ZvrqFHQ8TPv_c3vC@fan>
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
>From: Fan Ni <nifan.cxl@gmail.com>
>Sent: 30 September 2024 19:13
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
>wbs@os.amperecomputing.com; nifan.cxl@gmail.com; jgroves@micron.com;
>vsalve@micron.com; tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
><prime.zeng@hisilicon.com>; Roberto Sassu <roberto.sassu@huawei.com>;
>kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
>Linuxarm <linuxarm@huawei.com>
>Subject: Re: [PATCH v12 11/17] cxl/memfeature: Add CXL memory device ECS
>control feature
>
>On Wed, Sep 11, 2024 at 10:04:40AM +0100, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 ECS (Error Check
>> Scrub) control feature.
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
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  drivers/cxl/core/memfeature.c | 439
>> +++++++++++++++++++++++++++++++++-
>>  1 file changed, 438 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/memfeature.c
>> b/drivers/cxl/core/memfeature.c index 90c68d20b02b..5d4057fa304c
>> 100644
>> --- a/drivers/cxl/core/memfeature.c
>> +++ b/drivers/cxl/core/memfeature.c
>> @@ -19,7 +19,7 @@
>>  #include <cxl.h>
>>  #include <linux/edac.h>
>>
>> -#define CXL_DEV_NUM_RAS_FEATURES	1
>> +#define CXL_DEV_NUM_RAS_FEATURES	2
>>  #define CXL_DEV_HOUR_IN_SECS	3600
>>
>>  #define CXL_SCRUB_NAME_LEN	128
>> @@ -303,6 +303,405 @@ static const struct edac_scrub_ops cxl_ps_scrub_op=
s
>=3D {
>>  	.cycle_duration_write =3D cxl_patrol_scrub_write_scrub_cycle,
>>  };
>>
>...
>> +	case CXL_ECS_PARAM_THRESHOLD:
>> +		wr_attrs[fru_id].ecs_config &=3D
>~CXL_ECS_THRESHOLD_COUNT_MASK;
>> +		switch (params->threshold) {
>> +		case 256:
>> +			wr_attrs[fru_id].ecs_config |=3D
>FIELD_PREP(CXL_ECS_THRESHOLD_COUNT_MASK,
>> +
>ECS_THRESHOLD_256);
>> +			break;
>> +		case 1024:
>> +			wr_attrs[fru_id].ecs_config |=3D
>FIELD_PREP(CXL_ECS_THRESHOLD_COUNT_MASK,
>> +
>ECS_THRESHOLD_1024);
>> +			break;
>> +		case 4096:
>> +			wr_attrs[fru_id].ecs_config |=3D
>FIELD_PREP(CXL_ECS_THRESHOLD_COUNT_MASK,
>> +
>ECS_THRESHOLD_4096);
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
>The messaging here can be improved. When printed out in dmesg, it looks li=
ke
>
>root@localhost:~# echo 2 > /sys/bus/edac/devices/cxl_mem0/ecs_fru0/mode
>----
>[ 6099.073006] cxl_mem mem0: Invalid CXL ECS scrub mode(2) to set [
>6099.074407] cxl_mem mem0: Mode 0: ECS counts rows with errors 1: ECS
>counts codewords with errors
>----
>Maybe use similar message format as threshold above, like
>+			dev_err(dev,
>+				"Supported ECS mode: 0: ECS counts rows with
>errors; 1: ECS counts
>+codewords with errors\n");

Will modify.
>
>Fan

Thanks,
Shiju
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
>> +	ret =3D cxl_set_feature(cxlds, cxl_ecs_uuid, cxl_ecs_ctx->set_version,
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
>> +static int cxl_ecs_get_log_entry_type(struct device *dev, void *drv_dat=
a,
>> +				      int fru_id, u32 *val)
>> +{
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
>> +static int cxl_ecs_set_log_entry_type(struct device *dev, void *drv_dat=
a,
>> +				      int fru_id, u32 val)
>> +{
>> +	struct cxl_ecs_params params =3D {
>> +		.log_entry_type =3D val,
>> +	};
>> +
>> +	return cxl_mem_ecs_set_attrs(dev, drv_data, fru_id,
>> +				     &params,
>CXL_ECS_PARAM_LOG_ENTRY_TYPE); }
>> +
>> +static int cxl_ecs_get_log_entry_type_per_dram(struct device *dev, void
>*drv_data,
>> +					       int fru_id, u32 *val)
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
>*dev,
>> +						       void *drv_data,
>> +						       int fru_id, u32 *val)
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
>> +static int cxl_ecs_get_mode(struct device *dev, void *drv_data,
>> +			    int fru_id, u32 *val)
>> +{
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
>> +static int cxl_ecs_set_mode(struct device *dev, void *drv_data,
>> +			    int fru_id, u32 val)
>> +{
>> +	struct cxl_ecs_params params =3D {
>> +		.mode =3D val,
>> +	};
>> +
>> +	return cxl_mem_ecs_set_attrs(dev, drv_data, fru_id,
>> +				     &params, CXL_ECS_PARAM_MODE); }
>> +
>> +static int cxl_ecs_get_mode_counts_rows(struct device *dev, void *drv_d=
ata,
>> +					int fru_id, u32 *val)
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
>> +					     int fru_id, u32 *val)
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
>> +fru_id, u32 val) {
>> +	struct cxl_ecs_params params =3D {
>> +		.reset_counter =3D val,
>> +	};
>> +
>> +	return cxl_mem_ecs_set_attrs(dev, drv_data, fru_id,
>> +				     &params,
>CXL_ECS_PARAM_RESET_COUNTER); }
>> +
>> +static int cxl_ecs_get_threshold(struct device *dev, void *drv_data,
>> +				 int fru_id, u32 *val)
>> +{
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
>> +				 int fru_id, u32 val)
>> +{
>> +	struct cxl_ecs_params params =3D {
>> +		.threshold =3D val,
>> +	};
>> +
>> +	return cxl_mem_ecs_set_attrs(dev, drv_data, fru_id,
>> +				     &params, CXL_ECS_PARAM_THRESHOLD); }
>> +
>> +static const struct edac_ecs_ops cxl_ecs_ops =3D {
>> +	.get_log_entry_type =3D cxl_ecs_get_log_entry_type,
>> +	.set_log_entry_type =3D cxl_ecs_set_log_entry_type,
>> +	.get_log_entry_type_per_dram =3D
>cxl_ecs_get_log_entry_type_per_dram,
>> +	.get_log_entry_type_per_memory_media =3D
>> +
>	cxl_ecs_get_log_entry_type_per_memory_media,
>> +	.get_mode =3D cxl_ecs_get_mode,
>> +	.set_mode =3D cxl_ecs_set_mode,
>> +	.get_mode_counts_codewords =3D cxl_ecs_get_mode_counts_codewords,
>> +	.get_mode_counts_rows =3D cxl_ecs_get_mode_counts_rows,
>> +	.reset =3D cxl_ecs_reset,
>> +	.get_threshold =3D cxl_ecs_get_threshold,
>> +	.set_threshold =3D cxl_ecs_set_threshold, };
>> +
>>  int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct
>> cxl_region *cxlr)  {
>>  	struct edac_dev_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
>> @@ -310,7 +709,9 @@ int cxl_mem_ras_features_init(struct cxl_memdev
>*cxlmd, struct cxl_region *cxlr)
>>  	struct cxl_patrol_scrub_context *cxl_ps_ctx;
>>  	struct cxl_feat_entry feat_entry;
>>  	char cxl_dev_name[CXL_SCRUB_NAME_LEN];
>> +	struct cxl_ecs_context *cxl_ecs_ctx;
>>  	int rc, i, num_ras_features =3D 0;
>> +	int num_media_frus;
>>
>>  	if (cxlr) {
>>  		struct cxl_region_params *p =3D &cxlr->params; @@ -366,6
>+767,42 @@
>> int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct cxl_regio=
n
>*cxlr)
>>  	ras_features[num_ras_features].ctx =3D cxl_ps_ctx;
>>  	num_ras_features++;
>>
>> +	if (!cxlr) {
>> +		rc =3D cxl_get_supported_feature_entry(cxlds, &cxl_ecs_uuid,
>> +						     &feat_entry);
>> +		if (rc < 0)
>> +			goto feat_register;
>> +
>> +		if (!(feat_entry.attr_flags &
>CXL_FEAT_ENTRY_FLAG_CHANGABLE))
>> +			goto feat_register;
>> +		num_media_frus =3D feat_entry.get_feat_size /
>> +					sizeof(struct cxl_ecs_rd_attrs);
>> +		if (!num_media_frus)
>> +			goto feat_register;
>> +
>> +		cxl_ecs_ctx =3D devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ecs_ctx),
>> +					   GFP_KERNEL);
>> +		if (!cxl_ecs_ctx)
>> +			goto feat_register;
>> +		*cxl_ecs_ctx =3D (struct cxl_ecs_context) {
>> +			.get_feat_size =3D feat_entry.get_feat_size,
>> +			.set_feat_size =3D feat_entry.set_feat_size,
>> +			.get_version =3D feat_entry.get_feat_ver,
>> +			.set_version =3D feat_entry.set_feat_ver,
>> +			.set_effects =3D feat_entry.set_effects,
>> +			.num_media_frus =3D num_media_frus,
>> +			.cxlmd =3D cxlmd,
>> +		};
>> +
>> +		ras_features[num_ras_features].ft_type =3D RAS_FEAT_ECS;
>> +		ras_features[num_ras_features].ecs_ops =3D &cxl_ecs_ops;
>> +		ras_features[num_ras_features].ctx =3D cxl_ecs_ctx;
>> +		ras_features[num_ras_features].ecs_info.num_media_frus =3D
>> +
>	num_media_frus;
>> +		num_ras_features++;
>> +	}
>> +
>> +feat_register:
>>  	return edac_dev_register(&cxlmd->dev, cxl_dev_name, NULL,
>>  				 num_ras_features, ras_features);  }
>> --
>> 2.34.1
>>
>
>--
>Fan Ni

