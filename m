Return-Path: <linux-edac+bounces-3966-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E549ABE834
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 01:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64BE67B3210
	for <lists+linux-edac@lfdr.de>; Tue, 20 May 2025 23:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E64925EFBE;
	Tue, 20 May 2025 23:44:28 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC22220C469;
	Tue, 20 May 2025 23:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747784668; cv=none; b=MRmbgo/joJWMnui5a26nZaJleoYvW22HCvj7iU/ibC4SRqUIqqKUB5PCaT8p2kq1Fi3Q3CCIu8DjCFL3PKwEuuaWHPSnEVtxm3DcU7rziiBr98pw8NB1GuohVjGb4sTvyMYsZY01kkOjcq6YkBXXkOJ9ha6e0/phRyIjZsIAlX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747784668; c=relaxed/simple;
	bh=Kr1oSPOolkMSnzP72YucAcyAO1ZnkOQH8vdG22/vtCM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D0wAfxwrZEm5h6dBXvLE0XsXqyiFVa/YTORLIcHNiVRt8IPLZgMECuaTWL5odSA9OEVVMLlBsWJgKerTMRZsRrIHajC6PPy+Lq0hBHWHNoC6+QSjt2kK/NsO9s0y+A54dAT5w8/nUGvaiU7zoZJ0gzG1MqJongYi96lhKGale+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b29zs3gz7z67l35;
	Wed, 21 May 2025 07:41:13 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 28CD81400F4;
	Wed, 21 May 2025 07:44:23 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 May 2025 01:44:22 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 21 May 2025 01:44:22 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"lenb@kernel.org" <lenb@kernel.org>, "Yazen.Ghannam@amd.com"
	<Yazen.Ghannam@amd.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, Linuxarm <linuxarm@huawei.com>,
	tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>
Subject: RE: [PATCH v5 3/8] cxl/edac: Add CXL memory device patrol scrub
 control feature
Thread-Topic: [PATCH v5 3/8] cxl/edac: Add CXL memory device patrol scrub
 control feature
Thread-Index: AQHbxZDdKsDlafNwgkm9L5zIgWpe8bPaqcOAgAGLCFA=
Date: Tue, 20 May 2025 23:44:22 +0000
Message-ID: <3def6e579ab4439fb933ee742b3d9752@huawei.com>
References: <20250515115927.772-1-shiju.jose@huawei.com>
 <20250515115927.772-4-shiju.jose@huawei.com>
 <aCviqcNwQCUokZhl@aschofie-mobl2.lan>
In-Reply-To: <aCviqcNwQCUokZhl@aschofie-mobl2.lan>
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
>Sent: 20 May 2025 03:02
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-cxl@vger.kernel.org; dan.j.williams@intel.com; Jonathan Cameron
><jonathan.cameron@huawei.com>; dave.jiang@intel.com; dave@stgolabs.net;
>vishal.l.verma@intel.com; ira.weiny@intel.com; linux-edac@vger.kernel.org;
>linux-doc@vger.kernel.org; bp@alien8.de; tony.luck@intel.com;
>lenb@kernel.org; Yazen.Ghannam@amd.com; mchehab@kernel.org;
>nifan.cxl@gmail.com; Linuxarm <linuxarm@huawei.com>; tanxiaofei
><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Roberto
>Sassu <roberto.sassu@huawei.com>; kangkang.shen@futurewei.com;
>wanghuiqiang <wanghuiqiang@huawei.com>
>Subject: Re: [PATCH v5 3/8] cxl/edac: Add CXL memory device patrol scrub
>control feature
>
>On Thu, May 15, 2025 at 12:59:19PM +0100, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL spec 3.2 section 8.2.10.9.11.1 describes the device patrol scrub
>> control feature. The device patrol scrub proactively locates and makes
>> corrections to errors in regular cycle.
>>
>
>snip
>
>> +
>> +static int cxl_scrub_get_attrbs(struct cxl_patrol_scrub_context *cxl_ps=
_ctx,
>> +				u8 *cap, u16 *cycle, u8 *flags, u8 *min_cycle) {
>> +	struct cxl_mailbox *cxl_mbox;
>> +	u8 min_scrub_cycle =3D U8_MAX;
>> +	struct cxl_memdev *cxlmd;
>> +	int i, ret;
>> +
>> +	if (cxl_ps_ctx->cxlr) {
>> +		struct cxl_region *cxlr =3D cxl_ps_ctx->cxlr;
>> +		struct cxl_region_params *p =3D &cxlr->params;
>
>This function and the next, have a big if { } wrapper around cxlr existenc=
e. Can
>this logic be reversed -
>
>ie, declare cxl_region and cxl_region_params in the header and then do
>something like -
>
>	if (!cxl_ps_ctx->cxlr) {
>		cxl_mbox =3D &cxl_ps_ctx->cxlmd->cxlds->cxl_mbox;
>		return cxl_mem_scrub_get_attrbs(cxl_mbox, cap, cycle, flags,
>min_cycle);
>	}
>
>	cxlr =3D  cxl_ps_ctx->cxlr;
>	p =3D &cxlr->params;
>
>Then all this code below can shift left.
Changed.

>
>> +
>> +		struct rw_semaphore *region_lock
>__free(rwsem_read_release) =3D
>> +			rwsem_read_intr_acquire(&cxl_region_rwsem);
>> +		if (!region_lock)
>> +			return -EINTR;
>> +
>> +		for (i =3D 0; i < p->nr_targets; i++) {
>> +			struct cxl_endpoint_decoder *cxled =3D p->targets[i];
>> +
>> +			cxlmd =3D cxled_to_memdev(cxled);
>> +			cxl_mbox =3D &cxlmd->cxlds->cxl_mbox;
>> +			ret =3D cxl_mem_scrub_get_attrbs(cxl_mbox, cap, cycle,
>> +						       flags, min_cycle);
>> +			if (ret)
>> +				return ret;
>> +
>> +			if (min_cycle)
>> +				min_scrub_cycle =3D
>> +					min(*min_cycle, min_scrub_cycle);
>> +		}
>> +
>> +		if (min_cycle)
>> +			*min_cycle =3D min_scrub_cycle;
>> +
>> +		return 0;
>> +	}
>> +	cxl_mbox =3D &cxl_ps_ctx->cxlmd->cxlds->cxl_mbox;
>> +
>> +	return cxl_mem_scrub_get_attrbs(cxl_mbox, cap, cycle, flags,
>> +min_cycle); }
>> +
>> +static int cxl_scrub_set_attrbs(struct device *dev,
>> +				struct cxl_patrol_scrub_context *cxl_ps_ctx,
>> +				u8 cycle, u8 flags)
>> +{
>> +	struct cxl_scrub_wr_attrbs wr_attrbs;
>> +	struct cxl_mailbox *cxl_mbox;
>> +	struct cxl_memdev *cxlmd;
>> +	int ret, i;
>> +
>> +	wr_attrbs.scrub_cycle_hours =3D cycle;
>> +	wr_attrbs.scrub_flags =3D flags;
>> +
>> +	if (cxl_ps_ctx->cxlr) {
>> +		struct cxl_region *cxlr =3D cxl_ps_ctx->cxlr;
>> +		struct cxl_region_params *p =3D &cxlr->params;
>
>Similar to above function, but more work in the !cxlr case. Maybe a goto.
Modified with helper functions.
>
>
>> +
>> +		struct rw_semaphore *region_lock
>__free(rwsem_read_release) =3D
>> +			rwsem_read_intr_acquire(&cxl_region_rwsem);
>> +		if (!region_lock)
>> +			return -EINTR;
>> +
>> +		for (i =3D 0; i < p->nr_targets; i++) {
>> +			struct cxl_endpoint_decoder *cxled =3D p->targets[i];
>> +
>> +			cxlmd =3D cxled_to_memdev(cxled);
>> +			cxl_mbox =3D &cxlmd->cxlds->cxl_mbox;
>> +			ret =3D cxl_set_feature(cxl_mbox,
>&CXL_FEAT_PATROL_SCRUB_UUID,
>> +					      cxl_ps_ctx->set_version,
>&wr_attrbs,
>> +					      sizeof(wr_attrbs),
>> +
>CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET,
>> +					      0, NULL);
>> +			if (ret)
>> +				return ret;
>> +
>> +			if (cycle !=3D cxlmd->cur_scrub_cycle) {
>> +				if (cxlmd->cur_region_id !=3D -1)
>> +					dev_info(dev,
>> +						 "Device scrub rate(%d hours)
>set by region%d rate overwritten by region%d scrub rate(%d hours)\n",
>> +						 cxlmd->cur_scrub_cycle,
>> +						 cxlmd->cur_region_id, cxlr->id,
>> +						 cycle);
>> +
>> +				cxlmd->cur_scrub_cycle =3D cycle;
>> +				cxlmd->cur_region_id =3D cxlr->id;
>> +			}
>> +		}
>> +
>> +		return 0;
>> +	}
>> +
>> +	cxlmd =3D cxl_ps_ctx->cxlmd;
>> +	cxl_mbox =3D &cxlmd->cxlds->cxl_mbox;
>> +	ret =3D cxl_set_feature(cxl_mbox, &CXL_FEAT_PATROL_SCRUB_UUID,
>> +			      cxl_ps_ctx->set_version, &wr_attrbs,
>> +			      sizeof(wr_attrbs),
>> +			      CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET,
>0,
>> +			      NULL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (cycle !=3D cxlmd->cur_scrub_cycle) {
>> +		if (cxlmd->cur_region_id !=3D -1)
>> +			dev_info(dev,
>> +				 "Device scrub rate(%d hours) set by region%d
>rate overwritten with device local scrub rate(%d hours)\n",
>> +				 cxlmd->cur_scrub_cycle, cxlmd-
>>cur_region_id,
>> +				 cycle);
>> +
>> +		cxlmd->cur_scrub_cycle =3D cycle;
>> +		cxlmd->cur_region_id =3D -1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>
>skip
>
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h index
>> 3ec6b906371b..685957b312ea 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -45,6 +45,8 @@
>>   * @endpoint: connection to the CXL port topology for this memory devic=
e
>>   * @id: id number of this memdev instance.
>>   * @depth: endpoint port depth
>> + * @cur_scrub_cycle: current scrub cycle set for this device
>> + * @cur_region_id: id number of a backed region (if any) for which
>> + current scrub cycle set
>>   */
>>  struct cxl_memdev {
>>  	struct device dev;
>> @@ -56,6 +58,10 @@ struct cxl_memdev {
>>  	struct cxl_port *endpoint;
>>  	int id;
>>  	int depth;
>> +#ifdef CONFIG_CXL_EDAC_SCRUB
>> +	u8 cur_scrub_cycle;
>> +	int cur_region_id;
>> +#endif
>>  };
>
>
>Why the cur_ prefix?  Seems like it's just 'the' scrub cycle.
>
>How about:
>
>s/cur_scrub_cycle/scrub_cycle
>s/cur_region_id/scrub_region_id
>
>That also makes it clear that the region_id is related to the scrub.
Changed.

>
>Somewhere later cur_region_id gets compared to -1 a few times.
>Perhaps add a define for that like #define CXL_SCRUB_NO_REGION -1

Added and used CXL_SCRUB_NO_REGION.
>
>>
>>  static inline struct cxl_memdev *to_cxl_memdev(struct device *dev) @@
>> -853,6 +859,16 @@ int cxl_trigger_poison_list(struct cxl_memdev
>> *cxlmd);  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>> int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
>>
>> +#if IS_ENABLED(CONFIG_CXL_EDAC_MEM_FEATURES)
>
>that's the one I mentioned in cover letter that can be #ifdef
>
>> +int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd); int
>> +devm_cxl_region_edac_register(struct cxl_region *cxlr); #else static
>> +inline int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd) {
>> +return 0; } static inline int devm_cxl_region_edac_register(struct
>> +cxl_region *cxlr) { return 0; } #endif
>> +
>>  #ifdef CONFIG_CXL_SUSPEND
>>  void cxl_mem_active_inc(void);
>>  void cxl_mem_active_dec(void);
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c index
>> 9675243bd05b..6e6777b7bafb 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -180,6 +180,10 @@ static int cxl_mem_probe(struct device *dev)
>>  			return rc;
>>  	}
>>
>> +	rc =3D devm_cxl_memdev_edac_register(cxlmd);
>> +	if (rc)
>> +		dev_dbg(dev, "CXL memdev EDAC registration failed rc=3D%d\n",
>rc);
>> +
>>  	/*
>>  	 * The kernel may be operating out of CXL memory on this device,
>>  	 * there is no spec defined way to determine whether this device
>> --
>> 2.43.0
>>
>>

Thanks,
Shiju


