Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6ECE414E15
	for <lists+linux-edac@lfdr.de>; Wed, 22 Sep 2021 18:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhIVQ3H (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Sep 2021 12:29:07 -0400
Received: from mail-dm6nam08on2042.outbound.protection.outlook.com ([40.107.102.42]:4608
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229671AbhIVQ3G (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 22 Sep 2021 12:29:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnLXTaGDSeGDhedyfGrPBskm3131jvlqF/uNrTwP81aYmM6VLQ0Lzt7+4OgS/KqL0Kx8AOzNun8Fv7v6fLzB6nPLUPz/s9JJXvzByemNhYoQ0d+h9cKvnorg9dG/6TZfOFb/pvSydlARvPxeNHITH0hpkcVrTvnXSvp0R7m6wIFuWzwIY0Em3YTxRuev8IprQtlQZ7U+/+Dw0pAKjc623Hw2Wvb2QVhpgxZ6UDp7IP+XoT4sZrCeGj+lTuleLjnepx9fH1I4s44/kIFFIxaaQfqTLkGBXcg/RJGXAHbDgmhv35U4555P8w5Aat8jvhuArqnftvh+lMQiqAlKRRmvCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZEupYmMCKXYocHTObK9CcGUNExxzh4kfHXYpUnpWCaM=;
 b=gQGaWqvmrdC1RhABliJHp5er3EG2jllmM23onR30BswGivCwu1pH5OZHIlKRTEjbb4lXVSPv9Qg0Li/Hlvnsh1S1CvWfmMhNKuCIH0Ux9sKFmIgvANT3pvrJGaJNR3JuSOczcSjdN4u+nPG516v4GhFHr1JOWVKLCGwZvTsEZe0VlGvkDTnT/VVPf2o5EaQvwr29m6efeVYP1y9KOU5zn1SFLSbw+bxaLAzqHIgxMej5YzvCIF3YOFgT8kVA1Zkh0Nw6kRwcX31hF3ia08p+v3J9SfOgKtOIFTC0GzUBbNmexsV/FTsgp47uIXVofjo5hvV1BfoZ+gYCS7wIMsujdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEupYmMCKXYocHTObK9CcGUNExxzh4kfHXYpUnpWCaM=;
 b=Nvo/Dsew13AkUeEEz7SCedfIjZGqnth+A+H4wVVKZ3JMj/lj3wQkKIOEnhi5fNMH2tZfx6iZmFim6SYtttHxt9EtHIGno+zBg7lJWLjFbAIf9D/5JfYdq/iuqqd/HOXt/EhgCKs7hiPsF6gzYibKiyD+4PoAQdtyy5j8cnyLZOo=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5141.namprd12.prod.outlook.com (2603:10b6:208:309::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 16:27:34 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::7140:d1a:e4:a16a]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::7140:d1a:e4:a16a%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 16:27:34 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Joshi, Mukul" <Mukul.Joshi@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCHv2 1/2] x86/MCE/AMD: Export smca_get_bank_type symbol
Thread-Topic: [PATCHv2 1/2] x86/MCE/AMD: Export smca_get_bank_type symbol
Thread-Index: AQHXqEUSdjNpA2ICZkm9W3JF6J6Jqquv+uwAgABRe8A=
Date:   Wed, 22 Sep 2021 16:27:34 +0000
Message-ID: <BL1PR12MB51444DA94F2DE3D12BBF31D1F7A29@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210511152538.148084-2-nchatrad@amd.com>
 <20210913021311.12896-1-mukul.joshi@amd.com> <YUsUpkvP8zpz8yRz@zn.tnic>
In-Reply-To: <YUsUpkvP8zpz8yRz@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-09-22T16:27:31Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=13e84167-75b0-4fb3-a0e2-e85529697ec5;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f034f20c-9d6b-435d-75ef-08d97de5e1fa
x-ms-traffictypediagnostic: BL1PR12MB5141:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5141B78B13E138AB8E1FE184F7A29@BL1PR12MB5141.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VMSnc6613HKxaIUWdtHD7sQqYdbC2Q9fpqVx+XBzOGAJbEL3232q3dPOqKpT968FCrAbeOgCN0RMbb22K/FnheThZ0IHffbG7CIjNscQOhTfxI9sbBAPmOIIU58ptVZEffazw34NfNka0azSjDP45Z8fvVxhJjprD4RpqAoaRuuW9aSynUsybmIj7hqTmpgXjBwB1ehrtd/m5QhOreVmj1k48EqurT+5PSU29OluGIT+hg39byAVRb3FZIctIQJWc5XdctCM6P9miCuga0WkszwyYxNgk6i/dbmPqYPP08ibGZKORTlNcIYTzWYNSV2hQjcT57XqN0dSfAO3fTu2A+34zHgShuSeOi1K/4CkcHPI7QWsgVBRbmBdP3kdJtmvqV7giRdW0ifQcYfOuvUzqp4wILAzhLNYgdnwXa+63Q5xerDCZrZLEgE6ytqOLlRSC32O01FnEsoI5nhc8w4y7mPyq/LY4beIFQdSRzQfH7ouKi1KzFYQ4izjmRT//wkXgRtgTk2O0sRmkqOdYKsGCNNngcqM5ziCH041Lss0+wa5aXJRtxujVCCBLkxvz2eaJBtBO4XNFpO9MYdV2HIX7lG3OZr/LBgV57B3bwSBCYUvXKJtNBY8trdcS1WlD9dO+1Lmam0Zaasvmb5vzhhr4E0IFczOPt9jFCykjenq9+IGv0kdNUqCMycW5aKU6HNNlNOirqazB6WeP+Pouw5ssEgBCIPPARoaYP3EgH47ZSv3qpetNmBkcX3qRauXvB+otPTPK7+lzxmDomGCnTJBP7hFovFE5RBR7FIlSWvRqCY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(53546011)(66446008)(76116006)(8936002)(5660300002)(26005)(64756008)(2906002)(83380400001)(54906003)(33656002)(4326008)(8676002)(110136005)(86362001)(316002)(9686003)(6506007)(7696005)(186003)(71200400001)(966005)(508600001)(55016002)(66556008)(66476007)(122000001)(38100700002)(45080400002)(38070700005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K9Eal3a+3riLG0Lb8ak6YAfFjakQFAC0QMGXZvhGTJYq0AHmBVL1NV81Ef+P?=
 =?us-ascii?Q?MHMUj0opTmjNDJGB2nEoIm3r5H5uD6jPt/yCRpsHSWJ3p5R2VsS3C3YKLl6O?=
 =?us-ascii?Q?JBMUUY52/lfJVMnRm72jfqDVmcR5Rp+F4aByRShMwp0Lih1bsZtoUbObugLn?=
 =?us-ascii?Q?dwDTX3e57LfaXX4D2PYqOcutH9JWlo9icKfyF6+pZnQu0QYN9Yxlib0vvGx4?=
 =?us-ascii?Q?K3gIgQn2BypVRQPlHCHKyAttVHpdKaaSElQx308yI+pn8w2SSXvhF/9aZJr3?=
 =?us-ascii?Q?lEnu806tJLwzGaMaBfm2STblFOlIVSB9SMqjLx3VjsP7qH1Okf4WHtHZPT8B?=
 =?us-ascii?Q?J/mWLDqun6FXJiTGtnggkZ3nmmK8xlRy9TWWq00Cmv3U4SKPiIQZ3pDFZrwA?=
 =?us-ascii?Q?Am3VcMvfy/ofH1sx1H6KZAslLNaVsdTNkWocr/pZEAuTzM3du0U6unLrmBhn?=
 =?us-ascii?Q?4qDufnJ0fQyubg67x6oKPO8is8ReHKtB631+iq5/JNY8+O6A9xdxz9kj0vmb?=
 =?us-ascii?Q?N8UiCEHDNPQBkFBFNHaHYDgLAD4WGkdT28nAes/7Y+/RSkiYzFT3DXp4iDpL?=
 =?us-ascii?Q?mECK8yyfUgLD0f0FX+NJ5Ifyt3CPxCpm9nzQEEySnScBG1fqohxL1CBqiKSX?=
 =?us-ascii?Q?2gOECXQepsYB5DSs1YfsYod5CfbpVpPshQIevgXHhfi8qopfSCRjiHVImGnw?=
 =?us-ascii?Q?I7gDibLCCnWwY0b5tcZw3R1AmLTBBUfCgXS1H1w0quodjvPk7/8T2ORZEdSq?=
 =?us-ascii?Q?5zSaMwWsaD2Im67+NEyK6xIKBsX/kTtWVHQBXrQfwjJrXTgNR7jCp7xEcM1e?=
 =?us-ascii?Q?f/ejYaGb1VCTUinJ8HEUFWTF/rzVhGhmruAOJLs9g7RlK9wkL1Pt9Q/RHxt1?=
 =?us-ascii?Q?Uuok8a2VMYik592nciQTb5BEpi+BZSrOwHmNC/qJLmY/oScL7C9q9/WM0aXT?=
 =?us-ascii?Q?jDf9jfrOdcJwK5DGTWFLezPOnO91r6xN/4JpbaBRicS/zr3P+whhbMpqTFGN?=
 =?us-ascii?Q?8sfPvRxWRsK7DsVK4Itx3TdRJ5l5tFTngzh0C+l6hsy+TbtCCIIKdjz2r5xK?=
 =?us-ascii?Q?gm/H7jS6wepNdJu9YhSBWWeViCvNVi9zzJjMZVZEjnsbw8KWHrlnprz07S6O?=
 =?us-ascii?Q?bXMIQ3Ucts8qt0Nkl0Vc4GywFB7uwcFZeyG8lpzGvv1y3WskyBQl8tc/lGJO?=
 =?us-ascii?Q?y0QKyrwzFE9iXfVjNK2jBdZLLR0VHzez/fOx/2xUVGcggkFVyNBQdVruIyWW?=
 =?us-ascii?Q?iMCafSjUKyCuJhO7Ctkrp9peUUp7MqjdNq1c4plg1IAkfla8e4IYp30KkNsq?=
 =?us-ascii?Q?vbY8zXbPny3qxQlHPXGG3KsD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f034f20c-9d6b-435d-75ef-08d97de5e1fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 16:27:34.0572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +4GdWOqvmE93h9IwKvqvH1kzO9L+QkrHTjjoWVf9OlWbYkIkPW+NFSYEUHgxBlaeXBpOGka4pSyAvQMVX/2/kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5141
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Borislav Petkov
> Sent: Wednesday, September 22, 2021 7:34 AM
> To: Joshi, Mukul <Mukul.Joshi@amd.com>; Alex Deucher
> <alexdeucher@gmail.com>
> Cc: linux-edac@vger.kernel.org; x86@kernel.org; linux-
> kernel@vger.kernel.org; mingo@redhat.com; mchehab@kernel.org;
> Ghannam, Yazen <Yazen.Ghannam@amd.com>; amd-
> gfx@lists.freedesktop.org
> Subject: Re: [PATCHv2 1/2] x86/MCE/AMD: Export smca_get_bank_type
> symbol
>=20
> On Sun, Sep 12, 2021 at 10:13:10PM -0400, Mukul Joshi wrote:
> > Export smca_get_bank_type for use in the AMD GPU driver to determine
> > MCA bank while handling correctable and uncorrectable errors in GPU
> > UMC.
> >
> > v1->v2:
> > - Drop the function is_smca_umc_v2().
> > - Drop the patch to introduce a new MCE priority (MCE_PRIO_ACEL)
> >   for GPU/accelarator cards.
>=20
> Patch changelog information goes...
>=20
> >
> > Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> > ---
>=20
> ... under this line so that it gets automatically removed by git when app=
lying
> the patch.
>=20
> Alex, how do you wanna handle this?
>=20
> Want me to ACK this and you can carry it through your tree along with the
> second patch?

That would be great.  Thanks!

Alex

>=20
> --
> Regards/Gruss,
>     Boris.
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeo
> ple.kernel.org%2Ftglx%2Fnotes-about-
> netiquette&amp;data=3D04%7C01%7Calexander.deucher%40amd.com%7C12b
> cf4eeffad4e2533b508d97dca1cf4%7C3dd8961fe4884e608e11a82d994e183d%
> 7C0%7C0%7C637679129761221057%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C200
> 0&amp;sdata=3DtK9aK%2FHf5RimF%2FenuTGeJSFFmRuk86Q%2BqY9Jt23gKMQ
> %3D&amp;reserved=3D0
