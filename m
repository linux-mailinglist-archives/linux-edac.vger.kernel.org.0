Return-Path: <linux-edac+bounces-1882-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6400097A5D0
	for <lists+linux-edac@lfdr.de>; Mon, 16 Sep 2024 18:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3F628A843
	for <lists+linux-edac@lfdr.de>; Mon, 16 Sep 2024 16:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30506158DC0;
	Mon, 16 Sep 2024 16:16:34 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C398B154C14;
	Mon, 16 Sep 2024 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726503394; cv=none; b=Dw9iWX6mSF1PhnTGokZ/ASu2aSFcLu02AB8Il2AcruHKFqoEJ8JDVGa9O4SVDcP7j7nkhsy2uxDJDADtlCfpY2Wn5ojD7YiUkjYEs6x/TG4cIYXHOyKVrVQCYN+j/IVNI/1h3r+QbTdTS0HKi9t1duDMSYo6CTAjafR+aOp1Q6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726503394; c=relaxed/simple;
	bh=vqzYyA10Ra+Ue2aMyu+n6htlVt6+PdHenejO+zV5cVE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rDbG8tQgukTmR0n3VaQZvlMCEHkZx7SlIUJ5hn1b5g3Lb+2BXxQXYczTsFDVbDajW+Wh30xpiwmwAt0orwgSQSBZNwi9e9uEwvyrI0x94OQeqRg1emfEzsddvHjq/nknxjrwAEiddMIg/8N1eXLTAljdkwfRWEunh5hYksX1190=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6qgM6yfmz6K9Cj;
	Tue, 17 Sep 2024 00:12:15 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
	by mail.maildlp.com (Postfix) with ESMTPS id F271E140C98;
	Tue, 17 Sep 2024 00:16:27 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 18:16:27 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 16 Sep 2024 18:16:27 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: Borislav Petkov <bp@alien8.de>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
	<duenwen@google.com>, "mike.malvestuto@intel.com"
	<mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, "jgroves@micron.com"
	<jgroves@micron.com>, "vsalve@micron.com" <vsalve@micron.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v12 01/17] EDAC: Add support for EDAC device features
 control
Thread-Topic: [PATCH v12 01/17] EDAC: Add support for EDAC device features
 control
Thread-Index: AQHbBCn2X0FlmKPPaUWpEENlHZJn/rJVzXyAgARPCJCAAAYMAIAAfGFw
Date: Mon, 16 Sep 2024 16:16:27 +0000
Message-ID: <518da468c15047c0b78781784688f4f5@huawei.com>
References: <20240911090447.751-1-shiju.jose@huawei.com>
	<20240911090447.751-2-shiju.jose@huawei.com>
	<20240913164041.GKZuRrCeoFZBapVYaU@fat_crate.local>
	<c31c733bb6e742f580721ec9d0e2f3b2@huawei.com>
 <20240916115014.000064bf@Huawei.com>
In-Reply-To: <20240916115014.000064bf@Huawei.com>
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
>From: Jonathan Cameron <jonathan.cameron@huawei.com>
>Sent: 16 September 2024 11:50
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: Borislav Petkov <bp@alien8.de>; linux-edac@vger.kernel.org; linux-
>cxl@vger.kernel.org; linux-acpi@vger.kernel.org; linux-mm@kvack.org; linux=
-
>kernel@vger.kernel.org; tony.luck@intel.com; rafael@kernel.org;
>lenb@kernel.org; mchehab@kernel.org; dan.j.williams@intel.com;
>dave@stgolabs.net; dave.jiang@intel.com; alison.schofield@intel.com;
>vishal.l.verma@intel.com; ira.weiny@intel.com; david@redhat.com;
>Vilas.Sridharan@amd.com; leo.duran@amd.com; Yazen.Ghannam@amd.com;
>rientjes@google.com; jiaqiyan@google.com; Jon.Grimm@amd.com;
>dave.hansen@linux.intel.com; naoya.horiguchi@nec.com;
>james.morse@arm.com; jthoughton@google.com; somasundaram.a@hpe.com;
>erdemaktas@google.com; pgonda@google.com; duenwen@google.com;
>mike.malvestuto@intel.com; gthelen@google.com;
>wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
>wbs@os.amperecomputing.com; nifan.cxl@gmail.com; jgroves@micron.com;
>vsalve@micron.com; tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
><prime.zeng@hisilicon.com>; Roberto Sassu <roberto.sassu@huawei.com>;
>kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
>Linuxarm <linuxarm@huawei.com>
>Subject: Re: [PATCH v12 01/17] EDAC: Add support for EDAC device features
>control
>
>On Mon, 16 Sep 2024 10:21:58 +0100
>Shiju Jose <shiju.jose@huawei.com> wrote:
>
>> Thanks for reviewing.
>>
>> >-----Original Message-----
>> >From: Borislav Petkov <bp@alien8.de>
>> >Sent: 13 September 2024 17:41
>> >To: Shiju Jose <shiju.jose@huawei.com>
>> >Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org; linux-
>> >acpi@vger.kernel.org; linux-mm@kvack.org;
>> >linux-kernel@vger.kernel.org; tony.luck@intel.com; rafael@kernel.org;
>> >lenb@kernel.org; mchehab@kernel.org; dan.j.williams@intel.com;
>> >dave@stgolabs.net; Jonathan Cameron <jonathan.cameron@huawei.com>;
>> >dave.jiang@intel.com; alison.schofield@intel.com;
>> >vishal.l.verma@intel.com; ira.weiny@intel.com; david@redhat.com;
>> >Vilas.Sridharan@amd.com; leo.duran@amd.com;
>Yazen.Ghannam@amd.com;
>> >rientjes@google.com; jiaqiyan@google.com; Jon.Grimm@amd.com;
>> >dave.hansen@linux.intel.com; naoya.horiguchi@nec.com;
>> >james.morse@arm.com; jthoughton@google.com;
>somasundaram.a@hpe.com;
>> >erdemaktas@google.com; pgonda@google.com; duenwen@google.com;
>> >mike.malvestuto@intel.com; gthelen@google.com;
>> >wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
>> >wbs@os.amperecomputing.com; nifan.cxl@gmail.com; jgroves@micron.com;
>> >vsalve@micron.com; tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
>> ><prime.zeng@hisilicon.com>; Roberto Sassu <roberto.sassu@huawei.com>;
>> >kangkang.shen@futurewei.com; wanghuiqiang
><wanghuiqiang@huawei.com>;
>> >Linuxarm <linuxarm@huawei.com>
>> >Subject: Re: [PATCH v12 01/17] EDAC: Add support for EDAC device
>> >features control
>> >
>> >On Wed, Sep 11, 2024 at 10:04:30AM +0100, shiju.jose@huawei.com wrote:
>> >> +/**
>> >> + * edac_dev_feature_init - Init a RAS feature
>> >> + * @parent: client device.
>> >> + * @dev_data: pointer to the edac_dev_data structure, which
>> >> +contains
>> >> + * client device specific info.
>> >> + * @feat: pointer to struct edac_dev_feature.
>> >> + * @attr_groups: pointer to attribute group's container.
>> >> + *
>> >> + * Returns number of scrub features attribute groups on success,
>> >
>> >Not "scrub" - this is an interface initializing a generic feature.
>> Will correct.
>> >
>> >> + * error otherwise.
>> >> + */
>> >> +static int edac_dev_feat_init(struct device *parent,
>> >> +			      struct edac_dev_data *dev_data,
>> >> +			      const struct edac_dev_feature *ras_feat,
>> >> +			      const struct attribute_group **attr_groups) {
>> >> +	int num;
>> >> +
>> >> +	switch (ras_feat->ft_type) {
>> >> +	case RAS_FEAT_SCRUB:
>> >> +		dev_data->scrub_ops =3D ras_feat->scrub_ops;
>> >> +		dev_data->private =3D ras_feat->ctx;
>> >> +		return 1;
>> >> +	case RAS_FEAT_ECS:
>> >> +		num =3D ras_feat->ecs_info.num_media_frus;
>> >> +		dev_data->ecs_ops =3D ras_feat->ecs_ops;
>> >> +		dev_data->private =3D ras_feat->ctx;
>> >> +		return num;
>> >> +	case RAS_FEAT_PPR:
>> >> +		dev_data->ppr_ops =3D ras_feat->ppr_ops;
>> >> +		dev_data->private =3D ras_feat->ctx;
>> >> +		return 1;
>> >> +	default:
>> >> +		return -EINVAL;
>> >> +	}
>> >> +}
>> >
>> >And why does this function even exist and has kernel-doc comments
>> >when all it does is assign a couple of values? And it gets called exact=
ly once?
>> >
>> >Just merge its body into the call site. There you can reuse the
>> >switch-case there too. No need for too much noodling around.
>> edac_dev_feat_init () function is updated with feature specific function=
 call()
>etc in subsequent
>> EDAC feature specific patches. Thus added a separate function.
>> >
>> >> diff --git a/include/linux/edac.h b/include/linux/edac.h index
>> >> b4ee8961e623..b337254cf5b8 100644
>> >> --- a/include/linux/edac.h
>> >> +++ b/include/linux/edac.h
>> >> @@ -661,4 +661,59 @@ static inline struct dimm_info
>> >> *edac_get_dimm(struct mem_ctl_info *mci,
>> >>
>> >>  	return mci->dimms[index];
>> >>  }
>> >> +
>> >> +/* EDAC device features */
>> >> +
>> >> +#define EDAC_FEAT_NAME_LEN	128
>> >> +
>> >> +/* RAS feature type */
>> >> +enum edac_dev_feat {
>> >> +	RAS_FEAT_SCRUB,
>> >> +	RAS_FEAT_ECS,
>> >> +	RAS_FEAT_PPR,
>> >> +	RAS_FEAT_MAX
>> >
>> >I still don't know what ECS or PPR is.
>> I will add comment/documentation here with a short explanation of
>> features if that make sense?
>> Each feature is described in the subsequent EDAC feature specific patche=
s.
>Can you bring the enum entries in with those patches?
>That way there is no reference to them before we have the information on w=
hat
>they are.
Will do.
>
>J
>> >
>> >--
>> >Regards/Gruss,
>> >    Boris.
>> >
>> >https://people.kernel.org/tglx/notes-about-netiquette
>>
Thanks,
Shiju




