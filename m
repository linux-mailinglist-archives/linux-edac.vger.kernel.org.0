Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE1E37B3A2
	for <lists+linux-edac@lfdr.de>; Wed, 12 May 2021 03:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhELBmE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 May 2021 21:42:04 -0400
Received: from mail-mw2nam10on2083.outbound.protection.outlook.com ([40.107.94.83]:47680
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229736AbhELBmD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 11 May 2021 21:42:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfDACqyF2YlQatpV+y82GbZPOklctKhK7vAZs6tIz0QSpup4HaJw/NIuuqsl3hialfaDyy/lgiiqtdLUPyqfb0uVpRf5cwaHfHvFhYjIeaRQPuE6+z4Yuvj/p2DR2a5n/R3g/J7DU8zHIkjbbhuDnN99zBFB8xbeF0YAtS/j2KMvI4+zmMLiWCeEK0CorE7fA+XKA2DFzpPkSgYGAe7WoMqXDGSRVkVe+R6O9cmYzyMvkkOXwQE9C1KVRfpNze3pRMHvxrzSJUxplG7a7xZppqKrafcyYUBXXsXB7WfCuJtFaUh1/ntKQTkVEGyfKrlZTy4JZlAUAc/ONE2diVx5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWHmSc1f4L1NmgbeLB8O79qiTsaocu3R9VwZAHmd4/Y=;
 b=awhHZzFHNMbdH0z9SkgN+7MxDt6J6h8UXGXDMCB/UEgy1Za+V58AbriqSira+zT9BluIzIbRQixkds3XQyTULnvxtbvACFTZsTHeyJ8vdJC4VvS4cprcF3vpEii4EQFGaps/dnbg4g1Uc/tQZ46p/EOFXAMm0pikZar1WusLfGlrLrqxEQ8ev2agTMust10QEnq8g/fOmrPAiILv4oaTjBnUnmThTgrHwAqmpjeyO3YojZlrOxWAnA6ZwZvJTCenfzV4o5/LdCXsbiTnwFxAulJ73g02fvtBd2RhuGbRDgkUpn/xCNVw4nbQdx9MVetH1YPEcpNFD4k0u7yyCW9CFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWHmSc1f4L1NmgbeLB8O79qiTsaocu3R9VwZAHmd4/Y=;
 b=fCV0BnP19rBeDNyQIIE+SqPr0dMJoPQLr2avqIAlRfokYCPdJiqX7x/nEiMMhOOWG3eD32vB1bAHsjNfx6ONFvQ71ZuRREC0MXqjoClsgCitrxCSr5I7wbVGmy3iuTu+qJ0UFn4BaOk7jTfsankGDymkW6oQWhowryIq4yWkOe0=
Received: from DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23)
 by DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 01:40:55 +0000
Received: from DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::8ce9:f643:9ce6:af9c]) by DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::8ce9:f643:9ce6:af9c%6]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 01:40:55 +0000
From:   "Joshi, Mukul" <Mukul.Joshi@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Chatradhi, Naveen Krishna" <NaveenKrishna.Chatradhi@amd.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>
Subject: RE: [PATCH 2/3] x86/MCE/AMD: Helper function to check UMC v2
Thread-Topic: [PATCH 2/3] x86/MCE/AMD: Helper function to check UMC v2
Thread-Index: AQHXRnn94nTuKt9pvEm1PzSoQXvDPqreiu6AgACGczA=
Date:   Wed, 12 May 2021 01:40:54 +0000
Message-ID: <DM4PR12MB5263B138C38827A692411634EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
References: <20210511152538.148084-1-nchatrad@amd.com>
 <20210511152538.148084-2-nchatrad@amd.com> <YJrAOXEcyUvs/WvY@zn.tnic>
In-Reply-To: <YJrAOXEcyUvs/WvY@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-12T01:40:13Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=037f73f2-6ca1-4d20-b2cd-3e490a768705;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: The changes in the email are publicly available anyways.
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7812a8a6-57a6-427c-9f57-08d914e6fbdd
x-ms-traffictypediagnostic: DM6PR12MB5520:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB5520AC29CF644B5BC668E45CEE529@DM6PR12MB5520.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SDREfF9RFACsSeC1wbkyxY8k2pP5Qf+XKIPs6fCiuwy41S0IupCZeqy7cm3GlBYOmFljy8cELbqPoDbwo+92mlQqeHPHsLQLrEqgvwn8UD1fb4MQ5sS+fCYRYzemBey9N4KNEYzeuX3NJye5BGXFY8TNFxOlYFkLl0pbuGaTPq3jWCO/HSRjhwtNIjQChKb1MMw04AAhL/5pLG3tYN7zdaNttgfmZT9UFI0i/f1EXe4efbABgfCcM+7c2Pxck1m6XZh2ZDNurmAfwUT1uc9igt1SG4oNXZIkhwS5sU4fhGta/vDda85ngxJVCy0h2tYPZ2PRrYaR6+HW8hjYkaTf9R+XhQ2+v4yzipSihQ2VadGYcy/NEltspJfoKHI8MCdbPZ5AzPLA6ueTTOWfgoapkTi4S+yv5+er0TfX9+JVQNaFlxmHQiYjaGmcT6CxgEjzTvHUF9VCGdIWxabop6uTYTyyDjN3J/LDcsR9vTdS9tCPLq67Ve2GoS2CyMRYvnvJfHvCGE7x0msve1BCMq2tjJlhTD72TwloMRjyfbbqXa3U3GbGTgtH4p3eSVTEtkhHGFeX6t19OfInJmUKmc45miP9jM3yM42uDHcjyJ7H9RuwThCrCi74h1Ln34mNZR/5e0J1TMWZUs+49+qwbjzKq1fKT4HvWNQ3P746z9K9LLkjsOucvz9v/5ERkGiACE09
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5263.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(2906002)(316002)(122000001)(54906003)(52536014)(5660300002)(110136005)(55016002)(9686003)(38100700002)(86362001)(4326008)(186003)(71200400001)(8936002)(6636002)(76116006)(478600001)(64756008)(66476007)(66946007)(66446008)(7696005)(66556008)(45080400002)(83380400001)(53546011)(6506007)(966005)(26005)(8676002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yqZovRs0kfqOWoqfmtIkQ7SE+hdkh21kBBKV4DfYmUmN3bHFEDvQDRcuPv++?=
 =?us-ascii?Q?jcT9uUquYawLRKVf7ixzH66F9TkH3JLG7YEZeICQoE36MxPPhk89w2rwzQ2N?=
 =?us-ascii?Q?oyc/geJhGdLg79zvXCbfEX4pm57OkSxF4CPnU31TiVssK2Dseyu1410WoIza?=
 =?us-ascii?Q?2Tu7qHVqyxikuGCTf0CZJWwRNW264/ixwi5cA4PZrzcOu194W+Hmv/cUEL0J?=
 =?us-ascii?Q?2ay3v9PINblX6ARk8MtVJAPv1nEg22hFyi3ecXrm9QasM8etD5Rrvi87Mqhh?=
 =?us-ascii?Q?J8jn9fZjYxwnbPgjPxyOnll0X8eRXuX4KRS/N97kIQBPlganse/NhIgi5nkU?=
 =?us-ascii?Q?I8Kn+lpotWZDpJ40eAVgHJ2l2kz7Of8tUeDA5h0uxnrWfbXzDZ9tRa1xe414?=
 =?us-ascii?Q?n5+C0sJaD41VOmV+oz6ikSZZ4XLhgkaSg8c5RL5PaiyR5No6uMRbOZJf72+N?=
 =?us-ascii?Q?MSt93vlkHzWMEzQvmYv+a5VQzxA8/li1IrrQtJ1D1PlRRpATAShUDdynaVvr?=
 =?us-ascii?Q?miI2cps4CBrbtPYOb/Fgnz9usQ/MsJVg1MnDiuRvRzdL8MlvS+Fh0Vo0jg8f?=
 =?us-ascii?Q?KWnLqZV/OR+0EGi8zsZ87pwGvc07c0ZHkMseqXxVbPy/LSbumTuRHxc0p8Vi?=
 =?us-ascii?Q?oF2UkTaFeFJcL/sEBRdezjEfCmEuyfNI2/KvdQVNPBdsnvKM8iyVFi2vWXrR?=
 =?us-ascii?Q?p1bQmpJhclfvkcUjRUguaYENkGdjWhbn5KiQmUn7Nv9E5rohTo+dCG7oSJL0?=
 =?us-ascii?Q?FGlamMCaXy/YoH9Jus+A2HrHBAK9BAdShlYoOs99RJV+468jlYPjpBg6CZtC?=
 =?us-ascii?Q?mrkaAsVrxavj2Td6wq9T22bBxZex4alK4IraeTTjcvcSdZE82ddd/Yr/sSYV?=
 =?us-ascii?Q?XVtDkVEnZl8+PK6dUOO/nIXvIm09NGGJWDpiYV3F5rqNCBgLdBa6xMHoYb9t?=
 =?us-ascii?Q?wW7GfNcU7LK77vDHT/yVRdCecTmqgtpiAfWeQUVl7dqp+mMZZcOz5Klsx4mT?=
 =?us-ascii?Q?AqEyjKvx0H2ccE7vP6Xd9NBw3Z1KY+eQU3u36nRMCb4ZvnDzVpmgWeZ1wkj6?=
 =?us-ascii?Q?rM8vtxeA4RxlbOwZE+2cvQRxh9kmEZ7KFThSIthHORCU4Fu/d7HcB0Sia1g0?=
 =?us-ascii?Q?Ssx92lHSxN5IoKEJP/U3ntst9pzf7B+AHA38qyCZBhlYXrlBr1XldBPAVaIn?=
 =?us-ascii?Q?N9KaYXmnxww/2cODVglphW9RObO7RblP2EQGAK3wxAaZ8pfvOUCWUY/MZ0+U?=
 =?us-ascii?Q?pWH2JymO6tlWu7jGu1kFSq5j3elsFPlQo3o/BiUFmcagfot4KRDeT+Dq9lts?=
 =?us-ascii?Q?btGeQjO6QNWFqBWwSJdE3dTb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7812a8a6-57a6-427c-9f57-08d914e6fbdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 01:40:54.8940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3wWFdsKlL7JIU7fnPlopx4GFqqSVufgk1SCs4nldWbTwVZMMYD4XBgIixto3ElLDgV0Xy2r4C0atJRmQ398DuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5520
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

[AMD Official Use Only - Internal Distribution Only]

Hi Boris,

Thanks for the review comments.
I will update the Subject line and send out an updated patch.

In the meantime, here is the link to where the changes in Patch 2 and 3 are=
 being used:
https://lists.freedesktop.org/archives/amd-gfx/2021-May/063423.html

Thanks.

Regards,
Mukul

-----Original Message-----
From: Borislav Petkov <bp@alien8.de>=20
Sent: Tuesday, May 11, 2021 1:35 PM
To: Chatradhi, Naveen Krishna <NaveenKrishna.Chatradhi@amd.com>
Cc: linux-edac@vger.kernel.org; x86@kernel.org; linux-kernel@vger.kernel.or=
g; mingo@redhat.com; mchehab@kernel.org; Joshi, Mukul <Mukul.Joshi@amd.com>
Subject: Re: [PATCH 2/3] x86/MCE/AMD: Helper function to check UMC v2

[CAUTION: External Email]

On Tue, May 11, 2021 at 08:55:37PM +0530, Naveen Krishna Chatradhi wrote:

> Subject: Re: [PATCH 2/3] x86/MCE/AMD: Helper function to check UMC v2

The condensed patch description in the subject line should start with a upp=
ercase letter and should be written in imperative tone:

"x86/MCE/AMD: Add a helper function... "

> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> Reviewed-by: John Clements <John.Clements@amd.com>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

This is all fine and dandy but it needs your SOB too when you send the patc=
h.

Please read Documentation/process/submitting-patches.rst

sections

Sign your work - the Developer's Certificate of Origin When to use Acked-by=
:, Cc:, and Co-developed-by:

> +bool is_smca_umc_v2(int bank)
> +{
> +     return (smca_get_bank_type(bank) =3D=3D SMCA_UMC_V2); }=20
> +EXPORT_SYMBOL_GPL(is_smca_umc_v2);

This addition looks useless when it doesn't have any users.

Also, I'm pretty sceptical this even makes sense to have it exported - I'm =
guessing this is for mce_amd.c but I can't say without seeing it in use.

The same remarks hold true for your patch 3.

Thx.

--
Regards/Gruss,
    Boris.

https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeople.=
kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=3D04%7C01%7Cmukul.joshi=
%40amd.com%7C0a7f1e0a3bf04c9ed89408d914a3141c%7C3dd8961fe4884e608e11a82d994=
e183d%7C0%7C0%7C637563512928580623%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw=
MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dz3xbu=
S8yX4Ea1kG9tWv0tGNQRPZP9N6QcBI2VNjn6W0%3D&amp;reserved=3D0
