Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01AED122FF3
	for <lists+linux-edac@lfdr.de>; Tue, 17 Dec 2019 16:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbfLQPRQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Dec 2019 10:17:16 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:29740 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728005AbfLQPRP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 17 Dec 2019 10:17:15 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBHFGxIE000927;
        Tue, 17 Dec 2019 07:16:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=HMyyZUleFdIabNIdJiS5b2kDaiJr4Yu2NhTiTjl4ERA=;
 b=sI8GX76189meEFnKy6XGAHMpO+iwcTJxqW/qnIXVjgfqA9IMr8R6+H9SYPaDfnq9C5Ri
 HjugN02bATGNvuQmyLN4HesckOwpponrVDT7Dm9iH0Jx4z12hgNa2CnFQAK9KX8mKwRa
 bBvMjymac8jKIh89yJg3lI75JQr/Hrqn/6jvpeP4DFIUQBaThEO7uIQWn2aVmIMx6rvN
 VLrAuiyReEM8W2+ngbwaofdkYHUJSjLd9rygvCkljQxhdb6SJyQNG9RRll3fXZEwVUJQ
 zSKuutdOwrmNFG6/umTon8Ztq8kpvyRZ1B9tmzPnY+fe7RvYKgWoA419zjaVbTZo3dkz xg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2wxn0wjjsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 07:16:59 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 17 Dec
 2019 07:16:57 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.54) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 17 Dec 2019 07:16:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbPwQNpJPzyR+aFCN7+sDodrt1tcdPu9XaibNigwDNKf+uGos0njpd7fhdXN3/dC45gaeFB0KFj+nX+09lVDif3hLYKjwbjuk+D/mzL1itvz2896IlMcu1m5pBJLbpJnCZKw5UL+RXM0Uo7VUJrcJXNFEi6/zmGz135lughZ77PH/S9M5jy600IU2r6W2VV3EartQtOZUx245UE1a3fO/lDRnbdKZrD7vU3vGbiKZpxdrmLCOhyse6fTWpRHkVpfkQjvAne//GXaJHXptIl8zuRoZf7HdoUEK84oDRFcI7EJQj70SN46e/oPC8RSl9s9AqkAiZOB5oHh5/+bFY0jdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMyyZUleFdIabNIdJiS5b2kDaiJr4Yu2NhTiTjl4ERA=;
 b=B/eIEi5ggdWLdRk9F9FChrcdbcQBIWUwuQ8KPllUoIYkma2ivcBvP0B6a+U4fntIQMBcTZeD+1f1EPlXOz2ZI9k4ii9tLdQIXFGbyKCmrswGLSYGxkD7jiJRMD4wJ/tcK7asQYyF7Nl9+as5I5908i4HaWsCLk3lehbiy1q+SqbFAT1LCZ9umOsK+iOSZApTSXC+qV+TIWWMAtHRPjPdfJM0i6nFXjxRoJN33jyxvNsw6WdPKpgnkFRudbsiFuQIG6jKSDogUOQfm9DxivPpo4YgLDpopLcRFkIWhe8kzhDVagDVvhslB/pUMxcsTDQedgGoDGBODb17LwIU7Z2SLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMyyZUleFdIabNIdJiS5b2kDaiJr4Yu2NhTiTjl4ERA=;
 b=IJJoIK3UnapKsl2/0WsIQ/LCpBCaPNfVKD8cCnN5BvHgZCfmBxHgz991y3cblBtjooAY8x0sB2n2zzO6dKAf30m2UbxHARgWh9H9pw3+6hu7Ry3sCc60YJyj0vfm/p+qcu3LMoV1SJxgtRSHZ1Ws0tJQbmEsuc0TyGNTA2jkmiM=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2894.namprd18.prod.outlook.com (20.179.22.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Tue, 17 Dec 2019 15:16:53 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2559.012; Tue, 17 Dec 2019
 15:16:53 +0000
Received: from rric.localdomain (31.208.96.227) by HE1PR05CA0306.eurprd05.prod.outlook.com (2603:10a6:7:93::37) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 17 Dec 2019 15:16:51 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/10] EDAC: Rework core and ghes drivers, part two
Thread-Topic: [PATCH v2 00/10] EDAC: Rework core and ghes drivers, part two
Thread-Index: AQHVq0+sz98n7KgjO0C17RD2HnwZvqe+g1wA
Date:   Tue, 17 Dec 2019 15:16:53 +0000
Message-ID: <20191217151643.l742kbanczxtankq@rric.localdomain>
References: <20191205093739.4040-1-rrichter@marvell.com>
In-Reply-To: <20191205093739.4040-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0306.eurprd05.prod.outlook.com
 (2603:10a6:7:93::37) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd1044e1-d901-46a0-35e2-08d783042588
x-ms-traffictypediagnostic: MN2PR18MB2894:
x-microsoft-antispam-prvs: <MN2PR18MB2894C5371F6B514002223DE2D9500@MN2PR18MB2894.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(199004)(189003)(86362001)(55016002)(71200400001)(186003)(9686003)(498600001)(6506007)(81166006)(110136005)(966005)(53546011)(1076003)(66946007)(8936002)(81156014)(956004)(66446008)(66556008)(66476007)(8676002)(7696005)(54906003)(64756008)(26005)(5660300002)(16526019)(4326008)(2906002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2894;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cm9pYgeqN8+Xc0tTG/OnaARteR3aq/8DiEgmbj58oCObD9JFZC4YobHHAlfMFnhr+jontzpL/VJr343AXQoLOfWHu+86Sa2njmFUiR5ptAIdXaAjtVdu+dI785a724KPTF8Wn3Hmc/nTb8fxa9IiONJ7l5+ZwiV0PQv9AYlPbs9ygE/unygB459ucJMittUDEpD/yJtX8qfW4IP0uUDNEpufjjRpJdoTJDhVHmiT4R44vCnbNGChMRhIAkySVWKFURuawM4aSwY+fxCxezwlGAkVyGmSzO228U4fskSNS9bbmourL2bO6M0iOTlaMSWAgJgiY9N3DBJi1OtA75h+jRfg9QC/VdMiEkDe4UZkGe1sHbVWYtRQzdcEUcFb7d9UTMm7mabxgWMUl8uRMFyNzZUDBbjn11bR9jgamoRAh26Cw+dGLDR6ZmCZsih6YwIoHwYhomdQohUV6Ics5URCUlvmJtrIc7ZfLkXYilKcayE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <105F300F6FEC6541AEDBAB6CD7D50C60@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1044e1-d901-46a0-35e2-08d783042588
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 15:16:53.0894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RqZEidqEDFknWtYb8F9R/hJpNywW9e9F1dZTXSKUXhTp7231wLYQelKHUt8U1Pjsf/rmqbU6cUuBQJVo4rlimg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2894
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_02:2019-12-17,2019-12-17 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Gentle ping for review of this series.

Thanks,

-Robert

On 05.12.19 10:37:55, Robert Richter wrote:
> This patch set is part two of a rework of the ghes_edac and edac_mc
> driver. It addresses issues found during code review and while working
> with the code. Part one has been included to v5.5, see:
>=20
>  https://lore.kernel.org/patchwork/cover/1093488/
>=20
> The changes of this series include:
>=20
>  * add helper functions and factor out code (#1, #2, #5)
>=20
>  * improve function interfaces and data structures to decrease
>    complexity such as number of function arguments, unused data, etc.
>    (#3, #4, #7, #8, #9, #10),
>=20
>  * minor functional fixes (#6)
>=20
>  * improve code readability (#9)
>=20
> V2:
>  * fixed documentation issue in #3 found by "kbuild test robot
>    <lkp@intel.com>"
>=20
> Changes compared to part one:
>  * rebased onto 5781823fd0d3 ("EDAC/altera: Use the Altera System
>    Manager driver")
>  * reworded patch subjects
>  * reordered patches
>  * collected Mauro's Reviewed-by-tags (note: I kept them though there
>    has been small conflicts but dropped it when reworked)
>  * dropped: "EDAC/mc: Rework edac_raw_mc_handle_error() to use struct
>    dimm_info"
>  * split "EDAC/mc: Remove per layer counters" into smaller changes
>  * added:
>    "EDAC/mc: Report "unknown memory" on too many DIMM labels found"
>    "EDAC/mc: Remove enable_per_layer_report function arguments"
>    "EDAC/mc: Pass the error descriptor to error reporting functions"
>    "EDAC/mc: Remove detail[] string and cleanup error string
>    generation"
>  * moved to the end:
>    "EDAC/mc: Remove per layer counters"
>=20
>=20
> Robert Richter (10):
>   EDAC/mc: Split edac_mc_alloc() into smaller functions
>   EDAC/mc: Reorder functions edac_mc_alloc*()
>   EDAC: Store error type in struct edac_raw_error_desc
>   EDAC/mc: Determine mci pointer from the error descriptor
>   EDAC/mc: Create new function edac_inc_csrow()
>   EDAC/mc: Report "unknown memory" on too many DIMM labels found
>   EDAC/mc: Remove enable_per_layer_report function arguments
>   EDAC/mc: Pass the error descriptor to error reporting functions
>   EDAC/mc: Remove detail[] string and cleanup error string generation
>   EDAC/mc: Remove per layer counters
>=20
>  drivers/edac/edac_mc.c       | 496 ++++++++++++++++-------------------
>  drivers/edac/edac_mc.h       |   6 +-
>  drivers/edac/edac_mc_sysfs.c |  20 +-
>  drivers/edac/ghes_edac.c     |  16 +-
>  include/linux/edac.h         |   9 +-
>  5 files changed, 249 insertions(+), 298 deletions(-)
>=20
> --=20
> 2.20.1
>=20
