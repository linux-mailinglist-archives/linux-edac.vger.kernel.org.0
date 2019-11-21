Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 014E0105C1D
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2019 22:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKUVhQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Nov 2019 16:37:16 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:44032 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726297AbfKUVhQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 21 Nov 2019 16:37:16 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xALLa7Ew019620;
        Thu, 21 Nov 2019 13:37:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=LhkwCDxj2zmr/bo/TCb6irLf/K8dkYFWaKp+YNfoiDk=;
 b=QZSlGR/9gaPwmpSAXW1Zdtulu+SIHXyATNwZebXWo7w0SgNMx8udGd/aQXKobS/Jlw7Q
 qrZcHHwwycqqbKoIu0k7hdHeujmOTyPa0qTOhMyaPnBSw3JMGYhNxDeX8mMtdUDDaiFg
 o6jE4SjWLz5G8HnIQZy4mihEP+CyncyzIExnAouchcQz95zJLgbfJXG39bPNwEZRQnQQ
 U7XaGxo60BSepvwi+5hYXz08Wc4CCGZGXnAGwY14oXbK5kRkDJwYfo50SOLRlI7863WS
 0I+CXd7XVy5mneQYjMO9+81qDNuYLcNBLOzuBm/DXsaZh0kAqiK2z1aOe5gjvtbkNkZN 7A== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2wd09116yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 21 Nov 2019 13:37:00 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 21 Nov
 2019 13:36:58 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.50) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 21 Nov 2019 13:36:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJZFLJ3u7ssSRew4DEbP6fKZYkJkTOf/8SdHpzUyW8rL447I1XJBgB0h5uaJaCTDf7VGlOVVjFKNW9cGns2FrrHyvN+xcMug8MWIWguILbm78pWDoEDx99Y3gU+LXNAR6UPgZivEGELGVWW9NPgY3vtAjLjplIMOdA2qXT4BLRsh1ZBouNmuYaY8n5aaVbOsCljgWRrD9u7CJoqUJJTlanmysB2jzg1cXmsBnX2egQ9cVtaMOs/qcga9huiX0ynBA85Bu+gsyoGSksLHyec8rrwVoPSZNzFzsziXjPB04ZL+x147g66sJHU6+NLnSudAmqJZ6ri1/w3hmhkywirRpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhkwCDxj2zmr/bo/TCb6irLf/K8dkYFWaKp+YNfoiDk=;
 b=hLdFjUgXVQ2qr7mrVElZ5R6i7ixBUO3lAYtanliDdAh2AU2Mk/Vq7cHpU8nWdPO+ZDdjGxf2mKZTXnCmCIQqEh0dqGWoV50ZKhXYNkJrBe3x2UwI71aEyGTRiWQtuUgwR3H3mq61Qp9mAlxCzIdgs9RQun8XPLIpRKw8Isrvlx3j8zpVyDBSlth7LOf0MqTGYaVSZAOgqxo8H/tdnF++TwxqXLfSXx8pTUVutHMsfdgDrubGb4ZlaUZEXOmJ87stIOAsCvGDowo0gR6/HHwEXYK5Dt2zdKdmTbWTdPgRsfg2SYsIWvXixC2WvG/EnhMlAiUrM7LcGZNvVNyA26EkTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhkwCDxj2zmr/bo/TCb6irLf/K8dkYFWaKp+YNfoiDk=;
 b=RoZCAj5qPc3fr4TBZls1NLKecl+p1Pd8nlXPGrlzOw0ffxsH00qYgXNGown4Ty/hSR+9RCB6zlPoKxMS9nyAbgyFXxgqM3K92/4qu46WdBgildP0oaJYgBwUT7dhC1XSpH4EIW9McVRL+V4Wsf94xRs6Z+XX+ebWtI525CzvNdQ=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2510.namprd18.prod.outlook.com (20.179.83.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.18; Thu, 21 Nov 2019 21:36:57 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 21:36:57 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     "john.garry@huawei.com" <john.garry@huawei.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
CC:     "huangming23@huawei.com" <huangming23@huawei.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Robert Richter <rrichter@marvell.com>,
        "tanxiaofei@huawei.com" <tanxiaofei@huawei.com>,
        "wanghuiqiang@huawei.com" <wanghuiqiang@huawei.com>
Subject: [PATCH] EDAC/ghes: Do not warn when incrementing refcount on 0
Thread-Topic: [PATCH] EDAC/ghes: Do not warn when incrementing refcount on 0
Thread-Index: AQHVoLPMTYQWqoUDAEKhsjLdTKvU5A==
Date:   Thu, 21 Nov 2019 21:36:57 +0000
Message-ID: <20191121213628.21244-1-rrichter@marvell.com>
References: <4ff7631f-fbb7-e45f-87dd-9223beca4da7@huawei.com>
In-Reply-To: <4ff7631f-fbb7-e45f-87dd-9223beca4da7@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::34) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4909f83b-9846-44b8-9800-08d76ecaef03
x-ms-traffictypediagnostic: MN2PR18MB2510:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB25103BEB52ACD3E32227FFA1D94E0@MN2PR18MB2510.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(136003)(376002)(346002)(366004)(189003)(199004)(81156014)(6506007)(66476007)(3846002)(54906003)(66556008)(66446008)(110136005)(66066001)(6436002)(6116002)(11346002)(64756008)(66946007)(386003)(316002)(2501003)(102836004)(25786009)(446003)(7416002)(14454004)(76176011)(6486002)(86362001)(6512007)(36756003)(71200400001)(8676002)(71190400001)(2906002)(2616005)(14444005)(4326008)(256004)(5660300002)(1076003)(50226002)(8936002)(81166006)(99286004)(52116002)(7736002)(186003)(305945005)(26005)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2510;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d83YqB0kn+QYiyc1Y5f4iayGFX3/zGMqpdOA7F2aMRdVMAa74OQ/84wyR33Je/Wvn5zwo/ZAoFIPGcyBNCDl/7oqf1Az9Dbu1t50j3pKsmtGW3qm8uzgRuIpMrsO8UpGEs3XMpSULSXdRq8NhLtqrT7Km7R6SdAh5mMdAHZR5lRpAJ+llDJB0IEh3SRcvyMc9yrFOrr00Pba1PYPqjFlJHYEKzwpP2PFyiq/xPUBPdtUhGEWgg0P6LfCGRACnibNhvRbx741tspv9D3kGje2sx1pfN7FAQxdPwUFuYXz0LKD7vr4iKfsv1t7W7YAaImNEWa8jcjev8On46JEn1eLbkfYUO8BZAvX9LdqVpbuXYJEdv7FHwvpPrQ9iHjzOo6JavbcvH09CaCWHIn2ZIhE2Bb8U/P7Z8FUDGXCPWbFoFHdW7Ly26+ukX8FXH3dLRmx
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4909f83b-9846-44b8-9800-08d76ecaef03
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 21:36:57.1602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c7jSiKTU4mqakC4Ev3vmO3A8S17n87u8zIWumsH1c7m1x5OAa3o9YnggbmPHysUqkdgnllPCwb7jN90ye0hqmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2510
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_06:2019-11-21,2019-11-21 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Following warning from the refcount framework is seen during ghes
initialization:

 EDAC MC0: Giving out device to module ghes_edac.c controller ghes_edac: DE=
V ghes (INTERRUPT)
 ------------[ cut here ]------------
 refcount_t: increment on 0; use-after-free.
 WARNING: CPU: 36 PID: 1 at lib/refcount.c:156 refcount_inc_checked+0x44/0x=
50
[...]
 Call trace:
  refcount_inc_checked+0x44/0x50
  ghes_edac_register+0x258/0x388
  ghes_probe+0x28c/0x5f0

It warns if the refcount is incremented from zero. This warning is
reasonable as a kernel object is typically created with a refcount of
one and freed once the refcount is zero. Afterwards the object would
be "used-after-free".

For ghes the refcount is initialized with zero, and that is why this
message is seen when initializing the first instance. However,
whenever the refcount is zero, the device will be allocated and
registered. Since the ghes_reg_mutex protects the refcount and
serializes allocation and freeing of ghes devices, a use-after-free
cannot happen here.

Instead of using refcount_inc() for the first instance, use
refcount_set(). This can be used here because the refcount is zero at
this point and can not change due to its protection by the mutex.

Reported-by: John Garry <john.garry@huawei.com>
Tested-by: John Garry <john.garry@huawei.com>
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

