Return-Path: <linux-edac+bounces-2607-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F34629D5D6A
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 11:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFBC1F22398
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 10:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313EE1DD885;
	Fri, 22 Nov 2024 10:41:20 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7774C187321;
	Fri, 22 Nov 2024 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732272080; cv=none; b=nSSlqTPAKCMHMqWQTE0Pb2AcRYqUAUN2Apg6wZVlu+KbNKGOu85L2nhoxj+ZO52BnyQZCzMe5DafW+uL3/Kd9MyTzeBtVXBnzc/zcARk1XDLlzv/Iv0rrizs1af7uzAz3iBpoT8la5Pc6jN0ArKQJsnjYp1g1OjtJanPMW0578A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732272080; c=relaxed/simple;
	bh=KSYXqdrMRonpXduljyoL1qqI7zpiy/+BxUamLqdoUvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HqPnMixelfuB2qOD1NpWk8lGUBYPJA5RIJx2Dlc8h2scuX9zGe1JLZMqFYxv9hGMmzJqWmvM3CmJaZnZKT74E0LUj4w7dfwoGqnjriQaS/YU0iq0ikmiiouajidhTUVTUtiWKGIvUSRHUGA2AO8HdYraM95z1jYm79ZFDVJZra4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xvs4K64MWz6873W;
	Fri, 22 Nov 2024 18:37:37 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 4586C140133;
	Fri, 22 Nov 2024 18:41:15 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 11:41:15 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 22 Nov 2024 11:41:15 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: RE: [PATCH 13/13] rasdaemon: ras-mc-ctl: Update logging of CXL memory
 module data to align with CXL spec rev 3.1
Thread-Topic: [PATCH 13/13] rasdaemon: ras-mc-ctl: Update logging of CXL
 memory module data to align with CXL spec rev 3.1
Thread-Index: AQHbOzMKWgVy8qd6/k6IUGY4Oph577LBz8AAgAFNg4A=
Date: Fri, 22 Nov 2024 10:41:14 +0000
Message-ID: <0fbde50ced8a478aaa4aabd04cb7cb8a@huawei.com>
References: <20241120095923.1891-1-shiju.jose@huawei.com>
	<20241120095923.1891-14-shiju.jose@huawei.com>
 <20241121153848.0000079a@huawei.com>
In-Reply-To: <20241121153848.0000079a@huawei.com>
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

Hi Jonathan,

>-----Original Message-----
>From: Jonathan Cameron <jonathan.cameron@huawei.com>
>Sent: 21 November 2024 15:39
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org;
>mchehab@kernel.org; dave.jiang@intel.com; dan.j.williams@intel.com;
>alison.schofield@intel.com; nifan.cxl@gmail.com; vishal.l.verma@intel.com;
>ira.weiny@intel.com; dave@stgolabs.net; linux-kernel@vger.kernel.org;
>Linuxarm <linuxarm@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>Zengtao (B) <prime.zeng@hisilicon.com>
>Subject: Re: [PATCH 13/13] rasdaemon: ras-mc-ctl: Update logging of CXL
>memory module data to align with CXL spec rev 3.1
>
>On Wed, 20 Nov 2024 09:59:23 +0000
><shiju.jose@huawei.com> wrote:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL spec 3.1 section 8.2.9.2.1.3 Table 8-47, Memory Module Event
>> Record has updated with following new fields and new info for Device
>> Event Type and Device Health Information fields.
>> 1. Validity Flags
>> 2. Component Identifier
>> 3. Device Event Sub-Type
>>
>> This update modifies ras-mc-ctl to parse and log CXL memory module
>> event data stored in the RAS SQLite database table, reflecting the
>> specification changes introduced in revision 3.1.
>>
>> Example output,
>>
>> ./util/ras-mc-ctl --errors
>> ...
>> CXL memory module events:
>> 1 2024-11-20 00:22:33 +0000 error: memdev=3Dmem0, host=3D0000:0f:00.0,
>> serial=3D0x3, \ log=3DFatal,
>> hdr_uuid=3Dfe927475-dd59-4339-a586-79bab113b774, hdr_flags=3D0x1, , \
>> hdr_handle=3D0x1, hdr_related_handle=3D0x0, hdr_timestamp=3D1970-01-01
>> 00:04:38 +0000, \ hdr_length=3D128, hdr_maint_op_class=3D0,
>> hdr_maint_op_sub_class=3D1, \
>> event_type: Temperature Change, event_sub_type: Unsupported Config
>> Data, \
>> health_status: 'MAINTENANCE_NEEDED' , 'REPLACEMENT_NEEDED' , \
>> media_status: All Data Loss in Event of Power Loss, life_used=3D8, \
>> dirty_shutdown_cnt=3D33, cor_vol_err_cnt=3D25, cor_per_err_cnt=3D45, \
>> device_temp=3D3, add_status=3D3 \
>> component_id:02 74 c5 08 9a 1a 0b fc d2 7e 2f 31 9b 3c 81 4d \
>> pldm_entity_id:00 00 00 00 00 00 pldm_resource_id:fc d2 7e 2f ...
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>Feels like there is a lot of duplication in here, but you aren't really ma=
king it any
>worse and maybe it is hard to reduce it.
>
ras-mc-ctl is a tool(script), used offline, to read, decode and print  the =
error event's data stored
by rasdaemon into the SQLite data base. Thus logging here is similar to tho=
se done in the rasdaemon.

>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,
Shiju

