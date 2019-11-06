Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1C73F1266
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 10:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfKFJdT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 04:33:19 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:42896 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727642AbfKFJdT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Nov 2019 04:33:19 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA69UIxI002503;
        Wed, 6 Nov 2019 01:33:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=aLaTuVZChfzcoBY6BX5AGWUoC40fMoccLj2A6AQxBNc=;
 b=I9Mt4UAUR0186E0dVwxThSbamnLtfqhSkHMjIWkF/oocaDJ8bD4D4btUZ5mFQfN1vca4
 P5/RtfgNaBjTWmVZCHTbJ+bEhGYglQJFJv/cwQu7tGtBk+5gSrHgIe2tsDIRW1Zp5f6V
 0mPBSGXUjH8gGBsXfFZTLEUklSlLpJTtl8KtQm0WKhASxVLYooUkhrRn/pzAiTPDtwlw
 LC7S2zVPtmWTInE+w0cmw0EtSUwngayYS7DqqerygF40jFURrQmvYegV9Yv/IAhuF+H8
 sYcKAFIBcZJzN4pKGz/ilDp1Q+IxOSHorgk6ZUEexFZCN5ymMUMbxIEZX+wGaB5Wxt2P bA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2w3eud3c6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 01:33:12 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 01:33:11 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.57) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Nov 2019 01:33:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPz2cbitsvDgyGZWm4NuLTbNregSZ8L1traQTRGow6k8CIGMoaUyHtl964IlHy95aKQ+l0vKaHY7IBSblG6KODPEObZXF7QqjfVK83IhHgL0QgOfazZawFCzmQN03jbva+dn+j5di0Zd3zKjuLrJaTPgHveT982vgj4Q1eucMLXa4IVtiBKZUElFzpefpdrCx3bkF4FeAzYJ2a8znCbhN51qZRTMhnZygbTi0yDAxcO+2Ir2pgvVQ+drpT5P/Rc14LoV99RgNc9ni8TCp8kVmD6xQG4Rmykqw96XtdHvmdCVZejlKde+FxWdgrNxkG0qx81ruY2dcntC3BDIjOHRQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLaTuVZChfzcoBY6BX5AGWUoC40fMoccLj2A6AQxBNc=;
 b=EXAWTgVVbOBXYE/1P0IPcgRmJj+pjlbYCbwDKGSuMJWVl2O8R2gcPl9twauiAG0esJ5C68dCBHtlJ+rKCSUWcmDSXtL0LwGj2EMAhLeRH58aOxxfjDIZJdBB20nuhRTmRERTUKWmeT+u8SCJ520mncV4zwWVPRnJ7fm95iakaSkrCj+HRH4WxidB5HUArrsGs2UpkFhd1ioTONaQBmHQyJ6atC7tzwSFQSu2zDoS3GdxDP02yvImkYf9652yoEsbuIt3XKwbZgzLlQ/BgxSmkLVnNP1k1LW4jTMuTgPo+1kPY8yj3lLVjetC+su4Zt2EHlrelVN885PE7vHwbX14xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLaTuVZChfzcoBY6BX5AGWUoC40fMoccLj2A6AQxBNc=;
 b=dmc/3sKoXCicSnuZL8pDy8AKSV7QtnCXZTK+HtWEt2xiGuSLKiuFHw3T1akUiICdB0c5ZVbDedT/buwomN/Pm2/7Q1Ntfv/xhVrldvBRYSlXAH/onwz+tnUVS3lElE/x5iDnrrA2OW9orQaGENQCdJM1htF0nbM7Svi31w421+U=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3165.namprd18.prod.outlook.com (10.255.236.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 09:33:09 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 09:33:09 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Subject: [PATCH v2 04/20] EDAC, mc: Do not BUG_ON() in edac_mc_alloc()
Thread-Topic: [PATCH v2 04/20] EDAC, mc: Do not BUG_ON() in edac_mc_alloc()
Thread-Index: AQHVlIUz7boQWMifeEOuGHD4/0UIaQ==
Date:   Wed, 6 Nov 2019 09:33:09 +0000
Message-ID: <20191106093239.25517-5-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: f1438922-e2cb-4ad7-3426-08d7629c55ee
x-ms-traffictypediagnostic: MN2PR18MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB316594AC69F8A49DD2BE5DCDD9790@MN2PR18MB3165.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(52116002)(305945005)(6486002)(4744005)(76176011)(71190400001)(71200400001)(256004)(11346002)(446003)(7736002)(14444005)(6436002)(4326008)(6512007)(66446008)(66556008)(66476007)(66946007)(64756008)(5660300002)(1076003)(476003)(6116002)(3846002)(110136005)(54906003)(36756003)(2906002)(8676002)(99286004)(81166006)(81156014)(316002)(8936002)(50226002)(486006)(6506007)(386003)(102836004)(66066001)(2616005)(86362001)(478600001)(25786009)(186003)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3165;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xuVTvOqnYvzCV+XioAJ+xN+YDGUvTYwZC+R+c/3Ar8oCl6B/A/roJV0xeqgqpV3aZ9kZutTy/QCCg3UTbbJm1q0zubA0Oh2NyGfCYEzj6Ma0dWnen65AZ6gF/s+YPVqZ/HFRBWjvIzEPlOU6YidfgUPCNuAxHaf0VQTMDQT9XR94RfTo+ymtH3e8ZCYK69nFEx1yFLWUBuKHNEaiEsVItBaciMGJ9wlVXJeChyBRA3KfguzbpR0QnviLfYFx7/Cbs1wfswN5li4ODIGlJEbVmIQp7yQHAHUXb4NIxAn2mt/Dc+PozE/vgZ+TZghgslVX7JYmdXYJ73d0FwQsDqc5eSS5XmiroNo+Al22P4Sbj+GFSSBFgxu3TUqWIZCBAqw6WfHVyD3AQ94l3CBEYwUABmN848OjvZ+LYxULkwcs2uDlNok1m13+2rgMUVzVN8cG
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f1438922-e2cb-4ad7-3426-08d7629c55ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:33:09.5707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LXgYLU15vqg8A+yCjGZ/0YkaZxEVmOhtX/hChHOgcmg9nTYacAQhj1O9vGE7FcrhO2wKeovsjQEABfiH2C2bCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3165
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

No need to crash the system in case edac_mc_alloc() is called with
invalid arguments, just warn and return. This would cause a checkpatch
warning when touching the code later, so just fix it.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/edac/edac_mc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index c5240bb4c6c0..f2cbca77bc50 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -323,7 +323,9 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
 	int i, j, row, chn, n, len;
 	bool per_rank =3D false;
=20
-	BUG_ON(n_layers > EDAC_MAX_LAYERS || n_layers =3D=3D 0);
+	if (WARN_ON(n_layers > EDAC_MAX_LAYERS || n_layers =3D=3D 0))
+		return NULL;
+
 	/*
 	 * Calculate the total amount of dimms and csrows/cschannels while
 	 * in the old API emulation mode
--=20
2.20.1

