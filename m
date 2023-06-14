Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16F27303A3
	for <lists+linux-edac@lfdr.de>; Wed, 14 Jun 2023 17:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343703AbjFNPVz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 14 Jun 2023 11:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343695AbjFNPVy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 14 Jun 2023 11:21:54 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ADFE2;
        Wed, 14 Jun 2023 08:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSfhT8s9m5U9SpISulCPcT0cMkj13JYBrUXAJXG9ycScx9uPcacwu6lEH/DO3RsxrjKT2AchO8o1GPw33mmfFcKeVs/OpbdWesgNo17kFR+G2yOEcE8QE1N/B1XehzkUjG6Yo35jSHqJDAPQzpkMi5kEtPXWkJH5ErOLYztRTWWXZabPbGVbhXN/9xgTb6cRCPqIxBLzDxRwZebpyqu0iEO236z0Vhqo1CsnD8ip1vFdBOoHF0utdZsnTR1Zp9u8WEG7PXq56ZYrfkkYzs9I62T/f1gdvWYKXM2fuu61oENK3de2YJHqLL4YzyMLG3ZbL0WqRcDjHscTQAlR4Yvhbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbECKhJeaHLsGvNLyyiJ3tiqMwr0LRmOmociksly+QE=;
 b=lFIk0dbuMfjZnjMMak2lhiQyVC0Pwa7PJR9nyB1ooo6934p2kJLJG8wpMDEy5dWtTYKeOvTnL7rgI8anOggSPikmpuCDq8b5GE5vDo0ZG/kJbhZVYHxZKlJLbuw64S522ccPR2Ria6hG4eDHwNXUFiS7Jlc+tST9jf9jGKz8JqvarULM/DvzHBtp2bmn7Fi2TpLM8ylczYsszxpdPRULZD/irI3umtfoSjoeZ4XxeEdAt3n5L8VRLtL6N17cX+QdW+0CHnrkHg8nggcycd+EN7BuKrj0wOYKdrprT5aXoXWvxfrK2hg62H8ktZONhnehYXKC5mk1vJ4h7ZcplUl56Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbECKhJeaHLsGvNLyyiJ3tiqMwr0LRmOmociksly+QE=;
 b=dMPEZZlmNH+LuOkABCAu1ra2K5DqQxpsiEyBlinx2Hau3bAYwWjfKE0ZE76IohmCPDEFqnXJspCMyt9Ft3K4L+4+Hnme8YXmaScfTCS2HaBuWdi2cbChxKY5hrHPDY9RN4pZZU4VPQr/A/yjOaMJitHgNeQFKi9BW8kSRzcQ/0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3109.namprd12.prod.outlook.com (2603:10b6:a03:db::17)
 by SA0PR12MB7477.namprd12.prod.outlook.com (2603:10b6:806:24b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 15:21:50 +0000
Received: from BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b9ac:300b:9e37:8438]) by BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b9ac:300b:9e37:8438%4]) with mapi id 15.20.6455.020; Wed, 14 Jun 2023
 15:21:50 +0000
Message-ID: <89a67e4d-cada-ff57-f702-d5579ea8b39c@amd.com>
Date:   Wed, 14 Jun 2023 11:21:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Cc:     yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd64: set variable gpu_node_map
 storage-class-specifier to static
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org
References: <20230610210930.174074-1-trix@redhat.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230610210930.174074-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0098.namprd04.prod.outlook.com
 (2603:10b6:408:ec::13) To BYAPR12MB3109.namprd12.prod.outlook.com
 (2603:10b6:a03:db::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:EE_|SA0PR12MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 64309065-ea92-4b62-2179-08db6ceb1354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5kpSuARM2UwjvLFsHzrJ8MOgQpH9Hr3y6UEWKdO75NZvqAfbPxrpbA2MvKDWZTJZSo4xH9PfufCdEy71aUo1wit31c0Lmuabt66D7nafmQ+TJTwwlGywfkvaWMP5tZSma0/z1vVAEMburG8p/pzCDa0Odw3iqu822KN0G+BYvUXECh7DvWr0NsnJDYOdSig4wYL/W3qDZmip/YeudFv2PCjxL+ZlOD3+AMAVkfj7WvcpqFDfdYWPhOwJTjpYih6dvsE1isBmmw/btLDTvkTUA9exeImQge0gb2bdk5V7wG2xC0XrLACYi+otMbaQDKNiESI1kVFaZ96f3DY9Xd6lMiabbx4Gp9fHxH8Ko0WA5ide8+K50LQa3m0E4SBPoyJ8DrRE6SqA/OJyuGhd07SWHMj7Wdh9Dw7MSJlMSm5W4PxztvNYibLR6em7Rkxggmw8sgnnvTYvTMG4IY92cqiAp+IWEC9UX8ICCPOu5ZN+ba9Ri54xXj67BID0h7gT3LT0b7Dm8xjY8TnNUoA0KiYY7vRycllcKVEYjZhjnZG6AfScmln0oFb94iT0NMAGbja2tYzNZCd1XX6TepSJIjHnUJjni8/WXqtC14cTbnm09b+VifER+k6Vf9CGgmwWc7EeJ2UXcK2oeK742F/nGZ6Tkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199021)(2616005)(83380400001)(86362001)(38100700002)(31696002)(36756003)(478600001)(44832011)(4326008)(6666004)(6486002)(8936002)(4744005)(2906002)(8676002)(5660300002)(66946007)(66476007)(66556008)(31686004)(41300700001)(316002)(53546011)(186003)(26005)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWtIVW5xM240Ry9oZENOZzhzc1hFK2dGSGVDZWV2WXQvUXZodC9UWURUazVJ?=
 =?utf-8?B?SGlaWEc2T25BK3FXOHR4RnpmUE5pdTZQNHdOeXI2anFaSkw3dUFpMVcxOHRE?=
 =?utf-8?B?allyeUxGRHVqUEx3VFpkQ0ZBSTNsb3UxaVlRbUpIV1I3a3FQQWVPaFJoVmFM?=
 =?utf-8?B?VlFDdkRuVTZNWk5ZbzVpeEdFSEtwQURKK1kzRHppUCtzbkRlN2F5VUMzVlJE?=
 =?utf-8?B?dHpGSkdXeHArRk1DTmd1Zm4vQzRxT21oOGVFbGJnbE13ZXJlTkszVzZZUXBI?=
 =?utf-8?B?V1QyL2x5Q0xMNWpQMjhEdmJDKzhvWHhBUURIN2VlRWtVM0pjSGxiVkVHb3Mv?=
 =?utf-8?B?QWlaVTc1R2lhSUZCcUxqSkFuTEFIQlI3eVhFMCtpOUJPSVlmcXhZbnZzQXBy?=
 =?utf-8?B?VkFZSXFTOUU2ZENFM2l3eWRhWk5Famttci9kV0xYWHFFRUxJS1hHOXdJcVRF?=
 =?utf-8?B?U21LNUNaa0RXNTV0YytRTlZlT3FVTHlybTFGMEx3YTZENHBLL1IyWmI3SlZW?=
 =?utf-8?B?YW1BT2ZFZW5TdXFxQ1IwcVZHRXJJcTl0YXQzRk9aSHE3VGxIbnQvajAraldW?=
 =?utf-8?B?NmtVRC95c1VDSVkrTUNROG9jVXpZSk5IUnM4c0d3TmFvWGRpM1RKbndrWnha?=
 =?utf-8?B?RTBrVHRidDlqV3pzS1grT1owWHlqS3R6c0tQSUtlUlBUbU1YWlErZlUwNWUx?=
 =?utf-8?B?QjJIOHZ2V1U4WnhONm9xRjRSaWk1djA4SGptc0lHdDh6R2NTUVdjaUMxcEdk?=
 =?utf-8?B?S3l3Nmh6SFlGMnE5TG04WFJpaDlacXpPa2NzK2xXLzlkQjhFZEYyWmI3d1Y0?=
 =?utf-8?B?anZybzVIMFUrYVJRTndyd1lOcjNwWGZzc1NMNVZYNG5kakZuOElJSmp2RklU?=
 =?utf-8?B?Q2E2WWtKaStEdFJKVEhJS1FBNHRTRW1wMjNsTGxURU4rV1E2bThJWHBrQ2Rk?=
 =?utf-8?B?bHZ2azlPRzl6Z1FwQzhaeFU2bXVFTzVCcU54RGM0djlLbjlXZWpsekR1eEdQ?=
 =?utf-8?B?cUUrVm9UMGphdHJoSkxoZk04U2lkaWlicUFudXg4MzVsTzRWL3pIWWdTZHdj?=
 =?utf-8?B?U3F2ZlR1MngxQW90Nno3TzJhZ2hUNm5NbkR5UTZLUGFad1hkaTVURFQwdGpO?=
 =?utf-8?B?MDdnV2IxNlZKQUVjd0ZmZG9qY2hSSlF2Y0FscjdnZWxTV3BqMmVXc2pnYTc2?=
 =?utf-8?B?cWJHZHF5cE1SWFdNQ2lreDQzSnNZdE9JVWUwK3R6RU92dHNuaHM1U0dsNDdt?=
 =?utf-8?B?Y3JvWVp4ZFZqZExUc2NycFRSa1VHNGNpNFUvd0lIcG5UaGZpTXJRaTlEV3Zv?=
 =?utf-8?B?QjVWQWdhWUhjcUpsMWc4U2JTL2U3Znl4aUFSWUc4VmVhdHRnS3BKM2l6bk9m?=
 =?utf-8?B?eXNjRjV6WUpUNGxHNTZyYUFMSHdwMnFIdnV6djJ0bEZHZk9iM0xnenhqdW4y?=
 =?utf-8?B?cFNiczZuQmprUXZvL1VRbmRyNGFtZysyMEpacHIwTEZPellrVkJIU3h3cU92?=
 =?utf-8?B?VDlhaUgzb3hXK1NrUVMyL1NQT1VmTFd6dVRzQUdKUytReG52ZVdCWHNZMytL?=
 =?utf-8?B?empTWXc2SmVuWFBZV2ZScjJUdStMTmNrZWowd3I1VGFvc1o2M0dzaDZXUm9P?=
 =?utf-8?B?WTNrZUlyTEU2SDlRRTFiV1FkMiswK25XdDkyRHV2OHd6Z0hkZUk2QWYrZ2hT?=
 =?utf-8?B?ODJ1N2FKTWErTks0Q09tbis4U2R2YzlVRmhORjVWRFJSVHJuOXFNMVRTSlpy?=
 =?utf-8?B?OG1JRUdIbjU2QjVNeUZqUEZ1eE5QMHJyaVpBeTVkcWRQT2wvbE9rTWpPMkRr?=
 =?utf-8?B?aEFXLzU3THp2TzlmZENoYW1MOHcrQjlMWDEwUEthRjNXTEtTUHVFa2R4bCtP?=
 =?utf-8?B?cG1FOXBRZVV6c1FRaWRMVlBWVzJEcnA5RnNNbWZjVzdSUjZTYkc5UGV0U0tz?=
 =?utf-8?B?SlBDTHkwWEFqYlpqSWhrWDIzMW5HaExtTmlxLzF5UW5mS0QvUkFLVFVXdjJs?=
 =?utf-8?B?d0lXbi9KdUd1anhXWmpIbnFlOHR0eE1wek1BMGNXVmhDQnlwQjMycndVNEtv?=
 =?utf-8?B?YjVlQktHTmIxMFpqWmdFa2xBNHFOS3JycnY5RVhpL054VEdkR2xNV1lQc2Vm?=
 =?utf-8?Q?DSwaKah/t9g52768HtFW955Mw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64309065-ea92-4b62-2179-08db6ceb1354
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 15:21:50.2692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTTr5fFg9h4z6s3qxxNUvGtBNrsMY1ksL4zj4bqLLjo6FEpdZbBm7cowovR8qPL8AaEVJONzpUPII9FDeSzFeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7477
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 6/10/2023 5:09 PM, Tom Rix wrote:
> smatch reports
> drivers/edac/amd64_edac.c:990:3: warning: symbol
>    'gpu_node_map' was not declared. Should it be static?
> 
> This variable is only used in its defining file, so it should be static.
> 

Hi Tom,

Please use "imperative mood" when describing the change.

"This variable is only used in its defining file, so add the 'static' 
keyword to it."

or

"Make gpu_node_map static, since it's only used in its defining file."

Also, would a Fixes tag be appropriate?

Otherwise, looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
