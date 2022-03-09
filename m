Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FB94D3C45
	for <lists+linux-edac@lfdr.de>; Wed,  9 Mar 2022 22:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiCIVoL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Mar 2022 16:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238429AbiCIVoK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Mar 2022 16:44:10 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2066.outbound.protection.outlook.com [40.107.96.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA0F31239;
        Wed,  9 Mar 2022 13:43:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImL+GRdvYbaTJagM8CH12EUAQIf7DK9VFLB/n8moOXLFWCc92U6JBenMmv/QNG4yDAR6dRodo4VCGTpbMrvh49pOTUJ3QDL/X5TIaw+KV/GPgZU82/wcTVlSUK0Xrg000awBS0sI8iqrbSJm6gYj2y9t2EeUs13+GoJ91Ge+77bEnhf0koagyfi2iKRtjDX1/K0pG5M3B+IvSwyhW6Br7tAT48y15WCUznwzf1sEdnIBA1deCVuCbLaP0BJ58j2dJFKvj63GVUZMJfTbFrYRK75yvZ52NQ0y+5r5A135OlxZomXyVTFqVfuMiQHTpb3U6TTJ44F6hyTx7VV82BHAtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdpw1yJ4sqE1mUH8iaPVOjpc7w4bTFI5SxB4O6KpJ0U=;
 b=hJPV+Te+2teHURPYaiQLy8S8H6ooP+tutLc4fmgWOau4fGE5gy/lX9+Cj9EBWxdPDLSI82oyRNsgHY/6k68+RSoW4wbsn8ln2Ps08VUn1hBskC6hXLuM8OiVbVe8fDfzufzr5ycyGss/hePXhpwj32fIcXzO9yUtI8mpd50RtA/S6sctUslYA7GiyQKS4Buvxv8GL9bgUK6gYVMNofVjR6PGOTLJ/7OklHy4+QF6xYaVXg0fOQRkQ5ddTqPZ3yZPU/ZAzcqFoiS5qFJCL3c85Ml1sgPkgE4RN7P9mkHEdwW88tHZmXbtzkv9FRy913D2fyjacwIkHNG2LO5frLjJiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdpw1yJ4sqE1mUH8iaPVOjpc7w4bTFI5SxB4O6KpJ0U=;
 b=2E47m3j89wxcZx6CofsNBDO4Vqb2rdyYGl9KqFZ2TaqB3qZgLEVMauBsax2HrnguhvWZOIfOvNFy6dUeZqsdQjA4760RKg6KWFupfR1+kRbIH14KQzSXclnXfhtK0qGHArMslQ1xNsceu9jdMTrda2yTSthkMSZVn8TOSpfYEuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB0241.namprd12.prod.outlook.com (2603:10b6:405:58::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Wed, 9 Mar
 2022 21:43:09 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ad74:927:9e6:d2cd]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ad74:927:9e6:d2cd%2]) with mapi id 15.20.5038.029; Wed, 9 Mar 2022
 21:43:09 +0000
Date:   Wed, 9 Mar 2022 21:43:05 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v4 02/24] EDAC/amd64: Define functions for DramOffset
Message-ID: <YikfaT7mXWRj7eAh@yaz-ubuntu>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
 <20220127204115.384161-3-yazen.ghannam@amd.com>
 <Yga3oWKqg7TK6lWZ@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yga3oWKqg7TK6lWZ@zn.tnic>
X-ClientProxiedBy: CH2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:610:50::35) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cf3e51b-23f4-4fe5-4a12-08da0215cd60
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0241:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0241FE469168B9E7ED89F906F80A9@BN6PR1201MB0241.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHeMbFTcuwleeJodKWkZwVUwpKJLmEMIZ9D1i7gM/lKSzm8BcYwyEOOHipB48ZVEwD2WuJvnJEOb8x25V6URbs/voIdh+k1q2whQnwLsncWPEkj1aTOSxkMF/lF2T7pedhj8KrF8K81EdrAOJm8pqcYKA+INvBhREievqZe+ARIb8SX9uKwPbjTsw6eytFswlY0uj20Ug8NGWQE1Lz1cdMmsqpuTVvzmY4fahVw3vWFY3wak7SuVGhek1pt93JPLS8pWrGaMLQKsZO7rVAdsVjI538lIWsqmL0JloGi5tLfyY3AuKRUeQYo3w8XZR0y9tEEDEY0s2hQS8bk6juRWFY1zOIf19Fjsy5wAuyHrAwhg4e4B0jkSn+Ar7whlPZFi65Sf6Ib53UvUioGSiB5rcKzqA3AtjUu8JDKlGYeCJ5JDRfknDewYT21VJgZyrwGGDcnMgYDVFJkRGxZLH8m6rXXE1Tu7R1pm4Ye/X8yr8vRzI5X79CfJF74gqpdTGU6awV79SMqfzdcXg08WkFiNh7HO7Q2VzjCflqB2Q0BPIIf+KukeHcK/Hvuubahayi0DQR4NeiDl3er3azx8WRxC+cYnaareYrx96MYZ0wpdfBsdzpO4eSaRVan/FehMSTrIk85GKEz83P4I4TRlXjIOhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(5660300002)(4744005)(8936002)(26005)(44832011)(508600001)(186003)(4326008)(33716001)(66946007)(66556008)(66476007)(9686003)(6506007)(6512007)(86362001)(6666004)(8676002)(2906002)(6486002)(38100700002)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BEniRqHYg1Ocq1rZDSrAF1LRM0HLQ74b9EkOmQVRopaWrnPPgberZSWHeD6k?=
 =?us-ascii?Q?b0GhWn01aWM6tBe5LFJg8eO+2FDotlrEA9hvIEtTj1NQ37EioO3Fq792eKL1?=
 =?us-ascii?Q?8W8IceMpLV2rNsPHCUJ0KbzgcrovItSXElj4YBmNlMFbmSne4onM+9km1Hfp?=
 =?us-ascii?Q?KEXwjSSqNpHQZV4+d+tHQbcn+9u9PJYez2p3QLmZYpATLjWMaTUjgP6W735A?=
 =?us-ascii?Q?D6bgZ+JY+R59CwVoYwOmCOjD4mcQq2QRQ7gTlma3CyKxoLxLSc8/9QhqgKlE?=
 =?us-ascii?Q?j/Ix19wruVVGNbWNYEFMWg4SXnEk3tUumnc5HVo8ijqfNNOorph12pemW0ys?=
 =?us-ascii?Q?LnowQd6PZSGZhNUiK6GQYlCq+WwTvAAZFVFa16iFBjd5/N/AiwUZUtVrkZZZ?=
 =?us-ascii?Q?02KTqMs6KAgAWeJGw+ghVrS6ri2pfiuftGDqY1Tv5errAvmZDNKcXSL637Zh?=
 =?us-ascii?Q?peR2YpbMA35xVCI/dnUjKTHxw7Ie5HZBS4AhZOwYWsNmDX+VXLxn65oeLDF1?=
 =?us-ascii?Q?UGw/NFn1aNjcbrZnY9Yrujxm/qq3+8eV8yHRH0HhTTiDpL+3qzrClpiUJ/XB?=
 =?us-ascii?Q?x8oK57IY8k1dGKDfHh95OB7Z3SP44VuNzxmRFwGNZrEc0v5HV0GiiIdrpnQI?=
 =?us-ascii?Q?ymquHq6AfNwUewtiWJ0Q1clUcbSRicTx2p810wHlvsGlQMOnDCCMEUZGXwJS?=
 =?us-ascii?Q?mhygvR/ELlTUIjTApjMOB4d8FP6pPdNZXENsU0NW/5NjNQhPrHU+YeevTKXF?=
 =?us-ascii?Q?icFuHe8vKWbqtLzMvFFTXfvDncklYdwNGh573y/FLrnSzuZUDnjPRtanh9gj?=
 =?us-ascii?Q?nZfM/dKFGe0hR5Hj2ivw6gp3+sOIP2MsGb9LKcjtSF3MwMBZKbc4gAv3UCen?=
 =?us-ascii?Q?iwOLVMxaL+bkoPahxscjp0yTtVAB+wKOGmVMrEBZ1z8c8nnaPPZLdt5LM4F6?=
 =?us-ascii?Q?/PXnPyU32nBuQzi5BxYnsp9Dvz98daN+8J8cLrD++HlS+x/9/YqQlTYh8bNp?=
 =?us-ascii?Q?252YKHOwdg9+9+MdO1VRwxo3plYJVQl91IEse685ItxYHmbXakAT2cwH5gjo?=
 =?us-ascii?Q?x6vh2Ik5Gd/1/3oMQOs2c45D82WpZut8xJ1v2+/SiaKNdQgd2k/pXfRN27Vv?=
 =?us-ascii?Q?lcTsCI/iSriTclGyAayBBY9zt9/DtJlYs4yY6TnHL6IbDP4midWWTfdmbMw3?=
 =?us-ascii?Q?Z+zH0ZRV8n/hDbAxHuk2BVxMyOabIXpv79iSo7hWiKq5iT4BKkTyOLXbGqW0?=
 =?us-ascii?Q?QSliImuZsRYYeWXP+PjrgircRVtmsrSiZYoWJDfWQXXOIZQjn97r98GRR3mH?=
 =?us-ascii?Q?eHxzfHH/JXcO6z4TkSuInLhpwzWpmn4fGLXu04MbSLKpnCHO33qZf8Hqoqfl?=
 =?us-ascii?Q?+TdWrwrrOsvxnhOYCqmeiRQeVcRaqBS02kAlq6tWeD3xCIGilDQ0nPi6oJdH?=
 =?us-ascii?Q?G67yXHMx7GnEWR8X4m4PqfbJ09zzOlBn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf3e51b-23f4-4fe5-4a12-08da0215cd60
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 21:43:09.0804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYGDnFc7oD1bTbNiSYrefRoGcNCpDuwNwegu6l18Hib+6rKSnQoOwYnzhoIFpaP0yZ8XuIkJXfgH7KRb/zlwKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0241
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Feb 11, 2022 at 08:23:13PM +0100, Borislav Petkov wrote:
> On Thu, Jan 27, 2022 at 08:40:53PM +0000, Yazen Ghannam wrote:
> > @@ -1099,22 +1140,13 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
> >  	ctx.nid = nid;
> >  	ctx.inst_id = umc;
> >  
> > -	/* Read D18F0x1B4 (DramOffset), check if base 1 is used. */
> > -	if (df_indirect_read_instance(nid, 0, 0x1B4, umc, &ctx.tmp))
> > +	if (remove_dram_offset(&ctx)) {
> > +		pr_debug("Failed to remove DRAM offset");
> 
> You don't need that pr_debug - remove_dram_offset() already has one for
> the single error case.
>

Yep, will remove.

Thanks,
Yazen 
