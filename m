Return-Path: <linux-edac+bounces-3967-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E0EABE83A
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 01:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345D91BA82AB
	for <lists+linux-edac@lfdr.de>; Tue, 20 May 2025 23:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1A825392C;
	Tue, 20 May 2025 23:45:18 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F151DE2BF;
	Tue, 20 May 2025 23:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747784718; cv=none; b=ox95dgR6Xe/THhd7gYJokm5QakP4f/XHg4v/zkQd2CqhnvvjVvz4DCH75X3jfZRQal6kF+IJq6oe2v83uBGz7Zbni1hR3WHFlw/YBhxLrO6pnodVzXIEiAJYNwrISf/d35U2Dh76KaNkSEN/5fRoE7KP6fk0azzsdivnUei/3mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747784718; c=relaxed/simple;
	bh=jl3rQ8yvljv9R1GJ2Pf212zCz8OEOuFMxnWHrwdeimA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mQUW7QvlVlqv7k27TgQ0HaMv86ZWiHefOdK4h8bz2FD6pbMgpy+tooVRo/ZE3RKiDutqvQcxWjuvMbi4T14iCEP2IBMd+9iv+Q3aWr8rAXxcwQmHHfPUmR1G2BYpLStqJI6wux02Fo0OC9tw7jVlHJSgiWk8Qzxl2bE5eMb3UlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b29yt2zvhz6M4xg;
	Wed, 21 May 2025 07:40:22 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
	by mail.maildlp.com (Postfix) with ESMTPS id F2A201402F7;
	Wed, 21 May 2025 07:45:12 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 May 2025 01:45:12 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 21 May 2025 01:45:12 +0200
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
Subject: RE: [PATCH v5 6/8] cxl/edac: Support for finding memory operation
 attributes from the current boot
Thread-Topic: [PATCH v5 6/8] cxl/edac: Support for finding memory operation
 attributes from the current boot
Thread-Index: AQHbxZDgFo0Ql6ZU2E6LyYo7gzjDYrPa01AAgAFiT8A=
Date: Tue, 20 May 2025 23:45:12 +0000
Message-ID: <879667a6c73a475ab8ef06b0448258a3@huawei.com>
References: <20250515115927.772-1-shiju.jose@huawei.com>
 <20250515115927.772-7-shiju.jose@huawei.com>
 <aCwFhNeeX0YC41A3@aschofie-mobl2.lan>
In-Reply-To: <aCwFhNeeX0YC41A3@aschofie-mobl2.lan>
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
>Sent: 20 May 2025 05:31
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
>Subject: Re: [PATCH v5 6/8] cxl/edac: Support for finding memory operation
>attributes from the current boot
>
>On Thu, May 15, 2025 at 12:59:22PM +0100, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Certain operations on memory, such as memory repair, are permitted
>> only when the address and other attributes for the operation are from
>> the current boot. This is determined by checking whether the memory
>> attributes for the operation match those in the CXL gen_media or CXL
>> DRAM memory event records reported during the current boot.
>>
>> The CXL event records must be backed up because they are cleared in
>> the hardware after being processed by the kernel.
>>
>> Support is added for storing CXL gen_media or CXL DRAM memory event
>> records in xarrays. Old records are deleted when they expire or when
>> there is an overflow and which depends on platform correctly report
>> Event Record Timestamp field of CXL spec Table 8-55 Common Event
>> Record Format.
>>
>> Additionally, helper functions are implemented to find a matching
>> record in the xarray storage based on the memory attributes and repair
>> type.
>>
>> Add validity check, when matching attributes for sparing, using the
>> validity flag in the DRAM event record, to ensure that all required
>> attributes for a requested repair operation are valid and set.
>
>Using cxl-test I'm getting the below stack trace when trying to modprobe -=
r cxl-
>test.
>
>These cxl-test memdevs have num_ras_features =3D=3D 0 so upon adding the
>memdevs
>	edac_dev_register() returns -EINVAL,
>as does
>	devm_cxl_memdev_edac_register()
>
>Later on when I try to modprobe -r cxl-test, it seems odd that the
>devm_cxl_memdev_edac_release() is being called for this device, but it is,=
 and
>that where the kfree() oops happens.  Are those register and release funct=
ions
>intended to be paired/reciprocal ?
>
>Here's the code segment (from this patch) where it is failing, and the sta=
ck trace
>follows.
>
>> +
>> +void devm_cxl_memdev_edac_release(struct cxl_memdev *cxlmd) { #ifdef
>> +CONFIG_CXL_EDAC_MEM_REPAIR
>> +	struct cxl_mem_err_rec *array_rec =3D cxlmd->array_err_rec;
>> +	struct cxl_event_gen_media *rec_gen_media;
>> +	struct cxl_event_dram *rec_dram;
>> +	unsigned long index;
>> +
>> +	if (!array_rec)
>> +		return;
>> +
>> +	xa_for_each(&array_rec->rec_dram, index, rec_dram)
>> +		kfree(rec_dram);
>
>It fails above. That's as far as I've gotten. Hoping that you recognize so=
mething
>with this case where num_ras_features =3D=3D 0 that can lead to this.
>
>Here's the stack trace, and I'll hop to the point in the diff below where =
it's
>failing:

Thanks Alison for reporting and sharing the debug info.

I think following  changes should fix the issue. =20
Dave verified fix in his test setup. Thanks Dave.

Thanks,
Shiju
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c index 87b347=
c232b2..0f001f969228 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -1992,15 +1992,6 @@ int devm_cxl_memdev_edac_register(struct cxl_memdev =
*cxlmd)  #endif
=20
 #ifdef CONFIG_CXL_EDAC_MEM_REPAIR
-       struct cxl_mem_err_rec *array_rec =3D
-               devm_kzalloc(&cxlmd->dev, sizeof(*array_rec), GFP_KERNEL);
-       if (!array_rec)
-               return -ENOMEM;
-
-       cxlmd->array_err_rec =3D array_rec;
-       xa_init(&array_rec->rec_gen_media);
-       xa_init(&array_rec->rec_dram);
-
        for (int i =3D 0; i < CXL_MEM_SPARING_MAX; i++) {
                rc =3D cxl_memdev_sparing_init(cxlmd,
                                             &ras_features[num_ras_features=
], @@ -2023,6 +2014,16 @@ int devm_cxl_memdev_edac_register(struct cxl_memd=
ev *cxlmd)
                repair_inst++;
                num_ras_features++;
        }
+       if (repair_inst) {
+               struct cxl_mem_err_rec *array_rec =3D
+                       devm_kzalloc(&cxlmd->dev, sizeof(*array_rec), GFP_K=
ERNEL);
+               if (!array_rec)
+                       return -ENOMEM;
+
+               cxlmd->array_err_rec =3D array_rec;
+               xa_init(&array_rec->rec_gen_media);
+               xa_init(&array_rec->rec_dram);
+       }
 #endif
        char *cxl_dev_name __free(kfree) =3D
                kasprintf(GFP_KERNEL, "cxl_%s", dev_name(&cxlmd->dev));

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
>
>[  108.114491] cxl mem9: ALISON try_free_rec_dram [  108.115654] Oops:
>general protection fault, probably for non-canonical address
>0x1ad998badadad88: 0000 [#1] SMP NOPTI
>[  108.118125] CPU: 0 UID: 0 PID: 1187 Comm: modprobe Tainted: G          =
 O
>6.15.0-rc4+ #1 PREEMPT(voluntary)
>[  108.120507] Tainted: [O]=3DOOT_MODULE
>[  108.121202] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>0.0.0 02/06/2015 [  108.122466] RIP: 0010:kfree+0x6e/0x300 [  108.123099]
>Code: 80 48 01 d8 0f 82 98 02 00 00 48 c7 c2 00 00 00 80 48 2b 15 94 70 61=
 01
>48 01 d0 48 c1 e8 0c 48 c1 e0 06 48 03 05 72 70 61 01 <48> 8b 50 08 49 89 =
c5 f6
>c2 01 0f 85 4c 01 00 00 0f 1f 44 00 00 41 [  108.126050] RSP:
>0018:ffffc90002c03be0 EFLAGS: 00010203 [  108.126905] RAX:
>01ad998badadad80 RBX: 6b6b6b6b6b6b6b6b RCX: 0000000000000002 [
>108.128035] RDX: 0000777f80000000 RSI: ffffffff82a44991 RDI: ffffffff82a5a=
c86
>[  108.129194] RBP: ffffc90002c03c30 R08: 0000000000000000 R09:
>0000000000000000 [  108.130346] R10: 0000000000000001 R11:
>ffff888276ffe000 R12: ffff8880075a5000 [  108.131414] R13: ffff88800680a57=
8
>R14: 0000000000000000 R15: 000000000000000b [  108.132234] FS:
>00007fce1dd38740(0000) GS:ffff8880fa52b000(0000) knlGS:0000000000000000
>[  108.133256] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [
>108.133952] CR2: 00007ffce474e6e8 CR3: 0000000143296006 CR4:
>0000000000370ef0 [  108.134787] DR0: 0000000000000000 DR1:
>0000000000000000 DR2: 0000000000000000 [  108.135560] DR3:
>0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400 [
>108.136375] Call Trace:
>[  108.136694]  <TASK>
>[  108.136939]  devm_cxl_memdev_edac_release+0x6d/0x130 [cxl_core] [
>108.137611]  cxl_memdev_release+0x22/0x40 [cxl_core] [  108.138268]
>device_release+0x30/0x90 [  108.138720]  kobject_put+0x85/0x1c0 [
>108.139111]  put_device+0xe/0x20 [  108.139478]
>cxl_memdev_unregister+0x42/0x50 [cxl_core] [  108.140092]
>devm_action_release+0xd/0x20 [  108.140531]  devres_release_all+0xa5/0xe0 =
[
>108.141059]  device_unbind_cleanup+0xd/0x70 [  108.141416]
>device_release_driver_internal+0x1d3/0x220
>[  108.141890]  device_release_driver+0xd/0x20 [  108.142236]
>bus_remove_device+0xd7/0x140 [  108.142578]  device_del+0x15a/0x3a0 [
>108.142932]  platform_device_del.part.0+0x13/0x80
>[  108.143330]  platform_device_unregister+0x1b/0x40
>[  108.143786]  cxl_test_exit+0x1a/0xd80 [cxl_test] [  108.144171]
>__x64_sys_delete_module+0x17d/0x260
>[  108.144579]  ? debug_smp_processor_id+0x17/0x20 [  108.145004]
>x64_sys_call+0x19bd/0x1f90 [  108.145321]  do_syscall_64+0x64/0x140 [
>108.145628]  entry_SYSCALL_64_after_hwframe+0x71/0x79
>[  108.146284] RIP: 0033:0x7fce1d5128cb
>[  108.146775] Code: 73 01 c3 48 8b 0d 55 55 0e 00 f7 d8 64 89 01 48 83 c8=
 ff c3
>66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d =
01 f0 ff
>ff 73 01 c3 48 8b 0d 25 55 0e 00 f7 d8 64 89 01 48 [  108.148672] RSP:
>002b:00007ffce4752768 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0 [
>108.149490] RAX: ffffffffffffffda RBX: 0000556b12b5dd60 RCX:
>00007fce1d5128cb [  108.150284] RDX: 0000000000000000 RSI:
>0000000000000800 RDI: 0000556b12b5ddc8 [  108.151169] RBP:
>0000556b12b5ddc8 R08: 1999999999999999 R09: 0000000000000000 [
>108.151982] R10: 00007fce1d59dac0 R11: 0000000000000206 R12:
>0000000000000001 [  108.152756] R13: 0000000000000000 R14:
>00007ffce4754aa8 R15: 0000556b12b5def0 [  108.153523]  </TASK> [
>108.153925] Modules linked in: dax_pmem nd_pmem kmem nd_btt device_dax
>dax_cxl nd_e820 nfit cxl_mock_mem(O) cxl_test(O-) cxl_mem(O) cxl_pmem(O)
>cxl_acpi(O) cxl_port(O) cxl_mock(O) cxl_core(O) libnvdimm [  108.155784] -=
--[
>end trace 0000000000000000 ]---
>


