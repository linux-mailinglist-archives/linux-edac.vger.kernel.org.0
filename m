Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 736E1F0BA2
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 02:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbfKFBZI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 Nov 2019 20:25:08 -0500
Received: from mail-eopbgr820079.outbound.protection.outlook.com ([40.107.82.79]:36833
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730769AbfKFBZH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 5 Nov 2019 20:25:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1nuv38WwZJnbEczTqPaZ4qTRxD3/zxLRUUx2RAVnxzQdlLl0HLXRT6cCBCg3YTGKSidcrzoqVmvr/zyNaSsZlYMeR098i0oQTq3x83GmEXf2ZVQ84SyM7BWObqkiNZFf4MuNP8jSjcuyXSjZgYNFV6BwG8CnzjgTucOSG9nVpU9F+E+zGddFEHV4NL3yh6gD83ecx/kePYdfse6a1AuqYI5TeHx85TQYebjY1JejhSYJ3xgzIs2dr3+4CKPpmpwWCotWeGDKDnw0YEXVs2D2D9ThcQ+D8ur0Bu/Mvs31zFDzDACg3/E9RJFxMDvWWm9TjgjboSrobS0FHH8a8nEgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPdFnmmQ0WisiQ0Q2OwvnHI7ffddDpTtaxufw+gY9Ng=;
 b=QKPYw3bQHr48/mWhTR3xvzyad1v1dq7gOJW0hBJM3j2Zf/PNzJRzk31OMvEE5PsbUJFZpwDMFufUwcUu5/IgEJ5zr+FaI9c+F9um0IFD/Foa3riVgOPcp6wEprs8sn1uXj2cOQSoLNiGfQ0SOmxojiOqKisrBzJ9PE9xrnkcLJIQo27xyTxLlo5AktijZmqwQ5Y53b13hy4g3R1j3j4KII2hmWuDPn5ERXyEO0o+8Wju94cihTi5Phe/SbfAiLf9tfabtuLHFUfvSCkSix8Xc3xiEV/U/YqJLGTN3rRTIAK6gSknUL5OgtdCWiKssFvnImgtseMFV1YMf7yGlZl5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPdFnmmQ0WisiQ0Q2OwvnHI7ffddDpTtaxufw+gY9Ng=;
 b=tJlAKsaR3sf8rbxxlc+RkQAczVwwLAU2W/rD5akdkp/tpQfXbIWpPuKYPXINGHjaoLZ5yglaj6wd4S1iZD13PM4NUw3uY9aW7JPB416tXlCAYkxkf81PbZc6UEI7Jg4zwoDKwsFaBbij2o82/HH7TBce5US6h5J8yEPPuWDsR4g=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2783.namprd12.prod.outlook.com (52.135.107.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 01:25:02 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba%3]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 01:25:02 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v3 5/5] EDAC/amd64: Check for memory before fully initializing
 an instance
Thread-Topic: [PATCH v3 5/5] EDAC/amd64: Check for memory before fully
 initializing an instance
Thread-Index: AQHVlEECwn3bnSYYRUK/Y8obdVXQEg==
Date:   Wed, 6 Nov 2019 01:25:01 +0000
Message-ID: <20191106012448.243970-6-Yazen.Ghannam@amd.com>
References: <20191106012448.243970-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20191106012448.243970-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0064.namprd12.prod.outlook.com
 (2603:10b6:802:20::35) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9490d007-b841-40b9-5b25-08d762582527
x-ms-traffictypediagnostic: SN6PR12MB2783:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2783B0C8CE9EFBD9DB6F1D4BF8790@SN6PR12MB2783.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(189003)(199004)(186003)(5660300002)(86362001)(386003)(4326008)(102836004)(6506007)(1076003)(52116002)(966005)(6306002)(2906002)(5640700003)(99286004)(6116002)(36756003)(54906003)(14454004)(25786009)(486006)(66556008)(446003)(11346002)(81156014)(6916009)(76176011)(305945005)(7736002)(26005)(6512007)(2616005)(66066001)(2501003)(66946007)(316002)(64756008)(478600001)(50226002)(71190400001)(71200400001)(81166006)(8676002)(256004)(14444005)(2351001)(8936002)(6436002)(476003)(6486002)(66446008)(66476007)(3846002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2783;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FXdAP/lf7i1CaFONqkSjRlbTHRp1IzTJZDNw8rH0akyRQC3R1C+MsgYV0dRyjGP3Zn621exBVhVQpEdPpKUigoqVPRYiw14FIdfFT5mp1U4WgH7SGOD4u9Lzjn8BQnPXfX3FzWi8hf9CkQs4/CORdGAYZFRsKXHQH1iyvnoBcmjGbHnyMG9gJRZj0e7yraI5Tq/FUofWZMGKeMFwChTBP/zQJnk7sBR+4MRStU4+iA4Nlytqp78mlRmA7CyLneTzaKULBrHcia23LZ3H4oXnz84GNH3rI1LDqqvgZX4f48OJgM0OOvqP9qic/Vamo8MLwE0tt4TMAc8G+8FVpJIgTTVSDBQiowO1Pe0O0/VxJjmnjWUOMt7wcX9Q9Uw5u0cy+98mQD1BDho2nuVZVxdoVZZRgwdrBb7boPAOgeFzxLQgghIbeFfP4cVhEQzFXz1KETS4bsJIT8OWAEXAKoZ8q776+8T0icPXFyOkyzjjUoI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9490d007-b841-40b9-5b25-08d762582527
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 01:25:01.8663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fr3XO24ZneFR/53ODEKtq0TjjlSPV2G0lQIx39A8fKdIpDKsveTshO5Qz/h+PJtWuz/nG9elsrKrJFshfS+12w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2783
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

Return an error code when ECC is disabled. This check happens after
checking for memory. The module should explicitly fail to load if memory
is populated on a node and ECC is disabled.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20191022203448.13962-6-Yazen.Ghannam@amd.com

v2 -> v3:
* Add error code to !ecc_enabled() path.

v1 -> v2:
* No change.

rfc -> v1:
* Change message severity to "info".
  * Nodes without memory is a valid configuration. The user doesn't
    need to be warned.
* Drop "DRAM ECC disabled" from message.
  * The message is given when no memory was detected on a node.
  * The state of DRAM ECC is not checked here.

 drivers/edac/amd64_edac.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index d38ba7f17753..3aeb5173e200 100644
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
@@ -3491,6 +3489,19 @@ static int init_one_instance(struct amd64_pvt *pvt)
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
@@ -3520,8 +3531,14 @@ static int probe_one_instance(unsigned int nid)
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
-		ret =3D 0;
+		ret =3D -ENODEV;
=20
 		if (!ecc_enable_override)
 			goto err_enable;
@@ -3546,6 +3563,8 @@ static int probe_one_instance(unsigned int nid)
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

