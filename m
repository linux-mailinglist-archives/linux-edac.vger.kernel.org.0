Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 211C5DC889
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2019 17:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633135AbfJRPbi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Oct 2019 11:31:38 -0400
Received: from mail-eopbgr720052.outbound.protection.outlook.com ([40.107.72.52]:48496
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2501906AbfJRPbh (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 18 Oct 2019 11:31:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mapa8PI2QyeSUY0KQON7HmLzYgWj+y18HnKp1DsxrXFO32EOUent9xe2+XVIkw8C5+HFRJXK6FgeEGseqHhMkK47onDs+rJBcJZgh3+MFxJTOAkQQIwazprZcqkD1WHAcu1efDkORkMnaRu2r1HLTWocRrW8otdhQXZl81vJph3J8zp+WDa834RAsG8f85XurTueIbIgroF3iUnhuVwLu/LL4Q85xr8rOwkoJ6/E6bcPzpJvF+ozip3ZPfjpIJHYcml+m7KkJxgH5l9oN11lwsivGrxAujsOkKvu/Qzd8M/cceuGm8E+sEutjV8wf1E44KdTANmzJBmVRWAGNoCtTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KC8zJqJtdxmy/HxrTxNIEVgY48Vc+1j1tgy8Abxr7mM=;
 b=VSPwO+Z2Ql6FRhNM3l65lzr2Eequ4zCs0cyW4Fca34CnfwtNFU77yR3zesNoduv4W8W7EA4QLNJF8V3QLW/yRDV71uVo9L1eeww89rsMgUeBYnm2iIrbblqduI4f/UsldU6dp9Ln8mg8rnD0q/wVn1RRESI9NTk3bz9Ra75RAkUnraHN+XrTwGQI+ZDkwwhYK3QJFrygXVwcFlCVRU41svfsxxzQQki713FXRxExvCpIJiE+Vqx/iBTurO+F8w7YuqzjqOP8qfCVa1y569/t3WSu4H3ZiC3Zdq45Pk0qeR8GJgqhQlR3Su/kpl58r9dmGclda+wINM/WVc2u/seNvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KC8zJqJtdxmy/HxrTxNIEVgY48Vc+1j1tgy8Abxr7mM=;
 b=wijl5GYz8QrLqyatCr235iBzgJUH8yHk/APDIiNlrS/hEmZF2UYZ49oIxi0mFvvJqUjnHXE49q5vEK/+AbKs2STUcnqK1NQ5fXS6sj+5bn6ZCMHWMfGA4cDiQKTHO4jeeUEcvJL6Q9ougqa46DHlgx03o4eb5yoIEJrfq0X8/k8=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2608.namprd12.prod.outlook.com (52.135.102.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Fri, 18 Oct 2019 15:31:28 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8%7]) with mapi id 15.20.2367.019; Fri, 18 Oct 2019
 15:31:28 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH 5/6] EDAC/amd64: Check for memory before fully initializing an
 instance
Thread-Topic: [PATCH 5/6] EDAC/amd64: Check for memory before fully
 initializing an instance
Thread-Index: AQHVhckb2h8vvebLQEi9ylCDe5/coQ==
Date:   Fri, 18 Oct 2019 15:31:27 +0000
Message-ID: <20191018153114.39378-6-Yazen.Ghannam@amd.com>
References: <20191018153114.39378-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20191018153114.39378-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0046.namprd12.prod.outlook.com
 (2603:10b6:802:20::17) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5b276ba-5d6f-4578-d788-08d753e03e2a
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR12MB2608:
x-ms-exchange-purlcount: 1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2608FE4722736928E24632C2F86C0@SN6PR12MB2608.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(189003)(199004)(6506007)(386003)(186003)(2906002)(6512007)(6436002)(6486002)(2351001)(6306002)(3846002)(478600001)(6116002)(5640700003)(7736002)(305945005)(26005)(102836004)(966005)(446003)(76176011)(71190400001)(71200400001)(66446008)(64756008)(66556008)(66476007)(66946007)(11346002)(476003)(256004)(14444005)(2616005)(52116002)(50226002)(86362001)(6916009)(99286004)(8936002)(81156014)(25786009)(81166006)(486006)(8676002)(2501003)(36756003)(1076003)(5660300002)(4326008)(14454004)(316002)(66066001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2608;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mxzz45lXjBfdsfBs/3p95V1h5ag1c+tF1v/Nv2yyOJP/FbEXb3Ml/xzNCuTYA7AsOkyoEo2pJFigp1a+TLUzB+rpjicDqDuhpV+TuyHEwbMojth2nf86lrEkI1oLudseNYB+K/SiEujZ78q91PM7f3IV+9x74GbPXRIm80hnfkfWKAl5W7zRuozCN+mJBv/kLY4udLUcOqiEKSZYpHvxk8WbSsRie/8Pqlt9Q4iHXdj9t2O9zkcYciGV7UHRQQ6mdDZ/TKYLOmDuTbymyUkjSNfdUgVYNxKaDVsbEokB2212qMmIATeM7aAiGa62YKqzsHllC0+8Zi3F38fHBunUIs29W92TCB+qppXjpaBvr4YD7ARknonupKvaU4FNkaLeYvvygrE6R7n5YNkLrWFP2XjGGtC1hOTc3/kzIcel2+8bLD5mdMy1udza8RniVPRTs1B12RZF2q4TqISZeEiGSA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b276ba-5d6f-4578-d788-08d753e03e2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 15:31:27.9347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abyQS1ckWwzBYaAXq52dLlTYivEX3bOz8Ahchx+qA/C+iE3ALWiD0E/roZD5fQHNC+uKWWdwUbyLUHQ+WJGaWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2608
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
https://lkml.kernel.org/r/20190821235938.118710-11-Yazen.Ghannam@amd.com

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
index feb68c0a3217..2a0a8be8f767 100644
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
@@ -3501,6 +3499,19 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	return ret;
 }
=20
+static bool instance_has_memory(struct amd64_pvt *pvt)
+{
+	bool cs_enabled =3D false;
+	int cs =3D 0, dct =3D 0;
+
+	for (dct =3D 0; dct < fam_type->max_num_controllers; dct++) {
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
@@ -3530,6 +3541,12 @@ static int probe_one_instance(unsigned int nid)
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
@@ -3556,6 +3573,8 @@ static int probe_one_instance(unsigned int nid)
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

