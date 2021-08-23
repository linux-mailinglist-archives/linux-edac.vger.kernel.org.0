Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595F13F4ECD
	for <lists+linux-edac@lfdr.de>; Mon, 23 Aug 2021 18:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhHWQ5T (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Aug 2021 12:57:19 -0400
Received: from mail-dm6nam08on2060.outbound.protection.outlook.com ([40.107.102.60]:17888
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229479AbhHWQ5O (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Aug 2021 12:57:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLReqChbr1ORZY/grXN0psgZxmeO/GP71o0t8mmWlB19Vs7s62FDRpcbZSh9jxSEocMPI3wNmnpekg3EBoz4Fd2VEdyzoAazfwhotHzPSaUIlQqkUfGdeoR/WM3xzATE2y6PG0ESQmEslDAwdvkW8pQeBQ9GQqIYvK3XfwGTeL3axJPOg+XTvct/ZoA3Rox/ajfHZuqmFfeIBkMhRD/B0cFsg51fYb1rOekz5hoyCWIEs8bqRCxSphWrmeWJan9UDtiTqgJrxXTOdyW2doA3NlORIqY795NbK1PMArLcKNZXxTDiNLLe/fSUsfCjcRK30qGGm6U/MUsHzrXi4yVx2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiD+iniubdr+a4gzMGIstuq91kAEgwemSdPQ50tPTGU=;
 b=MCVW+rNb3BLpZUo1uXvdrXgVbDKcw+lnwZcmFFqcktVStqdh8IjvlFOCGeTRuDvD8CegehglW/dGR4TFb812EPYpeTC5jHwrvOAbhxVtQR9Zd3yOqAOFlmDK0UmeBzUbbEpzTBQJ8nKl5M64mavFDDqgMdkJYRYp5uPs2XbvYb605BCeNXxwdWjosHum++qNNia9uMGC4PzLVpbR2ZUc58KVPrvpyBcL5Mdwuu0dd3CRbEKZz602dzaMufFRIYNgCqh+ypOG1rup2frqoitGLEmJIZixpk565ILF26LSwMB8lfBfbXluoCGsovUvfickqZoTgTnHDAnpHmgAWfoZLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiD+iniubdr+a4gzMGIstuq91kAEgwemSdPQ50tPTGU=;
 b=AE43sKObmAP33Xm3nlYRvjCM7SjO+KlnEGLBqT44WsnGERmLfegtHV+arJG1iU2IfCTg9LvtmykzrjdrIDr1Vpd1EQgdwHaKfXXn8cGIajbdaXrPCIaVhWHXVcVGHpzaVICQe5FDE63T3zpurdHP+mMnw87iqPFbCF3/qx1Wfpw=
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL1PR12MB5222.namprd12.prod.outlook.com (2603:10b6:208:31e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Mon, 23 Aug
 2021 16:56:29 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::38e0:44fb:fbfb:c8d2]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::38e0:44fb:fbfb:c8d2%9]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 16:56:29 +0000
From:   "Chatradhi, Naveen Krishna" <NaveenKrishna.Chatradhi@amd.com>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "M K, Muralidhara" <Muralidhara.MK@amd.com>
Subject: RE: [PATCH v2 3/3] EDAC/amd64: Enumerate memory on noncpu nodes
Thread-Topic: [PATCH v2 3/3] EDAC/amd64: Enumerate memory on noncpu nodes
Thread-Index: AQHXipFJ4NZ5KPQPXUu+RS45KunXiat8tRwAgAS0cIA=
Date:   Mon, 23 Aug 2021 16:56:29 +0000
Message-ID: <BL1PR12MB52868457F38AB1F616F95F8CE8C49@BL1PR12MB5286.namprd12.prod.outlook.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
 <20210806074350.114614-1-nchatrad@amd.com>
 <20210806074350.114614-4-nchatrad@amd.com> <YR/gFuvMYnqDb95u@yaz-ubuntu>
In-Reply-To: <YR/gFuvMYnqDb95u@yaz-ubuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5249e05-76b8-487f-91b7-08d96656f401
x-ms-traffictypediagnostic: BL1PR12MB5222:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB522288A0131A059D338505F1E8C49@BL1PR12MB5222.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IJ5RS7px+djKloQgztBpzKdwS+plFKPEJDCRjwBUyhVMUsQ1/jnf03YVfAT9xcIBig3AY2stiI5uEk5kxtunlyshccGlKdUpcbALxcCZIBlPCch9UqpRX1ffuhB2lWfY9OmbkOV8KjiX9qEZnCaZ/2rCOKrqQNhORUys7xHLxcdWSzOBnOabBSCtj8prpO7C5Nml+pP8G8QGtTRRFs5H1Mh1utfqrHbbhl055j7DavwfONAz6gvxcXt5aoKxn0AzDM1KulYMg6fKDbyB2m8yGl+6per+daDAzLf56OJWQhI6YBK/EU03ZpjducJTlZjxTHcHCLia3RJjs/7wqbSn6q/bTcuLnFj7cR1hjw4N68RZBaxG1JKrpS3/Ii2xpnHY54+hTuSgK2S92Y8AA/LB/a1og69AAXf50fs8Nv5EblVBQriSjBozhUJYQxlbO+GioT5bL1fQLCgZtDGQ4H995gE0QcvCDBqWpbcKDY5lK4pZC/1/CKtiSyX3umLwb6mq1jF2Z3In1T/oc3ysTyiVCET2IbQsUcWuJV1GihI48Anvj96NmIlw2RnUTQlDYhkkEkatwAr4eAj91bIufgFxWrP2fYr9cc9DZ+lWyGioI1yHE+imRuF82IdzxmclOWH28P8yigzsVrCCYqcyNCArrAhsIFWg87r94SA6xfShhV2RdBPlKqTcAjCTD5oZkdVQqKojP0UpH+UDaXE9sQj1Qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(66476007)(66946007)(64756008)(66446008)(76116006)(54906003)(38100700002)(186003)(478600001)(8936002)(86362001)(66556008)(8676002)(53546011)(26005)(2906002)(4326008)(6862004)(9686003)(71200400001)(316002)(33656002)(5660300002)(52536014)(38070700005)(7696005)(6636002)(6506007)(83380400001)(30864003)(55016002)(122000001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0luAjMA1YX8HMck2ZDOSC04F7FRf8R1CRjK+zpdJCYx++RSJAGSf1+Oh1GP/?=
 =?us-ascii?Q?vvSPr6FtC4KSc01zVREf75VWVhte280ux5cTZWw7tEVreqf8uRxoCTLCmWnm?=
 =?us-ascii?Q?26OW/JSP5z0KZ87bz57CWM/cyP6j8vsw5j7600wE8yvV3yRGhFAd7LIkcuiV?=
 =?us-ascii?Q?BNzNhHqEpWO8HcxIPMyY0e9lMQes5AQwaBCL+utIxRBGei9PrjfyUTUG+yVx?=
 =?us-ascii?Q?2l85uOaXGVCbalp5RddfWXOe4xMnJXwir3cd6MT1t4uITmSEsHZAOwxkvtK6?=
 =?us-ascii?Q?rA/UdBxJMMv1qnUr0j8Iz3ExPQk0DjA3Eyv4c3JV6fu+MWnOJGCVGID27e69?=
 =?us-ascii?Q?3UcexwXnu4M+xN1uTGJiPAmqBBgOHEiajWkZnlywjWkLma3pjUO0mLY2uJp8?=
 =?us-ascii?Q?P1ZVXgrhlBYHLy4UpBkTfFH7j4HKKhqcA1hN0uuyhr+cHqJPdRMh0ddnFSYF?=
 =?us-ascii?Q?737cR8Uuu7LiQHdlQ5vf2qqou0ZczgO+Ly77rPUCJ01F19n6sllsnPCdVlpA?=
 =?us-ascii?Q?61ji45mX+r+iUF1RhRXol7CPnRumRtcg+aYJC+g/O/UbCHZqSmvFkRZmMork?=
 =?us-ascii?Q?5xyC8oquJWddGRPADTgEtBnJ1aWbtvpQrdWg9KsrbVNDDCRdhC9rSIqYl0iy?=
 =?us-ascii?Q?sg5bu7YOR5129Zdm2609z1/poKWe+9/6RpIAWwWGbGBYyR8WycSQJOJwDoJF?=
 =?us-ascii?Q?BOWhz2lO3jxsjZaD7QpUMcTzeAiUAu75/e59H2kPx3/TvwUD1eowQpdd9kaM?=
 =?us-ascii?Q?lSnhInhFYoVghH4mo/UZEeJy9MS9EpDub1pcWixsP/BYzwsWeBFOW/kqpBRS?=
 =?us-ascii?Q?TfMh21bVJFTQZ22EBnqHIIOgrJJGrcHFGNnprhD5CLskYSu2WXpKtNIkXd+/?=
 =?us-ascii?Q?uGNnfPKIkTlTBYA4wrBKPQ0CziFTd/QH414TcKYRS6VfrJjoogvhTdfgcbsQ?=
 =?us-ascii?Q?Fs6Whn8emkyoxPcdPaAHyyZI8GXBXDnxzwEKo6VpKXaBpNJcMbzFP0tt3Sih?=
 =?us-ascii?Q?5NKSt0Vm7F98r7ij48FZVhjVMJ5MtySRNwOAZpmKylAQLcpbVzxp4ZKEo7Xq?=
 =?us-ascii?Q?W1GdT9WiFhmgsXI1medX3V+8G2mex4o1dPhy/jmw7SAHP9Qx0aBJy6idRAKZ?=
 =?us-ascii?Q?n32uqItlUhgQh+TP/jWTe+3qmxAgm3dViLMyUVFiEqmfDQU/w3YQ/8Ud0Toc?=
 =?us-ascii?Q?V3W9junfUNf4UoCP1lkODsMztE8QXpi2cdJwyuA0fFDLUMMIh2avPkC+fUuJ?=
 =?us-ascii?Q?YUBumkVAUL0wdUYRDHYnFqHSCwRoD9hEbWe0nasTIh60J8I6ysMRgaD+4Ny9?=
 =?us-ascii?Q?VSS4fKNku+R/J1stffWFObtd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5249e05-76b8-487f-91b7-08d96656f401
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 16:56:29.5265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VrskmAMGTYM/mZF5otkF1ffKSeWB5/6U26fgyyi1nvxfxvg8DD3veYqPkwvVuakNBlhR4XRFdUt7aFIM2DLU/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5222
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Yazen,

Will address your comments and send the next version. Thank you.

Regards,
Naveenk

-----Original Message-----
From: Ghannam, Yazen <Yazen.Ghannam@amd.com>=20
Sent: Friday, August 20, 2021 10:32 PM
To: Chatradhi, Naveen Krishna <NaveenKrishna.Chatradhi@amd.com>
Cc: linux-edac@vger.kernel.org; x86@kernel.org; linux-kernel@vger.kernel.or=
g; mchehab@kernel.org; M K, Muralidhara <Muralidhara.MK@amd.com>
Subject: Re: [PATCH v2 3/3] EDAC/amd64: Enumerate memory on noncpu nodes

On Fri, Aug 06, 2021 at 01:13:50PM +0530, Naveen Krishna Chatradhi wrote:
> On newer heterogeneous systems from AMD with GPU nodes interfaced with=20
> HBM2 memory are connected to the CPUs via custom links.
>

This sentence is not clear to me.
=20
> This patch modifies the amd64_edac module to handle the HBM memory=20
> enumeration leveraging the existing edac and the amd64 specific data=20
> structures.
>=20
> This patch does the following for non-cpu nodes:
> 1. Define PCI IDs and ops for Aldeberarn GPUs in family_types array.
> 2. The UMC Phys on GPU nodes are enumerated as csrows and the UMC channel=
s
>    connected to HBMs are enumerated as ranks.
> 3. Define a function to find the UMCv2 channel number 4. Define a=20
> function to calculate base address of the UMCv2 registers 5. Add debug=20
> information for UMCv2 channel registers.
>

I don't think you need to say "This patch does..." and give a list. Just wr=
ite each point as a line in the commit message.
=20
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
> Changes since v1:
> 1. Modifed the commit message
> 2. Change the edac_cap
> 3. kept sizes of both cpu and noncpu together 4. return success if the=20
> !F3 condition true and remove unnecessary validation 5. declared=20
> is_noncpu as bool 6. modified the condition from channel/4 to=20
> channel>=3D4 7. Rearranged debug information for noncpu umcch registers
>=20
>  drivers/edac/amd64_edac.c | 202=20
> +++++++++++++++++++++++++++++++++-----
>  drivers/edac/amd64_edac.h |  27 +++++
>  2 files changed, 202 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c=20
> index b03c33240238..2dd77a828394 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -1979,6 +1979,9 @@ static unsigned long determine_edac_cap(struct=20
> amd64_pvt *pvt)
> =20
>  		if (umc_en_mask =3D=3D dimm_ecc_en_mask)
>  			edac_cap =3D EDAC_FLAG_SECDED;
> +
> +		if (pvt->is_noncpu)
> +			edac_cap =3D EDAC_FLAG_SECDED;
>  	} else {
>  		bit =3D (pvt->fam > 0xf || pvt->ext_model >=3D K8_REV_F)
>  			? 19
> @@ -2037,6 +2040,9 @@ static int f17_get_cs_mode(int dimm, u8 ctrl,=20
> struct amd64_pvt *pvt)  {
>  	int cs_mode =3D 0;
> =20
> +	if (pvt->is_noncpu)
> +		return CS_EVEN_PRIMARY | CS_ODD_PRIMARY;
> +
>  	if (csrow_enabled(2 * dimm, ctrl, pvt))
>  		cs_mode |=3D CS_EVEN_PRIMARY;
> =20
> @@ -2056,6 +2062,15 @@ static void debug_display_dimm_sizes_df(struct=20
> amd64_pvt *pvt, u8 ctrl)
> =20
>  	edac_printk(KERN_DEBUG, EDAC_MC, "UMC%d chip selects:\n", ctrl);
> =20
> +	if (pvt->is_noncpu) {
> +		cs_mode =3D f17_get_cs_mode(cs0, ctrl, pvt);
> +		for_each_chip_select(cs0, ctrl, pvt) {
> +			size0 =3D pvt->ops->dbam_to_cs(pvt, ctrl, cs_mode, cs0);
> +			amd64_info(EDAC_MC ": %d: %5dMB\n", cs0, size0);
> +		}
> +		return;
> +	}
> +
>  	for (dimm =3D 0; dimm < 2; dimm++) {
>  		cs0 =3D dimm * 2;
>  		cs1 =3D dimm * 2 + 1;
> @@ -2080,10 +2095,15 @@ static void __dump_misc_regs_df(struct amd64_pvt =
*pvt)
>  		umc_base =3D get_umc_base(i);
>  		umc =3D &pvt->umc[i];
> =20
> -		edac_dbg(1, "UMC%d DIMM cfg: 0x%x\n", i, umc->dimm_cfg);
> +		if (!pvt->is_noncpu)
> +			edac_dbg(1, "UMC%d DIMM cfg: 0x%x\n", i, umc->dimm_cfg);
>  		edac_dbg(1, "UMC%d UMC cfg: 0x%x\n", i, umc->umc_cfg);
>  		edac_dbg(1, "UMC%d SDP ctrl: 0x%x\n", i, umc->sdp_ctrl);
>  		edac_dbg(1, "UMC%d ECC ctrl: 0x%x\n", i, umc->ecc_ctrl);
> +		if (pvt->is_noncpu) {
> +			edac_dbg(1, "UMC%d All HBMs support ECC: yes\n", i);
> +			goto dimm_size;
> +		}
> =20
>  		amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_ECC_BAD_SYMBOL, &tmp);
>  		edac_dbg(1, "UMC%d ECC bad symbol: 0x%x\n", i, tmp); @@ -2108,6=20
> +2128,7 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
>  					i, 1 << ((tmp >> 4) & 0x3));
>  		}
> =20
> + dimm_size:
>  		debug_display_dimm_sizes_df(pvt, i);
>  	}
> =20
> @@ -2175,10 +2196,14 @@ static void prep_chip_selects(struct amd64_pvt *p=
vt)
>  		pvt->csels[0].m_cnt =3D pvt->csels[1].m_cnt =3D 2;
>  	} else if (pvt->fam >=3D 0x17) {
>  		int umc;
> -

This looks like a stray change. Was it intentional?

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
> @@ -2187,6 +2212,31 @@ static void prep_chip_selects(struct amd64_pvt *pv=
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

There should be {} here since the code spans multiple lines.

> +			mask_reg =3D get_noncpu_umc_base(umc, cs) + UMCCH_ADDR_MASK;
> +			mask =3D &pvt->csels[umc].csmasks[cs];
> +
> +			if (!amd_smn_read(pvt->mc_node_id, mask_reg, mask))
> +				edac_dbg(0, "  DCSM%d[%d]=3D0x%08x reg: 0x%x\n",
> +					 umc, cs, *mask, mask_reg);

Same as above.

> +		}
> +	}
> +}
> +
>  static void read_umc_base_mask(struct amd64_pvt *pvt)  {
>  	u32 umc_base_reg, umc_base_reg_sec;
> @@ -2247,8 +2297,12 @@ static void read_dct_base_mask(struct amd64_pvt=20
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
> @@ -2294,6 +2348,10 @@ static void determine_memory_type(struct amd64_pvt=
 *pvt)
>  	u32 dram_ctrl, dcsm;
> =20
>  	if (pvt->umc) {
> +		if (pvt->is_noncpu) {
> +			pvt->dram_type =3D MEM_HBM2;
> +			return;
> +		}

Needs a newline here.

>  		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
>  			pvt->dram_type =3D MEM_LRDDR4;
>  		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4)) @@=20
> -2683,7 +2741,10 @@ static int f17_early_channel_count(struct=20
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
> @@ -2824,6 +2885,12 @@ static int f17_addr_mask_to_cs_size(struct amd64_p=
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
> @@ -2849,6 +2916,7 @@ static int f17_addr_mask_to_cs_size(struct amd64_pv=
t *pvt, u8 umc,
>  	else
>  		addr_mask_orig =3D pvt->csels[umc].csmasks[dimm];
> =20
> + skip_noncpu:
>  	/*
>  	 * The number of zero bits in the mask is equal to the number of bits
>  	 * in a full mask minus the number of bits in the current mask.
> @@ -3594,6 +3662,16 @@ static struct amd64_family_type family_types[] =3D=
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
> @@ -3849,6 +3927,19 @@ static int find_umc_channel(struct mce *m)
>  	return (m->ipid & GENMASK(31, 0)) >> 20;  }
> =20
> +/*
> + * The HBM memory managed by the UMCCH of the noncpu node
> + * can be calculated based on the [15:12]bits of IPID as follows

This comment doesn't make sense to me.

Maybe it'll help to give some more context. The CPUs have one channel per U=
MC, so a UMC number is equivalent to a channel number. The GPUs have 8 chan=
nels per UMC, so the UMC number no longer works as a channel number. The ch=
annel number within a GPU UMC is given in MCA_IPID[15:12].
However, the IDs are split such that two UMC values go to one UMC, and the =
channel numbers are split in two groups of four.

For example,
UMC0 CH[3:0] =3D 0x0005[3:0]000
UMC0 CH[7:4] =3D 0x0015[3:0]000
UMC1 CH[3:0] =3D 0x0025[3:0]000
UMC1 CH[7:4] =3D 0x0035[3:0]000

> + */
> +static int find_umc_channel_noncpu(struct mce *m) {
> +	u8 umc, ch;
> +
> +	umc =3D find_umc_channel(m);
> +	ch =3D ((m->ipid >> 12) & 0xf);

Each of these can be on a single line when declared above.

Also, please leave a newline before the return.

> +	return umc % 2 ? (ch + 4) : ch;
> +}
> +
>  static void decode_umc_error(int node_id, struct mce *m)  {
>  	u8 ecc_type =3D (m->status >> 45) & 0x3; @@ -3856,6 +3947,7 @@ static=20
> void decode_umc_error(int node_id, struct mce *m)
>  	struct amd64_pvt *pvt;
>  	struct err_info err;
>  	u64 sys_addr =3D m->addr;
> +	u8 umc_num;
> =20
>  	mci =3D edac_mc_find(node_id);
>  	if (!mci)
> @@ -3868,7 +3960,17 @@ static void decode_umc_error(int node_id, struct m=
ce *m)
>  	if (m->status & MCI_STATUS_DEFERRED)
>  		ecc_type =3D 3;
> =20
> -	err.channel =3D find_umc_channel(m);
> +	if (pvt->is_noncpu) {
> +		/* The UMCPHY is reported as csrow in case of noncpu nodes */
> +		err.csrow =3D find_umc_channel(m) / 2;
> +		/* UMCCH is managing the HBM memory */
> +		err.channel =3D find_umc_channel_noncpu(m);

I don't think "UMCPHY" or "UMCCH" a clear here. Like above, more context sh=
ould help. The GPUs have one Chip Select per UMC, so the UMC number can be =
used as the Chip Select number. However, the UMC number is split in the ID =
value as mentioned above, so that's why it's necessary to divide by 2.

> +		umc_num =3D err.csrow * 8 + err.channel;

Now here "umc_num" is getting overloaded. The value in this line is not "N"=
 in UMCN, e.g. UMC0, UMC1, etc. It's an artificial value we construct to ha=
ve a global (within a GPU node) ID for each GPU memory channel.

This is used as the "DF Instance ID" input to the address translation code.=
 On CPUs this is "Channel"=3D"UMC Number"=3D"DF Instance ID". On GPUs, this=
 value is calculated according to the line above.

So I think "umc_num" should be renamed to something like "df_inst_id" to be=
 more explicit.

> +	} else {
> +		err.channel =3D find_umc_channel(m);
> +		err.csrow =3D m->synd & 0x7;
> +		umc_num =3D err.channel;
> +	}
> =20
>  	if (!(m->status & MCI_STATUS_SYNDV)) {
>  		err.err_code =3D ERR_SYND;
> @@ -3884,9 +3986,7 @@ static void decode_umc_error(int node_id, struct mc=
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
> @@ -4013,15 +4113,20 @@ static void __read_mc_regs_df(struct amd64_pvt=20
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

Another spurious line deletion?

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
> @@ -4103,7 +4208,9 @@ static void read_mc_regs(struct amd64_pvt *pvt)
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
> @@ -4191,15 +4298,21 @@ static int init_csrows_df(struct mem_ctl_info *mc=
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
> +				dimm =3D mci->csrows[cs]->channels[umc]->dimm;
> +				dimm->edac_mode =3D edac_mode;
> +				dimm->dtype =3D dev_type;
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
> @@ -4464,7 +4577,9 @@ static bool ecc_enabled(struct amd64_pvt *pvt)
> =20
>  			umc_en_mask |=3D BIT(i);
> =20
> -			if (umc->umc_cap_hi & UMC_ECC_ENABLED)
> +			/* ECC is enabled by default on NONCPU nodes */
> +			if (pvt->is_noncpu ||

Can you skip all the bitmask stuff and just say "ecc_en=3Dtrue" if on a non=
-CPU node?
[naveenk:] ecc_en is assigned only when umc_en_mask is set and is equal to =
ecc_en_mask.
	/* Check whether at least one UMC is enabled: */
	if (umc_en_mask)
		ecc_en =3D umc_en_mask =3D=3D ecc_en_mask;
	else
		edac_dbg(0, "Node %d: No enabled UMCs.\n", nid);

Since, the umc_en_mask is getting set appropriately, handling just the ecc_=
en_mask is enough to get the right ecc_en.
Setting ecc_en directly dint look nice to me. Let me know if you think othe=
rwise.

> +			    (umc->umc_cap_hi & UMC_ECC_ENABLED))
>  				ecc_en_mask |=3D BIT(i);
>  		}
> =20
> @@ -4500,6 +4615,11 @@ f17h_determine_edac_ctl_cap(struct mem_ctl_info=20
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
>  			ecc_en &=3D !!(pvt->umc[i].umc_cap_hi & UMC_ECC_ENABLED); @@ -4530,7=
=20
> +4650,11 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci) =20
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
> @@ -4635,11 +4759,24 @@ static struct amd64_family_type *per_family_init(=
struct amd64_pvt *pvt)
>  			fam_type =3D &family_types[F17_M70H_CPUS];
>  			pvt->ops =3D &family_types[F17_M70H_CPUS].ops;
>  			fam_type->ctl_name =3D "F19h_M20h";
> -			break;
> +		} else if (pvt->model >=3D 0x30 && pvt->model <=3D 0x3f) {
> +			if (pvt->is_noncpu) {
> +				int tmp =3D pvt->mc_node_id - NONCPU_NODE_INDEX;
> +
> +				fam_type =3D &family_types[ALDEBARAN_GPUS];
> +				pvt->ops =3D &family_types[ALDEBARAN_GPUS].ops;
> +				sprintf(pvt->buf, "Aldebaran#%ddie#%d", tmp / 2, tmp % 2);
> +				fam_type->ctl_name =3D pvt->buf;

I like the idea of giving unique names for each "MC". Maybe this can be use=
d on the CPU nodes too? I'll check this out. Thanks for the idea.

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
> @@ -4707,9 +4844,10 @@ static int init_one_instance(struct amd64_pvt *pvt=
)
>  	if (pvt->channel_count < 0)
>  		return ret;
> =20
> +	/* Define layers for CPU and NONCPU nodes */
>  	ret =3D -ENOMEM;
>  	layers[0].type =3D EDAC_MC_LAYER_CHIP_SELECT;
> -	layers[0].size =3D pvt->csels[0].b_cnt;
> +	layers[0].size =3D pvt->is_noncpu ? fam_type->max_mcs :=20
> +pvt->csels[0].b_cnt;
>  	layers[0].is_virt_csrow =3D true;
>  	layers[1].type =3D EDAC_MC_LAYER_CHANNEL;
> =20
> @@ -4718,7 +4856,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
>  	 * only one channel. Also, this simplifies handling later for the price
>  	 * of a couple of KBs tops.
>  	 */
> -	layers[1].size =3D fam_type->max_mcs;
> +	layers[1].size =3D pvt->is_noncpu ? pvt->csels[0].b_cnt :=20
> +fam_type->max_mcs;
>  	layers[1].is_virt_csrow =3D false;
> =20
>  	mci =3D edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);=
=20
> @@ -4763,6 +4901,9 @@ static int probe_one_instance(unsigned int nid)
>  	struct ecc_settings *s;
>  	int ret;
> =20
> +	if (!F3)
> +		return 0;
> +
>  	ret =3D -ENOMEM;
>  	s =3D kzalloc(sizeof(struct ecc_settings), GFP_KERNEL);
>  	if (!s)
> @@ -4774,6 +4915,9 @@ static int probe_one_instance(unsigned int nid)
>  	if (!pvt)
>  		goto err_settings;
> =20
> +	if (nid >=3D NONCPU_NODE_INDEX)
> +		pvt->is_noncpu =3D true;
> +
>  	pvt->mc_node_id	=3D nid;
>  	pvt->F3 =3D F3;
> =20
> @@ -4847,6 +4991,10 @@ static void remove_one_instance(unsigned int nid)
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
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h=20
> index 85aa820bc165..c5532a6f0c34 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -126,6 +126,8 @@
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F6 0x1446
>  #define PCI_DEVICE_ID_AMD_19H_DF_F0	0x1650
>  #define PCI_DEVICE_ID_AMD_19H_DF_F6	0x1656
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F0	0x14D0
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F6	0x14D6
> =20
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
> +	bool is_noncpu;
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

The wording in this comment is inaccurate. There is no "UMC channel" and "H=
BM channel". There is only "channel". On CPUs, there is one channel per UMC=
, so UMC numbering equals channel numbering. On GPUs, there are eight chann=
els per UMC, so the channel numbering is different from UMC numbering.

The notes are good overall, so I think it'll help to reference this comment=
 in amd64_edac.c where appropriate.

> +	 */
> +	umc *=3D 2;
> +
> +	if (channel >=3D 4)
> +		umc++;
> +
> +	return 0x50000 + (umc << 20) + ((channel % 4) << 12); }
> +
>  static inline u32 get_umc_base(u8 channel)  {
>  	/* chY: 0xY50000 */
> --

Thanks,
Yazen
