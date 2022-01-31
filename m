Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4522E4A5289
	for <lists+linux-edac@lfdr.de>; Mon, 31 Jan 2022 23:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbiAaWnp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 31 Jan 2022 17:43:45 -0500
Received: from mail-dm6nam10on2078.outbound.protection.outlook.com ([40.107.93.78]:37659
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229870AbiAaWnp (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 31 Jan 2022 17:43:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMs9H6dxMa/QqYaT6lx//6wekycQox6f3YKCjr2M8Z22Nysv88WiM3Ygc0iX48cE5KAy9ZxcVlXoz3OSO79pNVwwDxzuJuRhJukuBRPDyIUwcCi6plS5A4MGBkOxST1Xd51NC09Pes5dxkz0Ou16M107hysyuAdKjaCny1CIh8qu84X1dLfxGL31aqVRR5NMW8kvsKLOE1HgJ6TCJAU/m3VAT8ob0vgJcgxPwfEij3ZjQgYgr6TtHIGuc8Mw6Qh2hLIUNY19fQblO3nGX1y97aPNI8PG7tNvOCnKgZoVS+DdaexTc3/lU/nQ6G41+OqR8u2pME70A72/kh0aQIdHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2VHAIIz1uA2XzcJYDIJ3lbMiK6s5dj2QBzxvlUjVGs=;
 b=eEENhBz+OGXitxLl+4EwbdWSn0PVH4dVfY0tyvmtjTNQV1SlXDbRmOokVjf5PRLXcyvc9y5AKu8XuYNsVlc6hcTVdSip5DWc4pG/Sj1nvOk7362WQOfwo0ezQBcMbX4hMuo8hF+3WFEsAkEZIckZHGBrWzt/ENQFVnlrQfMGuCu1ikU03hnLDbcRRfPUu8v66Fc/QB2sHwe0FWiKUgrB4wKQSgj2kj9rL6HpYUg0+tcr5kVKDtLpe1kfmP8+dQupBI/BSaBYlQBLFqpoICAZtjK6+RdZp54b5zXUjHSla23SySLxyIDaTi1ndI48WyK6Kot54Zqyj4N8xNRcZiEZJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2VHAIIz1uA2XzcJYDIJ3lbMiK6s5dj2QBzxvlUjVGs=;
 b=xZVsJWTH06f92oreIwP483kHZybzGf3vG2kI7LleN/SmFONViFC0lsVqd5zW7ua+F2dwgv8Eob5IT25H+v525s8CXDfYCKSGESfffEP66Sposdg+ijQQE8xl1QfM+aV2ZMSSzvP7qB3tnwvvlQTMmLat+CULx5CQ1xCCgUecafo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MWHPR12MB1325.namprd12.prod.outlook.com (2603:10b6:300:f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Mon, 31 Jan
 2022 22:43:42 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a%6]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 22:43:42 +0000
Date:   Mon, 31 Jan 2022 22:43:37 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com,
        william.roche@oracle.com
Subject: Re: [PATCH v3 2/2] EDAC/amd64: Add new register offset support and
 related changes
Message-ID: <YfhmGaLQWaFM1V0n@yaz-ubuntu>
References: <20211228200615.412999-1-yazen.ghannam@amd.com>
 <20211228200615.412999-3-yazen.ghannam@amd.com>
 <YeqmMcOSpjgHwYFD@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeqmMcOSpjgHwYFD@zn.tnic>
X-ClientProxiedBy: BL1PR13CA0417.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::32) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2afe76d7-5db2-435c-7678-08d9e50b214c
X-MS-TrafficTypeDiagnostic: MWHPR12MB1325:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1325D3345A03CA709C55DD68F8259@MWHPR12MB1325.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i2djIJRdYqNvHovO1LCrA+h5V87KqxdJT6akscu/JxQV6q5azmUY1eoTmf8ngjePa6lMxpTPPsbXAOc/bwEtUm3UegO/SMwyrSHC3usFroDLUia0IdyDusyAS5FlqrXwgCOEjJ7OaldjbLMZroNQUSgrNVVShA7Z1g0ZnfUMQTEFfkMFLQAgnFDSYQ89vaA7MeUAjS4btXaaUbfHdoxKbQTKtjKcV0ly1h76qT+Ybd1+7mBbeWaFljM8QtoWBYl0wjTJw233t4MFAoaUb5InmzmRB9xwHAS2t/H3679PcThSe8ljAqMk1TWWouS+6ZBkM1mqlieQT2tXsRcBP9HjOuQX7KMDn+QEbhtgRTTHGweZFhahjStKazUuuwsqCWNrNts2016GNJFFqnLA1fpAapPUl3iRqe7+7M/WzgGUQ17J70WGvDq+6UGowSlJeh8R0/uYkefdyZfsTALrWAsZZnjVIwO5EWXbWAILDq4FbR3K/4f/ZZ3eLbm6uJ+MDKR575mwOeflmfXCWfH5VirtJKfnIqP0epLARJsbKGoBb4WIqhGl1CxHIdPqUuA9JPWR2XLcocHBHd6qvqtzBQzOh7cwV1DeQKAFQi9RWWinnXO+NHsSnOBp6+I5AAJpqtokLfx4Qf84uR31t/FvSGTgsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(26005)(186003)(508600001)(6916009)(316002)(6512007)(6666004)(6506007)(2906002)(6486002)(8936002)(4326008)(86362001)(8676002)(5660300002)(44832011)(9686003)(33716001)(66556008)(66476007)(66946007)(38100700002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ht3I51iDXB43Kmd+Admtxy2Rt1kDm72VSIW7br6OE1QlnXWXiLVmztcAWM0L?=
 =?us-ascii?Q?GphuRKTJRE56QZ2BJmjbeQPcBGhbUeflLy19gTold9by3rM/punsVfUnSD3m?=
 =?us-ascii?Q?5WAR7I68zv1ghLSK0IFlO0WQKI8bAyxDfoD5nEFupBGa/Ut4c57dsJ1xeutB?=
 =?us-ascii?Q?+twCbg0ik/YxXgskVhdO2K8tFNx9thRVl/5bShM/olKCGjZYWz4k1IbZEDCB?=
 =?us-ascii?Q?SlthC6ZpL21jDl+y4GKN8mEF7TsF5kR0m8lRvBZKpqeMt4/ln2ZHZu0x/2kx?=
 =?us-ascii?Q?SLXjKlRCkGZIRgHQE+dwf3WaYfLvH4GdWESBpRH4XjQbQZS2prn3zxptiSrQ?=
 =?us-ascii?Q?c1EgUoNCOlPF2JhIqdJIA7FIkDUbc1l/boZQIgpoBgkGTBN2fK+9ychbzBjD?=
 =?us-ascii?Q?Vkwt0AY+BS8NxOVgpd598Mg50C8ZL3rWSFn4IQhg/9Z4iHD6tK+8+z+PaQsm?=
 =?us-ascii?Q?PoJ2IkZByKt/oVAZlmPUIa+SgqhNM45hgw9kKZnMfqIbnksKIHyHxoTmpM8m?=
 =?us-ascii?Q?Tnsrx+9AiSmBOpYk/vtUiY0IaCh7hiLJM6bScW1LHUX7bLTHHMu4vL2owwT+?=
 =?us-ascii?Q?MmDlq5fXB5uY/ePgl/oQiH7oW5NoIb3S5CICjxW6Ed1IKCuluZbhevnyxuDc?=
 =?us-ascii?Q?jrm9OEoTp1HRmEoul+8sCGteqytS4QZDWgY/jwB4KkHP5Amm/XINpmoXZbYp?=
 =?us-ascii?Q?o6I5es7C8rKQoL6W9cIsUhKkZ8InQmL8Ev9QBUObFPZ9cahVFq1EiD5VfKo0?=
 =?us-ascii?Q?LLMYome2RrbbDwWmC7IuP6ICEiio/asvZJU/D9HQ6GmIS3a/GV/wT4/g576L?=
 =?us-ascii?Q?8SFlFYnZDiPQA02qk4ufdU1nbXhjf+Cx3IBFpmPYQc3dTVSWCzgm7bJSILCJ?=
 =?us-ascii?Q?zB40/c3RSuh9PmAoVno5BOLwqHt5ZKOUzyOh7rjpF6w3O0LVEWBVe3NUB+A/?=
 =?us-ascii?Q?7DALZ7VAkG3jBX48fCmvCEDfPoxjHPpRBOzLMknTnTDg0cujdu/6wt6IOqCn?=
 =?us-ascii?Q?Mt3V7rssCqYgK4gvg+v+s0DBqeFjSfPhZidSMnURcCo21zw6jkWcXJHl7/Sk?=
 =?us-ascii?Q?jKUQOyeD9qg2FlX7RTmmzRVIdsigQ/luEtY82EmxJD2nOfZECCG7PDDwunAz?=
 =?us-ascii?Q?5TRs20nSQqFQ0BCdNKPfi3tYoCjsv7uuCENXTqeae7sEzpg31S9PfVv5xwep?=
 =?us-ascii?Q?GcvAUJ+qA9B4Eno+KY0DfJ4XDSXd8KUxAbu+w5omEH5vlm/xHThYJ+LQdBYm?=
 =?us-ascii?Q?lO59Yqkseu2VACIDDUqZ2S6/5ShcuJ1LTnH7FUMrZZXYorjNoC1X01XMCORo?=
 =?us-ascii?Q?IfjQF826O07Tt6oSpeV77YJnzX95ynGo7KEiV8UV4zYmGdPD+0z+JJH9fGB9?=
 =?us-ascii?Q?gIEtI0SCThrxu8YUP88P/ICub13loRsBRb0VX2tVbMaM9gLZOtLHPzH7SBIW?=
 =?us-ascii?Q?ai5sjAVww++5HDXOoDamfYceMSqk1GFPA8zS58HfzxgKOpX3WNsFhPNlr8Tf?=
 =?us-ascii?Q?OCXdmLbCHsi4+aLLnR4BtpJYVtA/SBBnNFyQrfEwOVuPZ3maRvih/aYMLz+s?=
 =?us-ascii?Q?QpepZRIBG7/UiDJwIZ/JHtYaUr3RF4yi5b4cW5uNgLhHCBxVV6cOJRgMq834?=
 =?us-ascii?Q?0mwvNYYtI0QpKr+y0x1vyBY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afe76d7-5db2-435c-7678-08d9e50b214c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 22:43:41.9601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FLHctE8KUA+J+mDG6oEChYBD97AE+XaWiSXvvLJABC4clEto2wWCQrG4I4md8/804ewtULOw5cIe1JOtVjBDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1325
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 21, 2022 at 01:25:21PM +0100, Borislav Petkov wrote:
> On Tue, Dec 28, 2021 at 08:06:15PM +0000, Yazen Ghannam wrote:
> > diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> > index 4db92c77276f..a299c361a904 100644
> > --- a/drivers/edac/amd64_edac.c
> > +++ b/drivers/edac/amd64_edac.c
> > @@ -15,6 +15,31 @@ static struct msr __percpu *msrs;
> >  
> >  static struct amd64_family_type *fam_type;
> >  
> > +/* Family flag helpers */
> > +static inline u64 get_addr_cfg(void)
> > +{
> > +	if (fam_type->flags.zn_regs_v2)
> > +		return UMCCH_ADDR_CFG_DDR5;
> > +
> > +	return UMCCH_ADDR_CFG;
> > +}
> > +
> > +static inline u64 get_addr_mask_sec(void)
> > +{
> > +	if (fam_type->flags.zn_regs_v2)
> > +		return UMCCH_ADDR_MASK_SEC_DDR5;
> > +
> > +	return UMCCH_ADDR_MASK_SEC;
> > +}
> > +
> > +static inline u64 get_dimm_cfg(void)
> > +{
> > +	if (fam_type->flags.zn_regs_v2)
> > +		return UMCCH_DIMM_CFG_DDR5;
> > +
> > +	return UMCCH_DIMM_CFG;
> > +}
> 
> Yeah, you can do it either this way and have a lot of small functions
> or you can do what I did with mca_msr_reg() which is a single mapping
> function you then use everywhere.
> 
> Your call.
>

Yes, I'll do this.
 
> > +
> >  /* Per-node stuff */
> >  static struct ecc_settings **ecc_stngs;
> >  
> > @@ -1429,8 +1454,10 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
> >  		edac_dbg(1, "UMC%d x16 DIMMs present: %s\n",
> >  				i, (umc->dimm_cfg & BIT(7)) ? "yes" : "no");
> >  
> > -		if (pvt->dram_type == MEM_LRDDR4) {
> > -			amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_ADDR_CFG, &tmp);
> > +		if (pvt->dram_type == MEM_LRDDR4 || pvt->dram_type == MEM_LRDDR5) {
> 
> This still keeps the ->dram_type per pvt, which is per memory controller
> in amd64_edac nomenclature.
> 
> But AFAIR, we said last time that the DRAM type is per UMC now, as you
> do in the previous patch.
> 
> Which means, you either have to test umc->dimm_cfg to get the DRAM type
> here or push ->dram_type into the umc struct...
>

Yep, you're right. I'll cache the dram_type in the umc struct.

Thanks,
Yazen 
