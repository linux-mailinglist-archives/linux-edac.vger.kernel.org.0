Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CEB4DA4C6
	for <lists+linux-edac@lfdr.de>; Tue, 15 Mar 2022 22:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352039AbiCOVr5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Mar 2022 17:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352036AbiCOVrx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Mar 2022 17:47:53 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAF13CFD8;
        Tue, 15 Mar 2022 14:46:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFFfqbkZEFqGvXzOLvyHAlGtv6v96fNmGAcDMFQIM4xycTUryXhT8B/DM80R6Juj17ryCAULCy+LdEkRKuPYPQqBh5aaWeXq5bNlpkSQOuG2PXR5QPivF20ulE6o2gnM5VvHo716i4BZjh8UjW2cWOIDPzvFrRBDv/ezFN8qAjB+9PkB6gyQ0VoBbzVQ9SnNwE+GkWW/jlL6cEweldVNftsFZLPRztE4JavGDFEFanN6dQnBjN8A2C3GVSRgYhK2jKVqYudQfyEiQxdtDPAaxSAHdEbpFR44RF97TjRmNQH9okd2Sz4s0ExQEXx72Bz1dB4MXqOCQCHu2KFLS9Es8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBsbrKZp2/LnQz3Vt108jE94WcrYQ5cS40nQj+zLgcI=;
 b=NaLeZ0n6B3GRzXsPvNA0dEeDFftp45wbcgSjhYmo4pt6FD8wj1EZasskCN6mqq1qphH2mhpFp7bDpJQXlwigO6cIrFR+VZOYrjZuNLndyF7MxKv0NyYbj8dQtQ1MYn5fxsnEB+XV3d6pOZUsdclsfyKKEeML0NYl6Eu9tdECMXctzB3GQxDOeCgHp/pYtlDLn/sFDnqEErfjssePTU6zbM0O999zTNmnUKU7qKWWNeARjjAjM1XMMA9RmXb8gVH2gl0v6/+EMHSsqG9YKYhDx2egNFNPT5nB5rSh6VfXNK/CLf3LjYk1/TXhkl5gm5fD7VPZUQ2O94Rp3mRTngzA5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBsbrKZp2/LnQz3Vt108jE94WcrYQ5cS40nQj+zLgcI=;
 b=NsnK1h2/8iOHStM44PuZicG4E0c4kjaUSaWkV8ZiFykqv7yORGhW+9LHSD45cbx+IDgbbPzpWAIdsnqqexy4uyH7vN3RSc1SKbNao/tZ2HUUF3l8DqJ25ubo0wceEjXS0nO6v8lgTm6I8PxTy/HRvt+yLZVxvQpJ7Joysw5Lsys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by CH2PR12MB3686.namprd12.prod.outlook.com (2603:10b6:610:23::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 21:46:38 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::9df3:5cc7:c61e:ec6a]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::9df3:5cc7:c61e:ec6a%5]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 21:46:38 +0000
Subject: Re: [PATCH v2 0/2] New CMCI storm mitigation for Intel CPUs
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <Yg6FqR2cMZDwdBdi@agluck-desk3.sc.intel.com>
 <20220315181509.351704-1-tony.luck@intel.com> <YjDcN9XRa0teenD2@zn.tnic>
From:   "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Message-ID: <c8670520-e767-d0ec-b17b-5279ffa61450@amd.com>
Date:   Tue, 15 Mar 2022 16:46:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <YjDcN9XRa0teenD2@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::20) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7aa33b82-a5f9-48ce-2f49-08da06cd484c
X-MS-TrafficTypeDiagnostic: CH2PR12MB3686:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3686AAAD9A79CA9D11CA6C6890109@CH2PR12MB3686.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3zsZ/AZ/NnQog6qTSOqH8W0g5F0AZcN+CYhm7A7h+lVUTeK66tbc5CCOaYhUEw6kXJTsl7lAEiuhWNaIMMiZdJWHwzfVYM4OMGbnHPwQkD2QCybxNGO9jFT/47Dakubd42v7k134L4WkJ8Q/0LAtV/nE7sIiLVUArs5MxXU2Xl78BgR4xUG7S+bcwzq3e42GSF5rMwNUS2LMcSZH0Zt1+InMrOcZKRLEXPOqsItovHuFvNYYaNpHxKfe7PHtgz0sCB1tfyrEjuuPgIkMhNqSsbL6Bl4MCyIGE6Oqy8kE06nWzb8mnu2alaRTT+CcL0zZqO0U8nSVAJ8chMnxeoarjoiuUdzmDoPr33YH3xM6nzCGgbhUBWqe9o1OiyPNXwG7fQUyxq37RFKXZaE04+OaQk5EQeqBFK56DadCHm2EeKagzL2W4dQDJWgkjO0d7AS6F6TQR/cNUMogWpkqjbFRAGtqLH302k/Jeygdf6YMFvZBuAUmvrKeNDNv9agIFTPh9Jbmo9mMsrHywz47hIovMF5g+npedh2O6DzaIjN5gVImnYQCvnlhZ7rsVsTbLJJRYbfvjdsng0sUxiPbwM3SzQtADJkiduwF5i+MbZ00vR7+WzNO9YRToAcnGh6qdfAGdQXLMySHB8JCxq6Y42bHro6f37Avu50+EFie8oVbh3LPwtuXpRJ9VdhQLhZ8oGs+ukMhGHfkYzrJf41kHsqMMob4oRqMM+Urppf/jRD61Ps=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(316002)(6506007)(6512007)(110136005)(54906003)(508600001)(66556008)(66946007)(66476007)(83380400001)(36756003)(6486002)(4326008)(8676002)(31686004)(2906002)(31696002)(2616005)(8936002)(53546011)(38100700002)(5660300002)(186003)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzVEQjQzL1l6NFhQNWRIWEw1SGQycTYveTRwY2dNRGpRTWV4eHJ4b0djakhp?=
 =?utf-8?B?eEdSOFZKOFFicm1FWFhvSEtjV2tQQi9obXYvNTBQbXZWOTRVQXBNc050MFVk?=
 =?utf-8?B?cWU3NEQ1WWNPaXNRbnJpeGV0YjJ4VlJxZlFOeEVCNlNXZURHclpzVGpuc2x0?=
 =?utf-8?B?Y1JmM1huU3Jpd0RxaGd5WWNHV3Y4K01ERzZzVVRnMk9jNm5lSXZDMFlnQi9E?=
 =?utf-8?B?R1hzSENVT0RmLzNnTGdCS3pKNG1iN3IwNTVkV3ptMXI2bXdwdWZVOWFGWUQy?=
 =?utf-8?B?TlZKZHczY0o5aUlpN0p6MzRvM3hUd3dRUW44OEJYMFNFQkJONklDZFg5UXlL?=
 =?utf-8?B?bHRmM2txUkdSUGZvaTIxVjdCa0lnV0pyN1RJK1RoTzNTUEgrWjA3N1BTUnB1?=
 =?utf-8?B?Q3k3cEFkWXpQaklib1ZkbXpTSjg2SzNvWWVSclQweHRrcWZyZ2xkRUp0cGg4?=
 =?utf-8?B?OWRoenZkL0ZIVkRROExIOUwyd1A2eVRhVFpVRXpwWGdEdzE3Y3Jra1pvWGlm?=
 =?utf-8?B?aWc5N0Y4a0p1dlZrcUt1dlMrc0huS3dzS3RTdzBKUEk2S3ZjdElxTjEwT3pj?=
 =?utf-8?B?Y2NPOVFhUndzMVFjbkhzLzE2Z0JxMU9obmJXUnlhWlp6MmNHaEtPNkJDa3Q0?=
 =?utf-8?B?WFlqZHFiZmVQR1liZjBjZVlkblA2QUVBVDVqbnJ0UFh6b3o3aGI2ZWFEK241?=
 =?utf-8?B?eWczU2ZsS0xEQWR6V1pkTm9zWlJJblU1SHZDbmh2SlRIT3d4MmY5RERDOEpj?=
 =?utf-8?B?djlhU0pYZWpaTFR0bmJJaE5WS0p0OTBoYzZaNEhrYVM5RGIvclVsUHgrRmZ5?=
 =?utf-8?B?NndFNmMveThGUHZ4TmtYR1V1RVlUOHRhUGFXY1prNXd5Z0gxZ2VjMTk2MENU?=
 =?utf-8?B?QjA4a2ZyLzBmZm5tN1NsNHVqaFRhYndzRGtlWlBmeHNOYTQvbTVJYThSdGNv?=
 =?utf-8?B?L2VPU0pTMEg4MVJoMC8vWExteTUxV3Z3ZkNRV1JjSjhpK2Z1YksvVkZzSTlr?=
 =?utf-8?B?RkJ6OGFib2gycXlDUng0VC9hZVlENTZqYWczZkU1L0N0eUF1emRpZElnUWVk?=
 =?utf-8?B?MGtXUU5xVTFsQ21KZlFjekZFSFlHL0JmUTZ4cjdWeGRzNzZDVnBPRG5DQXFw?=
 =?utf-8?B?TUJWNlREbGpWNlJwZjBjK0o0MWVSWllhZHkyTmZza0M1ZkpQM3V1QUlVSUFk?=
 =?utf-8?B?ajJvQVg1SUg0aGhZc0xDSkUxOHQ4RTBJRTZnWnBPczJ3am5uR3I3aUZNN0Iz?=
 =?utf-8?B?aXN6bGxrSlhGOFY0dngwUWg0dVBncC9VMnFzSTBHeDRJdHF4c090WXpXdjhG?=
 =?utf-8?B?NnhYa0wvbEcxTnBIQWU4blpEeEZHQnZSOHJ5ajNWV2pLSmZaV0QxYVBaZ0Zm?=
 =?utf-8?B?eGg0YitwY0ZtY21BNnE1UzlRdGRDc1BlM3JVNElCMjk1dk1FaW9oSG41enVt?=
 =?utf-8?B?VlA4N1ZXaElLbmxxWkRMWFFydlo4d1FGVHQwb3A4SzdVdEZZRVFNekNLcFli?=
 =?utf-8?B?dnVIbmdFbTkxZkdvcURQYWM3QWhuaE1FWUd4VWFzZXdWZ2p0VnVqd1NjenVx?=
 =?utf-8?B?b1FUVEhBMGtETW4xamdJb3l3Q3RlZ2NxSEFrN2ppdnlvSWpTY05kNWo0QW5N?=
 =?utf-8?B?Rm9BQnBWeFhhbjNqTGc2TDJJTVpIdnhnVTNFZWcyL1BLKzcydnl5ZWl4WHpk?=
 =?utf-8?B?TWg4WHE2VllndXIyOUZTQ01NOUZzb1RrZDhzd3NBR2FQdWIrdDBPUndsSVM2?=
 =?utf-8?B?d0thQUJjZDVzWVNQbnpIdTV1amkrQlNPUkZxSVEzVk9CQXlYTzBMSDBnazlZ?=
 =?utf-8?B?UWNJMXpFVE92NjJBWldFMjcxREdvV1VxQUxlV3B1NU5zTmtrTStheVQ5UGxa?=
 =?utf-8?B?ZlowaTZXWEdKMHFuMVQySXNDWFRZeTFva1BEUElpakx2d0VEZjJqOW9KbkRU?=
 =?utf-8?B?b0NpLzFvbUU0N0NiazZZYU5MVTBqSW9QRnBDNHp5dzNiMTBJR1JNa0FPa0hR?=
 =?utf-8?B?MFRqdFJkS3JWYmpBeXlxaXlNczFiajBWUytKQVF3ZUpTWFQ5dTNWS2hXUUJW?=
 =?utf-8?Q?vWEmxn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa33b82-a5f9-48ce-2f49-08da06cd484c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 21:46:37.9079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4px+wzjVsrxbZB2IP4zLJZzcEeKMYZIipcqTNNmWco57BXNcgIPWmKQg+xDV/4cg21k7geUQo288jNcfG69HBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3686
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 3/15/22 1:34 PM, Borislav Petkov wrote:

> On Tue, Mar 15, 2022 at 11:15:07AM -0700, Tony Luck wrote:
>> Smita: Unless Boris finds a some more stuff for me to fix, this
>> version will be a better starting point to merge with your changes.
> Right, I'm wondering if AMD can use the same scheme so that abstracting
> out the hw-specific accesses (MSR writes, etc) would be enough...

Thanks Tony.

Agreed. Most of this would apply for AMD's threshold interrupts too.

Will come up with a merged patch and move the storm handling to
mce/core.c and just keep the hw-specific accesses separate for
Intel and AMD in their respective files.

Thanks
Smita.


