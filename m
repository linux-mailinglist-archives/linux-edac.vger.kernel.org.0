Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6361CF126C
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 10:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbfKFJda (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 04:33:30 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:39408 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731188AbfKFJd3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Nov 2019 04:33:29 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA69UVbe002968;
        Wed, 6 Nov 2019 01:33:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=xOZqgtBcg3LLHkIs2/DBb8m5Zq5RxLsNLKG8Sk18sZ4=;
 b=vRHIGQLiebjF7mTfb0KTcQgspgUA1Wzt3rn41uz4KEzDTH2G/NSX6dyvh/NDgXkHaMAk
 +3L+ZBXM55ObPATDnQi5UfFYP5Vc+sCgMIECJGUWZxdc/vv0Aj+waWJK6u814M6SYbOE
 7mr1EiKK3/Y7azHxViBrerg2s6/tz+ypXufii4kmbqD6uJM6UYnAtWfhT2mqAFnZJA7/
 04LAnzpbJdMLGnfaMAv6r9FejfTjNfJ1sp+n/hIgVeNn3MjfHa9MjELgmVsexAIP1ua+
 1k3TZmILmEvyNaQswMa22cqHd28u2FulFUuVjS6yh2pQlKMRLLVWr8M5MJ7c3XbKQWsZ dw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2w3eud3c6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 01:33:19 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 01:33:18 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.55) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Nov 2019 01:33:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PM0cPOVDXiv06V0vwyJjfKuS+pJIrcu0gUewnHAq09hFziq2NxJ9bLtE+dNupHFaNcvLY7mRTkGW6ntqu54Yz07Ziw4+S6Bz81zjKb/G7Hm6w1TOJEgsDWVQspvwy+4VdxQvMGofyRzyF1h/fiGTi/A6h1RDuThFK3CmYOb3I1MG7Rqowsk3aIuQcYbLPlyTL5xISdQgRITVbj0x5LjgnJKqIIWn4+I9xTB7w/Cf1ArTMZjoTwYfclL8kJjnsiXiBczmCyKTxk+F7R8bJA13Tc84t78R0D6P38SwBspPkdn2SZ9XSmsNS9gUdT/uYDD3btfq+RU1mvWo1eWnCB1Hzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOZqgtBcg3LLHkIs2/DBb8m5Zq5RxLsNLKG8Sk18sZ4=;
 b=bb4nM2hBFneRdl2/re6SO1ZIyMn5eiYJaEt3WOKbSCEPBiI+3B3AVNdHJliRgj0jrEZ2HNbHhjskoKNbnB+SoQc1cRdDIqj7ZZgKEC9exr2t8NYwEDpZQ71Bdj8oJ1aDiorA1r+I27bJmbz6bPC1zIa0H8Pw9ntJwE0f0LCoVC076h2xP7wO1w8YC6DVbfDfoUYx3ms6UywJqNZTVjIaV+ANWYL0q2/gxluHvzHyfQBtOqadtkmBzFXLWTTQ6G9pyd746rtgvncfHT4r0yBb4q53Djy5IQ0er1smjla2mwiMJP6HhkorHlDp6T+01Ulvn8bwE1idbT5MHwwoQHZSoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOZqgtBcg3LLHkIs2/DBb8m5Zq5RxLsNLKG8Sk18sZ4=;
 b=Aa9WaJcNYCwneSI4wc1H/Ps4qoqp2TS7bviCYS9sJ5gvb+nd3UXbScHi5WXSxvLEYwIZeirJDG1HN+orekMEun6WRd1RfbUAwXUdxW986tHf9D6l8m6ID7S5tz2Y0Twaqkn58NwKTqITA+nB35dfmj5HaAG2HzAa2GXTVb6Pcg0=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3165.namprd18.prod.outlook.com (10.255.236.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 09:33:16 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 09:33:16 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Subject: [PATCH v2 07/20] EDAC, mc: Rename iterator variable to idx
Thread-Topic: [PATCH v2 07/20] EDAC, mc: Rename iterator variable to idx
Thread-Index: AQHVlIU3+vlvqIYzsUKSv/A0AIxuNg==
Date:   Wed, 6 Nov 2019 09:33:16 +0000
Message-ID: <20191106093239.25517-8-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: a8604ed4-d044-4760-3029-08d7629c59f4
x-ms-traffictypediagnostic: MN2PR18MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB31651043C1B766C52E062427D9790@MN2PR18MB3165.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(52116002)(305945005)(6486002)(76176011)(71190400001)(71200400001)(256004)(11346002)(446003)(7736002)(6436002)(4326008)(6512007)(66446008)(66556008)(66476007)(66946007)(64756008)(5660300002)(1076003)(476003)(6116002)(3846002)(110136005)(54906003)(36756003)(2906002)(8676002)(99286004)(81166006)(81156014)(316002)(8936002)(50226002)(486006)(6506007)(386003)(102836004)(66066001)(2616005)(86362001)(478600001)(25786009)(186003)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3165;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nBzpw7wRjCN8t4x+8f5bPVm1Fpvjooq/QhjosKdNf6A/oLRsAwQpM0lPGpuEsO6DqdB5ksWzkR43ChiqfhHdS6u/AIGti0x5cXDlcGJYBqHrme8xsOpYahqCvg39QuTW6HmzZEyLAX1eGwyyFHogwE+5xLdO5U5J1243gIrOx3MkTFASQliZiu80WDnqwangHFIVkFlN/kSEqtU0p6Tp7zxGFXJbM5sy9e8dk04mPFBE7HoNap7x88eFo0xu3kPjvlNGVD+Q+V3TsvoiQebq0b7XahRzY4j5QZWy8H3GNbm9J7wdA93Z9Pn3BPlUpWnNiHt7AQIaq6XQmI7GcLmBjfIcnA+ipzcwBGxKx7X7v8GW9Ilmb3yZxGA1bgStIBEuuYdIsgANXm3DRK6Ex3Ky5AwjQctwq+WDzNbwM6bXRtoLW8r91Eb2iLDWV3o3d6bH
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a8604ed4-d044-4760-3029-08d7629c59f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:33:16.4097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KoeNa76vt2K83LytVNVmyJ3b453g1CdcuxFYtmrKh5ekM4kTOoB5xMwVnVbct3hwbMGdTClkJdfhjVIdJSnNrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3165
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Rename iterator variable to idx. The name is more handy, esp. when
searching it in the code.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/edac/edac_mc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 3dc1c5afabce..f76252b7a787 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -330,14 +330,14 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
m,
 	 * Calculate the total amount of dimms and csrows/cschannels while
 	 * in the old API emulation mode
 	 */
-	for (i =3D 0; i < n_layers; i++) {
-		tot_dimms *=3D layers[i].size;
-		if (layers[i].is_virt_csrow)
-			tot_csrows *=3D layers[i].size;
+	for (idx =3D 0; idx < n_layers; idx++) {
+		tot_dimms *=3D layers[idx].size;
+		if (layers[idx].is_virt_csrow)
+			tot_csrows *=3D layers[idx].size;
 		else
-			tot_channels *=3D layers[i].size;
+			tot_channels *=3D layers[idx].size;
=20
-		if (layers[i].type =3D=3D EDAC_MC_LAYER_CHIP_SELECT)
+		if (layers[idx].type =3D=3D EDAC_MC_LAYER_CHIP_SELECT)
 			per_rank =3D true;
 	}
=20
--=20
2.20.1

