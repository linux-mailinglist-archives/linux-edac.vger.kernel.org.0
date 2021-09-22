Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284BD41509D
	for <lists+linux-edac@lfdr.de>; Wed, 22 Sep 2021 21:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbhIVTpb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Sep 2021 15:45:31 -0400
Received: from mail-sn1anam02on2087.outbound.protection.outlook.com ([40.107.96.87]:40198
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230456AbhIVTpa (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 22 Sep 2021 15:45:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7UFTgHelAZGl5mCxtq3YIQowboxRDuOGdz7/3DabQl1vEBjFXZIjMCAuF5pWkAhXWJHAWeBMDyBjPfY+OTcvVCPH6lzS9JK1iizDsX+NVxspCEDYI/VHPnZzjV6F6ELX1f/bi8n2QccaoaTHa4BGU1/GPsBDAL8OOYe2OlVL/tioeV36A2yAVSq/wHnaPUqRe2wqYjVPSv/f3KnMkYRAQPkhk4KPheDn1gxcCflBO1aNpQdrS4gjc9AuToCeYUb/6JBbw5QIooaaKvCJNtxMNdGl3wSEQy56jEB8Z0cPB6M0SfxbpOPYoudsnT1AjC+ryIvX1Z14W5M11T9wG/1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=cb6HgKy67JO6uV3K/MakqjS8WBaA2Gfwni6PSbsL9mI=;
 b=fjKsUr8KhwFbLFv7Jg2JRNGeLcgQqbI8vi9Trmx3LnWersCS59gzIWY47FIickwEgu1/EZtybPousrY5ppBGShdrWRH0bwKi/XtyzQw+LRNe/cVHgtTve+eHEvhbgN29I1JWtv505jzFLHPRxc4WvvlEFBtrMeQEFZ4k2NLPqe8T7kSrCK/k/T58vIfNDDmzSsYc/TDU4kxOaLleHjoLb6nAVVUxi5OxLm8FhzC9XRhX/qyRpWfcCuzmxoDO+y+J37NOIJqo2xcn0BRpftU0/ptP+tAL71DW2sWfOyBNsZCjnzbkCNIKlyNJpla10wWKIs6oeOzIET0YibvmJ8X8CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cb6HgKy67JO6uV3K/MakqjS8WBaA2Gfwni6PSbsL9mI=;
 b=gH5WIw40ncM0QpQDYHb3TkzkLaAjd4wqCxns8Sxj2eUnwx8saU90hTmDiOIcEpjF7xMW0pj2Hsz6Ubl5cb9DZJc5ttsaWXZ/DZSVPeiTc9JqNhzbRLZNWYfwVER3H/qaxN9YfQehpNcGMQnwA/MAk9cI7qxtyw3m8P7C7B2R+2s=
Received: from DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23)
 by DM4PR12MB5053.namprd12.prod.outlook.com (2603:10b6:5:388::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 19:43:58 +0000
Received: from DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::90b2:e7f6:c5e5:c80f]) by DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::90b2:e7f6:c5e5:c80f%7]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 19:43:58 +0000
From:   "Joshi, Mukul" <Mukul.Joshi@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCHv2 2/2] drm/amdgpu: Register MCE notifier for Aldebaran RAS
Thread-Topic: [PATCHv2 2/2] drm/amdgpu: Register MCE notifier for Aldebaran
 RAS
Thread-Index: AQHXqEUZHAZFKTr3oEOca2084pGuxauv/MGAgACGkZA=
Date:   Wed, 22 Sep 2021 19:43:58 +0000
Message-ID: <DM4PR12MB5263059B0C67BCA373AB3AEDEEA29@DM4PR12MB5263.namprd12.prod.outlook.com>
References: <20210511152538.148084-2-nchatrad@amd.com>
 <20210913021311.12896-1-mukul.joshi@amd.com>
 <20210913021311.12896-2-mukul.joshi@amd.com> <YUsWLw1gSD/AQbcH@zn.tnic>
In-Reply-To: <YUsWLw1gSD/AQbcH@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-22T19:43:56Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=5af441ba-e1a4-4781-82cf-7607ce4dda35;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 981b13dc-c2c4-4f24-a992-08d97e0151e9
x-ms-traffictypediagnostic: DM4PR12MB5053:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB50534D2B7E6328BDE8A043BAEEA29@DM4PR12MB5053.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kEWeS5IPNaOGgbrtksrf09AJFsG2oIiwrWqQY91V0y3i67bORAL3ciB9EOsGxPnls1v3e9ROZJCBGOJ5AzzAIG8BFElPtTdsk/ocjP9RxIU0nIMiTLmGY38XOZV3BrjelXcR7BPNMHpS1oygJJAQH7GYFm0vgWRGOJN3VnPsWIEe0abqXDMzJVAqvPwmEU30iFPM1WOERH/TfXlLiZkGWrJW3vbXoY+/CMNQMnYkM3BJ6QWeSJf0/2ZCwacgzwfsNVTbTaUaaCx1uvxFFyR1zbIepnmeHfAFzLpz0JAWDmdWVvDcyLMErxHPfLGILcPB01vy8aSgQoz8PRwBBdOoHBeOLyHQ1afl+hcdoJ1uw95WTXXwtfmxkuPjyiS5hPl4Wm2XTTQs2aFQuY+fyO/AmMlwUXz3wHr5e6o4iShGkV6xfC9krUtzc041oCBVgypG9IeRojd1ebMUDTIgFFelMv25w3BLnZIRkPP/Zm09Bc39bR0rOwLCLIlvJD8x7GDV2PZf7FSipVis2anAmloRr85H/gyc43JkOqJauUaqsuMV75KTFXFNaV9CNuURO0yQF1EoteXhMrx1gpERZsDrQDiiEmnYxqbpXClfUHKW9djwULK4tR1m6tPKo0ExO+KZGmktGU0KskrIhxY1aNlSclRdnG1kC3f6nJB9S+rcYuJ3V3Jba9lqUPJFNRtJYMOXtiADa/f23lLGSV0XCxJUozkftXjhpI65LoUMDy09tCeQCr/MmiO9xUKMa1O98UICFyERQhwZhzrYHeNRb1W2fhaATlLX/jRqk1y8gI38wZI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5263.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(966005)(122000001)(5660300002)(54906003)(316002)(6916009)(33656002)(2906002)(38070700005)(4326008)(38100700002)(6506007)(66556008)(186003)(8936002)(66446008)(83380400001)(66476007)(7696005)(508600001)(53546011)(64756008)(26005)(86362001)(52536014)(45080400002)(66946007)(76116006)(8676002)(9686003)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J3pLTjmCNETTCofUQxzBk/VOJKty4qDvcVN6DNiWK9d57G1MyyB459RoGv+y?=
 =?us-ascii?Q?7Q5hAQ01QCYNrXdKRkWJbrtAcOSn8moOJdDLAol4PLdEDHP5HvpyJaRNYww2?=
 =?us-ascii?Q?QCd+WvvvNb8G+zWyUYogKUy82lT70+RjCTE2M34nteSDmv1Vx2Bk9sBjEX84?=
 =?us-ascii?Q?irDqAu1TOc7vtYMrz7G4EGcN8qv+KLU2bzm/A6EJ635BidojzBXc9XSlV8l/?=
 =?us-ascii?Q?YXm60lhWf3FuvLMNvG6Doq4Qy/rd/z41txFKlrNaSviTFnLtty/g+3fe9zqA?=
 =?us-ascii?Q?ZsTUSoQ5y2+w5ig4xVxDyVaDrRdcINbsmfdcrz5FP9gBECxm3hWHxrsmh3uY?=
 =?us-ascii?Q?qOnDRj3t+Eb0TdnFhzrTuAH/xsApHwbWZz67xCpa70YwtNoM0G2y3cUl2toH?=
 =?us-ascii?Q?C0dWupbbBRZAGqlaVVbVLglv2YVqBQmL0U0zsXUIkc9w3NIaLVUNh4pbCNi+?=
 =?us-ascii?Q?Lr75gAucCP++kLNCJxqrRESj1hH7a7zysTrKB0j+y3ZstIOE5O0ftihY1BgO?=
 =?us-ascii?Q?TuiSSkAbCtBPMLMqcjPM2PsGfAiprkShTlE9zEK28Eazv6c2h8JXwki4Yw4A?=
 =?us-ascii?Q?cMcsQ6g0YHvzY8TOjTi0YSZ77MsIPGb9y3EuXYNGhxA+2aeyNCfHLxzRu+Ao?=
 =?us-ascii?Q?L58ermHN6aSg9DSk7vjrjQWVnAUxql5f2kYoRLo0EtjIr1zXTvSXqWmTyFyQ?=
 =?us-ascii?Q?C8M70/mkdJVsFlPNAqZ1C3YmFAI32alFZ9VdaZMYNKib+aQm+0HAYr4Vd+wb?=
 =?us-ascii?Q?93KM06wK+QQOxLx6p8hoNjlwhwJs5a2zzGg6TqW2g/38N5FwnFcKxOEUm3so?=
 =?us-ascii?Q?riGmtzx7prh+5rYqrMzBdGSXvGnneDxdxGSvZDwTjWaa1lEEMzDGjgA/pXAB?=
 =?us-ascii?Q?jSQZ151+3A1FueE499/3KIYaXR6dM/ciqxDjsCn9M4Qn5i4W3U3Jz31dQ+UI?=
 =?us-ascii?Q?GZ8CL3sj8WzBjy5e1BIoQKa96nhRKDNuCDoMlIRpI7CikDT306q5AWeJWCBP?=
 =?us-ascii?Q?uRGjieI03EW/QocxywETIS30YupzU5u00+ekEsPLK0aMgoYQBfyub+24c6Mi?=
 =?us-ascii?Q?W1Wt86sa5U9T5CPJBDYUNJIsIf3YrF5W2ZlyXM0/xzPzvs3mJ1W4uOHCoWKR?=
 =?us-ascii?Q?a2cj7pIOSTP3SCCxFqkr49HUjdIB5KDWHe9GYd9T4LPxMFRNu985/kRpAYGF?=
 =?us-ascii?Q?diHXcH+AQviRmHaz4F7kg23l+Guov11ee9cl9q/GRoyzLIhRt0ANLq89VgAI?=
 =?us-ascii?Q?t6Z8da+nw+B8oi95d4eKpLM3uwdL83LPwvgCz0GsF5EKKPj2xKWZ6IGbXk7D?=
 =?us-ascii?Q?8I7CoiO90emrL0jRgFrfQFzI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981b13dc-c2c4-4f24-a992-08d97e0151e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 19:43:58.1979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6NfKZ3OjlBPsz+0b6eNAX0949XnDW2yraAfvjul+7f+BVgESYP4Bm6xFs7jmKH8geMTLMIOqa0+pH3ncc4rJdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5053
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

[AMD Official Use Only]



> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Wednesday, September 22, 2021 7:41 AM
> To: Joshi, Mukul <Mukul.Joshi@amd.com>
> Cc: linux-edac@vger.kernel.org; x86@kernel.org; linux-kernel@vger.kernel.=
org;
> mingo@redhat.com; mchehab@kernel.org; Ghannam, Yazen
> <Yazen.Ghannam@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCHv2 2/2] drm/amdgpu: Register MCE notifier for Aldebara=
n
> RAS
>=20
> [CAUTION: External Email]
>=20
> On Sun, Sep 12, 2021 at 10:13:11PM -0400, Mukul Joshi wrote:
> > On Aldebaran, GPU driver will handle bad page retirement even though
> > UMC is host managed. As a result, register a bad page retirement
> > handler on the mce notifier chain to retire bad pages on Aldebaran.
> >
> > v1->v2:
> > - Use smca_get_bank_type() to determine MCA bank.
> > - Envelope the changes under #ifdef CONFIG_X86_MCE_AMD.
> > - Use MCE_PRIORITY_UC instead of MCE_PRIO_ACCEL as we are
> >   only handling uncorrectable errors.
> > - Use macros to determine UMC instance and channel instance
> >   where the uncorrectable error occured.
> > - Update the headline.
>=20
> Same note as for the previous patch.
>=20
Acked.

> > +static int amdgpu_bad_page_notifier(struct notifier_block *nb,
> > +                                 unsigned long val, void *data) {
> > +     struct mce *m =3D (struct mce *)data;
> > +     struct amdgpu_device *adev =3D NULL;
> > +     uint32_t gpu_id =3D 0;
> > +     uint32_t umc_inst =3D 0;
> > +     uint32_t ch_inst, channel_index =3D 0;
> > +     struct ras_err_data err_data =3D {0, 0, 0, NULL};
> > +     struct eeprom_table_record err_rec;
> > +     uint64_t retired_page;
> > +
> > +     /*
> > +      * If the error was generated in UMC_V2, which belongs to GPU UMC=
s,
> > +      * and error occurred in DramECC (Extended error code =3D 0) then=
 only
> > +      * process the error, else bail out.
> > +      */
> > +     if (!m || !((smca_get_bank_type(m->bank) =3D=3D SMCA_UMC_V2) &&
> > +                 (XEC(m->status, 0x1f) =3D=3D 0x0)))
> > +             return NOTIFY_DONE;
> > +
> > +     /*
> > +      * GPU Id is offset by GPU_ID_OFFSET in MCA_IPID_UMC register.
> > +      */
> > +     gpu_id =3D GET_MCA_IPID_GPUID(m->ipid) - GPU_ID_OFFSET;
> > +
> > +     adev =3D find_adev(gpu_id);
> > +     if (!adev) {
> > +             dev_warn(adev->dev, "%s: Unable to find adev for gpu_id: =
%d\n",
> > +                                  __func__, gpu_id);
> > +             return NOTIFY_DONE;
> > +     }
> > +
> > +     /*
> > +      * If it is correctable error, return.
> > +      */
> > +     if (mce_is_correctable(m)) {
> > +             return NOTIFY_OK;
> > +     }
>=20
> This can run before you find_adev().
>=20
Acked.

> > +static void amdgpu_register_bad_pages_mca_notifier(void)
> > +{
> > +     /*
> > +      * Register the x86 notifier only once
> > +      * with MCE subsystem.
> > +      */
> > +     if (notifier_registered =3D=3D false) {
> > +             mce_register_decode_chain(&amdgpu_bad_page_nb);
> > +             notifier_registered =3D true;
> > +     }
>=20
> I have a patchset which will get rid of the need to do this silliness - o=
nly if I had
> some time to actually prepare it for submission... :-\
>=20
:-\

Thank you.

Regards,
Mukul
> --
> Regards/Gruss,
>     Boris.
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeopl=
e.
> kernel.org%2Ftglx%2Fnotes-about-
> netiquette&amp;data=3D04%7C01%7Cmukul.joshi%40amd.com%7C7ae9c87153f7
> 4572712908d97dbdcc7a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
> %7C637679076423976867%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata
> =3DM5UDrSea0lnEi5%2BhU4ck0zk1dZD9kX4DUoXt95J6dJ4%3D&amp;reserved=3D0
