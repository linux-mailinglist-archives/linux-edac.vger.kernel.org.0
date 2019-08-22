Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6620F98842
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2019 02:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbfHVAAc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 21 Aug 2019 20:00:32 -0400
Received: from mail-eopbgr770048.outbound.protection.outlook.com ([40.107.77.48]:22183
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731489AbfHVAAc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 21 Aug 2019 20:00:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKqrgeCyaIn1bCBal28SOExjiA/mRilKRbyM1iNZp0WpiaI4mot5tjjGiXgI9ySdTmlPXDEjkcdGeOGEaEIecmvgjkdPePPX537Uu/Tj47u+VSz2Fa3CHBcYRAROuqUzUOOjxLvlhaWI2+RLLpYkw6xqznQ1iD3rbcQYdZNA5OKOecEdOPa4nKvQZYFAgjv6UeW/DnRZEjN4goGUXzbPaGKumWI+1TTgX29/RHuaR90oMoPIC35DJdxTHHuuVJkmROqp2Y6TUkpJKrfofhfnFU9pJFtnOLqUORoTNhzP7SUC0hswi8cDWqL9SemNNd7DnLNxpDU68b7aVT94/YRePg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyDvxq3RRFKtgF7PpfgdgFCEekYhoN3m7qkzUsl/jXs=;
 b=QV6nUi7WDGTYhqaE7KRH373dA+N7e19Gg0jbHE9472nzAHLJXzcx+ruqazAzzHQYrwowfn/YCTrccKvLuD8cvd7SJ0TZuM6B6xwG59kOxUq5WhsABPOsJz9B0VNA59gOGjrBLUA6+RwCh+526473131S3izm7+lH7NTuejK0PRyXjOuRwZf+CAKQCe6ZwLMY4ve7DxGV01HOBPHgdLNFnZs8+mVGZF4U+zCGHGm8BYvEtFNN3pyw5Rz2DD70of43epfrWEG4hD3opx7aKhSpg0Z2cm6qqgMivP3g9w1xGU9oSoW6ebjyMNW8I6dV3KKWjey9UuTOvsefgzmKKe3Y5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyDvxq3RRFKtgF7PpfgdgFCEekYhoN3m7qkzUsl/jXs=;
 b=CtYJnO8NIyvJUukb4RRA5udMZ/EqgYgvCtJizwGLk2RrTNngISGhd0axZuJpHP9KD0ANgn5NHb7G8rBSYrAS+wRkphUJf/MHB/zKZOOcblyEY/9L8615IkWgQduUwJjP91iR95SEzZVNsrY+AN6MhAhryHpSlDwlJLoxsmPx82U=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2815.namprd12.prod.outlook.com (52.135.107.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 00:00:30 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53%2]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 00:00:30 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [RFC PATCH v3 10/10] EDAC/amd64: Check for memory before fully
 initializing an instance
Thread-Topic: [RFC PATCH v3 10/10] EDAC/amd64: Check for memory before fully
 initializing an instance
Thread-Index: AQHVWHyMETLORtrrWECN2j4kOERlMg==
Date:   Thu, 22 Aug 2019 00:00:03 +0000
Message-ID: <20190821235938.118710-11-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 5ac8b647-0d5f-4b34-6911-08d72693af36
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2815;
x-ms-traffictypediagnostic: SN6PR12MB2815:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2815718D1B43E3F06FAB1FC9F8A50@SN6PR12MB2815.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(6486002)(8936002)(6436002)(81156014)(99286004)(50226002)(8676002)(26005)(81166006)(52116002)(2906002)(6916009)(53936002)(5640700003)(476003)(54906003)(66946007)(25786009)(66476007)(386003)(64756008)(66446008)(66556008)(186003)(2351001)(446003)(11346002)(316002)(6506007)(6512007)(2616005)(486006)(102836004)(14444005)(36756003)(478600001)(71190400001)(256004)(86362001)(2501003)(1076003)(4326008)(5660300002)(7736002)(305945005)(6116002)(3846002)(71200400001)(6666004)(76176011)(66066001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2815;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u2TdU4NLVT2ClzPHsO+FPNDRRIptTiYp7RdNhvYqOy1dGVO0o84Flme+o42SKcWprSsOIJWTZyEsUPKIwAlAZ2C2d98hkkeSzvo5SyZYp8/2grQpRlkcHxPMY6y4UkXQlmkG9FFtY+c6FwbAeyQjQPR0eIQS4hZZMZvD+mI8+tF7JzqcM3PpOSCF7ma6VmVGFLiaOevRZ8riTCrr2/dlrqWC3wcH7axQzfLWmyH+DYQ4OyuaF67zFG14P4WEQP0tZLH19k8o4/kz1V76xU3XzIzEKV2WX/wOH7rOOdPcyySKYYbHbN3X/fa5WiAjK80fOKTXP/1sMxcovcaGV/IFg56aR9RFgVTLtyBGfLHXMrhJNrLyHQmg2lPGY6kO4BvoJFxm55DqTiWL1I4Bu13aKdEy6Nw3sCboD2ci0nXaLIY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac8b647-0d5f-4b34-6911-08d72693af36
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 00:00:04.0159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0vT4mHgi/PTv+CI1QgleWXwojZfU/1pD0OZIvXfo5A2QPK/ZWUl4Tvj8TzHvhNuOFjFZ8c6HLgDZ9JfGWzjXHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
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

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index c1cb0234f085..7230ed4ff665 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3505,6 +3505,23 @@ static int init_one_instance(struct amd64_pvt *pvt,
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
@@ -3535,6 +3552,10 @@ static int probe_one_instance(unsigned int nid)
 	if (ret < 0)
 		goto err_enable;
=20
+	ret =3D 0;
+	if (!instance_has_memory(pvt))
+		goto err_enable;
+
 	if (!ecc_enabled(pvt)) {
 		ret =3D 0;
=20
--=20
2.17.1

