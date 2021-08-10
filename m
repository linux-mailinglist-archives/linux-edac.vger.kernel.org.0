Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DA53E5A44
	for <lists+linux-edac@lfdr.de>; Tue, 10 Aug 2021 14:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240745AbhHJMpp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Aug 2021 08:45:45 -0400
Received: from mail-bn1nam07on2069.outbound.protection.outlook.com ([40.107.212.69]:36423
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240244AbhHJMpo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Aug 2021 08:45:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbxayuznaoCCjRofltsB3fF8e1VlyNaHqJYajyIfRQmd6PXjOPtxGj0oy4NUx9EPTdh+kwrzjeOmcoacBT7+Tn+64gMO+5TMjF2dprgqpXMPCHqda2+fgMnj3fysGpshKOAJi2GZcQbbrgzlhwq08mn79vCZQGKGZRT43YMJMY2aWE5dd2WOjQ4JTQifI1SZf7EKb9OUv+Mou1cgy22BSPe2DGTlGihKTZteRL+uCwo5+tfpRkuF1pke3lAqMSnP+iC91GIQOcoOKoSAsRAU//xB1nmd/4hUG2h1BxGVfENU0XDbpkiJ3OGdusJ1n8jKMUIZiiqaLf6GJnrgmF0zAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9c1EdHkcXGIeUodk/cOzWNz1VrdzYs1aI476THuw+U=;
 b=YOfWSiYg9wUdSf6HdBO8GHmelVXrMiCQJcA+DvTY2/podrRTLfIv68SUsxrPK00ABCMRTGc3dmaUAy3jsVhrrgSGmCb0uMs7b944mjTWjGXgz4DOTnilUgFzXY/iJ7VBisHSYp9mDfBmNOK+LkmkcAdNtRjRaYW/zEepeKq4IbSn6xi6OoGmcyOlJWxLXeLnThhFgemSfuXykKIBxEQfu8Oqrhw20zVmWxld4334qsbKD76zRPheep3v+g6meayjfxiyU8VC8A4SpqPJazA/r/g4RXb10DEgvUylzQLw5g5xeD2D14HxnNd74ySgPO8NOXuvpV+RwAnZKMYwMT+XnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9c1EdHkcXGIeUodk/cOzWNz1VrdzYs1aI476THuw+U=;
 b=GnP5BIP5wcNKN2q4NCODhqNKOEIVxd86QtIyuHfGgrURSt4Q8/AYjSIR6yEZzXHZcPZaaW2aoD5qA7rFHr8Fmlk+tp1UW6JpcLlin03hFZeDkAY7KvWZf2KPilVPkL6BK3BjthqJNP6L7bLxqq1dFsCQOLNz01L8BvQc+Ym9pAk=
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL1PR12MB5335.namprd12.prod.outlook.com (2603:10b6:208:317::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.22; Tue, 10 Aug
 2021 12:45:20 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::38e0:44fb:fbfb:c8d2]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::38e0:44fb:fbfb:c8d2%9]) with mapi id 15.20.4415.014; Tue, 10 Aug 2021
 12:45:20 +0000
From:   "Chatradhi, Naveen Krishna" <NaveenKrishna.Chatradhi@amd.com>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>
Subject: RE: [PATCH 2/7] x86/amd_nb: Add support for northbridges on Aldebaran
Thread-Topic: [PATCH 2/7] x86/amd_nb: Add support for northbridges on
 Aldebaran
Thread-Index: AQHXbb9Q3Bvx9g+CvE+KigV7M3taJ6tK3Q0AgCIRJWA=
Date:   Tue, 10 Aug 2021 12:45:20 +0000
Message-ID: <BL1PR12MB5286AF6D10A89BBA9DB569EBE8F79@BL1PR12MB5286.namprd12.prod.outlook.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
 <20210630152828.162659-3-nchatrad@amd.com>
 <20210719202554.GB19451@aus-x-yghannam.amd.com>
In-Reply-To: <20210719202554.GB19451@aus-x-yghannam.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-10T12:42:02Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1c691f2d-70f2-44db-a047-ec20d6f21428;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a068562-919e-42a2-fe21-08d95bfcb6ea
x-ms-traffictypediagnostic: BL1PR12MB5335:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB533506A26BDC1870BF2A958DE8F79@BL1PR12MB5335.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gfZ+EyZ+xQKdhzcJX+NGMcFenIdyRiszh9Cz5M7yUy2+zpTkD6X1PoeiQOewQdvTM1z3JBs68giwBerx22hrUx4PQUgJ6eGwIrHj+M5geY7zTEdI1Z2j86/oi8OqJIsuaFzryazJUvQ5LCx63yebl8iF45slOd+9VIBTDb7V0a+iBP14fLqgImoa2oH0pMx7HERaVkZf2d6algJ90YzSr0UT6ap0hNL5yrZYxoeqwgXXBfaLln0JGG0CzNNAxSyzcnxzMRHKH1Qq+7R85UH0KPa50HjfTiOpVO1yCLC5Lx/7qwRaZlDoyk8UcS181XUyCXtYTDRypJGbpgmNBsQVZuSAv6bMuFdGXm6yxOF3X22kEH8c92xldTyZuuxIhDAgW7UtvA3xlW4/HrqiqTFfMJl70st30M8x3HZtNA9xssfr3/Y4UF2mgTQ61HCca+qUMlX7/HivKmlf1Bv4YJsTZ+sK81Gv4XZk3/IoVD14iwQP/ljr97FXXcR/c2XoiFHciXw+u42OO2oqDqGtPzrGmZ00Q0QX3d3qmA9Q6wZCUohYM2lehH7vkAn89sc26PPQRmDWiUUVb/jLnj87X/XB0pl7NaH7B2BmKSJRFajgxijT1DdhKGLJcEKGKNuhYsMGBH4WQe0mguTGNXkMrZf1Wwexnr7Ak4HKpF5aTPJhBjn3gHL5+z5CyidvJlviKZiB/GRzUv89b10vMa9fONUvmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(6636002)(316002)(7696005)(52536014)(478600001)(9686003)(71200400001)(54906003)(186003)(76116006)(83380400001)(6862004)(86362001)(66946007)(66476007)(66556008)(64756008)(66446008)(53546011)(2906002)(6506007)(55016002)(38100700002)(26005)(4326008)(5660300002)(33656002)(122000001)(8936002)(8676002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YNe9RaHoa57tubyeVWZONkQAO1sSpMfnLtXCCcI4znoBZMMw4CE98u+YHVDl?=
 =?us-ascii?Q?NeYLHapKT+bm+J2Q3fe825SBPEJ7R6JJW76X37fCCegVJw8UUqKGWqqKzCjn?=
 =?us-ascii?Q?nTCVE3dQih+BCMNxZE9KcMfDcqMza+wk+zktuu62qbnyea7AJGFzmo/L/l+K?=
 =?us-ascii?Q?0QczVz/5hk0filMI25qc7EGJU5FdGERRZnlRHxhRdE93ywbZ0wLsSBab/wlg?=
 =?us-ascii?Q?cFoKGUvjA3MMTfs4x+ffTyDljW9ppXWe8d09PHk4ROcoEI1t/HN9Oq7W45MQ?=
 =?us-ascii?Q?FaDJL7MNhKIlKi2JjBRev7qZnHLeX64/PibR+JsD+GTxaLNf04Csn4431P7E?=
 =?us-ascii?Q?9ZKIgnj5VyKt8KajtqfrRpBoWCF3ejRugIch+zlbI/wKtLdEBwLafBkCPME5?=
 =?us-ascii?Q?mTcKJopwI3gZUzOqi+CtL0BaXsR1QCrfGKFSHPSR26MAVXcZU8RxRV109Lur?=
 =?us-ascii?Q?Wjx5NOTRhcxX5clJcs3VV+X3ycgbmgUvCabIdFgjQF0y38RUzfMaOUgDimw+?=
 =?us-ascii?Q?SB2PW0KvyjIydzuVaoBaP5Xut55g9nftzw+f72I9b9PzGGv4rdAxnC9MryOt?=
 =?us-ascii?Q?Mnbxf7s/HZZ7/8z29qrNpjPaUgF96UFG2K0k+Rh21e+x7dzLg2Yyqi7Aonj0?=
 =?us-ascii?Q?T9XiLPZwUkdjFiROu7LWz1VUXCsgyxn6DcaKhNaaF8WI7lstRRsfYH2tUEFl?=
 =?us-ascii?Q?zXC1KASevJpSl60cTCih9vmdm4cauM3hoYj2mKpAMb7IpifD7yCXlAASvR3z?=
 =?us-ascii?Q?2iKXB2jDoiMWtarUBAgCIriXNXc9DBTEK6ybN+EYYrx11J0s4Nk1c/WVG3Dd?=
 =?us-ascii?Q?UqRG15EWMBWRri6l3LWI9cP9QBEARlLjSkf6TXWwuz3ywHToB99sixJ7OaMw?=
 =?us-ascii?Q?AS1tipsId7XonRXo72HXAy6Ve115L0Y6GvtNG1kydnAUwjyFX7sBV1x71ynl?=
 =?us-ascii?Q?+jix863WFztQENmhfQuBOgEo+RgDhwAslKwZnv9dsahi6M/xhH9g9l50/N29?=
 =?us-ascii?Q?F6qpt/XmBu7WHEoMfz+CLyggoYh6omFixnc32aLaFf2Jaa+K7W2ezr1O5OH2?=
 =?us-ascii?Q?/4xx16kAtUtpmxVQgoCAsEN4ATMboNwKDvO3t2SRSvhdSJmGCqC4DkcmITjA?=
 =?us-ascii?Q?vvDYrlzMhlkx4APTyYMnVRykICG2YWv3302w2dBEsSpCj+s4Fx4VBS8p8itg?=
 =?us-ascii?Q?kEhdEiioOLhpAVVBr5sb8qF71fa/Se6lCVO7gtluoHkdpD3nv3N1hiBY+JVg?=
 =?us-ascii?Q?rxqnt3FUsgQR+PPJ/MvgR0+UMtF39Tdfx7zkx0kJv9t2/SA5GHoDLtXwZsl9?=
 =?us-ascii?Q?cl+3WWIskQBA+1LtTGWo47zp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a068562-919e-42a2-fe21-08d95bfcb6ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 12:45:20.7310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f6gRFSv7U+zhp9hZbE13dW/2hBydxH2jxCpkvz5AoaorSe/vXPlBQ06FPfI932phEh0rTfdx1wdOs6pU9dxmYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5335
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

[Public]

Hi Yazen

Regards,
Naveenk

-----Original Message-----
From: Ghannam, Yazen <Yazen.Ghannam@amd.com>=20
Sent: Tuesday, July 20, 2021 1:56 AM
To: Chatradhi, Naveen Krishna <NaveenKrishna.Chatradhi@amd.com>
Cc: linux-edac@vger.kernel.org; x86@kernel.org; linux-kernel@vger.kernel.or=
g; bp@alien8.de; mingo@redhat.com; mchehab@kernel.org
Subject: Re: [PATCH 2/7] x86/amd_nb: Add support for northbridges on Aldeba=
ran

On Wed, Jun 30, 2021 at 08:58:23PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
>=20
> On newer heterogeneous systems from AMD, there is a possibility of=20
> having GPU nodes along with CPU nodes with the MCA banks. The GPU=20
> nodes (noncpu nodes) starts enumerating from northbridge index 8.
>

"there is a possibility of having GPU nodes along with CPU nodes with the M=
CA banks" doesn't read clearly to me. It could be more explicit.
For example, "On newer systems...the CPUs manages MCA errors reported from =
the GPUs. Enumerate the GPU nodes with the AMD NB framework to support EDAC=
, etc." or something like this.

Also, "northbridge index" isn't a hardware thing rather it's an internal Li=
nux value. I think you are referring to the "AMD Node ID" value from CPUID.=
 The GPUs don't have CPUID, so the "AMD Node ID" value can't be directly re=
ad like for CPUs. But the current hardware implementation is such that the =
GPU nodes are enumerated in sequential order based on the PCI hierarchy, an=
d the first GPU node is assumed to have an "AMD Node ID" value of 8 (the se=
cond GPU node has 9, etc.). With this implemenation detail, the Data Fabric=
 on the GPU nodes can be accessed the same way as the Data Fabric on CPU no=
des.

> Aldebaran GPUs have 2 root ports, with 4 misc port for each root.
>=20

I don't fully understand this sentence. There are 2 "Nodes"/Data Fabrics pe=
r GPU package, but what do "4 misc port for each root" mean? In any case, i=
s this relevant to this patch?

Also, there should be an imperitive in the commit message, i.e. "Add ...".
[naveenk:] Modified the commit message

> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
>  arch/x86/include/asm/amd_nb.h |  6 ++++
>  arch/x86/kernel/amd_nb.c      | 62 ++++++++++++++++++++++++++++++++---
>  2 files changed, 63 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/amd_nb.h=20
> b/arch/x86/include/asm/amd_nb.h index 00d1a400b7a1..e71581cf00e3=20
> 100644
> --- a/arch/x86/include/asm/amd_nb.h
> +++ b/arch/x86/include/asm/amd_nb.h
> @@ -79,6 +79,12 @@ struct amd_northbridge_info {
> =20
>  #ifdef CONFIG_AMD_NB
> =20
> +/*
> + * On Newer heterogeneous systems from AMD with CPU and GPU nodes=20
> +connected
> + * via xGMI links, the NON CPU Nodes are enumerated from index 8  */
> +#define NONCPU_NODE_INDEX	8

"Newer" doesn't need to be capatilized. And there should be a period at the=
 end of the sentence.

I don't think "xGMI links" would mean much to most folks. I think the impli=
cation here is that the CPUs and GPUs are connected directly together (or r=
ather their Data Fabrics are connected) like is done with
2 socket CPU systems and also within a socket for Multi-chip Module
(MCM) CPUs like Naples.
[naveenk:] Modified the message

> +
>  u16 amd_nb_num(void);
>  bool amd_nb_has_feature(unsigned int feature);  struct=20
> amd_northbridge *node_to_amd_nb(int node); diff --git=20
> a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c index=20
> 5884dfa619ff..489003e850dd 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -26,6 +26,8 @@
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
>  #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT	0x14bb
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F4	0x14d4
>

These PCI IDs look correct.

>  /* Protect the PCI config register pairs used for SMN. */  static=20
> DEFINE_MUTEX(smn_mutex); @@ -94,6 +96,21 @@ static const struct=20
> pci_device_id hygon_nb_link_ids[] =3D {
>  	{}
>  };
> =20
> +static const struct pci_device_id amd_noncpu_root_ids[] =3D {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT) },
> +	{}
> +};
> +
> +static const struct pci_device_id amd_noncpu_nb_misc_ids[] =3D {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F3) },
> +	{}
> +};
> +
> +static const struct pci_device_id amd_noncpu_nb_link_ids[] =3D {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F4) },
> +	{}
> +};
> +

I think separating the CPU and non-CPU IDs is a good idea.

>  const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[] __initconst =
=3D {
>  	{ 0x00, 0x18, 0x20 },
>  	{ 0xff, 0x00, 0x20 },
> @@ -182,11 +199,16 @@ int amd_cache_northbridges(void)
>  	const struct pci_device_id *misc_ids =3D amd_nb_misc_ids;
>  	const struct pci_device_id *link_ids =3D amd_nb_link_ids;
>  	const struct pci_device_id *root_ids =3D amd_root_ids;
> +
> +	const struct pci_device_id *noncpu_misc_ids =3D amd_noncpu_nb_misc_ids;
> +	const struct pci_device_id *noncpu_link_ids =3D amd_noncpu_nb_link_ids;
> +	const struct pci_device_id *noncpu_root_ids =3D amd_noncpu_root_ids;
> +
>  	struct pci_dev *root, *misc, *link;
>  	struct amd_northbridge *nb;
>  	u16 roots_per_misc =3D 0;
> -	u16 misc_count =3D 0;
> -	u16 root_count =3D 0;
> +	u16 misc_count =3D 0, misc_count_noncpu =3D 0;
> +	u16 root_count =3D 0, root_count_noncpu =3D 0;
>  	u16 i, j;
> =20
>  	if (amd_northbridges.num)
> @@ -205,10 +227,16 @@ int amd_cache_northbridges(void)
>  	if (!misc_count)
>  		return -ENODEV;
> =20
> +	while ((misc =3D next_northbridge(misc, noncpu_misc_ids)) !=3D NULL)
> +		misc_count_noncpu++;
> +
>  	root =3D NULL;
>  	while ((root =3D next_northbridge(root, root_ids)) !=3D NULL)
>  		root_count++;
> =20
> +	while ((root =3D next_northbridge(root, noncpu_root_ids)) !=3D NULL)
> +		root_count_noncpu++;
> +
>  	if (root_count) {
>  		roots_per_misc =3D root_count / misc_count;
> =20
> @@ -222,15 +250,27 @@ int amd_cache_northbridges(void)
>  		}
>  	}
> =20
> -	nb =3D kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
> +	/*
> +	 * The valid amd_northbridges are in between (0 ~ misc_count) and
> +	 * (NONCPU_NODE_INDEX ~ NONCPU_NODE_INDEX + misc_count_noncpu)
> +	 */

This comment isn't clear to me. Is it even necessary?
[naveenk:] moved the message

> +	if (misc_count_noncpu)
> +		/*
> +		 * There are NONCPU Nodes with pci root ports starting at index 8
> +		 * allocate few extra cells for simplicity in handling the indexes
> +		 */

I think this comment can be more explicit. The first non-CPU Node ID starts=
 at 8 even if there are fewer than 8 CPU nodes. To maintain the AMD Node ID=
 to Linux amd_nb indexing scheme, allocate the number of GPU nodes plus 8. =
Some allocated amd_northbridge structures will go unused when the number of=
 CPU nodes is less than 8, but this tradeoff is to keep things relatively s=
imple.

> +		amd_northbridges.num =3D NONCPU_NODE_INDEX + misc_count_noncpu;
> +	else
> +		amd_northbridges.num =3D misc_count;

The if-else statements should have {}s even though there's only a single li=
ne of code in each. This is just to make it easier to read multiple lines. =
Or the second code comment can be merged with the first outside the if-else=
.
[naveenk:] Done

> +
> +	nb =3D kcalloc(amd_northbridges.num, sizeof(struct amd_northbridge),=20
> +GFP_KERNEL);
>  	if (!nb)
>  		return -ENOMEM;
> =20
>  	amd_northbridges.nb =3D nb;
> -	amd_northbridges.num =3D misc_count;
> =20
>  	link =3D misc =3D root =3D NULL;
> -	for (i =3D 0; i < amd_northbridges.num; i++) {
> +	for (i =3D 0; i < misc_count; i++) {
>  		node_to_amd_nb(i)->root =3D root =3D
>  			next_northbridge(root, root_ids);
>  		node_to_amd_nb(i)->misc =3D misc =3D
> @@ -251,6 +291,18 @@ int amd_cache_northbridges(void)
>  			root =3D next_northbridge(root, root_ids);
>  	}
> =20
> +	link =3D misc =3D root =3D NULL;

This line can go inside the if statement below.
[naveenk:] Done

I'm not sure it's totally necessary since the GPU devices should be listed =
after the CPU devices. But I guess better safe than sorry in case that impl=
ementation detail doesn't hold in the future. If you keep it, then I think =
you should do the same above when finding the counts.

> +	if (misc_count_noncpu) {
> +		for (i =3D NONCPU_NODE_INDEX; i < NONCPU_NODE_INDEX + misc_count_noncp=
u; i++) {
> +			node_to_amd_nb(i)->root =3D root =3D
> +				next_northbridge(root, noncpu_root_ids);
> +			node_to_amd_nb(i)->misc =3D misc =3D
> +				next_northbridge(misc, noncpu_misc_ids);
> +			node_to_amd_nb(i)->link =3D link =3D
> +				next_northbridge(link, noncpu_link_ids);
> +		}
> +	}
> +
>  	if (amd_gart_present())
>  		amd_northbridges.flags |=3D AMD_NB_GART;
> =20
> --

Thanks,
Yazen
[naveenk:] Than you
