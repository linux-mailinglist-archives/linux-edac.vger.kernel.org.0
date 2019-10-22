Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5FF3E0D57
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2019 22:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732995AbfJVUfZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Oct 2019 16:35:25 -0400
Received: from mail-eopbgr790088.outbound.protection.outlook.com ([40.107.79.88]:26304
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389525AbfJVUfY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 22 Oct 2019 16:35:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKDUFYpGv+peMVNFAUfHMVqkPXxt/TbnSgVIrPYSv3soqUPamUSJVvm2/IrFZaEa6Df5B914/bJdK4c6RPQQUnYW0flOKmf3G1GBBy60/7McWcLBeqDcVF/Pb/VhXNBAtoxX3GM+/E6pxWVBJSg3sC9r60u/cWyfnflC2Qj64jmHLG7PnUHKsUiaMlnCvnWwACRbS79Q3ZcQMH/c8v2SySvn4jMppg0psbs8kiGH/ge8oV1I9+9R4595D2l5FYFGwaqavjKp1Fafzw89dHwI2A8n5eI4hX6xrrA4jyt3Dw6Zu+N8fr02wHu8NfwbEQQVGZT5k1cbUVhMK+1ALE1qAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6mVHruVvrlSgNK5fP1y4irI0RNe/7mYnoODfU6YX+0=;
 b=a6Bq0RxJQcFViIQCMobWI90QZK9yvhlU1s+8xEM3VN+Z7WAQ8Eh2YOItW2UUe8/34pefW6nab+sCfsQPLLJJPBl1XfA6+7hn6V13NBveyeTLFMWqmpdGMIn0USAwX28WpoCW2ow9Ns9v57EMtvCqbwp3fzYmv3X0jas+HnBetVh5l/gdl4YmnpJn06O0Y1Zu8IwXdGAHdZ9b/fnIOlvoVaoZOvh69pqU1zNorsIWjQRUl4p0Y6tZLqAnCu2qT1ZAJxT1yQD5EYGCoAHL/Sa0fbn+4lKQfjSjWBv3+TvstAo/puR39QE75lGNy39EMHR2HKv2OtALStB2aY6s0rGviw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6mVHruVvrlSgNK5fP1y4irI0RNe/7mYnoODfU6YX+0=;
 b=l7IRJ3GONiZbTe8wQWzG3bpbiOOG8mfidmdN9cvtVIUyx3RkMVtsVrQil0cyGB7+azC8AUMw2OxzDw7I9HhUtOQoBrgNt7eNrpL03Nn0hBH8lf/HE6afusmr46tZ9zpxpfJhCliX6wws6cif4TWNvS3lXVYST209g+dG/pJsQyU=
Received: from BN7PR12MB2628.namprd12.prod.outlook.com (20.176.178.20) by
 BN7PR12MB2724.namprd12.prod.outlook.com (20.176.178.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 20:35:13 +0000
Received: from BN7PR12MB2628.namprd12.prod.outlook.com
 ([fe80::2115:dffc:44b6:e53a]) by BN7PR12MB2628.namprd12.prod.outlook.com
 ([fe80::2115:dffc:44b6:e53a%6]) with mapi id 15.20.2347.029; Tue, 22 Oct 2019
 20:35:13 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v2 5/6] EDAC/amd64: Check for memory before fully initializing
 an instance
Thread-Topic: [PATCH v2 5/6] EDAC/amd64: Check for memory before fully
 initializing an instance
Thread-Index: AQHViRg0iEJ85ugwuE2Gps0HSGXHgQ==
Date:   Tue, 22 Oct 2019 20:35:13 +0000
Message-ID: <20191022203448.13962-6-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 31b1de93-726a-4e5f-7714-08d7572f56d3
x-ms-traffictypediagnostic: BN7PR12MB2724:
x-ms-exchange-purlcount: 1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR12MB2724CD95E0B5C2B742693D6BF8680@BN7PR12MB2724.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(189003)(199004)(25786009)(36756003)(54906003)(316002)(2906002)(14444005)(256004)(66066001)(6916009)(52116002)(71200400001)(71190400001)(76176011)(2351001)(2501003)(6116002)(26005)(99286004)(186003)(6512007)(4326008)(6436002)(966005)(1076003)(102836004)(305945005)(5640700003)(7736002)(6486002)(386003)(6506007)(6306002)(14454004)(3846002)(478600001)(2616005)(486006)(476003)(8936002)(66446008)(11346002)(446003)(50226002)(66476007)(81166006)(66556008)(64756008)(8676002)(81156014)(5660300002)(86362001)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2724;H:BN7PR12MB2628.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ULNF4jVRwagW9Kls/WLl/YvaNtNVGJ2Nu/SBafi68ycTB4ojSIlZWWNPnkWjAY8kNEVNjEp3DftpWgrJ4k5o2w6+F9LAS9u4sIrtizAXQoqHkvxiBnRpsxKZwWxOnHLFnCaOXQsKnyMjwoZzOvTzmFdWtzA5heGcwLE44aoNxYG/P7+2hNO8pnrl3eTF+FocsVzcRYwyFPJLWS5o33gVFzQDi66EcQ3/u/fnBb92D5oPRcIGXEQTE8L1MLGE1SJRuUbSF+sRhLhZN9OLNd7L+Tu0nKP/wqsO4ClqJfL8PVSD/W2OgJbh/yuzr/2+lAbZzfzSZMEvkfJTRY0h/B6Clu4h724AebWvbz507o+y9wP/utbHRTc1TW9Ro2tfVuD8KSi26EtIcgVBdknLrTjTWj9suOaY6YG3NoEFBzVL5WAx7tbb0yO72gMVJ1ISCFPNiKss8cNvCEynGzjP07pPt6NgaqzjqPd82ISepoVPr6c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b1de93-726a-4e5f-7714-08d7572f56d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 20:35:13.1790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l88VY4K0oL3IjT+jpfVfevNDsGK6KwYhfetzNwfUgCeslovxrNSM0EdNEFQyf63+Gf1y6jwiDtS3Z+Se16mUHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2724
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Return early before checking for ECC if the node does not have any
populated memory.

Free any cached hardware data before returning. Also, return 0 in this
case since this is not a failure. Other nodes may have memory and the
module should attempt to load an instance for them.

Move printing of hardware information to after the instance is
initialized, so that the information is only printed for nodes with
memory.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20191018153114.39378-6-Yazen.Ghannam@amd.com

v1 -> v2:
* No change.

rfc -> v1:
* Change message severity to "info".
  * Nodes without memory is a valid configuration. The user doesn't
    need to be warned.
* Drop "DRAM ECC disabled" from message.
  * The message is given when no memory was detected on a node.
  * The state of DRAM ECC is not checked here.

 drivers/edac/amd64_edac.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 6b6df53e8ae7..114e7395daab 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2848,8 +2848,6 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
=20
 	determine_ecc_sym_sz(pvt);
-
-	dump_misc_regs(pvt);
 }
=20
 /*
@@ -3489,6 +3487,19 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	return 0;
 }
=20
+static bool instance_has_memory(struct amd64_pvt *pvt)
+{
+	bool cs_enabled =3D false;
+	int cs =3D 0, dct =3D 0;
+
+	for (dct =3D 0; dct < fam_type->max_mcs; dct++) {
+		for_each_chip_select(cs, dct, pvt)
+			cs_enabled |=3D csrow_enabled(cs, dct, pvt);
+	}
+
+	return cs_enabled;
+}
+
 static int probe_one_instance(unsigned int nid)
 {
 	struct pci_dev *F3 =3D node_to_amd_nb(nid)->misc;
@@ -3518,6 +3529,12 @@ static int probe_one_instance(unsigned int nid)
 	if (ret < 0)
 		goto err_enable;
=20
+	ret =3D 0;
+	if (!instance_has_memory(pvt)) {
+		amd64_info("Node %d: No DIMMs detected.\n", nid);
+		goto err_enable;
+	}
+
 	if (!ecc_enabled(pvt)) {
 		ret =3D 0;
=20
@@ -3544,6 +3561,8 @@ static int probe_one_instance(unsigned int nid)
 		goto err_enable;
 	}
=20
+	dump_misc_regs(pvt);
+
 	return ret;
=20
 err_enable:
--=20
2.17.1

