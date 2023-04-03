Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE716D4E96
	for <lists+linux-edac@lfdr.de>; Mon,  3 Apr 2023 19:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjDCRCS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 3 Apr 2023 13:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjDCRCP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 3 Apr 2023 13:02:15 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F402A30C8;
        Mon,  3 Apr 2023 10:02:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKCHR7rg1dmn0RK5UUWju5baUMJmWv9V8oqsmopZtJm2KPE+5EC60pRpwuKV1IH/Tn9rFPd9+PEfCH8o2vum0Hnmnx+p2aXWOXDpbPYq6+M+VJQVOEJLxRlIzW2YweaylX5a2LAkFyR84USONjLQoiSkyWjRUTO52qUYIZEArcx6TZoAO+wnCFpbHnxVkYTb3yikToRdlYDvhTi4gllNDHSBwHc+cjS3/5qDllLi/WK1hpuMzDToV55EasghJMrGgfXajhnIC3/o4p80JxxvMSBYMiViq3RKsXPAW9y6j/9fQz0fqwy+h2ev5FtJ/2D8gWnvIcxyMfU+ScFccB4nng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3IH1Nzcd6gzsA9/jZZTVaIfxHlmlIytlxbWDXUY8xQ=;
 b=F9xITY2+TCti+6Lp0MbrfmPPCkcYXP/dRIZO6wxfNwIzq/anUTPf/Q1Trrt6+rivfmlu1pzgtldGQHQWhF99ac3s9fTtBnmTykP6t0lFvqjhPAjHellWtwWIhha/szmX1yXZqI7wVhFPygv/LyLMPDK2OeV3ewMQ3j9J3zvg4Jwd63uU32DZjRHyUr85ysgM4+coprD9lH3UL9hiw9CGzZ6s3cAjF5gG0Y8D5xkMJdLQ0rJF/GS6UzCNddBIVIcpVuASblkMj1s2yvTUTFXxkZh7WQmjWB9rC24fXn5gFkBEdc/AJYNiVLd8K1wSi5QVXWpaUOmrWcm47Gbi6NI2fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3IH1Nzcd6gzsA9/jZZTVaIfxHlmlIytlxbWDXUY8xQ=;
 b=UErNbMwX4/sf0QR4YcUa4kfTczs2xNMTCPuy2afhA1X/XLveet+dODKiuOJKEnLqIXNf6ZyEZCSkX2PGFtVnlxPg+BlETE2sReHlb58FnmjtHbenPr0Yd628zXH9vAsqXolib/Qnog4vTmzf/fPnkv6HGR7aUeF0dkdpvRa1ERI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM4PR12MB5310.namprd12.prod.outlook.com (2603:10b6:5:39e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 17:02:06 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45%6]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 17:02:05 +0000
Message-ID: <5aed9905-78ed-4c3c-9212-3bb826cd5846@amd.com>
Date:   Mon, 3 Apr 2023 13:02:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Cc:     yazen.ghannam@amd.com, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] EDAC/amd64: clean up some inconsistent indentings
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>
References: <20230330012057.114811-1-yang.lee@linux.alibaba.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230330012057.114811-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0141.namprd04.prod.outlook.com
 (2603:10b6:408:ed::26) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DM4PR12MB5310:EE_
X-MS-Office365-Filtering-Correlation-Id: f2628fe1-21b0-4759-df90-08db346526f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c/RW2G8hKMUzpNjoL7YCeu0ZhU/I6JkIhb9ekBcj3NeQzjCE283ZOu0if5JZELIVNofA5gs8zQtB9+/KsBppquwHySgI7BLPafj0SKiK7RAjWIIli7cdBZv4KN/syxJVn6gprNp1wTSFi2R/gF6iVE5MRTq5mBSup5NqwAfBdu5LmtsLQTLmbD7OE1BDsMTzk1wYNcgLARkJBKWesPEm+V5Heyr/QpW6NT5rh2NravC5kt8nYT3Kr+o9b46GKSjTy+E9aYSnL0hQ/fuAN+/O6fhrGNcyutpv6N/EUWTth9lYapMPFsUFwEIBYlgr7XUxWIaJy+Qzc1cE22tPDAWB+ZGenS8VQ/cuplKEhAg2mkbtalRgiEeQs6+sESIakyfdq3yeKnLJBAgnUnJN5dUGLaHMgWNFYs4ehM09TeUZ8dWJKvivLWx5Wtz6iZsuMJqvUGr18SX7aT8VYBWLOISAbPFohd5CB1G1lfwMk3INfUQ2k9hVxln9wE5QyRt+leufdnpBJGFHi7gPsnTo+XpynZI1nESoRs7TI4ZaJcKVl/Ypi5lMJkLVkyvXqhtsnyPt7eSyWrxalKDGEexFLhbN5+dSg3/bQjbjR9cwg6K2SQbNX9svijadxT6YQBMjJ670
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199021)(966005)(31686004)(6666004)(186003)(26005)(53546011)(2906002)(5660300002)(31696002)(86362001)(8936002)(4744005)(44832011)(478600001)(6512007)(66946007)(66476007)(316002)(6916009)(4326008)(6506007)(83380400001)(41300700001)(2616005)(36756003)(38100700002)(8676002)(66556008)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUdZanlOaXRtekRhOWNLY0tFcE1IRkFTU3QzNHpkdFZHR0pCOGlsODZCY04r?=
 =?utf-8?B?OXZNN3ZXZlloUFVXdStnVjNONTlQQ0JONElWOWNMRVFBSHJ6TTlGNUs0Q2l1?=
 =?utf-8?B?YnZnaHJWY3JEREtsMHZ1Nm5nMEtESUU3UndFUkx1NXZJeWdlR3ZCMEt3SjNR?=
 =?utf-8?B?T2hlNDJwNGViOWs1bVZnK1RoN0RRN2ZWQ2s4NVp6dThYNGxtbkN4eXc4S1lI?=
 =?utf-8?B?clhaVFVJWERlaFRuT01ZWTdua1BpVzdkVkVKVktpbXRYS3ZROUR2UFE3YnZ5?=
 =?utf-8?B?SGd5NlhWOWI0N3RXTGpPczlCUk5tNFNkRFdvNHg5bWdZN0wxcWkvLzhhYUVM?=
 =?utf-8?B?dFFSUVo4Y1MyMjQ4SkpWa1pyS3J1NHJCODVrSHN6ajBTTkg1STZxdWFGRjJN?=
 =?utf-8?B?aVpJaWw1V2pQQTdkZEJTVjBZeXJWeDVVelVpa0htS1AwR1ZIbDFYakxnL1RL?=
 =?utf-8?B?YVMxOUM3S2t2aU5tQlc2cEpiVUtTeUV0RGVpc1htb2FqSWtTUUhjNGdkNkhs?=
 =?utf-8?B?U1FXVmxDd2s0RXFycEt6cXhaQnB0WHU5WGpvT3JocFc3Q2dSeEs2d2Z2YmVx?=
 =?utf-8?B?SFlVM1cvMUYyVEZNSFJVT2hjbk02ckthWGg1WmxCSU1LTSt4NDA2QkFOSjcr?=
 =?utf-8?B?Wks5Y1NDb3dyRjBCeXA2Umh6Z2dBZjFtT2NiTGorYVVzMmVieHJqZUdCU2hO?=
 =?utf-8?B?MS9yUDdROGdvNGlyVm9MUXJqNVhwMENLdWV3dDBkOFc4UDM2amxzZ05QTVp1?=
 =?utf-8?B?aldsMWxoNWQ5ZzRESWZlamE2RFlyUG5LWi9YVGc3SzlnL0NJVURjY1lPM29j?=
 =?utf-8?B?aEVkODJrWmRPWXM4RDNZN0hDd2xDaXl5UWx2aUhmUVAxNGdFNDJ1U1Y5eEpr?=
 =?utf-8?B?eGtweThTWmFveTFCVk9oWnR3SUxNT0pqMUtubDdiZ0dOWFZPN08rQ0dhMWFB?=
 =?utf-8?B?SnlMNmVMVW4yOUZyVGRHRmlVM0dZcHY0NlliRmNQUXJJSUlDWXA2L0xncXRk?=
 =?utf-8?B?OWg0V3ZGbHdCN25mN3kzT1F6Mko0WUJqVUFrYWxKaTJLNlA2b2I4Sm1PT0Rz?=
 =?utf-8?B?UlJ5S3crQkxURUZxWXFFUjRTODdKb2k2N2YzTy92R1NxQ2EzTVpuNW9MYnVO?=
 =?utf-8?B?N3V5cnM3OWpPV2V0VGg1OHFhYmxtV3B5VXFvQ1hyWHR5dWl4cUFsYlZySDRE?=
 =?utf-8?B?RkVZYUdMcTR2Y0NGMUFFZk02U0lramZVbUxtSlpHcm5MRnhROVlFd1ZhK001?=
 =?utf-8?B?Rm1rS0lqejB4ZDlabjRDWXZWV0FTODFyOWNhMHRmdXhRbUFNaW9RQk9DcC9B?=
 =?utf-8?B?OUV1U2FsZmRSVFBzQ0V6Z3VOS0ZDRStwb1UvanV4enBpSDYydFpCZHk1dGhB?=
 =?utf-8?B?QzVnWmtwZUdyU1pwRnZ3RXBiNFZqaXAveEFJWVJXZ1pPQmVwZnZaV3FubmNt?=
 =?utf-8?B?R2I5TkF4eVl0eWVSdlhQS3cvaFhRZG1qZ3AvWHhkT25WT1d6TDAvOU9seGFz?=
 =?utf-8?B?eW5LRmo2dTZjWGN6cURobjZTeEJYMkl0ckE4bEFQUDR5SDhCTTBBaGhoUUlS?=
 =?utf-8?B?dzlzNjlPVGUzQ3Mvb3BBdlo1VVJ2bUltSGNEWVdEb1M0V3BHNkRGZmtRcjg2?=
 =?utf-8?B?cnhvaHBjZFNPbTRZLytFTnYyNWZvUWcxQkhIQXIybkxxY1E1VHpUV3o1Z3Vr?=
 =?utf-8?B?VDdJWmZEd0IxSXBZMjUrd2xwc3g3dnFCbEJ1aWt3NzB0ZVFDUHVGWUh6cEZJ?=
 =?utf-8?B?Q0tyYURzMmIrbTBPNTJQcWdwUWhoa2tHM2JLQlJrTW9LTldlOWRFNXZyVzlH?=
 =?utf-8?B?TStJTGxFN0hYRHcwRXQwb2lFKzJLa3MwMW95NWVpcWVCMGU2SGZ1Uk5ScDlo?=
 =?utf-8?B?eU1UQTM0UEMwTktBRnNiLzRwSitWcmRET1ZsbjRyZWFMaWJTSnJHRlpsTksx?=
 =?utf-8?B?VENFZjhjOW1vZFlHbTNBNmhyRWZUTEFQbWpqQnI5MDNkdmxJcDF5K0lIdFlx?=
 =?utf-8?B?OVdEZ0tmNEhBQmpOeTJidGNpbGtObS9KTVZ3QTJQanFLeCtpZW8wTUlRbUs4?=
 =?utf-8?B?N0l3SmJPb3A1K2N3V25KcGowOE9wSnloZU9EVlREeGp6eWdLS0ZvTWNZUGRh?=
 =?utf-8?Q?Nx/m3T17pcx+XczKu0AE2DkkL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2628fe1-21b0-4759-df90-08db346526f4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 17:02:05.4928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCLKrnG7DJV5qohyS5dW3+0mj3vLJrHiqr1RZe/z6/Hifah3t0vF0OP1KwgooF022cRb+OMF02vqkPEd19MScQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5310
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 3/29/23 21:20, Yang Li wrote:
> drivers/edac/amd64_edac.c:1279 umc_determine_edac_cap() warn: inconsistent indenting
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4639
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---

Hi Yang,

Thanks for the patch.

It looks like this issue was introduced with the following commit.

f6a4b4a1aa16 ("EDAC/amd64: Split determine_edac_cap() into dct/umc functions")

Can you please include a Fixes tag and describe your changes in the commit message?

Thanks,
Yazen
