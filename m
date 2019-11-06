Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03BE6F1255
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 10:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731376AbfKFJeC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 04:34:02 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:26518 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731828AbfKFJeB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Nov 2019 04:34:01 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA69UNGS002538;
        Wed, 6 Nov 2019 01:33:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=9QP7d/lmwnUxc7oeYSJ5iMXeE5CRY3AYoKh3V02Cfrc=;
 b=iLTFBOSUeQK/hUhVMwxm7f1fnhWya7i1g+7yKelx0JA7SdgSEFjbXisr27aBpsir2K3F
 zbdVUAErt1jaVHs8XV4Wf190JL0JEQo62hntf0s7KzGFzXYzBYobIswRImWBtahvlfBn
 M7fwJPqRKwh93KbRODdB2rrUOMRITn3PYMPIfQfxdxKlCqjMxmUdz9xyi0q/cFrPADIt
 NdSt8GqjsutR5YoefQzdIVqicMCZfQWcRAo+R76njFMy7KSDotX7FOMtqgtQft1VUt3Q
 DhgS+gNW8nbR+Q1VLv90b6N7Thsif68aOE1IUmAOQ3ET/L9guaSw+CQiZ1kpAmiOStX+ tQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2w3eud3ca9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 01:33:49 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 01:33:49 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.52) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Nov 2019 01:33:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSoYEj+YW1nA7SAFHmMTE32/S2E0AeYO8Da9PJb6gtaxogAhTLMcLRaqziMmBviBlr5PDO+lcbjR4gLt+uB/RwubiC0fhHyelCt0NJkbMqzn1qnH7XjOBA2ulUYWHn1+VzFJxgLux/ZuWS89DU++fgZtV06rgzJz4CRiSPepOoGMgKnNADgTpJFwkuNW7cWgMk9aYTn73iYYWkn2vxCk1QPsd3w7WRLm6RGQMI3nnPHrDoth5TXCfHRsces/Q60sA/XojD06pWvw1NxMDc5eZXMW3Cd08qY5eIKqZ0ZyUw92a8ObF7QABSZpbxjgqeiIQ/mvZGdxxzZ2c/s2GA1aLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QP7d/lmwnUxc7oeYSJ5iMXeE5CRY3AYoKh3V02Cfrc=;
 b=dSYwmUOjam2+Y19kDSQFuX6yl4eU3kyHJ/AIsj982W39hsgPyiYqx/plhu6VgwDt3Ro1/ph01EuwsINtzQ6RXHFLwMGtW3/Bvovj8yeY6rZkv/LZP9h9Nn5RnY97XroVipC4NH62FZAXIqf5wCDfniNcxno3Loz00o8pZD5tuvfB+Nj2GXZedffqzQp1FmZHG3AL0fIrNUyPX/gvxCnwm8DJJq4fmxzbUXmgrCFYuFualgflAtOzktE5s4boogDquLDgNyuoXsMKzRr4vhe1qccXII4lDnnmNN7C+PZ0ZD6yMYm8bseV6IM4bcKuJKv8esLQpSsusZ5PUbjDXhAgbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QP7d/lmwnUxc7oeYSJ5iMXeE5CRY3AYoKh3V02Cfrc=;
 b=Bd+U0sNcsm5GNoLMg1pYTeMqXMqPVAHb2TH6hteJQYX3GzJ9rxyPg6VKPiwmFIysK3Y6BmiMP/fQxDIF2MzzjuGNCI2gbiLzVx8/lllJPvc2AkVOVa2JShTOpCGw1IVbte4Rto3AX025Dp9Y8x6ltFXBso1vABiK5lJjEqHuAok=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3165.namprd18.prod.outlook.com (10.255.236.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 09:33:46 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 09:33:46 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 20/20] EDAC, mc: Create new function edac_inc_csrow()
Thread-Topic: [PATCH v2 20/20] EDAC, mc: Create new function edac_inc_csrow()
Thread-Index: AQHVlIVJ7cGmjRflEUeKcnOp2bmQgA==
Date:   Wed, 6 Nov 2019 09:33:46 +0000
Message-ID: <20191106093239.25517-21-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: b3e277f8-9c27-4fcb-fa82-08d7629c6be1
x-ms-traffictypediagnostic: MN2PR18MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3165F9F0F1571CD2AADC1552D9790@MN2PR18MB3165.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(52116002)(305945005)(6486002)(76176011)(71190400001)(71200400001)(256004)(11346002)(446003)(7736002)(6436002)(4326008)(6512007)(66446008)(66556008)(66476007)(66946007)(64756008)(5660300002)(1076003)(476003)(6116002)(3846002)(110136005)(54906003)(36756003)(2906002)(8676002)(99286004)(81166006)(81156014)(316002)(8936002)(50226002)(486006)(6506007)(386003)(102836004)(66066001)(2616005)(86362001)(478600001)(25786009)(186003)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3165;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uE/ylMZt225LVrp6R7ymR2kZBRArqXUlSRPnsKcdaXYNBE/MyNy0GfzhaweTr69IovJ80+ya6RdT5dZUJTMoGckrZIwazqX3gUTySsqiger8J1Bq+fFgSrkp+4P7fv7V3TmH5qN/U2yyR5TPwoUepnmrgvKH2pNT4k8phCQ4Xd29sAflBpDhDZu07ed0T2gEerUGC3QrD2KS9E9YvIVwLKvCpzmIWt4HySK1AJElL8qWV12cpCaWqSHSsegPC0SaLak8WwEOPZGcoyAiYcABHGFuulyrqrTBckrO5flrq+VFTDsnNLdLcMWZ91BFf7Cs4Jet74baderz8BEqk/BBdWuS9oQ4TKHm1NbY0MhuFEB0NH01mOun31uVhxj1F0ujoOmBB3kXqYA1fii+oJaSB724ELmjCKkwZbNeyetogqQPSByAnDeW375231aQoFZ9
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e277f8-9c27-4fcb-fa82-08d7629c6be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:33:46.2545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1EzV1tVNnMZaR6Xy7odCv0jy7i9XU9xEAa+aFPk5O2fY5lX15oSuI914xFdUQd3GnArPEI27FC+Um+ruvUingA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3165
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Have a separate function to count errors in csrow/channel. This better
separates code and reduces the indentation level. No functional
changes.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 93eac968678e..34b740036ffc 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1045,6 +1045,26 @@ static struct mem_ctl_info *error_desc_to_mci(struct=
 edac_raw_error_desc *e)
 	return container_of(e, struct mem_ctl_info, error_desc);
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
 void edac_raw_mc_handle_error(struct edac_raw_error_desc *e,
 			      struct dimm_info *dimm)
 {
@@ -1214,22 +1234,12 @@ void edac_mc_handle_error(const enum hw_event_mc_er=
r_type type,
 			chan =3D -2;
 	}
=20
-	if (any_memory) {
+	if (any_memory)
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

