Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B993B624D1E
	for <lists+linux-edac@lfdr.de>; Thu, 10 Nov 2022 22:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiKJVgb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Nov 2022 16:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbiKJVg3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Nov 2022 16:36:29 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3E51C10C
        for <linux-edac@vger.kernel.org>; Thu, 10 Nov 2022 13:36:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U27fyLYrqvxij7pMPOEUJO3insOIE7vFBfuL1hOAt73bRXioVljfNWPxHXCy/04akluoJXs+tr+mPUbCsG+KySv/lBENbThf1nj43P+MinECP/cab0r6xiPEal7wUoOLRouds/ZQMwh1nTMpMVgR0UniOLL7WdftfTwyMm/gpHJw9PBVjjyqmJaPuG7pf3zLT+hRfqJW6w19FrjEVcOHbOLzpkjpXnXrsgy155kwuMVVvd4JRfHZTzj8UVOEJJ/RX/c1XSyu7BWBaCwSmh/rY2CWL1gaXm0ye7A6RJSfpRjTUKI1RsMDDj6XQPETi22Z/8vzi1rl/MJfY/0qpjtqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jT6UpuTD1MhZVtAOaZQDkg9KcU4NgpHb7CjxrH/rNXI=;
 b=cSQ6nsaPL7CLBEdJ3eavs0vDLOuRFlUd2ElNuPWuoJFiT13kdLJhlZOvJkX3J6dklY2CDctEM1TToXc7zhwHu/hXKDFODAzmVbanU6y4Zx6dzBloxUpsIPeZaH7lXpZBgxGPuE8FZSNBISPa7HehFbNbVZtC/S9E0uGvMBf+F118OW4gwvIP9jTD6RR7cChre+h/A9ywulphljNjwtS2UXJuNjIKR2torNQFx+T5GxV0BTVc8i9QRB4kgIjRm6uCe+pcsG4j3+Kz/0eABM/oU1LEIhAsYfvKXLd/tfqk12uzp8yXSzBjCYrEnj6T1ZHE7J8etqfJTro5dcngZUEfaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jT6UpuTD1MhZVtAOaZQDkg9KcU4NgpHb7CjxrH/rNXI=;
 b=NBmJVTGqOQDdgGmfraxDfQNjLeDZkAQvyVMbN+sCJIdHWVoFYQ4wp5QUujv4yGuowo4+AwtdVM9S3FjG4uB6lr77wPvr/b9JlYuR9GeUDHT4lz60l3GCuhL2u59+9Mqf+6WY6Uv1rc0O/zAAzZtMszyHJCamG6HDc/xwN4Mg4qQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SN7PR12MB7249.namprd12.prod.outlook.com (2603:10b6:806:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 21:36:26 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ee94:4f22:751d:278a]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ee94:4f22:751d:278a%7]) with mapi id 15.20.5813.012; Thu, 10 Nov 2022
 21:36:26 +0000
Date:   Thu, 10 Nov 2022 21:36:22 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Peng Wu <wupeng58@huawei.com>
Cc:     bp@alien8.de, mchehab@kernel.org, james.morse@arm.com,
        rric@kernel.org, linux-edac@vger.kernel.org, liwei391@huawei.com
Subject: Re: [PATCH] EDAC/amd64: fix possible leak in hw_info_get()
Message-ID: <Y21u1otQgMnmYzV7@yaz-fattaah>
References: <20221110025256.37599-1-wupeng58@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110025256.37599-1-wupeng58@huawei.com>
X-ClientProxiedBy: CH2PR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:610:54::19) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SN7PR12MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: 391215a9-8e6a-41fa-3ce8-08dac3639ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N/GHdutxHMmdSuKRX9zJfdX2kaL+wgwwjEEa3Pyt3ldelifIDNQCTiah3nZ/vf+szIP26yJBERN0lNHWAMuFX8lIDlV+4xXGV4mr6Hlm8oROFohE4kv+Yvx/4/jHiOBjY3uzT48WqPFvOfV0qSs6K0/N297JzaSAWKus2flo6sk4fMMLwW/UvRY7+hiQMCgdkZ1RADi40dHJ4Etn3/Z4v3q8KPfDJWCME/QPufj0iVn4vyqBh0aTnsdpLAOB9oz1SVua55vzArMUeIW/SOMn8km427A1MN3J911QMt9hPGWRum6Kti2Enn8yQGM+/AMkAwR18K09Mm9IdnDaAcGToxbi+2Pmoqfe53PRI0l3qi8uzqu67RofF4Ir69j6fvApmuPU8iyG0v3wn4bknRJ/Z1tC2hiZ9JTL9ilrcJKO+mSKGdNOGzf9VJiNaXhyOYUeGG8u8CLn2D0A/egG4WY9Pn1mrX0zdVtFSMNA28a1SyH29xaCAP7AnR1SxUwIgosrRc4CyPHPOqcPZIun4eDjSsfJoSpOQyZ2GEA5pAT9QWN89xHO26a6Eq5XN7q1zsSqlcUdezcFEjtL+hFRiwIuVoo6zjqsMySdKXSguv1+FLAnoQnz7d60FE7xps79vvOATPkXQK/6gKsTe5jPSPBIFwITcrJ88+3y5baRmDRCrMUi/54AnAKIAoIQZ6Ox2qw6YGEjIIimFnOESWSCadP/2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199015)(6506007)(41300700001)(186003)(5660300002)(83380400001)(6666004)(6916009)(38100700002)(316002)(9686003)(66556008)(66476007)(8936002)(4326008)(8676002)(66946007)(26005)(6512007)(86362001)(6486002)(478600001)(33716001)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z2opAAcv6u1safwFLMb0G9fqKhZdpy06dLFbl4708Z7Mk28UCpSXi/m/lvVr?=
 =?us-ascii?Q?PkhJBLENxl7sN/Sf9Bn5ifnq7+ZdnkZmmhLAsApaKyIZI0M2WzyBRW8ysFJe?=
 =?us-ascii?Q?HoShl+2jhDW0y9bw1LDd3CXCSv9XTapEu8kpdtKZUXwlp1E5qrVU2cuMR2e8?=
 =?us-ascii?Q?BfP0iNe1Qdfp9gCuZYeaFjq3ef5lC8AYhCb71wIpKYFYmKOLNI3VwJMxCCJ9?=
 =?us-ascii?Q?NZwvcUii8PtQofcVNL5wvmWWfivn1PiprmCcvTBfzVi8ASgyAhsvDXBvuAge?=
 =?us-ascii?Q?xO6J5B+bX8UQ493a/AwOpy8j5Yvw8euHE0ra6GYico/TWG9uwZLA2Rjmj26Y?=
 =?us-ascii?Q?gWPq7O3efcxy+SgOOy4R1TkwuwZ5Xu7NTcN0DUUtOptH0itL927N1fyPBcod?=
 =?us-ascii?Q?swuHJB4E1wNOUzw11AuwW4ps3gubRXzs9puiVVy7NKgBbOPO2uiM+NkRO3cW?=
 =?us-ascii?Q?Jg4/bUwo0LIWNGpGpMkv96ME12iXi4ObwfAicq1jSnUQXGsLuok/YbAtARFd?=
 =?us-ascii?Q?cZ55oFgbX7aG5DJA0LC5sRVVmJUGrMTEFzEBlE4ftjZRy9gg/tt5QA5NS9KA?=
 =?us-ascii?Q?sILGOK1D66aFiLcYsTCAwAPiaiqM0Usg4rp/BsGeBdGRPEw+KG4LzUwg6EGm?=
 =?us-ascii?Q?i88mpcK8GKHtvu33oqf0y0cDEop4uLWMloI7MexXA0xKXYJ7IB6KmGf3JQDg?=
 =?us-ascii?Q?EvxLQhyvTLi9aZMQ8PXOpvLceeSCJzaeQqG5VeS2x49rl9H1YRnXHiSGPQD8?=
 =?us-ascii?Q?uLA/CpRqoCH7YfGaMNSxHv5AjgjEEeCeVJ9IQYOWzrvhAb1foSGYuBG5lWay?=
 =?us-ascii?Q?Kzmui0X5oogaAOHO74kXbDfCW6thsbcaseKCp0JqvMGwNlg6IQojadiqwHm6?=
 =?us-ascii?Q?T3UFALnPqkDFrTnPv2yjJ4HdWyl8qZhsUqD6iOeifX6AkCzN/U8jY/wwI3bK?=
 =?us-ascii?Q?7uC98TcCZBLCnM+6dO1Fc3hydsLK82fecQqdHKNjveaZ/N5vMBEDq0WaBGn+?=
 =?us-ascii?Q?m/3O2KkpTS1K6GsNRC8wlM8CYWY1oAcGOIn4Ox0i7VJEtQV6yM+2jddne0dJ?=
 =?us-ascii?Q?im6SReL/Vis7+DlCPPFK1PhZ5qqL1X1YaqCPVmTaWBJN2yxDXr3LN8GdXp66?=
 =?us-ascii?Q?/Q7xpHhUyQ7Icq05mWJqXhTPSw+BXOu26HuqWgdvhFWdkk6qiOrbPsxWAXMD?=
 =?us-ascii?Q?kD3JUJAzMlTX18SFef3S4jZRkFvEKaqSGyC2eruHG0qatx9BJbRW3bhbqzFu?=
 =?us-ascii?Q?CtwBjgGY/hgu5XHg6dK0Ur2TxAi41jvcOnf+YJ26hQPXDCk7joTCTXVN2sna?=
 =?us-ascii?Q?88VsESNABiO4ndVm+zYWRHXOBRoox43j2VR2cpTo+5JxeRQXqAglNacg4mhf?=
 =?us-ascii?Q?n8YXYFDzrg2b6ybT9iFjTxLcJFtNr8OpU8sr2ar5rwtX2OGpjfIeawxQ8uuO?=
 =?us-ascii?Q?2YIeHWL9X2qg2J/pBJVCwAYLGt1AWwAZbPKPLN1llukE7o0zyqkkaHYhqTVH?=
 =?us-ascii?Q?mcGRUPDJ5LLijeeF5qoE1jE8s6EwVjT5Y2uQq8PkzQkcIDIvvJWYM5EhLPMq?=
 =?us-ascii?Q?RcnS+BPWyRjnplSrCuS8U1X8K/OQdSJcQYRbyulM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391215a9-8e6a-41fa-3ce8-08dac3639ee0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 21:36:26.6333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xztkLul7rgbQKilYNPCsfhL82bcUFnT2FAZCCVuryGO6lNTFDy1l2gSzhC3kXAX+0RwXWjGxDB1p8t5zwcv7ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7249
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Nov 10, 2022 at 02:52:56AM +0000, Peng Wu wrote:
> Add missing kfree() in an error path in hw_info_get()
> to avoid a memory leak.
> 
> Fixes: 80355a3b2db9 ("EDAC/amd64: Gather hardware information early")
> Signed-off-by: Peng Wu <wupeng58@huawei.com>
> ---
>  drivers/edac/amd64_edac.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 2f854feeeb23..b64b774eb974 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -4108,8 +4108,10 @@ static int hw_info_get(struct amd64_pvt *pvt)
>  	}
>  
>  	ret = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
> -	if (ret)
> +	if (ret) {
> +		kfree(pvt->umc);
>  		return ret;
> +	}
>  
>  	read_mc_regs(pvt);
>  
> -- 

Hi Peng Wu,

Thank you for your submisssion.

This is already handled in the error path.

If hw_info_get() fails, then we jump to the "err_enable" label in
probe_one_instance(). This calls hw_info_put() which frees the "umc" array.

Is there a case where this path isn't followed?

Thanks,
Yazen
