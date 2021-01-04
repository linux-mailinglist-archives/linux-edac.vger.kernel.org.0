Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27B72E92B0
	for <lists+linux-edac@lfdr.de>; Mon,  4 Jan 2021 10:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbhADJg1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Mon, 4 Jan 2021 04:36:27 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2284 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbhADJg0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 4 Jan 2021 04:36:26 -0500
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4D8VmC46Ltz67Xv6;
        Mon,  4 Jan 2021 17:32:59 +0800 (CST)
Received: from lhreml711-chm.china.huawei.com (10.201.108.62) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 4 Jan 2021 10:35:44 +0100
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml711-chm.china.huawei.com (10.201.108.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 4 Jan 2021 09:35:43 +0000
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.2106.002;
 Mon, 4 Jan 2021 09:35:43 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>
Subject: RE: [PATCH 3/3] rasdaemon: ras-mc-ctl: Add exception handling
Thread-Topic: [PATCH 3/3] rasdaemon: ras-mc-ctl: Add exception handling
Thread-Index: AQHWse1cnO+tUMjSm0yBcBxaBLvZTqoEwecAgBLTDgA=
Date:   Mon, 4 Jan 2021 09:35:43 +0000
Message-ID: <33ab986d1db24992a23e3adc3ae76abb@huawei.com>
References: <20201103142258.1253-1-shiju.jose@huawei.com>
        <20201103142258.1253-4-shiju.jose@huawei.com>
 <20201223110336.3c14233c@coco.lan>
In-Reply-To: <20201223110336.3c14233c@coco.lan>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.93.184]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Mauro,

>-----Original Message-----
>From: Mauro Carvalho Chehab [mailto:mchehab+huawei@kernel.org]
>Sent: 23 December 2020 10:04
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-edac@vger.kernel.org; Linuxarm <linuxarm@huawei.com>;
>tanxiaofei <tanxiaofei@huawei.com>
>Subject: Re: [PATCH 3/3] rasdaemon: ras-mc-ctl: Add exception handling
>
>Em Tue, 3 Nov 2020 14:22:58 +0000
>Shiju Jose <shiju.jose@huawei.com> escreveu:
>
>> Add exception handling in the ras-mc-ctl.
>>
>> For example, when an event's table is not present in the SQLite DB,
>> then the DBI would detect exception and ras-mc-ctl exit without read
>> and log remaining event's information. This would happen when an event
>> is not enabled in the rasdaemon. Following is the error log when the
>> devlink_event table is not present in the DB, "DBD::SQLite::db prepare
>> failed: no such table: devlink_event at ./ras-mc-ctl line 1198.
>> Can't call method "execute" on an undefined value at ./ras-mc-ctl line
>1199"
>>
>> Also disabled the DBI's automatic error logging by setting the
>> $dbh->{PrintError} = 0 to avoid duplicate exception logs.
>
>Hmm...
>
>
>	$ ./util/ras-mc-ctl --summary
>	No Memory errors.
>
>	No PCIe AER errors.
>
>	No ARM processor errors.
>
>	No Extlog errors.
>
>	No devlink errors.
>	No disk errors.
>	Exception: no such table: memory_failure_event
>
>	No MCE errors.
>
>While it sounds a good idea to catch such events, printing it as an exception
>doesn't seem the right thing to me, at least for things like "no such table".
>
>IMO, it should print something more intuitive, like:
>
>	"Warning: Memory failure detection not enabled"

Sure. I will change.
>
>-
>
>Yet, on a separate note, there's no memory_failure_event upstream.
>
>Maybe I missed some prior patch to be applied before this one?

This patch was posted previously.
https://patchwork.kernel.org/project/linux-edac/patch/20201002180144.1365-1-shiju.jose@huawei.com/

>
>
>Thanks,
>Mauro

Thanks,
Shiju
