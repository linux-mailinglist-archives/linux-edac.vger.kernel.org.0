Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F14F4F1264
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 10:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfKFJdf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 04:33:35 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:8628 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730806AbfKFJde (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Nov 2019 04:33:34 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA69Utdm003181;
        Wed, 6 Nov 2019 01:33:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=zd2Cfzw5lVu0bfmracEsDWMtt5AAZVQPJvcJyi1o1UE=;
 b=Ccy53EIpDo6kVm0xvzsbLYhszZ6aoquAIhbMcC8khKkyNKAX43OWWReU0QtqbeoGapOr
 KPZcKWxiYaB/ZgIyG7l6GTiaYdiEoSeqtVDNjdezNZfASczMoSZHm/9JkRlBIM57GmtN
 xNqPHS464/JWgTQpflOlsQdET0L2UbIxz43ANK1DvdMZ+Sho+qH2ogNuFE+6iv0wuwaf
 a8EFBkTaY6HdLjf6lFshNxbosGZ/AzSOrinok+hRVayn2fz2w/81+UcPuSs0Ou9q/MWz
 omo4spUpCShh0QWMR0T5u8SfdhRbqdxeIUwxXHXZbHeKRoemWnXqARXfbFMA/9vOOm8f 8A== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2w3eud3c7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 01:33:24 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 01:33:23 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.57) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Nov 2019 01:33:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLVH0uJFT+t7aeSMRmpos+PGC8FjwrrqvohSxvydFeFneS9QR2RtHbpC94XKLbGVsQnvxIMJTQTKdI/DuPDh29nScGilsUYj9NFsnFb9zvRJ7jlMa7UEGlW5/efQIWd5BcydbNoWzAOgPMYTjj3Nbd2MVC1WyhGRWqnuUwDZ5I649b8VKN9v+uaiq6LUIXjFPcM74BJBvhz1L5u7Ihm2FSfdzgQfe6QfG7n0zFLUpRpGykLr1xiV65AX0/UBpsBB9Sz6gzRUG4p0OwVes5TNh/0oMRWEs+WEJDKl1sPemZmlajvGCqzEDrofMZv3HLrhEAH11xacLl3nO36PxSC+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zd2Cfzw5lVu0bfmracEsDWMtt5AAZVQPJvcJyi1o1UE=;
 b=ADnCe9cfPntuhx3oi6HQotsKdD2dgzzTOzU3Y+nicJYyRJWhwFSBQBIn7OTuisFec58uEcevSyNryN4Ktwy7ZxfnBlHm5BRpbcdD5Bh09DSYyhZ+ZrHlDnPCzCfzUL6mNIjYDmbcXzxE6PsYvKj1UG/f4LhySfHOflxmfLvlfDAlgO8qHMMhqDOw4SNRTazhRajI3iE3ZVXv9L/Y74yL4hya2360WePensONaCWoS88Eo47K0K6eep851/BHX+brLfRqaOrHX7rDix8VDkVTRjHDigVIr1ZIwgRLTPN2Glmpx7b2L0mn/D5q9PoOwg1WLVqoVekFiTCtxfztzzZWlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zd2Cfzw5lVu0bfmracEsDWMtt5AAZVQPJvcJyi1o1UE=;
 b=MZOsWiBnspdccokr+4jKQKOCO/tiFqmxS7vJ71LYccw3SzuixdW9X0CkazaK6xtXvd9+DRE6izWIpv2hk1CVyWh38RBkJsfrHm3ILlDrtyUfKo+Y10mB85DHEkX9k0x4u3oZ3XJENv2PVjRepe/VM0aYATW998t1AsDZlNWOSCA=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3165.namprd18.prod.outlook.com (10.255.236.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 09:33:21 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 09:33:21 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Subject: [PATCH v2 09/20] EDAC, ghes: Use standard kernel macros for page
 calculations
Thread-Topic: [PATCH v2 09/20] EDAC, ghes: Use standard kernel macros for page
 calculations
Thread-Index: AQHVlIU6hXDtOVRZN0C/PhW6zmjwvw==
Date:   Wed, 6 Nov 2019 09:33:20 +0000
Message-ID: <20191106093239.25517-10-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: b55b76c9-0ea0-4ba8-771a-08d7629c5cb9
x-ms-traffictypediagnostic: MN2PR18MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB31651D1EABB9A7CA984F795DD9790@MN2PR18MB3165.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(52116002)(305945005)(6486002)(4744005)(76176011)(71190400001)(71200400001)(256004)(11346002)(446003)(7736002)(6436002)(4326008)(6512007)(66446008)(66556008)(66476007)(66946007)(64756008)(5660300002)(1076003)(476003)(6116002)(3846002)(110136005)(54906003)(36756003)(2906002)(8676002)(99286004)(81166006)(81156014)(316002)(8936002)(50226002)(486006)(6506007)(386003)(102836004)(66066001)(2616005)(86362001)(478600001)(25786009)(186003)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3165;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yXm8CC95/lk4aLQ8T7P+3lnohaC+Gd3I1dL5I21WK0+Wl/KQWhWansIsouN/4DwOO/ofkT7Y39Ipx8e5so06GA0Zthg7V8dDzVtKY0Zn0AL1XtePG/rgRQAwhn1Hdq7UuKAlLvAYwpwxHVeVztXLTBgMVFYgTVXVjNbpZUEbDy/LiiWj4f60qoQlmcLAfmpknCGlqF+Bvdr4Ap95d/Zw3xWxx/HQMHIJwTdWYy/dL0rCOg/523oPC1OBUfn3thbfk6TkBNJsnGyCmxjgSFNbhW4YGjVyhUke4+OCY4F9ZuawMnRPjH7Wp7VdF57w1iAKLePRb96sb/HGl/CfhxzlEUZhjMRVRuyu9lHDXxGT/lcUIGyrdDHRoClcxBxKXr3rFB8VWiTtRgsO/l9yxo2TyVJxSM7Cc26PjqtCZ8Lu/YvlaWNV7rzmQX8iVeb+X3AG
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b55b76c9-0ea0-4ba8-771a-08d7629c5cb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:33:20.9801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZQ3vtC/bHa85Jh5MHWsgn38Rv7/+pyRdcro+CalmxYW7k/gRtP8iFsHKvSgonRf8Ot2MzZJRd5OiOTu59cA/VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3165
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Use standard macros for page calculations.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: James Morse <james.morse@arm.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/edac/ghes_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index af27f8063891..944c9d2f0eef 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -319,8 +319,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_se=
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

