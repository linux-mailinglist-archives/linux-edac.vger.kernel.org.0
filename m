Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 713ADF0BA4
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 02:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbfKFBZM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 Nov 2019 20:25:12 -0500
Received: from mail-eopbgr820079.outbound.protection.outlook.com ([40.107.82.79]:36833
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730054AbfKFBZG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 5 Nov 2019 20:25:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgJ+uxPDG5dnghBLyTIABUY9TXsvomDszrr//hsPJNDUynbu1Agqh//fFFR97Fm/FXVA82kPCbalzLNqWxA/DlJhsxTC8s018XjIdWyLpPwqtC3shQM5ZLWy8m2QDzM4upJC/Rj8orwVXSD0/hhtKVcjr1s9Bs999c2UKKIlEFHl5gdLk9I6lA9N8SFy76kwqD9jVh+SERwQd4aMHkJdpWm7B9aCH+Ff8tT1OjZutaYeYI9LWNFyhUfokcrXo+y1fIXNWzByVLZlS9Xill/847b2NOFGDdHEGyrt/Lcq5KGCKrlRyqAqHuFfaYBZ+lH85oPtXn9BTmn2Eo3gEfrAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqtSPXqdjK5wC9DWxR4RJpgEYpj1wC54IHBLfa85jRc=;
 b=asbpBeYKP+Fkx7lWnXvJeafcsjMBcxIAe+Ed91C/ixUr64BAWYDFwjjZw569qr0EIqkUf4aArfWi87nSpoqKjkR9+wGKVBVZoJXCEqQqq4zwxiAFoRwN4RlTdgDKDrvQoYP533UazUeCVSdW4hiJXUHwR9gePwoDPTLHecnubCD4MKPugiIN2KHY9CVZosz8EbEDkXYBNRL3W6BSwg/Fap8Tuz9A/6W1ujvywcoaZJEql7NxExctufEpAnm2n85WfweF09mnO6Xy55Vt+Xp330KP72HmkyQ1Qf5BJqe8Wyzr4pNqZzlOBeHkZccEb208E0sevyXybKZ/wxOqroH2Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqtSPXqdjK5wC9DWxR4RJpgEYpj1wC54IHBLfa85jRc=;
 b=Oo4yQ7xquYDYwUv9dLuUF/+ZvQviiI56OCnGbzGMPO7q76ucbHq7hjEuMDu3FM/zeQ6ijA1EU3lwX1ulRzErARg76KIEBNHAr3e+MjI6M93GYOK8JOjcj5uq5Y5+f+z9GvMPTC+9XLVmiGd0R4H6yImUXP2ch2bqooTJBChHkQ8=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2783.namprd12.prod.outlook.com (52.135.107.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 01:25:01 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba%3]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 01:25:01 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v3 4/5] EDAC/amd64: Use cached data when checking for ECC
Thread-Topic: [PATCH v3 4/5] EDAC/amd64: Use cached data when checking for ECC
Thread-Index: AQHVlEECgc88AWnQWkqibLrNCrTHWQ==
Date:   Wed, 6 Nov 2019 01:25:01 +0000
Message-ID: <20191106012448.243970-5-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: d08ebf06-a274-403f-99a0-08d7625824ce
x-ms-traffictypediagnostic: SN6PR12MB2783:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2783E046BC97C9C9B67B07ACF8790@SN6PR12MB2783.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(189003)(199004)(186003)(5660300002)(86362001)(386003)(4326008)(102836004)(6506007)(1076003)(52116002)(966005)(6306002)(2906002)(5640700003)(99286004)(6116002)(36756003)(54906003)(14454004)(25786009)(486006)(66556008)(446003)(11346002)(81156014)(6916009)(76176011)(305945005)(7736002)(26005)(6512007)(2616005)(66066001)(2501003)(66946007)(316002)(64756008)(478600001)(50226002)(71190400001)(71200400001)(81166006)(8676002)(256004)(2351001)(8936002)(6436002)(476003)(6486002)(66446008)(66476007)(3846002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2783;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: noBr0V/W2TFX22UJWxkSJ4N9RhLWNpxi1HFtkbHfR4/V1NkHtmzNJetlf6EC9ao69nF7sBiL+LhCFtZhsUjXcLU6+KhbyX3FUSfdpONkfSgapDIhOG74ZapZB53cxYJwlEGJfM/hG+hz9Zdemxdm/c0HZLfbAB8SVeWGH/eRajC/22RjaUNqyPtoOOGHwTDpcWhdyOQ5SRH9Z0/DN7e+KrgA9NPEs1vxEpyrDd14gsh9vF4IohZ+CbZqmKkste69UQAVV4EmZXcfhKYDpczuQZjN0D544bLX0ByFv4rRDZ0lNcqzh1TQO+NhSYZFmlNtppXa+qwepKCuOLBQa0JnH/3NUYsfIxDA0eUz90HY5SUOHV/1xhVLh/xD9Ru1vOfMmNpxgC34ZDePpYPGknI17Nh2d23OHaX1cocDewDg5C7tokB7quK9RXQNazGqqBflTkATBxvIEhP0gHJlr5f2/RY5zvTYOLy/PGNm5e1pS7U=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08ebf06-a274-403f-99a0-08d7625824ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 01:25:01.3246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 84LzIeRkW1OUi3YTvngu/CfFyJ0lMPEBkRj5eT0RKOkKYN3wAuofUSV+Q4WKvaeBxz6R6hF2BLZ3MJMg8i7tdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2783
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

...now that the data is available earlier.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20191022203448.13962-5-Yazen.Ghannam@amd.com

v2 -> v3:
* No change.

v1 -> v2:
* No change.

rfc -> v1:
* No change.

 drivers/edac/amd64_edac.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 110ed0d27998..d38ba7f17753 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3202,31 +3202,27 @@ static const char *ecc_msg =3D
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
@@ -3239,7 +3235,7 @@ static bool ecc_enabled(struct pci_dev *F3, u16 nid)
 		/* Assume UMC MCA banks are enabled. */
 		nb_mce_en =3D true;
 	} else {
-		amd64_read_pci_cfg(F3, NBCFG, &value);
+		amd64_read_pci_cfg(pvt->F3, NBCFG, &value);
=20
 		ecc_en =3D !!(value & NBCFG_ECC_ENABLE);
=20
@@ -3524,7 +3520,7 @@ static int probe_one_instance(unsigned int nid)
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

