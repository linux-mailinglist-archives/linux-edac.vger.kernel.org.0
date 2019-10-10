Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3C0D31F4
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 22:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfJJUZe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 16:25:34 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:48076 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbfJJUZe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 16:25:34 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AKPMh3029878;
        Thu, 10 Oct 2019 13:25:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=6VC2hAAWNRPfST1c87AOti8xMFZ3ArEINFxIJuOSwv8=;
 b=AqEVjiGK6THJLs57tfyH2ZBFRcgrszK/o8hA3IlGJcD6+AU4wWkk6wUklbW/LB3R9gPC
 08YPoKISr/K5E4pVDxDt3FTYIbqjybPu5e3ObhG3HT8LYq9GtG55V0amm75UI7Rs/+Bm
 y2XZB3ncj+CX/2swMOkosnRsA88IQYDfO/7eiNqvPvWoKuuXbfJKzt4zGy67y8fZD/2B
 gVzqqaLNbgi30Lrzg/SVQW5XTgTvKrggmQhd7XNLy9DD64icviJXUhulNn1FqD1hjROQ
 2H2UaJkXNTTVS9Ig8cZLp2L6DESsCedrPe1FcIHJ+JpOGISR9G+QbfdfyGES04cOJQ5x iw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vhdxbxqg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 13:25:22 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 13:25:20 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.54) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 13:25:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSS8qYz94Knoclj6DO0XZ969hwSPViuZfTeDC9VI6FhkS3fELr3b7ilcjTSfrcMwLGaAZc/XG+H0jtvYXNGBxfCaTtRVA4SJtYSlBGZlEjX/0Q2BK018/w+Owrc+YW65PpScfO3lmza0g4whBa/cXKknrp5yOX2jZUfw8ltP+kvXwqEnmaeSXT/9LCsiVXsOLRgr1r5KIvzuLhN9bM+ciDIU8GwX0yJ3PowRNxwBU/ZMuyAwA8NA+YZ9ZX3csrh2obDyrsfpHVe7h2l4dugYf4gC1Il6Qhe4mfWahx8M/9ECfp+Zj4ANijickUmqFnu6brGpPiOgHH9U+YgFKbNr3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VC2hAAWNRPfST1c87AOti8xMFZ3ArEINFxIJuOSwv8=;
 b=WfZbTaPmZijgrtL4n0LWK3cK1jCU3xla7qWaf/o3puTrdbC25d+jpG6zCArZZdjq4ZEIZcISnV+1VpQMEAXauIYAwYIuPjCB7QmePHZLBG4Z48dQx9ueyeDMALciKaqoxJe6gRjAx53XImxRVQqsW1uildz325CedqngkhSBlvMjgGh9zgGjwlcKyo75MyH3WjPO2L3qodYJCW2SaBweWLOwTf6E3+R9rpOIdLDglW2jkMiImv4LzSwycWibRGu7Tp5I9kKbsdifOxkQKB6Zi27rDbUFLqOCR64QPLFE4hYo+MVZ/QVgAfOiB8D4lZPyMZvU9rNRycHSzKynwJhJ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VC2hAAWNRPfST1c87AOti8xMFZ3ArEINFxIJuOSwv8=;
 b=rgo27BHGS5hJxLlnSYD5SbEaehha3Y/zZykZWv+H3lMNL9b1ifS//mBZ08SJK0oI0srpwZx5kJcFp7SkhhxwV+/82VUdbb8AozI1SMkTLDncRQzBU5vrg5nKXwrGXYAMG/sTwIQc8/X6jAJ5uVThJ5wjPGuBKcjwtQaqve4hA9A=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2447.namprd18.prod.outlook.com (20.179.82.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 20:25:18 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 20:25:18 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/19] EDAC, mc: Rename iterator variable to idx
Thread-Topic: [PATCH 07/19] EDAC, mc: Rename iterator variable to idx
Thread-Index: AQHVf6jVL0auiWscLUyc7PPUUqlSUA==
Date:   Thu, 10 Oct 2019 20:25:18 +0000
Message-ID: <20191010202418.25098-8-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 0025cb43-806b-44c0-8ee4-08d74dbff796
x-ms-traffictypediagnostic: MN2PR18MB2447:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2447AD15B61174C3F76F93D7D9940@MN2PR18MB2447.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(199004)(189003)(6512007)(476003)(8936002)(25786009)(50226002)(8676002)(81156014)(81166006)(7736002)(305945005)(256004)(486006)(14454004)(2616005)(6436002)(86362001)(66066001)(36756003)(66946007)(66476007)(66556008)(64756008)(66446008)(11346002)(446003)(71190400001)(71200400001)(6486002)(186003)(478600001)(5660300002)(386003)(316002)(3846002)(26005)(4326008)(6116002)(2906002)(52116002)(76176011)(99286004)(54906003)(110136005)(6506007)(102836004)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2447;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B+Bvt9bhi3qgxxlrgrnc4e8abUJ/k3LQ7n5/E+HEJ231tqNUUrNyfnFvwTga6ImoEEsSZgoH2tRwZvmxZQvGyQyQjdZCH6bu+VSPsSojaBJ3KsCyUwaW9KY4ktjuW8BLVMyc00ydZlT2fNOSeZBxRhNV8EHAD56kTbnE3rjv1VX12F13xXIz1NHDuE+ZsFXKQFtL0/qr8/GLVEjlr7gHpfWaKiDWP7oECfKPNAnLKo6LUHcVQQ9BBnVc4xcbHcfMZpyBkHceMqo2I0oxsdyI4aBHrJaFzg3hnNOlImuvbw76Kt2YXZozUzyIobx3bsSMMZXvyU8faR67vXFHLfng7eRBozw9RbXwyPCEi27TNjPPjWT3QE1EuC7srnfGHO+Yh8NXOCJzW9erhXPOb8BWT91Q6JivR3/JRkHhC2qc33o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0025cb43-806b-44c0-8ee4-08d74dbff796
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 20:25:18.7104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /87UFRPCgR6nH+cvzpJr+zNdZ0Vs9G5cKGwHpS/qY1xXG5phAOIu1hXhcQwBeEnr1vyynyPa5aNlc3Stwa20tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2447
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_07:2019-10-10,2019-10-10 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Rename iterator variable to idx. The name is more handy, esp. when
searching it in the code.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index c1e142643006..a893f793be8a 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -319,7 +319,7 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
 	unsigned int idx, size, tot_dimms =3D 1;
 	unsigned int tot_csrows =3D 1, tot_channels =3D 1;
 	void *pvt, *p, *ptr =3D NULL;
-	int i, j, row, chn, n, len;
+	int j, row, chn, n, len;
 	bool per_rank =3D false;
=20
 	if (WARN_ON(n_layers > EDAC_MAX_LAYERS || n_layers =3D=3D 0))
@@ -329,14 +329,14 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
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

