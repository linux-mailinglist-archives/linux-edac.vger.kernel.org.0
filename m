Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D09E98839
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2019 02:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbfHVAAL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 21 Aug 2019 20:00:11 -0400
Received: from mail-eopbgr770075.outbound.protection.outlook.com ([40.107.77.75]:25798
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731051AbfHVAAE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 21 Aug 2019 20:00:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2eACpUYL9SutjzubHyhuodBzYwHWvDavto554NrTD07PyfM3MJWai8LYPi2xuLJn9cXsKkpna2nvswq/cGMr8jI6e/2RMafnlsKKOO1A/o41YTyfOqiBngYOJq2BzEZzDwOHcXpCvnF0wjqcno6XEfE/dmnaus5wvikUnjrGF0IICoCC1eIr1lUZrSlcxdgexKAgxXeQ5ub5Gw3U+xbTkhLpYjfVUPSRaQbScclW4HlXZflacODaq3efXZuT24Wz9woKn8g9zDzo//VJETcabc0HSPMYsD85wD84U1tZt/LIGAeRylrohzHXN+Fl1Xb8W7vvJ64jSEX2D8w+9tbIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhjE21YVmCHvMVtdQSvszbs/69fcd0N/kRVCotwQEa8=;
 b=nVS4pa5p2uci/9oVkwZpBdlq/pDZkcX8vkABp6yGkuB20cOnfEsUMb6cdyE8y59jCzGeyAzcHmJttdD1YEWQwpcRJPZ1HQi9ANoVtX+TNR1gy8l8bnLC02wdkz93/B6tb0yRz5+hoc0uYrAdZrAUsR9z2RV0nifPSWXQCmvE2liKX5O1ZyxEqovyPbWMGDuKboLkgTzNrgVvn0wh4qZ4/ImhNFwz9c8qwz0bSPyyVvdsbLhNjoQdWHSm91eskGmr7+TSErfQNzL6vaqgcMSnL2PodamE3yThtC6624URFL1o9h++lrQ0Uq70L/lRMTEpf/byaq8zRSvok2Y2k/n8Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhjE21YVmCHvMVtdQSvszbs/69fcd0N/kRVCotwQEa8=;
 b=I4wt6CuXnafHfgd7VIdRFlhGdSiPGca4lutfS+u2C7tNkEgLxEOIGeZcuQW/1zvzsOWTjIZEh6t5FuD4mu5crFDnhcV6yS6nKyh55hHPQd7govLb3oBJ4eDq5QKPKcCUKhq72tqRzzRrKQRVN2LYNgWP+6u/xjN3LR+5TZhgoI8=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2815.namprd12.prod.outlook.com (52.135.107.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 00:00:01 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53%2]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 00:00:01 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v3 5/8] EDAC/amd64: Decode syndrome before translating address
Thread-Topic: [PATCH v3 5/8] EDAC/amd64: Decode syndrome before translating
 address
Thread-Index: AQHVWHyKYFk6CqhKAkeMJOokY5XXRQ==
Date:   Thu, 22 Aug 2019 00:00:00 +0000
Message-ID: <20190821235938.118710-6-Yazen.Ghannam@amd.com>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0006.prod.exchangelabs.com (2603:10b6:804:2::16)
 To SN6PR12MB2639.namprd12.prod.outlook.com (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be3bdc7b-e349-4215-199b-08d72693ad4e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2815;
x-ms-traffictypediagnostic: SN6PR12MB2815:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB281504857BFC3CB8E2AF3CB7F8A50@SN6PR12MB2815.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(6486002)(8936002)(6436002)(81156014)(99286004)(50226002)(8676002)(26005)(81166006)(52116002)(2906002)(6916009)(53936002)(5640700003)(476003)(54906003)(66946007)(25786009)(66476007)(386003)(64756008)(66446008)(66556008)(186003)(2351001)(446003)(11346002)(316002)(6506007)(6512007)(6306002)(2616005)(486006)(102836004)(14444005)(36756003)(478600001)(71190400001)(256004)(86362001)(2501003)(1076003)(4326008)(5660300002)(7736002)(305945005)(6116002)(3846002)(966005)(71200400001)(76176011)(66066001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2815;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gwPYNc5zQw/jolQ+GD6L6dDiVOa/sPzQcYTuImi0wTOKOhpmSz4N1/Wr1SeT24TrVvMCakqPct11kuOBluSdR8jQPevRggYB5zR+gPclhlA/ytbyxM0WSzOu3845NUl0fnN1NTNnZVwTrEwgVhh6oTBWTi5mgU+h5vxBC9uo8VWHF8p2zAkwCW5Tr/5g7wLt4JD3iKuDpYpWpGBBzMbocKHPltmal3PIffO0M3YjAE5bSDfvnzfeMaCHCziXF6911s1ruiTtmZraZxWnpfn7hSRqs+5t+nOmJoc6CeaCIHK9uQP72WtEQNmZR0sUd51T04B50IhUGja8t6LF9354LBWKW6uKwMQRIP6kuP2dmeRK3AKLilZKHkCvoMu42oYxFuQ575XL8/bXFuH/DnJXcR1J10QHMn3A18JBNb+m6F8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3bdc7b-e349-4215-199b-08d72693ad4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 00:00:00.8297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GmleLp8DmRrA3yNokmGVcO0REynCgCjl4VgfXf+QjH559caIki0Chr0SgVYx9v9xOuyS4+4nWFNifTSfREbusw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
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
https://lkml.kernel.org/r/20190709215643.171078-6-Yazen.Ghannam@amd.com

v2->v3:
* No change.

v1->v2:
* No change.

 drivers/edac/amd64_edac.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index c4f2d7c59b04..de141de7b2e5 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2574,13 +2574,6 @@ static void decode_umc_error(int node_id, struct mce=
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
@@ -2597,6 +2590,13 @@ static void decode_umc_error(int node_id, struct mce=
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

