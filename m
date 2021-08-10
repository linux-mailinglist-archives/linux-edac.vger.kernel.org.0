Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA4F3E5A5E
	for <lists+linux-edac@lfdr.de>; Tue, 10 Aug 2021 14:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240687AbhHJMuI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Aug 2021 08:50:08 -0400
Received: from mail-dm3nam07on2056.outbound.protection.outlook.com ([40.107.95.56]:16609
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240821AbhHJMuI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Aug 2021 08:50:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBgPbwfEZFIQWj93u5YRs/SEycOnYuh8exKqgk5f+EvYqf+4hpL9Y3H6wji8uHwM6BX+wRoLSpEY5cj7ERhEENFkgJNMTKLPnjtgB9hEVOYuHmZaCsDueuTZjG/2tQ51QJ4MLh0QN3gCi7f6WJVCPjkHJhDRk2t8HlOdO/9ia0Eas9kMVbScQHJBYdKqeIBu3+tLyCdHWpS4MxvTpClVBREFp3uAaMKM5lDY/K9dFxcN6yXXBOEfAeb2R1b8/QbCuAYh6E/k1PaGRuin3jTZOb0ThVkhSt32gIWLpxRsyfzCPAwKMYChjMj2N54OnfeZokmDJBkV9+PJcW8SGe4qeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hhkt/h02U0T/1UgMYKlsuqLu7N9tANhGYhz5MLyGJ9w=;
 b=UI/2VcXQPWqOQ3N+1OfkKB4xsNVnn5p0+lZk76NhBrEOSmIZk1Zm+0aVEX9uAfGpDhuBFWIJimIZZ2DyI+/PLeu7F5fmzuNNODNBdjBnbYrxINUW+0HMMTnFoGK+W14zrCoI+itJFCMioetuwVi2X2nBWCILNtpQIAQ4Q2orfxRaDQyQPwNrn7o78+3lC6R5LAIDZfrK5KQN+322/ujYWXjmKgfEqUXfn/mkhraXCaj7E6qIgC888nF9Y0PkSjyZEKEQGbbwjXRyaT/oEfb4eVeNfnIJwNAwZYXhea4HMdkRe76xFmAeexnRpajyEjDzvak9NBhhbG3G6WnJhbWfYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hhkt/h02U0T/1UgMYKlsuqLu7N9tANhGYhz5MLyGJ9w=;
 b=RKpK0I4cU2ATbpchB9v0xKRgz7o1/MpwgERCXuo9QD2MeO65/yWlbP80EaY6CHCbnLWIDKOT2X1TXATD7GJ5R4GqdhMJIXNrUbn2yzyfSIw78aBRXeClEtbhg4MUzKcmG8zeFnXTypthGmfv41+lr/Wjg6b5TNkBY4GmO2wXmWA=
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Tue, 10 Aug
 2021 12:49:44 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::38e0:44fb:fbfb:c8d2]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::38e0:44fb:fbfb:c8d2%9]) with mapi id 15.20.4415.014; Tue, 10 Aug 2021
 12:49:44 +0000
From:   "Chatradhi, Naveen Krishna" <NaveenKrishna.Chatradhi@amd.com>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>
Subject: RE: [PATCH 5/7] EDAC/amd64: Enumerate memory on noncpu nodes
Thread-Topic: [PATCH 5/7] EDAC/amd64: Enumerate memory on noncpu nodes
Thread-Index: AQHXbb9WTv1m1WtltkWyQzGxAPIQzataam6AgBKE6GA=
Date:   Tue, 10 Aug 2021 12:49:44 +0000
Message-ID: <BL1PR12MB5286D16039495197C53779FCE8F79@BL1PR12MB5286.namprd12.prod.outlook.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
 <20210630152828.162659-6-nchatrad@amd.com>
 <20210729175549.GB4318@aus-x-yghannam.amd.com>
In-Reply-To: <20210729175549.GB4318@aus-x-yghannam.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-10T12:49:41Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d5155d2d-1db2-4df2-a61f-758603a14ccb;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cefb8bea-a95a-401e-d6b2-08d95bfd53f3
x-ms-traffictypediagnostic: BL1PR12MB5270:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5270486BB82583C0CC0BF8A3E8F79@BL1PR12MB5270.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jRRBC1efq8sr74rYPOZBUHAFlPw2OcFAI7TxQw1CimmUu8EwvfYsSUbJ1rT0+izBHBu3U4I5EIvFTlAt/8trt4HZGIDXVCJcHQZMsjcshnxDlpUHuQl1n/pAJHd24W1ll0UWrwnykgCQD1yi8aH5ctRwLltjjcXn3kXYJvGYcRDY/yuTCRCOjL/9VUk/WbWeZ+rk+fe4nHG7AYekAsJuKXlvl9d+Sv7Rg+5ToWibVmfHEo45yuPD8HTrBuZdNGh9rJ6Cmans7aTlImvsJxxQzafb53Btz0vKOMKvP34d3ntB48tsRGi3VJklIzqskiIGBwaqXPpZQ0lN+3Its4Q+cOZDJdc7fhInmWMiOaUEGAnocQylG7lyKLAUwP4LcRdVKbkIF1DRQ6HD3uXvgX0OkVpN/sz1BPwNF9O0Tjm7Ub9BhiwxxSU1h10mOyb2Jsg2JJTiVGmPpaq3ZieNMjfADeBoKo4194Akb46bI/UVNEFcvj/D565QNv3Ly2/bTJbFK82TmJzqzZUCz/OeWMEr1SryCYXVWroM2Zv1SMB4BT7Hq5WZ4lytRWaF5VEnQQFljXMXdmdcvrPEt1sek7QMndR7xDljNSEvuZWWDRZAtqnJtI2ATh7gVwPhkat5fCp+W6kwyL3YlWq6j0vPG6aA/IDMSM7We4KkFYvWL2DXGq4e4NbmJR6EFNdedoozIQeiuQhajokd2FP3G2K2hOrd8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(33656002)(71200400001)(6862004)(478600001)(8936002)(83380400001)(6506007)(5660300002)(30864003)(54906003)(6636002)(122000001)(4326008)(38100700002)(86362001)(76116006)(2906002)(7696005)(38070700005)(8676002)(26005)(186003)(316002)(9686003)(64756008)(66476007)(66946007)(53546011)(66446008)(52536014)(55016002)(66556008)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vmXOzfRlggGAc6A1/gYeWCR32v/sF4SzC/0FahBun9KHrKIXB/Qc1O6JzKRk?=
 =?us-ascii?Q?HRTEStamd5T5gnkrIegBqg2IRsGApL6033kxGtbTopRpLnSITch0vgEZTT1D?=
 =?us-ascii?Q?6ACioGP2c8HrpCgoAbJdN2ra52PjAa2/QxTVSOE7W1Nousx1cYsGpeUachD1?=
 =?us-ascii?Q?chQMuNo/S79Pc+Txz7DtmjfmPp35GuHutHKBTUoUOogZ5oOXLg96yOHxIMkP?=
 =?us-ascii?Q?PaS5empS4C2zW6yirsr9LOdzonEeFxsaIIS0lJukBPdHly/XQYO71cIMdGzG?=
 =?us-ascii?Q?xxldK9JfhFePfF3q2eOc1p4dET0YFOo7Jj8561wdQmqeM30xT66DCR+JRMtF?=
 =?us-ascii?Q?kXO83UgU1u6De019HrvupDJj8LjKLLV+9VhXI6AeyBKP8sVk1eL9Go+B0Tbi?=
 =?us-ascii?Q?oilm+hz21Xe+YopKSCk3eATcy6HYS74QPQBJ03dBHQb/EmZ/ShAWLLgspiOU?=
 =?us-ascii?Q?Vh8qI+XfIwj7Kor9dgwqR9+0o4Y0LwR5tRXy1h7zTfoClN0XY5pr0jBb0m8a?=
 =?us-ascii?Q?rfyxJY2wobZ1I/UxlSy3d0Nwd4sV5nlpCfLD7S7e86dyUTAlPMh0/ZTNFVke?=
 =?us-ascii?Q?vCmbA81D6kUQsdUF+9KvvKp2ehxYv0VlWw+uxK92oWUG7vKqoz7KzeRngCjo?=
 =?us-ascii?Q?b06dQ48MqmqXuXFGxqKOi5IDDE05/KQLyq6StrtJZaoxO1Hv5bm8WAjscQnn?=
 =?us-ascii?Q?zrhqc18NZM6UplTZE4Q7fvMOy9v9GH9JsudDifmX/yG9EuIzn4rLOo50ck32?=
 =?us-ascii?Q?PVBxN0AQsWtNa6INBD4g9+Qw/hUMoF0m0P8C6N/6ScARyv1RWqT9A7ysFx+y?=
 =?us-ascii?Q?D5AmVc7pIFKzDa0zEQ3XiaJxPcigbsoRlgskWrJKdT9mKWzFUtqBlxstN4gJ?=
 =?us-ascii?Q?+HrIqmOR0urdkyJ62qG9/J5abhKTlJ5cUjSrKYwiiMnwPQ3/7XYVnklziFOR?=
 =?us-ascii?Q?MG8K/NUjRuIRKdjG2hB2wtjWNrADlFqGLF7ZpsypNHrJl6kEbwhuK1wVyElQ?=
 =?us-ascii?Q?ouNRA6f2tBVmdrbZSgpk3kr5eHNbqDo6r5X9M+Ic+Hxbuk1csqnDVuhbKNIc?=
 =?us-ascii?Q?lQAfnXru/MslE+QxCnWrHu+Erdhn/5zgua2gK6MwPCuelUJSZSPcaXf5RL1z?=
 =?us-ascii?Q?uvOPzOhzhxux2wfPopUwmACYC53iKqQvEpHiUZEJIDsDq+yG2K9K80/uY9Op?=
 =?us-ascii?Q?v9NQrJtGY2ZDsuR+HSaL3GkNtpOqEO34hkonVJJ5sspS8YHPXdlOxcyehj99?=
 =?us-ascii?Q?kLtTHMRD1g4nw2E3ZAr0kjUjPTbQKlbE4ILywuKajM6NU14UXiKB6SCzIDqG?=
 =?us-ascii?Q?r3s/rj2LE5NkgSkFplQLiiJu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefb8bea-a95a-401e-d6b2-08d95bfd53f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 12:49:44.1196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cg2nbmHjakkZeNdmgAPdjUxXURrHNb6n/bm0wLSQtlp80F3LwTPmexauC2H3tsQYhXorb5Ai/9qq8Q3qHVSLsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

[Public]

Hi Yazen,=20

-----Original Message-----
From: Ghannam, Yazen <Yazen.Ghannam@amd.com>=20
Sent: Thursday, July 29, 2021 11:26 PM
To: Chatradhi, Naveen Krishna <NaveenKrishna.Chatradhi@amd.com>
Cc: linux-edac@vger.kernel.org; x86@kernel.org; linux-kernel@vger.kernel.or=
g; bp@alien8.de; mingo@redhat.com; mchehab@kernel.org
Subject: Re: [PATCH 5/7] EDAC/amd64: Enumerate memory on noncpu nodes

On Wed, Jun 30, 2021 at 08:58:26PM +0530, Naveen Krishna Chatradhi wrote:
> On newer heterogeneous systems from AMD with GPU nodes connected via=20
> xGMI links to the CPUs, the GPU dies are interfaced with HBM2 memory.
>=20
> This patch modifies the amd64_edac module to handle the HBM memory=20
> enumeration leveraging the existing edac and the amd64 specific data=20
> structures.
>=20
> The UMC Phys on GPU nodes are enumerated as csrows The UMC channels=20
> connected to HBMs are enumerated as ranks
>

Please make sure there is some imperative statement in the commit message. =
And watch out for grammar, punctuation, etc.

> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
>  drivers/edac/amd64_edac.c | 300=20
> +++++++++++++++++++++++++++++---------
>  drivers/edac/amd64_edac.h |  27 ++++
>  2 files changed, 259 insertions(+), 68 deletions(-)
>=20
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c=20
> index 25c6362e414b..8fe0a5e3c8f2 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -1741,6 +1741,9 @@ static unsigned long determine_edac_cap(struct=20
> amd64_pvt *pvt)
> =20
>  		if (umc_en_mask =3D=3D dimm_ecc_en_mask)
>  			edac_cap =3D EDAC_FLAG_SECDED;
> +
> +		if (pvt->is_noncpu)
> +			edac_cap	=3D EDAC_FLAG_EC;

This flag means "Error Checking - no correction". Is that appropriate for t=
hese devices?
[naveenk:] Used FLAG_SECDED which seems appropriate for our requirement.

>  	} else {
>  		bit =3D (pvt->fam > 0xf || pvt->ext_model >=3D K8_REV_F)
>  			? 19
> @@ -1799,6 +1802,9 @@ static int f17_get_cs_mode(int dimm, u8 ctrl,=20
> struct amd64_pvt *pvt)  {
>  	int cs_mode =3D 0;
> =20
> +	if (pvt->is_noncpu)
> +		return CS_EVEN_PRIMARY | CS_ODD_PRIMARY;
> +

Why do this function call if the values are hard-coded? I think you can jus=
t set them below.
[naveenk:] The mode was required in 2 places, instead of hardcoding in 2 pl=
aces we have modified once in the f17_get_cs_mode()

>  	if (csrow_enabled(2 * dimm, ctrl, pvt))
>  		cs_mode |=3D CS_EVEN_PRIMARY;
> =20
> @@ -1818,6 +1824,15 @@ static void debug_display_dimm_sizes_df(struct=20
> amd64_pvt *pvt, u8 ctrl)
> =20
>  	edac_printk(KERN_DEBUG, EDAC_MC, "UMC%d chip selects:\n", ctrl);
> =20
> +	if (pvt->is_noncpu) {
> +		cs_mode =3D f17_get_cs_mode(cs0, ctrl, pvt);
> +		for_each_chip_select(cs0, ctrl, pvt) {
> +			size0 =3D pvt->ops->dbam_to_cs(pvt, ctrl, cs_mode, cs0);
> +			amd64_info(EDAC_MC ": %d: %5dMB\n", cs0, size0);

So this puts each chip select size on a new line rather than grouping by tw=
os. Is there a logical or physical reason for the difference?
[naveenk:] The existing code is printing mode, size for cs0 and cs1. I did =
not find a reason to keep cs1 for noncpu nodes. Hence the difference.

> +		}
> +		return;
> +	}
> +
>  	for (dimm =3D 0; dimm < 2; dimm++) {
>  		cs0 =3D dimm * 2;
>  		cs1 =3D dimm * 2 + 1;
> @@ -1833,43 +1848,53 @@ static void debug_display_dimm_sizes_df(struct am=
d64_pvt *pvt, u8 ctrl)
>  	}
>  }
> =20
> -static void __dump_misc_regs_df(struct amd64_pvt *pvt)
> +static void dump_umcch_regs(struct amd64_pvt *pvt, int i)
>  {
> -	struct amd64_umc *umc;
> -	u32 i, tmp, umc_base;
> -
> -	for_each_umc(i) {
> -		umc_base =3D get_umc_base(i);
> -		umc =3D &pvt->umc[i];
> +	struct amd64_umc *umc =3D &pvt->umc[i];
> +	u32 tmp, umc_base;
> =20
> -		edac_dbg(1, "UMC%d DIMM cfg: 0x%x\n", i, umc->dimm_cfg);
> +	if (pvt->is_noncpu) {
>  		edac_dbg(1, "UMC%d UMC cfg: 0x%x\n", i, umc->umc_cfg);
>  		edac_dbg(1, "UMC%d SDP ctrl: 0x%x\n", i, umc->sdp_ctrl);
>  		edac_dbg(1, "UMC%d ECC ctrl: 0x%x\n", i, umc->ecc_ctrl);
> +		edac_dbg(1, "UMC%d All HBMs support ECC: yes\n", i);
> +		return;
> +	}
> =20
> -		amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_ECC_BAD_SYMBOL, &tmp);
> -		edac_dbg(1, "UMC%d ECC bad symbol: 0x%x\n", i, tmp);
> -
> -		amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_UMC_CAP, &tmp);
> -		edac_dbg(1, "UMC%d UMC cap: 0x%x\n", i, tmp);
> -		edac_dbg(1, "UMC%d UMC cap high: 0x%x\n", i, umc->umc_cap_hi);
> -
> -		edac_dbg(1, "UMC%d ECC capable: %s, ChipKill ECC capable: %s\n",
> -				i, (umc->umc_cap_hi & BIT(30)) ? "yes" : "no",
> -				    (umc->umc_cap_hi & BIT(31)) ? "yes" : "no");
> -		edac_dbg(1, "UMC%d All DIMMs support ECC: %s\n",
> -				i, (umc->umc_cfg & BIT(12)) ? "yes" : "no");
> -		edac_dbg(1, "UMC%d x4 DIMMs present: %s\n",
> -				i, (umc->dimm_cfg & BIT(6)) ? "yes" : "no");
> -		edac_dbg(1, "UMC%d x16 DIMMs present: %s\n",
> -				i, (umc->dimm_cfg & BIT(7)) ? "yes" : "no");
> -
> -		if (pvt->dram_type =3D=3D MEM_LRDDR4) {
> -			amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_ADDR_CFG, &tmp);
> -			edac_dbg(1, "UMC%d LRDIMM %dx rank multiply\n",
> -					i, 1 << ((tmp >> 4) & 0x3));
> -		}
> +	umc_base =3D get_umc_base(i);
> +
> +	edac_dbg(1, "UMC%d DIMM cfg: 0x%x\n", i, umc->dimm_cfg);
> +
> +	amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_ECC_BAD_SYMBOL, &tmp);
> +	edac_dbg(1, "UMC%d ECC bad symbol: 0x%x\n", i, tmp);
> +
> +	amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_UMC_CAP, &tmp);
> +	edac_dbg(1, "UMC%d UMC cap: 0x%x\n", i, tmp);
> +	edac_dbg(1, "UMC%d UMC cap high: 0x%x\n", i, umc->umc_cap_hi);
> =20
> +	edac_dbg(1, "UMC%d ECC capable: %s, ChipKill ECC capable: %s\n",
> +		 i, (umc->umc_cap_hi & BIT(30)) ? "yes" : "no",
> +		    (umc->umc_cap_hi & BIT(31)) ? "yes" : "no");
> +	edac_dbg(1, "UMC%d All DIMMs support ECC: %s\n",
> +		 i, (umc->umc_cfg & BIT(12)) ? "yes" : "no");
> +	edac_dbg(1, "UMC%d x4 DIMMs present: %s\n",
> +		 i, (umc->dimm_cfg & BIT(6)) ? "yes" : "no");
> +	edac_dbg(1, "UMC%d x16 DIMMs present: %s\n",
> +		 i, (umc->dimm_cfg & BIT(7)) ? "yes" : "no");
> +
> +	if (pvt->dram_type =3D=3D MEM_LRDDR4) {
> +		amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_ADDR_CFG, &tmp);
> +		edac_dbg(1, "UMC%d LRDIMM %dx rank multiply\n",
> +			 i, 1 << ((tmp >> 4) & 0x3));
> +	}
> +}
> +
> +static void __dump_misc_regs_df(struct amd64_pvt *pvt) {
> +	int i;
> +
> +	for_each_umc(i) {
> +		dump_umcch_regs(pvt, i);
>  		debug_display_dimm_sizes_df(pvt, i);
>  	}
> =20
> @@ -1937,10 +1962,14 @@ static void prep_chip_selects(struct amd64_pvt *p=
vt)
>  		pvt->csels[0].m_cnt =3D pvt->csels[1].m_cnt =3D 2;
>  	} else if (pvt->fam >=3D 0x17) {
>  		int umc;
> -
>  		for_each_umc(umc) {
> -			pvt->csels[umc].b_cnt =3D 4;
> -			pvt->csels[umc].m_cnt =3D 2;
> +			if (pvt->is_noncpu) {
> +				pvt->csels[umc].b_cnt =3D 8;
> +				pvt->csels[umc].m_cnt =3D 8;
> +			} else {
> +				pvt->csels[umc].b_cnt =3D 4;
> +				pvt->csels[umc].m_cnt =3D 2;
> +			}
>  		}
> =20
>  	} else {
> @@ -1949,6 +1978,31 @@ static void prep_chip_selects(struct amd64_pvt *pv=
t)
>  	}
>  }
> =20
> +static void read_noncpu_umc_base_mask(struct amd64_pvt *pvt) {
> +	u32 base_reg, mask_reg;
> +	u32 *base, *mask;
> +	int umc, cs;
> +
> +	for_each_umc(umc) {
> +		for_each_chip_select(cs, umc, pvt) {
> +			base_reg =3D get_noncpu_umc_base(umc, cs) + UMCCH_BASE_ADDR;
> +			base =3D &pvt->csels[umc].csbases[cs];
> +
> +			if (!amd_smn_read(pvt->mc_node_id, base_reg, base))
> +				edac_dbg(0, "  DCSB%d[%d]=3D0x%08x reg: 0x%x\n",
> +					 umc, cs, *base, base_reg);
> +
> +			mask_reg =3D get_noncpu_umc_base(umc, cs) + UMCCH_ADDR_MASK;
> +			mask =3D &pvt->csels[umc].csmasks[cs];
> +
> +			if (!amd_smn_read(pvt->mc_node_id, mask_reg, mask))
> +				edac_dbg(0, "  DCSM%d[%d]=3D0x%08x reg: 0x%x\n",
> +					 umc, cs, *mask, mask_reg);
> +		}
> +	}
> +}
> +
>  static void read_umc_base_mask(struct amd64_pvt *pvt)  {
>  	u32 umc_base_reg, umc_base_reg_sec;
> @@ -2009,8 +2063,12 @@ static void read_dct_base_mask(struct amd64_pvt=20
> *pvt)
> =20
>  	prep_chip_selects(pvt);
> =20
> -	if (pvt->umc)
> -		return read_umc_base_mask(pvt);
> +	if (pvt->umc) {
> +		if (pvt->is_noncpu)
> +			return read_noncpu_umc_base_mask(pvt);
> +		else
> +			return read_umc_base_mask(pvt);
> +	}
> =20
>  	for_each_chip_select(cs, 0, pvt) {
>  		int reg0   =3D DCSB0 + (cs * 4);
> @@ -2056,6 +2114,10 @@ static void determine_memory_type(struct amd64_pvt=
 *pvt)
>  	u32 dram_ctrl, dcsm;
> =20
>  	if (pvt->umc) {
> +		if (pvt->is_noncpu) {
> +			pvt->dram_type =3D MEM_HBM2;
> +			return;
> +		}
>  		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
>  			pvt->dram_type =3D MEM_LRDDR4;
>  		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4)) @@=20
> -2445,7 +2507,10 @@ static int f17_early_channel_count(struct=20
> amd64_pvt *pvt)
> =20
>  	/* SDP Control bit 31 (SdpInit) is clear for unused UMC channels */
>  	for_each_umc(i)
> -		channels +=3D !!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT);
> +		if (pvt->is_noncpu)
> +			channels +=3D pvt->csels[i].b_cnt;
> +		else
> +			channels +=3D !!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT);
> =20
>  	amd64_info("MCT channel count: %d\n", channels);
> =20
> @@ -2586,6 +2651,12 @@ static int f17_addr_mask_to_cs_size(struct amd64_p=
vt *pvt, u8 umc,
>  	u32 msb, weight, num_zero_bits;
>  	int dimm, size =3D 0;
> =20
> +	if (pvt->is_noncpu) {
> +		addr_mask_orig =3D pvt->csels[umc].csmasks[csrow_nr];
> +		/* The memory channels in case of GPUs are fully populated */
> +		goto skip_noncpu;
> +	}
> +
>  	/* No Chip Selects are enabled. */
>  	if (!cs_mode)
>  		return size;
> @@ -2611,6 +2682,7 @@ static int f17_addr_mask_to_cs_size(struct amd64_pv=
t *pvt, u8 umc,
>  	else
>  		addr_mask_orig =3D pvt->csels[umc].csmasks[dimm];
> =20
> + skip_noncpu:
>  	/*
>  	 * The number of zero bits in the mask is equal to the number of bits
>  	 * in a full mask minus the number of bits in the current mask.
> @@ -3356,6 +3428,16 @@ static struct amd64_family_type family_types[] =3D=
 {
>  			.dbam_to_cs		=3D f17_addr_mask_to_cs_size,
>  		}
>  	},
> +	[ALDEBARAN_GPUS] =3D {
> +		.ctl_name =3D "ALDEBARAN",
> +		.f0_id =3D PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F0,
> +		.f6_id =3D PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F6,
> +		.max_mcs =3D 4,
> +		.ops =3D {
> +			.early_channel_count	=3D f17_early_channel_count,
> +			.dbam_to_cs		=3D f17_addr_mask_to_cs_size,
> +		}
> +	},
>  };
> =20
>  /*
> @@ -3611,6 +3693,19 @@ static int find_umc_channel(struct mce *m)
>  	return (m->ipid & GENMASK(31, 0)) >> 20;  }
> =20
> +/*
> + * The HBM memory managed by the UMCCH of the noncpu node
> + * can be calculated based on the [15:12]bits of IPID as follows  */=20
> +static int find_umc_channel_noncpu(struct mce *m) {
> +	u8 umc, ch;
> +
> +	umc =3D find_umc_channel(m);
> +	ch =3D ((m->ipid >> 12) & 0xf);
> +	return umc % 2 ? (ch + 4) : ch;
> +}
> +
>  static void decode_umc_error(int node_id, struct mce *m)  {
>  	u8 ecc_type =3D (m->status >> 45) & 0x3; @@ -3618,6 +3713,7 @@ static=20
> void decode_umc_error(int node_id, struct mce *m)
>  	struct amd64_pvt *pvt;
>  	struct err_info err;
>  	u64 sys_addr =3D m->addr;
> +	u8 umc_num;
> =20
>  	mci =3D edac_mc_find(node_id);
>  	if (!mci)
> @@ -3630,7 +3726,16 @@ static void decode_umc_error(int node_id, struct m=
ce *m)
>  	if (m->status & MCI_STATUS_DEFERRED)
>  		ecc_type =3D 3;
> =20
> -	err.channel =3D find_umc_channel(m);
> +	if (pvt->is_noncpu) {
> +		err.csrow =3D find_umc_channel(m) / 2;
> +		/* The UMC channel is reported as the csrow in case of the noncpu node=
s */
> +		err.channel =3D find_umc_channel_noncpu(m);
> +		umc_num =3D err.csrow * 8 + err.channel;
> +	} else {
> +		err.channel =3D find_umc_channel(m);
> +		err.csrow =3D m->synd & 0x7;
> +		umc_num =3D err.channel;
> +	}
> =20
>  	if (!(m->status & MCI_STATUS_SYNDV)) {
>  		err.err_code =3D ERR_SYND;
> @@ -3646,9 +3751,7 @@ static void decode_umc_error(int node_id, struct mc=
e *m)
>  			err.err_code =3D ERR_CHANNEL;
>  	}
> =20
> -	err.csrow =3D m->synd & 0x7;
> -
> -	if (umc_normaddr_to_sysaddr(&sys_addr, pvt->mc_node_id, err.channel)) {
> +	if (umc_normaddr_to_sysaddr(&sys_addr, pvt->mc_node_id, umc_num)) {
>  		err.err_code =3D ERR_NORM_ADDR;
>  		goto log_error;
>  	}
> @@ -3775,15 +3878,20 @@ static void __read_mc_regs_df(struct amd64_pvt=20
> *pvt)
> =20
>  	/* Read registers from each UMC */
>  	for_each_umc(i) {
> +		if (pvt->is_noncpu)
> +			umc_base =3D get_noncpu_umc_base(i, 0);
> +		else
> +			umc_base =3D get_umc_base(i);
> =20
> -		umc_base =3D get_umc_base(i);
>  		umc =3D &pvt->umc[i];
> -
> -		amd_smn_read(nid, umc_base + UMCCH_DIMM_CFG, &umc->dimm_cfg);
>  		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
>  		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
>  		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
> -		amd_smn_read(nid, umc_base + UMCCH_UMC_CAP_HI, &umc->umc_cap_hi);
> +
> +		if (!pvt->is_noncpu) {
> +			amd_smn_read(nid, umc_base + UMCCH_DIMM_CFG, &umc->dimm_cfg);
> +			amd_smn_read(nid, umc_base + UMCCH_UMC_CAP_HI, &umc->umc_cap_hi);
> +		}
>  	}
>  }
> =20
> @@ -3865,7 +3973,9 @@ static void read_mc_regs(struct amd64_pvt *pvt)
>  	determine_memory_type(pvt);
>  	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
> =20
> -	determine_ecc_sym_sz(pvt);
> +	/* ECC symbol size is not available on NONCPU nodes */
> +	if (!pvt->is_noncpu)
> +		determine_ecc_sym_sz(pvt);
>  }
> =20
>  /*
> @@ -3953,15 +4063,21 @@ static int init_csrows_df(struct mem_ctl_info *mc=
i)
>  				continue;
> =20
>  			empty =3D 0;
> -			dimm =3D mci->csrows[cs]->channels[umc]->dimm;
> +			if (pvt->is_noncpu) {
> +				dimm =3D mci->csrows[umc]->channels[cs]->dimm;
> +				dimm->edac_mode =3D EDAC_SECDED;
> +				dimm->dtype =3D DEV_X16;
> +			} else {
> +				dimm->edac_mode =3D edac_mode;
> +				dimm->dtype =3D dev_type;
> +				dimm =3D mci->csrows[cs]->channels[umc]->dimm;

This last line should go before the other two.
[naveenk:] done

> +			}
> =20
>  			edac_dbg(1, "MC node: %d, csrow: %d\n",
>  					pvt->mc_node_id, cs);
> =20
>  			dimm->nr_pages =3D get_csrow_nr_pages(pvt, umc, cs);
>  			dimm->mtype =3D pvt->dram_type;
> -			dimm->edac_mode =3D edac_mode;
> -			dimm->dtype =3D dev_type;
>  			dimm->grain =3D 64;
>  		}
>  	}
> @@ -4226,7 +4342,9 @@ static bool ecc_enabled(struct amd64_pvt *pvt)
> =20
>  			umc_en_mask |=3D BIT(i);
> =20
> -			if (umc->umc_cap_hi & UMC_ECC_ENABLED)
> +			/* ECC is enabled by default on NONCPU nodes */
> +			if (pvt->is_noncpu ||
> +			    (umc->umc_cap_hi & UMC_ECC_ENABLED))
>  				ecc_en_mask |=3D BIT(i);
>  		}
> =20
> @@ -4262,6 +4380,11 @@ f17h_determine_edac_ctl_cap(struct mem_ctl_info=20
> *mci, struct amd64_pvt *pvt)  {
>  	u8 i, ecc_en =3D 1, cpk_en =3D 1, dev_x4 =3D 1, dev_x16 =3D 1;
> =20
> +	if (pvt->is_noncpu) {
> +		mci->edac_ctl_cap |=3D EDAC_SECDED;
> +		return;
> +	}
> +
>  	for_each_umc(i) {
>  		if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
>  			ecc_en &=3D !!(pvt->umc[i].umc_cap_hi & UMC_ECC_ENABLED); @@ -4292,7=
=20
> +4415,11 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci) =20
> {
>  	struct amd64_pvt *pvt =3D mci->pvt_info;
> =20
> -	mci->mtype_cap		=3D MEM_FLAG_DDR2 | MEM_FLAG_RDDR2;
> +	if (pvt->is_noncpu)
> +		mci->mtype_cap =3D MEM_FLAG_HBM2;
> +	else
> +		mci->mtype_cap =3D MEM_FLAG_DDR2 | MEM_FLAG_RDDR2;
> +
>  	mci->edac_ctl_cap	=3D EDAC_FLAG_NONE;
> =20
>  	if (pvt->umc) {
> @@ -4397,11 +4524,25 @@ static struct amd64_family_type *per_family_init(=
struct amd64_pvt *pvt)
>  			fam_type =3D &family_types[F17_M70H_CPUS];
>  			pvt->ops =3D &family_types[F17_M70H_CPUS].ops;
>  			fam_type->ctl_name =3D "F19h_M20h";
> -			break;
> +		} else if (pvt->model >=3D 0x30 && pvt->model <=3D 0x3f) {
> +			if (pvt->is_noncpu) {
> +				int tmp =3D 0;
> +
> +				fam_type =3D &family_types[ALDEBARAN_GPUS];
> +				pvt->ops =3D &family_types[ALDEBARAN_GPUS].ops;
> +				tmp =3D pvt->mc_node_id - NONCPU_NODE_INDEX;

This can be set when you declare it.
[naveenk:] done

> +				sprintf(pvt->buf, "Aldebaran#%ddie#%d", tmp / 2, tmp % 2);
> +				fam_type->ctl_name =3D pvt->buf;
> +			} else {
> +				fam_type =3D &family_types[F19_CPUS];
> +				pvt->ops =3D &family_types[F19_CPUS].ops;
> +				fam_type->ctl_name =3D "F19h_M30h";
> +			}
> +		} else {
> +			fam_type =3D &family_types[F19_CPUS];
> +			pvt->ops =3D &family_types[F19_CPUS].ops;
> +			family_types[F19_CPUS].ctl_name =3D "F19h";
>  		}
> -		fam_type	=3D &family_types[F19_CPUS];
> -		pvt->ops	=3D &family_types[F19_CPUS].ops;
> -		family_types[F19_CPUS].ctl_name =3D "F19h";
>  		break;
> =20
>  	default:
> @@ -4454,6 +4595,30 @@ static void hw_info_put(struct amd64_pvt *pvt)
>  	kfree(pvt->umc);
>  }
> =20
> +static void populate_layers(struct amd64_pvt *pvt, struct=20
> +edac_mc_layer *layers) {
> +	if (pvt->is_noncpu) {
> +		layers[0].type =3D EDAC_MC_LAYER_CHIP_SELECT;
> +		layers[0].size =3D fam_type->max_mcs;
> +		layers[0].is_virt_csrow =3D true;
> +		layers[1].type =3D EDAC_MC_LAYER_CHANNEL;
> +		layers[1].size =3D pvt->csels[0].b_cnt;
> +		layers[1].is_virt_csrow =3D false;

This looks mostly the same as below but the sizes are different. Can't you =
keep all this together and just adjust the sizes?
[naveenk:] done

> +	} else {
> +		layers[0].type =3D EDAC_MC_LAYER_CHIP_SELECT;
> +		layers[0].size =3D pvt->csels[0].b_cnt;
> +		layers[0].is_virt_csrow =3D true;
> +		layers[1].type =3D EDAC_MC_LAYER_CHANNEL;
> +		/*
> +		 * Always allocate two channels since we can have setups with
> +		 * DIMMs on only one channel. Also, this simplifies handling
> +		 * later for the price of a couple of KBs tops.
> +		 */
> +		layers[1].size =3D fam_type->max_mcs;
> +		layers[1].is_virt_csrow =3D false;
> +	}
> +}
> +
>  static int init_one_instance(struct amd64_pvt *pvt)  {
>  	struct mem_ctl_info *mci =3D NULL;
> @@ -4469,19 +4634,8 @@ static int init_one_instance(struct amd64_pvt *pvt=
)
>  	if (pvt->channel_count < 0)
>  		return ret;
> =20
> -	ret =3D -ENOMEM;
> -	layers[0].type =3D EDAC_MC_LAYER_CHIP_SELECT;
> -	layers[0].size =3D pvt->csels[0].b_cnt;
> -	layers[0].is_virt_csrow =3D true;
> -	layers[1].type =3D EDAC_MC_LAYER_CHANNEL;
> -
> -	/*
> -	 * Always allocate two channels since we can have setups with DIMMs on
> -	 * only one channel. Also, this simplifies handling later for the price
> -	 * of a couple of KBs tops.
> -	 */
> -	layers[1].size =3D fam_type->max_mcs;
> -	layers[1].is_virt_csrow =3D false;
> +	/* Define layers for CPU and NONCPU nodes */
> +	populate_layers(pvt, layers);
> =20
>  	mci =3D edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);
>  	if (!mci)
> @@ -4525,6 +4679,9 @@ static int probe_one_instance(unsigned int nid)
>  	struct ecc_settings *s;
>  	int ret;
> =20
> +	if (!F3)
> +		return -EINVAL;
> +

Why is this needed?
[naveenk:] make sense, returning 0 instead.

>  	ret =3D -ENOMEM;
>  	s =3D kzalloc(sizeof(struct ecc_settings), GFP_KERNEL);
>  	if (!s)
> @@ -4536,6 +4693,9 @@ static int probe_one_instance(unsigned int nid)
>  	if (!pvt)
>  		goto err_settings;
> =20
> +	if (nid >=3D NONCPU_NODE_INDEX)
> +		pvt->is_noncpu =3D true;
> +
>  	pvt->mc_node_id	=3D nid;
>  	pvt->F3 =3D F3;
> =20
> @@ -4609,6 +4769,10 @@ static void remove_one_instance(unsigned int nid)
>  	struct mem_ctl_info *mci;
>  	struct amd64_pvt *pvt;
> =20
> +	/* Nothing to remove for the space holder entries */
> +	if (!F3)
> +		return;
> +
>  	/* Remove from EDAC CORE tracking list */
>  	mci =3D edac_mc_del_mc(&F3->dev);
>  	if (!mci)
> @@ -4682,7 +4846,7 @@ static int __init amd64_edac_init(void)
> =20
>  	for (i =3D 0; i < amd_nb_num(); i++) {
>  		err =3D probe_one_instance(i);
> -		if (err) {
> +		if (err && (err !=3D -EINVAL)) {

If the !F3 condition above is "okay", why not just return 0 (success)?
[naveenk:] done

>  			/* unwind properly */
>  			while (--i >=3D 0)
>  				remove_one_instance(i);
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h=20
> index 85aa820bc165..6d5f7b3afc83 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -126,6 +126,8 @@
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F6 0x1446
>  #define PCI_DEVICE_ID_AMD_19H_DF_F0	0x1650
>  #define PCI_DEVICE_ID_AMD_19H_DF_F6	0x1656
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F0	0x14D0
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F6	0x14D6
>=20

These are correct.

>  /*
>   * Function 1 - Address Map
> @@ -298,6 +300,7 @@ enum amd_families {
>  	F17_M60H_CPUS,
>  	F17_M70H_CPUS,
>  	F19_CPUS,
> +	ALDEBARAN_GPUS,
>  	NUM_FAMILIES,
>  };
> =20
> @@ -389,6 +392,9 @@ struct amd64_pvt {
>  	enum mem_type dram_type;
> =20
>  	struct amd64_umc *umc;	/* UMC registers */
> +	char buf[20];
> +
> +	u8 is_noncpu;

Can this be a "bool"?
[naveenk:] done

>  };
> =20
>  enum err_codes {
> @@ -410,6 +416,27 @@ struct err_info {
>  	u32 offset;
>  };
> =20
> +static inline u32 get_noncpu_umc_base(u8 umc, u8 channel) {
> +	/*
> +	 * On the NONCPU nodes, base address is calculated based on
> +	 * UMC channel and the HBM channel.
> +	 *
> +	 * UMC channels are selected in 6th nibble
> +	 * UMC chY[3:0]=3D [(chY*2 + 1) : (chY*2)]50000;
> +	 *
> +	 * HBM channels are selected in 3rd nibble
> +	 * HBM chX[3:0]=3D [Y  ]5X[3:0]000;
> +	 * HBM chX[7:4]=3D [Y+1]5X[3:0]000
> +	 */
> +	umc *=3D 2;
> +
> +	if (channel / 4)

Can this be "if (channel >=3D 4)"?
[naveenk:] done

> +		umc++;
> +
> +	return 0x50000 + (umc << 20) + ((channel % 4) << 12); }
> +
>  static inline u32 get_umc_base(u8 channel)  {
>  	/* chY: 0xY50000 */
> --

There are a lot of changes in this patch. I think you should give the highl=
ights in the commit message. For example, you may want to say if you introd=
uced new functions, changed code flow, etc., and why this is needed compare=
d to existing systems. I think the code comments have some details, but a s=
ummary in the commit message may help.
[naveenk:] Updated the commit message to reflect the changes.

Thanks,
Yazen
[naveenk:] Thank you
