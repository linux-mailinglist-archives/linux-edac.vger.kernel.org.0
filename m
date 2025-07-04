Return-Path: <linux-edac+bounces-4316-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CE1AF8DE9
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 11:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D71DCB6027D
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 08:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D782DAFCB;
	Fri,  4 Jul 2025 08:28:06 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B262DAFC0
	for <linux-edac@vger.kernel.org>; Fri,  4 Jul 2025 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751617686; cv=none; b=LqEFSJdvuSTUQDZGXEdwlQx0uQCu0ecnibTXgNO8bK5HV1NOXBgBnkb6QfxeQFQzh2q+DrvhRcCINMvfpnZD8lfRe8+F5T2Fy8vY/Q0+9e/razmj0yh4zN8Tu94iwGspWLoOghUI1w2X4NZczAlkZqzsi/SS554il5KX3QqnsfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751617686; c=relaxed/simple;
	bh=b79VnFEzaAwFtOjveohqY/cr+Ku1j1pJcXemn3U23jo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WC9Z++9j1q831a3h2BhtKCVpXfgfDhoeRKKcCGr4BBS36NvitEButXH4hDkp/XpYP27cEojmTSOP5iyCiR0mAPDjD7wLBD0I8J+iQCDNZodIQTIVZPbR6lU2B67ffqKF6LGIq1bvNFoluO8L2FZCzMqirqX15J8cIy462/ao2Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bYRWy4sR3z6L5HV;
	Fri,  4 Jul 2025 16:25:02 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 162E21404C5;
	Fri,  4 Jul 2025 16:28:01 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Jul 2025 10:28:00 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 4 Jul 2025 10:28:00 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, "Luck, Tony"
	<tony.luck@intel.com>, "arnd@kernel.org" <arnd@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "rric@kernel.org"
	<rric@kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
CC: Linuxarm <linuxarm@huawei.com>, tanxiaofei <tanxiaofei@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: RE: [RESEND PATCH v2 0/2] EDAC/features:  Reduce stack usage in
 create_desc functions
Thread-Topic: [RESEND PATCH v2 0/2] EDAC/features:  Reduce stack usage in
 create_desc functions
Thread-Index: AQHb7Kz4+s8ifLl3BU6SMA9VAIcTerQhfYMAgAAiKZA=
Date: Fri, 4 Jul 2025 08:28:00 +0000
Message-ID: <9ca33d563a1045e7b3116b4c450e6719@huawei.com>
References: <20250704062911.1882-1-shiju.jose@huawei.com>
 <CY8PR11MB7134C82ABE0CC64ABC6B68628942A@CY8PR11MB7134.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB7134C82ABE0CC64ABC6B68628942A@CY8PR11MB7134.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>-----Original Message-----
>From: Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
>Sent: 04 July 2025 09:18
>To: Shiju Jose <shiju.jose@huawei.com>; linux-edac@vger.kernel.org;
>bp@alien8.de; Luck, Tony <tony.luck@intel.com>; arnd@kernel.org;
>mchehab@kernel.org; rric@kernel.org; Jiang, Dave <dave.jiang@intel.com>;
>Jonathan Cameron <jonathan.cameron@huawei.com>
>Cc: Linuxarm <linuxarm@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>Zengtao (B) <prime.zeng@hisilicon.com>
>Subject: RE: [RESEND PATCH v2 0/2] EDAC/features: Reduce stack usage in
>create_desc functions
>
>> From: shiju.jose@huawei.com <shiju.jose@huawei.com>
>> Sent: Friday, July 4, 2025 2:29 PM
>> To: linux-edac@vger.kernel.org; bp@alien8.de; Luck, Tony
>> <tony.luck@intel.com>; arnd@kernel.org; mchehab@kernel.org;
>> rric@kernel.org; Jiang, Dave <dave.jiang@intel.com>;
>> jonathan.cameron@huawei.com
>> Cc: linuxarm@huawei.com; tanxiaofei@huawei.com;
>> prime.zeng@hisilicon.com; shiju.jose@huawei.com
>> Subject: [RESEND PATCH v2 0/2] EDAC/features: Reduce stack usage in
>> create_desc functions
>>
>> From: Shiju Jose <shiju.jose@huawei.com>
>
>Which branch is this patch series based on?
>I failed to "git am" this patch series either=A0on v6.16-rc4 or the RAS ed=
ac-drivers
>branch.

Hi Qiuxu,=20

https://web.git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/log/?h=3Ded=
ac-for-next
edac-for-next as suggested by Borislav.
https://lore.kernel.org/all/20250628145433.GEaGACKVlsfyRegTw6@fat_crate.loc=
al/

>
>-Qiuxu

Thanks,
Shiju

