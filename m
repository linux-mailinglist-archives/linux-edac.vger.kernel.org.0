Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82515113E27
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2019 10:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfLEJiR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Dec 2019 04:38:17 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:40864 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729215AbfLEJiQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 Dec 2019 04:38:16 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB59bcUr023683;
        Thu, 5 Dec 2019 01:38:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=YYp/oOuA8n2lwLMoUuW95cJ2bKYWXJPqEGaTueCLunw=;
 b=ogsSB1JbFHKtODdhmck6Zioufmn6yFKdCLgvxOnheapgK1wPdXuTGQ0KnkM3EstnX7fg
 ax4CD66VFpNp6piuNrFHxkO3MD4jlJGgCzwPWb7yJx2jjthhKN6tGj206RYFrDiuweYA
 leH52mDE9KWuswTn55OORsj+CerGHkrg3NuqtroV0/VQWUbqggT4tfKTpXg3MJPSL/z1
 dnjs6Q+SyRVHFrZRDDXwTCBcUfdnfiw5UaJJaoEp8MNeaAPGje8Ts0KEqSYaR12FDX6Q
 3+njaxYq4937/zk7ZJZGpTurEYk3uwNH0IT80xENVGRMRwrMEzR0MDfrm9NUGjg/xw7G Zg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2wnvgvrd07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 05 Dec 2019 01:38:09 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 5 Dec
 2019 01:38:08 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.53) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 5 Dec 2019 01:38:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8b3zeab3mtCKRN/27zVycDX8MmJGuEpA/44E4Si3H56qkLpe0Ps6Yl7C9jeD8raITBaqN795O/Gu5jFv9FJmDmkAIp4b8xZ2I3dkHxswH8ataOniJLlbu59AnEf78JDz2e1Z4s6b+abVBE3w/y9TQh9JhgkhPTN14ChLK+rR137oIB9RJpZyogyHOPuvOraiUpiSDfUcbFwt+arKo6JDmnkbMnikUwAZ++qT/HxzwU97ph/aQYUYywYG055th3zhoMv1C9jrftqOz37mDDtI7OstRZXqnoatQOVc3pwxakZSyYVxkMKd+CBLGcedjCeIjwDH0AkkadELF2kvLHqwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYp/oOuA8n2lwLMoUuW95cJ2bKYWXJPqEGaTueCLunw=;
 b=VH1rQfBRvHtSSrP/57FKXGlk3PiCVdKD0dsG53LTk+fDSbZEYuEjwMp5uIA4taXZwPdQGmH5HgyhCquAJnnmu/3I2a6XELr1J0MuemKfOPvQaUCniYiCyCZoKQYnEK4VQh9FNFgp/AKd8cmvpZ7ReLBxPpQ8V4LPQ5fM3aKYcraId8ZrhVVTCvvAfDnB5ClZSgeN5DJYombxWHgvMtSGzguy+5UD+S6Qchc92WSHnEse0maFbC/tOW6RfkllSkemqzb1hK5h+nnQv1Q0K58eP5G2K2BIUsyQvNj9E63wN9aLtZX6cDjOdUAZSJclPPWIw4Xp4ODFHP/N08DqJxYanA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYp/oOuA8n2lwLMoUuW95cJ2bKYWXJPqEGaTueCLunw=;
 b=UVJaZ+KSY/8oBr0HPKHxzZBxTJ37cwTSt27JjzmkARvajtVCzrdDv/yMPNTpnQDz1gnk/gxEWgT3rJyCh+xPkmXEO1SOsSXx2Do2D36F2rWO2chifdRy4wqvBKluTNSpc68Dqq1SFs5fe1h89LfhI4Zb4zTj60Mj49rkHou+uXw=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2367.namprd18.prod.outlook.com (20.179.80.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Thu, 5 Dec 2019 09:38:06 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 09:38:06 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 05/10] EDAC/mc: Create new function edac_inc_csrow()
Thread-Topic: [PATCH v2 05/10] EDAC/mc: Create new function edac_inc_csrow()
Thread-Index: AQHVq0+yPgEeAv730k+GRrQq6PBK8w==
Date:   Thu, 5 Dec 2019 09:38:06 +0000
Message-ID: <20191205093739.4040-6-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 7c74e149-7baf-4487-c74f-08d77966d4eb
x-ms-traffictypediagnostic: MN2PR18MB2367:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB236701551EAEEB5CEBCCCA71D95C0@MN2PR18MB2367.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(189003)(199004)(81166006)(14454004)(36756003)(6512007)(316002)(478600001)(54906003)(5660300002)(110136005)(186003)(8936002)(50226002)(6486002)(26005)(99286004)(66556008)(66476007)(81156014)(71190400001)(86362001)(66946007)(66446008)(64756008)(25786009)(8676002)(2906002)(71200400001)(6506007)(4326008)(2616005)(11346002)(102836004)(305945005)(1076003)(76176011)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2367;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LtXIVR5zZJNBs4smPiuMLPb76PjgR1+MsIQTGYbhN3wFntR6HIFB23AXdUFtGpBKIzC9nhpxJCI7HGgqS8+DkySlYqBSZGJz2saTF8OdDbsqxCKKaYKmomXUQ3fSBdUmilLnezc045lqfp+GZ5ViP8ZMC+QDNVk4rjYXyOaIgejW3f3lN6sK2FnhYpkAfzxHYaRR6vjDcELGfX5nQP944uijSFZ0eJvHuSG7EoeWxboD3YSiboZJpF387DcOzIAKQRZSaZ3oZSovXxd5M9Wpi3/hmhSU3yUfVeuJ6LnWYybEOSZhmSTDIm1plpuqXXNueAWpIcH0rBfiAFpiFqkVNIkzp6ZZcAkY5/fsYxfEYcUFexPNobPwbxO30K1F40OcLQsclSXeDbwF9XToSf1HOzcbBPrO5rvXF2a5fztAQcwro9fM3B7mPQOq1ELW5I4A
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c74e149-7baf-4487-c74f-08d77966d4eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 09:38:06.3690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WJ+qbs5JTr7I3QczDHGYtwZ8/0+80418nPRIkigjfJL/XkqOgd2KaI4dn+OOOv3OL+HrvsYLWciECwOmRPz8ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2367
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_01:2019-12-04,2019-12-05 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Have a separate function to count errors in csrow/channel. This better
separates code and reduces the indentation level. No functional
changes.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/edac/edac_mc.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index aff0630c02fc..e81d33960a0c 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1089,6 +1089,26 @@ static void edac_ue_error(struct mem_ctl_info *mci,
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
@@ -1256,22 +1276,12 @@ void edac_mc_handle_error(const enum hw_event_mc_er=
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

