Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D22CE146419
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2020 10:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgAWJDO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Jan 2020 04:03:14 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:45420 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726118AbgAWJDN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Jan 2020 04:03:13 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00N90o6v029801;
        Thu, 23 Jan 2020 01:03:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=ZqFVXH/fJOtbtpkZXYPoHPdz/WNYCXropmBYNSbL3Go=;
 b=vH5XDDb4WMRja4UOZkgKlrkY3Lhjvh/5b6s5jnITr5WQ/5+VqnrK1CBAahkNPNQmth5a
 WbBUPUJ2NckJppK5BW43VGh8UNgzCEQI/dDr/onjv/X1zAwErTdl3WkKRlZcSBWfiHPS
 rycfMN4OwsTlu9RuIYCkouj92lFGeVXd9yh8qpJ4wO+1f0h67njNjlJWlGoKd8XfHCXt
 axkaBPsw59OW3a4AXkqVArB7cuPbU669BXwq2Q0fGvU2jk9IEiAbpeI7bcLop1KKYXck
 C5533u06oTLBQivywp6eG/+73FO+sDkB24z6+hivPbkGLkR0DXwaL3C/5n4L+maQE7cw LA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2xm2dtb1y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 23 Jan 2020 01:03:00 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 23 Jan
 2020 01:02:57 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.52) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Jan 2020 01:02:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKsD+QzqxD1vIcv827KIX80CgRflfVWSVT8dZ4FPcPsIk0DQJOqrKvwKeC+nvIhyWbe5soFxR1FYQeI5lj2dI7vn5KlJqjrZHZttZIoO9c3VtrVEL5ngBdO4Iz8fli+WkMmQ6NxhEnj6rlRS7RZRYxoZgtaLWO8J1Ex3KBT4QK6745CibJtnW6jWW2F67Up9IUAQM8tG4rrV/e+X0ozFhewuZGzOFofbAFRcW+aI47Kr7boeZTezUPmXAq0EI2R1pTLb5Ir7ZF4oYxdPBCdKEzDujR29cH27cfFC9NZsOqfhKVaJ50ZlNXDg9rQUgMLf0RbbI53Uhc0TDoftqjOcKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqFVXH/fJOtbtpkZXYPoHPdz/WNYCXropmBYNSbL3Go=;
 b=ME7zzuFzuhBKnlIe2ymfuKhbwf8hgIc/drZg+bW9oXKXuYFrMc1TEKWwoUfnrV3YVh956MHHvBDn31xXOX6WB+93rVWu+1rPkoPewpqHDurYGic0FcY6ZysaVP+fScsBIYjGz7W92f+NZI/7elr4DjFip7I/JRYJQLyvccuF2PJB0QgElDSsGNiyDyDa8tgKmhaK8kTDbOzxrqJmZmmciF2MwLYOGEiE7Ub44tRD2t1Ej9svbXckNHC4A52XjhLflk/8Aw78UCWh/tyK1PB+9soDGlqZslOw4X9oQx8fujMHY1CEq8Ikw09GCRLNhVsbUzk00/PgJfXaxBzKOVtglQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqFVXH/fJOtbtpkZXYPoHPdz/WNYCXropmBYNSbL3Go=;
 b=ll7WTh4H6IXojmBvIgB3JUGkyt8PkSi7mR6LbPJYs2wzQpJ3pgM7PUiW5kSI9Iuic9/YR51CzKkLRsYe/H1IfJvbAi8CUjCLNn29+PtJ0L5jKB9RZtnu/KYuA2h1YScuPEq+yEkbfXzzKx9PQJ37jef2UiFHbtRj2tHxxMzcshw=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3247.namprd18.prod.outlook.com (10.255.237.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Thu, 23 Jan 2020 09:02:56 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 09:02:56 +0000
Received: from rric.localdomain (31.208.96.227) by HE1PR0902CA0010.eurprd09.prod.outlook.com (2603:10a6:3:e5::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Thu, 23 Jan 2020 09:02:55 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v3 04/10] EDAC/mc: Determine mci pointer from the error
 descriptor
Thread-Topic: [PATCH v3 04/10] EDAC/mc: Determine mci pointer from the error
 descriptor
Thread-Index: AQHV0cvnwLokIMr0x0if4218S0+YaA==
Date:   Thu, 23 Jan 2020 09:02:56 +0000
Message-ID: <20200123090210.26933-5-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 91db3d0c-493e-4929-dabd-08d79fe309c1
x-ms-traffictypediagnostic: MN2PR18MB3247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB32473D82F5B9C73515EB3177D90F0@MN2PR18MB3247.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(396003)(39850400004)(376002)(199004)(189003)(110136005)(66946007)(52116002)(6512007)(66476007)(66556008)(64756008)(66446008)(54906003)(478600001)(1076003)(5660300002)(956004)(2616005)(6486002)(6506007)(36756003)(2906002)(81156014)(8676002)(86362001)(26005)(81166006)(8936002)(71200400001)(4326008)(186003)(316002)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3247;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PG2TO1xjm5apa7E1AX17czJw7zPTke73lCEH5bI514/I1Gxa2JoO0essb+LzYgtJK+Jvd+4lzdtvGpnL/e9Ysg+MY2MqUGC7rotsPgmrTGY73Y4wFyK+hPXY/F01O1YxwbkSEGUipf9LgYQETINNk8P8WvyR8N5a6L1mP5ZHdxIQzAT2ZU6j1s1wQzgwmOF60nps/sskCMID/s1S/0bqWgdW6WvGc6H6+owesQ4grHKBHLJNlSEr35bEnJoufhShDyd5C3zUXLWcyHIQNIMk2wfTVzuXbUQaq+ChZW17O1omxF6UtQlvmCS1rlbWy9LsZCZwwTAPSnNKWjZo5BLNjE644oHvIHTt/YY+2zh/J48kDOQHRN5Yw9FYBVY80CuASbHGgUuLJd42JxeXm9AWWHFFh4fnXD92BOFb8dtwi/+YY5W+PMd9lH2g0Wo6VZnq
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 91db3d0c-493e-4929-dabd-08d79fe309c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 09:02:56.8005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bza7fV2pFAG9hlKnbCq77Qs49owSjiymTvEUROoGZ96z/mjcVMRJqBygiVnz7opeFqV4ysKaOGxDqwquyDC7Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3247
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-22_08:2020-01-22,2020-01-22 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Each struct mci has its own error descriptor. Create a function
error_desc_to_mci() to determine the corresponding mci from an error
descriptor. This eases the parameter list of edac_raw_mc_handle_
error() as the mci pointer do not need to be passed any longer.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Acked-by: Aristeu Rozanski <aris@redhat.com>
---
 drivers/edac/edac_mc.c   | 11 ++++++++---
 drivers/edac/edac_mc.h   |  4 +---
 drivers/edac/ghes_edac.c |  2 +-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 8ef69d24297d..3c00c046acc9 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -55,6 +55,11 @@ static LIST_HEAD(mc_devices);
  */
 static const char *edac_mc_owner;
=20
+static struct mem_ctl_info *error_desc_to_mci(struct edac_raw_error_desc *=
e)
+{
+	return container_of(e, struct mem_ctl_info, error_desc);
+}
+
 int edac_get_report_status(void)
 {
 	return edac_report;
@@ -1086,9 +1091,9 @@ static void edac_ue_error(struct mem_ctl_info *mci,
 	edac_inc_ue_error(mci, enable_per_layer_report, pos, error_count);
 }
=20
-void edac_raw_mc_handle_error(struct mem_ctl_info *mci,
-			      struct edac_raw_error_desc *e)
+void edac_raw_mc_handle_error(struct edac_raw_error_desc *e)
 {
+	struct mem_ctl_info *mci =3D error_desc_to_mci(e);
 	char detail[80];
 	int pos[EDAC_MAX_LAYERS] =3D { e->top_layer, e->mid_layer, e->low_layer }=
;
 	u8 grain_bits;
@@ -1284,6 +1289,6 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 	if (p > e->location)
 		*(p - 1) =3D '\0';
=20
-	edac_raw_mc_handle_error(mci, e);
+	edac_raw_mc_handle_error(e);
 }
 EXPORT_SYMBOL_GPL(edac_mc_handle_error);
diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
index 5d78be774f9e..881b00eadf7a 100644
--- a/drivers/edac/edac_mc.h
+++ b/drivers/edac/edac_mc.h
@@ -212,15 +212,13 @@ extern int edac_mc_find_csrow_by_page(struct mem_ctl_=
info *mci,
  * edac_raw_mc_handle_error() - Reports a memory event to userspace withou=
t
  *	doing anything to discover the error location.
  *
- * @mci:		a struct mem_ctl_info pointer
  * @e:			error description
  *
  * This raw function is used internally by edac_mc_handle_error(). It shou=
ld
  * only be called directly when the hardware error come directly from BIOS=
,
  * like in the case of APEI GHES driver.
  */
-void edac_raw_mc_handle_error(struct mem_ctl_info *mci,
-			      struct edac_raw_error_desc *e);
+void edac_raw_mc_handle_error(struct edac_raw_error_desc *e);
=20
 /**
  * edac_mc_handle_error() - Reports a memory event to userspace.
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 7c3e5264a41e..bef8a428c429 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -441,7 +441,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_se=
c_mem_err *mem_err)
 	if (p > pvt->other_detail)
 		*(p - 1) =3D '\0';
=20
-	edac_raw_mc_handle_error(mci, e);
+	edac_raw_mc_handle_error(e);
=20
 unlock:
 	spin_unlock_irqrestore(&ghes_lock, flags);
--=20
2.20.1

