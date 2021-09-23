Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1775A416213
	for <lists+linux-edac@lfdr.de>; Thu, 23 Sep 2021 17:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242064AbhIWPcc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Sep 2021 11:32:32 -0400
Received: from mail-dm3nam07on2088.outbound.protection.outlook.com ([40.107.95.88]:4358
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242055AbhIWPc2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Sep 2021 11:32:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQdwcEHByt959OYQzqhcCKu7nDwShbodhW+EJPlGjnpB2J+mYR8XIvnwk5nqUIMmTFe7n3D/pPcT+t9TOuqI7jIt2+pr/C65kfFszeKzGW3tDOZW6GlEhNqtV5W1wPd5QQINmkIXhTzqX66D6N+1RlRE9gS5mnmyXYeuvKaeUUpI5RsgyApF75U14vjTuF2dWgM7Cbn+gwPs53vbnVBH5pj81yb+xQCEMgAwOTiy9ocBXNnRLNMKWZkAbChKpUS66SB4a67DHs0SVKaphE1LSQIvEYaON1FNwSLzG4m5pPwSWjWhLY37nwgvTjE2wtsFX1+wsBpOIRqGChJ2o0RkHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NW+fLw8pO7Th0ql3I0dr6SrvVHq9V3qgDq96nBH67Ig=;
 b=j+iapDwoa4eU1YdGfLbkRjyXVCOAzR+ls6F/IJsY5jtzGn41fh1dS/sDWd93QjIxyoT54OE6lz3SJI3xx7VvcUii4JYzKhnIEzxKdgTeg7SaBbT8B4ZsCORkM/zseZFPfVl6izrt/xUoMB0P9dQmtCoXBC/t9MdCPSTGTggf6DaskJwaS6mVvLqdTqG6Avs8IxlxKVnKpMZs5awJqy3YLteeQsJWrFGvH2hK2mbj3CX0aZAQ3f5tHgP5lWwE0jT7TOig7aCVJs3uX280VLfbvyc27fT7QWK7Hu/iVDv3VGHB0bwnlZVgTjTV31ykB6Aj7a5a9UPk9k7MIoqS9l40EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NW+fLw8pO7Th0ql3I0dr6SrvVHq9V3qgDq96nBH67Ig=;
 b=YnCes+jIztp1Z/1W7jpqbBUZlEQ2rgvBNzVsOlvJfy4XkqDiPcCe5Iv99oed733FUQDwCyxEXxFWcWtHO5Z2xCl7ypDqyX1g7wYhPeYieFfdghr9z0PBoGgXUFfFPqH99Nu65Pelbzz6jhjyBsItI0OBO2qrgQ7wWBaRQ99j8q4=
Received: from DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23)
 by DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 15:30:55 +0000
Received: from DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::90b2:e7f6:c5e5:c80f]) by DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::90b2:e7f6:c5e5:c80f%7]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 15:30:55 +0000
From:   "Joshi, Mukul" <Mukul.Joshi@amd.com>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCHv3 2/2] drm/amdgpu: Register MCE notifier for Aldebaran RAS
Thread-Topic: [PATCHv3 2/2] drm/amdgpu: Register MCE notifier for Aldebaran
 RAS
Thread-Index: AQHXr+ktpJldbvXsiEi/xMi8ZoJNQKuxrumAgAAF1YA=
Date:   Thu, 23 Sep 2021 15:30:55 +0000
Message-ID: <DM4PR12MB52639349DF98DB01A3B155EFEEA39@DM4PR12MB5263.namprd12.prod.outlook.com>
References: <20210913021311.12896-2-mukul.joshi@amd.com>
 <20210922193620.15925-1-mukul.joshi@amd.com> <YUyPM7VfYFG/PJmu@yaz-ubuntu>
In-Reply-To: <YUyPM7VfYFG/PJmu@yaz-ubuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-23T15:30:53Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=fa6e978c-a6ec-451d-8c51-69a4400ab6a4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eab7c577-bcc3-49f7-dde2-08d97ea722a6
x-ms-traffictypediagnostic: DM4PR12MB5311:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB531172D573BD8047FB76F75FEEA39@DM4PR12MB5311.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +6tV9Hqp/IA0OjCAjEIVpD794KriZlDy+aJwJnnELsWEQ+RUX6qcB/OnPJGpScgGs7lG3VCEadf5uwNr+I/OtzRKGUTt7K9EIq5b+imkw0q1enRlMz4Rn3BYPuKKsDrrOM9BDZJkU3+PcVsUkDgtNDf6ZF8KfTAb8hxyP5KdVLJw9mxfi9lbEy1wsV7v16rOD3krJ/FsSbnpDzjY2u/GL64MaG7OwuvyN24AO4V5+WpAMsOpDek78khJebSH8PNPfvQ2SwyVUv5D8HnTDsA9xRwqzyLPljBPvR91ZV+7CB8V1PMoCRT1KaXCZCSt6xy4Imx3QyAZrQUsijUEvnmbgf/Hqqd3Ef6Niyi+8cre1BHnVInNpd3ze4H6iFL43hCtVT3XmRxLa9K6BDZAMXw+r2mWop+NGTUvGH/eNQ3uZtx1e7tgrDUSFQdGRf5F4Ho7Vc+LGSx3/t6SMs+hLRanLsCaZLI1AEjVssns4Grg/rFfzVPLKAqsmTXeB8UNiYUobXcJYHodDqL41kQ33085y9PECxGM3YoaWpGULWOuo4LZ6lVrbOdTE7Cxi4zOD3i+CQ0qwGaNJcl8MHCZ2RllJXrz6j1C3ODllDV4Xwb8Um2WmEjJV250VpkJA+SXpQX2rCJiHW5FTQk8qmzztq1KBlXVGsWVP7t3YQy4ys2uoVlc47kTVzwE4i7X8AO0P5RLkLauhMziUQWGqYzjY/0TQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5263.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(7696005)(33656002)(53546011)(8676002)(76116006)(8936002)(38070700005)(5660300002)(122000001)(2906002)(83380400001)(38100700002)(52536014)(55016002)(6506007)(86362001)(6636002)(9686003)(316002)(26005)(186003)(6862004)(54906003)(71200400001)(4326008)(66476007)(66946007)(64756008)(66446008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/EIK0TjDvpQjIhr9X9zNEshQbYGQB+DIdUjO2NkT2hpq/vNGRxWl5iBd4Zkl?=
 =?us-ascii?Q?GlTrRhdELIkMrabAAcrTfzOrhB62M4+8cizYkoNayDv+xO2aSb8qUlz4/pJC?=
 =?us-ascii?Q?6TuQFKwW2GRr7Wk5lAzQ8aJ/lNzLLrBCT9TLLUJ2o82yz1XsKNxB4IhJhQky?=
 =?us-ascii?Q?D60xOugsc6K0uWs/yb0pRFHj3Z4tNxh2KPq6jrjG7nsSLU/XAXQAAkCbDxIw?=
 =?us-ascii?Q?fQd+hfQMVjo+CnnS71Bo4Dlx/6wlKbrVS1S/uhLbBu6l8HCraz90CvxDvnoA?=
 =?us-ascii?Q?KB6YG+5EP8CgIWkACNQIdXUstBgF2TLYGE+M9/LRMgZKtWpwAbojApOwP3iB?=
 =?us-ascii?Q?SUOCZtEaYLNldflxWH+ERwC6s25pyqPpvwI7Ba+vW4MvMbLSpR7FkPDqYO83?=
 =?us-ascii?Q?ClgnYIUgW8GrAeaguUg4fsb42e/j/S2fl1Boq7ohNr2widSY7ZZfDWIq62UD?=
 =?us-ascii?Q?j/x20qd7/hFDxAehR/bO3seKxwlC3XnoDhIA58vDSfVAIncTScw8kEikEYy7?=
 =?us-ascii?Q?NUdUY4FXkb37YunC2B0jBSeEVye+AiRipbGYPQ9kOVN4Phem2to53zbe27OQ?=
 =?us-ascii?Q?giGfbOBzNjgAJPUs1JZvJ2RG2CYqEnqE0xf5pNW7EuQM0qOEeB61Lg/D2heq?=
 =?us-ascii?Q?mJTVHUlDqO0HIeeyU0939okQ85DTHcKvlXuIh+CI7Zr0lzgWuzDyfVBZv1w9?=
 =?us-ascii?Q?3LfJYVpUQZhQQNDGvWMxRVpUdSEnHeemNZg5Fbtse+IW5YVzasKy6ketkpYU?=
 =?us-ascii?Q?w060ofmSpHW9Y9QI/z6LS4PkPhvRSk/LODyEsUAbiR0aSaBut++xGDgxQJDs?=
 =?us-ascii?Q?17I7VuioPMHzWqWbMR7QsSa4sZm56jS/VCKV2Z+oYwN1c7kDo/2wrf6RarbL?=
 =?us-ascii?Q?IrtJULqr1/Bvr0qEhHS/Z9eTYBOjPz/gl1DF9ou/kpKOGAsRbyQk7FQ5Burv?=
 =?us-ascii?Q?uvcYwn1HtPagE2/2lds//1xqeqh4uNoMeCL7cQbNfMk7yQUDje32/iC1BFMn?=
 =?us-ascii?Q?O30JGj9++tNDDT6yNJhD420tMBlNnqGiy8k9GLQ83OHa1lSqrELDDP4eGAnt?=
 =?us-ascii?Q?lzSMR6lADkMmjXXfGCMudjHe80c7oCv5om005m2vGuE7CO3IbD/C8CJ3y3TK?=
 =?us-ascii?Q?EiklUpbYVTCwXBAQURSsUSc4ozy2oHEEZuWtBqq7uwIUTUInXxQkv4HgOKuy?=
 =?us-ascii?Q?RAlJtvoq6kX59TcDY355A9lCNzLwqU9FmGD6UAfAx0BpTEe4uipntVvuQgXF?=
 =?us-ascii?Q?SUoHwJTqO3D2d5Wd6yqhYENwwsSAEzB7G+TwG/TgsxwMbKOVxdCMNuv0TBxN?=
 =?us-ascii?Q?TA0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab7c577-bcc3-49f7-dde2-08d97ea722a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 15:30:55.4649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hTu9/hSJs4Y0DJ0KDlF/3lPHLHiyPYNVgo7Zp22GuerEp3GRL05slTm/GZoWUV+g3I9zCYrgKfg7/+w1UwdtRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5311
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

[AMD Official Use Only]



> -----Original Message-----
> From: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Sent: Thursday, September 23, 2021 10:29 AM
> To: Joshi, Mukul <Mukul.Joshi@amd.com>
> Cc: linux-edac@vger.kernel.org; x86@kernel.org; linux-kernel@vger.kernel.=
org;
> bp@alien8.de; mingo@redhat.com; mchehab@kernel.org; amd-
> gfx@lists.freedesktop.org
> Subject: Re: [PATCHv3 2/2] drm/amdgpu: Register MCE notifier for Aldebara=
n
> RAS
>=20
> On Wed, Sep 22, 2021 at 03:36:20PM -0400, Mukul Joshi wrote:
> > On Aldebaran, GPU driver will handle bad page retirement even though
> > UMC is host managed. As a result, register a bad page retirement
> > handler on the mce notifier chain to retire bad pages on Aldebaran.
> >
>=20
> I think this should state that the driver will do page retirement for GPU=
-managed
> memory. As written, it implies that the driver do page retirement in gene=
ral for
> the system.
>=20
ACK. I will update the description.
> ...
>=20
> > +
> > +static int amdgpu_bad_page_notifier(struct notifier_block *nb,
> > +				    unsigned long val, void *data) {
> > +	struct mce *m =3D (struct mce *)data;
> > +	struct amdgpu_device *adev =3D NULL;
> > +	uint32_t gpu_id =3D 0;
> > +	uint32_t umc_inst =3D 0;
> > +	uint32_t ch_inst, channel_index =3D 0;
> > +	struct ras_err_data err_data =3D {0, 0, 0, NULL};
> > +	struct eeprom_table_record err_rec;
> > +	uint64_t retired_page;
> > +
> > +	/*
> > +	 * If the error was generated in UMC_V2, which belongs to GPU UMCs,
> > +	 * and error occurred in DramECC (Extended error code =3D 0) then onl=
y
> > +	 * process the error, else bail out.
> > +	 */
> > +	if (!m || !((smca_get_bank_type(m->bank) =3D=3D SMCA_UMC_V2) &&
> > +		    (XEC(m->status, 0x1f) =3D=3D 0x0)))
>=20
> The MCA_STATUS[ErrorCodeExt] field is bits [21:16], so the mask should be
> 0x3f.

Ack. Thanks for catching this.
>=20
> > +		return NOTIFY_DONE;
> > +
> > +	/*
> > +	 * If it is correctable error, return.
> > +	 */
> > +	if (mce_is_correctable(m))
> > +		return NOTIFY_OK;
>=20
> Shouldn't this be "NOTIFY_DONE" if "don't care" about this error?

The thinking is we want to stop calling further consumers since it's a corr=
ectable error in GPU UMC and we are not taking any action about the correct=
able errors.

Thanks,
Mukul

>=20
> Thanks,
> Yazen
