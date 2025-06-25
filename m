Return-Path: <linux-edac+bounces-4241-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC27AE822D
	for <lists+linux-edac@lfdr.de>; Wed, 25 Jun 2025 13:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB0B3ACD2F
	for <lists+linux-edac@lfdr.de>; Wed, 25 Jun 2025 11:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ED3260574;
	Wed, 25 Jun 2025 11:54:17 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C4825DAE3;
	Wed, 25 Jun 2025 11:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852457; cv=none; b=shiWG3CRSth514ZAvE5nGzDjbhXHKpQk0LANyFBTZVyD5j4LNcqtRxMpK9uswfiUYSfK8Iib4mFyqn+9XT1nqsJyyzDYergg1PY7LfLBLxSKdYdWPoKUo5FUn5OvoQb3Qv9KOsVhHWo2nCvjuZZCZJaMfO9cFIn8WYHEr2kbA8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852457; c=relaxed/simple;
	bh=lyL28FtOIZficmUvWLLFRpGI8z+IRT+sgDDnewF6vd4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S/sujVQGTJ0Emmd4G74Qd/y4g+q3RyBRua1BkqTpfCl0kI3If7gk+xARIR19CbLjwCzEbVvw8qm/NdIFCtkzlMMRqAzPEmVioFgRV0cut64covKhvRrrnUTKwdY2ptZaoXKn/4JVaJy5tw3JAtLlNe0e8nQSIQbAgw86c5Lfzso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bS0XW6Z3Gz6GDFj;
	Wed, 25 Jun 2025 19:51:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BE971400D9;
	Wed, 25 Jun 2025 19:54:12 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Jun 2025 13:54:12 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 25 Jun 2025 13:54:12 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"lenb@kernel.org" <lenb@kernel.org>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Linuxarm
	<linuxarm@huawei.com>, tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)"
	<prime.zeng@hisilicon.com>
Subject: RE: [PATCH 1/1] EDAC: Fix lockdep splat caused by edac features code
Thread-Topic: [PATCH 1/1] EDAC: Fix lockdep splat caused by edac features code
Thread-Index: AQHb5TOu2Pri1G3iPUmFljj1HAfIlbQTj4QAgAA1OzA=
Date: Wed, 25 Jun 2025 11:54:12 +0000
Message-ID: <aa142386d0944955b742340b2454e114@huawei.com>
References: <20250624181312.1712-1-shiju.jose@huawei.com>
 <20250625114136.0000021a@huawei.com>
In-Reply-To: <20250625114136.0000021a@huawei.com>
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
>Sent: 25 June 2025 11:42
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-edac@vger.kernel.org; bp@alien8.de; tony.luck@intel.com;
>lenb@kernel.org; leo.duran@amd.com; Yazen.Ghannam@amd.com;
>mchehab@kernel.org; dave.jiang@intel.com; linux-cxl@vger.kernel.org;
>Linuxarm <linuxarm@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>Zengtao (B) <prime.zeng@hisilicon.com>
>Subject: Re: [PATCH 1/1] EDAC: Fix lockdep splat caused by edac features c=
ode
>
>On Tue, 24 Jun 2025 19:13:12 +0100
><shiju.jose@huawei.com> wrote:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Fix the lockdep splat caused by missing sysfs_attr_init() calls for
>> the newely added EDAC feature's sysfs attributes.
>newly though recently is probably better.
>>
>> ...
>> [   16.867268] CPU: 4 UID: 0 PID: 131 Comm: kworker/u33:4 Tainted: G
>O        6.16.0-rc3+
>> [   16.867272] Tainted: [O]=3DOOT_MODULE
>> [   16.867273] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>edk2-20241117-5.fc41 11/17/2
>> 024
>> [   16.867275] Workqueue: async async_run_entry_fn
>> [   16.867282] RIP: 0010:lockdep_init_map_type+0x131/0x270
>> [   16.867287] Code: 85 c0 75 b4 e8 50 d6 6f 00 85 c0 74 ab 8b 3d 26 0d =
bd 01
>85 ff 75 a1 48 c7 c6 c
>> f 52 ac 82 48 c7 c7 2a 12 aa 82 e8 6f 59 f6 ff <0f> 0b eb 8a 9c 58 0f
>> 1f 40 00 48 89 c5 fa 0f 1f 44
>> 00 00 48 c7 c7
>> [   16.867289] RSP: 0018:ffffc900020875d8 EFLAGS: 00010292
>> [   16.867291] RAX: 0000000000000016 RBX: ffff888212716a58 RCX:
>0000000000000000
>> [   16.867292] RDX: 0000000000000002 RSI: ffffffff82ab189f RDI:
>00000000ffffffff
>> [   16.867293] RBP: ffff888201a5e8c0 R08: 0000000000000000 R09:
>0000000000000000
>> [   16.867294] R10: 0000000000000000 R11: 65726f635f6c7863 R12:
>0000000000000000
>> [   16.867295] R13: ffff888201a5e8c0 R14: ffff8882052bc630 R15:
>ffff888201a5e9a8
>> [   16.867296] FS:  0000000000000000(0000) GS:ffff8882f11e5000(0000)
>knlGS:0000000000000000
>> [   16.867298] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   16.867299] CR2: 00007f20a16c6030 CR3: 0000000003c4c005 CR4:
>0000000000770ef0
>> [   16.867304] PKRU: 55555554
>> [   16.867305] Call Trace:
>> [   16.867308]  <TASK>
>> [   16.867313]  __kernfs_create_file+0x77/0xf0
>> [   16.887524]  sysfs_add_file_mode_ns+0x86/0x140
>> [   16.887534]  internal_create_group+0x1cc/0x4b0
>> [   16.887540]  internal_create_groups+0x42/0xa0
>> [   16.887544]  device_add+0x310/0x860
>> [   16.887548]  ? __init_waitqueue_head+0x4a/0x60
>> [   16.887555]  edac_dev_register+0x3ff/0x480
>> [   16.887565]  devm_cxl_memdev_edac_register+0x509/0x640 [cxl_core]
>> [   16.893091]  ? lock_acquire+0xc4/0x2d0
>> [   16.893100]  ? find_held_lock+0x2b/0x80
>> [   16.893103]  ? cxl_mem_probe+0x21e/0x360 [cxl_mem]
>> [   16.893113]  ? cxl_mem_probe+0x21e/0x360 [cxl_mem]
>> [   16.893117]  ? lockdep_hardirqs_on+0x78/0x100
>> [   16.896972]  ? cxl_mem_probe+0x226/0x360 [cxl_mem]
>> [   16.896982]  cxl_mem_probe+0x226/0x360 [cxl_mem]
>
Hi Jonathan,

Thanks for the feedback.

>Prune this to drop timestamps etc and keep only the relevant info.
>https://docs.kernel.org/process/submitting-patches.html#backtraces-in-comm=
it-
>messages
Sure.

>
>Also, call out the code that actually causes the splat which from our earl=
ier
>discussion is I think:
> if (!static_obj(key) && !is_dynamic_key(key)) check in lockdev_init_map_t=
ype?
>https://elixir.bootlin.com/linux/v6.15.3/source/kernel/locking/lockdep.c#L=
4977
Will do.

>
>> ...
>>
>> Fixes: f90b738166fe ("EDAC: Add scrub control feature")
>> Fixes: bcbd069b11b0 ("EDAC: Add a Error Check Scrub control feature")
>> Fixes: 699ea5219c4b ("EDAC: Add a memory repair control feature")
>> Reported-by: Dave Jiang <dave.jiang@intel.com>
>> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  drivers/edac/ecs.c        | 4 +++-
>>  drivers/edac/mem_repair.c | 1 +
>>  drivers/edac/scrub.c      | 1 +
>>  3 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/edac/ecs.c b/drivers/edac/ecs.c index
>> 1d51838a60c1..1be237d15bed 100755
>> --- a/drivers/edac/ecs.c
>> +++ b/drivers/edac/ecs.c
>> @@ -170,8 +170,10 @@ static int ecs_create_desc(struct device *ecs_dev,
>const struct attribute_group
>>  		fru_ctx->dev_attr[ECS_RESET]		=3D
>EDAC_ECS_ATTR_WO(reset, fru);
>>  		fru_ctx->dev_attr[ECS_THRESHOLD]	=3D
>EDAC_ECS_ATTR_RW(threshold, fru);
>>
>> -		for (i =3D 0; i < ECS_MAX_ATTRS; i++)
>> +		for (i =3D 0; i < ECS_MAX_ATTRS; i++) {
>>  			fru_ctx->ecs_attrs[i] =3D &fru_ctx-
>>dev_attr[i].dev_attr.attr;
>> +			sysfs_attr_init(fru_ctx->ecs_attrs[i]);
>It feels to me like maybe this should be applied before we put the pointer=
 in the
>array of attribute pointers.  So one line earlier (without the convenience=
 of that
>shorter form). Perhaps a local variable?
>
>			struct attribute *attr =3D &fru_ctx-
>>dev_attr[i].dev_attr.attr;
>
>			sysfs_attr_init(attr);
>			fru_ctx->ecs_attrs[i] =3D attr;
>
Will change.

>I don't care that much though.
>
>> +		}
>>
>>  		sprintf(fru_ctx->name, "%s%d", EDAC_ECS_FRU_NAME, fru);
>>  		group->name =3D fru_ctx->name;
>> diff --git a/drivers/edac/mem_repair.c b/drivers/edac/mem_repair.c
>> index d1a8caa85369..c7951bc5efdb 100755
>> --- a/drivers/edac/mem_repair.c
>> +++ b/drivers/edac/mem_repair.c
>> @@ -335,6 +335,7 @@ static int mem_repair_create_desc(struct device *dev=
,
>>  		       &dev_attr[i], sizeof(dev_attr[i]));
>>  		ctx->mem_repair_attrs[i] =3D
>>  			&ctx->mem_repair_dev_attr[i].dev_attr.attr;
>> +		sysfs_attr_init(ctx->mem_repair_attrs[i]);
>>  	}
>>
>>  	sprintf(ctx->name, "%s%d", "mem_repair", instance); diff --git
>> a/drivers/edac/scrub.c b/drivers/edac/scrub.c index
>> e421d3ebd959..8831b44e9193 100755
>> --- a/drivers/edac/scrub.c
>> +++ b/drivers/edac/scrub.c
>> @@ -177,6 +177,7 @@ static int scrub_create_desc(struct device *scrub_de=
v,
>>  	for (i =3D 0; i < SCRUB_MAX_ATTRS; i++) {
>>  		memcpy(&scrub_ctx->scrub_dev_attr[i], &dev_attr[i],
>sizeof(dev_attr[i]));
>>  		scrub_ctx->scrub_attrs[i] =3D
>> &scrub_ctx->scrub_dev_attr[i].dev_attr.attr;
>> +		sysfs_attr_init(scrub_ctx->scrub_attrs[i]);
>>  	}
>>  	sprintf(scrub_ctx->name, "%s%d", "scrub", instance);
>>  	group->name =3D scrub_ctx->name;

Thanks,
Shiju

