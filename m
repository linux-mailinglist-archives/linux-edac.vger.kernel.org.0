Return-Path: <linux-edac+bounces-3965-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3F2ABE831
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 01:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8832C4C66A4
	for <lists+linux-edac@lfdr.de>; Tue, 20 May 2025 23:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE41325E476;
	Tue, 20 May 2025 23:44:23 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A6F20C469;
	Tue, 20 May 2025 23:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747784663; cv=none; b=YqMs9Bv/qUNgXy87kzkwWjeFJLlTpBS5+wjbBK+rGQ0JfsAkgedtyfk9S5gxHA5RQwf28dkjerhXRI1KgHjhDTtuHvFUqaNJv61apNAjVCD84m5PUK+EewbcpvlfEJVleCVa86lfg3Ts8P4qwrVRtLPcnTTc9nIwv2OoINOuHi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747784663; c=relaxed/simple;
	bh=x/eVtiBKZUtdF5Mz7daO0zlZe8NYUeYy4df1FsOSzyg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZQiitSeTveZBY61/tM3oqYp9H3uRhpOawJE2nLGRjWeUOyAXf0siTIbKQvUuHjFmYE/QNT0avyhEbd1YAxWZ26VsHfG3CIsjreE1ZnKVWSrcDScytDaUVibHeDWn+wZF1rHcScKsMJ7GaK1slKpUOF/aWKJnnnIzbHuKilF6o7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b29zk4r16z6L50b;
	Wed, 21 May 2025 07:41:06 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 500B8140519;
	Wed, 21 May 2025 07:44:16 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 May 2025 01:44:15 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 21 May 2025 01:44:15 +0200
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
Subject: RE: [PATCH v5 0/8] cxl: support CXL memory RAS features
Thread-Topic: [PATCH v5 0/8] cxl: support CXL memory RAS features
Thread-Index: AQHbxZDbv1byJEJ2lESUs1jPn5i3f7Paom2AgAEr/5A=
Date: Tue, 20 May 2025 23:44:15 +0000
Message-ID: <5cd76e828f694871a83747384dd5f90d@huawei.com>
References: <20250515115927.772-1-shiju.jose@huawei.com>
 <aCvcgUv03XUWtYKS@aschofie-mobl2.lan>
In-Reply-To: <aCvcgUv03XUWtYKS@aschofie-mobl2.lan>
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
>Sent: 20 May 2025 02:36
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
>Subject: Re: [PATCH v5 0/8] cxl: support CXL memory RAS features
>
>On Thu, May 15, 2025 at 12:59:16PM +0100, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Support for CXL memory EDAC features: patrol scrub, ECS, soft-PPR and
>> memory sparing.
>
>snip
>
>>
>> Shiju Jose (8):
>>   EDAC: Update documentation for the CXL memory patrol scrub control
>>     feature
>>   cxl: Update prototype of function get_support_feature_info()
>>   cxl/edac: Add CXL memory device patrol scrub control feature
>>   cxl/edac: Add CXL memory device ECS control feature
>>   cxl/edac: Add support for PERFORM_MAINTENANCE command
>>   cxl/edac: Support for finding memory operation attributes from the
>>     current boot
>>   cxl/edac: Add CXL memory device memory sparing control feature
>>   cxl/edac: Add CXL memory device soft PPR control feature
>>
>>  Documentation/edac/memory_repair.rst |   31 +
>>  Documentation/edac/scrub.rst         |   76 +
>>  drivers/cxl/Kconfig                  |   71 +
>>  drivers/cxl/core/Makefile            |    1 +
>>  drivers/cxl/core/core.h              |    2 +
>>  drivers/cxl/core/edac.c              | 2082 ++++++++++++++++++++++++++
>
>Hi Shiju,
>
>The file edac.c contains a scattering of ifdef's that can be replaced with=
 the
>IS_ENABLED() mechanism.
>
>This issue touches many patches, looks like patches 3-7 all added to edac.=
c.
>
>See Documentation/process/coding-style.rst  "Conditional Compilation".
>You'll find a few usage example in drivers/cxl/ and of course many more al=
l over
>the kernel.
>
>Conversely, in cxlmem.h, the patch uses IS_ENABLED() where an #ifdef is
>perfectly fine and expected. See the surrounding ifdef's in cxlmem.h
>
>I'm aware it's not a simple search and replace operation to rework this bu=
t it is
>worth doing now to make the code more readable forever, and there's also t=
he
>benefit of allowing the compiler to check code inside the block for correc=
tness.

Hi Alison,

Thanks for the feedback.

I replaced #ifdef  with  IS_ENABLED() in .c file and opposite in cxlmem.h.

Thanks,
Shiju

>
>-- Alison
>
>>  drivers/cxl/core/features.c          |   17 +-
>>  drivers/cxl/core/mbox.c              |   11 +-
>>  drivers/cxl/core/memdev.c            |    1 +
>>  drivers/cxl/core/region.c            |   10 +
>>  drivers/cxl/cxl.h                    |   10 +
>>  drivers/cxl/cxlmem.h                 |   36 +
>>  drivers/cxl/mem.c                    |    4 +
>>  drivers/edac/mem_repair.c            |    9 +
>>  include/linux/edac.h                 |    7 +
>>  15 files changed, 2356 insertions(+), 12 deletions(-)  create mode
>> 100644 drivers/cxl/core/edac.c
>>
>> --
>> 2.43.0
>>


