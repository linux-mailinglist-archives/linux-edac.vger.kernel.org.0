Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84A70D3202
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 22:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfJJUZz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 16:25:55 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:56146 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727125AbfJJUZy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 16:25:54 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AKKSTR030199;
        Thu, 10 Oct 2019 13:25:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=f1hs/py0Rr0nPNiJS554yy0yr11bWlffRM0typKOO2c=;
 b=x0ad6Cmm1L+HnbgjsD9VmK1DZnE4hFN9eMZOZfdRPB8s5O/2W2dJplcnZpIKfKNBsvYA
 dU/2VgmRRSrX2NK8Ch+hXTZ4WfhL1OOjQyp29hKdPk+voRYO7jpY/uA2xtqyfUFs6vzM
 5HZPBnfPpNP1P+FrtWS5kokoKCylgfpN2hGE7TXZMnquH1LSR6Jjp6WnPPut8HD59A6T
 Z9EwTZH0xaV84koG+cA/jEKfjw6D8LHk+kxe0F05YR6RAVqSjf//Dpk2wnCnZVHZUc5i
 dtcP8EKTotv6TFx+M7u/fzb/qnQywo36gXxQdKt0ULnMXu2bsoc9MosX23PgqKXlmA1r Fw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vj66h1gds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 13:25:43 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 13:25:42 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.50) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 13:25:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmYcZTty8KuWv4jntJy95avORcE5Mkofk0TVqu2nx4lUIMtTUrF8mrUK32lRdb7c18t2gzKtXJ5wmCJnCkfRUUu5qPnnlp6R5PmigrXj6/f5YFVOpObFVgCctctKsN355pBCg0doDdp5DJ8z3rhnqcvi7wDOgzM5NFVz1TBSRonVkN68o5TkePwvj9/+xjU8gT81+cmUZKMAO4e3alNnPcjhFOEGBHaei4WWdk+q4Y9Mm4RY2ne5D3FOEql7AEwukvGlig6xLHFrlBPt+ajNJfVazzzVE19rFiD+JHYniaD7n7DGXgRu+aEZz8gVqqCITHyMA7hHcXjR5GqhIazA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1hs/py0Rr0nPNiJS554yy0yr11bWlffRM0typKOO2c=;
 b=SlBYPlFtFZw/QHms6i7mLWKhONmVSwgfFxsadU5Rpgm7874i9AGSFCN1K7RQMkJ64gbftn46mEb0eJ5Ep0QecxHcaJJ95WSivuMgSvxwPUzxPtdJJ9XP/NAd45+5E5VxE1EYaHrnLpPb0Z3iZTaC7rKhPRHZCdLKJjRaMn7crAc4+viXjiZdAO3I8/LllzZttqB/N2dwBflDGAuZ2sFCXuCMn12OnmkJB9GrNLmk45MkmZfZ5+6UyrN1Zc9AClNOGUXPaKHZuVZR1hJrEWYiJVebowzL69tNi8iNPOF0kUP8qSVa7jvO7+iIspboeRGHV57iB8x0+Yr62i7947cG5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1hs/py0Rr0nPNiJS554yy0yr11bWlffRM0typKOO2c=;
 b=F7BdWps0PzJ4Z7ivbtCp7TF9BPy3OiSAzQk5ulK9FdAcFor4lL6U0NXKNt+dEpw1vB5PvYNLAr0osITLgeeSCbMXRAqVvMxeFs47mav2kDrh1T1AIS+rqgaiYJBQFyQ/M1g9BPxuuyxabqr+MrENb1SvIQOr518iCX50GLDBkXY=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2447.namprd18.prod.outlook.com (20.179.82.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 20:25:41 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 20:25:40 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 18/19] EDAC, ghes: Unify trace_mc_event() code with edac_mc
 driver
Thread-Topic: [PATCH 18/19] EDAC, ghes: Unify trace_mc_event() code with
 edac_mc driver
Thread-Index: AQHVf6jiLfe0RSKsj0ycB1JaM2TD/g==
Date:   Thu, 10 Oct 2019 20:25:40 +0000
Message-ID: <20191010202418.25098-19-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: ba646771-7db3-4ae2-8203-08d74dc004dd
x-ms-traffictypediagnostic: MN2PR18MB2447:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2447FEDA1CF2127EBB7ED2E3D9940@MN2PR18MB2447.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(199004)(189003)(6512007)(476003)(8936002)(25786009)(50226002)(8676002)(81156014)(81166006)(7736002)(305945005)(256004)(486006)(14454004)(2616005)(6436002)(86362001)(66066001)(36756003)(66946007)(66476007)(66556008)(64756008)(66446008)(11346002)(446003)(71190400001)(71200400001)(6486002)(186003)(478600001)(5660300002)(386003)(316002)(3846002)(26005)(4326008)(6116002)(2906002)(52116002)(76176011)(99286004)(54906003)(110136005)(6506007)(102836004)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2447;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BkTUYb53fLqcsfmqxhiylgOWqGfLlvlOxoIic/utC6d/Cuvm8wPnqCdiPXBzXnsvczO3BWuqh6YRjSAf9RzUBehubfLJyEwBc14rccgP8219tVF7hHsLDHWBYIGJVsSYnfkidXW1kDnlhM/OdBHDOLCXo1EOWK5ktBbpCn2rzgxz4ZS2FdFP4zzfRBf+eKcygRkED508+4REN3lozkNl/VplsnCg1HOCHXJH8llEXQrjm4Lbes19DsDe66hANvbICM72p3nvC3kdrdOOwaqSg8r8353uf9SrMJf8HMZXd1nLVRx+z45AvIL2kgOOpsYqrRNWAEQoquQSt2pBEx4ZULNK1Ti1yuWreRN3sGi7m/SH/9+3FVdcL0/UjC9gEqxSPGpo0nQAh9APxJnHYpJcUzMJBfcbiBVyJQQLA2DWZsk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ba646771-7db3-4ae2-8203-08d74dc004dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 20:25:40.8828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /rhUAvkCsLOB1TCOWACuKtvx285MOliKpY00yes4SgsxToIwmxqA9YgiSAfSmXxr/QltbqReTzAVEV5NaU+6Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2447
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_07:2019-10-10,2019-10-10 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The code in ghes_edac.c and edac_mc.c for grain_bits calculation and
calling trace_mc_event() is now the same. Move it to a single location
in edac_raw_mc_handle_error().

The only difference is the missing IS_ENABLED(CONFIG_RAS) switch, but
this is needed for ghes too.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c   | 30 +++++++++++++++---------------
 drivers/edac/ghes_edac.c | 13 -------------
 2 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 3779204c0e21..e6c6e40dc760 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1070,6 +1070,21 @@ void edac_raw_mc_handle_error(struct edac_raw_error_=
desc *e,
 {
 	struct mem_ctl_info *mci =3D error_desc_to_mci(e);
 	char detail[80];
+	u8 grain_bits;
+
+	/* Sanity-check driver-supplied grain value. */
+	if (WARN_ON_ONCE(!e->grain))
+		e->grain =3D 1;
+
+	grain_bits =3D fls_long(e->grain - 1);
+
+	/* Report the error via the trace interface */
+	if (IS_ENABLED(CONFIG_RAS))
+		trace_mc_event(e->type, e->msg, e->label, e->error_count,
+			       mci->mc_idx, e->top_layer, e->mid_layer,
+			       e->low_layer,
+			       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
+			       grain_bits, e->syndrome, e->other_detail);
=20
 	/* Memory type dependent details about the error */
 	if (e->type =3D=3D HW_EVENT_ERR_CORRECTED) {
@@ -1110,7 +1125,6 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 	int row =3D -1, chan =3D -1;
 	int pos[EDAC_MAX_LAYERS] =3D { top_layer, mid_layer, low_layer };
 	int i, n_labels =3D 0;
-	u8 grain_bits;
 	struct edac_raw_error_desc *e =3D &mci->error_desc;
 	bool any_memory =3D true;
=20
@@ -1242,20 +1256,6 @@ void edac_mc_handle_error(const enum hw_event_mc_err=
_type type,
 	if (p > e->location)
 		*(p - 1) =3D '\0';
=20
-	/* Sanity-check driver-supplied grain value. */
-	if (WARN_ON_ONCE(!e->grain))
-		e->grain =3D 1;
-
-	grain_bits =3D fls_long(e->grain - 1);
-
-	/* Report the error via the trace interface */
-	if (IS_ENABLED(CONFIG_RAS))
-		trace_mc_event(type, e->msg, e->label, e->error_count,
-			       mci->mc_idx, e->top_layer, e->mid_layer,
-			       e->low_layer,
-			       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
-			       grain_bits, e->syndrome, e->other_detail);
-
 	dimm =3D edac_get_dimm(mci, top_layer, mid_layer, low_layer);
=20
 	edac_raw_mc_handle_error(e, dimm);
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 8d9d3c4dbebb..17d5b22fe000 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -198,7 +198,6 @@ void ghes_edac_report_mem_error(int sev, struct cper_se=
c_mem_err *mem_err)
 	struct ghes_edac_pvt *pvt =3D ghes_pvt;
 	unsigned long flags;
 	char *p;
-	u8 grain_bits;
=20
 	if (!pvt)
 		return;
@@ -430,18 +429,6 @@ void ghes_edac_report_mem_error(int sev, struct cper_s=
ec_mem_err *mem_err)
 	if (p > pvt->other_detail)
 		*(p - 1) =3D '\0';
=20
-	/* Sanity-check driver-supplied grain value. */
-	if (WARN_ON_ONCE(!e->grain))
-		e->grain =3D 1;
-
-	grain_bits =3D fls_long(e->grain - 1);
-
-	/* Generate the trace event */
-	trace_mc_event(e->type, e->msg, e->label, e->error_count,
-		       mci->mc_idx, e->top_layer, e->mid_layer, e->low_layer,
-		       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
-		       grain_bits, e->syndrome, e->other_detail);
-
 	dimm =3D edac_get_dimm_by_index(mci, e->top_layer);
=20
 	edac_raw_mc_handle_error(e, dimm);
--=20
2.20.1

