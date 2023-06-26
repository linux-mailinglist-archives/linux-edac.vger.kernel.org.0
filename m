Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755F273E264
	for <lists+linux-edac@lfdr.de>; Mon, 26 Jun 2023 16:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjFZOrh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Jun 2023 10:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjFZOrf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 26 Jun 2023 10:47:35 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D02B12E;
        Mon, 26 Jun 2023 07:47:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnnNXWFmAd5cG1BdeMmMTeszNelCnZjHZ5MRSBT0+nxgICjCifyfPqI/tKQVlJtVCMOBAwyJHLqEqwR4MyvTxxUAoyaz9saZNd8N9bzqHLNImCIoBycBk9LQbbtdw8A9iAqM7lKpqfe5gdJDbnc3HPuSGcFXLOn9gNBrM3RafSeEY4TlqgovYDXYgkMypVmjv6EZk2QDgeIgJgYU1yDHmb0A1/m0h5oGNKX2ommnYdCDk/bygC7kiDAR8RjWOKxTFU9KNu+TELnm5Ul1oVntVOdNohvUdnySDkmIZc0kSxrJ7Swa3dtrD15XjaoKpmiPxjABtgw73jFo4HlsJikrMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IScN+9QhzH3oSABLFtPLJzsnIUzxzhKRsxqRzvvVsrk=;
 b=eMRx11qoqUCIn/RGaI5HRjI2PVbmdR2VbrIVyrOi32Vj5oMbWEBklLV9PZcOJ6ih5E38W6McWAEFW/yXfwxYR6g8mWTWMNt1zWHWRcpeqgcMKJ3xJB2FUeOqJkIpg0y0LemVzmPYhhuV5Q0/SpnQhBlyjcB/5zBDvRFxSFCjdDt5Tilpj/5PFIxZx2N2nKIRPKH/sujqyB8ybkt6paXkoR6FDJ28AMi7IrJw3UIV7dT7V/9fcJ40ADhhmUyRNfKZ0HlBiuPzlLYZVlyY9FHnCJeKvP9CoH3PfQQ6KVFA/NVA0nkjQJF6vhrddxYxNdrnQ7bcqTddCa63zocwPpqqwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IScN+9QhzH3oSABLFtPLJzsnIUzxzhKRsxqRzvvVsrk=;
 b=t24UA0iNhodb1iJb7CITe5ao41AvJC+pr98aQ3NvVWJKBUGq28UEJzvRPQd+U+WdDzvOPhDMTfaXnbEov9yZs2KAWqR7TBtVCsDRcT72p+P25GK31N3hReDzS+KaaCXe5Henf/4YtzsHOzMl7VXkL5UQ0BY5qZ2PaRProhqf3sk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 14:47:25 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1816:6426:34dd:426]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1816:6426:34dd:426%7]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 14:47:25 +0000
Message-ID: <6719ae8f-6efa-82bf-a0ef-90b7c1334f41@amd.com>
Date:   Mon, 26 Jun 2023 10:47:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Cc:     yazen.ghannam@amd.com, "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 1/2] x86/mce: Disable preemption for CPER decoding
To:     Borislav Petkov <bp@alien8.de>
References: <20230622131841.3153672-2-yazen.ghannam@amd.com>
 <SJ1PR11MB6083664BCFC8047A5FE8F6A9FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <f03b6c61-1669-c03e-310c-cc1364cf30a8@amd.com>
 <SJ1PR11MB6083961DFCA3D90922824189FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <77d51e2f-cd1c-9c30-5bd5-42b1d583db53@amd.com>
 <SJ1PR11MB60831A6E82329E1C53257F3EFC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <e6b1af5a-774a-c3ef-223e-4595b7ec532a@amd.com>
 <SJ1PR11MB6083662CBA9A2F40512034D0FC23A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230623160138.GBZJXB4hlFM/ahvROH@fat_crate.local>
 <5f40b5f0-3e19-5cf3-5bd3-eafa4d036119@amd.com>
 <20230623164221.GCZJXLbSYQebMrVa4y@fat_crate.local>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230623164221.GCZJXLbSYQebMrVa4y@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0491.namprd03.prod.outlook.com
 (2603:10b6:408:130::16) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: d35bb349-5d2f-4a40-3ff9-08db76544161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MUoIg2yyemeE/PdJSsFYbr9tB2/M0LITYURLo6+G9dmbtjWAG/bJ9arHWHanttvWPjGKiSa7cJFeTctyop749nmT8gBBYE9lvPw++dIU1/rbrxOdvV6vU5vD/dAMdLlYZkzEFD0UYCCBmdqKcMLqlAZvx2yDq663SHFhPS11sZd2miPqe3loGMttDMCaw5kRzI8lF+NqdcINA4CahW9z3wsmizFmkxuKlWywqj0bU7isda26A9WEBGqFuA+LI+gUqY0DpWcleNPCp1eL6dkso54kYFT6tiJoY1qnFmHsC+WCsmEc5gNbBAb0iZQre9WaJBQ+2JnoVxbpdzl7pqSjmZcSSHlRXTdxhiwY75O7qbRhNajBixARl531X78fheGOMnAQ2vuK7N743ouqqYX9iTTARejuITaFgqJT2AEn4MH/Z+5TJC02Vxp3JelKdKLGURce1XcPgXO84Sj/vQl3GWA7o89H6bjeyfLPzQqKS1otJkr5x9IK+Mdg8Ds+7OWEb1BjqzH6japqGvGS+9P5qmAbrHM3x8pZcqisnoCZXRF/HECYAFTTfGDOO76OkpKXPkAPrQpHhdChirWQv71nY84UVScj+dtU+m3AFup340YfKROP01aJQ2zKdt1c6NZ7SUQvRcOMH0ChgrVl9dgT8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(53546011)(6666004)(2616005)(6486002)(54906003)(26005)(6512007)(6506007)(186003)(2906002)(4744005)(478600001)(5660300002)(44832011)(36756003)(38100700002)(31696002)(66946007)(4326008)(316002)(8936002)(8676002)(41300700001)(86362001)(6916009)(66556008)(66476007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXp6VldFWFhoYXZlbmVlQkJaWHplTVRvUGNRanpieFV5TlRYT1BQV1RvYWhu?=
 =?utf-8?B?K2c0dU5UcUJjRGNPOWE0R244MUdVNXVhNmhDZGZBajVsOWp5M2FFODlpaTBw?=
 =?utf-8?B?dzByT20rODdwdlRJc3l4TXRuTzJsTWZLTnpacnErMzgzS1FpRVlJendPSTBT?=
 =?utf-8?B?UVJ3enhXUjJCeVJ0TUx5b0RxcGVzZ0RXUFdRTjJEWUNSVE91NkE4Wkh1UEg2?=
 =?utf-8?B?QmE4VmloTXVqbTc5V25sN01pS3l3d2RrMXJZTkV3OFFBcXJnNDZHcm1LU08x?=
 =?utf-8?B?SVRlMndMRFQ4ejBEaHZzN0RIcHkxYzU5Wm5IVG9wQzFWdDkwWlVzak5LcHNB?=
 =?utf-8?B?ZzM5MzJhMVhYUHZKWWVlRytIdElKaHI4enludUtGbTR1WVdydS9HY2NnckVv?=
 =?utf-8?B?THpkLzBIQklqeXZsUGh6QThZZkFDOGphYXgwL3A4ckIrN2s3NXZDY29FMzlw?=
 =?utf-8?B?SWY4bFo3NCs3SW9ody9lR3NrRHlNYXE5bFhBMFZGUjhnWnFCVk1wVUl5QmFF?=
 =?utf-8?B?OXRjUERQbzV0VzlicDRTOFFxTTJhNks0Z1gzYW90ZGYzeVdNcm5vaDBPTWZB?=
 =?utf-8?B?N0tkVER3WmpmZy9jWXVVSFd5Wmp4azFBRWllaWRTUmp0Yy9OZVNIUXczakI5?=
 =?utf-8?B?dHJXUDNwQ3VrMTNRbzhsS2V3bC82RE11aElYdGZxRlhHb1huVm1STjBnbzRh?=
 =?utf-8?B?eCtxNkFXZjFWOGRXZFhCbnVXakhSdE9mVzF0UUpJdHp1T3VSMU5QT0xwSGFj?=
 =?utf-8?B?RExJMitVeWdhVmlRVWZHaW5PTFJXY1lZSVFlaXRzcTI1YzlPanEwek9VVWU5?=
 =?utf-8?B?R1ozTEgyb1g3cFM4L2xNOFBHdDhPKzlFUUtGUGhZWk1ubGE0L1pZQ1doUjFa?=
 =?utf-8?B?b0xCMUdlQWxmaUEyYWtja2FBaGJwQkVTeHIwejA3NmViaktHQWZ4L0R5b1JY?=
 =?utf-8?B?cTRLRlZwOGNUcCthTnVGbUJCSnhSb1lGWG0wSk9oUjNPcHNTMXdqbnlodWw2?=
 =?utf-8?B?TjdWSXhlV2M4NzRCb1I2bDVCbTVKenQvS2lZTlFMRUhiUWdkdFA0UmVKdGJO?=
 =?utf-8?B?UUhYNTUwTHRJeVViV0VKVk82RjRuRnViVjRZbUJnaXFlSHk4MWpBdk5FYWNQ?=
 =?utf-8?B?OER3UUtNdTRzZThBMGFkWnhxb2d5WE80cWdkQ1ZDc2dMNzgraWlvdVFZc3pl?=
 =?utf-8?B?cWQwTUJvL05valVmWkdsb2VPMjRzSVI1UVBUZWNhOUFuaGZUR2Y5eDVSTmpL?=
 =?utf-8?B?UDlUdmxtWlJZbkEwNkV3TlcyNEY3S3owR2VqcVd1eStPSk5USEZBb0NVc05i?=
 =?utf-8?B?SGhCbHBZTnBXTVFPd3J3NjRZbFZTUHVYZktSRTdMQUhlQnh3OGxESmwxNzVh?=
 =?utf-8?B?ZmNaMWh6R3Vib0EzSTI0Qys2OFgvUXdKMlArczR0cWRoVndWZ1hmVzlkbSs4?=
 =?utf-8?B?NUp2QnhhcktWV0dEK01SSVhDT2Mwb1p5TzZVTTBGU0tMWG9NdjRWWTdwTDhO?=
 =?utf-8?B?ckRYZFRLR0FPdWFucDhYc05sMUdkRGRIMENQMnJrTzJvVzRoTDE3dG94cVZO?=
 =?utf-8?B?MzE2OUdlLzJta1hlQ015YzlUdzlxanpzcGtscWZjMVBkYnUvcEZWNjhPSXpQ?=
 =?utf-8?B?bmhDdEQ4RzM0WXdjampGS3FmaGFTZGR1QkNGZ2RYWEI3a1VJVW40VHk1NEF4?=
 =?utf-8?B?R0wydnFTaDYvYXplUUN6Qjd3Q3o2R0pEOHlwM3ZkM283SVEzcDdtbHpZOUd5?=
 =?utf-8?B?OXR1T3dhVkdJOUhNbHphMTlsc1MzNTdITG95bEp5VEFQS0tJL1dwTmxiVFI3?=
 =?utf-8?B?TUFtMmcvVGpIb1FraDJoeEx3dG5tVjRDeTVHTkR4Zlo4ajdUVHJPaEcxWG5R?=
 =?utf-8?B?S3pmWUZVKzVWZVI1aFZZaCtWYWpUalQyc2dLYWhnell4VkJDZStyYVkvM0xJ?=
 =?utf-8?B?SkNKNDhPeEgzNnQrT3RFTmhhanRjVG9kVi9hVHVjSU9udy9RSEJwYk9weDhK?=
 =?utf-8?B?bTd6em02dURnci92aytHWEVSZ2tzOFR4dGNveG95TXRsd1FXK2kxcGtzVWhY?=
 =?utf-8?B?M3ZLQ0JCd0ptSk1ucmQ0Z251RUZHays1cEpJcU9tMU80VTA0cGdtczF5TzNz?=
 =?utf-8?Q?0IeeJ100AbtyyIyc+cxahkjKG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35bb349-5d2f-4a40-3ff9-08db76544161
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 14:47:25.1093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3nq79ivQBdt00pMb9A/zfA3kuWcQjsrsLN1sOQEepuLvad6fjwE4dF6iNEP36bQ+RCmn3ZpA9onU6FSh76lLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 6/23/2023 12:42 PM, Borislav Petkov wrote:
> On Fri, Jun 23, 2023 at 12:14:00PM -0400, Yazen Ghannam wrote:
>> Or do you mean that we can support mixed microcode systems?
> 
> We can and always have. I can chase down hw guys at some point and have
> them make a definitive statement about mixed silicon steppings but we
> have bigger fish to fry right now.
> 
> :-)
> 

No problem. I'll work on a solution that covers this case then.

Thanks,
Yazen
