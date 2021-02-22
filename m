Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7391D321F10
	for <lists+linux-edac@lfdr.de>; Mon, 22 Feb 2021 19:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhBVSVb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Feb 2021 13:21:31 -0500
Received: from mail-bn7nam10on2117.outbound.protection.outlook.com ([40.107.92.117]:36352
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232385AbhBVSUt (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 22 Feb 2021 13:20:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3v1Q5EfrxpDo3Z0WXYN1l1Dr/zQYgEfiwH8Dm6VT+nTaICLPDzEfxp25VmKjwbrFHInXbLKIwd+Y0ngKxyT81SPa2T5zXRJd7O4M/o+LZEGF/yuQjWQEX3Nc2ON52LoZQlOR4uW1c8QJ3whi3/CvjVn8imtxOAxWWiNmqpJAZrR++Ahu8IZCmX27BmkkdNSKAnFIBo1erEhIk3Kgvfafma/QfYBlCbf4MO5lA18hpFWRuXXmgYT+ilDgRhPg8tS086ehHflu+r5ruNUtdloK4v0150W0/Vv3/S06iCAboNxZEx52t+yLW92Iw/GcDfuy457HKuuqvNHhSUDFqa9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gh3Gpgubv0JtMxzKGviUxyD7N+jFax6rtIhe39hrQVA=;
 b=bwQtZTPuPTyuDBbwrRPu5tbwmDU90fC9NILI4ghbMMy2d9xPVd8J6Jvrz0uTpiAkydHmCIhdL7QZI4nTIuAHWYGNrVavwk/Y6vpcAqPOHiNlhyU2mGeazY4HjU1relygU+yVuDrsFM3h7Uh5GpgvwcNUH0fAwiU0HjVSiS0rRNmvjjJSPkGq1+9XXjlUNABt4t9RCKGgfOJTXxjCrC/zGFGo6Unk4uCqYbDrASdIexaffrX+NeJNUIP0H9uN3KJzf13kqbJ7Rqn4M63t4YZ5vOjaU1K4ugTdY6iFSaxGnI5obVRFffBhlzqJuU7ZmdeXvl0EukV9Cyy1CZAB3mvnug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gh3Gpgubv0JtMxzKGviUxyD7N+jFax6rtIhe39hrQVA=;
 b=L4VBCTb4nCiCfRVEPXkl98PHODthbETAJNNkdRvju5Xq6K2PECIHA/iO6iHmm4ZLB5zFPlHdBP5irX6VLuraqdN5kZxX1PbL+UxzABoeg4SE2CJ75i5e+TaL5LFJkxx2Ln6gCsJLDbyVknUYy6VrS3Ee0jyx7qPpKEssmKfB7D4=
Received: from BY5PR22MB1841.namprd22.prod.outlook.com (2603:10b6:a03:21f::8)
 by BY5PR22MB1841.namprd22.prod.outlook.com (2603:10b6:a03:21f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Mon, 22 Feb
 2021 18:19:56 +0000
Received: from BY5PR22MB1841.namprd22.prod.outlook.com
 ([fe80::28b1:71a4:7da7:7f22]) by BY5PR22MB1841.namprd22.prod.outlook.com
 ([fe80::28b1:71a4:7da7:7f22%8]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 18:19:56 +0000
From:   Kurt Martin <kmartin@wavecomp.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-hams@vger.kernel.org" <linux-hams@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL]Re: [PATCH 0/5] Remove dead linux-mips.org references
Thread-Topic: [EXTERNAL]Re: [PATCH 0/5] Remove dead linux-mips.org references
Thread-Index: AQHXCULWdQk/F3s/b0W7KeJnqupL6qpkeiOw
Date:   Mon, 22 Feb 2021 18:19:56 +0000
Message-ID: <BY5PR22MB1841658D64FB8D8B619BC870C7819@BY5PR22MB1841.namprd22.prod.outlook.com>
References: <20210222161905.1153-1-lukas.bulwahn@gmail.com>
 <alpine.DEB.2.21.2102221836030.1900@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2102221836030.1900@angie.orcam.me.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: orcam.me.uk; dkim=none (message not signed)
 header.d=none;orcam.me.uk; dmarc=none action=none header.from=wavecomp.com;
x-originating-ip: [12.86.84.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e5dd7a5-bf5c-46d9-e9eb-08d8d75e74fe
x-ms-traffictypediagnostic: BY5PR22MB1841:
x-microsoft-antispam-prvs: <BY5PR22MB184147CF625B1C50A5BC439FC7819@BY5PR22MB1841.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zWARBJON/YF/HD/rL3DxUG8QHLZhNS1gcRW7Q5/H7Sj7gLNRRNUlD3z3WoMGqO/7MV+8nbSUP6p9Motci5rJ35nLDWBzw0k5/Hs1wigUeMHobxPGYeEFJC7Zwzoe0DoJu4Od5mI4ROkvvnvOlDAYqfrbTqmsehfwbC1SztLSyuvH4j6S/Kk0u9TrMEM/w5xYqRwKxBit5m1iQQQE0Nq7VIMFO37s2tt/7bNnpj552W05PKvZ8eQUS+aYf9qnmnOy7Tkq0dDmTEV4IBB9t4vUkvW/lNcwyCD99qs9bG5GaK5/qKvNElxxwhknCADSUVE8w7Gr5r+mM3dsmSlPjcS+0Q0ZveAYhIQvdlVfo+FeyN7qd6u5dgm7bD3ZQNklDzUWbYBgoRfrwjZYW2MWYcRroY52AoyJ9czn3QVjq6YGfk8mxpXej1BPwgnavOim612bOLc7d7jnirBXMocFc+uuL+cVMwWmKgXbBwuSZGDpAgxRNZ/k0b9v7j/wWGb05ESYHpITsZxjl28YQp2aX1KNtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR22MB1841.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39830400003)(136003)(376002)(396003)(346002)(478600001)(7696005)(83380400001)(71200400001)(5660300002)(86362001)(66946007)(8676002)(8936002)(64756008)(54906003)(66556008)(66446008)(76116006)(66476007)(33656002)(26005)(53546011)(9686003)(186003)(7416002)(316002)(110136005)(4326008)(52536014)(6506007)(2906002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?uSbv4J52GEWQdjLMybIAXfAzdwaTUDWyWHFZbkPnOI1Ci7BoX07pqL0Edg?=
 =?iso-8859-1?Q?qOqxmdulH3Hp6s1/X+vXi+eoqetSObWw/2EPihmZPNfvG+wrhgZ1lhvpJK?=
 =?iso-8859-1?Q?VPrUErXcUY+fujZPHXOk5smpkBBcwt7icn8ODSNRczhkvqSDFZTOSCdFPV?=
 =?iso-8859-1?Q?PwoZulU3APrA3UzGF/2WOFTNLRH6RLx8NBcUTYRfZhFywm0wFbWZL5CSoC?=
 =?iso-8859-1?Q?SIRM2dAaf4ZSjL2EX0GIuTgh41rLma7xuDJJl8Ro+f3IwRRP94C+Bt4oTx?=
 =?iso-8859-1?Q?+4saXqPRw/EKpOpPa0vVAFHrc6mcJH+GX9vrYC7U5TcUGdyx6i/OVor28/?=
 =?iso-8859-1?Q?qdJT0QhUprBJk3t3LUnoNja5eFnCHtswOoG23hPq1XmeBLDdIcpzECTRyy?=
 =?iso-8859-1?Q?bf0sCtn2pbyLfGfwMEZhIsILvtiVB+Asaxo/gCkLYthScwmnURvTg3VWJv?=
 =?iso-8859-1?Q?kp/IEqUnADBxfDqva3U8XzNMnSBQ0KQcrACW5LVbWN8zImNITRfKziQ6af?=
 =?iso-8859-1?Q?lsX7xdAdVO03zLKdD9bozUfajBhyGq8sCNDjWkbw3vLm98pwllzj61zXU2?=
 =?iso-8859-1?Q?8Px4X9L66MmekniF3qeMlE65eRGOereqzfDhgBNDxR0DP3QQW87lsgrKp+?=
 =?iso-8859-1?Q?teu1RIXsbdqylNH2qYWqkI9OPJfTA2S2Hppg56ZGVwW0MPj++8Aj/mDVDQ?=
 =?iso-8859-1?Q?tcLqYmLUCry1CsSK36+a5+86FeN+bAsTYrb9GlPU9gY/hQjFjeZjOOvoLf?=
 =?iso-8859-1?Q?3LfGHL7xGP07g2dhPz6myy/OgGJxSdrqEQ6aj21h739LObBFv8HVja5uwo?=
 =?iso-8859-1?Q?Gdf/AdHguAFb9iG7ZdUyInQS9l7BVfzpjijfiq+aQeVO8FTwxl5J6nYH18?=
 =?iso-8859-1?Q?E2Nw6VfYElXhefasxX4wKWvMEb3o8oKcPZ85B7GF0Ylq9PJ/7imcgN0EFk?=
 =?iso-8859-1?Q?moH7MoJ8unsc78pfWoC+KdDYsNC9LcptP8suREyyJs1Gh/QjapEgCLa66q?=
 =?iso-8859-1?Q?1eEEOLcOMQ8LU7/trm+TPqs0Ko94VrH/JPmdkF99m3FOzHVGABZaosCCXl?=
 =?iso-8859-1?Q?zO5cwGlLrsH8DSqq2enQzbqFVr+HfX+jFMZjywTzDclEZxlTffSyifi5ei?=
 =?iso-8859-1?Q?ypS0juL2z9K6IlHIEtdBmMh2v7ev+/GuTrQlQpKNzLZ6oen1yN+h2s2WRh?=
 =?iso-8859-1?Q?AHnV7srURP5j38u54UdN64ubtxDAq3xEcGsDmjQ6sKOpYBN2yDgtvqMsGD?=
 =?iso-8859-1?Q?KtelZB6TRkr8Gbn/2/eIHdE5Fzznx6Snc1Qs05Zk+YPsY5JIWeMdErJ06z?=
 =?iso-8859-1?Q?61hnrkjEevRUlIGreCLJIzxo0aoB47En8QWGDmCJeXn6igE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR22MB1841.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5dd7a5-bf5c-46d9-e9eb-08d8d75e74fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 18:19:56.1839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VeCrO+O3O7s1CGo8PfphEwSnMHgxItkdiZmjp1nDFiefDV45bw7NWka92vtKYXjEeezjm/t7O2uwMjJfWh735g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR22MB1841
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Everybody,

This is Kurt Martin.  I'm part of the MIPS Customer Engineering team at Wav=
e Computing.  Some of you may remember me.  I have just established contact=
 with Ralf, and I will be working with him to restore linux-mips.org back t=
o life.  I just got the account and login information for the linux-mips.or=
g hosting account at Hetzner from Chris Dearman.

So as Maciej says, please hold off any actions at this time, and I will att=
empt to get linux-mips.org working again as quickly as possible.  Thanks!

Regards,
Kurt

Kurt Martin
Senior Customer Support Engineer
Wave Computing
kmartin@wavecomp.com=A0
o +1 408 530 5180

-----Original Message-----
From: Maciej W. Rozycki <macro@orcam.me.uk>=20
Sent: Monday, February 22, 2021 9:48 AM
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>; linux-mips@vger.kernel=
.org; Tiezhu Yang <yangtiezhu@loongson.cn>; Willy Tarreau <w@1wt.eu>; linux=
-edac@vger.kernel.org; linux-hams@vger.kernel.org; kernel-janitors@vger.ker=
nel.org; linux-kernel@vger.kernel.org
Subject: [EXTERNAL]Re: [PATCH 0/5] Remove dead linux-mips.org references

On Mon, 22 Feb 2021, Lukas Bulwahn wrote:

> The domain lookup for linux-mips.org fails for quite some time now.
> Hence, webpages, the patchwork instance and Ralf Baechle's email there=20
> is not reachable anymore.

 I have been contacted by Ralf a couple of weeks ago and he told me there h=
ad been a storage failure with the machine running linux-mips.org.

 Due to a complex situation with linux-mips.org I do not want to dive the d=
etails of into here recovery of the site caused some trouble, however I was=
 told it had been under way now.  So I suggest that we wait a couple of wee=
ks yet and see how it goes before going ahead with this series.

 As to Ralf personal commitments WRT maintenance duties I can't speak, but =
I have bcc-ed him on his alternative e-mail address with this message in ca=
se he wants to speak up.

  Maciej
