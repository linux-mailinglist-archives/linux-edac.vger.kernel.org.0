Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82623F1263
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 10:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbfKFJdh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 04:33:37 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:16304 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731153AbfKFJdg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Nov 2019 04:33:36 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA69UVbg002968;
        Wed, 6 Nov 2019 01:33:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=XNb2IwKFs7xqhsbp0NuXTpSpc68SXycHhJlp2ERbujo=;
 b=FgEXFthCexwHIIp1scTCVAha+c3yBAV5nyC5zEX6kB289l6OE0drPC3EW5+8gslYaHyx
 fzQQF2ZzC79dSuub8Y+bygsaJDitpowWkHegCGjGS8dAHgb8tgzbm1I4887sqFK2/xJE
 rQYzj2Pk/9W/yQ8knJhHwR1sAXsyjSYxb8pIbOn0IKv/xq3RDey4mvzRLLZ0O51RBwJ6
 J/+j/spnyZjYsg6yRirUoMsuSGUuuyOpW3QrBj663PZKDiml+qppvy/6OI0r1nw92uR5
 D+LsqVi0/OK8xKvDvwk4DB5c06g6mpfcCe/lqv+qKHmd50tff0oy7LATj4MYRtLiVJ7f cA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2w3eud3c81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 01:33:27 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 01:33:27 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.51) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Nov 2019 01:33:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5sK0Df+xaYfZcf4FhqatRIgRX2jSSDWs6E/K2BR4Xw4hfZwUpoDsbfxo76VJOj4dz2EbH1cyM8Pla6EO8Lp/FD6iRO1ojmteBbw0qXIRX50U+NjosLi7bE67CU5zR6d1BhGiaNzc7eW0cG977qOOQeZfjigg+B/3/qfWUUOTSqDIUI2RYZBF822Vmi0WM1jAZ+UM0jvHDot1fZv3RSyW6I470WPXOkLzipLsobIYrgt76Zpc6YCVrqAcrcOY+CB+d9ij5uc+NIphy251mKqAlATO1WMrweMm46sSYggcc6i531C07laWzWIvrABMMw9f/rc4bVfJTFY6MZvIu8pLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNb2IwKFs7xqhsbp0NuXTpSpc68SXycHhJlp2ERbujo=;
 b=IK5VRB8iyfE6X8yQfGI1H0QcljGu8rHviLTJ3wFzauk6xouW3FUYkiFmZTfC96UY+JDF7O2cY+LmB/GB9a0z2QFFfvzthwxQU/0O+bULuI5Gl5H5oBQcyBVwBdwk44xBluHk1QyHo0o6a4rwMivUhTqsJtlZuY6u3lAeZUkTT5mgTo98oyXlaw+pxY0myYl3AOebPqujyo92zgLyil3r8JyPq8KI7LzChlIqDvUC8RUaTfKrMxDBtP/gHV+fGAhB0iQ+rEEoRCJ8uzKYg+BPp4FBZ4pvvBIa0ZLOILtpnez/TzE7kE/P9wHizsillHPLUCv27dubWajoY5sTe/6PJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNb2IwKFs7xqhsbp0NuXTpSpc68SXycHhJlp2ERbujo=;
 b=ws75bOz6aPGKQUC5XV0TJuNc4yXC88iMOMF8IgAnaW2rFEUGJaIRhKbhYuXUuYwcXnDT87Y7kjw1V+J3G6ZCPwDaTyhYoyVIoLxcHbXM4+EG0YeZApCGhkUX5tK9eURNc2YRNiFwxJBa8D7C/gpKXxQxbGhsTjUx3ubLpQncTTc=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3165.namprd18.prod.outlook.com (10.255.236.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 09:33:25 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 09:33:25 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Subject: [PATCH v2 11/20] EDAC, ghes: Remove intermediate buffer
 pvt->detail_location
Thread-Topic: [PATCH v2 11/20] EDAC, ghes: Remove intermediate buffer
 pvt->detail_location
Thread-Index: AQHVlIU9Dt1I/qDcNkGuWwAY2UMBUw==
Date:   Wed, 6 Nov 2019 09:33:25 +0000
Message-ID: <20191106093239.25517-12-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 4fb5ccb7-e30d-4777-11e1-08d7629c5f6b
x-ms-traffictypediagnostic: MN2PR18MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3165D08DCEAD9736BE57444BD9790@MN2PR18MB3165.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(52116002)(305945005)(6486002)(76176011)(71190400001)(71200400001)(256004)(11346002)(446003)(7736002)(6436002)(4326008)(6512007)(66446008)(66556008)(66476007)(66946007)(64756008)(5660300002)(1076003)(476003)(6116002)(3846002)(110136005)(54906003)(36756003)(2906002)(8676002)(99286004)(81166006)(81156014)(316002)(8936002)(50226002)(486006)(6506007)(386003)(102836004)(66066001)(2616005)(86362001)(478600001)(25786009)(186003)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3165;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EXz61B048kBzJpbX/gqMXeC6U5nRjX+HeojLds+uM0I2fuJsfE0CDKhbT8xl1RShJRvoCy6C541HAyB+0iHPDmittef6mbQanpWAsQfsw1pDZEF1QzSlzyQvmnNnxkfaPNqwClNl9rIS177EcflvPuS58rZ0IFRIx8MOm2tOyWAOVdqtXqfvM/09YLSfRS1fGFP8DDkrZFBDLTeEubHGwDhvzgyF/KAHdhA0L5lIQgaTmxPJiPrenSE2CVA7vqM8Hbpng9Iis+AFtbeLluXmbdTsbLdjQ9Bgac0SDhzOVvgQjxh7Oi5algqdU//6G3z4hz4EhK1ViaJE5mFzzviMbs3HOq0LeACtmfSnTNNaJsK5DZ+r/aJ2f3cc2s0L+8gt7KvZSvkL3g02bo/cZxtw/lEzrW2hUCwTfUQOH+q6oovD/w4TqwtLXCpWvaIebzSj
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb5ccb7-e30d-4777-11e1-08d7629c5f6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:33:25.4235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QsHobY5MBmoy7INThQGl505VAgLlaBia/LBRguQh4cyae0A4hWnvdjUqnHRLjr+yKBEMlIMoX9crZdhVG9QKxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3165
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

detail_location[] is used to collect two location strings so they can
be passed as one to trace_mc_event(). Instead of having an extra copy
step, assemble the location string in other_detail[] from the
beginning.

Using other_detail[] to call trace_mc_event() is now the same as in
edac_mc.c and code can be unified.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: James Morse <james.morse@arm.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/edac/ghes_edac.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 4acb456c20f7..cb1ab44361f0 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -21,8 +21,7 @@ struct ghes_edac_pvt {
 	struct mem_ctl_info *mci;
=20
 	/* Buffers for the error handling routine */
-	char detail_location[240];
-	char other_detail[160];
+	char other_detail[400];
 	char msg[80];
 };
=20
@@ -369,6 +368,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_se=
c_mem_err *mem_err)
=20
 	/* All other fields are mapped on e->other_detail */
 	p =3D pvt->other_detail;
+	p +=3D snprintf(p, sizeof(pvt->other_detail),
+		"APEI location: %s ", e->location);
 	if (mem_err->validation_bits & CPER_MEM_VALID_ERROR_STATUS) {
 		u64 status =3D mem_err->error_status;
=20
@@ -449,12 +450,10 @@ void ghes_edac_report_mem_error(int sev, struct cper_=
sec_mem_err *mem_err)
 	grain_bits =3D fls_long(e->grain - 1);
=20
 	/* Generate the trace event */
-	snprintf(pvt->detail_location, sizeof(pvt->detail_location),
-		 "APEI location: %s %s", e->location, e->other_detail);
 	trace_mc_event(type, e->msg, e->label, e->error_count,
 		       mci->mc_idx, e->top_layer, e->mid_layer, e->low_layer,
 		       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
-		       grain_bits, e->syndrome, pvt->detail_location);
+		       grain_bits, e->syndrome, e->other_detail);
=20
 	edac_raw_mc_handle_error(type, mci, e);
 unlock:
--=20
2.20.1

