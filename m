Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60F53F06B3
	for <lists+linux-edac@lfdr.de>; Tue,  5 Nov 2019 21:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfKEULr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 Nov 2019 15:11:47 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:19646 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726141AbfKEULr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 5 Nov 2019 15:11:47 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA5KBBbu031910;
        Tue, 5 Nov 2019 12:11:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=6fldtIfTwygtwU9YCGXXG6yjhX2kAXXRAwut7/L19I0=;
 b=F3vZr/7tfbWDfGrBvQXVMI5GIw1D+7mAVsM6tkj7Yvg2Ze3pSiFcn8aswZtTMmS8f+AN
 SvmqZKx3AH/8L643xU22Ug/NXgKYYRkw9+lN1jqHEmIKVzMzQHIft0ZP4vWyD7vdRPC4
 kqDYTOoQsHQynXOeNFAHJdDY2CuO5V8p92m4mp/afM8/TBgiehmLsiijq3UFbRhLl7K2
 +bnwf10+MK+TY/mqWNr7a8L1TfE3FeQWpXDIpkuG4po6sTXE+FiRO4EQKbWqMckbSpvV
 qkhGkSvQ7HYyDbYl+05kRY9r7JcKk9uHDCDixi4lWxihToiq3fVHUBosw4Q2LtT8wh3+ xA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2w19amv3xx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 05 Nov 2019 12:11:26 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 5 Nov
 2019 12:11:24 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.52) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 5 Nov 2019 12:11:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obKKyObselS1qfRUG3TT6lGm0S23+I9eKF2mxB99dlLDOjbsFjpQmw2PrHul3Wa+vmXvc5GxF0N2JJE+vdVHsUzUj9m/Hg7UAMu4yjvtJCanaLa/8gH0T9vRXPOs9cOxx19DZ9BaUiuA4hDV9BZejPOoQoQY4oXJqGWXEalFgL0V3pycuAQENrqwb9YjNdcHAQ4IIgVZTlwho8aYE8HZdMmf3lv0sofpebnD/Pci4bV98hKU9sbNwLWKaFH6Yzu074VHvalkHLooFbNXbNJWjJLCHBqDeJipCuPeDudrrImIcCJPRy45o6b3+SWwg1ezFmFnNqMIYjk2Uxq/vPIwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fldtIfTwygtwU9YCGXXG6yjhX2kAXXRAwut7/L19I0=;
 b=mGjNFOxWGXYWkIB6tsNdSHQLigV8ZPUDpvUTZnR41TwXU5inkY2AZpsW1ox3g4wffttGYuQf3UHH5xShRs6bbMGC9UdwkKozlNihTcOwSo+4wQ30hRvlm5ar/Nqym1dyeZgnH4v1WX8XZ3UlxBOXCJ5vXJdT7fX8nuhkZFt+bXrxLtNkGXjOriIJu13Uizkb9lVRUiNwe/c48jH6Scyo7lJLWbotfTrwdUg4j9jdU90+qPL6vVBkyB1RhhJTpMizbJE+4vIdTTCTfoapwFB7pC2oE/KzO0SJ2YwMQ7VJzKNVNAe4LqS2PSlBA7m/vc3E1YpIHcvXrod935Fx8+1FVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fldtIfTwygtwU9YCGXXG6yjhX2kAXXRAwut7/L19I0=;
 b=Qvp0/k2h7zK0sVueex+xmR1qACEauh6Z40ra5qKH+SHXQrRYqC0pG0ItUOPk4xgFGMR1ph7304oxbo3/JcZ40WtyrqnxfvowN1gLnN5yZd4P8jd8EfDCTZI2VXnb66KHQ/6XQHFMXWQL8LcUKvOsGp9yinLxxK6FUdzFOEaQ5mQ=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3358.namprd18.prod.outlook.com (10.255.238.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 20:11:22 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 20:11:22 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
CC:     Borislav Petkov <bp@suse.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] EDAC, ghes: Fix locking and memory barrier issues
Thread-Topic: [PATCH v3] EDAC, ghes: Fix locking and memory barrier issues
Thread-Index: AQHVlBSz45Hg5fqU9kW80JLQAsOb96d9AjCA
Date:   Tue, 5 Nov 2019 20:11:22 +0000
Message-ID: <20191105201115.v2pe6k6g2brx5itv@rric.localdomain>
References: <20191105200732.3053-1-rrichter@marvell.com>
In-Reply-To: <20191105200732.3053-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0037.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::26) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccf33f59-de3a-4a6b-f462-08d7622c53e9
x-ms-traffictypediagnostic: MN2PR18MB3358:
x-microsoft-antispam-prvs: <MN2PR18MB33589FA02705063D2F0B7D31D97E0@MN2PR18MB3358.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(199004)(189003)(8676002)(14444005)(81156014)(6512007)(6246003)(14454004)(71200400001)(71190400001)(86362001)(66946007)(81166006)(66476007)(66556008)(11346002)(446003)(64756008)(66446008)(486006)(476003)(305945005)(8936002)(386003)(53546011)(316002)(54906003)(6506007)(110136005)(186003)(76176011)(102836004)(26005)(6436002)(66066001)(229853002)(9686003)(7736002)(6486002)(3846002)(2906002)(99286004)(25786009)(52116002)(4326008)(5660300002)(1076003)(6116002)(478600001)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3358;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OTNNwQzwMK+kI24jO+paFjxjwagUk8g3ahUrlh0jxjFi6NEU7zRkLG4j45pC6lP8HpGc0NB2DPOz1MjaVcnY+DmDItckceylRaK+nJPFGmHuELY/G0azCacyry4VkuqE8lvN362xpdehuJuuBmLM3WNP41rOuPp4aP1xPJD9P0z/1gDAOIrD8hAC6jBdc8NNt8Cm9JYgh81+yQP0mdJ16sSpSkXRMFHEuh/KazebZtgvaYgjYbRI9ptz8EB66wp3eq+3846ja8TtIzA0Ex0riPWo0GpKLqD73QycVM18V5YRClT+G59E963GrurjSrYHOIu+nlm7qjO5VTbncJ1yOX964YA6oq+A6tk34Fv7TKSs5D+I51994MUA2F3X/QSS9qa+09LhfkNxMsAFF8A4GgYd3sLW6xwpiEKGr5D/W/RIz6RohXgmjeVs+LK0KFR9
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B59DECEBD314A44AAC656088F54B08EF@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf33f59-de3a-4a6b-f462-08d7622c53e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 20:11:22.3708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 27vWgLXKW/eUSZaIPxpRgsULlDKHCZzfeiYPwoZnOwjZ9adN2FpMcq4TX2WPUtQhSf8aQ5MuRZ7ur/Jhr+YWtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3358
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-05_07:2019-11-05,2019-11-05 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 05.11.19 20:07:51, Robert Richter wrote:
> The ghes registration and refcount is broken in several ways:
>=20
>  * ghes_edac_register() returns with success for a 2nd instance even
>    if a first instance is still running. This is not correct as the
>    first instance may fail later. A subsequent registration may not
>    finish before the first. Parallel registrations must be avoided.
>=20
>  * The refcount was increased even if a registration failed. This
>    leads to stale counters preventing the device from being released.
>=20
>  * The ghes refcount may not be decremented properly on
>    unregistration. Always decrement the refcount once
>    ghes_edac_unregister() is called to keep the refcount sane.
>=20
>  * The ghes_pvt pointer is handed to the irq handler before
>    registration finished.
>=20
>  * The mci structure could be freed while the irq handler is running.
>=20
> Fix this by adding a mutex to ghes_edac_register(). This mutex
> serializes instances to register and unregister. The refcount is only
> increased if the registration succeeded. This makes sure the refcount
> is in a consistent state after registering or unregistering a device.
> Note: A spinlock cannot be used here as the code section may sleep.
>=20
> The ghes_pvt is protected by ghes_lock now. This ensures the pointer
> is not updated before registration was finished or while the irq
> handler is running. It is unset before unregistering the device
> including necessary (implicit) memory barriers making the changes
> visible to other cpus. Thus, the device can not be used anymore by an
> interrupt.
>=20
> Also, rename ghes_init to ghes_refcount for better readability and
> switch to refcount API.
>=20
> A refcount is needed. There can be multiple GHES structures being
> defined (see ACPI 6.3 specification, 18.3.2.7 Generic Hardware Error
> Source, "Some platforms may describe multiple Generic Hardware Error
> Source structures with different notification types, ...").
>=20
> Another approach to use the mci's device refcount (get_device()) and
> have a release function does not work here. A release function will be
> called only for device_release() with the last put_device() call. The
> device must be deleted *before* that with device_del(). This is only
> possible by maintaining an own refcount.
>=20
> Fixes: 0fe5f281f749 ("EDAC, ghes: Model a single, logical memory controll=
er")
> Fixes: 1e72e673b9d1 ("EDAC/ghes: Fix Use after free in ghes_edac remove p=
ath")
> Co-developed-by: James Morse <james.morse@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Co-developed-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Robert Richter <rrichter@marvell.com>

I hope this SOB chain is correct now.

Thanks,

-Robert

> ---
> V3:
>  * fixed SOB chain again (added SOBs according to
>    submitting-patches.rst)
>=20
> V2:
>  * fixed missing 'goto unlock' in error path
>  * fixed SOB chain
>  * added comment on how to protect ghes_pvt with ghes_lock
>  * renamed ghes_init to ghes_refcount
>  * switched to refcount API instead of atomic_*
> ---
>  drivers/edac/ghes_edac.c | 89 +++++++++++++++++++++++++++++-----------
>  1 file changed, 65 insertions(+), 24 deletions(-)
