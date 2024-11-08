Return-Path: <linux-edac+bounces-2474-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 371DA9C1E59
	for <lists+linux-edac@lfdr.de>; Fri,  8 Nov 2024 14:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E283F283258
	for <lists+linux-edac@lfdr.de>; Fri,  8 Nov 2024 13:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB021F131F;
	Fri,  8 Nov 2024 13:47:21 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045DF1F4700;
	Fri,  8 Nov 2024 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073641; cv=none; b=bLDXc8jzXlcRy3OSNQUZ/OYmnLLvd7JAWfMvq5P4UUvv3QxMzsHsoKxiMAajk6gLf2pZWKrnyC5LOcrdxZUMnxTrL+RrGVTx1OS7CBXjClCq6vN3Q2Hwze1PrdIYetyA3psC01aHkFUQuB3Nuv549YJLrKJ/Cm2Y4ueEqMBamtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073641; c=relaxed/simple;
	bh=8knQ7wE4fQq4x8sY3mGFsnXaStycaIQDHgUGvkXqYZk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NZpOeuoVsRIC7ZVA9h6gw4fvimFE6lNxdFfW9ZnCZPuG2rDj2XBTh9CmuoGHeHnZr/5S9uiHl367s3SxPjoMceU9oN5vhfZ1dwXlx0I4x/BLqPlKCipNxhCnOI5x+sdOoZWiNLeAVGePCEYeEpdT5oDLg1OjimZSrfrqQTmSasw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XlKvd3Mp6z6K95G;
	Fri,  8 Nov 2024 21:45:33 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 96EED140133;
	Fri,  8 Nov 2024 21:47:16 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Nov 2024 14:47:16 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 8 Nov 2024 14:47:16 +0100
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
	"Jonathan Cameron" <jonathan.cameron@huawei.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>, "leo.duran@amd.com"
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
	<wbs@os.amperecomputing.com>, tanxiaofei <tanxiaofei@huawei.com>, "Zengtao
 (B)" <prime.zeng@hisilicon.com>, "Roberto Sassu" <roberto.sassu@huawei.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, wanghuiqiang
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v15 02/15] EDAC: Add scrub control feature
Thread-Topic: [PATCH v15 02/15] EDAC: Add scrub control feature
Thread-Index: AQHbLD7vCzL+HgVM6Umrx0HY63Gx9LKsgzCAgADs7ZA=
Date: Fri, 8 Nov 2024 13:47:16 +0000
Message-ID: <f6b1be9f02b94bc6a05ba4494e5b973b@huawei.com>
References: <20241101091735.1465-1-shiju.jose@huawei.com>
	<20241101091735.1465-3-shiju.jose@huawei.com> <Zy1dAazN9OPR0POI@fan>
In-Reply-To: <Zy1dAazN9OPR0POI@fan>
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
>Sent: 08 November 2024 00:36
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org; linux-
>acpi@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org;
>bp@alien8.de; tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
>mchehab@kernel.org; dan.j.williams@intel.com; dave@stgolabs.net; Jonathan
>Cameron <jonathan.cameron@huawei.com>; gregkh@linuxfoundation.org;
>sudeep.holla@arm.com; jassisinghbrar@gmail.com; dave.jiang@intel.com;
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
>Subject: Re: [PATCH v15 02/15] EDAC: Add scrub control feature
>
>On Fri, Nov 01, 2024 at 09:17:20AM +0000, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add a generic EDAC scrub control to manage memory scrubbers in the syste=
m.
>> Devices with a scrub feature register with the EDAC device driver,
>> which retrieves the scrub descriptor from the EDAC scrub driver and
>> exposes the sysfs scrub control attributes for a scrub instance to
>> userspace at /sys/bus/edac/devices/<dev-name>/scrubX/.
>>
>> The common sysfs scrub control interface abstracts the control of
>> arbitrary scrubbing functionality into a common set of functions. The
>> sysfs scrub attribute nodes are only present if the client driver has
>> implemented the corresponding attribute callback function and passed
>> the
>> operations(ops) to the EDAC device driver during registration.
>>
>> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>
>Minor comments inline.
>
>>  Documentation/ABI/testing/sysfs-edac-scrub |  74 ++++++++
>>  drivers/edac/Makefile                      |   1 +
>>  drivers/edac/edac_device.c                 |  40 +++-
>>  drivers/edac/scrub.c                       | 209 +++++++++++++++++++++
>>  include/linux/edac.h                       |  34 ++++
>>  5 files changed, 354 insertions(+), 4 deletions(-)  create mode
>> 100644 Documentation/ABI/testing/sysfs-edac-scrub
>>  create mode 100755 drivers/edac/scrub.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-edac-scrub
>> b/Documentation/ABI/testing/sysfs-edac-scrub
>> new file mode 100644
>> index 000000000000..d8d11165ff2a
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-edac-scrub
>
>...
>
>> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
>> index e9229b5f8afe..cd700a64406e 100644
>> --- a/drivers/edac/edac_device.c
>> +++ b/drivers/edac/edac_device.c
>> @@ -576,6 +576,7 @@ static void edac_dev_release(struct device *dev)
>> {
>>  	struct edac_dev_feat_ctx *ctx =3D container_of(dev, struct
>> edac_dev_feat_ctx, dev);
>>
>> +	kfree(ctx->scrub);
>>  	kfree(ctx->dev.groups);
>>  	kfree(ctx);
>>  }
>> @@ -609,6 +610,8 @@ int edac_dev_register(struct device *parent, char
>*name,
>>  		      const struct edac_dev_feature *ras_features)  {
>>  	const struct attribute_group **ras_attr_groups;
>> +	int scrub_cnt =3D 0, scrub_inst =3D 0;
>> +	struct edac_dev_data *dev_data;
>>  	struct edac_dev_feat_ctx *ctx;
>>  	int attr_gcnt =3D 0;
>>  	int ret, feat;
>> @@ -619,7 +622,10 @@ int edac_dev_register(struct device *parent, char
>*name,
>>  	/* Double parse to make space for attributes */
>>  	for (feat =3D 0; feat < num_features; feat++) {
>>  		switch (ras_features[feat].ft_type) {
>> -		/* Add feature specific code */
>> +		case RAS_FEAT_SCRUB:
>> +			attr_gcnt++;
>> +			scrub_cnt++;
>> +			break;
>>  		default:
>>  			return -EINVAL;
>>  		}
>> @@ -635,13 +641,37 @@ int edac_dev_register(struct device *parent, char
>*name,
>>  		goto ctx_free;
>>  	}
>>
>> +	if (scrub_cnt) {
>> +		ctx->scrub =3D kcalloc(scrub_cnt, sizeof(*ctx->scrub),
>GFP_KERNEL);
>> +		if (!ctx->scrub) {
>> +			ret =3D -ENOMEM;
>> +			goto groups_free;
>> +		}
>> +	}
>> +
>>  	attr_gcnt =3D 0;
>
>If we use scrub_cnt the same way as we use attr_gcnt, we do not need
>scrub_inst.

Hi Fan,
Thanks for suggestion. Modified and done the same for EDAC memory repair fe=
ature as well.=20
>
>Fan
>>  	for (feat =3D 0; feat < num_features; feat++, ras_features++) {
>>  		switch (ras_features->ft_type) {
>> -		/* Add feature specific code */
[...]
>--
>Fan Ni
>
Thanks,
Shiju

