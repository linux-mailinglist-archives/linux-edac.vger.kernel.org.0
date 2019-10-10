Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC02BD31FC
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 22:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfJJUZq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 16:25:46 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:30894 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726678AbfJJUZp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 16:25:45 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AKPMh7029878;
        Thu, 10 Oct 2019 13:25:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=o1b3djdTg/nm2ISJxuGuvT21IZ/8pVHiu31rfh0Knno=;
 b=MbSxp9Q6GvMay8zoQcKf73Dztm2CBe2EgEj0Ko7HHCOPgM6aiydJOGYwEdZ4Nb3pCPUs
 4tRX2RSUZsBanhfc2t64sVXfA/6HZkFgr4rOoMs/Hby7e4lOJqqJi05qK6SX1n0TqvUg
 AUSFBq5KAfrKESU1w6MsfsuyBF8edq06iWiEAkduKBfXuxuFIU5ryfrGA3IQkYkCM8Nv
 fKsMBGb++1sfBDeLwgfCmVX6RpiW8cibhGAKQnAKszlxoxYScjnrn2GRjGwMe66JLT18
 3RzYB4nl7ckCMfBOPjOdO69iwC+6Rd3hAOBugVcvtsQZAZfAE/cJZ7VlvGDwrRA5YlR3 Jg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vhdxbxqhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 13:25:38 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 13:25:36 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.59) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 13:25:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eaki6+MubLl6S1K4YlgK4qSjZNelvZkKXVk/QShcILh5wzoPCS+yDSCJlnUfyWIH7bMxtV38tmHEsFk3b4FCeRtt2xAZJ4zLs8ljPgclGvuPHJYCqAb/wK7DCYOOtBayGsuYdlmXqfwSwf+8T2DKkrh0L40cZmCQhUrbDqRA35DbGtMcAi1xMgTkezDOHk4WOTPY/Dko+txpVJTMH+h+C3+Rc9D1WcC/879h+rP7oPGm9Sx80CL7pApqRbAA8ug22ARmq+rpgLU6tShsiskx8Mez/kkbdKXE8PgVOcGtYSJ/JGkFzj4cwYi4QhV+b72hTodartxFV59oeYJdYoY8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1b3djdTg/nm2ISJxuGuvT21IZ/8pVHiu31rfh0Knno=;
 b=aycACdsedo89SufZSUbZxiQyPNefuec2tbipr/6utlGHuX1Vwef0Ak1KeJKjmt/6FFaYXH7ZxtDox0Uiym+WNC6wIpPte2sRSyI5ZTcxlkfMy7N/jgMVvgci8Cg/UaTSI/iDdg1J+rszfvjvz37rPd5cnloPOvsdI9bLQUKQlUtLmMAVXODuzS4XZTtv1/fbzZvJsd2dxHztf8QM0dfEnapwbIAlhrG54DCSAFmha0H5d/gTJJAnBq1QNqThJP6ht6NYIsysZPE9dHV/zwLfljHoO1589mrsJIwROFi8BFbZ8SIhK1LnyT2NRSgUc2XA9b934Yd2DV0BEgtDBoOm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1b3djdTg/nm2ISJxuGuvT21IZ/8pVHiu31rfh0Knno=;
 b=Mlu0HnkI+DWaIKPtyxDcYbD8NekGwU6YBzhVZiUAqeL4tB3dwyloYSWgGPMl8ZkjDtU8hs23sUsez4mJg6stLvwHppBzRkTigYkMyfCHiIitB829lZDZHIms/Aj+hFBvNWGDqndKCuweFeIrUISGWvUW4efO55g6dsieH2O9ykc=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2447.namprd18.prod.outlook.com (20.179.82.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 20:25:35 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 20:25:35 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 15/19] EDAC, ghes: Use standard kernel macros for page
 calculations
Thread-Topic: [PATCH 15/19] EDAC, ghes: Use standard kernel macros for page
 calculations
Thread-Index: AQHVf6jf/IL0S6oYnkGImdINaIzkrQ==
Date:   Thu, 10 Oct 2019 20:25:35 +0000
Message-ID: <20191010202418.25098-16-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 935d9d8c-67f8-42c0-2afa-08d74dc00170
x-ms-traffictypediagnostic: MN2PR18MB2447:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB24478E6A3992218ED367F090D9940@MN2PR18MB2447.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(199004)(189003)(6512007)(476003)(8936002)(25786009)(50226002)(8676002)(81156014)(81166006)(7736002)(305945005)(256004)(486006)(14454004)(2616005)(6436002)(86362001)(66066001)(36756003)(66946007)(66476007)(66556008)(64756008)(66446008)(11346002)(446003)(71190400001)(71200400001)(6486002)(186003)(478600001)(5660300002)(386003)(316002)(3846002)(26005)(4744005)(4326008)(6116002)(2906002)(52116002)(76176011)(99286004)(54906003)(110136005)(6506007)(102836004)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2447;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nAQfyElTARzLlsIm174BNLq8tg8ft+yKZkQ9lnZfIJgp/0H9xTwpQG2gBAfnhHs+R7fzWL9R1BzWUQKWBoUQ+Sxpk25Apl7BX9AVZa1Sgb+3zbnSn+VHT5CWjw02tQ/rpYK9I+YMvnYhLHqg9lUgCFlScSnnfL8Q1k6xxC1FRHa+v14fPxs1RfVjFkW7NixShxg2oVoKGW8kQtTHPr0IjuoTZYm0HbFZPrqD9d/HXy5IkC4vgk617xh0Ib5UFvgBS4Kh3pqFZWNLo2LiJm9GDmZU425++aFV4ITcisHXykiRmGpzujnr3nvVTJO72qBdD2yZiatwny+CC91hIwMNdWu+WrrnC0nrbcvLlVGUresLykjqmmArWqN51hsK/mvbew7Yi52r7BYrjjzmZv81hmS7GTO5gkZbOg3iGAnwwjI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 935d9d8c-67f8-42c0-2afa-08d74dc00170
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 20:25:35.2030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LYGbOyNXZcQ2v7Ub3iyjTNenMIu4Q6xJ2+eEuS3jIQRsnap3JR+pGe9stuCJyamXmjeF4RdcJcFqimWLkYzz1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2447
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_07:2019-10-10,2019-10-10 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Use standard macros for page calculations.

Reviewed-by: James Morse <james.morse@arm.com>
Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 8078d4ec9631..851aad92e42d 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -309,8 +309,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_se=
c_mem_err *mem_err)
=20
 	/* Error address */
 	if (mem_err->validation_bits & CPER_MEM_VALID_PA) {
-		e->page_frame_number =3D mem_err->physical_addr >> PAGE_SHIFT;
-		e->offset_in_page =3D mem_err->physical_addr & ~PAGE_MASK;
+		e->page_frame_number =3D PHYS_PFN(mem_err->physical_addr);
+		e->offset_in_page =3D offset_in_page(mem_err->physical_addr);
 	}
=20
 	/* Error grain */
--=20
2.20.1

