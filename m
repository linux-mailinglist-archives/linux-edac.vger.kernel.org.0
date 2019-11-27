Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD0110BFE1
	for <lists+linux-edac@lfdr.de>; Wed, 27 Nov 2019 22:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfK0VzG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Nov 2019 16:55:06 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:60860 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727764AbfK0VzD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 27 Nov 2019 16:55:03 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARLnq0D005146;
        Wed, 27 Nov 2019 13:54:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=qV5qi/AfPq3EqFN41vakSlCrzeSPxB0+xglTrWS/iQs=;
 b=d/rMw82f0tiW93zfSD8G2aQoXunQVlKfsb/2wxSQJTfbL2doeGmpDGv0PJF+0Vvq+oLN
 T55R3F/S15bDHrYv5zfFIJjk17BW2XUrUWILVr5Y+5o1onmy4Vub7/9EJBRfc5En5FfT
 DVDRrHM/SRryoli8xhlAVScQP7B0PnIcYaf5baqhK1WfLgSImHN4k8e5x1xuTSLs/tj5
 SRX3jCsthQvyqAQQJ4C2t1y8qlv15VuiN2fjpoTZ+/5k7e9aty1hRKNmQciOLolfPdAR
 JhHEwXHn12wLginlmr75Xko/wAYNuMoarAgqDHjEbEeA9K57T6ZYqsi2F2cQ0lsvL4Wz /Q== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2whd08mrd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 13:54:55 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 27 Nov
 2019 13:54:54 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.55) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 27 Nov 2019 13:54:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAtLQ0HxshJmXHeyq03bI1zlKn+J8uboDGDcXLUZJDfbrUH4mo+yHn0TbJegwNPTE9iaw+LZYj1AOnyyvA5bPo4c7xOgyxFvmWBwb8iau+WzFA242QLTPF3BXtIe2ZIgPDGFTJ0QA1XwsYj7tGFZfiKIAbSLe4tUWg8ZS4YClLkeaXK7IPlRY4m/GVqLiYo9OBRQ5pEycX+CvDLmxykcLF1JaqNT2o6X9lGx1lIzNhsxUyW7cCLEAG5Pi6QFCWMyt4LjL0zBrGqbkZWiPPnM7lkn3HAuR0eWXdwsQp2b+XNp3r4NaOTyD6J6x5wQF2XYCenZwepscd+RVvZU4ZKRLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qV5qi/AfPq3EqFN41vakSlCrzeSPxB0+xglTrWS/iQs=;
 b=U5AeYhPjZyePIvix1d6fjTmF1qCMUQp/DEJrnpMTVeh1djEFkZRd18RPmBua/MQ/5ClW8jBDdP2IH3rlruwfJwX4zFlpQwW/aNOFAH0cnCZSVMV6hGtYjVwhOqu/7VWD5RQ20gJ25AKiqTWhR+p2rB7wHYZkyvkRhs6gWpovB8TZaWCMeWCwHln3vuIlSsL91KRpMPl+JtroY0vcU9vDcVmhwjeUK0EGGJijjCqQy7T6UpxPC4qaxO7lAIabR3tVKH0aNLKTcXFYpRdnxePmsKvXxcdLFMQLRITLhTOxBbcWBTiWuaiYtviaqIeYkmzJZN2QkDBExNXpVGXZclf5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qV5qi/AfPq3EqFN41vakSlCrzeSPxB0+xglTrWS/iQs=;
 b=CRgNgw+ZKHrF0isHrvakTfP/fffNmzBpeU1BejKcGpJrInT+DVYkj/JVXEh2LlCo9V2zrHHl7w35Wg0/YYNKZ57RMNf3+/ZoP4xMpRcHcCscSeZeB19nDWp3R4Sq8/LEXv5alB/N7i3D2U3PT001TIh9F0Rr6ab5ldat/PN7kYc=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2477.namprd18.prod.outlook.com (20.179.81.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.22; Wed, 27 Nov 2019 21:54:53 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 21:54:53 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Subject: [PATCH 04/10] EDAC/mc: Determine mci pointer from the error
 descriptor
Thread-Topic: [PATCH 04/10] EDAC/mc: Determine mci pointer from the error
 descriptor
Thread-Index: AQHVpW1MO7+hOyRLkUWGA+BbCNV3mw==
Date:   Wed, 27 Nov 2019 21:54:52 +0000
Message-ID: <20191127215415.11230-5-rrichter@marvell.com>
References: <20191127215415.11230-1-rrichter@marvell.com>
In-Reply-To: <20191127215415.11230-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::30) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b29edcb-87f4-471b-78c9-08d773846ea1
x-ms-traffictypediagnostic: MN2PR18MB2477:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2477C87CF2A2526FBDCE7645D9440@MN2PR18MB2477.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(189003)(199004)(14454004)(305945005)(110136005)(256004)(186003)(1076003)(4326008)(86362001)(11346002)(6436002)(14444005)(8676002)(6486002)(81156014)(2906002)(81166006)(386003)(6512007)(478600001)(76176011)(54906003)(99286004)(52116002)(8936002)(25786009)(7736002)(66946007)(6116002)(26005)(316002)(66066001)(50226002)(36756003)(71190400001)(3846002)(66476007)(66556008)(64756008)(66446008)(71200400001)(102836004)(2616005)(6506007)(446003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2477;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aNZzDIdHhflH7tNEFqs3Ix0mQvIrVMmHrlWT3IRR1DHNwJqVydNQdnw5ORLcS4kOn9ibd5xfepxn/WgIflmOQAcwkX/gPHvw6mRe2ryqwJw6NVuGQmtgF2CSX4LOCfA1TXhRT30ogopQtXModhdvPAFJ3znBUDAG5nI71q0qgnhVQX6BwSXRCUwO7Vdjd4uG5ebh4Exgu4y6Zv/aFOiL1602N2Z2pg/TEE/mu//Rzx0pUHElkSNnsToWEzu/fYcPs0hFYiu4rv/Y5aEqLzyb/WCequfL/Eablzx7dWjbTPD3AsAYABnUogJRump04vWqF606vPNkzOPB7us/tVhMTHwO9HjpYjx1JN/GgvYwmotCGtYIx4thS6DAASfOwHf6IixIxejvin2MSB0Js/ODv/iuiT5NB6zd//eJJmcZbtChG1SknP31Cnq3JlOeekgm
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b29edcb-87f4-471b-78c9-08d773846ea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 21:54:52.8995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nxt7eY3yMthUys7V/I4gpqO3FT8ARaCjssJ7o8CD611xCvRk9kV4gRqC4DUnf8yhrDcgLtwBX/cqi95tcVW/bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2477
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_04:2019-11-27,2019-11-27 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Each struct mci has its own error descriptor. Create a function
error_desc_to_mci() to determine the corresponding mci from an error
descriptor. This eases the parameter list of edac_raw_mc_handle_
error() as the mci pointer do not need to be passed any longer.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/edac/edac_mc.c   | 11 ++++++++---
 drivers/edac/edac_mc.h   |  4 +---
 drivers/edac/ghes_edac.c |  2 +-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index ecab08032b4a..aff0630c02fc 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -55,6 +55,11 @@ static LIST_HEAD(mc_devices);
  */
 static const char *edac_mc_owner;
=20
+static struct mem_ctl_info *error_desc_to_mci(struct edac_raw_error_desc *=
e)
+{
+	return container_of(e, struct mem_ctl_info, error_desc);
+}
+
 int edac_get_report_status(void)
 {
 	return edac_report;
@@ -1084,9 +1089,9 @@ static void edac_ue_error(struct mem_ctl_info *mci,
 	edac_inc_ue_error(mci, enable_per_layer_report, pos, error_count);
 }
=20
-void edac_raw_mc_handle_error(struct mem_ctl_info *mci,
-			      struct edac_raw_error_desc *e)
+void edac_raw_mc_handle_error(struct edac_raw_error_desc *e)
 {
+	struct mem_ctl_info *mci =3D error_desc_to_mci(e);
 	char detail[80];
 	int pos[EDAC_MAX_LAYERS] =3D { e->top_layer, e->mid_layer, e->low_layer }=
;
 	u8 grain_bits;
@@ -1282,6 +1287,6 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 	if (p > e->location)
 		*(p - 1) =3D '\0';
=20
-	edac_raw_mc_handle_error(mci, e);
+	edac_raw_mc_handle_error(e);
 }
 EXPORT_SYMBOL_GPL(edac_mc_handle_error);
diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
index 5d78be774f9e..881b00eadf7a 100644
--- a/drivers/edac/edac_mc.h
+++ b/drivers/edac/edac_mc.h
@@ -212,15 +212,13 @@ extern int edac_mc_find_csrow_by_page(struct mem_ctl_=
info *mci,
  * edac_raw_mc_handle_error() - Reports a memory event to userspace withou=
t
  *	doing anything to discover the error location.
  *
- * @mci:		a struct mem_ctl_info pointer
  * @e:			error description
  *
  * This raw function is used internally by edac_mc_handle_error(). It shou=
ld
  * only be called directly when the hardware error come directly from BIOS=
,
  * like in the case of APEI GHES driver.
  */
-void edac_raw_mc_handle_error(struct mem_ctl_info *mci,
-			      struct edac_raw_error_desc *e);
+void edac_raw_mc_handle_error(struct edac_raw_error_desc *e);
=20
 /**
  * edac_mc_handle_error() - Reports a memory event to userspace.
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 7c3e5264a41e..bef8a428c429 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -441,7 +441,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_se=
c_mem_err *mem_err)
 	if (p > pvt->other_detail)
 		*(p - 1) =3D '\0';
=20
-	edac_raw_mc_handle_error(mci, e);
+	edac_raw_mc_handle_error(e);
=20
 unlock:
 	spin_unlock_irqrestore(&ghes_lock, flags);
--=20
2.20.1

