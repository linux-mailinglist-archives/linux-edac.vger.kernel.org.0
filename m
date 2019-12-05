Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26591113E3D
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2019 10:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfLEJiT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Dec 2019 04:38:19 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:48538 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729215AbfLEJiS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 Dec 2019 04:38:18 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB59avmA023516;
        Thu, 5 Dec 2019 01:38:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=qV5qi/AfPq3EqFN41vakSlCrzeSPxB0+xglTrWS/iQs=;
 b=lXrWYKGvdE9ig6V7LzcukY41pezWrLxUH2a2piyC+DKyx7IE98QyTkA3tmOSpTBTO29r
 Nsbgk8QBSQA/X+3Vxf1OUr+i1qbYFVHY8MAsOp9V9GT+lLLjGEchA4e07A0glRSTHdPP
 InQHOp+3h6VUF1yNxyhFo4fvY3zB5Uu/A0dKq5f0V2f9eXedAYH4/rQS+c9uRYLvie5S
 gvyF6aFLWspfeS4INWlX1mK17GlDfYYyfS9499HCV4DR7Avep7Jd7ydpgCAo3kJz9cFL
 t7zcJCCd1JmtI8jUIwYaj8AwqiLWN0O21AzTnWSZII14mZScsgtCbI2oTEONQ6bt3D3z BQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2wnvgvrd03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 05 Dec 2019 01:38:06 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 5 Dec
 2019 01:38:05 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.54) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 5 Dec 2019 01:38:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbKfMnvDKtspl1kxUjT739vrfUhwG4sw9TRVshDoYC2orffJUly90PvBXMNXpHVk2BW/It5RHldlJkRq1XKVKCRfKKa7s9639AwDBHimmNS5X5s0QgNhIUDpLOIbPr73I0L0B+iv0O0sdnTa2whe7TCbHz/frjlCepqVEUdtI5lk0QWd6mw14mMrQxWYMaHDMg5hwHDBBXrMJy5KgzXpsz3ZQYTCxy5g9L6FwEaGYmWzEjZFcxPGijz44lNlwGQwnPI++f/ZYJvuUDlLgBz1gPSXpEFdq64vIuGn+f1HX8TbcNAPeeJPjyzkSkHE2Rxif/JnlZ/AvfgcFBC22nWO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qV5qi/AfPq3EqFN41vakSlCrzeSPxB0+xglTrWS/iQs=;
 b=nXFDjEwUaTA7YyfuvzEnCz2Ls+qyGLgDjom9sPUfsBnHWACX9RePPYUEhfAbYarBwwXcsnx8VFpzJhZh+nQjJsRa6Bq0HaWQHTzSJJWU7qdB9XbKNlPOq/F/9o3iAOYawwcAuVrOcqyqNt8GYwNYrXn6/65NiVNLYnPTton5H/8r6B1fJa9SicCllHj05dCRLFt6gBVds88fwQm7oOJUiUb02RShvSo5SUs54WamDVN0yuTzHhONMkBj0fr4cPiwKb5QWBIJiQ2m+o+aMxf1UwXJSesgLbVA0UtozrQrB6Jp9hzuioAxXCefs3k8nHGIP2ilkhazGL47AzNqtexqCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qV5qi/AfPq3EqFN41vakSlCrzeSPxB0+xglTrWS/iQs=;
 b=roDuDoLYRfnzIrKCH305mI6NX2aPc2X6c4KdpMP1bhyVsF5girve/RnRz0Lx+WEdUHQCKpzNgJglRpzqLTYOhStcXpR3m0FqtLvLERjd5MvKumev2Uu/O7IuYg2Nkih2wU1tyO5tADQBzCX04oGyV9h6anzVhS8n9UVme5kA0ok=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2367.namprd18.prod.outlook.com (20.179.80.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Thu, 5 Dec 2019 09:38:04 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 09:38:04 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Subject: [PATCH v2 04/10] EDAC/mc: Determine mci pointer from the error
 descriptor
Thread-Topic: [PATCH v2 04/10] EDAC/mc: Determine mci pointer from the error
 descriptor
Thread-Index: AQHVq0+xb1CUUMWr+UmUY/kup7ElpA==
Date:   Thu, 5 Dec 2019 09:38:04 +0000
Message-ID: <20191205093739.4040-5-rrichter@marvell.com>
References: <20191205093739.4040-1-rrichter@marvell.com>
In-Reply-To: <20191205093739.4040-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0170.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::18) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45551063-58ed-4b20-cec4-08d77966d3c8
x-ms-traffictypediagnostic: MN2PR18MB2367:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB236705501FC6E0D00C32C2AAD95C0@MN2PR18MB2367.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(189003)(199004)(81166006)(14444005)(14454004)(36756003)(6512007)(316002)(478600001)(54906003)(5660300002)(110136005)(186003)(8936002)(50226002)(6486002)(26005)(99286004)(66556008)(66476007)(81156014)(71190400001)(86362001)(66946007)(66446008)(64756008)(25786009)(8676002)(2906002)(71200400001)(6506007)(4326008)(2616005)(11346002)(102836004)(305945005)(1076003)(76176011)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2367;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TyDrnfzeF29z4NnAZK9AhoM3a7bGZMRSbdeSVcZSk0yjtBMNsoLjEdI7Yq4MQxqHy6HKhnmi2NNVqfZmbgw+ZSwKvRlXqiAd5a5kEtigSs5iJUysurPyx2z8d7mxlcdzYQu64CbfsHDdH5wWIrgUyXAIkERQDpY4JhHuaHqhDX+lqVwGI9vh6NmH5zvrvZA5LzaTKAzidlWynRsQ/HTVF8y8XxGYP5R9mYgah4oHwKfJ16CvVvwIw05pIgTyjF+aSLClhVWNaDMpVNS43PCdHOZlZGdP4cYWTGSdDD0wLnQcOaC4hV0xEuSfoxM7/7d14XD3IQHnkcyhphYvioGaPSFpVbbQvCSoK2evRKbdYRNn2VEt1+vVqbZBuVq3DE6TptfufVxsB2p0D+ojmgkwvmugenNtVJRzDl4H68p5NkxVrUp9ySukxpcJ5iS6Sneq
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 45551063-58ed-4b20-cec4-08d77966d3c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 09:38:04.5231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tisSjB4d+dETnl2r0Hx4UP7tJYB974sIZ2Zk/rkINXjSTHpc6/mlLHqsC4E90Qha1H9Yr6uac856qJ3Juh6nvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2367
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_01:2019-12-04,2019-12-05 signatures=0
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

