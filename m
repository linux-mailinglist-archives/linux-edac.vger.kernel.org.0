Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1EBAB048
	for <lists+linux-edac@lfdr.de>; Fri,  6 Sep 2019 03:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbfIFBlx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Sep 2019 21:41:53 -0400
Received: from mail-eopbgr800072.outbound.protection.outlook.com ([40.107.80.72]:55472
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730991AbfIFBlx (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 5 Sep 2019 21:41:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Knd2FZ6sJf0Imbfp3bQPx9G9gfqH3Fp73zj7p6g9aoVpfIT18K993LCL0/x5BIaWiihhfF/HajASkgUNo0WVz6UAr0McQO+p5I2teR6zPJw8iZPSrunSX/xDdapvt3Xk1lBmfiAtkFEONOnFf8s8Cp3zUmbJflVoxvPAJTxcFkHX6eF5TcayMS6k8QfdChsJtXvI1igGEujls6/ZYcNgn2fGXrztn9B0amadFHjS4Ufl79PZRx67bYONO9jnif5OEXMGK10HaAZLK5hNt4pdTbHfjFSZm5+9Xo9DWajiyp6x0+DV8Gjeo97FvNydVT56VZcD7dWw3ia5IXOL0AiHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSxMitJ4NviytC2rgpfYOwCCcUA1EMh9isTfgiZ6Wwc=;
 b=dTF8V7PFaUg3voyAcScoIngCoOs6Nawv/XuVu914jZemtj59zQFiFa25Tfg9LO/ZmBiugcNMhF87FRSzkeWclirYLBuADlSFvuVjdXFkQDq5zl7eu7gld+zMyjYZua/MrmDYABL++6ZZnUjhUNja4+TAmUaDc8+bIMP6Z3Fxsetg+5jtHLoRQVjLD6b/2AT09p2xOZbgWUcKpGRj55+mj4A8u7wviiG4nLUPNIopSkFbGHOXG1ipBH0Iwo4GyL4D8VBLprYFJQjSLNQofxlewZJWJuJi3E1HC1VNGv7m5GUw0k49jPHPWTi4UGqUMKyqYEpjavmzaqo+QblRRdWtxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSxMitJ4NviytC2rgpfYOwCCcUA1EMh9isTfgiZ6Wwc=;
 b=ozez80V054Cf17JTPTvgQBB6f0hLYPlGu7Z2h8IOusv+AQjc4/kdI0yJ/pqVSq0fMx5AdnWEUDy+dgcibuAR9lOw/IPIyUpmerbx9oQ3pH5pqiDr4KEVN86ujOB/s3HZOZKbi+7Cm9ezkZKW/XIzJQ//ohVn+il30DKAu+ZCMsk=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Fri, 6 Sep 2019 01:41:45 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::307c:a378:f96e:690]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::307c:a378:f96e:690%7]) with mapi id 15.20.2220.020; Fri, 6 Sep 2019
 01:41:45 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>,
        Borislav Petkov <bp@alien8.de>
CC:     "trivial@kernel.org" <trivial@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH] Add PCI device IDs for family 17h, model 70h
Thread-Topic: [PATCH] Add PCI device IDs for family 17h, model 70h
Thread-Index: AQHVZE6m01dXntbbPkSlefoxnTwOiKcd3bVQ
Date:   Fri, 6 Sep 2019 01:41:45 +0000
Message-ID: <SN6PR12MB26391613BB518F00FC0A72D9F8BA0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <BN7PR07MB5186DD5732B95B784A9D46BFCEB80@BN7PR07MB5186.namprd07.prod.outlook.com>
        <20190904215308.GA12374@zn.tnic>
        <BN7PR07MB5186E542BB3AD734262AA345CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>
        <20190905070917.GA19246@zn.tnic>
        <BN7PR07MB51864F8287CAD4847BF17A83CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>
        <20190905135408.GE19246@zn.tnic>
 <20190905210134.007503f968a34cff43921390@knights.ucf.edu>
In-Reply-To: <20190905210134.007503f968a34cff43921390@knights.ucf.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.77.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3f907af-072f-4026-ca77-08d7326b6081
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2736;
x-ms-traffictypediagnostic: SN6PR12MB2736:
x-microsoft-antispam-prvs: <SN6PR12MB2736FB51A4C0F546B4FB6052F8BA0@SN6PR12MB2736.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(13464003)(199004)(189003)(66476007)(66446008)(66946007)(6116002)(76116006)(8936002)(81156014)(81166006)(3846002)(14454004)(74316002)(64756008)(478600001)(66556008)(52536014)(8676002)(229853002)(5660300002)(305945005)(7736002)(2906002)(86362001)(6246003)(296002)(110136005)(71190400001)(54906003)(99286004)(4326008)(25786009)(14444005)(256004)(7696005)(316002)(76176011)(71200400001)(2171002)(476003)(33656002)(486006)(55016002)(446003)(11346002)(26005)(6436002)(66066001)(186003)(102836004)(6506007)(53936002)(53546011)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2736;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 84AnD04U+YSdwRu1iZR0dvTyiP4K3A/V9rp82eQx4btsSvbhUW7DcWBuJNs98DJwTmzV9Pb5ZgrmAyIZM1BBzI280xF8er51MvZ8bkV+oBx4fWe7mD1tqKIdRugU5+ebv+fpPF3SaKMpbF/9PuxqRP5gQDBtAEvjW0pp680504wPUv0zDd88NDRNPNgl7YX17LiN+Q7/Q08kFxYoJ4Zacbg/n2ApcLQd44YKubjPKlHviiUGBru0sT13Q8aowU/I/ozoZF4GUsfM4PwIym3z4l59YhgorPM3oeQV4oU75QVBiZGl/FrK07YFNcyCt1ZCb1NHO19VbNLb9cpRZcyRt90HNCevpGAHF/+A3XiXpiYwcIAI3dYtpid5gS6UwrUoAzL6Kak3UM7q977hiV43bWVevMZqW82zBD6GEwaywMo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f907af-072f-4026-ca77-08d7326b6081
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 01:41:45.7053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oS/pZpa5o6htlzFHxehpNA7vXLk+gletlp2dqkTrSjLFuOGYnMXfgTdwLtz2ppVRq6rw7oZCyu0b1wBZ8jYokQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2736
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> -----Original Message-----
> From: Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>
> Sent: Thursday, September 5, 2019 8:02 PM
> To: Borislav Petkov <bp@alien8.de>
> Cc: Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>; Ghannam, Yazen <Yazen.Gh=
annam@amd.com>; trivial@kernel.org; linux-
> edac@vger.kernel.org
> Subject: [PATCH] Add PCI device IDs for family 17h, model 70h
>=20
> Add the new Family 17h Model 70h PCI IDs (device 18h functions 0,3,4,6)
> to the kernel, the hwmon module, and the AMD64 EDAC module.
>=20
> Signed-off-by: Isaac Vaughn <isaac.vaughn@knights.ucf.edu>
> ---
>  arch/x86/kernel/amd_nb.c  |  5 +++++
>  drivers/edac/amd64_edac.c | 13 +++++++++++++
>  drivers/edac/amd64_edac.h |  3 +++
>  drivers/hwmon/k10temp.c   |  1 +
>  include/linux/pci_ids.h   |  1 +
>  5 files changed, 23 insertions(+)
>=20
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index d63e63b7d1d9..08cc057126ba 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -18,9 +18,11 @@
>  #define PCI_DEVICE_ID_AMD_17H_ROOT	0x1450
>  #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
>  #define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480
> +#define PCI_DEVICE_ID_AMD_17H_M70H_ROOT	0x1480

Since this ID is already defined, you don't need to add it again.

The code that searches for the PCI device will match on the ID and return a
pointer to the device. The name we associate with the ID is arbitrary. By
convention, we use the family/model where the ID first appears, but the
name itself isn't important.

Thanks,
Yazen
