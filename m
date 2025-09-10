Return-Path: <linux-edac+bounces-4770-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DC5B5119B
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 10:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BBC4404D0
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 08:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3D73101D9;
	Wed, 10 Sep 2025 08:39:03 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6CD30F550;
	Wed, 10 Sep 2025 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493543; cv=none; b=bbVMTrRj1krntTJhBisL6jVK2EvSODJ+SM9F7KzcRT1K0kWhh89B1yVHoJ46hmdWiykbCBTMjDw9o2c4yMFqYNCUkedBv2h7sU4N35J+otmQWS/b6xqJHbprqmItxEG1WMzgShrGP7bPjgBelQkR0q577PHPIliDJaf4FFntR6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493543; c=relaxed/simple;
	bh=1unVb9A7rLJncC482sVIjlZ8IfluMpc4MVJgVqD0JVE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PE4tsfcry0+g4aE7eM9Nby2mj2DeQEu3ZD/1YVK6hEv5Z3UmRhBr45JMdyWQ/P0aurIKjU2wDApanGM0ih+ULPyb98NP38k8+RE4gtiNfJLJX1G1MBtqiCYObX3L8eqK6zymxKQR9LBud5/GKRx+Tx8XmocSSbe3YdtiWtttXaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cMDbC6vdSz6GD5p;
	Wed, 10 Sep 2025 16:37:43 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id E95FB14033C;
	Wed, 10 Sep 2025 16:38:55 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Sep 2025 10:38:55 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 10 Sep 2025 10:38:55 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: "rafael@kernel.org" <rafael@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "rppt@kernel.org"
	<rppt@kernel.org>, "dferguson@amperecomputing.com"
	<dferguson@amperecomputing.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Linuxarm <linuxarm@huawei.com>,
	"rientjes@google.com" <rientjes@google.com>, "jiaqiyan@google.com"
	<jiaqiyan@google.com>, "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>, "erdemaktas@google.com"
	<erdemaktas@google.com>, "pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>, "gthelen@google.com"
	<gthelen@google.com>, "wschwartz@amperecomputing.com"
	<wschwartz@amperecomputing.com>, "wbs@os.amperecomputing.com"
	<wbs@os.amperecomputing.com>, "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>
Subject: RE: [PATCH v12 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Thread-Topic: [PATCH v12 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Thread-Index: AQHcHC9WuMPoKRXbY02Oy+WxUZ/jerSK8o4AgAEvHbA=
Date: Wed, 10 Sep 2025 08:38:55 +0000
Message-ID: <81f32641fbc5448c8da1918ddc5d6965@huawei.com>
References: <20250902173043.1796-1-shiju.jose@huawei.com>
 <20250902173043.1796-2-shiju.jose@huawei.com>
 <20250909162434.GB11602@yaz-khff2.amd.com>
In-Reply-To: <20250909162434.GB11602@yaz-khff2.amd.com>
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
>From: Yazen Ghannam <yazen.ghannam@amd.com>
>Sent: 09 September 2025 17:25
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: rafael@kernel.org; bp@alien8.de; akpm@linux-foundation.org;
>rppt@kernel.org; dferguson@amperecomputing.com; linux-
>edac@vger.kernel.org; linux-acpi@vger.kernel.org; linux-mm@kvack.org; linu=
x-
>doc@vger.kernel.org; tony.luck@intel.com; lenb@kernel.org;
>leo.duran@amd.com; mchehab@kernel.org; Jonathan Cameron
><jonathan.cameron@huawei.com>; Linuxarm <linuxarm@huawei.com>;
>rientjes@google.com; jiaqiyan@google.com; Jon.Grimm@amd.com;
>dave.hansen@linux.intel.com; naoya.horiguchi@nec.com;
>james.morse@arm.com; jthoughton@google.com; somasundaram.a@hpe.com;
>erdemaktas@google.com; pgonda@google.com; duenwen@google.com;
>gthelen@google.com; wschwartz@amperecomputing.com;
>wbs@os.amperecomputing.com; nifan.cxl@gmail.com; tanxiaofei
><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Roberto
>Sassu <roberto.sassu@huawei.com>; kangkang.shen@futurewei.com;
>wanghuiqiang <wanghuiqiang@huawei.com>
>Subject: Re: [PATCH v12 1/2] ACPI:RAS2: Add ACPI RAS2 driver
>
>On Tue, Sep 02, 2025 at 06:30:39PM +0100, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>
>[...]
>
>> +static int ras2_add_aux_device(char *name, int channel, u32 pxm_inst)
>> +{
>> +	unsigned long start_pfn, size_pfn;
>> +	struct ras2_mem_ctx *ras2_ctx;
>> +	int id, rc;
>
>'rc' is uninitialized, and LLVM gives a warning.
>
>The issue is the "goto ctx_free" paths return 'rc' before it is set.

Thanks Yazen. I missed setting rc with the error code in the failure case o=
f the
newly added code. I will fix in the next version.

>
>> +
>> +	ras2_ctx =3D kzalloc(sizeof(*ras2_ctx), GFP_KERNEL);
>> +	if (!ras2_ctx)
>> +		return -ENOMEM;
>> +
>> +	ras2_ctx->sys_comp_nid =3D pxm_to_node(pxm_inst);
>> +	/*
>> +	 * Retrieve the lowest contiguous physical memory address range within
>> +	 * the NUMA node.
>> +	 */
>> +	start_pfn =3D node_start_pfn(ras2_ctx->sys_comp_nid);
>> +	size_pfn =3D node_spanned_pages(ras2_ctx->sys_comp_nid);
>> +	if (!size_pfn) {
>> +		pr_debug("Failed to find phy addr range for NUMA node(%u)\n",
>> +			 pxm_inst);
>> +		goto ctx_free;
>> +	}
>> +	ras2_ctx->mem_base_addr =3D __pfn_to_phys(start_pfn);
>> +	ras2_ctx->mem_size =3D __pfn_to_phys(size_pfn);
>> +
[...]
>
>Thanks,
>Yazen

Thanks,
Shiju

