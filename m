Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6491146415
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2020 10:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgAWJDL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Jan 2020 04:03:11 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:19888 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726099AbgAWJDL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Jan 2020 04:03:11 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00N90NUD023659;
        Thu, 23 Jan 2020 01:03:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=igjWSOHFQSnLV7JN/nvLfDIKKLS2G/vJqqtYKDffafc=;
 b=OCaOKc8pr2oNPOo2wCB748xafJDaO8hIVEKc5JM3YS1uipX2/M/1bfGQU8EV5k6b1m2f
 GFUeM1vpXz+SM2l6QuKyBMh0P/zFs3GZ3g1i0ZFFJVrm3ZXk+945xRtm+tGBG+AunkVA
 8q9SK0AIh9SYlBgXOsbYWmK0mJonVONi1U4BdSSDZpPU8rIgCosl+bXioxd/vQqtkfPR
 OiFHifkcF/3VnGfDzFqM3jr7MH4OtplqlHLdi7puJdCS3MXjqsi4K/B/GipaZ7e5NBj4
 1mVHzt2BHjeqEXj/vFeflRBxxHOR64S+/gmh7tSvwd2eeHt0GTeklClpM2cXJ4Hz3z62 FQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2xq4x4gqw4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 23 Jan 2020 01:03:02 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 23 Jan
 2020 01:03:01 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Jan 2020 01:03:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKLLwb+BmFXQm4Bb07JHU4gqYOBARmPtleSBrl6vfRralwG5MwZWopMqCBi3ZCnJQDBEuvj8kqN27zip+eIeu2w6FyGdvAzjkZxJGGFYPD+wF0H+g2mRUAYlOVs7iEiI0oDDzPnUQQUL1AAC05vrGWsXVbHuospx+p0zIkNIv1XCbnSIT/rlfdsfu6x+QewbKP+OhZApoUZjNPeh5AI8cKLvrJGbGDUkQTBiVpygbdqMMQ8PVx+S4CGRLbXC3zzvd7qBAT+BG5+lkzjphqJ7Sus8g2pVgjID9SzxfZA+GkYNWvHH/0Bb5OgQnvJZ99zHFJzZ7CkQFpTwI1PALzgSuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igjWSOHFQSnLV7JN/nvLfDIKKLS2G/vJqqtYKDffafc=;
 b=N3WqMf13BVSJmjEq0lR+t0jJ2sc6PEWmzqmDaGV+LI0/OqgZmn8Gd+60nM+DoeHL7em5+5XL3PF8qtddb1WNMD1v+Jl25MI02XdAFINLim6vKGp6vWuZd+UZlVMIiJcmIfFqbd70yZHhUbk6oc+UMK/W+IXSc3Uo6Kb6GqWh9RK8G1JIqs5JY01Al13jJp87by5Gpeh1W0XKD6+NP/89fvgg+p7uHBjYw/d4omBcP9Mv7dOv+t7u9su20iWoQ5Xr1OGnujnI/UHnbHBW9A/5zgC8jz0ELiNPMR/1IbeAAY3JBU3Y8rs0+QhMW6g/GHzArOzip+wteGXlKzfEilBsrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igjWSOHFQSnLV7JN/nvLfDIKKLS2G/vJqqtYKDffafc=;
 b=K184SxaFudPjWyLW3zj1+UqC0QasEFTSBBjhZuMDNk3Sc5N6yJ5FARGwS0hxjpSAz0RC+p4c4ZhBxsVRG39ap6z1sQGEJV/89FqShKR68BQV3VBNsULaggo8FONn+8biIXlXSyiLoBt59sK9Fs+hhsImITkTq60SMzQNDiQOOoY=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3247.namprd18.prod.outlook.com (10.255.237.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Thu, 23 Jan 2020 09:03:00 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 09:03:00 +0000
Received: from rric.localdomain (31.208.96.227) by HE1PR0902CA0010.eurprd09.prod.outlook.com (2603:10a6:3:e5::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Thu, 23 Jan 2020 09:02:59 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 06/10] EDAC/mc: Report "unknown memory" on too many DIMM
 labels found
Thread-Topic: [PATCH v3 06/10] EDAC/mc: Report "unknown memory" on too many
 DIMM labels found
Thread-Index: AQHV0cvpAjtm7u086USRplIay6mVRg==
Date:   Thu, 23 Jan 2020 09:03:00 +0000
Message-ID: <20200123090210.26933-7-rrichter@marvell.com>
References: <20200123090210.26933-1-rrichter@marvell.com>
In-Reply-To: <20200123090210.26933-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0010.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::20) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f9ec508-3c2e-4ee6-8a68-08d79fe30c16
x-ms-traffictypediagnostic: MN2PR18MB3247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB324709EADF619AE46B572B83D90F0@MN2PR18MB3247.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(396003)(39850400004)(376002)(199004)(189003)(110136005)(66946007)(6666004)(52116002)(6512007)(66476007)(66556008)(64756008)(66446008)(54906003)(478600001)(1076003)(5660300002)(956004)(2616005)(6486002)(6506007)(36756003)(2906002)(81156014)(8676002)(86362001)(26005)(81166006)(8936002)(71200400001)(4326008)(186003)(316002)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3247;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: thqJWqfnOPZMA70Jm0zC6y/+iyMhg/V3E4Ko2WDQCXXedAWhKRsjuL4gusKob/Jb07t+AHFBXAqLJ4zJh9NGqNdN6XSAfv84+3dqg/kH+J5LHr3zBY00+/BmoTkCzT6RDia0NwL9aVF4HP240EkEPQtThf2WlzAfw8Rvzx8yGxz6ba+xfjpkI+9gDNohTZmgPWIbxbTMpjYhqOH+zrkPFv3pUBUcbASXbIq8AMbvwMFZGtVjhNtQV9Pf8Ze+oEXkp5E2juNFCVVtDlL87wxDuZTwWmA4Lvvj5KfPkwtzHL3J4cmuCZiyox7Du94XhlUoUlkoieVhd6OsDtqZkVF0FT5AwrZlbGC6v8A+PVF/+6YhQp2qr+w4x3CwzchblRyzfEh96y3z0pKPl3YKhOCSPD04JYvJkEWnbleqOsjn1Vbt6tGAcQy2UY/Lj1biI/1H
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9ec508-3c2e-4ee6-8a68-08d79fe30c16
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 09:03:00.7349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ti1k0aLIIYHo/cqFdc+/v66u+E+ub3v/VymrSrrWTDcgCcoAsp89Q2V+RDU4x4lyviLrdaKsMMlSODvGOasK4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3247
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-22_08:2020-01-22,2020-01-22 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

There is a limitation to report only EDAC_MAX_LABELS in e->label of
the error descriptor. This is to prevent a possible string overflow.
Current implementation falls back to "any memory" in this case and
also stops all further processing to find a unique row and channel of
the possible error location. Reporting "any memory" is wrong as the
memory controller reported an error location for one of the layers.
Instead, report "unknown memory" and also do not break early in the
loop to further check row and channel for uniqueness.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Acked-by: Aristeu Rozanski <aris@redhat.com>
---
 drivers/edac/edac_mc.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index e75cb7a9c454..aa94152777fe 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1245,20 +1245,21 @@ void edac_mc_handle_error(const enum hw_event_mc_er=
r_type type,
 		 * channel/memory controller/...  may be affected.
 		 * Also, don't show errors for empty DIMM slots.
 		 */
-		if (!e->enable_per_layer_report || !dimm->nr_pages)
+		if (!dimm->nr_pages)
 			continue;
=20
-		if (n_labels >=3D EDAC_MAX_LABELS) {
-			e->enable_per_layer_report =3D false;
-			break;
-		}
 		n_labels++;
-		if (p !=3D e->label) {
-			strcpy(p, OTHER_LABEL);
-			p +=3D strlen(OTHER_LABEL);
+		if (n_labels > EDAC_MAX_LABELS) {
+			p =3D e->label;
+			*p =3D '\0';
+		} else {
+			if (p !=3D e->label) {
+				strcpy(p, OTHER_LABEL);
+				p +=3D strlen(OTHER_LABEL);
+			}
+			strcpy(p, dimm->label);
+			p +=3D strlen(p);
 		}
-		strcpy(p, dimm->label);
-		p +=3D strlen(p);
=20
 		/*
 		 * get csrow/channel of the DIMM, in order to allow
--=20
2.20.1

