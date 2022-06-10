Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25AA546A5B
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jun 2022 18:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344557AbiFJQ3S (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 Jun 2022 12:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240625AbiFJQ3R (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 10 Jun 2022 12:29:17 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E4756749;
        Fri, 10 Jun 2022 09:29:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSJZj/r59HP+jOcqZYxBEa7sY3RcaJXaFLytPFkslKmUkCUVkwpkHpeTBmnShPwS+YbIMw1t5ZwdiOWIp8AwuXubplIRuYPYYt6K/XoIsPwukKxtZe9skgEfO6tIlcCbKjbC1+VwIyWUwEmz5F1fkuuVgVdn6x0v7+VB1tEhL557Y5m6XA7Ycf6wI9QFzM5jK4CR2W6uZvsg4enfC6ruGZLxuVx8J7JurfEeDp1/aTVvNSuCzoslJhCB4vW9UnCI6Y9IwNoDDMELiCzTiQ3qjFj/r940dpUq/N+4nGeU8QX/eWHKw2b/pKYPxzGAhIKmtgh/VjEyA9tgUu/nvI0oZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VD2X5/V95tnCsQux4Ogu8QyjioD+poLhVy+AFliiCo=;
 b=C19YRYnMyP2+4kAHApiM/qMzr9YNQkI0NBwgmW+uPgcwbTxy4sNhlnfD1h97GRyzl2CH/ejZBaVAcrPqDQYOyNb+KmKcWJ4ZHbR282f4jSIeg5EJ2l2sKXQ72FtKDpP34kQ/rK/lkbExd08eQF9Ays/0ZUoUIZzaqG5zZOZ7Vto457TKZ/nZ/JWqrqtLNe6CItDyWJwpplU0FwXAcwmhIyTtgODSDJvMYCWqXNTOGAFj3WzHiOg/j025cSprJz3skmNp9STcPk315wmD3g6ObGU2JUZj4Pwjh24XIqdEqZZQ71AxcU+05FQgCP3EfUPYrPr/lTcz6Cb5UZc15EW7BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VD2X5/V95tnCsQux4Ogu8QyjioD+poLhVy+AFliiCo=;
 b=GJ4qjP33+9yRHFgNL3OETlcAaT08AJxCoVlohSiY+HAoxGar9Pbh47axWzUcQ6ornB1ViS7ApP+MXAT1XVK+XLX9PE1VKZf/B0u3x3BUFK4NiVsWVAdEZdKa76y3s1t/opUirjpNUpTHCdKmCddN9EIhaDft/aQnRBKcWmi7sho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CY4PR12MB1767.namprd12.prod.outlook.com (2603:10b6:903:121::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Fri, 10 Jun
 2022 16:29:13 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9dfa:d871:2068:662f]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9dfa:d871:2068:662f%7]) with mapi id 15.20.5332.014; Fri, 10 Jun 2022
 16:29:13 +0000
Date:   Fri, 10 Jun 2022 16:29:09 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH 0/3] New SMCA Syndrome registers and FRU Text feature
Message-ID: <YqNxVXQvTeqUOSE7@yaz-fattaah>
References: <20220418174440.334336-1-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418174440.334336-1-yazen.ghannam@amd.com>
X-ClientProxiedBy: CH2PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:610:4e::13) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94f24714-89d0-408a-6993-08da4afe5af9
X-MS-TrafficTypeDiagnostic: CY4PR12MB1767:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB176783555B7D31BB0EB3F912F8A69@CY4PR12MB1767.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50akeT1ToNjZJUDsB6sNh6W83LCVrVPHwbgSjpZNZRCh9hFKOVq08lkTf0cuD834uNes0e9f3h1a/W+qaHX+n6NVtKNhJw7OIP0Noz9yVG2KwcWXsDcttaWEWeKoWaYGozNaHZuSwD22E1/Cq5Kny8xnoRZO3f24pWKDVqVMP2jdzh48e7+gCCAZrFCB4E0yvtoVodStLktnJE/EVH0IvO8WXy0V2/HZXozNckwNEW5FQzax0h+NpP2XwCN9jSWRdmmlq+JElAGG1skHC4S54CQDjbWPeXMa2b64vsFKd1UIx6CjvqJJTVmbcgwTl/NgaK73kWIrChGYy16hnxxE7oOuhRmNxh2k61RstHFwssAX15ieHX0iSs4geHpO8wAZ3+9RvaGhwn1tvNEkyk51RIxkrD9rcmllxIFUMUyM4LpWujL2/Dy0j+faqs4Rwm+riWxbsQxqpgYTyBKS+3+WgIOXObXXWHlVE2gSMWvhFmKLkm8NNo30rlQC055kxJkB4vrdItVPTnVU/DSn7JZxyfOm/6qq7R9uc8FFlVNAMj/UHPe6s1j6cwSmbfama5/c/5t5E78djUuYklPYdlVmXXSjOoJKFf/pKHmhSPs8Aa/RtgpDB/3t+lOIlLYodkZyvCXZQm9Mbx2wvpFBb2Q09Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(33716001)(5660300002)(66946007)(66476007)(66556008)(8676002)(4326008)(38100700002)(6916009)(44832011)(316002)(2906002)(6486002)(9686003)(83380400001)(6512007)(186003)(86362001)(8936002)(26005)(508600001)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?032fJB7rKiRx8btLeWf19JRNsqphH9uwJ0g/UKThpjAJWnjJ5VyraaT4eXEK?=
 =?us-ascii?Q?Jawn7bMAq1VSyBSo+tZgvG4TrfTg8DQQNYWjlG6CdcqFpz4NwN3ozdmwVOO7?=
 =?us-ascii?Q?lH1Y/tvRiFr3ePupAXdDrZu+uqVHP1xG4q68KlK3t9AkWZHEkm/PEWjocGvR?=
 =?us-ascii?Q?SjTjKVHPcOrW5BwGgd/3tdefhzjzj58e1wmYe8NwXj2kwHVwGzCMIKn6B4Fi?=
 =?us-ascii?Q?one2CnJcSX6c0L3j4lrJ9RinQCMrk+6JiSevTOmf0tBdZAgaX/JWSjq7Wfiw?=
 =?us-ascii?Q?T9JlK3kkqgincWBJh7l3S9LM1z+DjDi36n3ZDHc8YvGroDATLNXhtZCa5qSq?=
 =?us-ascii?Q?Q5wavvxf35hPwCXKsflpVp7Tkdrlfk5yZReZA04sB8eufzauVmIMOL7oGxxG?=
 =?us-ascii?Q?PAfDjSe5tbFRA9wIlMDzzkhUK12ibSQjBlaYzFN5fuuLeKX+qotvqTVM1/83?=
 =?us-ascii?Q?FaZCbb6Da8duQAB/8TLqJ1e0xly05gbLn08/qCwLVOFAl77G0+WLUbD7r1ch?=
 =?us-ascii?Q?MQMkqh8SkUcA3Qjyc5LbUNmwwSMVvGYBgyvr84ToVT697t2dVHyAampn2p2O?=
 =?us-ascii?Q?BIbVqn8Ub+wSMUaMUJtJUdjOKmFFOtz4UF5KK3KXYjYH1wWWge1ENHiVs0rg?=
 =?us-ascii?Q?e9jh74vKiTB+nJHQozMDM/rdRKOoc00W5HMyM/I0hkLeEWat8iUR4V9EvgQP?=
 =?us-ascii?Q?PV374FUQQ+7WgWGeACxByVtW97ImEsp/AyfaPth+30t1HiRa6Oe29NrR+8zJ?=
 =?us-ascii?Q?ihM/dTxXVixh/xPvKPoM7Wptdqhx09VzhNjrlqIym+4Unhu7dKrtZtG9QSmM?=
 =?us-ascii?Q?VlA4yl1Mwqz/y9eb/vKUAevocLccb3VqodleZDbZb0JYZhHntp+17P/wG0rc?=
 =?us-ascii?Q?S3TZQ+vInO2L8HfdhgTPj8dcUOQlsUEgYg0cH6fOtQFjvv32cWNzBj6adv60?=
 =?us-ascii?Q?joYQOqnKp4q6R2bfz5P5gyBc7iQ0igHZHsI3VNmFkje/47kYzHVczbFgZL/o?=
 =?us-ascii?Q?YuClGTZtD1lsuNNnmsteXOJWQoPtZne0wcYYFCnJl0tA9VnmiFki9AM3alkd?=
 =?us-ascii?Q?K9dem88Fu0vi0hU2ZhGK9Ro/6y2/ItYdcGQNKeV4VWQh2u7uC6phf2gZmaE6?=
 =?us-ascii?Q?paHqV1DvWVCqNxtCBYn65AXkZfbi8S+5kdXrlAaK+mxv4Br30Fa17epLHd5t?=
 =?us-ascii?Q?xNKx655ol23YI2yDmaoJT5do3I1zks0Ylb5eTYtWTa+68lP9GtqNrxJrnSLo?=
 =?us-ascii?Q?qe8Cx+yupZpdvg6KkoHn2aTH32qBG0dPZEIDWEpTQLoPbEf5DGxZXXTIden4?=
 =?us-ascii?Q?S/MnXbAJAm52Y44smRjobZl09XIsN/t8BMiQHdUe9dq5a7Ed6oAIUqHMzSh2?=
 =?us-ascii?Q?kci+1e/AXdmhb0VTqozlyC5di3DL+fRDkwsJ+tyX8fjQi8Q7Wikhl69oHo9R?=
 =?us-ascii?Q?ek5e00g8ND+Vrc5tU7MTgG/DJ8vD9eYuTLOzAY5y2kbCcHWvjpFU+1NmTSdD?=
 =?us-ascii?Q?eT6iyIIvy4tWxW1zYUJ9A4hHwxqgbnXEM0epAgR9FX+GIJAKUmqdIPWBEQ+r?=
 =?us-ascii?Q?2f8Pzf44QTJivbIysTvB1OnJpBj29WiBYKDxqrbZ1Pwg0ePNiwWnYLBiA3yj?=
 =?us-ascii?Q?TTbPkMVr/7L9JxYatUbGpW3g2qaFI4hYGAE1aZtUN4eze0P9htOmJsO7z13l?=
 =?us-ascii?Q?CGZDxsk/y6Hx1XYHCLrDJ4z49eFjOkRiBbXEZoDmAZm84xfoqH7QtVddItAD?=
 =?us-ascii?Q?TPtXzzfZxQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f24714-89d0-408a-6993-08da4afe5af9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 16:29:13.6821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/9v46iXgkL6QgvUYPdirhGh6GTbUc37V6Lf8fVmqp4XLrwPy6F8dcsynH+/VyOoPHVeCK1+j0JU+r1u3n/Ajw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1767
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Apr 18, 2022 at 05:44:37PM +0000, Yazen Ghannam wrote:
> Hello,
> 
> This patchset adds support for two new "syndrome" registers used in
> future AMD Scalable MCA (SMCA) systems and also a new "FRU Text in MCA"
> feature that uses these new registers.
> 
> Patch 1 adds support for the new registers. They are read/printed
> wherever the existing MCA_SYND register is used.
> 
> Patch 2 updates the function that pulls MCA information from UEFI x86
> Common Platform Error Records (CPERs) to handle systems that support the
> new registers.
> 
> Patch 3 adds support to the AMD MCE decoder module to detect and use the
> "FRU Text in MCA" feature which leverages the new registers.
> 
> Thanks,
> Yazen
> 
> Yazen Ghannam (3):
>   x86/MCE, EDAC/mce_amd: Add support for new MCA_SYND{1,2} registers
>   x86/MCE/APEI: Handle variable register array size
>   EDAC/mce_amd: Add support for FRU Text in MCA
> 
>  arch/x86/include/asm/mce.h      |  5 +++
>  arch/x86/include/uapi/asm/mce.h |  2 +
>  arch/x86/kernel/cpu/mce/amd.c   |  5 ++-
>  arch/x86/kernel/cpu/mce/apei.c  | 73 ++++++++++++++++++++++++++-------
>  arch/x86/kernel/cpu/mce/core.c  |  9 +++-
>  drivers/edac/mce_amd.c          | 24 ++++++++---
>  include/trace/events/mce.h      |  7 +++-
>  7 files changed, 103 insertions(+), 22 deletions(-)
> 
> -- 

Hi everyone,

Any comments on this set? Thanks!

-Yazen
