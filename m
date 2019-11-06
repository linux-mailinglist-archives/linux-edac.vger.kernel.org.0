Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13783F1262
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 10:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbfKFJdn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 04:33:43 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:12762 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731712AbfKFJdm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Nov 2019 04:33:42 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA69VKLT027217;
        Wed, 6 Nov 2019 01:33:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=1TFVM5ORM0P3zV7f/gRuhjY4rmk0XP4KnO4NIoEQzaY=;
 b=ZRPo+CIZ27YeUmJ/Ouuy5CeYGwxoGBPYNmP940FhSnsm0BA2TDANfIP2uIbmn3h3EpWH
 0idcnf2+WG0qo0IdVMKvmu6oQtmvJCEmL2DMYPf84wj6bzw2jhqnParwQFOuFzsLod2a
 kC/uTyDZtTN0x/Q9d2R8riXStNo50lvsDXYxQbfZg86gskqV26z2JBn4hT1a3lAMBAOT
 sOWoRxcRNYW+Iiqi+NK6SBIJznp50LMLjC6ar6hSjcdCaL6SYpL477IhroFRBy7Tj09h
 VFkLG7qV5LdDcAzRBe1Di1+l98BiVEn/JgykKm+OktinURV1VrXdNUSMMz6ZdtpyuXft IA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2w19amyakg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 01:33:35 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 01:33:33 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.59) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Nov 2019 01:33:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyNsS/MbNjE6/a+e1PMw+9rspZSx/ASi5mq8+0tlnbFwwbbpfJgMbpfXoZvgep2yWYW6CgMJBmCWC4PQfgvYwYJvqafFD0YoVhSD27kXh4jU4bZf+hFb55YNaQC2YMI1cZlvU0oQKoanmEZsPFq6fccb0U5ktsA1UFUvxCHiDxMwnSKlGj5gSC5KCsqlYk3qjcBclRY8Z4HInk/lyf5pWjKM+9bKKPeAvhFyOjC+GFD+oVQL9Bnqch9Z/gRfqkRX76KkAlX+s9fEPmbCFwQJpDqLTCPdKNe4HQDGVV2ObOdkzMFex66m2arRMl6jde6u9VoaPuz+dGBzk7QrBfxkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TFVM5ORM0P3zV7f/gRuhjY4rmk0XP4KnO4NIoEQzaY=;
 b=SsR7dGYN6XPG2pfbh8NDZVhhhGvikAyqlVCMv2IsYiuParLjunXmcea6rCIMiphQ/CfWQ1037Sl+tkCtO4MNQi4v4mPsG115QcnJnENzZfuUQ/UgnrrX4ihviyg/C50mWXNfeI2O2A38a0DMoPsThqC1Q4KB6o/J5KTujamTHoNUhUgBEu26+E1KKZ8J7V+pnQq2pQy7cQn0Mzex6kyRqmjFt+czuTUCWlc/eqW0/IoIpNMTn0wvqbg3otQHYSfu2uBVdKyDzheza1nLn8Yhlwf7RIy29J/3olbNvkSYinbeoXorr8cg9zUSC73XEdA3SP/jShNnm/fKP1PoDkpxbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TFVM5ORM0P3zV7f/gRuhjY4rmk0XP4KnO4NIoEQzaY=;
 b=WFe6L8/gYGyGOqseUvvSeMePrMQFHhpcAhJPc8XLoQpqGqKW1Y/dN+6e1h7XgNE0Kk6eyi8+VSJ/FQSAiAkqVnxcG8UJL7XahYB4gEvXZFnfukEKj3fez0uQ9ZkubmzGDGUhvOShZ8yqTcfHCdaDOvLfxXGecpfuoiG/290mo2k=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3165.namprd18.prod.outlook.com (10.255.236.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 09:33:30 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 09:33:30 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: [PATCH v2 13/20] EDAC, Documentation: Describe CPER module definition
 and DIMM ranks
Thread-Topic: [PATCH v2 13/20] EDAC, Documentation: Describe CPER module
 definition and DIMM ranks
Thread-Index: AQHVlIU/GtvaA83eREuXj+Z4hz4EIg==
Date:   Wed, 6 Nov 2019 09:33:30 +0000
Message-ID: <20191106093239.25517-14-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 2a1a2d69-357c-4a73-1fe3-08d7629c6238
x-ms-traffictypediagnostic: MN2PR18MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB31650CC33ACC23A01E0D3D71D9790@MN2PR18MB3165.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(52116002)(305945005)(6486002)(76176011)(71190400001)(71200400001)(256004)(11346002)(446003)(7736002)(14444005)(6436002)(4326008)(6512007)(66446008)(66556008)(66476007)(66946007)(64756008)(5660300002)(1076003)(476003)(6116002)(3846002)(110136005)(54906003)(36756003)(2906002)(8676002)(99286004)(81166006)(81156014)(316002)(8936002)(50226002)(486006)(6506007)(386003)(102836004)(66066001)(2616005)(86362001)(478600001)(25786009)(186003)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3165;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BWEK9AYir7LdYl68B+5lxnEX0CZ2KWdV2Nr8JpI3QQoLXxTT2QZZPZClVwb6K+anG3W07PrvMjKlmVP/Usyyf1TfZf+ggQ40a+PeYR5aZMDhfAs0FMkZfaBaLggFTYtjhJWMkoEtZD3QASzPn/AWhIMGtCsfrdGg63HB+E1cLEKa+ck+jdeG393yZRkeRubD1z3uvdzEH5MjfqLDXvu/XzdMoHgDN2Um8ClvQkgbAlIAj/b03S87H5XL2GEmb19htuY7RDPtCnXRTSH2X4nXP2jobwpuHG3p0xlGpplF427KDJXB83vGDz+H5nNSpoASQUYJ04rzLvl6tO6x4LkWGqOXvM1Zoe10rgNLUwvo40TjXW0CnztpZDvuySfOx/Gv8+f2hE4g0qm4JYI/F08QaxRnP4IN1JX7q4Yl253QXvXLXnqjegVnyRCTyzeVvzbu
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1a2d69-357c-4a73-1fe3-08d7629c6238
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:33:30.1788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jG5x9JpgnoT9WcWC8A9H04R3i0oXAxJAyP4NEZB62EzTrOB/zwfw6DGHm+H6mqjS34+KESnVVlkTsY2Pbh6sqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3165
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Update on CPER DIMM naming convention and DIMM ranks.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/admin-guide/ras.rst | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/ras.rst b/Documentation/admin-guide/=
ras.rst
index 2b20f5f7380d..26e02a59f0f4 100644
--- a/Documentation/admin-guide/ras.rst
+++ b/Documentation/admin-guide/ras.rst
@@ -330,9 +330,12 @@ There can be multiple csrows and multiple channels.
=20
 .. [#f4] Nowadays, the term DIMM (Dual In-line Memory Module) is widely
   used to refer to a memory module, although there are other memory
-  packaging alternatives, like SO-DIMM, SIMM, etc. Along this document,
-  and inside the EDAC system, the term "dimm" is used for all memory
-  modules, even when they use a different kind of packaging.
+  packaging alternatives, like SO-DIMM, SIMM, etc. The UEFI
+  specification (Version 2.7) defines a memory module in the Common
+  Platform Error Record (CPER) section to be an SMBIOS Memory Device
+  (Type 17). Along this document, and inside the EDAC system, the term
+  "dimm" is used for all memory modules, even when they use a
+  different kind of packaging.
=20
 Memory controllers allow for several csrows, with 8 csrows being a
 typical value. Yet, the actual number of csrows depends on the layout of
@@ -349,12 +352,14 @@ controllers. The following example will assume 2 chan=
nels:
 	|            |  ``ch0``  |  ``ch1``  |
 	+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
 	| ``csrow0`` |  DIMM_A0  |  DIMM_B0  |
-	+------------+           |           |
-	| ``csrow1`` |           |           |
+	|            |   rank0   |   rank0   |
+	+------------+     -     |     -     |
+	| ``csrow1`` |   rank1   |   rank1   |
 	+------------+-----------+-----------+
 	| ``csrow2`` |  DIMM_A1  | DIMM_B1   |
-	+------------+           |           |
-	| ``csrow3`` |           |           |
+	|            |   rank0   |   rank0   |
+	+------------+     -     |     -     |
+	| ``csrow3`` |   rank1   |   rank1   |
 	+------------+-----------+-----------+
=20
 In the above example, there are 4 physical slots on the motherboard
@@ -374,11 +379,13 @@ which the memory DIMM is placed. Thus, when 1 DIMM is=
 placed in each
 Channel, the csrows cross both DIMMs.
=20
 Memory DIMMs come single or dual "ranked". A rank is a populated csrow.
-Thus, 2 single ranked DIMMs, placed in slots DIMM_A0 and DIMM_B0 above
-will have just one csrow (csrow0). csrow1 will be empty. On the other
-hand, when 2 dual ranked DIMMs are similarly placed, then both csrow0
-and csrow1 will be populated. The pattern repeats itself for csrow2 and
-csrow3.
+In the example above 2 dual ranked DIMMs are similarly placed. Thus,
+both csrow0 and csrow1 are populated. On the other hand, when 2 single
+ranked DIMMs are placed in slots DIMM_A0 and DIMM_B0, then they will
+have just one csrow (csrow0) and csrow1 will be empty. The pattern
+repeats itself for csrow2 and csrow3. Also note that some memory
+controller doesn't have any logic to identify the memory module, see
+``rankX`` directories below.
=20
 The representation of the above is reflected in the directory
 tree in EDAC's sysfs interface. Starting in directory
--=20
2.20.1

