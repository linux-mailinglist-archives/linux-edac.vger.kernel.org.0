Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B819F1245
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 10:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbfKFJdi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 04:33:38 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:14734 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731712AbfKFJdi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Nov 2019 04:33:38 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA69UNGN002538;
        Wed, 6 Nov 2019 01:33:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=NMz8HKNPT5n+l5k0+GACBMBQDogCHu2Sf6ZMz11U42c=;
 b=I83jqS5i0j6nbdKl2t0RALqPfwO+RAtXG21xVOJSkLr2CJrvdojNi9LPCuxbl2ZUr+9S
 L7aLPTP9kCXER6FigmMsSy2ngyy9IFVVGnxxa1LBDfmwi/YwVUO7QcGLuCpBXksv760v
 qDEycAnwsuSTWBT3HR+QdVNJqcsCE02n7Hyy/eG3SNl/7LULBNkJzaoDgDE/wbCz4gyh
 dkPhARRqVhv6tET4MbVD6zA532ZvRrVN2EhhLNI0q898fN3oUVNmd6yNQvuqI6svtGlo
 6Hi+uBCnVU7BEwdaWOp19Y60bTJ7MU9ugAeS3h1nhQX2vPEL7i4OouwIcBdia9LfmxHD 6g== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2w3eud3c7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 01:33:25 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 01:33:24 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.57) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Nov 2019 01:33:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFe9kepT0I8qxeKcZLoW8VrB+qoC+wP13YZhme0imBXTAFQdkyGanIC3+6odH0/KNY5+YQaR9BXOY1KmxB1f8Ld0glVyvFVDyX2GVx+pLJtuOxucwddwSEV9D2sOudQdWOECAoA8rrO9lbzA5jkqqW1Pmgx/Ekyz6EN9HfppBa6Q342lOU2eozzW0wVCyEi0g/T1ym+qREHFI8HnVpdGLnvEGPLLUT7faaEFqWU00x5HKXRk0GGt8NGnwr8buIgD2pjg7bBwcByP3n37EjllDvKlztGI1ojThGFxvsUeDojkrfYHsQDHRBohQEbq+19NFB3D5lCXbMwjuNq1YHiPUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMz8HKNPT5n+l5k0+GACBMBQDogCHu2Sf6ZMz11U42c=;
 b=C+L9pxpoR04ij6qaNkguuh/EzavlOCKdaEehUr5rx5NmoozgB64ytQRpDIauYRohfiYmvCc6HsyLKaNNGlPwsau93ba4lptJzC5Vj8I+cJDZNdQr8201I3faRIXvIFC6fu4NGdflAVt7xpWUDkKh1XuM+TZLvp2FVLRIs1BuV7g4MUBC7NcNi85WPmXadyncOONRdVvb2mUmLlTvRkptEoZmACQOS68hVswjGvKqIgmpgYV6tJCnU8QFG0JZyAUjieqXtad1d1xkFCdmJ8P0+IdyZLc6hrIZo3oZkccRi4IYQMfWFVTUlkPh1JD/lJCB4rDXSgl+6WGw0nWEys2oww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMz8HKNPT5n+l5k0+GACBMBQDogCHu2Sf6ZMz11U42c=;
 b=FjVEtf4wcRq9q1wlNUO0sMqXK/8sWDLWRhJO8Lla4W+UEVOpzLJdYzf6sItJdvlUKN9V9kU9EvaqgRLcrcLrFfUWFYGwMfYmDV/sF/FAMEw96aV1LK8P6OqLwhi7mQ0NgJu+tvCOsH3p3VEOy2qtSI3cuAN21L+3qcCxjVxcYWA=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3165.namprd18.prod.outlook.com (10.255.236.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 09:33:23 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 09:33:23 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Subject: [PATCH v2 10/20] EDAC, ghes: Fix grain calculation
Thread-Topic: [PATCH v2 10/20] EDAC, ghes: Fix grain calculation
Thread-Index: AQHVlIU7o+YOpjBkNEWoXqVKFSptpA==
Date:   Wed, 6 Nov 2019 09:33:23 +0000
Message-ID: <20191106093239.25517-11-rrichter@marvell.com>
References: <20191106093239.25517-1-rrichter@marvell.com>
In-Reply-To: <20191106093239.25517-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0287.eurprd05.prod.outlook.com
 (2603:10a6:7:93::18) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23536f82-a3a2-427f-5eb6-08d7629c5e0f
x-ms-traffictypediagnostic: MN2PR18MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3165A671CA068941F37BFB45D9790@MN2PR18MB3165.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(52116002)(305945005)(6486002)(76176011)(71190400001)(71200400001)(256004)(11346002)(446003)(7736002)(14444005)(6436002)(4326008)(6512007)(66446008)(66556008)(66476007)(66946007)(64756008)(5660300002)(1076003)(476003)(6116002)(3846002)(110136005)(54906003)(36756003)(2906002)(8676002)(99286004)(81166006)(81156014)(316002)(8936002)(50226002)(486006)(6506007)(386003)(102836004)(66066001)(2616005)(86362001)(478600001)(25786009)(186003)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3165;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2uxxCzhad9EezHB1UNLwr6tbLPmM2AEomQrGKRK9htTJDCL+eihaNTViO6BzSPNjGS4DNXJivYEh5o+sxDvQHy92zO3GDZ80ZNsG7/3qNqIcc5EPrF1SNTsJRnuqLZId2Gj2ZahGrUyF0NdmZzl/aToKDRaF/fvHHvj7G32UeQmPP1zPjSt+/Pni7gonqzfc1wlN3vxHilpmCi+ST7sMYOGZWOnVQWt1jCgkooSjM3NgZXh7F4h38v3hPstge8AB+JqKO/0gnUw/U1cYitXiKhqs5Q6a+sjnxZQdVnfZbG+6Kq19w4hzZJDMHWURXUcsVQABKmG557lItjAvy7c2qrlNzl23H4Q4dKfLaB4ufohDPoYkpojhTOBreCVOd7udL0GPB5d0wf09TJwwRXktRDcSq+dlhlqOg0BEzWVHyzLeoBxw8qPeVmBMsShWty/B
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 23536f82-a3a2-427f-5eb6-08d7629c5e0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:33:23.2458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rj70I2Ckb3CdrS6FF5/FpbMCMwVs89+mJJ+QWNVzKCgEvpTXKNKAfmqbR0MvEXJH4ppxwgITB6j9DN2dcgVkAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3165
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The current code to convert a physical address mask to a grain
(defined as granularity in bytes) is:

	e->grain =3D ~(mem_err->physical_addr_mask & ~PAGE_MASK);

This is broken in several ways:

1) It calculates to wrong grain values. E.g., a physical address mask
of ~0xfff should give a grain of 0x1000. Without considering
PAGE_MASK, there is an off-by-one. Things are worse when also
filtering it with ~PAGE_MASK. This will calculate to a grain with the
upper bits set. In the example it even calculates to ~0.

2) The grain does not depend on and is unrelated to the kernel's
page-size. The page-size only matters when unmapping memory in
memory_failure(). Smaller grains are wrongly rounded up to the
page-size, on architectures with a configurable page-size (e.g. arm64)
this could round up to the even bigger page-size of the hypervisor.

Fix this with:

	e->grain =3D ~mem_err->physical_addr_mask + 1;

The grain_bits are defined as:

	grain =3D 1 << grain_bits;

Change also the grain_bits calculation accordingly, it is the same
formula as in edac_mc.c now and the code can be unified.

The value in ->physical_addr_mask coming from firmware is assumed to
be contiguous, but this is not sanity-checked. However, in case the
mask is non-contiguous, a conversion to grain_bits effectively
converts the grain bit mask to a power of 2 by rounding up.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/edac/ghes_edac.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 944c9d2f0eef..4acb456c20f7 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -230,6 +230,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_se=
c_mem_err *mem_err)
 	/* Cleans the error report buffer */
 	memset(e, 0, sizeof (*e));
 	e->error_count =3D 1;
+	e->grain =3D 1;
 	strcpy(e->label, "unknown label");
 	e->msg =3D pvt->msg;
 	e->other_detail =3D pvt->other_detail;
@@ -325,7 +326,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_se=
c_mem_err *mem_err)
=20
 	/* Error grain */
 	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
-		e->grain =3D ~(mem_err->physical_addr_mask & ~PAGE_MASK);
+		e->grain =3D ~mem_err->physical_addr_mask + 1;
=20
 	/* Memory error location, mapped on e->location */
 	p =3D e->location;
@@ -441,8 +442,13 @@ void ghes_edac_report_mem_error(int sev, struct cper_s=
ec_mem_err *mem_err)
 	if (p > pvt->other_detail)
 		*(p - 1) =3D '\0';
=20
+	/* Sanity-check driver-supplied grain value. */
+	if (WARN_ON_ONCE(!e->grain))
+		e->grain =3D 1;
+
+	grain_bits =3D fls_long(e->grain - 1);
+
 	/* Generate the trace event */
-	grain_bits =3D fls_long(e->grain);
 	snprintf(pvt->detail_location, sizeof(pvt->detail_location),
 		 "APEI location: %s %s", e->location, e->other_detail);
 	trace_mc_event(type, e->msg, e->label, e->error_count,
--=20
2.20.1

