Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE03610544C
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2019 15:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKUOXp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Nov 2019 09:23:45 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:32146 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726500AbfKUOXo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 21 Nov 2019 09:23:44 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xALEJrsl026978;
        Thu, 21 Nov 2019 06:23:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=3nOBUzibffD8WVfmHTktrRXL+EzKmLI8yezlm9Wsol8=;
 b=paQ1chYAd4JD6Xq/swklkXZK7KapmExYVC7azUFqw4GUav4oXHggqvwbV5l8npIw4naI
 yj44VzKHRhn7BkJa+cS+ivoAp/89b//OJR0nVUEWxvEF7KyxnSriCfFDmv3erGFTLSGj
 RI+O4BGgnpVksHXNg+z9tMGIVnpez1x5JSAzjMaa8Gi45aAHU14xh9vHRpGzC1lza4Oh
 1qp2J2UnvE8s0neu0rEwF21ez2PW9a5G1Be8quElEF5bjebLOZjbrQReRleTMvdSYxbu
 Q4OuhVwJDoHVd4Nroj6vleLrByu1i1j+PCuf68MRT2wYE/YTIgoFGI5ksfVDR5q+PK6i 3g== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2wd090y3vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 21 Nov 2019 06:23:15 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 21 Nov
 2019 06:23:13 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.59) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 21 Nov 2019 06:23:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1vJQBESg95hnCKynh6FAmcAAsotWda6eUfcAy9ENnm3RsvO0141WeAn0apL38ybA9Bn5++THao+fNxelwCOQKkqpXE3nymsub1+GkVad3HFoSQvX/2miHocpbF8IpbeEIZ6LzhQjVkb9VWp6d62zSYhCOoVHkQECZ+yd0FTYX6O4USV0bfW64e5EhZeNFvE475SA9jXn5Ka2qGAxciK66r/kZ9irTkuMm+eFEKwxVjUPorU7Cyz2d3yWwqRs0FdAQQw3Xic8r2VGwrEKt20eANpCj1sED5zVsdwQNuipn6W3HcWYJjs2sm2qjpzhPpOhlP2SCSoLr5iRlpaOhwG+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nOBUzibffD8WVfmHTktrRXL+EzKmLI8yezlm9Wsol8=;
 b=afV7PY9LaYPd6x6duUknHZZpiKHXS4MVJInZM2yvKj0Ia3IZZm9Nbr22dzB6ilS6O/KvZ6F24Vo6Ia/HcZKRf6LkDZdRCulcCfDxx77FTgR3nbNseNPpeCq4/QYIQ+whNi5peWo3LK4kcipLVPOXISetUsHMAw5d74sM+cLvBCRWC1eGqBFPVDQTVztkCUVhsopoVxkj0tV9YCW4nnguJuQ+rWe59i/wQsGmcufKaht4a2M/KdVqdiBtpgXulQzOPbdIwKYetCu5xguM6tVJmFK42Oqk1Uas76UjdD6C/kPLOCqSaBXY3RhxIz0i4ZneXNv3Vac2W3lDlV7baSTumQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nOBUzibffD8WVfmHTktrRXL+EzKmLI8yezlm9Wsol8=;
 b=kWycaEh7bl27JHdGVzmHIr7m7jp85RYNoiSie3IrjGg65wxFHBcx8G8HEZwwt/jbZyZQqmz+8+3q6E5yE9KR5feY/zjnoSw/s6/csSZbgclpXpdajs2xUFhM0E/eDX3Mi78ys/te8C5LDlrbYAQjTmPG7b9ZAVMoFu/5I7KGtCw=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2640.namprd18.prod.outlook.com (20.179.81.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Thu, 21 Nov 2019 14:23:11 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 14:23:11 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     John Garry <john.garry@huawei.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linuxnext-2019119 edac warns (was Re: edac KASAN warning in
 experimental arm64 allmodconfig boot)
Thread-Topic: linuxnext-2019119 edac warns (was Re: edac KASAN warning in
 experimental arm64 allmodconfig boot)
Thread-Index: AQHVoHc0B7IHuU8xcUefhQR74C67ew==
Date:   Thu, 21 Nov 2019 14:23:11 +0000
Message-ID: <20191121142302.rhvgkgqpiubidhtu@rric.localdomain>
References: <304df85b-8b56-b77e-1a11-aa23769f2e7c@huawei.com>
 <93bdc04e-9e8f-b766-6e97-9fd9e1460a8c@huawei.com>
In-Reply-To: <93bdc04e-9e8f-b766-6e97-9fd9e1460a8c@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0061.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::29) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f07f6519-9284-4803-0a22-08d76e8e5675
x-ms-traffictypediagnostic: MN2PR18MB2640:
x-microsoft-antispam-prvs: <MN2PR18MB264041DA231E9AE2B28176AFD94E0@MN2PR18MB2640.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(8676002)(53546011)(256004)(6506007)(14444005)(305945005)(81156014)(1076003)(7736002)(478600001)(5024004)(71190400001)(76176011)(9686003)(6512007)(446003)(11346002)(86362001)(66556008)(64756008)(6436002)(66476007)(66946007)(54906003)(6486002)(66446008)(386003)(5660300002)(8936002)(6916009)(71200400001)(52116002)(81166006)(316002)(6246003)(229853002)(102836004)(45080400002)(99286004)(4326008)(25786009)(3716004)(26005)(6116002)(66066001)(186003)(3846002)(2906002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2640;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wuDrmr+e/mwVYw3ekcnIp27YweFFxE/nTCLFGVRtXcZ+g5GJ4tosEK5l0YqNHEHsUx4eauRZvw13/UhxGWq/olAmMxgNwfl7gSITBcOofvEccIloJ179TOzePOS4ALYk16eVUGJb9/QWITkKOKsJVpi2gI+i1SDOrCuKUX9hzvyMOwlAX0aTEfKn7W+vX9rMjWAI91OAoiE9iU1/ixUy3qStEBADZQxi7dwwinhbS8sTtrY4IHly76tF03ahjSKoym7YgEW/asn3EOJ/r/fj2RZrLFlPIdpmPo0+6alWqc+QWeG+WtY9No22jj0j/q7m+2yrtfW7KQ0o1P+43UvLzTIaH5e2J8evCksJhHrvd+vpYFJezNjmOlJXOW4d6ccyANL8zDns5RzeEX23j/Ik5aL15XW/P5KZ07kbe0eWrErxHLTwK+A7dFj/0pMtYkn0
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6FA6D80EF1DAF54D9FED0B54B2751E84@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f07f6519-9284-4803-0a22-08d76e8e5675
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 14:23:11.5834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tqtcSXJmgyDYKjl1yT41AZZFErKlzeNUFTEK72c3F/WilreAuV80znMmiyIGiMXVK6SQiIqNeIg9xz5rLf0s+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2640
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_03:2019-11-21,2019-11-21 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi John,

thanks for testing and reporting this. See inline.

On 21.11.19 12:34:22, John Garry wrote:
> On 14/10/2019 16:18, John Garry wrote:
> JFYI, I see an issue on linuxnext-2019119, as follows:
>=20
>    21.645388] io scheduler kyber registered
> [   21.734011] input: Power Button as
> /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> [   21.743295] ACPI: Power Button [PWRB]
> [   21.809644] [Firmware Bug]: APEI: Invalid bit width + offset in GAR
> [0x94110034/64/0/3/0]
> [   21.821974] EDAC MC0: Giving out device to module ghes_edac.c controll=
er
> ghes_edac: DEV ghes (INTERRUPT)
> [   21.831763] ------------[ cut here ]------------
> [   21.836374] refcount_t: increment on 0; use-after-free.
> [   21.841620] WARNING: CPU: 36 PID: 1 at lib/refcount.c:156
> refcount_inc_checked+0x44/0x50
> [   21.849697] Modules linked in:
> [   21.852745] CPU: 36 PID: 1 Comm: swapper/0 Not tainted
> 5.4.0-rc8-next-20191119-00003-g141a9fef5092-dirty #650
> [   21.862645] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI RC=
0 -
> V1.16.01 03/15/2019
> [   21.871157] pstate: 60c00009 (nZCv daif +PAN +UAO)
> [   21.875936] pc : refcount_inc_checked+0x44/0x50
> [   21.880455] lr : refcount_inc_checked+0x44/0x50

This is a warning from the refcount framework. It warns if we
increment from zero. This is reasonable as typically a kernel object
is created with a refcount of 1 and thrown away once the refcount is
zero. Afterwards the object is used-after-free.

For ghes the refcount is initialized with zero, and that is why we see
this message. However, we protect the refcount with the ghes_reg_mutex
and thus there is no use after free. The device is allocated and
registered if the refcount is zero. So this works fine.

Enclosed a fix that avoids the warning, please test.

But see below...

> [   21.884972] sp : ffff00236ffbf8a0
> [   21.888274] x29: ffff00236ffbf8a0 x28: 0000000000000002
> [   21.893576] x27: ffff00236cd07900 x26: ffff002369063010
> [   21.898876] x25: 0000000000000000 x24: ffff00233c236824
> [   21.904177] x23: ffffa000137b9000 x22: ffffa00016fbb7c0
> [   21.909477] x21: ffffa00012dfd000 x20: 1fffe0046dff7f24
> [   21.914777] x19: ffff00233c236000 x18: 0000000000000000
> [   21.920077] x17: 0000000000000000 x16: 0000000000000000
> [   21.925377] x15: 0000000000007700 x14: 64655f7365686720
> [   21.930677] x13: 72656c6c6f72746e x12: 1ffff40002719618
> [   21.935977] x11: ffff940002719618 x10: dfffa00000000000
> [   21.941278] x9 : ffff940002719619 x8 : 0000000000000001
> [   21.946578] x7 : 0000000000000000 x6 : 0000000000000001
> [   21.951877] x5 : ffff940002719618 x4 : ffff00236ffb0010
> [   21.957178] x3 : ffffa000112415e4 x2 : ffff80046dff7ede
> [   21.962478] x1 : 5aff78756b1cf400 x0 : 0000000000000000
> [   21.967779] Call trace:
> [   21.970214]  refcount_inc_checked+0x44/0x50
> [   21.974389]  ghes_edac_register+0x258/0x388
> [   21.978562]  ghes_probe+0x28c/0x5f0
> [   21.982041]  platform_drv_probe+0x70/0xd8
> [   21.986039]  really_probe+0x174/0x468
> [   21.989690]  driver_probe_device+0x7c/0x148
> [   21.993862]  device_driver_attach+0x94/0xa0
> [   21.998033]  __driver_attach+0xa4/0x110
> [   22.001857]  bus_for_each_dev+0xe8/0x158
> [   22.005768]  driver_attach+0x30/0x40
> [   22.009331]  bus_add_driver+0x234/0x2f0
> [   22.013156]  driver_register+0xbc/0x1d0
> [   22.016981]  __platform_driver_register+0x7c/0x88
> [   22.021675]  ghes_init+0xbc/0x14c
> [   22.024979]  do_one_initcall+0xb4/0x254
> [   22.028805]  kernel_init_freeable+0x248/0x2f4
> [   22.033151]  kernel_init+0x10/0x118
> [   22.036628]  ret_from_fork+0x10/0x18
> [   22.040194] ---[ end trace 33655bb65a9835fe ]---
> [   22.046666] EDAC MC: bug in low-level driver: attempt to assign
> [   22.046666]     duplicate mc_idx 0 in add_mc_to_global_list()
> [   22.058311] ghes_edac: Can't register at EDAC core
> [   22.065402] EDAC MC: bug in low-level driver: attempt to assign
> [   22.065402]     duplicate mc_idx 0 in add_mc_to_global_list()
> [   22.077080] ghes_edac: Can't register at EDAC core
> [   22.084140] EDAC MC: bug in low-level driver: attempt to assign
> [   22.084140]     duplicate mc_idx 0 in add_mc_to_global_list()
> [   22.095789] ghes_edac: Can't register at EDAC core
> [   22.102873] EDAC MC: bug in low-level driver: attempt to assign
> [   22.102873]     duplicate mc_idx 0 in add_mc_to_global_list()
> [   22.115442] ghes_edac: Can't register at EDAC core
> [   22.122536] EDAC MC: bug in low-level driver: attempt to assign
> [   22.122536]     duplicate mc_idx 0 in add_mc_to_global_list()
> [   22.134344] ghes_edac: Can't register at EDAC core
> [   22.141441] EDAC MC: bug in low-level driver: attempt to assign
> [   22.141441]     duplicate mc_idx 0 in add_mc_to_global_list()
> [   22.153089] ghes_edac: Can't register at EDAC core
> [   22.160161] EDAC MC: bug in low-level driver: attempt to assign
> [   22.160161]     duplicate mc_idx 0 in add_mc_to_global_list()
> [   22.171810] ghes_edac: Can't register at EDAC core

What I am more concerned is this here. In total this implies 8 ghes
users that all try to register a (single-instance) ghes mc device. For
non-x86 only one instance is allowed (see ghes_edac_register(), idx =3D
0).

So on your platform, when parsing the HEST table
(hest_ghes_dev_register()), more than one "GHES" device is parsed,
allocated and registered. Mind sending me your HEST table
(/sys/firmware/acpi/tables/HEST), or explain what happens here? If
this is a valid use case, we need to change ghes_edac_register() to
support more than one instance.

Again, please try the patch below.

Thanks,

-Robert


From 6962f8af4a7c1051c9e87a5ac60571f70d2b6814 Mon Sep 17 00:00:00 2001
From: Robert Richter <rrichter@marvell.com>
Date: Thu, 21 Nov 2019 15:01:28 +0100
Subject: [PATCH] EDAC/ghes: Do not warn on when increment refcount on 0

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 47f4e7f90ef0..b99080d8a10c 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -556,8 +556,8 @@ int ghes_edac_register(struct ghes *ghes, struct device=
 *dev)
 	ghes_pvt =3D pvt;
 	spin_unlock_irqrestore(&ghes_lock, flags);
=20
-	/* only increment on success */
-	refcount_inc(&ghes_refcount);
+	/* only set on success */
+	refcount_set(&ghes_refcount, 1);
=20
 unlock:
 	mutex_unlock(&ghes_reg_mutex);
--=20
2.20.1

