Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A29B014BD5E
	for <lists+linux-edac@lfdr.de>; Tue, 28 Jan 2020 16:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgA1P7O (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 28 Jan 2020 10:59:14 -0500
Received: from mail-db8eur05on2134.outbound.protection.outlook.com ([40.107.20.134]:49537
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725959AbgA1P7N (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 28 Jan 2020 10:59:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itbEeAZuVDnQApY9lENFfWmG7XvwrNIB2feyNEBtNwj4bPa9MHvGsz6XZvEHowBKDbFp+fWp0RM685kUJt1RIchoxkT+ceOpba7DxD67uzK7Q645ff/uU9Xg9giQdBiKF9gSTA9+Azt5gxGAMcND1XKeSJysbn5Fl4AXI1ylZDP13EpskprArZBVDns9GZN2f+Y1Rx/VYOCQx1vltfxyuWXyOvblhwt4rKpnKIQ/bHWto2QwTioFyb6cMEUHWKGuWv9rflDRVhXwq63uMS71DH7lnZR7LDdni2PfJMG2QyxLmHO/89F95sTe83xxmtO9M8+RnI9mXQ5GrXnuhBjfnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNrXF/Fw/5guRG7xw+Y6mJ2U/96+azpldJ0gEEoUpA0=;
 b=DbeMAC2TzbVFQqzYR9++2kzlc0zaEUR/kHKzQCFiL3+YlHWbWvVwqbd/rCETYDSp2VqvTqaE1NFX/JTS8AwycdQLbAFGoFymWLJnSfR5i3pRlbk7AkghyJiDiq0k3Z7FfP1O8+B/WCWc2pX+e9C8erSSEN35JDi8vWxLVpWViTZaZ9tztrfzeL46Hau6lMi2T2+Br25oXaybEj+sMKZZjb6+ciVDMPnRnNP/qqpSyGDpQwcoPjARSNyOfG/aFEStZv+/T/7KcEQhi9f587bqrfDItxE/NQPMZNakb6CAoxCnf1zsnbMDFD9lux7Q9zzalK8m7HRkIlNkREG+4+62ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNrXF/Fw/5guRG7xw+Y6mJ2U/96+azpldJ0gEEoUpA0=;
 b=Z3eU+ltMOHTcygfey+Mxkfd+09uD17D1UxEAD6JeuYcryq0LQ7qt0Z4Mcl0w8eoYeRIK3pfr5fDX6jErJM672oyv9rMaXAj/MeyA69/phoZRBgVmn2XP/EZ+2l0DJfBSObDfga21RxrtRJllQL4pTbKYzk8LAO8uxMhRwrT/zHc=
Received: from AM5PR83MB0195.EURPRD83.prod.outlook.com (141.251.3.214) by
 AM5PR83MB0370.EURPRD83.prod.outlook.com (10.161.103.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.15; Tue, 28 Jan 2020 15:59:09 +0000
Received: from AM5PR83MB0195.EURPRD83.prod.outlook.com
 ([fe80::ad8b:84a8:89f7:d86e]) by AM5PR83MB0195.EURPRD83.prod.outlook.com
 ([fe80::ad8b:84a8:89f7:d86e%11]) with mapi id 15.20.2707.008; Tue, 28 Jan
 2020 15:59:09 +0000
From:   Saar Amar <Saar.Amar@microsoft.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>
Subject: RE: [EXTERNAL] [PATCH] x86/MCE/AMD: Fix use after free in error
 handling
Thread-Topic: [EXTERNAL] [PATCH] x86/MCE/AMD: Fix use after free in error
 handling
Thread-Index: AQHV1eS12vBoiEW3fUCLAhCrOiQFAKgAO7yA
Date:   Tue, 28 Jan 2020 15:59:08 +0000
Message-ID: <AM5PR83MB01951D715568E2BFD67C51AAF10A0@AM5PR83MB0195.EURPRD83.prod.outlook.com>
References: <20190813100752.GM1935@kadam>
 <20200128140846.phctkvx5btiexvbx@kili.mountain>
In-Reply-To: <20200128140846.phctkvx5btiexvbx@kili.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=saaramar@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-28T15:59:07.2343303Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ca78afd6-a717-442b-8319-8a2c274b7c0f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Saar.Amar@microsoft.com; 
x-originating-ip: [109.160.198.148]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08b23312-f9a9-487b-2ede-08d7a40b02be
x-ms-traffictypediagnostic: AM5PR83MB0370:
x-microsoft-antispam-prvs: <AM5PR83MB03705B7E0439C40AFD768E35F10A0@AM5PR83MB0370.EURPRD83.prod.outlook.com>
x-o365-sonar-daas-pilot: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(199004)(189003)(52536014)(71200400001)(478600001)(55016002)(9686003)(8990500004)(7696005)(76116006)(10290500003)(6506007)(66476007)(64756008)(66946007)(86362001)(53546011)(66556008)(66446008)(33656002)(26005)(186003)(5660300002)(81166006)(8936002)(8676002)(4326008)(110136005)(54906003)(2906002)(316002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR83MB0370;H:AM5PR83MB0195.EURPRD83.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XCV/jIuoJkMhph6raZNZffCOO/J6XDmJZ00YiFSpj2eA7hZgOuatvi1Q+uEZ0a2Y7qWYVoT8di6srlsrq+nMF4TYsOE4PyFNL6hEYzPLTwUrgmY6Zj4GpPgt0I6kscFuCij2/cRHn0KIgt/uYOTqy14caQGnFPdAMTSGpPCA2U+Y3KnpcSsHy8RqYXeUVhI3vvuto4wvJVcEmxqLZT8PdNHllxzHu/4VDUw20pp5TAi5VZEhaX5uOH2e+iJMUgNdZHF0c5ti6meGYRj+bwXREMfdk+xr0q8BfnMFXR+yucJizMWZoOpCafvo/27XXX0BqZO+s/ssMx3qTpJswU/PnYMOEpJosoUIaSts5bVem2cMBuwupDv9O7ehrG1Q0I+780jKpuQ9MZkdADyNvQshYuNKobaSV39PK05Df2XN0J1pQnEDiJt/Wqwu8oTyUdKj
x-ms-exchange-antispam-messagedata: MujuVp6lv/sEKoiDXvKrVXdWXpqc5i34Q5u6VhpatvU1RymMy9KrMd5VXCTCNlcOM+05nRvQn6U77cxcUuNhvkrM0iIdSLMkYC7WstKIIUYvcY50SLJJ2Tqc8MUtaR9Gxqn/mqGSRFwepkHKm7iuwA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b23312-f9a9-487b-2ede-08d7a40b02be
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 15:59:09.1789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GPFm2vTJCYlxag0Is2ObuElnWBsPUQ8zzVWby+lTBn0uWBMULOY4DXCq3QMQ97JQrKd0kf5b5GgznCdl8JIReg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR83MB0370
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Actually, if we are at it - Dan, given the fact there is an actual use (a d=
ereference) for that pointer after the free, shouldn't we assign a CVE for =
it?

-----Original Message-----
From: Dan Carpenter <dan.carpenter@oracle.com>=20
Sent: Tuesday, January 28, 2020 4:10 PM
To: Tony Luck <tony.luck@intel.com>; Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>; H=
. Peter Anvin <hpa@zytor.com>; x86@kernel.org; linux-edac@vger.kernel.org; =
Saar Amar <Saar.Amar@microsoft.com>; security@kernel.org
Subject: [EXTERNAL] [PATCH] x86/MCE/AMD: Fix use after free in error handli=
ng

If an error occurs in the threshold_create_bank() function then the real cl=
ean up is supposed to happen in mce_threshold_remove_device().  The problem=
 here is that if allocate_threshold_blocks() fails, then we
kfree(b) before returning.  Then we use "b" again in
mce_threshold_remove_device() when we do the rest of the clean up work.

Fixes: 019f34fccfd5 ("x86, MCE, AMD: Move shared bank to node descriptor")
Reported-by: Saar Amar <Saar.Amar@microsoft.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I believe Saar found this through reading the code and there is no test cas=
e.  I have don't have a way to test it.

 arch/x86/kernel/cpu/mce/amd.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c =
index b3a50d962851..ff01b789066e 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1342,7 +1342,8 @@ static int threshold_create_bank(unsigned int cpu, un=
signed int bank)
 	b->kobj =3D kobject_create_and_add(name, &dev->kobj);
 	if (!b->kobj) {
 		err =3D -EINVAL;
-		goto out_free;
+		kfree(b);
+		goto out;
 	}
=20
 	per_cpu(threshold_banks, cpu)[bank] =3D b; @@ -1358,12 +1359,6 @@ static =
int threshold_create_bank(unsigned int cpu, unsigned int bank)
 	}
=20
 	err =3D allocate_threshold_blocks(cpu, bank, 0, msr_ops.misc(bank));
-	if (!err)
-		goto out;
-
- out_free:
-	kfree(b);
-
  out:
 	return err;
 }
--
2.11.0

