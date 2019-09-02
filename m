Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59174A561B
	for <lists+linux-edac@lfdr.de>; Mon,  2 Sep 2019 14:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfIBMeA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Sep 2019 08:34:00 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:28348 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731670AbfIBMeA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 Sep 2019 08:34:00 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x82CUjqb029663;
        Mon, 2 Sep 2019 05:33:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=eT5ARylE0PPIGqS6JRb8G0U3D3rvi556maazBgeCjFU=;
 b=dy+t1ysNoJ5vO4Bq30yGrWi3AmKAxxbI3SvOhgj2b8msbsP/CkxcCIEKtLS50HSIRYqG
 nXXESwWmxB1Rf2fCoy3brF226+MBe5BMUULD4xpeA4Ts2wMTBtungbG43R0KJv89Z9Wn
 uTwZk8OPuVoz71kyHbvEXNz/pa5DkQYA/H4wM7/Tbh05g6Ol3KwhBZ4AXPEDg5HpSqW/
 ts1jyzuj2AT9HY3Wvszo5Yh2MTBu+z49gybBGtGck7AaqFZribivOEq2o9x4sM/c7nFQ
 zaIqHyy10cUsIqUBH9IUDhNiRRnBbtkYWe2XraDswwE5VA0CqJ7XVcq4uZxzS6OiNGzq Xw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uqrdm603k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 02 Sep 2019 05:33:53 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 2 Sep
 2019 05:33:51 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.55) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 2 Sep 2019 05:33:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNyw7VF3iW87LXF8cmAE5O4PWhvxTAHksEVpk5LijtkkGP0ZdgQEB5ceNbNCDr1ZAjwJjO3E0GM7xNEHPcKgW5A2oRygSuiucqK47iHV67Ypz7uq1Ocs1cYijucqrjYhW/X7O8MhxuHn5kD9gQ8RVmLa2Fdf9dJMoISjBOD2K2wulEfPBHi6yyxA4VpIPIbyU4nKo/TpvvRueYEHx8zbAb22iLtOaFWy1/htKeFp1jeXQT/BWKjOGzNKDg2ub0hBM+l/IeglPEtqsq/yNIAodZ/VPJFFmCScfUUb53zUj+lrztX4Y020mhUbeMq53RfMJ7B0LFYJj3JedHisMec1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eT5ARylE0PPIGqS6JRb8G0U3D3rvi556maazBgeCjFU=;
 b=Oht0Dw9e5iBZ5+USPp1k8qkTwprCYgDksq7YBaLZ38uzCBy+633alCsFnGZqlHkHjn3fRPimvYRUD6d7gEEI8eZc7dnAmOLRam+os0z+UxjTQnnvFRJFfUt/j4U3Cm2kL1QqXRxpYf1y3XQucbWyKinMhDSlvfH5LDgG7jWq1pIpJ8uifUt8ofZLerRvSUINCILbj1MNCNmgFLxXqy30B/t4yi7eP6CplHPPOFsoiWF0rKgnBVV5YrG5gZP88O8xP5gaF1LA2j//ZigUyi5yBwG4WKnfIE6jx9RZImaQKiWrhHyBlEFGSaTs8t9VjVezs84DELs20P4gfsp90nejUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eT5ARylE0PPIGqS6JRb8G0U3D3rvi556maazBgeCjFU=;
 b=YWqPfaY7qmSlCqnQKCHpXJJjrWOAtu4VpnGiwvXZqyoDwNMM7l2sHRWiu9gnovBBxtqGZabTF7xvsAokLHLz3rJPan5gOOyvMxogYYnJWNmBEPR9gQtwpvikJ4ZHR/cUak732FkshfU2TRA6fsgQXN9hn55Etw/l07tK8X0JqCk=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2480.namprd18.prod.outlook.com (20.179.82.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Mon, 2 Sep 2019 12:33:49 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b%3]) with mapi id 15.20.2220.013; Mon, 2 Sep 2019
 12:33:49 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     Robert Richter <rrichter@marvell.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] MAINTAINERS: update EDAC's reviewer entry
Thread-Topic: [PATCH 5/5] MAINTAINERS: update EDAC's reviewer entry
Thread-Index: AQHVYYqr018fZ7kvpEWL1+5AuK3XQg==
Date:   Mon, 2 Sep 2019 12:33:49 +0000
Message-ID: <20190902123216.9809-6-rrichter@marvell.com>
References: <20190902123216.9809-1-rrichter@marvell.com>
In-Reply-To: <20190902123216.9809-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0027.eurprd07.prod.outlook.com
 (2603:10a6:7:66::13) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 083237a3-3f95-4960-daf2-08d72fa1ce1b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2480;
x-ms-traffictypediagnostic: MN2PR18MB2480:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB24809F9D10BA12FC0677BE32D9BE0@MN2PR18MB2480.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39850400004)(396003)(136003)(366004)(199004)(189003)(6486002)(8676002)(186003)(110136005)(81166006)(81156014)(71190400001)(66066001)(6506007)(386003)(1076003)(71200400001)(26005)(6512007)(4744005)(53936002)(256004)(478600001)(50226002)(54906003)(86362001)(36756003)(8936002)(52116002)(66556008)(66476007)(486006)(5660300002)(64756008)(66446008)(11346002)(2616005)(4326008)(316002)(476003)(2906002)(7736002)(76176011)(6436002)(305945005)(6116002)(3846002)(99286004)(102836004)(14454004)(446003)(66946007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2480;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3AZIqllSYG6pa60ZulnBu4qjdUcsliLuRb5iUXpRcO/YXZbqyGJvmBzTMmaOlBpiW7bsKjFExzAmJfIAY1e5rjF6YDGfIl/cQpSHEHPCZ+33ZXLXKCCD5caWde891HAcdJn5wZ1dYTZGkImSvKp5gq28m0B23lKCASvF26v+sK4lU57GOeODO1zAkLeHZ9Z4ws/Rml/e2fv522WaafdsNwd0vV+aRZpReS3Z3GFJUDCvh/jHKPlroVCRwLzZnTQrCOx7+Z+4KfQxdVcH8YicIhV6UL74tr2wNWNPJaT7ROTCXkk5YfYoplMr9hdlMf/RhHNFbtfUfBldKhzYPdB24m4/7EvtVDMiQ19mPN82KCdb1GolFauLegLbvSB0IiUP1p4PYf1G2X5UkQYXbVfJLfhUpmo4tHPZjkseo3q8P4g=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 083237a3-3f95-4960-daf2-08d72fa1ce1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 12:33:49.3494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: muPGUNjntKO2LUn76FgmwDk6ufPJgRnsTZlz9lNdMQfHZYZeSwi2Cbu2+tOkNMatpl6+c7iJ/MJVyjq9fAPU3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2480
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_04:2019-08-29,2019-09-02 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

I did some significant work with code in edac_mc.c and ghes_edac.c
already, so I guess I can probably helping out a bit as code reviewer
here.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97912d8333a9..79d2ae8519e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5788,6 +5788,7 @@ M:	Borislav Petkov <bp@alien8.de>
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 M:	Tony Luck <tony.luck@intel.com>
 R:	James Morse <james.morse@arm.com>
+R:	Robert Richter <rrichter@marvell.com>
 L:	linux-edac@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-=
next
 S:	Supported
--=20
2.20.1

