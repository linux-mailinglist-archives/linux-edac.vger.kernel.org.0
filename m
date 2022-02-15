Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA74B4B72D6
	for <lists+linux-edac@lfdr.de>; Tue, 15 Feb 2022 17:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238335AbiBOPtk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Feb 2022 10:49:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiBOPtk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Feb 2022 10:49:40 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D12241;
        Tue, 15 Feb 2022 07:49:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxf1u9F9gxhJUDvztdzcu0x+ge5iVmuy0+rrRvnQEbgs5b/+3Xqv16vrJxJXUv/JNsNiALD7enUvXw+oQvkb3ytlOpm1ximxZdZ0VQJInrUfjF43IDw0vt24wZiuI9AWHvRO49wwMbO8XgMR09P3NC3nuHQlvUFa/eQj1E4MKPPIqg6z6bkgctlRcohEYtzt/sPTCnU0IAg73F/7t7WVdAepXm0nIae8TCN4FKDYFqcekqZb3FgJwQL5OqWGYfyXrVdnfnFNO6pb7lOpv07ZajfQCD/95elMh/fg8AAakxl6U/2PGCr2Q8JwRf2m2t+axFZPSwsX0/nNZZ6e/eWVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/1Du4EXs63ZVDpdgQz9GicNWagI5Ks2qlFUbRZ2dyc=;
 b=VGQBuzJHsloKVyUsq7xfOcsTOxfYHXcmvyWKm2uyvmaM3uUMACcfStjOTkz8NS/i2AyLTplmJF5VhrDRKt/JsJGm348KT1G9kyIElSBIjtTP9C+vj53rUur34Y6sgj0AiEaf2rZ1OwcGSNnpjbwyXmRBf0CMw95RfvDQRpc2nSVx9IPGmRzTkfZLy2Oo1v1MytDCvUVarPBmK3VEcWZCywwBeVGxRSvQQ7sfkKjBfOl6r3e4Z3zl6oFSFF1eiraXASS9SyZmF2Fq9dnM6RAjfHftiSiK7eJPSWL3cvXQSZV9vJtI1NbyJtomgrMdNyCRixYbH1mZGxcN+NKlJxlnDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/1Du4EXs63ZVDpdgQz9GicNWagI5Ks2qlFUbRZ2dyc=;
 b=qb3127cDkTJHnIMAG/enPoa7VIw73UacjGvTQvTvxgO/WIUdBxgdreeHl+jGgoXVx6ft1xA//oXzXKzbIux/7UlX9NGsbeabt4o3+YBzMPK1wQtsc7LGj2nZBaHSgEBC6HDjRsdIhdsW3S34wNKd+wQllkD5oXpGIh0WkYgsJ4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM4PR12MB5151.namprd12.prod.outlook.com (2603:10b6:5:392::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 15:49:28 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a%6]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 15:49:28 +0000
Date:   Tue, 15 Feb 2022 15:49:25 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v7 05/12] EDAC/amd64: Define dynamic family ops routines
Message-ID: <YgvLhXVOX+upsE3a@yaz-ubuntu>
References: <20220203174942.31630-1-nchatrad@amd.com>
 <20220203174942.31630-6-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203174942.31630-6-nchatrad@amd.com>
X-ClientProxiedBy: BL0PR0102CA0049.prod.exchangelabs.com
 (2603:10b6:208:25::26) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01689294-5d72-4a28-a8cd-08d9f09abfc6
X-MS-TrafficTypeDiagnostic: DM4PR12MB5151:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5151F21574F0D171E6B3E165F8349@DM4PR12MB5151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5D4IlpCm8OD57r16mMZNbGEI9N8bQPcJ4DKFO3Fk6J5/53kG9huncx1XSLRfxwlDzieLgfnXH5n5Qtkf/C3GLmSflIw4aTBTeap3YTzRcDbwdSJdSwYW7H/NjIQdIs0NaD+HSowY3lLKW3OJ0eod4OO9uiWeepNq0FhfZ8NVBesMs50onaxJQ/WOTL1d3m1aSvT2qhE3+q9FAy97QFdwb53JhCqO0QchHPdrlrTS2OpYg8e7xitEG8H3wQXoHwlj0tX5dV2s74BaQFNRMj2+d7AG7W/xT+pMP21ZMMexsBqA9Kkmu216Af0H6+tSSGt1q7hab7PLBkrvdisIr4Jq7hrkJtydnGyKF0BQY8+3ouGtz7h2KYM9Yd2D7f+1mjaKch1vR+N30ZOzJ+kyaUlZOVgEJMtnwvGDbxgMRwLbDtmmKOtEVjQf9ouj7G/beryit5wcpol59oP9Z0RNKGsy8ylQFKOJZHnskuODQVkZcMNBYUr0GnmOYVT2hz8jjEGQ9ZDcaVOLvBsv2pZfz9iwhb/Usx/d98zH2BGvmaIeUu3DIzNjM4cL6BLTePUgeCDWbwsJkftt8U62PEpmJWU3iSB0yP1d3khD71E1dW76pSApZmpoXpyqtMjtUKiAJvW8B3AYcidtmuTPVufu6zSPBHejmZ9gkqqV+SAeOTuB68eb1ToSCDDq2lvZypYuFPNDYQVmkSzHZvz5WFr1c+uprw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(4326008)(8676002)(26005)(86362001)(66946007)(66476007)(66556008)(8936002)(186003)(6862004)(316002)(5660300002)(44832011)(6666004)(6636002)(2906002)(38100700002)(33716001)(6486002)(83380400001)(9686003)(6512007)(6506007)(508600001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M5Eaea+/WNYZX5jYBzLlBSmDTJHwrKL/EaPT+sq4WZ7SyZGkP3rju/+pKjLb?=
 =?us-ascii?Q?lLMrYvAN/EdaXHPu/jF3pKUzFc53ndu/oRkLC6EdrchrxQ+K9sVQrUBs7c5u?=
 =?us-ascii?Q?iEJEeWfs84i6mf+e+XwNYf52tpf31DV57anYvs5zuxjTmkM+YwaQfaw3huPT?=
 =?us-ascii?Q?Zs3Ws00ARUCtjVHKZk++FrNCXy8ovAmokyd0M3Bkun6BcWs/yGXsfp6DGdnE?=
 =?us-ascii?Q?/LNy9YTQpqPrSLIGLkw6dxsAomJOdYGpZZjgAx71Ja+DV03M0GBUPs6WNTT+?=
 =?us-ascii?Q?G7xYjwaOf7F1mVXx3/Jh24+9jdllbXH9Csswl3F9L8YkdBO0j4tT4BHVhri6?=
 =?us-ascii?Q?HqHudMg6aWnGCqMgWXgclWbCh17gSzgI3v6FS+qKW1vX30ebpDmFa5T7nDH3?=
 =?us-ascii?Q?5rfIX83jl2UHOmjk3zRbYib8qkzq0gzUQQVnl0FdZYfx1FpPH8c3lcIkgYBC?=
 =?us-ascii?Q?/cY/GcX8RUfrAURA9AKAXsDjckD26zoXQ+biS4lFIaUnvisx4DPRMlUAZpgB?=
 =?us-ascii?Q?fflM37hgyCcErAIJVRCi4EdaEKCTW/5stQR/+KuOpk4apnz3ikpBZwhdXR0h?=
 =?us-ascii?Q?rX6C1F3JriStzFjWIISWvQ/sL+hJoFT7saSW75K8yqFs+7emZxbBVhVxysEW?=
 =?us-ascii?Q?eseQc+ng+/WCVxSLepMdGnJl7d6AwTGq4b6BJiOk6utDXeXqxfTw1g4CXnkq?=
 =?us-ascii?Q?pdEtexbmwgcNXsFDIzDHs/8zQ36TFowqr92mns+kgiaJpS5fJD9NPknbjzmh?=
 =?us-ascii?Q?fKIPEuSAhGN/dbn4X7xTJXKpHOoZP5vCRyuswzT0+jxGRtCqKN6NOdMo/1E0?=
 =?us-ascii?Q?lddsX494YZjKfqm89LgKiuX1ZWyZ8YDzukYk6g7d8tqp0a7//BAgrmvTmBqj?=
 =?us-ascii?Q?P5CxRuw13bn7C9JtE12tJIF4Dc0tCUntmhjfY1CYhfToUssXksAP1Z6JNcP6?=
 =?us-ascii?Q?bQpLzhnwrDrDGt3FLvOl4yg+BhPOe7xYKAURtlU9FEj+kQJEvRQwulJ62KEI?=
 =?us-ascii?Q?zQR48v/NZ0tROOhjRmGlZV7GHv7HUIgByszR+oEKFNDVMS4o2zCCavXtZhbQ?=
 =?us-ascii?Q?NsR1Tz0A8WUZtCEam9OTZrMaXxsJqcKvKFCa/jsfINLMqRpRkvnsjltYAEVM?=
 =?us-ascii?Q?ZvSnwAxb4C3pjqhkrg0gocTm4zZyyEB/YU68uRlClMo8Y6Bggkpa5oD2bynO?=
 =?us-ascii?Q?hdaQ4OENDpvzsKYi48MDErzEdlmrr8BGJ/RywWxljV7c3BU5BbRdWZBTfhbq?=
 =?us-ascii?Q?HLFDwxgcr7eDg5Y31kgqe1plDO7Q8IxNg0DvVwy9Q8VbHGNDD+SZ9hZyiotV?=
 =?us-ascii?Q?2KzJsv9F7H13/LylXxk3esHKj8TK9h8VKGGY92Xeh1a9RHyhojxeErPT5Ztq?=
 =?us-ascii?Q?MSspPWTNhR8MjzM5L8AtvszEjN4s9rBuSjJvQQ+7uKn1zBcZoj5Dkq7cqmSy?=
 =?us-ascii?Q?lurzGHyhyzA9oo89q0hRdUoeuKzpLMTY04Cx+K8LErAInHMSETqTiTkPOAVL?=
 =?us-ascii?Q?/t3nTHK2pNXoisYnkhfyAy+lS+pm5C+ctxLEu8fwOoY1mQMjqFalA+YBN6i7?=
 =?us-ascii?Q?XhWw9xX5jy/yfOtpM0k/SHPuH90aUM9WV5jOnMp4bq5s7So6KAJJP+GZ3PPA?=
 =?us-ascii?Q?rDsTEIBHylz2KrydvLno6oc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01689294-5d72-4a28-a8cd-08d9f09abfc6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 15:49:28.3826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ba4DYBLLOIoB4Is73he7gDb1oLTJ67ObiMjmwvqx3F12BfblME2dmUkhOMvXYb1Y0z+Yi3rRJikSe872m5bMBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Feb 03, 2022 at 11:49:35AM -0600, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> Extending family-specific assignments dynamic.

The commit message doesn't clearly describe what the patch is about.

> This would simplify adding support for future platforms.
> 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---

...

> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -481,6 +481,19 @@ struct low_ops {
>  				     struct err_info *err);
>  	int  (*dbam_to_cs)(struct amd64_pvt *pvt, u8 dct,
>  			   unsigned int cs_mode, int cs_mask_nr);
> +	void (*prep_chip_selects)(struct amd64_pvt *pvt);
> +	void (*determine_memory_type)(struct amd64_pvt *pvt);
> +	void (*determine_ecc_sym_sz)(struct amd64_pvt *pvt);
> +	bool (*ecc_enabled)(struct amd64_pvt *pvt);
> +	void (*determine_edac_ctl_cap)(struct mem_ctl_info *mci, struct amd64_pvt *pvt);
> +	unsigned long (*determine_edac_cap)(struct amd64_pvt *pvt);
> +	int  (*get_cs_mode)(int dimm, u8 ctrl, struct amd64_pvt *pvt);
> +	void (*get_base_mask)(struct amd64_pvt *pvt);
> +	void (*dump_misc_regs)(struct amd64_pvt *pvt);
> +	void (*get_mc_regs)(struct amd64_pvt *pvt);
> +	void (*setup_mci_misc_attrs)(struct mem_ctl_info *mci);
> +	int  (*populate_csrows)(struct mem_ctl_info *mci);
> +	void (*get_umc_err_info)(struct mce *m, struct err_info *err);
>  };

I think there should be a patch for breaking out each of these functions.

Thanks,
Yazen
