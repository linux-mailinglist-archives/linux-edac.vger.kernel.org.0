Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8DC863DA3
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2019 23:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfGIV5B (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Jul 2019 17:57:01 -0400
Received: from mail-eopbgr690059.outbound.protection.outlook.com ([40.107.69.59]:63872
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727026AbfGIV5A (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 9 Jul 2019 17:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhaUkSx0NsBBYsqXRQ6MDnkdji70rk7l3dlD1UaNmgM=;
 b=VIMfhrTaemKEF8+RPAMXsJ9QmxH+zku8pKIAK49edBX8XEaP8voF4f2VAqf4CHs/oDFGcmg+1dhaBpfIdCLUqAVGJKfec8fLX8OXxwaRDlFFCNCy2pA4jb7aRsnR2P+Q8i0rleNYNBNaby4WdVdtw4kYT02vfJWc3gt8a8aSaGk=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2718.namprd12.prod.outlook.com (52.135.103.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Tue, 9 Jul 2019 21:56:57 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::fd06:e03b:2b06:e8d7]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::fd06:e03b:2b06:e8d7%6]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 21:56:57 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v2 5/7] EDAC/amd64: Decode syndrome before translating address
Thread-Topic: [PATCH v2 5/7] EDAC/amd64: Decode syndrome before translating
 address
Thread-Index: AQHVNqE6YZEPPaJGlkOX/sPL2pGVag==
Date:   Tue, 9 Jul 2019 21:56:57 +0000
Message-ID: <20190709215643.171078-6-Yazen.Ghannam@amd.com>
References: <20190709215643.171078-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190709215643.171078-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0034.namprd04.prod.outlook.com
 (2603:10b6:803:2a::20) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f32ed1c-13bb-4a84-45a9-08d704b85c8d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2718;
x-ms-traffictypediagnostic: SN6PR12MB2718:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB27188F31CEB258FDFE39035DF8F10@SN6PR12MB2718.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(199004)(189003)(6506007)(53936002)(386003)(76176011)(26005)(2351001)(186003)(2501003)(14444005)(256004)(6116002)(99286004)(52116002)(102836004)(6306002)(2906002)(6512007)(68736007)(1076003)(6916009)(305945005)(5660300002)(66066001)(3846002)(6436002)(50226002)(66446008)(66556008)(66476007)(66946007)(64756008)(71200400001)(36756003)(71190400001)(2616005)(8676002)(81166006)(966005)(25786009)(316002)(81156014)(446003)(4326008)(54906003)(11346002)(8936002)(14454004)(486006)(478600001)(86362001)(5640700003)(7736002)(6486002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2718;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WbKmfGb1RygwzbV/dueYs85gIkapuoEZUa3muIyU20fDCBQIq9xQ3QLXOpLxmnL7mZY35cctLfUABv5m+VmRY3nw/1RUtOjybH73+YiKU/twPV6XMW1JggW7S8FfCjewGzaZAvnwmlepIkRt4EmhklBcfSzVUWxhVg0CEqPTTHNWXOm64xoMMGHhIHbV1o9wB9RSyjtzkLD/dLrCJXTm9qDjMaseA25kf+2m65D//HrPnKTJsgXRNTCHggbePK9MTDv6UonJ9PqqI3QjX5XIOHig9GANpvwQWS7QBS7wGek8zlqErk3mdiUwY1r0OurIMeEgRkGojUYrmLCCdfszsEQ39md8xlpPlcEkhlweKY5GA+J3opfo2dsGVjdz6rWfce0F8JBoMhG3SjjWiQxl4A6Yu/LtCgrrN95HhytHP74=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f32ed1c-13bb-4a84-45a9-08d704b85c8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 21:56:57.1858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2718
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

AMD Family 17h systems currently require address translation in order to
report the system address of a DRAM ECC error. This is currently done
before decoding the syndrome information. The syndrome information does
not depend on the address translation, so the proper EDAC csrow/channel
reporting can function without the address. However, the syndrome
information will not be decoded if the address translation fails.

Decode the syndrome information before doing the address translation.
The syndrome information is architecturally defined in MCA_SYND and can
be considered robust. The address translation is system-specific and may
fail on newer systems without proper updates to the translation
algorithm.

Fixes: 713ad54675fd ("EDAC, amd64: Define and register UMC error decode fun=
ction")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190531234501.32826-7-Yazen.Ghannam@amd.com

v1->v2:
* No change.

 drivers/edac/amd64_edac.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f0424c10cac0..4058b24b8e04 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2567,13 +2567,6 @@ static void decode_umc_error(int node_id, struct mce=
 *m)
=20
 	err.channel =3D find_umc_channel(m);
=20
-	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_a=
ddr)) {
-		err.err_code =3D ERR_NORM_ADDR;
-		goto log_error;
-	}
-
-	error_address_to_page_and_offset(sys_addr, &err);
-
 	if (!(m->status & MCI_STATUS_SYNDV)) {
 		err.err_code =3D ERR_SYND;
 		goto log_error;
@@ -2590,6 +2583,13 @@ static void decode_umc_error(int node_id, struct mce=
 *m)
=20
 	err.csrow =3D m->synd & 0x7;
=20
+	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_a=
ddr)) {
+		err.err_code =3D ERR_NORM_ADDR;
+		goto log_error;
+	}
+
+	error_address_to_page_and_offset(sys_addr, &err);
+
 log_error:
 	__log_ecc_error(mci, &err, ecc_type);
 }
--=20
2.17.1

