Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0744A47332D
	for <lists+linux-edac@lfdr.de>; Mon, 13 Dec 2021 18:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbhLMRrH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Dec 2021 12:47:07 -0500
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com ([40.107.237.42]:51680
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238326AbhLMRrG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 13 Dec 2021 12:47:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5hlZII1pqC1/Ua+KZj7nYFRwA2ObqODau+X6+JANnubr8jtV8NBIcDWieaXoMznYd1We8VNrCOcanwo1H+DDnr1dtQ40SXU2fpUk9sp/i5mkB5lWsYYn2vJUUXtoB+300SMSRpU7+4tiDt+2B/L2+9JGhxQgmWK0gZ0ZAShNX/jbVR88hGaelkzw0WuFCDKoL7PLe9VzcaK7+ckQxQW5L2oU2pi1DzyzkmAadRfXDNQ4Ue+XIkJ/ZPcsgZFn92PFxlI96/dPseDi6ND1+yJ4Uvwscz/uhXOg0Ke5GZ3WR1jIgDxvvEYxb/yLtQZ4JvMiQDvlGaBdQ68hAdKaUx/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaQ6bgckXgTXpuTktyB/0b4IGn8AYC2ObARb7Cn+vWk=;
 b=I5FmBiD7ukyjlsAyNb4WEqjYDnT7OeJKYfcv2OTeLkl3fxPd4zJvvmnpY9K+KzZNXPqXVZvRHYxacFAXfSENJ/9TdPymBaicX0F2r9xiRuxkVkgas+kkx46KeI8ECl8ga0xtqOKghUYAeiJw4DRNWV49HKhNVLrfa1T5zplHsfmYUBcO8KUnXbazBLHnVm+o0oZZW0SjQiqm8aPcTE5O3QY+6AIHp5yOjevjjjpCkUKY9ur7Afzy8teH0RDQZS3OEoN4u891f4avaQQDc3V2kTuTj0zVnrbG2nlbuo7bXc2Q+aseQqK/3P1iY7AQDKR8olGacC2NoSp0TVUB26QjCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaQ6bgckXgTXpuTktyB/0b4IGn8AYC2ObARb7Cn+vWk=;
 b=DlollWFYKRJy5R1KsSZVBMWypP3u4pXXUzL3kxZ1+mbuiaPWL9hTs9WRuNzK5sHQYVnwTByy1VCIPgedzKluXFo5VnQHgrEK/58xO0y6h6KZN2OHBIO5el+3A6lbvPHWw00c4RWWwcRtcJBJvAISrBIWHHNRpume3SeX6ibBVHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3442.namprd12.prod.outlook.com (2603:10b6:408:43::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Mon, 13 Dec
 2021 17:47:04 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a192:7073:258c:28b3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a192:7073:258c:28b3%6]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 17:47:04 +0000
Date:   Mon, 13 Dec 2021 17:46:55 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com,
        william.roche@oracle.com
Subject: Re: [PATCH 4/4] EDAC/amd64: Add DDR5 support and related register
 changes
Message-ID: <YbeHD5PW0sv4O13r@yaz-ubuntu>
References: <20211208174356.1997855-1-yazen.ghannam@amd.com>
 <20211208174356.1997855-5-yazen.ghannam@amd.com>
 <YbNK9jV06al93XDN@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbNK9jV06al93XDN@zn.tnic>
X-ClientProxiedBy: CH0PR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:610:74::16) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bce8a4b-a691-4a67-faa1-08d9be60929b
X-MS-TrafficTypeDiagnostic: BN8PR12MB3442:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB34424D607BF758A22180AE2CF8749@BN8PR12MB3442.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s54czoo3qKm6qIGPsOK2pd6WAju/QLe9GJWmfnr3mInrJ4FTJ/NKHMfqQb+QgVaAPcKyutuyJChPFQwszCtmKcmSqN2KGG36aaqQCxPBH2sxqSyTTXpQpaKyU+wZg0LtLik1hQIpwSNvuPcRFGa7TfhQCZ+omDTPej6AjI4s7BI4wOvt57wlXbqxG3/sjw1qt3pg3vyuA8LlWi4S6ccaAlVC2xPUMm3vt6iAyTpSW2FtmKnvYypdlYpJ9oy07Q/A+ubMzpea7jISYUzCxlL4T+SmTPoWjyEpHzJQDx4cjrQy7hpq+Tzm1pcRinekrStk6wWqUjfNuYXvMKeTD/rjJX9xRSGV2G7PmY+nWgIifXtkQDwNq0WedqyJqUBHSJV+hKxBSa47n4JIeSSfTsL0LHXM+BULRgZn5vNQeZ+Mq9Rky37Ki/h7TYKT4o1Vn8mPqbdJGVveHdKH4e2ELQro6Nftl5MJ7UrXbJwWEEc3vIsmfW+KG9TXqNwh8yTiPABhCngYM+wa5IgpKdMGBWIdEn0h+Mtz7YIT6beg3j8zhoxS/z30Hmk316ddTORY5TRREh/hiC+pVuveMeCp0AepkDyp9WH8D7bcRU0pWDVhZY1B76+nLj1SiHMZDmINxXLH8sr5oaV/tr8aOIsCX3TQRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(6666004)(186003)(316002)(26005)(4326008)(6916009)(6512007)(83380400001)(9686003)(38100700002)(66476007)(66946007)(33716001)(6486002)(8936002)(6506007)(2906002)(8676002)(508600001)(5660300002)(86362001)(44832011)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kn9SeSEICjj0t49gDtBSlBhHPf/NQXT+1kRuj8BEVhLxhVakcpRLuZAtXUiS?=
 =?us-ascii?Q?+qN40W16TnRUJs7b5S5MqYqFp8S3hOz3Y/DcBejLj7uiCVHAGc/KmEo6YgKG?=
 =?us-ascii?Q?Vbpqen2e5OhCq54v0+5ikkyWPAtwweX7g4nx1vkTpcfaFHeEaRA0vhObnRFC?=
 =?us-ascii?Q?1vTYzLJSxsrvv6xNDoxGp4WrbJnMyDY05eDlE6UIxMFlzimFN7qwnaEgi0QL?=
 =?us-ascii?Q?doYsXgSnr2FdTExPeeVEaE6aXgmVXimD62i+ifUQ2leozeM6D9QN1g4rgvCJ?=
 =?us-ascii?Q?xQutv4qbdi6LDHgEsZpqAH6Ies/vNjHLXIaKSnIXhCBxqTpzmQOouSIy1MK0?=
 =?us-ascii?Q?tQuD92dQzfNrgQRfoZt2TFcZbc1fBhQ0frT3/bp93kvdV5azL8PHGYmIy1me?=
 =?us-ascii?Q?vkxzDAfeUyc/BnPkN/rTeB3B/egPgJvJ/hWjyvEwoLyZZawZOmoPa+9dBc+o?=
 =?us-ascii?Q?DCPPYS6iQrY6c0chMOPkgKDne7Qf/lDGHjHyX4GhpZqtOtVEkjNx9a2OPn/b?=
 =?us-ascii?Q?9a3dZEhuS3DOfohiDuH3awPe+9K6g9ZWsm9FwAEobvGhk++Aj1FS+xWfSRra?=
 =?us-ascii?Q?g4ig8WlskE/XxamDJBPJ2c5IuIDlos/JjRAz7DmmhkUEwLqsBld0F5EMxDq1?=
 =?us-ascii?Q?dYt9ivtugHY/D47aWqxd27z4hSZNHszxawdpsgcL6bMdFTVTiJ9ZZJVJfDzU?=
 =?us-ascii?Q?/vFWvmbkkdE9sHowfhHXHYX6QTsKv+8gQSX21CzWJGvQtuI/D4wUk8X4RsaP?=
 =?us-ascii?Q?ClAVM7eHM9oEHH0TBYSGl3C6/UaojxA83wra/HqjH5s2VV3djVmhNxCa7b6a?=
 =?us-ascii?Q?SRcoug9lMsa+ETL7Nc7XGI/v0DnTEkiV085PedYDRrOVIGht5LtP6+QknHAF?=
 =?us-ascii?Q?ubhHY9SMJPNsgDdPQ72XWpynvLlIvYA2kUoOdvuJsq5AsdAehSgojIZKpljn?=
 =?us-ascii?Q?94M/G+fpgHZavGqv6EPDZAUjR+TXLMKnUQ7py9QoLhVNK8HORrhZBlF9BLEY?=
 =?us-ascii?Q?vFlkqVR2cX9TQO27EDQTKwXMbgcTqY1CgYR/e5EXBR9riwGXyA0OvFn4ocPv?=
 =?us-ascii?Q?sz+CVoDmpzct5k+8Opm338CUYvFhh4haesj+7YmKMBYsJalAxN+nWViu+g1G?=
 =?us-ascii?Q?pwXQRI9ul1M+7wS+BVC4Y1+ex44GKyutU9K0oHpO9WuM570h4Ztp/JIgDCyv?=
 =?us-ascii?Q?n8ueAyM7+n8l+XvDlxQ+ZfSuu3t3An6oF3QEL6VzHez/5TBdwKJJsfiYvbP+?=
 =?us-ascii?Q?2BDIgCitXRl8iJKAy2P/7fQSFx+APyY/hGyyBkxTjsfXgyv14KnYoW121MrL?=
 =?us-ascii?Q?PCjnsfZlAStVHygYlZ6V+aTlPuigj4HT/tecSEo1536QlZrnA/11GH3TB7tK?=
 =?us-ascii?Q?50J00wkL1NPoEWtOK0DQO7wp6I2mlQoU78ay9kltct35o8TPumXs11/o49Bn?=
 =?us-ascii?Q?ilB/Sv3NQ4RpdN8pDq3MwEEHhPUQqI60T8NFn3Ovplj4jLjPkJPmdUg4xz4+?=
 =?us-ascii?Q?1WaPvOYmn3y6SYvmz6tqjyRrs/PemEFv20wINCsXKRmD8OM/cWoG5T4HukvT?=
 =?us-ascii?Q?i4UWJSWqakQW9zmfW/VfRmnANq+nM0S1UpMPx5BZmkl7GZ0wuwcN9NcgDKFT?=
 =?us-ascii?Q?LDTFEFX7poAZaXLg28nZrvA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bce8a4b-a691-4a67-faa1-08d9be60929b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 17:47:03.7969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZLtcwmfyqChwp3IEr3IgTkMZw7iNOWNYGBEPpOuvbGqdtLIZbayr9bbE3NqZeh8dV19ZrnRYqdYyzt8k9jv5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3442
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Dec 10, 2021 at 01:41:26PM +0100, Borislav Petkov wrote:
> On Wed, Dec 08, 2021 at 05:43:56PM +0000, Yazen Ghannam wrote:
> > Future AMD systems will support DDR5.
> > 
> > Add support for changes in register addresses for these systems.
> > 
> > Introduce a "family flags" bitmask that can be used to indicate any
> > special behavior needed on a per-family basis.
> > 
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> >  drivers/edac/amd64_edac.c | 61 +++++++++++++++++++++++++++++++++++----
> >  drivers/edac/amd64_edac.h | 11 +++++++
> >  2 files changed, 66 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> > index 1df763128483..e37a8e0cef7e 100644
> > --- a/drivers/edac/amd64_edac.c
> > +++ b/drivers/edac/amd64_edac.c
> > @@ -15,6 +15,36 @@ static struct msr __percpu *msrs;
> >  
> >  static struct amd64_family_type *fam_type;
> >  
> > +/* Family flag helpers */
> > +static inline bool has_ddr5(void)
> > +{
> > +	return fam_type->flags.has_ddr5;
> 
> A flag about ddr5 *and* a function of the same name. Kinda too much,
> don't ya think?
>

Yeah, you're right. I didn't think about that. I think I'll drop this function
and just check the flag directly.
 
> > @@ -1628,6 +1660,17 @@ static void determine_memory_type(struct amd64_pvt *pvt)
> >  			dimm_cfg |= pvt->umc[i].dimm_cfg;
> >  		}
> >  
> > +		/* Check if system supports DDR5 and has DDR5 DIMMs in use. */
> > +		if (has_ddr5() && (umc_cfg & BIT(0))) {
> > +			if (dimm_cfg & BIT(5))
> > +				pvt->dram_type = MEM_LRDDR5;
> > +			else if (dimm_cfg & BIT(4))
> > +				pvt->dram_type = MEM_RDDR5;
> > +			else
> > +				pvt->dram_type = MEM_DDR5;
> > +			return;
> > +		}
> > +
> >  		if (dimm_cfg & BIT(5))
> >  			pvt->dram_type = MEM_LRDDR4;
> >  		else if (dimm_cfg & BIT(4))
> > @@ -2174,8 +2217,13 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
> >  	 * There is one mask per DIMM, and two Chip Selects per DIMM.
> >  	 *	CS0 and CS1 -> DIMM0
> >  	 *	CS2 and CS3 -> DIMM1
> > +	 *
> > +	 *	Systems with DDR5 support have one mask per Chip Select.
> >  	 */
> > -	dimm = csrow_nr >> 1;
> > +	if (has_ddr5())
> > +		dimm = csrow_nr;
> > +	else
> > +		dimm = csrow_nr >> 1;
> >  
> >  	/* Asymmetric dual-rank DIMM support. */
> >  	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
> > @@ -2937,6 +2985,7 @@ static struct amd64_family_type family_types[] = {
> >  		.f0_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F0,
> >  		.f6_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F6,
> >  		.max_mcs = 12,
> > +		.flags.has_ddr5 = 1,
> 
> So judging by the name, this means that model 0x10 has DDR5. But I think
> you wanna say whether it supports DDR5 or not?
> 
> Or does M10 support DDR5 only?
> 
> But it doesn't look like it from the comment above:
> 
> 	"Check if system supports DDR5 and has DDR5 DIMMs in use."
> 
> So why is this thing set statically only for this model instead of
> detecting from the hw whether there are ddr5 or ddr5 DIMMs and what it
> supports?
> 
> And then you can use the defines you just added in patch 1.
> 
> I'm confused.
>

Yeah, sorry it's not clear. The purpose of the flag is to indicate some minor
changes that show up with future systems like register offsets changes, etc. I
didn't want to tie the name to a specific model or core name. I went with DDR5
as a new feature that shows up with these changes, but they're not directly
tied to DDR5.

But yes, a system may support DDR5 and DDR4. And this can be detected from the
hardware.

What do you think about calling the flag "uses_f19h_m10h_offsets" or something
like that? I was trying to avoid family/model in the name, but the code
already does this all over. And the convention has been to call something by
the first family/model where it shows up.

Thanks,
Yazen
