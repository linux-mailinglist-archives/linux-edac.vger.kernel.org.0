Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2262146417
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2020 10:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgAWJDO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Jan 2020 04:03:14 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:57098 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728899AbgAWJDO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Jan 2020 04:03:14 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00N91RJ8030011;
        Thu, 23 Jan 2020 01:03:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=cAG7xKJQ6P2j2GblAKQzq4SaOB4XZuYJkIjcN+KmayI=;
 b=cYDAyV+w2QCsGdJcfuNrP2kU/lXS1JiUIkO+CGhG2SZCf6j+VcMvZQ9jpy6Eqley1fNo
 G1gteiPlBHarOeBpNIpVGGTmjexZ3zNMWW8UeJurMn9qE2uA+cpaMnOtyBai27pVOMv+
 bJ5BFuaOyLCESVxtqrG1q8er9x2twsfggzBGMKCWdHiuOdAnnYM4gTDgGCJP2dC510s7
 wdHv2QwkcDNAi724vNkqcmK1KDCaF54wxwwQaIMiq7HSWaoqzLVf8Pkpipsqxmpqmw7H
 pFF1SU980gc2s71yEi4/WKGN0v2Q7e1gzhCHmu2G8absAQkcCGKgawxGsF7DEdTbY4gg Yw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2xm2dtb1yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 23 Jan 2020 01:03:02 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 23 Jan
 2020 01:03:00 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Jan 2020 01:03:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2d6JjFoY4YxPPO7TDI5IYU6hkfkb4r0L2LwUraTNu/vUInr9L0+gGxfZEfZJr8s1Luw6XveXeOtf7Hnk6PLCiwAkfGWYpiVzbFnFBNbXuNW1u2u94T6BcY3cDXwimDQdzJOao8jJVl+zq1tZtjbjF2+ElvvbBSdRaPq/ks44Ctq0wihkHIg5THFxyFNVtnmQ8p1e/SknODMd84wrr/Mevl5sZIuKv9CcOXCd6WG+d70agyd4zwKc/8YVFV2WmqpQ3n+gW0sD+9NW+k+cHhzuPOAS5nHZvrMKsT+T5MYM2zsUClUGOzlP8pOxrzhBT+LV/O8f61/air9uz7ASHT4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAG7xKJQ6P2j2GblAKQzq4SaOB4XZuYJkIjcN+KmayI=;
 b=JikYc3byBVyvr6DnzE7az8Wy8ixZKuKi2V9CkOhQi0xuwY6Tsgy3bY8cYvlWTK91/gsWBagyVEM0sqF+BhPVvLUwAbxi1XhzI5wzyWY01YW1ldNUY2la+PYR4+7PGXLIipWr9dZvPC3Kjn9yjDR+At4g7s3bZBt6pSSd5hIsl307X7q1K5je7a99gWi96k4w9z3ymcFqaS8x3HZ+GufuWxGzEAPtuJg7Y8zXywxduZSRCJG0vrWmVxKeoLu0XczDWVtdxYsOEfNgxg50IJn3qjU+JeyziVvg8JWvUQ/ZLrXDDRM94iAH9y1zZalACN5Gnopc+0IdUJpnlIk8esnKKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAG7xKJQ6P2j2GblAKQzq4SaOB4XZuYJkIjcN+KmayI=;
 b=pgeJV0IafDjYf3QfVEZBHmAW5EgK/jcgirC/gxdtwuutNjeP6b8pgaRHJGw6yQnYr+g7M4/x15yZYAA3/Ii5kG5ZkicSThqhhUt3O5V/GKyBuaDHsPIwMP+18Db0/wIMVsgG+V6EQidBlpdz3kHVoNTBvHf0DolnNr5kXVKbkDw=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3247.namprd18.prod.outlook.com (10.255.237.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Thu, 23 Jan 2020 09:02:58 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 09:02:58 +0000
Received: from rric.localdomain (31.208.96.227) by HE1PR0902CA0010.eurprd09.prod.outlook.com (2603:10a6:3:e5::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Thu, 23 Jan 2020 09:02:57 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 05/10] EDAC/mc: Create new function edac_inc_csrow()
Thread-Topic: [PATCH v3 05/10] EDAC/mc: Create new function edac_inc_csrow()
Thread-Index: AQHV0cvolxqfD14+fEqOiiJDRId10g==
Date:   Thu, 23 Jan 2020 09:02:58 +0000
Message-ID: <20200123090210.26933-6-rrichter@marvell.com>
References: <20200123090210.26933-1-rrichter@marvell.com>
In-Reply-To: <20200123090210.26933-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0010.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::20) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fa5712e-309f-4518-eef2-08d79fe30aef
x-ms-traffictypediagnostic: MN2PR18MB3247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB32473225E6CF6C957ED3E7E1D90F0@MN2PR18MB3247.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(396003)(39850400004)(376002)(199004)(189003)(110136005)(66946007)(52116002)(6512007)(66476007)(66556008)(64756008)(66446008)(54906003)(478600001)(1076003)(5660300002)(956004)(2616005)(6486002)(6506007)(36756003)(2906002)(81156014)(8676002)(86362001)(26005)(81166006)(8936002)(71200400001)(4326008)(186003)(316002)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3247;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QSWDh65Gc70flpF2l0GEBXfqZ/M0asiXnnOEpGHRZ6iQ63f32qtZqY8mhrVKvIaQw/3QmoNYgikfUcQy0FfXrCMdO43p0mReINPMGfrNosIpIGIQXjAd4wwS9o07iJG/aCpPjwuvWMkCTLlS5UOy2KCvafYSk/W4xy4nyqg0uSWM909Q4UJMGUEHmHDCR6E+lD/OcwZdjrVgQPsgKtltGuNI3dEIO83r96ZQBcB1x5gQcxMo8/0DxXi6JCsDfuV6Fm85Q9Qvlqddr9iNPu0Uav/wTkx70V2nuY0tnTjiR3Z9tSfdlgK2mBZyccL35UkrCrId11gxvCqsxmOfYuKA0EG5PMHZplkSYdudHuriaiS6oMUY/Cb1TToNdXOGkz+YtSFWjpIZ+wYYZ0DIUz+HLOplvqdlN/Vw9mVTAWWWe1v4Wodje269NW3wFgQLepDK
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa5712e-309f-4518-eef2-08d79fe30aef
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 09:02:58.7712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JT0wjCUS04xnLmkc6u7dh6Fr10c8AOzDgjHgYyOhqkQKnuqUGnLCWhEprNA6wjdyVEGJ4CwVpQpSj2Q0Zykycw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3247
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-22_08:2020-01-22,2020-01-22 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Have a separate function to count errors in csrow/channel. This better
separates code and reduces the indentation level. No functional
changes.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Acked-by: Aristeu Rozanski <aris@redhat.com>
---
 drivers/edac/edac_mc.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 3c00c046acc9..e75cb7a9c454 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1091,6 +1091,26 @@ static void edac_ue_error(struct mem_ctl_info *mci,
 	edac_inc_ue_error(mci, enable_per_layer_report, pos, error_count);
 }
=20
+static void edac_inc_csrow(struct edac_raw_error_desc *e, int row, int cha=
n)
+{
+	struct mem_ctl_info *mci =3D error_desc_to_mci(e);
+	u16 count =3D e->error_count;
+	enum hw_event_mc_err_type type =3D e->type;
+
+	if (row < 0)
+		return;
+
+	edac_dbg(4, "csrow/channel to increment: (%d,%d)\n", row, chan);
+
+	if (type =3D=3D HW_EVENT_ERR_CORRECTED) {
+		mci->csrows[row]->ce_count +=3D count;
+		if (chan >=3D 0)
+			mci->csrows[row]->channels[chan]->ce_count +=3D count;
+	} else {
+		mci->csrows[row]->ue_count +=3D count;
+	}
+}
+
 void edac_raw_mc_handle_error(struct edac_raw_error_desc *e)
 {
 	struct mem_ctl_info *mci =3D error_desc_to_mci(e);
@@ -1258,22 +1278,12 @@ void edac_mc_handle_error(const enum hw_event_mc_er=
r_type type,
 			chan =3D -2;
 	}
=20
-	if (!e->enable_per_layer_report) {
+	if (!e->enable_per_layer_report)
 		strcpy(e->label, "any memory");
-	} else {
-		edac_dbg(4, "csrow/channel to increment: (%d,%d)\n", row, chan);
-		if (p =3D=3D e->label)
-			strcpy(e->label, "unknown memory");
-		if (type =3D=3D HW_EVENT_ERR_CORRECTED) {
-			if (row >=3D 0) {
-				mci->csrows[row]->ce_count +=3D error_count;
-				if (chan >=3D 0)
-					mci->csrows[row]->channels[chan]->ce_count +=3D error_count;
-			}
-		} else
-			if (row >=3D 0)
-				mci->csrows[row]->ue_count +=3D error_count;
-	}
+	else if (!*e->label)
+		strcpy(e->label, "unknown memory");
+
+	edac_inc_csrow(e, row, chan);
=20
 	/* Fill the RAM location data */
 	p =3D e->location;
--=20
2.20.1

