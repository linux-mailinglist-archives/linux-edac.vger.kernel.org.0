Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B08EDC88B
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2019 17:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410555AbfJRPbk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Oct 2019 11:31:40 -0400
Received: from mail-eopbgr720052.outbound.protection.outlook.com ([40.107.72.52]:48496
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2633040AbfJRPbk (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 18 Oct 2019 11:31:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R31TNP8+MneVngwpQUVtAXNqO604IO7hXSw965kfa+oKmwqRFqaAepi4+FVmoMTrK3Ps2be1BCKu7fdmh02yqETyGcSpE3yFFPCKzKppCK1lIKVTTj3xSxfGZGq6M2fcY/1mGzI1mL86zADlKo3dJQ41Q3YZhcdIWPy6c4QYwnZ/1jdhp2A1rVXzwou/3xHki/49QQYwp3ZfNUX2/uH7RW0DwLAIr9uoXIuGF1jz7+agxbdf4VTuDYKl3dX7KgaQC05eNMjLwv3UVqnVPE1ROVEvSX/S7P3/4obAN8MdKsbQws1hslAmHD9/I6EPETfschD0xbYzLJW+e0UAIQzKSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Td1BXkUXW9JNviE3Bg/x8ltLF81YFqQStp1Y/CXOY8=;
 b=Dtp9YpZ8aV+iPUQW5+My6eUNIlgmeQEQFCQ/MKXhy5hwkWDifhQpdQAlslGdyH8ehqKkPFaQD4oVJtzTn0UFaipXkwnMhqVsqwzMVLrMyOm5OIR0/JYo7nnPPAiCUr9ulza7F9X5bB194ljMnRB99Wbt6aCjC9TnmAOwx93oR8XHI+ZqJ2Fah4Vt7lUn3FOyFdRE395NLAL5+ODWWRkHWzX9kHX0i8BeqcP4GckYeSS2GCRbnns61Oeo8M9bh8JR5b23EWiKdDT4gINLzAv0adNn7A148aOLxSW4Db1jZsrVELKi0lyxYRO/L+U0jxos271x022arQ01KHXMblmQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Td1BXkUXW9JNviE3Bg/x8ltLF81YFqQStp1Y/CXOY8=;
 b=Kf7tzTmfu3oYf5X7mxSqOkj7MtFBv+B3FDH84VUJw6OKN8JyFTnSFbJcmXoN/bxfrlY92kVftYld39L9pMvQyf5nSilz+CQWw5Iwg7ZKqk0FeQC7+xm/nn+BgBSBdAk6PfTDX/uQ428cASBgRRNruPXDf/Fy1S8J27e45eYrF0Q=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2608.namprd12.prod.outlook.com (52.135.102.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Fri, 18 Oct 2019 15:31:30 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8%7]) with mapi id 15.20.2367.019; Fri, 18 Oct 2019
 15:31:30 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH 6/6] EDAC/amd64: Set grain per DIMM
Thread-Topic: [PATCH 6/6] EDAC/amd64: Set grain per DIMM
Thread-Index: AQHVhckcH8Q3hhJGUEaVQKby7sMplg==
Date:   Fri, 18 Oct 2019 15:31:28 +0000
Message-ID: <20191018153114.39378-7-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: b9b58ad7-6155-480d-6e1e-08d753e03e7c
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR12MB2608:
x-ms-exchange-purlcount: 1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2608A50F90257D05C85056DAF86C0@SN6PR12MB2608.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:240;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(189003)(199004)(6506007)(386003)(186003)(2906002)(6512007)(6436002)(6486002)(2351001)(6306002)(3846002)(478600001)(6116002)(5640700003)(7736002)(305945005)(26005)(102836004)(966005)(446003)(76176011)(71190400001)(71200400001)(66446008)(64756008)(66556008)(66476007)(66946007)(11346002)(476003)(256004)(14444005)(2616005)(52116002)(50226002)(86362001)(6916009)(99286004)(8936002)(81156014)(25786009)(81166006)(486006)(8676002)(2501003)(36756003)(1076003)(5660300002)(4326008)(14454004)(316002)(66066001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2608;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iCTunEawsZ5bsUHK7Bgxjn75gltqf6MsKatui5Qty8hWi9cWoB52BJBst0wvYAuprdaXvKQE83+QcloXNu4IArI9bmfTofWTW3vOfuvWjPpVNVSZoVmwMNcZiaEqZXU6hh95VytmT9ydoAmR3W+ktJFGPzC9Pz8AshycwHCyCs3zrdCILxdArFDc4a++pS6i1DL0BmCH63eYYzMajMtiQ7esGP5jhzRL+xvUZzz4FVWvXgTtnYb/EbJxxhtONYX4a57BX0IXXd4W5qY144wogICDJomc26KCbkUoqzcRKaBQHFi3M1GbesKKbZWP16w/90IDn8BqWQjTQC2daWolgU5rWbqr1tWnshYD5oje87nxcsIGaKH9iOLquf4NNri+j7pHZECfFcfSPjUlLDkKboCyGeCv5UbayFsGPVh5fmydyG91Cu6p+YW+tn3g4xbAA1SQk8tlYgBXwDQbVwE2Cw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b58ad7-6155-480d-6e1e-08d753e03e7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 15:31:28.4934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /FXKKJFTk2UkTChpyscJLRr9sb9o43WNdp4OclOTrC0FgPokLo+WMtIn81Ma9V8fsKE3DCSQk+Gh3pzz8BjQ7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2608
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The following commit introduced a warning on error reports without a
non-zero grain value.

  3724ace582d9 ("EDAC/mc: Fix grain_bits calculation")

The amd64_edac_mod module does not provide a value, so the warning will
be given on the first reported memory error.

Set the grain per DIMM to cacheline size (64 bytes). This is the current
recommendation.

Fixes: 3724ace582d9 ("EDAC/mc: Fix grain_bits calculation")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/724d6f97-61f2-94bd-3f4b-793a55b6ac15@amd.com

rfc -> v1:
* New patch.

 drivers/edac/amd64_edac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2a0a8be8f767..b5c0accfefcf 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2944,6 +2944,7 @@ static int init_csrows_df(struct mem_ctl_info *mci)
 			dimm->mtype =3D pvt->dram_type;
 			dimm->edac_mode =3D edac_mode;
 			dimm->dtype =3D dev_type;
+			dimm->grain =3D 64;
 		}
 	}
=20
@@ -3020,6 +3021,7 @@ static int init_csrows(struct mem_ctl_info *mci)
 			dimm =3D csrow->channels[j]->dimm;
 			dimm->mtype =3D pvt->dram_type;
 			dimm->edac_mode =3D edac_mode;
+			dimm->grain =3D 64;
 		}
 	}
=20
--=20
2.17.1

