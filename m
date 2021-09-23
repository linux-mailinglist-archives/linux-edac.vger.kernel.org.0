Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483B841621A
	for <lists+linux-edac@lfdr.de>; Thu, 23 Sep 2021 17:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241976AbhIWPdT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Sep 2021 11:33:19 -0400
Received: from mail-dm3nam07on2074.outbound.protection.outlook.com ([40.107.95.74]:56769
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242047AbhIWPc5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Sep 2021 11:32:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWD6ZwH6T/kEtsHzW4uhhDgdu/XWOXcJFSQsQJrGVZdlXrfR5q5IHHAN7jypFS5Op0aJLlT1qMnj87gmoeC2eW9nC37/GUH6HtxMyNNoDbV/WpzeBqQwNXRzwKYEfpx0PDFTrotKx0ZUI5e1/PM+PVVbibnOeQsfr8qhp5oR9SvdkhJCL2EHsWLyH2XKGEI7t+truHz/2NXUtXXPR7d38W7x04zyYl726tZIieyIrR8he6PVGOvu1+PXM8eXHCa++OSUeG24DPOWuTWNMP94m8hILpAGNZp7BS5wmYz5TMKxfcU3wuqfhw6ZgINQykqEwZzfrMWELWym6QoeGAaXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kpxXkebSVEnMnSma5aTnN+OYkL8/6RlIr0OZbj9wjIc=;
 b=Vp1Ow3XLGhQdKYT9hEq1lmsKplllUXrEbVEjl8NT3mO1n/mlSWR9mGlbHFWJjD928GxMCSDbRgasPVMUchB2EPpGqTg90xKEQwnyIEyDdIl+IYVZC2Hjan1wxMRCdJsbcXoG6/dQe2UPfWGWdap6dfT/Kwzh8EWlizSMvR++uY7EkgXo53nrwpCvaYvmxBR4crTtBlXNUjPInwfl6qVW/wENBFVK/84z/7G7d+CSBChuzSbc7/ObvGWSfPjSNb19libsvNNotF7M0HkZQcQWVm2QrV/DuwiIG5ZsTg3Rb+MMJjAl3lhaj/+plp0iYj8vk6Az4duxqFpBek6h6zagrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpxXkebSVEnMnSma5aTnN+OYkL8/6RlIr0OZbj9wjIc=;
 b=u++eh4T9D1LdQTyZ96DJIlBPnVgNBabRqlAjjA/7AckLBqC2Txd+Zlf6S6ln6/URVFZTN/dJOI5F5vRJOff5+NIGsmhT2xNR7Gt0+e3s+DczJr4Q/P6UnXoBvfAhfSOb+tJOvZBWZ/dtsfRqEfCFnU4iVeh4YKDWuzsZ+sXeg0w=
Received: from DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23)
 by DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 15:31:24 +0000
Received: from DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::90b2:e7f6:c5e5:c80f]) by DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::90b2:e7f6:c5e5:c80f%7]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 15:31:24 +0000
From:   "Joshi, Mukul" <Mukul.Joshi@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCHv3 2/2] drm/amdgpu: Register MCE notifier for Aldebaran RAS
Thread-Topic: [PATCHv3 2/2] drm/amdgpu: Register MCE notifier for Aldebaran
 RAS
Thread-Index: AQHXr+ktpJldbvXsiEi/xMi8ZoJNQKuxrumAgAACPwCAAA8RIA==
Date:   Thu, 23 Sep 2021 15:31:24 +0000
Message-ID: <DM4PR12MB526346B7ECC03951C33C0253EEA39@DM4PR12MB5263.namprd12.prod.outlook.com>
References: <20210913021311.12896-2-mukul.joshi@amd.com>
 <20210922193620.15925-1-mukul.joshi@amd.com> <YUyPM7VfYFG/PJmu@yaz-ubuntu>
 <YUyRFl3oc2CwFxZz@zn.tnic>
In-Reply-To: <YUyRFl3oc2CwFxZz@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-23T15:31:22Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=464bbd2b-fcde-409c-8471-4af9fed62717;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47fc0156-f742-4388-2e11-08d97ea733b7
x-ms-traffictypediagnostic: DM4PR12MB5311:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB531167ABD83D826B25BAD960EEA39@DM4PR12MB5311.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YAkMptov/HnJG+T7OAW/uMUAYjjhCI9TN0fWskWADe2uUMYUAlkFPLMtvND23/e8n8eCPHa59/qSV8XuQJ2T+tnG9QtpLN4UaA4T/JRTsTLKaVdk9plNywOkIgvLCvgL9hxb2uxGbKD3exRsYcActeKAoCESnvVmVTjq2S3vkOtexrF9kn2T70rprzYArFPKAyWo5T3heelMPz6i/rV642+t1mmvrtLMLXGLmqcpNzBY8MAwk1pPlnij+nHwhKoYp7eSi3JLsidyG4Y7EOdWQtxAdpJfiU7z4NkN3t0MDHxqWpnaa857I2/+7c/YTadircwDA/bX2wPHVhTVonfeHfLCi+bUFhXbRkATfGIDYJOZmvwpy/hqdCP0ob/sEiLVJNC9Q1FYq6PrazWMQXTkIN+p50SIlgqFyck6SQuLADEvCorhJCuksk68VNizyqB4vqktsDLWPR2A4cGMK/cQhEuYVoNFJThl0kwIMS7tge0lpXVHCieVv8LLUYUQoecDBP1RnMMRfOy6QuOD1FPraexhwSrU8WgJPVT0Qtcikd3eepg3gclIExQPWvxsCFX0pH6y9TMM10Mn8vJ/Bw4DND1cHtYJlEEI25JZd3Jom1Dyqs7IGLUIRllI29Xb5gIt+yZ8mKWXfeOG9yAMNMHmduU9dQwNji7GE6xvBdlhn6ySspTvM972mc71/4i0NyEJt7sGtx75CXA4YlsIGZjQC06Ulj1lHLG4NgAwpOe+IBvPKj3TA/9Gy4G2mNOGMqdcEhEJV5OfQJNavJ4btpTyUTHJSslYT+l3xWBnTGaXCg0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5263.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(7696005)(33656002)(45080400002)(53546011)(8676002)(76116006)(8936002)(38070700005)(5660300002)(122000001)(2906002)(83380400001)(38100700002)(52536014)(55016002)(6506007)(86362001)(110136005)(6636002)(966005)(9686003)(316002)(26005)(186003)(54906003)(71200400001)(4326008)(66476007)(66946007)(64756008)(66446008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O9ULmQM4x9nmVPnu9GRThYzO/yF2JI/QY24CxC1/zrR6TIs9n2EK5tU0DrgY?=
 =?us-ascii?Q?b8+k454Iq7G3jL2LHWRDnim0pueua/GXQK2X4Mci42RauXNumrwRwq+11OeE?=
 =?us-ascii?Q?dL06yGzrDrP/oyqoH13Hw/B3nK0ZA2XxyfVdFprut+l5vL/GGRozYt9DwPV8?=
 =?us-ascii?Q?xj02dz5N8i2ir3SXJLzDL0nBZPsIazWhbR1N0l18JOUfTGlZiukPM+R7tFqu?=
 =?us-ascii?Q?CcDBXEBcofUgB2LlWVXF87K/GnA8TvCboqS/uED7MvMSK2oKDS1M9BC2J6AO?=
 =?us-ascii?Q?fKDPEC0sjM1xDYadm+w++ccF0qyfeh+0ikleJXgzXc1A/7LwbuNSX1x7jvQH?=
 =?us-ascii?Q?DAQThxGVPxhtJHoCzAQU0b5l1Y05wEFMihWvqiCat8Sx/hNcnocRDfsCzfj+?=
 =?us-ascii?Q?n3R2wnzsMNom6jZ3QDBMozebsRlBvXgWb+nQA+oO6qRTgM9J0/7CO374CVT0?=
 =?us-ascii?Q?RCvZXu0plMyoElkAzbSshOS9wUc5eFuqXGfH6UPhlBgcsGLUYU2vl98RNZFc?=
 =?us-ascii?Q?zDM/Zl2YBaEnhEOI0mKJGZROSX0dmZPyrJG3CmWrF4Y7goXKC8AxmCjQKwKp?=
 =?us-ascii?Q?PzjQyUTjEoj015a4OAyeLsOKQE/qdu861O4EMZ/7VqFhfOrr2NnDUNRRVyBL?=
 =?us-ascii?Q?0TyUBv7dEsTUWXrrGPhvkCcWoNoLmz0fPdN+M9/JwbiQBVjy8Ur3mZiIkXjf?=
 =?us-ascii?Q?zo/7qgm0QX9CfGWC5VOYZPECnOnLWtUKNltsj850tpAdoYWMJutX8CBzWNIY?=
 =?us-ascii?Q?Ks0B4iFVDB5KaxR5M7UgK6NTLI4CGr78jWGv4YhuUzr+Aa9a7gqe8NaKCz+w?=
 =?us-ascii?Q?v74/qlLvLVZW8bpbXvxckt4rIG0EpbjdCJDPEVC74nnMt9GftWXKDIj5UtIV?=
 =?us-ascii?Q?i/09YvPNAJshItMcuLKR8gSbDywTUopMpyjgN/hpr3kBgo1s/a5sMthy/EeL?=
 =?us-ascii?Q?hnH6R9BnCaOLpkbC7AZa5Ayy/MQKw83Ji/3x/1BW+Uf5IL6YCrtugGTNo8RX?=
 =?us-ascii?Q?3AbDGTREkBx1QkFZSKQceO33uuzGfeMFkXOuIJJRUOa4nPmjBh3sJbO0BFvj?=
 =?us-ascii?Q?FdtvOmlTpx00pakAU3S97mfg0cKmeYeFZdvs7Je7a/+U87x92ZfBXluIO8ew?=
 =?us-ascii?Q?mk4vcU1/F3zF/WfOetBLfb8BaOpThpRHi41zQLZYYCeztLrpXcu9Z0B+xh+7?=
 =?us-ascii?Q?omL4OPXOuIlzpvcqhr1WipUxMYQU0vzYW7AFA9GR5l+qs6VmdPJVm+r+5mYz?=
 =?us-ascii?Q?TownGyi+Jh5f4mZOVPqhGa/MI5z1BoWTRKVbMOa41rFmpPwV/DoFGUxluAnC?=
 =?us-ascii?Q?OII=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47fc0156-f742-4388-2e11-08d97ea733b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 15:31:24.1677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eruu2ymqDCQ8tqsdf/mQ0Hb9W6hTOOwMiinqwYTuuR2czs4+bAAc/lmFc1BuqRTZQbj9igPfPodTLIh3n20ZWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5311
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

[AMD Official Use Only]



> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Thursday, September 23, 2021 10:37 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: Joshi, Mukul <Mukul.Joshi@amd.com>; linux-edac@vger.kernel.org;
> x86@kernel.org; linux-kernel@vger.kernel.org; mingo@redhat.com;
> mchehab@kernel.org; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCHv3 2/2] drm/amdgpu: Register MCE notifier for Aldebara=
n
> RAS
>=20
> [CAUTION: External Email]
>=20
> On Thu, Sep 23, 2021 at 02:29:07PM +0000, Yazen Ghannam wrote:
> > > +   /*
> > > +    * If the error was generated in UMC_V2, which belongs to GPU UMC=
s,
> > > +    * and error occurred in DramECC (Extended error code =3D 0) then=
 only
> > > +    * process the error, else bail out.
> > > +    */
> > > +   if (!m || !((smca_get_bank_type(m->bank) =3D=3D SMCA_UMC_V2) &&
> > > +               (XEC(m->status, 0x1f) =3D=3D 0x0)))
> >
> > The MCA_STATUS[ErrorCodeExt] field is bits [21:16], so the mask should
> > be 0x3f.
> >
> > > +           return NOTIFY_DONE;
> > > +
> > > +   /*
> > > +    * If it is correctable error, return.
> > > +    */
> > > +   if (mce_is_correctable(m))
> > > +           return NOTIFY_OK;
> >
> > Shouldn't this be "NOTIFY_DONE" if "don't care" about this error?
>=20
> I think the logic here is to stop calling any further consumers on the no=
tify chain
> because this is a GPU correctable error and they can't do anything about =
it
> anyway, right?

That's correct.

Regards,
Mukul

>=20
> Or am I misreading it?
>=20
> --
> Regards/Gruss,
>     Boris.
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeopl=
e.
> kernel.org%2Ftglx%2Fnotes-about-
> netiquette&amp;data=3D04%7C01%7Cmukul.joshi%40amd.com%7C1493bcdae62
> 8466d5b8408d97e9fa6f0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
> %7C637680046455034969%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata
> =3DuqbjJslUPJabZonJc6m9Ub3C5IkZDPdqwr6MI0oLPcc%3D&amp;reserved=3D0
