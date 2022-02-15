Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664764B73A0
	for <lists+linux-edac@lfdr.de>; Tue, 15 Feb 2022 17:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240206AbiBOPpd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Feb 2022 10:45:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240380AbiBOPpZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Feb 2022 10:45:25 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2080.outbound.protection.outlook.com [40.107.95.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A0212D092;
        Tue, 15 Feb 2022 07:39:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYCU2euVPhqScK1scytdeCr1gt+7Xhp90u7Tvnb7YUiwMTg7oRyc5KvoXhy972rCBPfQVz3z8M6fsfURkii3HgBkg9iiOeDNO5ufhBUVD3dcazAz8CHF21xwcJARgcmqie5mvpnMvG5gBx5jIXyYFN3oc/zGM4uBUsHxzjbAiPSiUQReYwkmREhvA1XCVhGsOyU575MdCchWK8lZeh3xDIv/jnALtaple/HlIRabSHxvC+VHoM63VRksUscSch8QiBdnT02jeF8zNB7vc8jCGFYKv6rv3HOB19uACrh7tLV4sBYl+o7uv6kEW52aTvrHgPYqaGc0bkiF2GDGQ51+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Bq+gNKsiPwf5hAUurNeslNyeKuPijE+bw92Pvf7ZVU=;
 b=W45U+ENr7XsuUDvsFA+w16Y2fscR2k+/4WuomUzrThg31ZiVUwdP1Tf+H7gYM5f43LnMmjVOyLpY373ZHp3Iyf1VZh0EXOK+Jtwl8esGKkoR1QayGg6/eJH+9KBOvdGauI9JUJJu62yqB2mPFzZGzorKE8jh3VvxjHTJvXqKUgO3QgSxjFKB+5cKIoeBJj5GFB1+HWHAE969GbT6Dq10qeqZaVqBium8L9AKIl2A58E+DgyUWzwDIEs2Jezeg+k4YUqXu8fsYRalelCgbtD7jUuMEQd9+5krCSED+eNR/rcKo85r2Ru5rXb6FLD7o5DOP+B+zokYWnWdklxMkxAA/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Bq+gNKsiPwf5hAUurNeslNyeKuPijE+bw92Pvf7ZVU=;
 b=PnabtFwc5f9CGW3kHnhhIKcq21Nlx7Soywi2Qb5RoaNWdWBfPKyXYzr28PkqOxgWT5ug9ui5E7mF8trkiPpuK3XDIyFF+vPN4ZtbF+x4kH8TymIOPU5hc97dx77g1p8ewuHxNnsRWSR1pVBUxb68pUEVR/NfLzzraWApYk8YGFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1249.namprd12.prod.outlook.com (2603:10b6:404:1d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 15:39:35 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a%6]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 15:39:35 +0000
Date:   Tue, 15 Feb 2022 15:39:26 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v7 04/12] EDAC/amd64: Move struct fam_type variables into
 amd64_pvt structure
Message-ID: <YgvJLm3gF/4QvxSm@yaz-ubuntu>
References: <20220203174942.31630-1-nchatrad@amd.com>
 <20220203174942.31630-5-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203174942.31630-5-nchatrad@amd.com>
X-ClientProxiedBy: MN2PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:23a::27) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92f81824-957e-41f1-db83-08d9f0995e88
X-MS-TrafficTypeDiagnostic: BN6PR12MB1249:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB124971A758762A75C34354DEF8349@BN6PR12MB1249.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: knOEl5sQ7JWuG/8M+dcpvD0CpGYfgPC3DNiuM4VgyYaii7J1zRRRlEi8wnEiufWAfMh3smPobepdHiYtleQt4J6miog7ghX52k2C3aAhQzPacI0HpDChTp2K8Hv/8ViOSuQMlryIqs2BR8jAN0mA3cz4VwISv7Z0eOPbFFw28LcSku0d8YyIR2C8/Rsh7Jc+edkPgl986k0O4wDaK29wZ7L6x4bijwTt6P0AHIvFO2eMYFiIKAOB7g+ckqh12etHDa+zHFOnwzvIJeJ4Z++pTIgNSHqixVrLo13zzUbtPlETZa0vfP1fTwNx6frulvq7tVhVqqgOA0WvtU2y4cWF6tAT2qes9dA/tRaRCveE/fkL40VlIoncDbvSMcFuB530Ui1Uzs8Soig6CaGTWPEq8/i7NPswy/+PSAhzxAbMl/REZhijW+pWuV0b3xk2duJbHperio9X4I15WPYmGI20cE4PQ43gNP7gfL5ThCmslBIxcam/wWMvcHlUoEh+ig3kNqs37FI8M6fradz7Y0YH6hoU9miNyzGSd+LPVGbik0yyHuzmbzX7gPTHw55qkM6EVYPdBg1J6sewXqcwXF2h9wQabsTFv46+gFG01hN2MUFXm/2vgpDuh/IJCj2bYArOD5DOwk1/tSYT4D6zWXZo3NuvgAXpzGhqKiLmaF4xbxrqXgAOxRkUGX11ON41zeQ5ui3E/wDFD2VV9LGpJYlmJs9rt+Go1QaPp+1ft2SztYMf0VWx4WDWkVhrdd0eIQnlvLN92Cf/x28DbWeo0XI3lQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(66556008)(66476007)(66946007)(316002)(2906002)(8676002)(33716001)(6636002)(6486002)(966005)(508600001)(6862004)(6666004)(4326008)(83380400001)(26005)(38100700002)(44832011)(5660300002)(30864003)(9686003)(6506007)(8936002)(86362001)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qJWX6rUppELqjIIxXE7DkPzaCFmmbf4IcmQv5Zl+fzV6YaUeLXyorQRBSBQf?=
 =?us-ascii?Q?OPyoZN29hpIBHtSAme45o3eccuP4jpTsUsqSStpm2PsqzpsWUrz0pk+fnVIG?=
 =?us-ascii?Q?rBoq/YQ759lRYRJxvEpncB1/1enQCtGeGfjicsw6Qynor0x5EdFUV5BFNT+r?=
 =?us-ascii?Q?8Qlut4cHROKyOlAnPRXnhXa1Nfd/vbCfqKk7tsKC+4wlO8wm9CqmgOgna987?=
 =?us-ascii?Q?qUmk+THcncWO3xAl5su3Dln8dOJ/xps3FbYi0PXHiE/hcsUzO+k4eHntk6zu?=
 =?us-ascii?Q?KDDnQvD/Glea6gxkWLdVw9DQ9RSwAPyflX5IFZq3n0qROq8NCeeQDOZlPMdm?=
 =?us-ascii?Q?AumwsyiRnjKdmeNhGZMYXdKCtoP39HuhXIy8T5EYXv3tvJviRRI2LJrczY09?=
 =?us-ascii?Q?prztpGS5FMvynpALw4pAtcFu7MzRukIUNFVOLkdvoxeGWuoeHYftwzg2uj+h?=
 =?us-ascii?Q?7tKG11KDis4Lsj9+ZdKBnEHebWsB5nl49x5UtOWp4qrxnA5QTXipEHYTFVLs?=
 =?us-ascii?Q?F0ESebWsbfOpIxmEjKhBpLQddPCPLG9urNQj5RRVPpqWRLXwi4EoYJ1/7NKy?=
 =?us-ascii?Q?NTRGfowBSuPKL6Gf55FIUVYRA4wtMhp63ktyH8bSkRSHf1XIDJXA556ESr52?=
 =?us-ascii?Q?L5OR56KsGV4WDfOc46xCNLOodQQIcDoRD3GWV6i7FZoNh7K8I8TjqAW8rOX5?=
 =?us-ascii?Q?i9V4uUldGVQXZ+PyK2vEHilnHidj2/Tdhl47Td6BiZ0FtapvPSfSGZzPTKQL?=
 =?us-ascii?Q?OgwniLfondt0uOlYfgtBlFOKZM87SrlUkGEjXYlEmzOF8bVR+h2FBsZQVDwf?=
 =?us-ascii?Q?sdgag434DmyblBksWmfz5KM7YklJwB8X25e46rA4IqtQkfXtPMg8t1gSNmpn?=
 =?us-ascii?Q?7VN5zIqLA4/Yh4cdgRFW3l2zfOS6bWZweVCPv3FvbDdtfXPaGlIJcznsWyVq?=
 =?us-ascii?Q?ixte0wS8Q2hb5WwHeLXXL31Lx1TSFEE0Ct1M7lYXTi/AlILDs630SSv+xmu9?=
 =?us-ascii?Q?cn+VMNaor2Jt4LIBXIweZ3fRC0oEMQJZrq2WLK/3lHy3yOlCzACukDn3kqOl?=
 =?us-ascii?Q?S5E2dfqOvz8EdMIjpWq99ZmqRsmCSPBqdVBu352y3XiBLUxIKTZ55aBeEUrg?=
 =?us-ascii?Q?xEJgdVa/9ct1prTS5Ew6PF4hUtqVB2Vj/214n1fc9kz9cX3jWG21QD/3t9xZ?=
 =?us-ascii?Q?44drh4d5u6MI+Qxu2mct0wHO7MAZih4xDpW8jtgmtaL6EpHLNBWeEtK9O+zX?=
 =?us-ascii?Q?86eJAz9teU/QiAetjsSZvHXT0k3HxONVeuz2KGzw7sDQln2ZiSXch8IpIqKT?=
 =?us-ascii?Q?/oTVq4JCVt1gpmJQ3uSJ0+kM3euzWAXN73uXsHWvWcAyzHcX+iOX/df99kiA?=
 =?us-ascii?Q?4O1HSA07STVdq3wBa8Ip+FQEgu1PEQqeEKjc3DSruanwTaIO40nzKiGw7jma?=
 =?us-ascii?Q?ofIsgoc9dNZynGXNhUFjcT57EGqcqzXix+zTLcc+yNtTTYgpOyYEb5S5C0jb?=
 =?us-ascii?Q?tbF+4kDWTvdnCIIaMMxgoHpmacgfTV3YKd6/OHoATUmJuOyqTLyx240SgFqd?=
 =?us-ascii?Q?AK3pv7tgFEZMH1fFX2piNyoyEmqW0enAV9LgqPMq4j709msfQPk9iIHW/L0G?=
 =?us-ascii?Q?jA3cetWA4VBCKehkwacYfIE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f81824-957e-41f1-db83-08d9f0995e88
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 15:39:35.8044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 605PjbRPMqLs7E/XeyYfqIxPKghY5kECjUvb0uNMeDaPCg7nhaMc8AMlemL/kuFJodTfeSKWsjoQQG6DuIgsqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1249
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Feb 03, 2022 at 11:49:34AM -0600, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> On heterogeneous systems, the GPU nodes are probed after the CPU
> nodes and will overwrites the family type set by CPU nodes.
>

s/overwrites/overwrite
 
> Removed struct fam_type and made all family-specific assignments

Remove...make...

> dynamic and get rid of static definitions of family_types and ops,

Should the comma (,) be a period (.)?

> This would simplify adding support for future platforms.
> 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20211028130106.15701-5-nchatrad@amd.com
> 
> v6->v7:
> * rebased on top of\
>   https://lore.kernel.org/all/20220202144307.2678405-1-yazen.ghannam@amd.com/
> 
> v4->v5:
> * Added reviewed by Yazen
> 
> v1->v4:
> * New change in v4
> 
> 
>  drivers/edac/amd64_edac.c | 384 +++++++++++++-------------------------
>  drivers/edac/amd64_edac.h |  64 +++----
>  2 files changed, 153 insertions(+), 295 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 782e286d5390..4cac43840ccc 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -13,11 +13,9 @@ module_param(ecc_enable_override, int, 0644);
>  
>  static struct msr __percpu *msrs;
>  
> -static struct amd64_family_type *fam_type;
> -
> -static inline u32 get_umc_reg(u32 reg)
> +static inline u32 get_umc_reg(u32 reg, struct amd64_pvt *pvt)

Can you please switch the parameters? I think having "pvt" first is more
consistent across this file.

>  {
> -	if (!fam_type->flags.zn_regs_v2)
> +	if (!pvt->flags.zn_regs_v2)
>  		return reg;
>  
>  	switch (reg) {
> @@ -463,7 +461,7 @@ static void get_cs_base_and_mask(struct amd64_pvt *pvt, int csrow, u8 dct,
>  	for (i = 0; i < pvt->csels[dct].m_cnt; i++)
>  
>  #define for_each_umc(i) \
> -	for (i = 0; i < fam_type->max_mcs; i++)
> +	for (i = 0; i < pvt->max_mcs; i++)
>  
>  /*
>   * @input_addr is an InputAddr associated with the node given by mci. Return the
> @@ -1859,7 +1857,7 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
>  
>  		if (umc->dram_type == MEM_LRDDR4 || umc->dram_type == MEM_LRDDR5) {
>  			amd_smn_read(pvt->mc_node_id,
> -				     umc_base + get_umc_reg(UMCCH_ADDR_CFG),
> +				     umc_base + get_umc_reg(UMCCH_ADDR_CFG, pvt),
>  				     &tmp);
>  			edac_dbg(1, "UMC%d LRDIMM %dx rank multiply\n",
>  					i, 1 << ((tmp >> 4) & 0x3));
> @@ -1935,7 +1933,7 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
>  
>  		for_each_umc(umc) {
>  			pvt->csels[umc].b_cnt = 4;
> -			pvt->csels[umc].m_cnt = fam_type->flags.zn_regs_v2 ? 4 : 2;
> +			pvt->csels[umc].m_cnt = pvt->flags.zn_regs_v2 ? 4 : 2;
>  		}
>  
>  	} else {
> @@ -1975,7 +1973,7 @@ static void read_umc_base_mask(struct amd64_pvt *pvt)
>  		}
>  
>  		umc_mask_reg = get_umc_base(umc) + UMCCH_ADDR_MASK;
> -		umc_mask_reg_sec = get_umc_base(umc) + get_umc_reg(UMCCH_ADDR_MASK_SEC);
> +		umc_mask_reg_sec = get_umc_base(umc) + get_umc_reg(UMCCH_ADDR_MASK_SEC, pvt);
>  
>  		for_each_chip_select_mask(cs, umc, pvt) {
>  			mask = &pvt->csels[umc].csmasks[cs];
> @@ -2046,7 +2044,7 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
>  	}
>  }
>  
> -static void _determine_memory_type_df(struct amd64_umc *umc)
> +static void _determine_memory_type_df(struct amd64_pvt *pvt, struct amd64_umc *umc)
>  {
>  	if (!(umc->sdp_ctrl & UMC_SDP_INIT)) {
>  		umc->dram_type = MEM_EMPTY;
> @@ -2057,7 +2055,7 @@ static void _determine_memory_type_df(struct amd64_umc *umc)
>  	 * Check if the system supports the "DDR Type" field in UMC Config
>  	 * and has DDR5 DIMMs in use.
>  	 */
> -	if (fam_type->flags.zn_regs_v2 && ((umc->umc_cfg & GENMASK(2, 0)) == 0x1)) {
> +	if (pvt->flags.zn_regs_v2 && ((umc->umc_cfg & GENMASK(2, 0)) == 0x1)) {
>  		if (umc->dimm_cfg & BIT(5))
>  			umc->dram_type = MEM_LRDDR5;
>  		else if (umc->dimm_cfg & BIT(4))
> @@ -2082,7 +2080,7 @@ static void determine_memory_type_df(struct amd64_pvt *pvt)
>  	for_each_umc(i) {
>  		umc = &pvt->umc[i];
>  
> -		_determine_memory_type_df(umc);
> +		_determine_memory_type_df(pvt, umc);
>  		edac_dbg(1, "  UMC%d DIMM type: %s\n", i, edac_mem_types[umc->dram_type]);
>  	}
>  }
> @@ -2648,7 +2646,7 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>  	 */
>  	dimm = csrow_nr >> 1;
>  
> -	if (!fam_type->flags.zn_regs_v2)
> +	if (!pvt->flags.zn_regs_v2)
>  		cs_mask_nr >>= 1;
>  
>  	/* Asymmetric dual-rank DIMM support. */
> @@ -3268,167 +3266,6 @@ static void debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
>  	}
>  }
>  
> -static struct amd64_family_type family_types[] = {
> -	[K8_CPUS] = {
> -		.ctl_name = "K8",
> -		.f1_id = PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP,
> -		.f2_id = PCI_DEVICE_ID_AMD_K8_NB_MEMCTL,
> -		.max_mcs = 2,
> -		.ops = {
> -			.early_channel_count	= k8_early_channel_count,
> -			.map_sysaddr_to_csrow	= k8_map_sysaddr_to_csrow,
> -			.dbam_to_cs		= k8_dbam_to_chip_select,
> -		}
> -	},
> -	[F10_CPUS] = {
> -		.ctl_name = "F10h",
> -		.f1_id = PCI_DEVICE_ID_AMD_10H_NB_MAP,
> -		.f2_id = PCI_DEVICE_ID_AMD_10H_NB_DRAM,
> -		.max_mcs = 2,
> -		.ops = {
> -			.early_channel_count	= f1x_early_channel_count,
> -			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
> -			.dbam_to_cs		= f10_dbam_to_chip_select,
> -		}
> -	},
> -	[F15_CPUS] = {
> -		.ctl_name = "F15h",
> -		.f1_id = PCI_DEVICE_ID_AMD_15H_NB_F1,
> -		.f2_id = PCI_DEVICE_ID_AMD_15H_NB_F2,
> -		.max_mcs = 2,
> -		.ops = {
> -			.early_channel_count	= f1x_early_channel_count,
> -			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
> -			.dbam_to_cs		= f15_dbam_to_chip_select,
> -		}
> -	},
> -	[F15_M30H_CPUS] = {
> -		.ctl_name = "F15h_M30h",
> -		.f1_id = PCI_DEVICE_ID_AMD_15H_M30H_NB_F1,
> -		.f2_id = PCI_DEVICE_ID_AMD_15H_M30H_NB_F2,
> -		.max_mcs = 2,
> -		.ops = {
> -			.early_channel_count	= f1x_early_channel_count,
> -			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
> -			.dbam_to_cs		= f16_dbam_to_chip_select,
> -		}
> -	},
> -	[F15_M60H_CPUS] = {
> -		.ctl_name = "F15h_M60h",
> -		.f1_id = PCI_DEVICE_ID_AMD_15H_M60H_NB_F1,
> -		.f2_id = PCI_DEVICE_ID_AMD_15H_M60H_NB_F2,
> -		.max_mcs = 2,
> -		.ops = {
> -			.early_channel_count	= f1x_early_channel_count,
> -			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
> -			.dbam_to_cs		= f15_m60h_dbam_to_chip_select,
> -		}
> -	},
> -	[F16_CPUS] = {
> -		.ctl_name = "F16h",
> -		.f1_id = PCI_DEVICE_ID_AMD_16H_NB_F1,
> -		.f2_id = PCI_DEVICE_ID_AMD_16H_NB_F2,
> -		.max_mcs = 2,
> -		.ops = {
> -			.early_channel_count	= f1x_early_channel_count,
> -			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
> -			.dbam_to_cs		= f16_dbam_to_chip_select,
> -		}
> -	},
> -	[F16_M30H_CPUS] = {
> -		.ctl_name = "F16h_M30h",
> -		.f1_id = PCI_DEVICE_ID_AMD_16H_M30H_NB_F1,
> -		.f2_id = PCI_DEVICE_ID_AMD_16H_M30H_NB_F2,
> -		.max_mcs = 2,
> -		.ops = {
> -			.early_channel_count	= f1x_early_channel_count,
> -			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
> -			.dbam_to_cs		= f16_dbam_to_chip_select,
> -		}
> -	},
> -	[F17_CPUS] = {
> -		.ctl_name = "F17h",
> -		.f0_id = PCI_DEVICE_ID_AMD_17H_DF_F0,
> -		.f6_id = PCI_DEVICE_ID_AMD_17H_DF_F6,
> -		.max_mcs = 2,
> -		.ops = {
> -			.early_channel_count	= f17_early_channel_count,
> -			.dbam_to_cs		= f17_addr_mask_to_cs_size,
> -		}
> -	},
> -	[F17_M10H_CPUS] = {
> -		.ctl_name = "F17h_M10h",
> -		.f0_id = PCI_DEVICE_ID_AMD_17H_M10H_DF_F0,
> -		.f6_id = PCI_DEVICE_ID_AMD_17H_M10H_DF_F6,
> -		.max_mcs = 2,
> -		.ops = {
> -			.early_channel_count	= f17_early_channel_count,
> -			.dbam_to_cs		= f17_addr_mask_to_cs_size,
> -		}
> -	},
> -	[F17_M30H_CPUS] = {
> -		.ctl_name = "F17h_M30h",
> -		.f0_id = PCI_DEVICE_ID_AMD_17H_M30H_DF_F0,
> -		.f6_id = PCI_DEVICE_ID_AMD_17H_M30H_DF_F6,
> -		.max_mcs = 8,
> -		.ops = {
> -			.early_channel_count	= f17_early_channel_count,
> -			.dbam_to_cs		= f17_addr_mask_to_cs_size,
> -		}
> -	},
> -	[F17_M60H_CPUS] = {
> -		.ctl_name = "F17h_M60h",
> -		.f0_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F0,
> -		.f6_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F6,
> -		.max_mcs = 2,
> -		.ops = {
> -			.early_channel_count	= f17_early_channel_count,
> -			.dbam_to_cs		= f17_addr_mask_to_cs_size,
> -		}
> -	},
> -	[F17_M70H_CPUS] = {
> -		.ctl_name = "F17h_M70h",
> -		.f0_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F0,
> -		.f6_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F6,
> -		.max_mcs = 2,
> -		.ops = {
> -			.early_channel_count	= f17_early_channel_count,
> -			.dbam_to_cs		= f17_addr_mask_to_cs_size,
> -		}
> -	},
> -	[F19_CPUS] = {
> -		.ctl_name = "F19h",
> -		.f0_id = PCI_DEVICE_ID_AMD_19H_DF_F0,
> -		.f6_id = PCI_DEVICE_ID_AMD_19H_DF_F6,
> -		.max_mcs = 8,
> -		.ops = {
> -			.early_channel_count	= f17_early_channel_count,
> -			.dbam_to_cs		= f17_addr_mask_to_cs_size,
> -		}
> -	},
> -	[F19_M10H_CPUS] = {
> -		.ctl_name = "F19h_M10h",
> -		.f0_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F0,
> -		.f6_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F6,
> -		.max_mcs = 12,
> -		.flags.zn_regs_v2 = 1,
> -		.ops = {
> -			.early_channel_count	= f17_early_channel_count,
> -			.dbam_to_cs		= f17_addr_mask_to_cs_size,
> -		}
> -	},
> -	[F19_M50H_CPUS] = {
> -		.ctl_name = "F19h_M50h",
> -		.f0_id = PCI_DEVICE_ID_AMD_19H_M50H_DF_F0,
> -		.f6_id = PCI_DEVICE_ID_AMD_19H_M50H_DF_F6,
> -		.max_mcs = 2,
> -		.ops = {
> -			.early_channel_count	= f17_early_channel_count,
> -			.dbam_to_cs		= f17_addr_mask_to_cs_size,
> -		}
> -	},
> -};
> -
>  /*
>   * These are tables of eigenvectors (one per line) which can be used for the
>   * construction of the syndrome tables. The modified syndrome search algorithm
> @@ -3850,7 +3687,7 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
>  		umc_base = get_umc_base(i);
>  		umc = &pvt->umc[i];
>  
> -		amd_smn_read(nid, umc_base + get_umc_reg(UMCCH_DIMM_CFG), &umc->dimm_cfg);
> +		amd_smn_read(nid, umc_base + get_umc_reg(UMCCH_DIMM_CFG, pvt), &umc->dimm_cfg);
>  		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
>  		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
>  		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
> @@ -4380,7 +4217,7 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
>  
>  	mci->edac_cap		= determine_edac_cap(pvt);
>  	mci->mod_name		= EDAC_MOD_STR;
> -	mci->ctl_name		= fam_type->ctl_name;
> +	mci->ctl_name		= pvt->ctl_name;
>  	mci->dev_name		= pci_name(pvt->F3);
>  	mci->ctl_page_to_phys	= NULL;
>  
> @@ -4392,7 +4229,7 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
>  /*
>   * returns a pointer to the family descriptor on success, NULL otherwise.
>   */
> -static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
> +static void per_family_init(struct amd64_pvt *pvt)
>  {
>  	pvt->ext_model  = boot_cpu_data.x86_model >> 4;
>  	pvt->stepping	= boot_cpu_data.x86_stepping;
> @@ -4401,109 +4238,150 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
>  
>  	switch (pvt->fam) {
>  	case 0xf:
> -		fam_type	= &family_types[K8_CPUS];
> -		pvt->ops	= &family_types[K8_CPUS].ops;
> +		pvt->ctl_name				= "K8";
> +		pvt->f1_id				= PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP;
> +		pvt->f2_id				= PCI_DEVICE_ID_AMD_K8_NB_MEMCTL;
> +		pvt->max_mcs				= 2;

Most systems have "max_mcs = 2", so this can be the default. It can be set
before the switch statement. Then any systems that have a different value can
overwrite it.

> +		pvt->ops->early_channel_count		= k8_early_channel_count;
> +		pvt->ops->map_sysaddr_to_csrow		= k8_map_sysaddr_to_csrow;
> +		pvt->ops->dbam_to_cs			= k8_dbam_to_chip_select;

I think an argument can be made that the "low_ops" can also be removed. That
way the the "pvt" is flatten even more. But I think that'd make the diff even
bigger without any immediate benefit. I think this module needs a bit of
spring cleaning, so removing "low_ops" can be done then once the current
changes settle down.

>  		break;
>  
>  	case 0x10:
> -		fam_type	= &family_types[F10_CPUS];
> -		pvt->ops	= &family_types[F10_CPUS].ops;
> +		pvt->ctl_name				= "F10h";
> +		pvt->f1_id				= PCI_DEVICE_ID_AMD_10H_NB_MAP;
> +		pvt->f2_id				= PCI_DEVICE_ID_AMD_10H_NB_DRAM;
> +		pvt->max_mcs				= 2;
> +		pvt->ops->early_channel_count		= f1x_early_channel_count;
> +		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
> +		pvt->ops->dbam_to_cs			= f10_dbam_to_chip_select;
>  		break;
>  
>  	case 0x15:
>  		if (pvt->model == 0x30) {
> -			fam_type = &family_types[F15_M30H_CPUS];
> -			pvt->ops = &family_types[F15_M30H_CPUS].ops;
> -			break;
> +			pvt->ctl_name			= "F15h_M30h";
> +			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_M30H_NB_F1;
> +			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_M30H_NB_F2;
> +			pvt->ops->dbam_to_cs		= f16_dbam_to_chip_select;
>  		} else if (pvt->model == 0x60) {
> -			fam_type = &family_types[F15_M60H_CPUS];
> -			pvt->ops = &family_types[F15_M60H_CPUS].ops;
> -			break;
> -		/* Richland is only client */
> +			pvt->ctl_name			= "F15h_M60h";
> +			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_M60H_NB_F1;
> +			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_M60H_NB_F2;
> +			pvt->ops->dbam_to_cs		= f15_m60h_dbam_to_chip_select;
>  		} else if (pvt->model == 0x13) {
> -			return NULL;
> +		/* Richland is only client */
> +			return;
>  		} else {
> -			fam_type	= &family_types[F15_CPUS];
> -			pvt->ops	= &family_types[F15_CPUS].ops;
> +			pvt->ctl_name			= "F15h";
> +			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_NB_F1;
> +			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_NB_F2;
> +			pvt->ops->dbam_to_cs		= f15_dbam_to_chip_select;
>  		}
> +		pvt->max_mcs				= 2;
> +		pvt->ops->early_channel_count		= f1x_early_channel_count;
> +		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
>  		break;
>  
>  	case 0x16:
>  		if (pvt->model == 0x30) {
> -			fam_type = &family_types[F16_M30H_CPUS];
> -			pvt->ops = &family_types[F16_M30H_CPUS].ops;
> -			break;
> +			pvt->ctl_name			= "F16h_M30h";
> +			pvt->f1_id			= PCI_DEVICE_ID_AMD_16H_M30H_NB_F1;
> +			pvt->f2_id			= PCI_DEVICE_ID_AMD_16H_M30H_NB_F2;
> +		} else {
> +			pvt->ctl_name			= "F16h";
> +			pvt->f1_id			= PCI_DEVICE_ID_AMD_16H_NB_F1;
> +			pvt->f2_id			= PCI_DEVICE_ID_AMD_16H_NB_F2;
>  		}
> -		fam_type	= &family_types[F16_CPUS];
> -		pvt->ops	= &family_types[F16_CPUS].ops;
> +		pvt->max_mcs				= 2;
> +		pvt->ops->early_channel_count		= f1x_early_channel_count;
> +		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
> +		pvt->ops->dbam_to_cs			= f16_dbam_to_chip_select;
>  		break;
>  
>  	case 0x17:
>  		if (pvt->model >= 0x10 && pvt->model <= 0x2f) {
> -			fam_type = &family_types[F17_M10H_CPUS];
> -			pvt->ops = &family_types[F17_M10H_CPUS].ops;
> -			df_ops	 = &df2_ops;
> -			break;
> +			pvt->ctl_name			= "F17h_M10h";
> +			pvt->f0_id			= PCI_DEVICE_ID_AMD_17H_M10H_DF_F0;
> +			pvt->f6_id			= PCI_DEVICE_ID_AMD_17H_M10H_DF_F6;
> +			pvt->max_mcs			= 2;
> +			df_ops				= &df2_ops;
>  		} else if (pvt->model >= 0x30 && pvt->model <= 0x3f) {
> -			fam_type = &family_types[F17_M30H_CPUS];
> -			pvt->ops = &family_types[F17_M30H_CPUS].ops;
> -			df_ops	 = &df3_ops;
> -			break;
> +			pvt->ctl_name			= "F17h_M30h";
> +			pvt->f0_id			= PCI_DEVICE_ID_AMD_17H_M30H_DF_F0;
> +			pvt->f6_id			= PCI_DEVICE_ID_AMD_17H_M30H_DF_F6;
> +			pvt->max_mcs			= 8;
> +			df_ops				= &df3_ops;
>  		} else if (pvt->model >= 0x60 && pvt->model <= 0x6f) {
> -			fam_type = &family_types[F17_M60H_CPUS];
> -			pvt->ops = &family_types[F17_M60H_CPUS].ops;
> -			df_ops	 = &df3_ops;
> -			break;
> +			pvt->ctl_name			= "F17h_M60h";
> +			pvt->f0_id			= PCI_DEVICE_ID_AMD_17H_M60H_DF_F0;
> +			pvt->f6_id			= PCI_DEVICE_ID_AMD_17H_M60H_DF_F6;
> +			pvt->max_mcs			= 2;
> +			df_ops				= &df3_ops;
>  		} else if (pvt->model >= 0x70 && pvt->model <= 0x7f) {
> -			fam_type = &family_types[F17_M70H_CPUS];
> -			pvt->ops = &family_types[F17_M70H_CPUS].ops;
> -			df_ops	 = &df3_ops;
> -			break;
> +			pvt->ctl_name			= "F17h_M70h";
> +			pvt->f0_id			= PCI_DEVICE_ID_AMD_17H_M70H_DF_F0;
> +			pvt->f6_id			= PCI_DEVICE_ID_AMD_17H_M70H_DF_F6;
> +			pvt->max_mcs			= 2;
> +			df_ops				= &df3_ops;
> +		} else {
> +			pvt->ctl_name			= "F17h";
> +			pvt->f0_id			= PCI_DEVICE_ID_AMD_17H_DF_F0;
> +			pvt->f6_id			= PCI_DEVICE_ID_AMD_17H_DF_F6;
> +			pvt->max_mcs			= 2;
> +			df_ops				= &df2_ops;
>  		}
>  		fallthrough;
>  	case 0x18:
> -		fam_type	= &family_types[F17_CPUS];
> -		pvt->ops	= &family_types[F17_CPUS].ops;
> -		df_ops		= &df2_ops;
> -
> -		if (pvt->fam == 0x18)
> -			family_types[F17_CPUS].ctl_name = "F18h";
> +		pvt->ops->early_channel_count		= f17_early_channel_count;
> +		pvt->ops->dbam_to_cs			= f17_addr_mask_to_cs_size;
> +
> +		if (pvt->fam == 0x18) {
> +			pvt->ctl_name			= "F18h";
> +			pvt->f0_id			= PCI_DEVICE_ID_AMD_17H_DF_F0;
> +			pvt->f6_id			= PCI_DEVICE_ID_AMD_17H_DF_F6;
> +			pvt->max_mcs			= 2;
> +			df_ops				= &df2_ops;
> +		}
>  		break;
>  
>  	case 0x19:
>  		if (pvt->model >= 0x10 && pvt->model <= 0x1f) {
> -			fam_type = &family_types[F19_M10H_CPUS];
> -			pvt->ops = &family_types[F19_M10H_CPUS].ops;
> -			break;
> +			pvt->ctl_name			= "F19h_M10h";
> +			pvt->f0_id			= PCI_DEVICE_ID_AMD_19H_M10H_DF_F0;
> +			pvt->f6_id			= PCI_DEVICE_ID_AMD_19H_M10H_DF_F6;
> +			pvt->max_mcs			= 12;
> +			pvt->flags.zn_regs_v2		= 1;
>  		} else if (pvt->model >= 0x20 && pvt->model <= 0x2f) {
> -			fam_type = &family_types[F17_M70H_CPUS];
> -			pvt->ops = &family_types[F17_M70H_CPUS].ops;
> -			fam_type->ctl_name = "F19h_M20h";
> -			df_ops	 = &df3_ops;
> -			break;
> +			pvt->ctl_name			= "F19h_M20h";
> +			pvt->f0_id			= PCI_DEVICE_ID_AMD_17H_M70H_DF_F0;
> +			pvt->f6_id			= PCI_DEVICE_ID_AMD_17H_M70H_DF_F6;
> +			pvt->max_mcs			= 2;
> +			df_ops				= &df3_ops;
>  		} else if (pvt->model >= 0x50 && pvt->model <= 0x5f) {
> -			fam_type = &family_types[F19_M50H_CPUS];
> -			pvt->ops = &family_types[F19_M50H_CPUS].ops;
> -			fam_type->ctl_name = "F19h_M50h";
> -			break;
> +			pvt->ctl_name			= "F19h_M50h";
> +			pvt->f0_id			= PCI_DEVICE_ID_AMD_19H_M50H_DF_F0;
> +			pvt->f6_id			= PCI_DEVICE_ID_AMD_19H_M50H_DF_F6;
> +			pvt->max_mcs			= 2;
>  		} else if (pvt->model >= 0xa0 && pvt->model <= 0xaf) {
> -			fam_type = &family_types[F19_M10H_CPUS];
> -			pvt->ops = &family_types[F19_M10H_CPUS].ops;
> -			fam_type->ctl_name = "F19h_MA0h";
> -			break;
> +			pvt->ctl_name			= "F19h_M10h";

Should be "F19h_MA0h".

> +			pvt->f0_id			= PCI_DEVICE_ID_AMD_19H_M10H_DF_F0;
> +			pvt->f6_id			= PCI_DEVICE_ID_AMD_19H_M10H_DF_F6;
> +			pvt->max_mcs			= 2;

Should be "12".

> +		} else {
> +			pvt->ctl_name			= "F19h";
> +			pvt->f0_id			= PCI_DEVICE_ID_AMD_19H_DF_F0;
> +			pvt->f6_id			= PCI_DEVICE_ID_AMD_19H_DF_F6;
> +			pvt->max_mcs			= 8;
> +			df_ops				= &df3_ops;
>  		}
> -		fam_type	= &family_types[F19_CPUS];
> -		pvt->ops	= &family_types[F19_CPUS].ops;
> -		family_types[F19_CPUS].ctl_name = "F19h";
> -		df_ops		= &df3_ops;
> +		pvt->ops->early_channel_count		= f17_early_channel_count;
> +		pvt->ops->dbam_to_cs			= f17_addr_mask_to_cs_size;
>  		break;
>  
>  	default:
>  		amd64_err("Unsupported family!\n");
> -		return NULL;
> +		return;

This should return an error code.

>  	}
> -
> -	return fam_type;
>  }
>  
>  static const struct attribute_group *amd64_edac_attr_groups[] = {
> @@ -4520,15 +4398,15 @@ static int hw_info_get(struct amd64_pvt *pvt)
>  	int ret;
>  
>  	if (pvt->fam >= 0x17) {
> -		pvt->umc = kcalloc(fam_type->max_mcs, sizeof(struct amd64_umc), GFP_KERNEL);
> +		pvt->umc = kcalloc(pvt->max_mcs, sizeof(struct amd64_umc), GFP_KERNEL);
>  		if (!pvt->umc)
>  			return -ENOMEM;
>  
> -		pci_id1 = fam_type->f0_id;
> -		pci_id2 = fam_type->f6_id;
> +		pci_id1 = pvt->f0_id;
> +		pci_id2 = pvt->f6_id;
>  	} else {
> -		pci_id1 = fam_type->f1_id;
> -		pci_id2 = fam_type->f2_id;
> +		pci_id1 = pvt->f1_id;
> +		pci_id2 = pvt->f2_id;
>  	}
>  
>  	ret = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
> @@ -4574,7 +4452,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
>  	 * only one channel. Also, this simplifies handling later for the price
>  	 * of a couple of KBs tops.
>  	 */
> -	layers[1].size = fam_type->max_mcs;
> +	layers[1].size = pvt->max_mcs;
>  	layers[1].is_virt_csrow = false;
>  
>  	mci = edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);
> @@ -4604,7 +4482,7 @@ static bool instance_has_memory(struct amd64_pvt *pvt)
>  	bool cs_enabled = false;
>  	int cs = 0, dct = 0;
>  
> -	for (dct = 0; dct < fam_type->max_mcs; dct++) {
> +	for (dct = 0; dct < pvt->max_mcs; dct++) {
>  		for_each_chip_select(cs, dct, pvt)
>  			cs_enabled |= csrow_enabled(cs, dct, pvt);
>  	}
> @@ -4633,10 +4511,12 @@ static int probe_one_instance(unsigned int nid)
>  	pvt->mc_node_id	= nid;
>  	pvt->F3 = F3;
>  
> +	pvt->ops = kzalloc(sizeof(*pvt->ops), GFP_KERNEL);
> +	if (!pvt->ops)
> +		goto err_out;
> +
>  	ret = -ENODEV;
> -	fam_type = per_family_init(pvt);
> -	if (!fam_type)
> -		goto err_enable;
> +	per_family_init(pvt);

This should check for an error code. The module should not continue to load if
it doesn't have the necessary information for the system.

>  
>  	ret = hw_info_get(pvt);
>  	if (ret < 0)
> @@ -4674,8 +4554,8 @@ static int probe_one_instance(unsigned int nid)
>  		goto err_enable;
>  	}
>  
> -	amd64_info("%s %sdetected (node %d).\n", fam_type->ctl_name,
> -		     (pvt->fam == 0xf ?
> +	amd64_info("%s %sdetected (node %d).\n", pvt->ctl_name,
> +		   (pvt->fam == 0xf ?
>  				(pvt->ext_model >= K8_REV_F  ? "revF or later "
>  							     : "revE or earlier ")
>  				 : ""), pvt->mc_node_id);

This "ext_model" check can be baked into the ctl_name during
per_family_init().

Thanks,
Yazen
