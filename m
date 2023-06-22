Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9136873A605
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jun 2023 18:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjFVQYV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Jun 2023 12:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjFVQYU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Jun 2023 12:24:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7C41BD8;
        Thu, 22 Jun 2023 09:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCuB6GRrN9xtkeF/OWIAI7tH/srvtUVwzMjCpjuZGeS+MF6ILOtKlCDAm7+D3SObhS+lccLABTY5OQYm/49i8hdd3bNaWkXi6VlrdXQRsaeuiMMxwuAFX6afrpG0FBVWT18VR0ZnZR6FtSKObRgIneXcgn9DLA1I9tkatvsrdsC3WcrMlA1nncjkSOTnbYRCq1kbmTgu6d0EaBP1VYQkpZU/Ijcok0QCwqMFhYgDGY/bxEgeA2OBNZBdghtRMDNU3VxYFDJYcanZC1ZVNAkrCnwQ5vUQe2wBSjLbZXmtsPFuIKlbRQBqohmbgKFYO9PXESqavDlq9FidV4ATZ3axfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yq+pvNB/DVtRR6N0Hjf5ybB6qK30r/oJwv5fina0d1E=;
 b=NOpeKLDqHfUrgFS5gJlGY67Tw/7H5MX4L5TDmrAHU3mozrLKfSTr5aXLMSoBi3ZuoPy4V2KlULHuhvEthWWwGQaexYz3uxEt5y5H/sY3DCLXUJP3ZCQqliIVfxHKkuqYtgvTS1X6JdnVsog2FIdnAmRGlNKwKPucNgwvSG7Qd7apcOmNN3D5ZgbNQDuYlp+e2LRIs6ELQ22SV29P5D/muZdJcSMe0H0sEkVPMU1/N3KWSZJi+lAwTwrl/hL81dOlQ2v4Vl12qingQc1UHBOEYQj1mFg1OJNUdV9kLBR5C1tancN9W8fNSo7sS5h4O1ICea8FMmTlkJwuFiA7y1kR9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yq+pvNB/DVtRR6N0Hjf5ybB6qK30r/oJwv5fina0d1E=;
 b=zY8YFQOBLXA57fhtqngUXrgxJkAxhaBsiqqQpTJ31pBSPjvfF8XDd3hLvhcYj+0A7PJnfPgzjY/umerY9DlHcq8OkmSi22d9lDGZtW0tvmuRmuC3tsoAQpEVbPsuOx/lcTyqvhgryZ0lv2ApsmAXZzbKrD822aE6Tz/IR6Akg6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by IA1PR12MB8496.namprd12.prod.outlook.com (2603:10b6:208:446::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 16:24:17 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1816:6426:34dd:426]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1816:6426:34dd:426%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 16:24:17 +0000
Message-ID: <f03b6c61-1669-c03e-310c-cc1364cf30a8@amd.com>
Date:   Thu, 22 Jun 2023 12:24:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Cc:     yazen.ghannam@amd.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 1/2] x86/mce: Disable preemption for CPER decoding
To:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <20230622131841.3153672-1-yazen.ghannam@amd.com>
 <20230622131841.3153672-2-yazen.ghannam@amd.com>
 <SJ1PR11MB6083664BCFC8047A5FE8F6A9FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <SJ1PR11MB6083664BCFC8047A5FE8F6A9FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR10CA0007.namprd10.prod.outlook.com
 (2603:10b6:408:143::25) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|IA1PR12MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f355338-6bcd-4ce2-7be4-08db733d1ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GjvsFyCXY7zcEIHzsYgyPuDBTc12yZkspMmnqdlZvyVQQNtr0E82OBMYVGIU9G56nsoR3v9qXJZdEOjCaILr4bzCC40GGX75v4QucSQj4WGcpOALwrHkRMYSKHQE+Yh7MWna0PImFs5Ez+Ok7EtCo14CJTMZyG2OE+1Pir5dxTfL8pJjAN6dSkAomAh1jKiV1IvJoI707TOZgBUWjaqw7k8CVrcu3Rs1OA/IxD6Ftw1pQxhbzDjBPsertL0dprrx6vfv/EDqu4LJDlGS9vtcM9eq8eDZFa86dOgqRsI5Rnuhj6r7IxPHpBYZ8ofYGZSoMTd8sfuwLSED1gC17jnxzqIG4dF5dZtqxhiAAmBwmcQ214YhlWUuPjf0Mfo35jQfmYOiESGQkn+rqf5GRUG0UninwrbJydc0vOcDUvEjc79GpIPGumuO0wXntuwCs2MJuAPJWHxqOwsmmieAS5iAcdvG6bbTvb0pITnQQZi7CIM52zHSka5Obo9tisyGlIFWbP2+ifHbe7kgRYhLbDrVPZh2H8RcllaSooVEujfMdGydZXRXFW2HDzFDnnC6tkATZHH/idk4ASew3ewXj70tmwJLhiWGGf7E5H1KUPaSxjQhBbkzDBFqSxZZwmoUXf1HLhBsObj1cZn5OwEIl6/h8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199021)(6512007)(44832011)(186003)(53546011)(5660300002)(6506007)(478600001)(26005)(31686004)(2906002)(38100700002)(8936002)(2616005)(6486002)(8676002)(41300700001)(66476007)(66556008)(110136005)(54906003)(66946007)(83380400001)(36756003)(316002)(86362001)(31696002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHJMRlFPWm14Z2NRc1c5OTVodERaNXNLNzZkSlhKb3hDTExQTVVGY0JpM00x?=
 =?utf-8?B?cFFrdHJoYjFpZTVWeHFQQW05bGpYcmJuS0VQc3VEclpmTEJEczB0amZ1U1JF?=
 =?utf-8?B?d1ZBbVBwZXdpV2JTUXh3V0JNSnlFdnlvRnAyeXVIY0ZMb0Zvd2N2d3FWVW8z?=
 =?utf-8?B?TzdWaHErQzZsT1FWM1VOQXVpdDdXMi9YVTIvemVCWHQ0MDlIN0VBeXB1UHJR?=
 =?utf-8?B?REpTWS92ZzdjaGg5NWJzVUV5d2R6SkJHaHhaZWVCZHFmdFdKY2RVQ1RZZFRV?=
 =?utf-8?B?bGIyREtqRk50RFRJNlJkQkF1N2V5bGt6eUdjUWtPbHlNVjdOcktxUVJjUk80?=
 =?utf-8?B?R0FER1E1VkFVREZLMGZDVldQQmkweGw0MXFTRGovZ09Pd3BCMk05Y0kzUXRj?=
 =?utf-8?B?L3pmTWV4YkREMTVsZDArS2RxWlFEaDQrR2c3TFJ6eWNKN0g1WWhFNEhLU2h1?=
 =?utf-8?B?UU93V0FncnNKQS9EVU5SYWlWVjZwM1lFVGhGK1M5YnFETXcwMGRsR2l1Yi9i?=
 =?utf-8?B?Y2VqYkc5cGhzbHJyYUxReEgranl1SG4vOUkyRlZJd3ppckFGdjZsT21MZUtn?=
 =?utf-8?B?VnRVWlV0aHVKeGpGS1JGcG9uNnpiQVRML2Zwb3NNUmNGRUkxelBEdGI4RSts?=
 =?utf-8?B?ZW41TTNBN2FLY2RnbjFYdDNqaWNwQUdTK2lUeXdZTnpMeGFFcXgwT1lxVVBD?=
 =?utf-8?B?T3BJVDZRZHo4LzdOMFV3YWpNYzFlL1UzcGdFMjNieWhqejlXTUxBOE53OVJt?=
 =?utf-8?B?NzMxQ0Zhby92Mmo4cXBuVjlncy9HbTlZeTJweW5UVFl5Vy9Qc2djTEpXSms4?=
 =?utf-8?B?TGQvbjF3a0ZaOFprV3EvNVJPdzRSLzlRUXd4ZDhpaVBMYlNwOUx3ZGlvVlVP?=
 =?utf-8?B?S0Zna3BIM3ZqdUJNTi9QNFE2UXJ2RHJDTkdEUGZvcEFYM0NRTkdjOVBTem5q?=
 =?utf-8?B?WXQ5YWF4ZHQ1Vit1a0VGK0JlaVpLTXZUNnZSSzlhaHErVml0bm1Pd2VCUC9h?=
 =?utf-8?B?TEU2SmVqTVRCZkx4dFBDOXFNNDBpRmM4em1uWjVxQit0Sis1eUZHQmxtcVlt?=
 =?utf-8?B?d2lUSkc4S3lTa0RZMVgrSURUWGczWUZCY05LNUtUaXl1OXpKU0J6NXVlVzMr?=
 =?utf-8?B?VmJpdmw1RitqWHJEWW1xYlptcEc4SDBveFBDMXBsalZPMXZUSlZidUZ3Q1Nw?=
 =?utf-8?B?dVpKSDFkaXNtejlPYWRwbkFyZDY1ZDF4V25hM1hGTDhldnViY1ZtQ1ZJQ2ln?=
 =?utf-8?B?RDFlSmc0NVN1VE5JY2V1S29ya0hlMnRPYWozRFhmNkVvNU14RkJQSEtyMlBq?=
 =?utf-8?B?Qm02OGQweDlJWGhjc2JEekZ6MnE0SnNuandHaFprWlc5UWxNQUh6dUROWktE?=
 =?utf-8?B?Wi95SVdEcTFiS21pTFVzRGJMYnRRQ2FDbXI0V0ZEZFZxWEpldjVpdDh2Vklm?=
 =?utf-8?B?eHk0eFplU0ZlbTlCdTJVY0hmckVEaS9rWXVmVE4rZUZNZzdLblVVL2NTZlNl?=
 =?utf-8?B?OEUybmp6TS9iaytWWE5sUk0yb2lvRGtGTmYzaW1hV3hBMTZDNUEwRjBONU9C?=
 =?utf-8?B?OW1kamJncys5MUlseXl6cEFTWmZEbFBnNjdrdXpKSkhvWXJNcSt1TmIvTC84?=
 =?utf-8?B?ZlFIYTkwZXM5U2dEU1NGNFlPdVFoMEdZbEtudnR1N0RLMUNOTEFBTTljb0NW?=
 =?utf-8?B?aFFLWERpVVpLUUdRcjhON2ZhbG1OZmdKNXRETW5iejVhMkd0TmZwYXlFRzUr?=
 =?utf-8?B?L203WVBpYW5RSFM5VldYMWVmS1I4KytETWo2RUZoN3RXaWdCWi9GQTZ0cWRR?=
 =?utf-8?B?RGFPMXJHTE5JbjR2VlErKzhkVFp3Y2NZSWIvT21lK2c3LzFSUm4zR2VSaEg1?=
 =?utf-8?B?MjJSWWRUUlFRa09FWjRFaEM3QjZkZit3OG1sd2Rka1liSWJSZ21LMGNraTBx?=
 =?utf-8?B?Ymo2YU5VOCtWaUhEemM4VlU2MFJnTS9WNUZncWF3ZDA0cEZnV0RVWWYwZ2Mr?=
 =?utf-8?B?NWJNR1hlN08wUzJmYmRycVVHM1c2K3o0WE5lRlpDS25UQXlzdUtMdis2d0c3?=
 =?utf-8?B?enVqb291bkxWYldpRkF4OHNHOEVrclVDcXoxK3FiQVVhR2JnKzNoL1h6QmEz?=
 =?utf-8?Q?PXmHV8cldDd1fs1KG1GcVpHM6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f355338-6bcd-4ce2-7be4-08db733d1ffb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 16:24:17.1063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rCxg1VjQqjrHprjre7tWoWqHtoXvFFJPeOKYgZKX+PCOYVmip05rUcWyGzEjFos80Qd5Iboukm2PtqLn4BZnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8496
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 6/22/2023 11:35 AM, Luck, Tony wrote:
>> All the above is done when the BERT is processed during late init. This
>> can be scheduled on any CPU, and it may be preemptible.
> 
>> 2) mce_setup() will pull info from the executing CPU, so some info in
>>    struct mce may be incorrect for the CPU with the error. For example,
>>    in a dual-socket system, an error logged in socket 1 CPU but
>>    processed by a socket 0 CPU will save the PPIN of the socket 0 CPU.
> 
>> Fix the first issue by locally disabling preemption before calling
>> mce_setup().
> 
> It doesn't really fix the issue, it just makes the warnings go away.
> 
> The BERT record was created because some error crashed the
> system. It's being parsed by a CPU that likely had nothing
> to do with the actual error that occurred in the previous incarnation
> of the OS.
>

Yes, these are true statements.

> If there is a CPER record in the BERT data that includes CPU
> information, that would be the right thing to use. Alternatively
> is there some invalid CPU value that could be loaded into the
> "struct mce"?
> 

This is the reason we search for the logical CPU number using the Local 
APIC ID provided in the CPER. And fill in relevant data using that CPU 
number.

Thanks,
Yazen

