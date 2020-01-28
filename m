Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37D8914BAF4
	for <lists+linux-edac@lfdr.de>; Tue, 28 Jan 2020 15:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbgA1ONA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 28 Jan 2020 09:13:00 -0500
Received: from mail-am6eur05on2096.outbound.protection.outlook.com ([40.107.22.96]:26208
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729346AbgA1OM7 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 28 Jan 2020 09:12:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bev6g0d3XGkcLxeKpofD/osLXUhybqcWbQePrsR8pj2R9P1WdUwke+pkPrXdiGJQwlIfy+yM27So5yqCMJUDtaQMIoujEkvS+gTwBdalp7092ZsZWLD5eTT5Kr7N2UbkwILGLSdaosWW517oQ/8Y1TZkOTBKLMXF+L+IScldkQGOsBAxVF1kMHAL0rvgwxo+UrqRGSYXnV8Px6FAD3xempYCapAcpKAbyhIzhk9Kl77HC/SYHxLDXSIW06ZA0GbB/K/f21HXRJXPHQEfDVlBowsv2ZkLCwO+mtyFhlKAwfgsQ6p5tg4kODNhU7E8VgX0y3BAklxFKAFpHkCFlp7czw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0YR8fsW7yqrMlU7iMocdbkJWyWOLGp+Bzy0gJg/t7I=;
 b=ZzH6e7ZCONHtj0RnVjs7i749iN1Kx5OSSxHs6nfUl0Sat7KkrPzwOUXk7sHG8Xy8b5g0ByOYiRRW4gxD6bO+fP67CAQ55ec6FpcHSEtGuGSwaJoeE50V6Ow8KG9y5uhLWdWMUm+xLnJQgHzr0nUxAAgnqcUeZ47/PIwREYEf+i9ae2GH2MMERhgkrHDOoJBlTS2V/lhCddRH1SO7eVF4o0NjO3SgqH7VxWks1/eTmmAeZxEZowk5sPOWw4YoJKJH/lsF0RJd1bV1tD8sn9PK1N+IPstfgp/L9CH6alnd0Qnb1pco0D69PUGDh2hny7vdLGYMa+1VDIHhYN0Mi+TRxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0YR8fsW7yqrMlU7iMocdbkJWyWOLGp+Bzy0gJg/t7I=;
 b=DJZw1Mgz7MRPxI+tTygLYnbN65RAlMbmvKD801o5MmVkYGLIBDou+Z+LSMk4vF58DJXDK01KiQhbRbL97IbNWe82u0zZqbIi99eJwnIzIlosh8bwb5Abo8Vtyh9qZAij3u7adyCMgdmd/w+L8nwyLxAlA9+BlbnLVvxEpsW9vro=
Received: from AM5PR83MB0195.EURPRD83.prod.outlook.com (141.251.3.214) by
 AM5PR83MB0369.EURPRD83.prod.outlook.com (10.161.103.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.12; Tue, 28 Jan 2020 14:12:55 +0000
Received: from AM5PR83MB0195.EURPRD83.prod.outlook.com
 ([fe80::ad8b:84a8:89f7:d86e]) by AM5PR83MB0195.EURPRD83.prod.outlook.com
 ([fe80::ad8b:84a8:89f7:d86e%11]) with mapi id 15.20.2707.008; Tue, 28 Jan
 2020 14:12:55 +0000
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
Thread-Index: AQHV1eS12vBoiEW3fUCLAhCrOiQFAKgAHeTg
Date:   Tue, 28 Jan 2020 14:12:55 +0000
Message-ID: <AM5PR83MB019597CD34A7AB50A1738AF0F10A0@AM5PR83MB0195.EURPRD83.prod.outlook.com>
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
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-28T14:12:53.4353060Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0464b210-2086-4837-a4c0-d9b25a4ab115;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Saar.Amar@microsoft.com; 
x-originating-ip: [109.160.198.148]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 80e93bbf-1df9-4ce8-05ba-08d7a3fc2b80
x-ms-traffictypediagnostic: AM5PR83MB0369:
x-microsoft-antispam-prvs: <AM5PR83MB03694C10A8BD60FFEDF7351BF10A0@AM5PR83MB0369.EURPRD83.prod.outlook.com>
x-o365-sonar-daas-pilot: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(189003)(199004)(186003)(6506007)(55016002)(81166006)(9686003)(110136005)(2906002)(478600001)(53546011)(8990500004)(10290500003)(86362001)(316002)(81156014)(8936002)(4326008)(54906003)(8676002)(76116006)(5660300002)(66446008)(64756008)(66556008)(66946007)(71200400001)(26005)(52536014)(66476007)(33656002)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR83MB0369;H:AM5PR83MB0195.EURPRD83.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: frFU7p5aMMBrLu1BFvNECOCopekPspDBACPgAi2YVZy46P1N5SNsOeEmIlTFPltrUGzVd0+uAfW5La7K/b7vKa2MWWElHFC5ewTOAs1eBB0i0GIlqnVKFI3rmoxI/m3LZgpHeRUVJvhS/LDg+dKnr7w76i/ayfBj+sJuhVEy47N05EN8H2Ird9ZIzwhOgbruI3FYvuMh2kaEqBc76cuYpbJN1jhGzXozvYOqhIV4+ax+5MVZKRHYFXUyYy8ryApM4P9PlKbIez4ZA9rOAg2sOrvqkqsRPw0GfMQ+esiVje+0fHVt97ZgPVSuohs8ajWx9uhZhx1Ih2WwQcO+KcCCiRqFvibWUYcfoE9pYdGYIW0aPmfZ+Mihm/nvGw8PpBHxcS3fs0SZsbQUGOW64+rSS/hauPZmgbecAcuGnKy+umyRilrRT3yg+3wwBlZcleOx
x-ms-exchange-antispam-messagedata: QsroA0RcOLhx0uNTody4NrJZHU5EErlkBR6IbF8tb1WSqZvgdALAkyLEWWNDdcUD4N8VZmLM3Z05Y2ZJqqLNZ8RYNNUysFTVCjUOgpsHE449bb1gmsIS6V7ShBWk9G4cYqbzxz0hLHhCBswokoqA7w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e93bbf-1df9-4ce8-05ba-08d7a3fc2b80
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 14:12:55.0512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0b0+mhW97hiQ92dUO0OSlvilZq+KETqf0g2LA1hRPg16wDchzHQEh4pb26M8Le77usN/GzfZnumCgQf0m1ffig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR83MB0369
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

That's correct - I found this issue through reading and audit the code stat=
ically. Thanks for helping out Dan!

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

