Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A78B4F1DAB
	for <lists+linux-edac@lfdr.de>; Mon,  4 Apr 2022 23:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380495AbiDDVk1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 4 Apr 2022 17:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379921AbiDDSVl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 4 Apr 2022 14:21:41 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A5322BC5
        for <linux-edac@vger.kernel.org>; Mon,  4 Apr 2022 11:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMt2+XXWUkNX5YOlVdndxfKF4yBzXGaOJV8wKScQrxCAnOeUW6aaRGg0OW1YAZHg/NMxoInnaN1zItBk3gFVs+ZoxkxdMCF5vMZH1H+hBCrajvbQ2I+z0X26gTIsOMae7KomH3ZN/k7a3E86cSmpiv8DKmuZI+ma6Hs2bD9BVMuv3xjgCV/6CeBjNxalLZ+FUjrP96Bf8LojwY7oojYAtYwMRSY+2F4azyt8pDIbziGdM22xzK0X/9zB5mJn6J3pp6BoJ16iAzXHYlPyBRPqQGRRMy+FTpNC84zEsxhiHiq3M10F250LZMPq5+i485Fepaj/TmEnqfkkGs+mOhu/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GyZPmIyzSO3g1A0EDun/qrezon2gDUPTuwkxT+gczY=;
 b=dXWfLPKJm4//YnVAsbg+wT4Zj+TMOiFebWj8dM9DW35VBNH58MBHK+qdsJ8cpghzpfU40UL3OGg+dtb0HDgSKZ2+KOw9dLtr8iQe14KIZo0zZkZnG2lYG1rOwCVvK7/BijToLDGfXpib/ZNenTwu0sN9vV3ywDJNTphSDVZ18MZKG5yz4LivWa7RlWN+q8UnpqQOUhHWRwIaLam+kFPzqvhQEh+M6K4G3XNODi4zkOuj6Fw0vc757vXBATZYVyNZiPGOnrjJmxtOVm/WV8l4oSizzAsq0jsfh7o21WV70banK91JmgPfkG6tiNLoPx19HrrKBGyCaaEPvTyq6hQJOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GyZPmIyzSO3g1A0EDun/qrezon2gDUPTuwkxT+gczY=;
 b=sk83IHGB9efVSap1VbpsiKBR2N52z4wjO1A8CIvKRUinrlJ/smCdwCcN7akGYFAb1nhyAZWfv1tVc8nBsqcKm5OSHE0U/CqvgaJbt5srKrmVfETIpiPSjpPPvcKaG0IuqvDjl+989Y5c7uAHie34YOTxvZ/UJzxP9anE6HPp6s8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 18:19:43 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a941:fe42:23a5:c501]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a941:fe42:23a5:c501%3]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 18:19:42 +0000
Date:   Mon, 4 Apr 2022 18:19:36 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH 06/14] EDAC/amd64: Add get_mc_regs() into pvt->ops
Message-ID: <Yks2uNprjjQSO36/@yaz-ubuntu>
References: <20220228161354.54923-1-nchatrad@amd.com>
 <20220228161354.54923-7-nchatrad@amd.com>
 <YkHdZ1UWh9o016j1@yaz-ubuntu>
 <4f7e4f58-41d4-f08b-56ff-e0f83c4bfed3@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f7e4f58-41d4-f08b-56ff-e0f83c4bfed3@amd.com>
X-ClientProxiedBy: BLAPR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:208:32a::31) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2c7ea5d-5731-410e-0f2c-08da1667b09d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5205:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB52051B5D78D2E0511960EB82F8E59@BL1PR12MB5205.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0wU5O0xEds9zN/iWORkXbqC+bm57rMKbCsc6ktjqUXVmabQ4zwBjGFRrur13cqgN64G8JdKCm0fqKo2rmPM4KFLN5L3NBlDq0qsE6ina0PCBDTqB7rRgzHx+opbeMVES13ozOSH9lpm/IwR2rSHD0wes0/E6I1msci7wdf6sASs7fuKvcraPdjvThcDhVEMmksvrL8p+somBPsMzs+WoTOTh1ZL3y1r1se7AJZ5zowQI4MffUrMMLDff4velDO/zyFQZF7TsPK019nFwX7P0UAQjeO4s723fvRR/L/LXOtz++VzvMe9C4boqFLsWvA1OG4s3YBvyGlXU2/qifP2MK+erZ1IFD6GMZ2c/RhN6VPpDpBVP78zmbT/AmDaykjQINms8yYbGWzKlR/MJLODzXOfpV8YNfnPBwrKJMd+I9aX0Gbm+GG9BH6HLOSx7xxI1iEdzjRh2E8s3g37HPepMT5iMX+Oc/RrYtbtj3ITMG9aHbIFEsORin1d3Xq9Sl7t5SDeLGeoVT9RrgcaHl9LUxjCCF2iqYhO7iUiym8So9mfw03rRmIozG2Um0a/NkOSm0jHTsmUIBv/3v0EWKJVp3ubEnDawCfe4qlB0waGPWeBqrVnmyamuCbwt65yU1KYz7BLbFRSic7pbM/NmR6/9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(26005)(6636002)(6486002)(66476007)(8676002)(66946007)(508600001)(6862004)(66556008)(4326008)(186003)(316002)(6512007)(9686003)(38100700002)(33716001)(86362001)(2906002)(6506007)(8936002)(44832011)(83380400001)(6666004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BTJJaLCmr7Tvn++62BQVw6n4th5fN1Xg7nfXa5k7v3Utko7nsTEPZIpNqOc4?=
 =?us-ascii?Q?H/F3bkvIVnJ+Ez0IpWSED0PHtQvBVst9DJ7tXw3E4ktOY6G4Zk0pCfNCKGOM?=
 =?us-ascii?Q?nJkR7aSX/jB1eNWmU/jfxt2RgdWP1N28Ny/erahiDIeKso7zjO3SZ/Y+qA8z?=
 =?us-ascii?Q?ImoUE0kOwFppYe/cf1OGqDiMRgo2wasnKOT0mbKcNpy4cNEXFK2f5E0aSzZ+?=
 =?us-ascii?Q?ky2nyYR2hY/Wvj50WjOkeaNyFiq6YjRToZdm+D5HWOJlQCJR1jnrU8DBsM8o?=
 =?us-ascii?Q?9DmKtN//FMyklMVaxmF2dIttbJw7NenwkrCv5QVTWgVr4f8vb1XC3VLdIbmz?=
 =?us-ascii?Q?wqmf9o3aqznW3bne6GhcDZzPXQFrQtx8J/BQXo51GpSuRVRWKA/vkbvK14eB?=
 =?us-ascii?Q?k13H4SYnMkO3aTdLXBL4OIasPj1ZTGjFodcOZaoPjtAW/MJyQicQfgyQT+n5?=
 =?us-ascii?Q?RFuzTgDQLjuTPb0kYUNr2qW4D4dLydADct0PLlWJCLa6XKUOUxeg/7Yf23tE?=
 =?us-ascii?Q?zhuVrRfbrmHeJHDvuvtom18aCNmiYS4vF3FHn0WpOnJdHF/XZxggjqkr8qGD?=
 =?us-ascii?Q?fN/gf4PbfEPyBp2eTSvdeTKBXaz4iot+/Z4khpsn+L0+t2kGrCbeRr7G+RKu?=
 =?us-ascii?Q?kiCyfq26vW7FcaZglkV8DdUIULdLCxJsjz0qyho1fqedPocf7BcW9lIS1rS4?=
 =?us-ascii?Q?+7R5mxamjJ4x0E4Ars4ifW0egqGgXuXwwDDT5eKyarhzJuvMMUNgvnyMiix5?=
 =?us-ascii?Q?tDzcp5k4dXO7vMYGRPVPkwK7sNaR9Zs3OH0Q0ivL0LCUyJp/AlqmwuiQIdjA?=
 =?us-ascii?Q?AiSsYYrm2hmnjNcDNkf17h3J5THp+1ssCsTh5lnMbgXigopK0iF0Lz0o5g8R?=
 =?us-ascii?Q?9hbGENw/v8oAclvpNIYXBqe+cnZ+tkSf1spZwhENLhUPgsd4zuUKJV1YPpl7?=
 =?us-ascii?Q?IhQDINaSQz/a5zoa0hCO66LD2xEPA9HUAz6waucKkCVre3MZ50ZRFxd12RX/?=
 =?us-ascii?Q?xnvEFzMo7dKMr3RTpgcHWhbP1Yqcgi846nutlH0vEp2rmfuS8McSwx8A5xxo?=
 =?us-ascii?Q?GJG775nQkqJbJUrW3KPwc2gN+Vh3FoNRZ7mdAQMW6peMCGU6iDiquymY1CYJ?=
 =?us-ascii?Q?wQZD8fAtOAJikjpsPjK9c7MpTlj9WGfvuKtcsK/Wdi9XlU5fdCvaYaffVI5R?=
 =?us-ascii?Q?LIyv8xl3+7fbE+Y7eEdIP+093437l6FNVI+w/x5x/vJGcDwCskgTKDB+NzX6?=
 =?us-ascii?Q?oe4YPbktRM+8tCIUGgNEGnfzRqNN6qJ4f/Zohi/Uob4DW+FX/jSc+fEWC6rQ?=
 =?us-ascii?Q?6jndWItkiNjDNxeqnyza2t7Lk9vqtjGp2iK6oeWGd5RikpZoU1UCWNXIP7m7?=
 =?us-ascii?Q?DmMsUd30V9qBRxRcPK54qdU7Z9AkSKS46weKAs5wjH95uMUT8mCCD6W0Jq+n?=
 =?us-ascii?Q?tWwKSAinjcOjIjTfxfeyseOrnp0CHnctM2N+VvDt8hBa1U7+lX3XLNFguZtH?=
 =?us-ascii?Q?niR++maJt20DgUGTakaFNxZ9nLWOEgqL7jlQRGhhhSaJRzytwKtpCRoPj9p5?=
 =?us-ascii?Q?JSd1aVc1HTrGPAubxx/ZYRvWoCnIMt9Wjrb/gBQ/gV6xOrtVOB/LNT02hbVJ?=
 =?us-ascii?Q?t34FhdwO6Sy5ilkXjlMNXVr1ybgNLmw9RyHg6xihsNGGoUZMOsjpc43HB1hn?=
 =?us-ascii?Q?4CZ1H5Hk6vB0J2gqXoE31V/ldD4iH5NfWsmZdEkqDwxhrb7Ub5aSjEXlFZyJ?=
 =?us-ascii?Q?tpMXiv8oVw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c7ea5d-5731-410e-0f2c-08da1667b09d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 18:19:42.8434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AR0GXBP+FIblk/L4D5lyyoscisJCtW+gqKe2ro0tsi/GpHLO4+nu/pRyXztqfYZm+CMxA3xGUJXXAoiys9pICA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5205
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Mar 31, 2022 at 05:49:49PM +0530, Chatradhi, Naveen Krishna wrote:

...

> > > +static void read_top_mem_registers(struct amd64_pvt *pvt)
> > > +{
> > > +	u64 msr_val;
> > > +
> > > +	/*
> > > +	 * Retrieve TOP_MEM and TOP_MEM2; no masking off of reserved bits since
> > > +	 * those are Read-As-Zero.
> > > +	 */
> > > +	rdmsrl(MSR_K8_TOP_MEM1, pvt->top_mem);
> > > +	edac_dbg(0, "  TOP_MEM:  0x%016llx\n", pvt->top_mem);
> > > +
> > > +	/* Check first whether TOP_MEM2 is enabled: */
> > > +	rdmsrl(MSR_AMD64_SYSCFG, msr_val);
> > > +	if (msr_val & BIT(21)) {
> > > +		rdmsrl(MSR_K8_TOP_MEM2, pvt->top_mem2);
> > > +		edac_dbg(0, "  TOP_MEM2: 0x%016llx\n", pvt->top_mem2);
> > > +	} else {
> > > +		edac_dbg(0, "  TOP_MEM2 disabled\n");
> > > +	}
> > These two values are not used by any code within this module. They are only
> > used in debug print statements and debug sysfs entries. I think this code
> > should just be removed. An expert user who wants to know TOM and TOM2 can use
> > another method, like msr-tools, rather than recompile a kernel with
> > CONFIG_EDAC_DEBUG, etc.
> Make sense, do you think some users have developed scripts to parse the EDAC
> debug logs ?

I'm not aware of any users of this. But this isn't a robust interface like an
ABI.

Thanks,
Yazen
