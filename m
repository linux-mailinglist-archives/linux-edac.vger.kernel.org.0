Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4058AC68F
	for <lists+linux-edac@lfdr.de>; Sat,  7 Sep 2019 14:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfIGMJX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 7 Sep 2019 08:09:23 -0400
Received: from mail-eopbgr810073.outbound.protection.outlook.com ([40.107.81.73]:35810
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbfIGMJX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 7 Sep 2019 08:09:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsEs7eAzWemWdFbaMwDpu78oR3cWrcGPW94QR5/+zN46fYAutZXQ/DSlfK7liTZ/Qya1pDqj5HeSxAsZWgwOrwNcIWqnbXy16OIBnYFzl7omKDD3uCN+nsXT6TDwyin4t7+wCkEE038UWUCIZjbarFC/NQOxGL3eyqr4KSa7CqQHy7O5LRbrVcH+Sjr+GCzDpp8+8aZQTYEPY9tiNFgHxK9zJED9oO55J3Xqu0GJ8TxJUKZi0iJWxzSh/02gM8W3WxkQ1T06XDNhkwweAUoqsvQL/6paItFRY40ED4ciW6Y+gIauTu5sgPmIZ0tBcwxDJ9GccSv+1dbGts37p45niA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3ivv34ffU0etiFSjpDTZMgKGGZ05g4C7pcAXOdARxg=;
 b=HpLFu5kOe4wR8LNn9R5Vz6XkTq+wGlbZHh7AFAo5OU8M9SpMHCG20Ixd+YeJ8ZYtoojr2j0IpJAWT2uyK8wRypfM+QWs6zg+NW0lqwyLhA0RlaS++Y8gsT9ZYveXAtCRkLo2S/JZ2BrF6ELb0Z5GSwhMvXTJ83a7ZnjbuJ9pQlIHBsiAWW9Fyg5beVZ0/Zir3npxQll4P24NzcbJy9oNHM54V1qHrWj+m4Ti0f5rez8dIx3sIvT4D66RNhLpS2GDLMh1FvsiwvRCK0AZmAoZHxl+hyr6fQhDkuKKq/boQyaMQ/EVMKNNOJlHYShFR/k2PW94cdML+d/Ft9ZyLdua8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3ivv34ffU0etiFSjpDTZMgKGGZ05g4C7pcAXOdARxg=;
 b=d9q1lutZzLIDLO228SCCdraX2BhUyVyWLfMuE39dVNuu+/u/+n/pj5UjtkFENt2MqmD/RGzd+8z0CEJKy7m0t+fnGo619VlFtxfVpHB5a+01O/HDd2VVQa9wPdhI92mZtvTD7h/KtiMaxXmHRkUq/+qaXoCE1k+fCwq1kCsQOT8=
Received: from BN7PR07MB5186.namprd07.prod.outlook.com (20.176.176.155) by
 BN7PR07MB5156.namprd07.prod.outlook.com (20.176.26.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Sat, 7 Sep 2019 12:09:15 +0000
Received: from BN7PR07MB5186.namprd07.prod.outlook.com
 ([fe80::682e:801a:5227:668f]) by BN7PR07MB5186.namprd07.prod.outlook.com
 ([fe80::682e:801a:5227:668f%7]) with mapi id 15.20.2220.022; Sat, 7 Sep 2019
 12:09:15 +0000
From:   Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>
To:     Borislav Petkov <bp@alien8.de>
CC:     Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add PCI device IDs for family 17h, model 70h
Thread-Topic: [PATCH] Add PCI device IDs for family 17h, model 70h
Thread-Index: AQHVZQnUh7Ebv130M0alIHUhtmAMhacfuLCAgABnVYA=
Date:   Sat, 7 Sep 2019 12:09:15 +0000
Message-ID: <20190907080907.d6214d7f628e543bca718bd2@knights.ucf.edu>
References: <20190906192131.8ced0ca112146f32d82b6cae@knights.ucf.edu>
        <20190907055917.GA10446@zn.tnic>
In-Reply-To: <20190907055917.GA10446@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR0101CA0014.prod.exchangelabs.com
 (2603:10b6:405:2a::27) To BN7PR07MB5186.namprd07.prod.outlook.com
 (2603:10b6:408:2a::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=isaac.vaughn@Knights.ucf.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
x-originating-ip: [132.170.63.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e44023b-d800-45bb-445a-08d7338c338e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN7PR07MB5156;
x-ms-traffictypediagnostic: BN7PR07MB5156:|BN7PR07MB5156:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR07MB5156A05093F94CC58BC2944BCEB50@BN7PR07MB5156.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0153A8321A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(366004)(199004)(189003)(52314003)(3846002)(6116002)(88552002)(229853002)(50226002)(4326008)(7736002)(305945005)(8936002)(81166006)(81156014)(8676002)(966005)(6916009)(45080400002)(478600001)(6486002)(6436002)(256004)(5660300002)(71190400001)(66476007)(66556008)(64756008)(66446008)(25786009)(53936002)(6306002)(6246003)(71200400001)(66066001)(66946007)(6512007)(86362001)(99286004)(54906003)(1076003)(14454004)(186003)(6506007)(386003)(76176011)(786003)(316002)(52116002)(2906002)(75432002)(26005)(486006)(44832011)(476003)(2616005)(446003)(11346002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB5156;H:BN7PR07MB5186.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: Knights.ucf.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jkt9EzSl2tJ2n6l9Jsc8BTSLPOFP2nYcpuyS9pu5Pa7LSJovpVXxh1kjQeKAHfRkAyhRqsS964adIUqGVs9+FQPs2DUpsKCMj8aJZJAeY8eqLeOgCy9qCad0/Ko8Snd5rotBJc66pHj0yfG7btm0z4ZIX6z3e/Wn7nS5Q1nY7koN77jmXf12FVobg7hUQeoNbnDnD9o/fk9n0NHGb5IFKhZsOCu5sN+tOEVMoNK1vA/hNMOXBH+JuhHKXcdM1NwLNeaubQzYyMldWtA302mw6PCboM8qooezUgQKeehAXPczgRZnK1DPJ/PzS3m0zmJ57RLXHMxVSn49GfBjj7I5VJNcnmqLlGBvke2vlP4QXjkHfmjH7OtO3ubKDcIFgoFPXKJySsyoKOu/ZPNaxT+KSSku1VU453FHkNLfLRA94oI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C46086C54B6C804D8AF6B318820BCDE8@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e44023b-d800-45bb-445a-08d7338c338e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2019 12:09:15.3811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P7yxLc5+Gn2NWuBK5bJNbD156IOcTAWwOCNUGMgcaMGYZ8AeQa6mvKJQDInN4yh+AKqy/cDYkGrrx1zsMWdjQmf+Xr5C1o+qCjCnoQHidqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB5156
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> > Add the new Family 17h Model 70h PCI IDs (device 18h functions 0 and 6)
> > to the AMD64 EDAC module.
> >=20
> > Cc: Borislav Petkov <bp@alien8.de> (maintainer:EDAC-AMD64)
> > Cc: Mauro Carvalho Chehab <mchehab@kernel.org> (supporter:EDAC-CORE)
> > Cc: James Morse <james.morse@arm.com> (reviewer:EDAC-CORE)
> > Cc: linux-edac@vger.kernel.org (open list:EDAC-AMD64)
> > Cc: linux-kernel@vger.kernel.org (open list)
> > Signed-off-by: Isaac Vaughn <isaac.vaughn@knights.ucf.edu>
> > ---
> >  drivers/edac/amd64_edac.c | 13 +++++++++++++
> >  drivers/edac/amd64_edac.h |  3 +++
> >  2 files changed, 16 insertions(+)
> >=20
> > diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> > index 873437be86d9..a35c97f9100a 100644
> > --- a/drivers/edac/amd64_edac.c
> > +++ b/drivers/edac/amd64_edac.c
> > @@ -2253,6 +2253,15 @@ static struct amd64_family_type family_types[] =
=3D {
> >  			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
> >  		}
> >  	},
> > +	[F17_M70H_CPUS] =3D {
> > +		.ctl_name =3D "F17h_M70h",
> > +		.f0_id =3D PCI_DEVICE_ID_AMD_17H_M70H_DF_F0,
> > +		.f6_id =3D PCI_DEVICE_ID_AMD_17H_M70H_DF_F6,
> > +		.ops =3D {
> > +			.early_channel_count	=3D f17_early_channel_count,
> > +			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
>=20
> You still have f17_base_addr_to_cs_size here. If you'd built it against
> the branch I pointed you at:
>=20
> https://nam02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
ernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fras%2Fras.git%2Flog%2F%3Fh%3=
Dedac-for-next&amp;data=3D02%7C01%7Cisaac.vaughn%40Knights.ucf.edu%7Ca142cf=
f36aab414087c608d733588d1f%7C5b16e18278b3412c919668342689eeb7%7C0%7C0%7C637=
034327751460625&amp;sdata=3DKy1T%2F9tWeNYEDcLftxU%2FQyVeN0zbrmRIrH5fHF2Mz8s=
%3D&amp;reserved=3D0
>=20
> it would have failed.
>=20
> Anyway, I fixed it up and applied it.
>=20
> Thx.
>=20
> --=20
> Regards/Gruss,
>     Boris.
>=20
> https://nam02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeopl=
e.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=3D02%7C01%7Cisaac.vau=
ghn%40Knights.ucf.edu%7Ca142cff36aab414087c608d733588d1f%7C5b16e18278b3412c=
919668342689eeb7%7C0%7C0%7C637034327751460625&amp;sdata=3DmOi8dnvpzomUvfX4F=
AabgA5G0A8tr3bMcbUx%2BKB91r8%3D&amp;reserved=3D0

Sorry about that, I didn't follow that edac-for-next was a branch and built=
 against ras master.

Thanks again for all the help.

Sincerely,
Isaac Vaughn


