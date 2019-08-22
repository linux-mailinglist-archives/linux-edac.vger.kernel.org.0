Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C393E99F29
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2019 20:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391041AbfHVStB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Aug 2019 14:49:01 -0400
Received: from mail-eopbgr690068.outbound.protection.outlook.com ([40.107.69.68]:53823
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390392AbfHVStA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 22 Aug 2019 14:49:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAzFtntfi62y+Jh2qOx5SFFawLVEDCDCdaEPKnomy/TWzz74TXAaOq1jqTigu8KMxUWmJgdtcn3KQUcHzdgH4HnXsrvhUuyGC4EJzTen5nVB5POGNLnyPuwJXMocOPrNxLcPNw1PS2di1XBLx//t3FTYhQwcPaGetnyc6dZQgWZ9qpJG3wW/w5NmDJKB6Jud09/kuQ8JUooStBej3WHKCw8YN4zdtCXUmKdu6ftm6S54yGawZ7HOx6Bf3EoS7G6aogX+5ES6PNxRNOhmWH7UjoDaObamISCkN8f58FvnxZGTobJ51zL82tYrG3U+S4lajzNgrbT2g0YT3EEj08ufug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8tOYs/P0C1jrZrSMZd/iU96wMxYNdNq6HLU+AkCY90=;
 b=LooodlnJS2bvSgmNrlMYUNsqyi6SwMBR+qMWmHOn0K3D7SzlNp4SM0m/zsP5eW027/PQbGU2pIwpjivRwzFE0oxNxL4xj3l3x9veaTuopdMjLHc7ua2TzWzhSxHEnoUh0jMl66tJKi1Qd+qRI2FQ5TfnJx9nFPgIbMJGEk2YsU1o7cphCNqsVkWSrh3HXLID59d17c0wOy/vok8Jj982m342a47vrfyE6+xpwz3SFipxdwPRhhAa++fDmfWzqT1oTUgMf5FuYJYkxv106ZntSb4hRXPfxK9uMQzVaYU69OmWH65KDJdb0mpUAFDj4DncXUr1QzAxdVmSsi+ndHni/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8tOYs/P0C1jrZrSMZd/iU96wMxYNdNq6HLU+AkCY90=;
 b=E8GxFjID+5qqPObwUAS8ewJkQcXqzNCNAKZuzYS+08M/Of813//JAdcPKc9pTPSvcUpuf0O8Y+eMFMPBrxu4D+g9xomZ+bggzi1LySjuVwisK+LUji9jXjvMQoZhatU4p2kpilSy2EaRi57h0PiKJou9qQ/w1XunI6nAnl8RhEI=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2829.namprd12.prod.outlook.com (20.177.250.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 18:48:54 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53%2]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 18:48:53 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [RFC PATCH v2] EDAC/amd64: Check for memory before fully initializing
 an instance
Thread-Topic: [RFC PATCH v2] EDAC/amd64: Check for memory before fully
 initializing an instance
Thread-Index: AQHVWRo+xR0jdEvkBUStALn2kRVlFQ==
Date:   Thu, 22 Aug 2019 18:48:53 +0000
Message-ID: <20190822184843.187134-1-Yazen.Ghannam@amd.com>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0701CA0044.namprd07.prod.outlook.com
 (2603:10b6:803:2d::17) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0da1099-796a-4e82-ea83-08d727316152
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2829;
x-ms-traffictypediagnostic: SN6PR12MB2829:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB28299A1861B678662D6797DEF8A50@SN6PR12MB2829.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(199004)(189003)(50226002)(2906002)(186003)(6116002)(36756003)(3846002)(8936002)(11346002)(478600001)(53936002)(14454004)(316002)(25786009)(26005)(6486002)(6506007)(7736002)(6916009)(102836004)(386003)(5640700003)(476003)(2616005)(486006)(446003)(6436002)(305945005)(6512007)(6306002)(81166006)(81156014)(8676002)(256004)(66446008)(14444005)(66556008)(64756008)(66476007)(66946007)(5660300002)(76176011)(54906003)(1076003)(2351001)(66066001)(52116002)(4326008)(86362001)(99286004)(2501003)(966005)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2829;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YrKZt25+x7xEYbMo4bJNndD6l2VGk8ESUwXSyVVP7pdxQe9oJjxiPaPyVTNY2o+BxJxKjXOFhr/8oSQ/aTmt0yI7f7HrrfRD8Ku7QE5Cn1z6SpbPJGiDG1LQh2F5IPKuttYAJNhxr0iKaWSybDUTC5iGHmMNQl1oR21sPwA2/LwmOd6uXOOifLEnG3rgVaiNeR58rgaVQ8aghaIHaEc3WD2f9HsrEvLs0SqQV5i1qaKFVoT4FVFfUgpOUId+iEE9i1lWLvghE1+ilVo4TgPX6AcvX0/NZmfiyeFlDqxk++hw+YuQqo+1NR9XdBK6mlfTt2oFYBAwOdbkf6NjBXjQhBhlnpk18wXH7Gf9xQWdwJy3TZmUuVRzE/hDO20Fa64X1c48/yFVJLz5vNRGUn60AlifRgwrTIOam8B6XHJawCs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0da1099-796a-4e82-ea83-08d727316152
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 18:48:53.8237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O9YflhWcgta46s3XZ0zCMOTiHyjMUJasm0kqQuCVst+adnAK7YLlhIzbhvOyYMnTvuY9zHDuP7xjD0qMauzJdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2829
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

v1->v2:
* Moved hardware info printing to after instance is initialized.
* Added message for when instance has no memory.

 drivers/edac/amd64_edac.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index c1cb0234f085..3f0fe6ed1fa3 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2831,8 +2831,6 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
=20
 	determine_ecc_sym_sz(pvt);
-
-	dump_misc_regs(pvt);
 }
=20
 /*
@@ -3505,6 +3503,23 @@ static int init_one_instance(struct amd64_pvt *pvt,
 	return ret;
 }
=20
+static bool instance_has_memory(struct amd64_pvt *pvt)
+{
+	bool cs_enabled =3D false;
+	int num_channels =3D 2;
+	int cs =3D 0, dct =3D 0;
+
+	if (pvt->umc)
+		num_channels =3D num_umcs;
+
+	for (dct =3D 0; dct < num_channels; dct++) {
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
@@ -3535,6 +3550,12 @@ static int probe_one_instance(unsigned int nid)
 	if (ret < 0)
 		goto err_enable;
=20
+	ret =3D 0;
+	if (!instance_has_memory(pvt)) {
+		amd64_warn("Node %d: DRAM ECC disabled. No DIMMs detected.\n", nid);
+		goto err_enable;
+	}
+
 	if (!ecc_enabled(pvt)) {
 		ret =3D 0;
=20
@@ -3561,6 +3582,8 @@ static int probe_one_instance(unsigned int nid)
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

