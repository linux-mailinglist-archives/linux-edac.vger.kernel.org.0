Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7301E0D55
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2019 22:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbfJVUfY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Oct 2019 16:35:24 -0400
Received: from mail-eopbgr790088.outbound.protection.outlook.com ([40.107.79.88]:26304
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388799AbfJVUfX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 22 Oct 2019 16:35:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgoOEzdNyXlD5aY3+9W3ESwtcnIkMC8e2jr7cO71lrOnRV4K6npBj6dp4s4ZYnOPpGafB8WzqvCnVHDTXb/C6YBWHRzMxj2bUypNJIQNud0WNPl+FihUcDuY5QDK7NffZDgpBRqn65w+rUj2gjCRQV+GW6E3/ErJ6hqmB7U9fkmEQkDeKBtdND8ioDYVKkwCe9C9heSsADJoSR6JWun14PZsQrwGbzvQswnc2KD8nQmHnBeV0MFXH66qCq++PEp11SRAtVRvaF3oBqND6Jt+Tzyr/yQifoY99s5/8l46IZgXw4UZPd/3sjSRTqgf/4ZoPkXWU8sVtfpISF6vXBSPpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TihJG6dFmN5GD0edAU7KW6s+D7DH1wOrhZOcyziEIU0=;
 b=cWtFd2PtuVxOOaHVwfS/akQq+BOEtJ/+in2xHrcNj9pP6rp4qoKZPHM6mwVR+RzMkNtdo374F2xMGRKU5x3ELPLLa2wJVQk47SG/wXPPrqb/8AvbuJxDwg84kdf4qVfnZ2evrIMFSfxGfnLx126zlf38g0LqeUK5b+6GGnQJqgPwHMcg+nK1999OLzAHU2Tfcr3w8F0S9Wb7bAIo3u4TphXaSIHzD8WoqyoKY8YDyh43eTmIcVc+ik1b5eHlHcYnNEwuFsGSAXxJ7IJQJHqpYGqqL0TyKCMDNFvHlWWbEyRcJHd+0uiG3WwvOgq4lKEZgOASHS9RdkyqI6fX1luvrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TihJG6dFmN5GD0edAU7KW6s+D7DH1wOrhZOcyziEIU0=;
 b=foSoNi3oOHQpU0JiBgFDZ4ar94vnsZ1dfB7Ahp1fuXOIDrEz1hwFsjVAC01dptUaBPhDvim21nemiK+cOAyhDxVThBt5mlSJuf2w2z++dLWp4fp5nw7Ndvo3JBsmunUT4X4+wGWBdzlO2H+EVditkQUXhcMVt4dJ3nGks+1CPzo=
Received: from BN7PR12MB2628.namprd12.prod.outlook.com (20.176.178.20) by
 BN7PR12MB2724.namprd12.prod.outlook.com (20.176.178.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 20:35:12 +0000
Received: from BN7PR12MB2628.namprd12.prod.outlook.com
 ([fe80::2115:dffc:44b6:e53a]) by BN7PR12MB2628.namprd12.prod.outlook.com
 ([fe80::2115:dffc:44b6:e53a%6]) with mapi id 15.20.2347.029; Tue, 22 Oct 2019
 20:35:12 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v2 4/6] EDAC/amd64: Use cached data when checking for ECC
Thread-Topic: [PATCH v2 4/6] EDAC/amd64: Use cached data when checking for ECC
Thread-Index: AQHViRgzqUXQe6JrSUGwHvuLMkPd5g==
Date:   Tue, 22 Oct 2019 20:35:12 +0000
Message-ID: <20191022203448.13962-5-Yazen.Ghannam@amd.com>
References: <20191022203448.13962-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20191022203448.13962-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0024.namprd05.prod.outlook.com
 (2603:10b6:803:40::37) To BN7PR12MB2628.namprd12.prod.outlook.com
 (2603:10b6:408:30::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc1e556a-bd72-4df2-3be6-08d7572f563f
x-ms-traffictypediagnostic: BN7PR12MB2724:
x-ms-exchange-purlcount: 1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR12MB27246C8C9B57A43E6C4A9130F8680@BN7PR12MB2724.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(189003)(199004)(25786009)(36756003)(54906003)(316002)(2906002)(256004)(66066001)(6916009)(52116002)(71200400001)(71190400001)(76176011)(2351001)(2501003)(6116002)(26005)(99286004)(186003)(6512007)(4326008)(6436002)(966005)(1076003)(102836004)(305945005)(5640700003)(7736002)(6486002)(386003)(6506007)(6306002)(14454004)(3846002)(478600001)(2616005)(486006)(476003)(8936002)(66446008)(11346002)(446003)(50226002)(66476007)(81166006)(66556008)(64756008)(8676002)(81156014)(5660300002)(86362001)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2724;H:BN7PR12MB2628.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wV2eUPRmMfqpB4eaACiNWDzB/NLGYj1ZPxHlpHeXbJhWWX3foqhOOARx1qu0mFtV3WqFGTbNRtwjoSi44QLM45W+AizJorpmLkpjonrngfvrnVOUBfJ75/co5HTUB9h/NSvmp26FACsJN2iKCGhA4QoxA0sQPfYJZvyFar2II4xGCPqI1ufgEhnE+NIa6js9ucyHQd8CyMc1ZzmUizkZzGqUCYuqaOjxZTGRFkexqqggLX4EGRyEBBwR7bq+Kjc+QGw71Hre9ta0QNFj8sBBW45IX4VYHNSh6qMAsJkk+9HhGhyVs7ThOGSiXMWOJHEZ+SgFJ/HpE9Yz4Uc7Mji+6lngPYQscg6b350K9g+tZEazW6dsJRVSBzSjWJWxptFMSQgm1AdlkqRR9cJzms6np3my8vCcAgKpr94la0CAdtxEgUd7yQGQaETNBWiXtJU5RewQ2nG+WoUoQ6/+AfI06yOHp6QqVOMcHm0p4XLE5Q8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1e556a-bd72-4df2-3be6-08d7572f563f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 20:35:12.1616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWIyBJQnfbjoB9ss8MMrmLGSTLlaxglN5BTVuQ2vC/o58kArukLu0BRZssKl+KzsffAeZE1j8xtFOsgjfWmjxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2724
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

...now that the data is available earlier.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20191018153114.39378-5-Yazen.Ghannam@amd.com

v1 -> v2:
* No change.

rfc -> v1:
* No change.

 drivers/edac/amd64_edac.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2d8129c8d183..6b6df53e8ae7 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3200,31 +3200,27 @@ static const char *ecc_msg =3D
 	"'ecc_enable_override'.\n"
 	" (Note that use of the override may cause unknown side effects.)\n";
=20
-static bool ecc_enabled(struct pci_dev *F3, u16 nid)
+static bool ecc_enabled(struct amd64_pvt *pvt)
 {
+	u16 nid =3D pvt->mc_node_id;
 	bool nb_mce_en =3D false;
 	u8 ecc_en =3D 0, i;
 	u32 value;
=20
 	if (boot_cpu_data.x86 >=3D 0x17) {
 		u8 umc_en_mask =3D 0, ecc_en_mask =3D 0;
+		struct amd64_umc *umc;
=20
 		for_each_umc(i) {
-			u32 base =3D get_umc_base(i);
+			umc =3D &pvt->umc[i];
=20
 			/* Only check enabled UMCs. */
-			if (amd_smn_read(nid, base + UMCCH_SDP_CTRL, &value))
-				continue;
-
-			if (!(value & UMC_SDP_INIT))
+			if (!(umc->sdp_ctrl & UMC_SDP_INIT))
 				continue;
=20
 			umc_en_mask |=3D BIT(i);
=20
-			if (amd_smn_read(nid, base + UMCCH_UMC_CAP_HI, &value))
-				continue;
-
-			if (value & UMC_ECC_ENABLED)
+			if (umc->umc_cap_hi & UMC_ECC_ENABLED)
 				ecc_en_mask |=3D BIT(i);
 		}
=20
@@ -3237,7 +3233,7 @@ static bool ecc_enabled(struct pci_dev *F3, u16 nid)
 		/* Assume UMC MCA banks are enabled. */
 		nb_mce_en =3D true;
 	} else {
-		amd64_read_pci_cfg(F3, NBCFG, &value);
+		amd64_read_pci_cfg(pvt->F3, NBCFG, &value);
=20
 		ecc_en =3D !!(value & NBCFG_ECC_ENABLE);
=20
@@ -3522,7 +3518,7 @@ static int probe_one_instance(unsigned int nid)
 	if (ret < 0)
 		goto err_enable;
=20
-	if (!ecc_enabled(F3, nid)) {
+	if (!ecc_enabled(pvt)) {
 		ret =3D 0;
=20
 		if (!ecc_enable_override)
--=20
2.17.1

