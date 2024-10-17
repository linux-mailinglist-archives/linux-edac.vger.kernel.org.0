Return-Path: <linux-edac+bounces-2120-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DFC9A1D55
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 10:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14A31C21601
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 08:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3B81D3648;
	Thu, 17 Oct 2024 08:37:45 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABA4762EB;
	Thu, 17 Oct 2024 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729154265; cv=none; b=OpPNn4dyVSVu4qstPfBkGYXaA0dD0Hx8yQTah6P51iJKlsa8D4/Uzj5Ct2tA9bZXkqc5LM8hR7wsyoDr8baDtnZC3/gOcdKPdL438q58lJyA6hLIWFNTUoS8e5KmlAMkeU8kL1naO/ACki/eW/vDqqGFM5br3DohRSPGHQ3NNHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729154265; c=relaxed/simple;
	bh=WoYkazkHU6AwGRAFRR6XpGrloyKBMWmwP2W1nHF6/ss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ni5JDQrTPBNTWb2cOZMxW7w2Rt1v/+T6TRGH6Hrazg+pzJ1SW1mQoT31OJDvc4iGZTElXlSXaEKGeO26gPQwUhLFyFTT9Amu+YYHhQVYuU82XYD/WtxaT/cKDBqJ4sCNkKgyJMrFC9tbbvsOnQ2466F58E0wH6XdJB9aR0jwiqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTh1J1KV5z6LD8T;
	Thu, 17 Oct 2024 16:33:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 791C71400F4;
	Thu, 17 Oct 2024 16:37:39 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 10:37:39 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 17 Oct 2024 10:37:39 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
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
	<duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v13 01/18] EDAC: Add support for EDAC device features
 control
Thread-Topic: [PATCH v13 01/18] EDAC: Add support for EDAC device features
 control
Thread-Index: AQHbGkjIT8EMR4nHhkSztyssI50yp7KGMcmAgAMn9YA=
Date: Thu, 17 Oct 2024 08:37:38 +0000
Message-ID: <9431b46fefec4f87bcd5e7999b97ed00@huawei.com>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
	<20241009124120.1124-2-shiju.jose@huawei.com>
 <20241014151829.00000e7f@Huawei.com>
In-Reply-To: <20241014151829.00000e7f@Huawei.com>
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

Hi Jonathan,=20

>-----Original Message-----
>From: Jonathan Cameron <jonathan.cameron@huawei.com>
>Sent: 14 October 2024 15:18
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org; linux-
>acpi@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org;
>bp@alien8.de; tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
>mchehab@kernel.org; dan.j.williams@intel.com; dave@stgolabs.net;
>dave.jiang@intel.com; alison.schofield@intel.com; vishal.l.verma@intel.com=
;
>ira.weiny@intel.com; david@redhat.com; Vilas.Sridharan@amd.com;
>leo.duran@amd.com; Yazen.Ghannam@amd.com; rientjes@google.com;
>jiaqiyan@google.com; Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
>naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
>somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
>duenwen@google.com; gthelen@google.com;
>wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
>wbs@os.amperecomputing.com; nifan.cxl@gmail.com; tanxiaofei
><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Roberto
>Sassu <roberto.sassu@huawei.com>; kangkang.shen@futurewei.com;
>wanghuiqiang <wanghuiqiang@huawei.com>; Linuxarm
><linuxarm@huawei.com>
>Subject: Re: [PATCH v13 01/18] EDAC: Add support for EDAC device features
>control
>
>On Wed, 9 Oct 2024 13:41:02 +0100
><shiju.jose@huawei.com> wrote:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add generic EDAC device features control supports registering RAS
>> features supported in the system. Driver exposes features control
>> attributes to userspace in
>> /sys/bus/edac/devices/<dev-name>/<ras-feature>/
>>
>> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>Hi Shiju,
>
>Spotted a few minor bugs in here that I'd missed in internal review :( See=
 below.
>
>Jonathan

Thanks for reviewing.
>
>> ---
>>  drivers/edac/edac_device.c | 105
>+++++++++++++++++++++++++++++++++++++
>>  include/linux/edac.h       |  32 +++++++++++
>>  2 files changed, 137 insertions(+)
>>
>> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
>> index 621dc2a5d034..0b8aa8150239 100644
>> --- a/drivers/edac/edac_device.c
>> +++ b/drivers/edac/edac_device.c
>
>
>> +
>> +/**
>> + * edac_dev_register - register device for RAS features with EDAC
>> + * @parent: client device.
>> + * @name: client device's name.
>> + * @private: parent driver's data to store in the context if any.
>> + * @num_features: number of RAS features to register.
>> + * @ras_features: list of RAS features to register.
>> + *
>> + * Return:
>> + *  * %0       - Success.
>> + *  * %-EINVAL - Invalid parameters passed.
>> + *  * %-ENOMEM - Dynamic memory allocation failed.
>> + *
>> + * The new edac_dev_feat_ctx would be freed automatically.
>> + */
>> +int edac_dev_register(struct device *parent, char *name,
>> +		      void *private, int num_features,
>> +		      const struct edac_dev_feature *ras_features) {
>
>...
>
>> +	ret =3D device_register(&ctx->dev);
>> +	if (ret) {
>> +		put_device(&ctx->dev);
>> +		goto groups_free;
>> +		return ret;
>
>Unreachable line. However, shouldn't have the goto here as put_device() sh=
ould
>result in the release being called in which case this is a double free. So=
 drop the
>goto and keep the return.
Fixed.
>
>
>> +	}
>> +
>> +	return devm_add_action_or_reset(parent, edac_dev_unreg, &ctx->dev);
>> +
>> +groups_free:
>> +	kfree(ras_attr_groups);
>> +ctx_free:
>> +	kfree(ctx);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(edac_dev_register);
>> diff --git a/include/linux/edac.h b/include/linux/edac.h index
>> b4ee8961e623..1db008a82690 100644
>> --- a/include/linux/edac.h
>> +++ b/include/linux/edac.h
>> @@ -661,4 +661,36 @@ static inline struct dimm_info
>> *edac_get_dimm(struct mem_ctl_info *mci,
>
>
>> +/* EDAC device feature information structure */ struct edac_dev_data
>> +{
>> +	u8 instance;
>> +	void *private;
>> +};
>> +
>> +struct device;
>
>That forwards def doesn't work as this header needs to include enough
>information to establish layout of struct edac_dev_feat_ctx.
>Header already includes linux/device.h so just drop this.
Deleted.
>
>
>> +
>> +struct edac_dev_feat_ctx {
>> +	struct device dev;
>> +	void *private;
>> +};
>> +
>> +struct edac_dev_feature {
>> +	enum edac_dev_feat ft_type;
>> +	u8 instance;
>> +	void *ctx;
>> +};
>> +
>> +int edac_dev_register(struct device *parent, char *dev_name,
>> +		      void *parent_pvt_data, int num_features,
>> +		      const struct edac_dev_feature *ras_features);
>>  #endif /* _LINUX_EDAC_H_ */


Thanks,
Shiju

