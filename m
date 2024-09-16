Return-Path: <linux-edac+bounces-1880-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB053979FBE
	for <lists+linux-edac@lfdr.de>; Mon, 16 Sep 2024 12:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34271B20AA8
	for <lists+linux-edac@lfdr.de>; Mon, 16 Sep 2024 10:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF941509A5;
	Mon, 16 Sep 2024 10:50:24 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DAE153BF6;
	Mon, 16 Sep 2024 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726483824; cv=none; b=n9WCcyqtdMj8MT8j9j7tap0k/vxUeSBDqTPl5kl2916eRXZaBdValT3gBrAx6D29Jav/wovZ4Nj8FHHxJfCvapZh/oNJBuGob0Y1cF9fdXQ5OZ1Lyh25PPVv0ah9nBT+rPoMGW+sOZmoKRnQgRlKguZ4vKl0IHgVV62Y6fmL3+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726483824; c=relaxed/simple;
	bh=c4YWO/0EFiYQanN9XvQuPPIasnvzcVAiaTGY/zs6NBI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDAAzgCSxOkpp87/0eo0wD+P1TMnZ6Kxd+aujCx6xXBjgreTjjoSEWTahhJUwmTLKDbOv2yHjALjkoslBvnXo757LOW4dAHo2YaD7uggLqRhkryBZuGFcFmdzfOXlwBRWqJwQRMg55htAOQgHT5vwTDZSNgA+BCkRkZ/wQYo0As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6hWp1XDXz6K5xQ;
	Mon, 16 Sep 2024 18:50:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 06083140F5E;
	Mon, 16 Sep 2024 18:50:18 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Sep
 2024 12:50:16 +0200
Date: Mon, 16 Sep 2024 11:50:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shiju Jose <shiju.jose@huawei.com>
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
Subject: Re: [PATCH v12 01/17] EDAC: Add support for EDAC device features
 control
Message-ID: <20240916115014.000064bf@Huawei.com>
In-Reply-To: <c31c733bb6e742f580721ec9d0e2f3b2@huawei.com>
References: <20240911090447.751-1-shiju.jose@huawei.com>
	<20240911090447.751-2-shiju.jose@huawei.com>
	<20240913164041.GKZuRrCeoFZBapVYaU@fat_crate.local>
	<c31c733bb6e742f580721ec9d0e2f3b2@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 16 Sep 2024 10:21:58 +0100
Shiju Jose <shiju.jose@huawei.com> wrote:

> Thanks for reviewing.
> 
> >-----Original Message-----
> >From: Borislav Petkov <bp@alien8.de>
> >Sent: 13 September 2024 17:41
> >To: Shiju Jose <shiju.jose@huawei.com>
> >Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org; linux-
> >acpi@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org;
> >tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
> >mchehab@kernel.org; dan.j.williams@intel.com; dave@stgolabs.net; Jonathan
> >Cameron <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
> >alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
> >david@redhat.com; Vilas.Sridharan@amd.com; leo.duran@amd.com;
> >Yazen.Ghannam@amd.com; rientjes@google.com; jiaqiyan@google.com;
> >Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
> >naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
> >somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
> >duenwen@google.com; mike.malvestuto@intel.com; gthelen@google.com;
> >wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
> >wbs@os.amperecomputing.com; nifan.cxl@gmail.com; jgroves@micron.com;
> >vsalve@micron.com; tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
> ><prime.zeng@hisilicon.com>; Roberto Sassu <roberto.sassu@huawei.com>;
> >kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
> >Linuxarm <linuxarm@huawei.com>
> >Subject: Re: [PATCH v12 01/17] EDAC: Add support for EDAC device features
> >control
> >
> >On Wed, Sep 11, 2024 at 10:04:30AM +0100, shiju.jose@huawei.com wrote:  
> >> +/**
> >> + * edac_dev_feature_init - Init a RAS feature
> >> + * @parent: client device.
> >> + * @dev_data: pointer to the edac_dev_data structure, which contains
> >> + * client device specific info.
> >> + * @feat: pointer to struct edac_dev_feature.
> >> + * @attr_groups: pointer to attribute group's container.
> >> + *
> >> + * Returns number of scrub features attribute groups on success,  
> >
> >Not "scrub" - this is an interface initializing a generic feature.  
> Will correct.
> >  
> >> + * error otherwise.
> >> + */
> >> +static int edac_dev_feat_init(struct device *parent,
> >> +			      struct edac_dev_data *dev_data,
> >> +			      const struct edac_dev_feature *ras_feat,
> >> +			      const struct attribute_group **attr_groups) {
> >> +	int num;
> >> +
> >> +	switch (ras_feat->ft_type) {
> >> +	case RAS_FEAT_SCRUB:
> >> +		dev_data->scrub_ops = ras_feat->scrub_ops;
> >> +		dev_data->private = ras_feat->ctx;
> >> +		return 1;
> >> +	case RAS_FEAT_ECS:
> >> +		num = ras_feat->ecs_info.num_media_frus;
> >> +		dev_data->ecs_ops = ras_feat->ecs_ops;
> >> +		dev_data->private = ras_feat->ctx;
> >> +		return num;
> >> +	case RAS_FEAT_PPR:
> >> +		dev_data->ppr_ops = ras_feat->ppr_ops;
> >> +		dev_data->private = ras_feat->ctx;
> >> +		return 1;
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +}  
> >
> >And why does this function even exist and has kernel-doc comments when all it
> >does is assign a couple of values? And it gets called exactly once?
> >
> >Just merge its body into the call site. There you can reuse the switch-case there
> >too. No need for too much noodling around.  
> edac_dev_feat_init () function is updated with feature specific function call() etc in subsequent
> EDAC feature specific patches. Thus added a separate function.   
> >  
> >> diff --git a/include/linux/edac.h b/include/linux/edac.h index
> >> b4ee8961e623..b337254cf5b8 100644
> >> --- a/include/linux/edac.h
> >> +++ b/include/linux/edac.h
> >> @@ -661,4 +661,59 @@ static inline struct dimm_info
> >> *edac_get_dimm(struct mem_ctl_info *mci,
> >>
> >>  	return mci->dimms[index];
> >>  }
> >> +
> >> +/* EDAC device features */
> >> +
> >> +#define EDAC_FEAT_NAME_LEN	128
> >> +
> >> +/* RAS feature type */
> >> +enum edac_dev_feat {
> >> +	RAS_FEAT_SCRUB,
> >> +	RAS_FEAT_ECS,
> >> +	RAS_FEAT_PPR,
> >> +	RAS_FEAT_MAX  
> >
> >I still don't know what ECS or PPR is.  
> I will add comment/documentation here with a short explanation of features
> if that make sense?
> Each feature is described in the subsequent EDAC feature specific patches. 
Can you bring the enum entries in with those patches?
That way there is no reference to them before we have the information
on what they are.

J
> >
> >--
> >Regards/Gruss,
> >    Boris.
> >
> >https://people.kernel.org/tglx/notes-about-netiquette  
> 
> Thanks,
> Shiju
> 


