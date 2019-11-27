Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 718C210BFED
	for <lists+linux-edac@lfdr.de>; Wed, 27 Nov 2019 22:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfK0VzG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Nov 2019 16:55:06 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:54632 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727773AbfK0VzE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 27 Nov 2019 16:55:04 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARLo1gX005174;
        Wed, 27 Nov 2019 13:54:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=YYp/oOuA8n2lwLMoUuW95cJ2bKYWXJPqEGaTueCLunw=;
 b=kH0N/NCOcYLT4xJoD0VdVxYovCzmGtrsO/cP3BZIVubiM1Iv8WiyzeKOB2QJGfAZU2ga
 P9P/f2PthbCqokGAFegCXyxMy8J84AGiXGX3cM/FeZ0Wgraf2IZI0bdeaPp2pG8t+HtD
 HQYJMClIb3KYaY82THXUabbU2JnNfJboc4heTyIiJZmAo1xd/0K86LaAfsjeiUsvgDQ4
 YCDjRkRgVaBus3ahOSim5I95zrwTBQffs0vOQ8dSdE9BrdsiFxSa95VQJUVjRjvmUclN
 LTdQeFfPeLYBYx8lTecqWn2VHji6guuC054VfqEg8N18Yo2oQA0NCuB7qDUzW7ao5TyU wQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2whd08mrd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 13:54:57 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 27 Nov
 2019 13:54:56 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.57) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 27 Nov 2019 13:54:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpYa/4vA8sP2x2lU5vm53OBpPRHY6hftRWlc751TW8JKuUo242x0Yf7A/hnvnPSW2fE0M/z1M3TmXn2JqgumQ9G46IGzFqiIJkfVLlACUA3N0RwLWeLVdIk6YkQEaENLCj6vtqOpcQJUaMTZQzUyg+vEJ2NoY2yhmvPjxWLCDBm8lquyTvli+uBPWtfkE+ZKCv4HTfbdPOcS8CWoYNFI0e1V2gqNVIZ2uaJhVy5jNMkL5SuJJ7EX0atxoegg61AVJiwBLoBKsHtSWa6zXuuUmfQFVZt/0zTRZ+8AX51GwaQKJTjOavOvsiWs/6U1LHtEQs1VRme/pAhaEcKgis8pAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYp/oOuA8n2lwLMoUuW95cJ2bKYWXJPqEGaTueCLunw=;
 b=IuRslh2NYMcM6AXEmyKFw+dgLjqRM59a2R92cL9vFH6D4NEoDh1fdKCvl9dOpnDcEwQGMPXOGG7ZUbV/OlBwgsI7MuBb7B5HemAPxr547SMdE0OpKx204b30fzeexytb6ggRn+numFtO5myV3ZZHxXiXjKbn9/CPNutVAjCIHLC+RFw1IeMZZWFKdvQ36bjEB6i3MCxFkvedKVRCDCl2cBfrN91d2ZwiU/tnE3ULn4w0n8DU+coGeF1UzGC9ib/sAgWBcFM8Z4u55EXPl247Ir3Bmk8EEMJpkxBuxCb8z0BEzw2D99E1K4GiRtBVYwMyMEtPbhxMsgMPoRSoRm01vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYp/oOuA8n2lwLMoUuW95cJ2bKYWXJPqEGaTueCLunw=;
 b=sL69lhVBt10kE+xeTzjsiKCsaTjUi12FCxsVbliYBAryUfE64RqT216shD7z2wJ2huxSVkREG9DprjEqmwx7Vyi24m5GLvl4YB62N24totaCbETteJSiPYn2qknhvJoBjz+1FgxZC0ixRy8ph5IFWdFtPtE+ecQeW+3p+cai6Xw=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2477.namprd18.prod.outlook.com (20.179.81.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.22; Wed, 27 Nov 2019 21:54:55 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 21:54:55 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/10] EDAC/mc: Create new function edac_inc_csrow()
Thread-Topic: [PATCH 05/10] EDAC/mc: Create new function edac_inc_csrow()
Thread-Index: AQHVpW1Nlibqv9x5pUut5Ig9LljS+A==
Date:   Wed, 27 Nov 2019 21:54:54 +0000
Message-ID: <20191127215415.11230-6-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 33fafad8-0734-4c61-5cc3-08d773846fde
x-ms-traffictypediagnostic: MN2PR18MB2477:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB247761798A4FFA3C001C63EED9440@MN2PR18MB2477.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(189003)(199004)(14454004)(305945005)(110136005)(256004)(186003)(1076003)(4326008)(86362001)(11346002)(6436002)(8676002)(6486002)(81156014)(2906002)(81166006)(386003)(6512007)(478600001)(76176011)(54906003)(99286004)(52116002)(8936002)(25786009)(7736002)(66946007)(6116002)(26005)(316002)(66066001)(50226002)(36756003)(71190400001)(3846002)(66476007)(66556008)(64756008)(66446008)(71200400001)(102836004)(2616005)(6506007)(446003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2477;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z/BrNi42onYNJlmRnla2K25NAZYpcaNtcRP//2kJ57JT+xLjHUa9mLF65WYWC6egEXfIFyZGMMTXRIuaqMLGVq1dVkO/nTpDC9pdpN1O5iP1wepjiP9FM7SwpK72jI8tx+ZpaxQwbxPlfUTAwr0l2+Il463/O8HfYHpfwGprzSM7acQfre+UqgaXTgYO+lEAVM6DKhaHg/cuR1evE9piGPLC7AvOKXU7TC0OhGRY3QvZZcbfLaduqXhM4ppLoPPtwZGAQekQ9ZAH4hoceu/S6BhizrYjiFK6jWwtcaIve1EZw84YtYhR782h5tZD50tyWDGTYXVCRqLoxhZ6k2qnB/teufAZexKFdDrml+CKHssVj0bd/3pQuojbCUfDTARnMXtX6aY6to+bn1MLOw8lCToBFCqpI8RWazfCH2Um+51+f4Yh97cwpHuWMN/sLiUO
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fafad8-0734-4c61-5cc3-08d773846fde
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 21:54:54.8324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rBTC6XGTLtre6XWw8FBr33GiVpAcC5q1KEHLByOOVmcksg5S6xCR7mCcXaGQ2FxMK6UTFcYTTiWwHXEBsjbsZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2477
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_04:2019-11-27,2019-11-27 signatures=0
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

