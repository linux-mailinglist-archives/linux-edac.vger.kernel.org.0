Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A33B414E55
	for <lists+linux-edac@lfdr.de>; Wed, 22 Sep 2021 18:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhIVQsk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Sep 2021 12:48:40 -0400
Received: from mail-bn8nam12on2078.outbound.protection.outlook.com ([40.107.237.78]:41729
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229467AbhIVQsj (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 22 Sep 2021 12:48:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msGCDcxCumGwCRCgYbqVp646jkoSbz4YRvjRMMVF3W7gz4iDnFe7rX680U3YuZfxdqklQXNHI24DWQ9RcIRKfpWFH3a6irG7wpieXfZesX8LOuYP2kozYPS6fdQTwQlgBF8tH9p9eDkHo/fi84CoxvV/b/09kIFU3jsgPGulEqYNUCaaU/oKCm5XtM6TtFpKUPzkKS5POyB5rgR7gTynlBWKPUhrqVPyYN4TxrMEib4pJfqGJxxsM114/yMXD+x8AU5vFAh0TG1kjrAY+ulqKQAC6Fq6Sz4mRKqvJhAdIhd+XZnkZu7/XC9zCIHC0/23JJ2QU+UMsV/Z7rzXJo8d4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZiYqdKJPpRubi+MCPG5VotQgd5eNWtEO8uV+Ojz5XLs=;
 b=YmXiKtbiVyMzitPrRnaFOFRFv8EgYxtS0L5u8e0OFIkJMji8WSzNakZpo43iXVlexCUWF6zRcB5JsQ6Djpf4uFpIGWO7qBZlJZwENBWV5CNhuiGGcOGZOzKbvHP11ylT35bMDIl5vzj+6yHIJQ74Y7A4twxmHMdJi2rt9viZF8Pgrh08eCWqTiqQPW7IoHdXp19tP+IVrM73vO629rC7pPu0jt0qtb+WaQGgX8VtPOAJ5BQFcQlJPhVswu7YwYaZ5yDSPh7H9nWRmHQXJZyD7NF+Km8R0S3C9QsDwjQKZl07B2/g6QofQdUvuV3FhrnP5C8lnSUDPi/MaXGnpP9gEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiYqdKJPpRubi+MCPG5VotQgd5eNWtEO8uV+Ojz5XLs=;
 b=zeR4Tw3h93KhIC9gulDx48qeKunA1SDNM7CIMtpFSNZjt5Uo5mISW0eg+LAdD1gm86sgY/Qjbuv99IDjGhmQW2c+XV3yMxMSpEmt7ArxHv7iws6GEQY5kefhwfJkd6b20m6GRQWpUvN/WaHVzSLWP5u/MyR8qRTMcBCOI8EP6Uw=
Received: from DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23)
 by DM4PR12MB5264.namprd12.prod.outlook.com (2603:10b6:5:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 16:47:07 +0000
Received: from DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::90b2:e7f6:c5e5:c80f]) by DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::90b2:e7f6:c5e5:c80f%7]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 16:47:07 +0000
From:   "Joshi, Mukul" <Mukul.Joshi@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC:     Alex Deucher <alexdeucher@gmail.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCHv2 1/2] x86/MCE/AMD: Export smca_get_bank_type symbol
Thread-Topic: [PATCHv2 1/2] x86/MCE/AMD: Export smca_get_bank_type symbol
Thread-Index: AQHXqEUMwS5RMPas+kCH50BDwt3Mjquv+uwAgABSCACAAASOAIAAAIuQ
Date:   Wed, 22 Sep 2021 16:47:07 +0000
Message-ID: <DM4PR12MB5263759B8D7924DCA067B551EEA29@DM4PR12MB5263.namprd12.prod.outlook.com>
References: <20210511152538.148084-2-nchatrad@amd.com>
 <20210913021311.12896-1-mukul.joshi@amd.com> <YUsUpkvP8zpz8yRz@zn.tnic>
 <BL1PR12MB51444DA94F2DE3D12BBF31D1F7A29@BL1PR12MB5144.namprd12.prod.outlook.com>
 <YUtdSO8QZWiPeYwr@zn.tnic>
In-Reply-To: <YUtdSO8QZWiPeYwr@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-22T16:47:06Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=bb045230-9753-4053-b11d-bab475987b31;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b02096d2-92fe-4c20-6360-08d97de89d80
x-ms-traffictypediagnostic: DM4PR12MB5264:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB52648CD992948A98AB79E930EEA29@DM4PR12MB5264.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 79layc7l39KtUSfld9CHVrXb2kJ21IBjrELypzO8x4pwuYIVVv8OYAiC5+lQNUrsZO9r5ZpTUrwzIYR/C5Y156GRJt39W6WCoRg0xs0c5yqyEizb4oZyx0g/sH9rsfC98keJs2ngw+4c5nmHnGjR3czV2Hvcs5T640a0quzi+Z+YmmjcuMKy4TVFA/RcoJz8EwuyZ+xvBe/0gpv3tgiORPnS6EMX7sPX2EnDe9CXwTibyo/kybxJJbtyk4Nyf7KujW9XOr0/OcJdfyivIpBFQd0BWycOwMq4xPNxI121kVC3XsbUzKCqO2wBui9QKrunGlsR9/8QK5YcirDluRFwtAlqP9BLrjZBtBWSsN5dnpHK6c9bFiNBhMpe8Bf/bhYP0/1Zyg+mv/VSzn2iiUjkhpq/qkoyGAzGtc4tEXkRX999/Kke6K3wcORljp1VXP+UD53djykZcSBGLd+EVtLqUfqSPLqaGfgKQPjF7R1mNdinR/v8KvPZm5vHVA7k9Yurdw4b90/uZb+ubWEXk/1ksZ+57npSu7FRdXE1fr7txjOTRlbKIqicjNnISTZNPvY6piTbvKNQzdCHn48mkSZXcjfTVmHcRHzt2XnOeHkSIaBqMW7BEKeRj0MXa6szE1lYXX6ykkfMIDD1xcUPBhO2rbkze4YVg+t0KTBViY0rOWv/u6JJMtQmkBjUdG1ZE02MWtGqv+ykGaokH4Gs/MxtlD/nkj7aaG2XEdQDC+gIC+vjJVVgldDNFS0lMxeL81XCUZeZd65JpY6PK5SLEtHBN7LNW29Q/8MORChFhxmznYY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5263.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(508600001)(6636002)(122000001)(83380400001)(26005)(54906003)(4326008)(966005)(33656002)(8936002)(38070700005)(45080400002)(186003)(66556008)(316002)(5660300002)(110136005)(8676002)(6506007)(71200400001)(66476007)(76116006)(55016002)(64756008)(38100700002)(86362001)(66446008)(9686003)(7696005)(2906002)(52536014)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XD53wpzqcgrMdLvnj149aVFrCOEoOPBhGrUdE9wQHVdRzzvoUnA9A9pAz93a?=
 =?us-ascii?Q?HeQnzUVkFIbfAlVrfOQuzC0Jxi1wDFs9WWzF1Qfpmef2RJhiqM3s7Ze+YmEP?=
 =?us-ascii?Q?qF0bZcnyj2d3Y8pApQevVBbukgDf3cr3BSBfJp+fJ24TVNwRYB8+sj/wwAH3?=
 =?us-ascii?Q?Y3MQFRjCMeYCMl4snwqwJQBe0wJxgbgpBKgLlJkhw7osnkYa/JopDpspGe+I?=
 =?us-ascii?Q?VR0Pau0+Z/V64yQbEXSrDJFQDVepq9pwgom8c0naQxDrNPI4xckCvaCAhH+b?=
 =?us-ascii?Q?iuD//k+dO+AsGwwH77Nw/T2+pQXhuWKdvdJBtZRTI9qmgy9pAwWDLxoEZX2m?=
 =?us-ascii?Q?wTAJVsgx641fDOVnBQnB5DWJh2KIYmo3tCn4j08Ek9JwZn2bSZIKJgfHJXzK?=
 =?us-ascii?Q?3FbsYc53Pe1ErU2b66uXucGeHFgopLet7Pq+MoVT4uS0PbbbZfLcA0WbdFPQ?=
 =?us-ascii?Q?Z75eYvwL89XPJdHL5UZnXqy+bVUaCdwJx3fS03R8wnyJ+DnhVvVZOuiq9pSk?=
 =?us-ascii?Q?0fngzYq+bOs4SPpQsTK/n/Te5JKOcxiTmFqElZ0yhZmENGtkJs91DHXOtbcb?=
 =?us-ascii?Q?aGw8L5gy8M9atCh2vrQg2y4gmcmoMWHmABQiBvugu7nqNJnzQ9mURnHgudC3?=
 =?us-ascii?Q?zElDHeo1f85sKjrsxKzmn8MG+Bb9kygfPQxnZZs2pO3Z9HPlavm2bJW8hRNI?=
 =?us-ascii?Q?a19yN/BfhvC6S0KAgdd3jE1qMIa+K5gAGPjtts//7KHljdSoxdQJrIKJnGUm?=
 =?us-ascii?Q?smPOfTIepY5ytYMowmCUn0Nfd13yKCtrgIdIH2OjmliEGG9nuPHddz/XmISP?=
 =?us-ascii?Q?KvQB7+lpCg+YmK805urXsOdOD94Wcbz6nCS3fL735EBgmXC9IQGyRJk5OdM+?=
 =?us-ascii?Q?jX5tS0aXOtvbMgy6duRMzaDkw87Y//z5ij0Ga4deujDO1APJfStuSJ+ax1Rm?=
 =?us-ascii?Q?QIYMaqGqGsvnDq3rdOaSsaxloPzhADxTJe21bc9ZTRwRiOego+MIQjghXfT9?=
 =?us-ascii?Q?R/pKyC/yapMHUdIXqwB1dPdKOqN/xmr+lDam2fxripEPTAv3+3+9Jb31K+UB?=
 =?us-ascii?Q?2z9iXCYBDr2pjWD/y9jf7s+Hhx3lAnX4NUyUA8EixZSXlxmiMX/jCpvHsAmh?=
 =?us-ascii?Q?NnyF+YNY6xa3GuYi06iuFJDx20e4N3mVNQr6sJ91Y8oTi4e9P0L1KsfZJuIB?=
 =?us-ascii?Q?UUV80FKpL2JslQaRZ6TD6bkOgOwXlbgM0gOxkV8wKG7vDFMTDQiJ2RIHq32P?=
 =?us-ascii?Q?daPcXaPpm4K9/fcj14DeHB8FCOBa8b5918ObhnPwsllDbqdYlclYLntEmDZ+?=
 =?us-ascii?Q?x4VAJlNmZkIyC9GDA0d1g3vc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02096d2-92fe-4c20-6360-08d97de89d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 16:47:07.6235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ITROo9RXKxUavYVn62FtunaiJjSVOUEoq4TWHI5R2uknCQNI7YvYA0BW4PFmgqwqF8F/mOWzjh30EQ2Li7lIuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

[AMD Official Use Only]



> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Wednesday, September 22, 2021 12:44 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Joshi, Mukul <Mukul.Joshi@amd.com>; Alex Deucher
> <alexdeucher@gmail.com>; linux-edac@vger.kernel.org; x86@kernel.org; linu=
x-
> kernel@vger.kernel.org; mingo@redhat.com; mchehab@kernel.org; Ghannam,
> Yazen <Yazen.Ghannam@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCHv2 1/2] x86/MCE/AMD: Export smca_get_bank_type symbol
>=20
> [CAUTION: External Email]
>=20
> On Wed, Sep 22, 2021 at 04:27:34PM +0000, Deucher, Alexander wrote:
> > > On Sun, Sep 12, 2021 at 10:13:10PM -0400, Mukul Joshi wrote:
> > > > Export smca_get_bank_type for use in the AMD GPU driver to
> > > > determine MCA bank while handling correctable and uncorrectable
> > > > errors in GPU UMC.
> > > >
> > > > v1->v2:
> > > > - Drop the function is_smca_umc_v2().
> > > > - Drop the patch to introduce a new MCE priority (MCE_PRIO_ACEL)
> > > >   for GPU/accelarator cards.
> > >
> > > Patch changelog information goes...
> > >
> > > >
> > > > Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> > > > ---
> > >
> > > ... under this line so that it gets automatically removed by git
> > > when applying the patch.
> > >
> > > Alex, how do you wanna handle this?
> > >
> > > Want me to ACK this and you can carry it through your tree along
> > > with the second patch?
> >
> > That would be great.  Thanks!
>=20
> Ok, with the above changelog removed:
>=20
> Acked-by: Borislav Petkov <bp@suse.de>
>=20
> Thx.
>=20
Thank you so much!=20
I will make sure to remove the changelog.
And I will send the updated version for the second patch soon.

Regards,
Mukul

> --
> Regards/Gruss,
>     Boris.
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeopl=
e.
> kernel.org%2Ftglx%2Fnotes-about-
> netiquette&amp;data=3D04%7C01%7CMukul.Joshi%40amd.com%7C3dc61ec5018f
> 487ec06e08d97de83039%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
> %7C637679258473597532%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata
> =3D4JqFDJpxM%2Bzl4%2BZoaC3tTwScEhRy2Aa7xJaNJn3rxbE%3D&amp;reserved=3D
> 0
