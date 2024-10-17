Return-Path: <linux-edac+bounces-2121-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB019A1D57
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 10:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4021C218E2
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 08:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135651D416E;
	Thu, 17 Oct 2024 08:37:59 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5C51D097C;
	Thu, 17 Oct 2024 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729154279; cv=none; b=TzRw/6AIa2rWpQT0krVzds8dytKB9yM5QYm5zP9Y5WXJpW7llwOm8dYbGrNPkK7eNUAbfBtKMimXnfvMHmN1IaT5Ewps4bvjmGvmpcT7IJc6W3Zrlz0As8Hok3tfuo9AmTRL6DU+rERf8jHswEOrhplbNydTkTjmSDWUQa7Rd8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729154279; c=relaxed/simple;
	bh=V1Nxm3PFFy1wfn7H+Vz/8ZFWFV7bYvzpYltoz5NJiGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jxySWyerGjrmDSf7gfmpA1oSgAvFmrGnAPhgu0cdRXBoGhLMEPPrVAtxlH6w+2MLlZ/ooDD+OY4YDxo9YlWHGQBiKWq8EFYlQZUbMW/Kvnf0E+NZ66gY6FF9EACfRKsZjCw+I/ifAG7UhNFh+r107gc7DkrtYfPb7cuj3j39KDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTh605KJKz6K9C4;
	Thu, 17 Oct 2024 16:37:12 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 7DB13140119;
	Thu, 17 Oct 2024 16:37:52 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 10:37:52 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 17 Oct 2024 10:37:51 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
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
Thread-Index: AQHbGkjIT8EMR4nHhkSztyssI50yp7KJHpUAgABGrZA=
Date: Thu, 17 Oct 2024 08:37:51 +0000
Message-ID: <b59606d95d384e43900587b25dec1a4e@huawei.com>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
 <20241009124120.1124-2-shiju.jose@huawei.com>
 <20241016105832.GSZw-cWDOFweQMWRgZ@fat_crate.local>
In-Reply-To: <20241016105832.GSZw-cWDOFweQMWRgZ@fat_crate.local>
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

Hi Boris,

Thanks for the comments.

>-----Original Message-----
>From: Borislav Petkov <bp@alien8.de>
>Sent: 16 October 2024 11:59
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org; linux-
>acpi@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org;
>tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
>mchehab@kernel.org; dan.j.williams@intel.com; dave@stgolabs.net; Jonathan
>Cameron <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>david@redhat.com; Vilas.Sridharan@amd.com; leo.duran@amd.com;
>Yazen.Ghannam@amd.com; rientjes@google.com; jiaqiyan@google.com;
>Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
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
>On Wed, Oct 09, 2024 at 01:41:02PM +0100, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add generic EDAC device features control supports registering RAS
>> features supported in the system. Driver exposes features control
>> attributes to userspace in
>> /sys/bus/edac/devices/<dev-name>/<ras-feature>/
>
>Chatgpt prompt:
>
>| Please check the grammar in this English text: "Add generic EDAC
>| device features control supports registering RAS features supported in t=
he
>system.
>| Driver exposes features control attributes to userspace in
>| /sys/bus/edac/devices/<dev-name>/<ras-"feature>/
>
>Response:
>
>| Here's a corrected version of the text:
>|
>| "Add generic EDAC device feature control support for registering RAS
>| features supported in the system. The driver exposes feature control
>| attributes to userspace in /sys/bus/edac/devices/<dev-name>/<ras-feature=
>/."
>|
>| Changes made:
>|
>| * "features control" was changed to "feature control" for consistency
>| and clarity.
>|
>| * "supports registering" was changed to "support for registering" to
>| match the structure of the sentence.
>|
>| * Added "The" at the beginning of the second sentence for better flow.
>|
>| * Corrected the syntax around the file path to ensure clarity and
>| proper
>| * punctuation.
>
>Please run all your commit text through some LLM AI as they're apparently =
good
>enough now to help me in correcting grammar.
Will do.
>
>> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
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
>> @@ -570,3 +570,108 @@ void edac_device_handle_ue_count(struct
>edac_device_ctl_info *edac_dev,
>>  		      block ? block->name : "N/A", count, msg);  }
>> EXPORT_SYMBOL_GPL(edac_device_handle_ue_count);
>> +
>> +/* EDAC device feature */
>> +static void edac_dev_release(struct device *dev) {
>> +	struct edac_dev_feat_ctx *ctx =3D container_of(dev, struct
>> +edac_dev_feat_ctx, dev);
>> +
>> +	kfree(ctx->dev.groups);
>> +	kfree(ctx);
>> +}
>> +
>> +const struct device_type edac_dev_type =3D {
>> +	.name =3D "edac_dev",
>> +	.release =3D edac_dev_release,
>> +};
>> +
>> +static void edac_dev_unreg(void *data) {
>> +	device_unregister(data);
>> +}
>> +
>> +/**
>> + * edac_dev_register - register device for RAS features with EDAC
>> + * @parent: client device.
>
>If this is a client device, why is the variable called "parent" and not "c=
lient"?
>
>I.e.,
>
>	struct device *client;
>
>For clarity and simplicity.
>
>Or call it "parent" because you do:
>
>	ctx->dev.parent =3D parent;
>
>and forget "client" altogether.
Changed to "parent".=20
>
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
>
>Why is this important to call out here?
>
>It is a common coding pattern of freeing resources in the release function=
...
Deleted.
>
>> + */
>> +int edac_dev_register(struct device *parent, char *name,
>> +		      void *private, int num_features,
>> +		      const struct edac_dev_feature *ras_features) {
>> +	const struct attribute_group **ras_attr_groups;
>> +	struct edac_dev_feat_ctx *ctx;
>> +	int attr_gcnt =3D 0;
>> +	int ret, feat;
>> +
>> +	if (!parent || !name || !num_features || !ras_features)
>> +		return -EINVAL;
>> +
>> +	/* Double parse to make space for attributes */
>> +	for (feat =3D 0; feat < num_features; feat++) {
>> +		switch (ras_features[feat].ft_type) {
>> +		/* Add feature specific code */
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
>> +	if (!ctx)
>> +		return -ENOMEM;
>> +
>> +	ctx->dev.parent =3D parent;
>> +	ctx->private =3D private;
>> +
>> +	ras_attr_groups =3D kcalloc(attr_gcnt + 1, sizeof(*ras_attr_groups),
>GFP_KERNEL);
>> +	if (!ras_attr_groups) {
>> +		ret =3D -ENOMEM;
>> +		goto ctx_free;
>> +	}
>> +
>> +	attr_gcnt =3D 0;
>> +	for (feat =3D 0; feat < num_features; feat++, ras_features++) {
>> +		switch (ras_features->ft_type) {
>> +		/* Add feature specific code */
>> +		default:
>> +			ret =3D -EINVAL;
>> +			goto groups_free;
>> +		}
>> +	}
>> +
>> +	ras_attr_groups[attr_gcnt] =3D NULL;
>> +	ctx->dev.bus =3D edac_get_sysfs_subsys();
>> +	ctx->dev.type =3D &edac_dev_type;
>> +	ctx->dev.groups =3D ras_attr_groups;
>> +	dev_set_drvdata(&ctx->dev, ctx);
>> +
>> +	ret =3D dev_set_name(&ctx->dev, name);
>> +	if (ret)
>> +		goto groups_free;
>> +
>> +	ret =3D device_register(&ctx->dev);
>> +	if (ret) {
>> +		put_device(&ctx->dev);
>> +		goto groups_free;
>> +		return ret;
>		^^^^^^^^^^
>
>Come again?!
>
>There's code after a "goto"?
Fixed.
>
>--
>Regards/Gruss,
>    Boris.
>
>https://people.kernel.org/tglx/notes-about-netiquette

Thanks,
Shiju

