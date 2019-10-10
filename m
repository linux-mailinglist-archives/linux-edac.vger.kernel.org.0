Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B1CD31EC
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 22:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfJJUZY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 16:25:24 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:32436 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbfJJUZY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 16:25:24 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AKK2cS025471;
        Thu, 10 Oct 2019 13:25:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=a3qAQ50KnhCWWX5tKynPYvYyHc24amfLZhkhs5/cBZ0=;
 b=k/9NHNY1ziQHI+GyeiZdWQ+McYXOmJYA6iP3OaR+Y5rwBXURYLKSjbVlj+zOH83Ou029
 lU/sjDqMDsB/aaK8aJGPQxIgy/5BPNnkOvKadtrNZjdOfcT+LkQKKR8RcnVCRDmZ/4O6
 V3oJHV5clvLhkNxW98VYPsnnVJJrxiTZqzXuuQtSav7VVF7rr3ZtMw6V5wXiuhAf9m1R
 imtAy5j+E9vCGPrSi7CUOW6QoD6Gteb3QycNJw//UcH0qFtQpOA/nVaKedA4NECuaYHW
 y3DRaE43xeop6hJgwDKu6rrcwZ7wWHnBo0NJILagGd0ORz/4ZfYL/DsC68PrBM6ci/Eg IQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vhdxbxqfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 13:25:15 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 13:25:13 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.59) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 13:25:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McLeEe3FExBN/gEOef1/AoEFs6Od5xffeSuE11SrySP+xaO1FYTiVEGUJqZW79kAyvW1a7556iWpamVXZoEYdWHJuinWZemQ1KCLkjHe1USpsi5EDWTtLsg18SNKRpSkCGLPbGoNDIAZMT8FWxWPmIsCIoHrYpCqqsmQxVXwXQRuSEB4ZNadh7hr3dUU0Sh2WZd+I4cP1VTDkCsuxCD9Y9UdsxVA9+zSxbHqPZ0op+0ebgNK33fCqLNYXQPCfOVDwrVrNwFgRSc4zO8XUwcNbFP/IOyau9x7wEB7/XJb4Nyx4yXhuHpun6znURRwA1W1mz4UNCugMVRQy3yaJMdNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3qAQ50KnhCWWX5tKynPYvYyHc24amfLZhkhs5/cBZ0=;
 b=WPSD6b9LuO9lVvV9vXRgVSPWdHLIsDIf3OikMvJHP2cxn7sBBi/A8oHco+oE9bmG1F2dy44z0mv/QdC2LMPItOIZ5CxfOuQHh275zD3G/88NSTlq+DeL7G/y3ViFIqcNlySlMqZfJCtsKNbS6+9CBjfc5ZJMYBmHksvnatblWfSOlzYF8GxOlb8sF1JlRkNGfhI7qOpdcSnEphvW8ziqKbXjzM8XY4OObO38kauwjyAZy4BOsL1Ua/oSYhvwHdqLAJPKRqey740A5Sbm/nYvlC5ZyFFeTElTcgXrwAxmhNT0wnAgpKmBcObYTK+JBexQBwJRDy4JrjZcoHWRLFuSwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3qAQ50KnhCWWX5tKynPYvYyHc24amfLZhkhs5/cBZ0=;
 b=SMysw1koyjH8BiIvS1SlaqF3lMDL+qUoNpU3Qqp5pxCu7SLGvAeeIu0VBLwBXMeUAFzPi20COhnHYtkjFPe+yS06UScBv4pqPFl+TwjzeRwvQOBhARGmYAXqBO8zVmz0wq3mKByJsX1Dn0zuWK7xYx43SfNM1JX+szamXzFkHKE=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2701.namprd18.prod.outlook.com (20.179.22.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Thu, 10 Oct 2019 20:25:12 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 20:25:12 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/19] EDAC, mc: Do not BUG_ON() in edac_mc_alloc()
Thread-Topic: [PATCH 04/19] EDAC, mc: Do not BUG_ON() in edac_mc_alloc()
Thread-Index: AQHVf6jRkCDZlVfZIkWqoVgs/LSUFg==
Date:   Thu, 10 Oct 2019 20:25:12 +0000
Message-ID: <20191010202418.25098-5-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: ab8d0730-7d5e-44f3-d562-08d74dbff394
x-ms-traffictypediagnostic: MN2PR18MB2701:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2701956BB353011A6D6E085CD9940@MN2PR18MB2701.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(346002)(136003)(366004)(376002)(189003)(199004)(6436002)(6512007)(54906003)(71190400001)(110136005)(14454004)(316002)(6486002)(86362001)(71200400001)(5660300002)(2906002)(66066001)(25786009)(50226002)(478600001)(11346002)(446003)(476003)(486006)(3846002)(6116002)(2616005)(99286004)(1076003)(6506007)(76176011)(4326008)(14444005)(386003)(7736002)(305945005)(52116002)(26005)(256004)(4744005)(102836004)(81166006)(66946007)(36756003)(186003)(81156014)(66446008)(66556008)(8936002)(64756008)(8676002)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2701;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CiHjWlp/Z8WaS6v9UFsDwR/zG0IrZikluoUm6CHsnB52TiR+9fhGBDKjx9Szk2PCwGWNPjMSHGl3Kq+7EVTGAXaq+M5fO+fCVsyqiQ//tq4hh8rNUJp9cm9/N6bDs3haNMwFcPXLX5Mfic7Fi1rKDwloKhLLRzaSqlqSwTvKPPhMWLcEM/Nz7iMXZ0NANxcCdcxCgXaMX0biy4dZbzpDY/ePkEX2qh8ipxQjAgu4I7ZXiTyoC8mWeGV6evG9zvIPPuckrBsjFom/hMlTMTeX72A6cIW4lF1u3Ng3a4DROPYi8vzxIvtWjF9YEA755zIguV6K1YjhniQMBeui+TeWu+NdgX9T3HLMiAxaAonz1T2dVDw64oZWbEo3jDT8+QKuJWNmfEM86wRvbHBPxvqrdEt1a3PGVp61msfr58zHEVs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8d0730-7d5e-44f3-d562-08d74dbff394
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 20:25:12.1701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7YbmF+N0SD8Q+KrC54VoDF4Cwl9CXqDRwVgYy5Fmq9jUHt/0qkBRgqIUpGRGrNObyj0Zpj+Y/XNXUdPsE3sV2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2701
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_07:2019-10-10,2019-10-10 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

No need to crash the system in case edac_mc_alloc() is called with
invalid arguments, just warn and return. This would cause a checkpatch
warning when touching the code later, so just fix it.

Signed-off-by: Robert Richter <rrichter@marvell.com>
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

