Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8838D3209
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 22:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfJJU0J (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 16:26:09 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:24140 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727109AbfJJUZr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 16:25:47 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AKKdOx030238;
        Thu, 10 Oct 2019 13:25:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=37KlQ6M7K2AyFsprVrl8/ZezeqQSKv5uUXRqfWFTU90=;
 b=UnvrVwZzoN8eA7Insz6A35h5KI2C0dq5E1d1XwgJVTI39dGa9OodhkmZPjGLVgEF8UL4
 VvUPtO8nFfTtxDIyh4RumNuWFG2qmJ1Q517j9/JjRXFCvQE1eI+PX1tXswqs2koEDb1l
 7HdzOvRP1It5HLWA4YK4PrnH4UpeEbwWH7Cu049CenhQ4vcy0B4DCAoH0Uk658bcXDx7
 +aEHIXb5z+M7mXxqMh0gktjEJJDAp1wavspxzcQ2Fsmh9f5xQJiO9uQ5r5hg0ktkddCu
 Er+HC9AKEi6I4UUipn7GJHhKBgv61UOKhEfy4JERNesTSzQIEvcGSovPuuVEpTmlwSA1 Iw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vj66h1gde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 13:25:33 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 13:25:32 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.59) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 13:25:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBTPunldpWqdpsXmcnhpWSFHoZGaL9/p4uZbvVydg78BwDcki2BXV0Vn6vBk2Ahiws27HTKkGTyBsvu1m7rT5cxoUcPtlQY+POMq0FNHx2yjha1Caiz3Yd2YOQiumGL7fXnI945JzYxnzqWA8S0cCLApap6B1npfVPNmR4rMqVXzpH/lIzNWeLF1CgP6uOi9OySb6679M+B9B3g2jRSYBJVTDKGNaIl0sjtr4z6xsmQm4TxO/AEzAUHV6M40zsKYdb1nzRv4Hl4aCGhqVM0ioAnCYfwU6ZWepkFNP1dPc2UW1c3JzsgSDYvsTqapFW/1E56yZU1dTC1lxufzpbXgdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37KlQ6M7K2AyFsprVrl8/ZezeqQSKv5uUXRqfWFTU90=;
 b=lM+cbEgYEOmnAoUGd6+NUtrJ/gIakhsVO7AMOugs8AD/otDTSn5b2OMwfRts+n2h31DBoVRfrrdWjX2eQc1h3BYqFpA1hax1BGC/fsQMdfi+DI8tTnz3DLztipwDFsMwpXfl0DDeaeveUVcfUZvmMrxcp3LkcND6LeZqGtN+lbccUhgdyuxQLHhQ0f4cSUczpcwpVlQWfSowTaI5E4AwT/pTMp2xxYMKEjWCjXg/Lj7UreLuSnS2Z9EuchG7h57hgYSVx4WgMAqpMy1ZFfp0MpUaymo68mZDoJeCpZOvSfecYTKo4dfDIrYoMusEMvr2nWh9Aw2MJ7PMFCI4BpMtgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37KlQ6M7K2AyFsprVrl8/ZezeqQSKv5uUXRqfWFTU90=;
 b=vhjewxGyo05j1JBaD1kRntD09K9t9Rm52flF5rpSrc5QcxU2QAMops16uv+QLu+Z5dVGyQc+Bv1bTf0Gmb/JW98MbH7Toe0UL3tXdCQiluF+qV7CxYYTaAotUH/brTdtjm51FcFr3CBory+vCKzAEgSdn97Tg918witm6N2J5hA=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2447.namprd18.prod.outlook.com (20.179.82.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 20:25:31 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 20:25:31 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 13/19] EDAC, mc: Determine mci pointer from the error
 descriptor
Thread-Topic: [PATCH 13/19] EDAC, mc: Determine mci pointer from the error
 descriptor
Thread-Index: AQHVf6jcZfW9FXTSyEObM2Ya6k8l+g==
Date:   Thu, 10 Oct 2019 20:25:31 +0000
Message-ID: <20191010202418.25098-14-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
In-Reply-To: <20191010202418.25098-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0336.eurprd05.prod.outlook.com
 (2603:10a6:7:92::31) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27781cbd-de3b-4efe-e67f-08d74dbfff2b
x-ms-traffictypediagnostic: MN2PR18MB2447:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB244746C61D42D8387A7CC83CD9940@MN2PR18MB2447.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(199004)(189003)(6512007)(476003)(8936002)(25786009)(50226002)(8676002)(81156014)(81166006)(14444005)(7736002)(305945005)(256004)(486006)(14454004)(2616005)(6436002)(86362001)(66066001)(36756003)(66946007)(66476007)(66556008)(64756008)(66446008)(11346002)(446003)(71190400001)(71200400001)(6486002)(186003)(478600001)(5660300002)(386003)(316002)(3846002)(26005)(4326008)(6116002)(2906002)(52116002)(76176011)(99286004)(54906003)(110136005)(6506007)(102836004)(1076003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2447;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YrVGPezFiK2bAwvQmLgjdZCXfFGXYopv57kMSh9cKPrJHUtvZg9QHXGavLqDlP13RH1IJcnGXT24IjuFY66YCXpaVKbAkc1vjZeebMcs1keNZw6etY2zYBY7eWx0NT/GoYa5TwyaqKH9+mTONQDPZ90kSscROeVgJLMBnawLijaYoFcSgirICd57IBH+HGRCIzltzalGHyFCB5nEc7dlj9rlaZfOLFztkuKXygL27vYfvGi+2/6ZHOwDW0P4t9IvHS4+Av6RHGXHldJ/gx4K67ZaBE+BkhUWCFZ0G+IHXQaR3ibk21pg9tqI8WpE/ZAOOT1Lq6mpQitMDr5yw5d2WfQLCLLJrQ88mVAEvvltSBzuZWmWmlJiUc017xJ/+gxxJhaaUV6aXRsCb4M50jNBtwDlj9SKhezSpI6PWgmFOoY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 27781cbd-de3b-4efe-e67f-08d74dbfff2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 20:25:31.2933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VTYernBCFJ7XO2YJmVLrywjo1W0zrJfdNnwkwd7QPkcwOdMMfh4A5IZjTd29ecL4F5GcGTak1xrw+KFcuR7wjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2447
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_07:2019-10-10,2019-10-10 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Each struct mci has its own error descriptor. Create a function
error_desc_to_mci() to determine the corresponding mci from an error
descriptor. This eases the parameter list of edac_raw_mc_handle_
error() as the mci pointer do not need to be passed any longer.

While at it, reorder parameters of edac_raw_mc_handle_error().

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c   | 13 +++++++++----
 drivers/edac/edac_mc.h   |  8 +++-----
 drivers/edac/ghes_edac.c |  2 +-
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index ca206854b8ee..9e8c5716a8c0 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1040,10 +1040,15 @@ static void edac_ue_error(struct mem_ctl_info *mci,
 	edac_inc_ue_error(mci, dimm, error_count);
 }
=20
-void edac_raw_mc_handle_error(struct mem_ctl_info *mci,
-			      struct dimm_info *dimm,
-			      struct edac_raw_error_desc *e)
+static struct mem_ctl_info *error_desc_to_mci(struct edac_raw_error_desc *=
e)
+{
+	return container_of(e, struct mem_ctl_info, error_desc);
+}
+
+void edac_raw_mc_handle_error(struct edac_raw_error_desc *e,
+			      struct dimm_info *dimm)
 {
+	struct mem_ctl_info *mci =3D error_desc_to_mci(e);
 	char detail[80];
=20
 	/* Memory type dependent details about the error */
@@ -1243,6 +1248,6 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
=20
 	dimm =3D edac_get_dimm(mci, top_layer, mid_layer, low_layer);
=20
-	edac_raw_mc_handle_error(mci, dimm, e);
+	edac_raw_mc_handle_error(e, dimm);
 }
 EXPORT_SYMBOL_GPL(edac_mc_handle_error);
diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
index a8f1b5b5e873..3b01d5d9d7bc 100644
--- a/drivers/edac/edac_mc.h
+++ b/drivers/edac/edac_mc.h
@@ -212,17 +212,15 @@ extern int edac_mc_find_csrow_by_page(struct mem_ctl_=
info *mci,
  * edac_raw_mc_handle_error() - Reports a memory event to userspace withou=
t
  *	doing anything to discover the error location.
  *
- * @mci:		a struct mem_ctl_info pointer
- * @dimm:		a struct dimm_info pointer
  * @e:			error description
+ * @dimm:		a struct dimm_info pointer
  *
  * This raw function is used internally by edac_mc_handle_error(). It shou=
ld
  * only be called directly when the hardware error come directly from BIOS=
,
  * like in the case of APEI GHES driver.
  */
-void edac_raw_mc_handle_error(struct mem_ctl_info *mci,
-			      struct dimm_info *dimm,
-			      struct edac_raw_error_desc *e);
+void edac_raw_mc_handle_error(struct edac_raw_error_desc *e,
+			      struct dimm_info *dimm);
=20
 /**
  * edac_mc_handle_error() - Reports a memory event to userspace.
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 1db1c012bed9..8078d4ec9631 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -439,7 +439,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_se=
c_mem_err *mem_err)
=20
 	dimm =3D edac_get_dimm_by_index(mci, e->top_layer);
=20
-	edac_raw_mc_handle_error(mci, dimm, e);
+	edac_raw_mc_handle_error(e, dimm);
=20
 	spin_unlock_irqrestore(&ghes_lock, flags);
 }
--=20
2.20.1

