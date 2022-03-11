Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B264D69C3
	for <lists+linux-edac@lfdr.de>; Fri, 11 Mar 2022 21:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiCKU5r (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Mar 2022 15:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiCKU5p (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Mar 2022 15:57:45 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8912077B4;
        Fri, 11 Mar 2022 12:56:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aK5Yp84vygy2MLiIBUqPhLHd3u9pH1xeEIwpykAJF15LiJENJ7RUbgCbmb31s+6enavHM/RDdhEhWt8leoYLnfwXhgVCHZKqW1YcJJ4fW/E62MNyvtYyfmZAqFk14AkuX2x0UOcj88V7wDwWNRj+tdom5wCdFcZmdwq3jCmlRQ2gOqn9e+Sxd+5ogPpJ5cfNy6dmw9BKUK7sxm9hnDF0w0gWFjXjhtIVC0/0I1VUxbdDb+RdqfeRb+cqVY69AngeV1jOt/RFkCKx5RG2G1mlGmv4FifPwHz2lXELThz8WyL/tc80ulmQc6KVBfZ1Nl9qujAXgKejdH07eyA4XS9THg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coNJsRdR1FEi1Lj6f3oI4BUpX66SJtVhMCAe0BhmEeo=;
 b=Q29oRQVLmgSuXRbFgjHr5lTJHgDYbS1Pw6JSSt5udlmNAQyuzQiwGNeO1II7szOwAfxWtcUHw/9FU9anx0NA//ajlgZQYcfptugE/FdAJVCjDuSf5w9zm7veMzxUJ/F7D1OAUEeUX7DU/+0qKmdcc55IgJXoU+wUTfoVEJOYZ92hhHqc6+LoD5VETW1fCoG+17j2HXojwrCWsiKGd1GJTgxpzk1snnRhhKe1JszYKg4NKF8byUIGsKUaDggNLBSLofMegib0aS0go6GOZvweoaDMQc9BkYTbqkxKp4mA12mdCUujhk21ZOjzGntRtKwgxOW0GvXjJDTUqREdyhnEuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coNJsRdR1FEi1Lj6f3oI4BUpX66SJtVhMCAe0BhmEeo=;
 b=FYWnbg1SNhhYJsAJG0CHdBOcTepKbDZXriQ31MgrHFW3TNBQRy4x8kWDQlzvuI7+JX3Ix4XqYob/IPjBbA4w2th4KFo/Ti24Z3fno1qDzQtV5hKNSF0XaQSYsdPUy4A2mc3KaOixXFSE89BtnHABLoYKnpKyBL9FUuhYZNOi3rY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Fri, 11 Mar
 2022 20:55:42 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::9df3:5cc7:c61e:ec6a]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::9df3:5cc7:c61e:ec6a%5]) with mapi id 15.20.5038.027; Fri, 11 Mar 2022
 20:55:42 +0000
Subject: Re: [PATCH v4 0/2] x86/mce: Handle error injection failure in
 mce-inject module
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20220214233640.70510-1-Smita.KoralahalliChannabasappa@amd.com>
From:   "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Message-ID: <f2d7c8fd-5178-a40b-7f15-5e0736388aa4@amd.com>
Date:   Fri, 11 Mar 2022 14:55:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <20220214233640.70510-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR07CA0108.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::49) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 271a7322-240f-4d93-879a-08da03a180e8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4387:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB43875C1D396411406EAEE18B900C9@DM6PR12MB4387.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UXUNd9cmUjBUwcT0acoHOFWHZcTflE/NG+7MgcB+OsZwKTiKG6GKOsYzalps/WODXKMWQTbpA+BViIMKVaT4aRKvmX4S/Z/RsHag0LY5VO/vxNlxu6oPzBnwD6dzbWTNlArvP4Is4OiVFuDH2ViAB2ygwFqG8saKFbX8hZ9yZs0eAkSE7QZmai/pt14KIGn/g7/KsiORDka0d7jiqnviYzjhzx9PgJQmn12gczz929BsBE265aOUkVNsJepGqK+DQw2iqVFQEdNYFdv3GNeNFbLhj18QTce8z1fF6LWKzk8D80HhlPK8Zw+5qZj0ylUfn5NFOj1YBLXI/vmjMrXyY07+KLiK2fSc2spDxGL8JpwkE+p8rg1t33WVrS+z7+V76Q2H6chjBHwflbg3RnSeS+JpILVkKQ7FInoObQhAitbKVuv1+vyPRpl7Chby7SGdrYTzkIVNrzyLLfPz9+4CJLIyOpYJ33L7VIkh3JZGe/XBJPn2CKAiq0bi+LsYXkZ0+aI6tTqqJTBYYl+ghGa8kNk4kgkBvQyT2Q8t6DEmf2eIF/bjLrXx4oUJbaCkAHa6AVEtm2q3wUIx1KdTGz+Rv8b8mnZ/rJG6x9VzN3JUWGrLuWU3rGig1QzSyDY6I2TaX8ljrz4+CKvLdr9JdoFqYQmVU1yr2kf/qfVIGBVkmMUU20XgGt31stIAPi0wAaX4SjnaplWIKeOLFt5jNi8g5JgqdUOc+CfzW3zfa7CBs6aBckdNfSo2eSrv5bnUNJc0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(66946007)(83380400001)(8936002)(4744005)(6486002)(5660300002)(316002)(66476007)(66556008)(4326008)(54906003)(8676002)(2616005)(186003)(508600001)(6666004)(6512007)(6506007)(2906002)(53546011)(36756003)(31686004)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2FTTlE2QWVEVjUvQUIzaVpGSlFxVzF3d0hKd3craWwyNUlKaEpuNm91OHpZ?=
 =?utf-8?B?UXUzaktKU0FGd2hNWGhGc3praUZqd2psQU1TRzNMVVlGd3F6ekdGY0hFV1BI?=
 =?utf-8?B?SCtGenpyOE5ncmhJa1FZbGJwa3FRRHpESWlFci9nYkVaK3FJYnR6TEdkNDBr?=
 =?utf-8?B?djFiN0lvYUR5SE4zaUZMbHRkOVlaQ2lRUHlZVXluM3ZxcnZoV0JpeHlyK2xh?=
 =?utf-8?B?SE5LMmJWNmF4UE96WEJNdnJnWCt0eHRJRjljOXE3SjAvMWtXS2V5S1JBaFBS?=
 =?utf-8?B?NTI2Sm13b3VRb1N0Rm9GWWV6UTVmUGlReGNocEUyVGF1bHZUdDNyS0ZlaWs1?=
 =?utf-8?B?cmdvVENUSTBCdTRWTGVBelRKd09KR1R4VkpxZFFmc09oU1BXYjdyQjNjVU9Q?=
 =?utf-8?B?dXR6T2EyREFBc1N2bDNUdHpmOFo1UjVjRzNWMS9vQkZjVzNuQWhBMkhUSzRT?=
 =?utf-8?B?aW56RkhrMHlNaUVHN25wZDdKSnJZK2RyUGx5TFdiOWV3YmRLbkEydFlMbzVM?=
 =?utf-8?B?ZmtjdC80OGJyejhWclB4VTJzcHk2ZzV2RE51MGNoVTNrMGU3VU9ubG9PQ1Bk?=
 =?utf-8?B?MzNjVHZhR2hMRXUwS3JXT280ZkhrZDdDNEtBNVBoUHlZTXRvNHZ5cFFJVmpI?=
 =?utf-8?B?WmxTY0hIT3hTNndvWDR1NHZVbE5WZEdFeUNyUjZiWHFoVGt4S2dDcnF4SnE2?=
 =?utf-8?B?S3FjTTNPejZrYTRuRWZpYXd2TEliT1Z3ZkFzS0JhdW5hS3JVMjYvdXJPRFZD?=
 =?utf-8?B?U01FWENmc0xpWUJlSjBXQy85QW1RSmNtK0JONTM3dTNrelZXYVdRZzMwbmtl?=
 =?utf-8?B?aWFpZ3p5aGRnNTFzSlB3dERtNGpSc1FOczBIRlJEUW1wSFBCRTVLaEM5cGxR?=
 =?utf-8?B?YzV4dStHclV3YkI5RlhkaStGa2s0cUcvbW5mTkVQVTh3aE5LNFZMUTFMaGlE?=
 =?utf-8?B?YWVWb0M1SjNpVzQzRGdIa2xELzJZc095K1JSb3Z6eXowWFlQWEZ4Y1J0blNv?=
 =?utf-8?B?Z0JRdldmNlhONUJ3enVmTHRlaVgxTzJURDRtNDdBYmNmTFN6aDdnbC9LWFNp?=
 =?utf-8?B?bjlkdVBFYWMzUFh3bXU2MW1aV3J1NDlPWVVMT2JpQXo3dzlDbVpSdzczUUtK?=
 =?utf-8?B?d0pNRGpHM29zUXlHL25zZ2crTUJVMDR1UkNVR3lHcllhNEpUd1hvNnF6ZEla?=
 =?utf-8?B?MkwxTHdKQnNkcU5oek1QTE10Q1dNcVFQZXhLK0w4NWd3UytSVFd5by9Td0Zu?=
 =?utf-8?B?Z2dSTllnRDhwWmVkajM4OXRBNFpsVVhXMkQ0T0RyOFc0enFWYzdzYjRwd1NO?=
 =?utf-8?B?d3RmMUlJVjNtdkY5U2FMWGZuRlJhSW9NdFlLYWNIdmx5b3Z2MjU4WnFDS0pG?=
 =?utf-8?B?YmVnSmxrc3BsWjRTTlg2RjdkcExrRHB6cU9UYkpwYW4yeVlUZWdWUklIUlEy?=
 =?utf-8?B?UmlVZm5CTXBiS1hYMzVpSnFLS0tPR3pBWG53TXh2aExBd0ZLQlJ1ejJSa1hF?=
 =?utf-8?B?REZPNnNSZ0ZjVytqdjNTM1VTaFAvM1NwSTlEcjdBTGdRVUZWT0p2bjB3eDBJ?=
 =?utf-8?B?aHplOXVpY2tTNEVtSE5TM1JOS2FrZ2dlWWtXZGdudHBoZFREMnc5RGpTRDcy?=
 =?utf-8?B?TEdNZDZhenlHTG5DdHh6b2JFbWoraTZwL1pDRjNzMytQT2JRTWYwNkpjY1FH?=
 =?utf-8?B?QmZsUmgrdm1qZmpUSFJHMnVENHhSTVllM0FSM1J1a295T2J1NTlJVmtnSTAv?=
 =?utf-8?B?eFkrSlp3YzVHSzJmYzBjdmNkNVlEZFVpNko1M3BGTnNmUWl2MzlqbVhnRkF4?=
 =?utf-8?B?QmpyOXpJVXRSMmpJQTZvVkZvVzllQ20xak1pU2xzVjdxYzJCVHRLQS90R2t6?=
 =?utf-8?B?ckJuRHdycDFRRUNwUDNZZG5UMy9FOTlBVG4rbEFVTk5naGw0dVJsNmpoMkZu?=
 =?utf-8?B?QUtjeFNvcnJJanYrWkpmbDdxZDI5RHFiWjBSQ2J4aHloNnhodlBocGpSNVZJ?=
 =?utf-8?B?RWJFaXd0bzdnR2xWSUJZT0xxdEpOTmJNQkdlaEtLOXRiQlRUR3Q3WTZmMk9p?=
 =?utf-8?Q?iQMUy+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271a7322-240f-4d93-879a-08da03a180e8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 20:55:41.7749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InoeZARzUbMoDuRoNw2loZaJb6f3xprlsnxodamO8kx8vs4nL/j0ZmOCreABW78ZwlH23eu2nPxX06oH9HHSxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi all,

Do you have any comments that needs to be addressed on these set of patches?

Thanks,
Smita.

On 2/14/22 5:36 PM, Smita Koralahalli wrote:

> This set of patches handles a scenario where error injection fails silently
> on mce-inject module and returns appropriate error code to userspace.
>
> Error injection fails if the platform enforces write ignored behavior on
> status registers and the first patch checks for writes ignored from
> MCA_STATUS register and returns appropriate error code to user.
>
> The second patch assigns and returns the error code to userspace when none
> of the CPUs are online.
>
> Smita Koralahalli (2):
>    x86/mce: Check for writes ignored in MCA_STATUS register
>    x86/mce/mce-inject: Return appropriate error code if CPUs are offline
>
>   arch/x86/kernel/cpu/mce/core.c   |  1 +
>   arch/x86/kernel/cpu/mce/inject.c | 42 +++++++++++++++++++++++++++++---
>   2 files changed, 39 insertions(+), 4 deletions(-)
>

